Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC704B38A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfFSID1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 04:03:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730418AbfFSID0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 04:03:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2BEAAF68;
        Wed, 19 Jun 2019 08:03:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     dm-devel@redhat.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] dm log writes: Introduce dump_type= message type to change dump_type on the fly
Date:   Wed, 19 Jun 2019 16:03:12 +0800
Message-Id: <20190619080312.11549-3-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190619080312.11549-1-wqu@suse.com>
References: <20190619080312.11549-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new message format is:
dump_type=<new dump type>

The parameter of dump_type= follows the same one of constructor.
This allows us to change dump_type on the fly, making the following use
case possible:
  # dmsetup create log --table 0 10485760 log-writes \
    /dev/tests/dest /dev/test/log dump_type=ALL
  # mkfs.btrfs -f /dev/mapper/log
  # dmsetup suspend log
  # dmsetup message log dm_dump_type=METADATA|FLUSH|FUA|DISCARD|MARK
  # mount /dev/mapper/log
  # <do some writes>
  # umount /dev/mapper/log

The log device will record the full mkfs bios (as user space write can't
generate bios with METADATA flag), then switch to only log METADATA FUA
FLUSH DISCARD writes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 drivers/md/dm-log-writes.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 9edf0bdcae39..80e872c7dcd3 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -980,7 +980,8 @@ static int log_writes_iterate_devices(struct dm_target *ti,
 
 /*
  * Messages supported:
- *   mark <mark data> - specify the marked data.
+ *   mark <mark data>	    - specify the marked data.
+ *   dump_type=<type flags> - change dump type on the fly, suspend recommended
  */
 static int log_writes_message(struct dm_target *ti, unsigned argc, char **argv,
 			      char *result, unsigned maxlen)
@@ -988,15 +989,35 @@ static int log_writes_message(struct dm_target *ti, unsigned argc, char **argv,
 	int r = -EINVAL;
 	struct log_writes_c *lc = ti->private;
 
-	if (argc != 2) {
-		DMWARN("Invalid log-writes message arguments, expect 2 arguments, got %d", argc);
+	if (argc < 1) {
+		DMWARN(
+"Invalid log-writes message arguments, expect at least one argument, got %d",
+			argc);
 		return r;
 	}
 
-	if (!strcasecmp(argv[0], "mark"))
+	if (!strcasecmp(argv[0], "mark")) {
+		if (argc != 2) {
+			DMWARN(
+"Invalid log-writes message arguments, expect 2 arguments for mark, got %d",
+				argc);
+			return r;
+		}
 		r = log_mark(lc, argv[1]);
-	else
+	} else if (!strncasecmp(argv[0], "dump_type=", strlen("dump_type="))) {
+		if (argc != 1) {
+			DMWARN(
+"Invalid log-writes message arguments, expect 1 argument for dump_type, got %d",
+				argc);
+			return r;
+		}
+		r = parse_dump_types(lc, argv[0] + strlen("dump_type="));
+		if (r < 0) {
+			ti->error = "Bad dump type";
+		}
+	} else {
 		DMWARN("Unrecognised log writes target message received: %s", argv[0]);
+	}
 
 	return r;
 }
-- 
2.22.0

