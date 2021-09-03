Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531B23FFE62
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348035AbhICKvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 06:51:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34144 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbhICKvt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 06:51:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CA1022465;
        Fri,  3 Sep 2021 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630666249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HiaRjO1wdPqkUs+0qLuWgeYVhD9pLNGKrm22kbv/N6k=;
        b=ARa94s/39Brk7LAPheSEk+T8mwCvrwLWh0eDaJEHLmVPMzEfDNdmcihJPog0uRq5K1PVMv
        kjd/Zxa54PfkKBpOhfEZGpnfxi7uSwb6g7nY7hcJknsoyBupUVqKRix01M7vsgNIY03kJy
        gsNbUdpbbf/11Aimrgv5gOLsh6vtsWc=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E6AFB1376B;
        Fri,  3 Sep 2021 10:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id AXa6NQj+MWHMEwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 03 Sep 2021 10:50:48 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: add new filter for missing devices
Date:   Fri,  3 Sep 2021 13:50:47 +0300
Message-Id: <20210903105047.1118101-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are pending changes to btrfs progs which make the output of
'btrfs fi show' more useful w.r.t to misisng devices. I.e instead of
printing a single '*** Some devices missing'  at the end it now produces
one line per missing device:

Total devices 2 FS bytes used 128.00KiB
	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
	devid    2 size 0 used 0 path /dev/loop1 ***MISSING***

This obviously will break all existing tests so in anticipation for this
change landing the filter is being added.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/filter.btrfs | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index d4169cc69112..37b92478c939 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -13,6 +13,22 @@ _filter_devid()
 	sed -e "s/\(devid\)\s\+[0-9]\+/\1 <DEVID>/g"
 }
 
+
+# Filter btrfs fi show output to match the old format, before the more verbose
+# missing device lines were add
+_filter_btrfs_missing_line()
+{
+	awk '
+	BEGIN {should_print=0}
+# skip empty lines as btrfs progs inserts such
+	/^$/ {next}
+	!/.*\*\*\*MISSING\*\*\*/ {print $0}
+	/.*\*\*\*MISSING\*\*\*/ {should_print=1}
+# The final \n adds an extra empty line to match with the original output
+	END {if (should_print) {print "\t*** Some devices missing"} print "\n"}
+	'
+}
+
 # If passed a number as first arg, filter that number of devices
 # If passed a UUID as second arg, filter that exact UUID
 _filter_btrfs_filesystem_show()
@@ -31,9 +47,9 @@ _filter_btrfs_filesystem_show()
 	fi
 
 	# the uniq collapses all device lines into 1
-	_filter_uuid $UUID | _filter_scratch | _filter_scratch_pool | \
-	_filter_size | _filter_btrfs_version | _filter_devid | \
-	_filter_zero_size | \
+	_filter_btrfs_missing_line | _filter_uuid $UUID | _filter_scratch | \
+	_filter_scratch_pool | _filter_size | _filter_btrfs_version | \
+	_filter_devid | _filter_zero_size | \
 	sed -e "s/\(Total devices\) $NUMDEVS/\1 $NUM_SUBST/g" | \
 	uniq
 }
-- 
2.17.1

