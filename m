Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623144B2786
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiBKOJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 09:09:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiBKOJY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 09:09:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC6C43
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 06:09:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9AD421F3AA
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644588561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=kTwuofy03J7i1xxodw+t4+mBDLZFokrVFGQcsfHQR1M=;
        b=GmlzMK2BEEXdz6td4KzVkzWyS6qsYoBDQqhoTq4ywcEQdAXUUo87o5vOxq8ff9c8RBvYua
        kL80I1BNrl1fAxqs61JX/P24P8Q5Pig3L5euI9/SxxLQarCr2qyvw5OrMFyLHwuxY6klde
        QYB29bOvHQTJHO6dNFqyKcz/2v/qRyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644588561;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=kTwuofy03J7i1xxodw+t4+mBDLZFokrVFGQcsfHQR1M=;
        b=SiIgbSgV93IyievgBQr1INxDzmEwIOPlIDvZ61bqHbmYN61466EoWARNJApM9g23NF34eP
        rOmHxkdyV3mcDrCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1303B13C7E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 14:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t4UrMRBuBmJ/JQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 14:09:20 +0000
Date:   Fri, 11 Feb 2022 08:09:18 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: Fix subvol turns RO if root is remounted RO
Message-ID: <20220211140918.c6wpmh3pgzjuytve@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a read-write root mount is remounted as read-only, the subvolume
is also set to read-only.

Use a rw_mounts counter to check the number of read-write mounts, and change
superblock to read-only only in case there are no read-write subvol mounts.
Disable SB_RDONLY in flags passed so superblock does not change
read-only.


Test case:
DEV=/dev/vdb
mkfs.btrfs -f $DEV
mount $DEV /mnt
btrfs subvol create /mnt/sv
mount -o remount,ro /mnt
mount -o subvol=/sv $DEV /mnt/sv
findmnt # /mnt is RO, /mnt/sv RW
mount -o remount,ro /mnt
findmnt # /mnt is RO, /mnt/sv RO as well
umount /mnt{/sv,}


Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a2991971c6b5..2bb6869f15af 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1060,6 +1060,9 @@ struct btrfs_fs_info {
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
 
+	/* Count of subvol mounts read-write */
+	int rw_mounts;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 33cfc9e27451..2072759d5f22 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1835,6 +1835,11 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
 	/* mount_subvol() will free subvol_name and mnt_root */
 	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
 
+	if (!IS_ERR(root) && !(flags & SB_RDONLY)) {
+		struct btrfs_fs_info *fs_info = btrfs_sb(mnt_root->mnt_sb);
+		fs_info->rw_mounts++;
+	}
+
 out:
 	return root;
 }
@@ -1958,6 +1963,11 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		goto out;
 
 	if (*flags & SB_RDONLY) {
+
+		if (--fs_info->rw_mounts > 0) {
+			*flags &= ~SB_RDONLY;
+			goto out;
+		}
 		/*
 		 * this also happens on 'umount -rf' or on shutdown, when
 		 * the filesystem is busy.
@@ -2057,6 +2067,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		if (ret)
 			goto restore;
 
+		fs_info->rw_mounts++;
+
 		btrfs_clear_sb_rdonly(sb);
 
 		set_bit(BTRFS_FS_OPEN, &fs_info->flags);

-- 
Goldwyn
