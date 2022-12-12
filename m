Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D546497F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 03:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiLLCUa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Dec 2022 21:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiLLCUJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Dec 2022 21:20:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16047F62
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 18:19:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93E03337DC
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 02:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670811595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=L+n/Htnm3B538Sg5li7W3QYjjZl4g0okBHqN5o330t4=;
        b=JJCv+UuQThaZJKUxh6fO/oy7BfLZ5kQv1RXljIdTnG7iE3tQLJhBG7IaXRP8EMTM3FLrlZ
        gsyRctI+2MDvSA5d8uB8P3ilTGHKU5wfOL6NEujvwsB0nj6gJ6HaD8r7ftOkdAgbqFfKBW
        XzmFMzEjAo6InZqhpcINPDGwxMSA+NI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5FB3133F5
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 02:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nwReK8qPlmNmDQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 02:19:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add extra error messages to cover non-ENOMEM errors from device_add_list()
Date:   Mon, 12 Dec 2022 10:19:37 +0800
Message-Id: <fc50bf81b7f93780d19c7eb5bcf1dcabacf00dc6.1670811571.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When test case btrfs/219 (aka, mount a registered device but with a lower
generation) failed, there is not any useful information for the end user
to find out what's going wrong.

The mount failure just looks like this:

  #  mount -o loop /tmp/219.img2 /mnt/btrfs/
  mount: /mnt/btrfs: mount(2) system call failed: File exists.
         dmesg(1) may have more information after failed mount system call.

While the dmesg contains nothing but the loop device change:

  loop1: detected capacity change from 0 to 524288

[CAUSE]
In device_list_add() we have a lot of extra checks to reject invalid
cases.

That function also contains the regular device scan result like the
following prompt:

  BTRFS: device fsid 6222333e-f9f1-47e6-b306-55ddd4dcaef4 devid 1 transid 8 /dev/loop0 scanned by systemd-udevd (3027)

But unfortunately not all errors have their own error messages, thus if
we hit something wrong in device_add_list(), there may be no error
messages at all.

[FIX]
Add errors message for all non-ENOMEM errors.

For ENOMEM, I'd say we're in a much worse situation, and there should be
some OOM messages way before our call sites.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8edd4069b2df..4633421ab594 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -768,8 +768,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
 
 	error = lookup_bdev(path, &path_devt);
-	if (error)
+	if (error) {
+		btrfs_err(NULL, "failed to lookup block device for path %s",
+			  path);
 		return ERR_PTR(error);
+	}
 
 	if (fsid_change_in_progress) {
 		if (!has_metadata_uuid)
@@ -836,6 +839,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		unsigned int nofs_flag;
 
 		if (fs_devices->opened) {
+			btrfs_err(NULL,
+		"device %s belongs to fsid %pU, and the fs is already mounted",
+				  path, fs_devices->fsid);
 			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-EBUSY);
 		}
@@ -905,6 +911,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			 * generation are equal.
 			 */
 			mutex_unlock(&fs_devices->device_list_mutex);
+			btrfs_err(NULL,
+"device %s already registered with a higher generation, found %llu expect %llu",
+				  path, found_transid, device->generation);
 			return ERR_PTR(-EEXIST);
 		}
 
-- 
2.38.1

