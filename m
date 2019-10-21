Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC545DE86E
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 11:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfJUJrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 05:47:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbfJUJrg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 05:47:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0EB2B8D8;
        Mon, 21 Oct 2019 09:47:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH v3] tools/lib/traceevent, perf tools: Handle %pU format correctly
Date:   Mon, 21 Oct 2019 17:47:30 +0800
Message-Id: <20191021094730.57332-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For btrfs related events, there is a field for fsid, but perf never
parse it correctly.

 # perf trace -e btrfs:qgroup_meta_convert xfs_io -f -c "pwrite 0 4k" \
   /mnt/btrfs/file1
     0.000 xfs_io/77915 btrfs:qgroup_meta_reserve:(nil)U: refroot=5(FS_TREE) type=0x0 diff=2
                                                  ^^^^^^ Not a correct UUID
     ...

[CAUSE]
The pretty_print() function doesn't handle the %pU format correctly.
In fact it doesn't handle %pU as uuid at all.

[FIX]
Add a new function, print_uuid_arg(), to handle %pU correctly.

Now perf trace can at least print fsid correctly:
     0.000 xfs_io/79619 btrfs:qgroup_meta_reserve:23ad1511-dd83-47d4-a79c-e96625a15a6e refroot=5(FS_TREE) type=0x0 diff=2

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use more comment explaining the finetunings we skipped for %pU*
- Extra check for the field before reading the data
- Use more elegant way to output uuid string
v3:
- Use a even more elegant way to output uuid string
---
 tools/lib/traceevent/event-parse.c | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index d948475585ce..a71f4a86b6ca 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -18,6 +18,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <limits.h>
+#include <linux/uuid.h>
 #include <linux/time64.h>
 
 #include <netinet/in.h>
@@ -4508,6 +4509,40 @@ get_bprint_format(void *data, int size __maybe_unused,
 	return format;
 }
 
+static void print_uuid_arg(struct trace_seq *s, void *data, int size,
+			   struct tep_event *event, struct tep_print_arg *arg)
+{
+	unsigned char *buf;
+	int i;
+
+	if (arg->type != TEP_PRINT_FIELD) {
+		trace_seq_printf(s, "ARG TYPE NOT FIELID but %d", arg->type);
+		return;
+	}
+
+	if (!arg->field.field) {
+		arg->field.field = tep_find_any_field(event, arg->field.name);
+		if (!arg->field.field) {
+			do_warning("%s: field %s not found",
+				   __func__, arg->field.name);
+			return;
+		}
+	}
+	if (arg->field.field->size < 16) {
+		trace_seq_printf(s, "INVALID UUID: size have %u expect 16",
+				arg->field.field->size);
+		return;
+	}
+	buf = data + arg->field.field->offset;
+
+	for (i = 0; i < 8; i++) {
+		trace_seq_printf(s, "%02x", buf[2 * i]);
+		trace_seq_printf(s, "%02x", buf[2 * i + 1]);
+		if (1 <= i && i <= 4)
+			trace_seq_putc(s, '-');
+	}
+}
+
 static void print_mac_arg(struct trace_seq *s, int mac, void *data, int size,
 			  struct tep_event *event, struct tep_print_arg *arg)
 {
@@ -5074,6 +5109,22 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 						arg = arg->next;
 						break;
 					}
+				} else if (*ptr == 'U') {
+					/*
+					 * %pU has several finetunings variants
+					 * like %pUb and %pUL.
+					 * Here we ignore them, default to
+					 * byte-order no endian, lower case
+					 * letters.
+					 */
+					if (isalpha(ptr[1]))
+						ptr += 2;
+					else
+						ptr++;
+
+					print_uuid_arg(s, data, size, event, arg);
+					arg = arg->next;
+					break;
 				}
 
 				/* fall through */
-- 
2.23.0

