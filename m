Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8857AA260
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjIUVPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjIUVOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 17:14:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7F112452
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:06:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D84E3338A7;
        Thu, 21 Sep 2023 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695298794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/IvyR5teJIDpXHPqwwG2InOXmelIIpG9En6DQgpMvUY=;
        b=kRXFK1xbl6JapWXWNJ738DCzg4NIj6Lhitne+Irhfh5PA0BAO1el94YBk3FDwsgxISs1bc
        d+gvaUZSMNv6YVN8HSTqmW4JgDF6gYKBvHRi0OML52Cm/4rSwok9YB9r3e3Zi1v2MPzIFv
        DY1KzdoomkEcAkxfvDTNV0ViObhAgGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695298794;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/IvyR5teJIDpXHPqwwG2InOXmelIIpG9En6DQgpMvUY=;
        b=G7yGpz7tgBx/LW+qI0maxV+Ttv5yaGl8ym2TV0OFP+fZDH2NMCsieuNqLQ4kvTa1R8V5fa
        H2kkgffGZSgXCVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBF0613513;
        Thu, 21 Sep 2023 12:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YHk+Leo0DGU+FQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 21 Sep 2023 12:19:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 34DF3A077D; Thu, 21 Sep 2023 14:19:54 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH RESEND] btrfs: use the super_block as holder when mounting file systems
Date:   Thu, 21 Sep 2023 14:19:45 +0200
Message-Id: <20230921121945.4701-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2374; i=jack@suse.cz; h=from:subject; bh=tDDmoV+ckhbcmWWGyi5En+lo2KqOpx0jSYdkvjOmBzQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlDDTRBA/jF5vBYnT+vIt48rvHJkjgD9KVFYFTzEor Mu2Yjy2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZQw00QAKCRCcnaoHP2RA2dHvB/ 4tXbH6vmX+GoC/4FEA181hfoZlRfONcPdCn6t+bU1B4XVwJrgy0pleQdNUeGx1F9nwlX01TqvO84pl gg2mHlWJezvst026DeBUCc+BQd4zCvQaRwMtI8iv1kKOY48QQf+3mzR6YYAtK4yPlNMwACma1xNtXQ Btzy8l3MfZJMyJv2JRIy6RC9PgYaoJIiOTanRVwmB8d92kRhcLGnm4dqWFMiBFhIlO5lUqIE8Q6BBX joQjnDe4HySR2bUF4ZJLNm6hLfiVes4CzemU9t0X/hK9M2quAmTNs2qYr3SOn0JHMWiJwXLV0ocA+l HRu7S3n1BErWgLqLYwUTEeaS0C1Rm9
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

The file system type is not a very useful holder as it doesn't allow us
to go back to the actual file system instance.  Pass the super_block
instead which is useful when passed back to the file system driver.

This matches what is done for all other block device based file systems and it
also fixes an issue that block device freezing (as used e.g. by LVM when
performing device snapshots) starts working for btrfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Message-Id: <20230811100828.1897174-7-hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/btrfs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Hello,

I'm resending this btrfs fix. Can you please merge it David? It's the only bit
remaining from the original Christoph's block device opening patches and is
blocking me in pushing out the opening of block devices using bdev_handle.
Thanks!

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4577cd64da2e..94ca2236e57f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -70,8 +70,6 @@ static const struct super_operations btrfs_super_ops;
  * requested by subvol=/path. That way the callchain is straightforward and we
  * don't have to play tricks with the mount options and recursive calls to
  * btrfs_mount.
- *
- * The new btrfs_root_fs_type also servers as a tag for the bdev_holder.
  */
 static struct file_system_type btrfs_fs_type;
 static struct file_system_type btrfs_root_fs_type;
@@ -1462,8 +1460,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
 		mutex_lock(&uuid_mutex);
-		error = btrfs_open_devices(fs_devices, sb_open_mode(flags),
-					   fs_type);
+		error = btrfs_open_devices(fs_devices, sb_open_mode(flags), s);
 		mutex_unlock(&uuid_mutex);
 		if (error)
 			goto error_deactivate;
@@ -1477,7 +1474,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 			 fs_devices->latest_dev->bdev);
 		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
 					s->s_id);
-		btrfs_sb(s)->bdev_holder = fs_type;
+		btrfs_sb(s)->bdev_holder = s;
 		error = btrfs_fill_super(s, fs_devices, data);
 	}
 	if (!error)
-- 
2.35.3

