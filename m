Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7874DE28
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGJT00 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jul 2023 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGJT0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jul 2023 15:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22AFB
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jul 2023 12:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 105A160FE8
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jul 2023 19:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286D5C433C7;
        Mon, 10 Jul 2023 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689017182;
        bh=Cf3mPWw+OR3bidf90Xpep4b0JaEMZawb41ulGjKXsKM=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=AZkZRKL688jBwYk6s7wfOPsr7VhB5LGg72BU3bRwxERCl7F6f18MRvOAJ+/bonsjT
         mczXyuPRAyagOt6TfVVLLXrgc2QR/t7+RLno26iCA4JkIYAKeY3zbr8TQq/g4S9tv/
         erq9upBSPF6Qo2YNHVKxN8N8b3bPQwDA5NMTZNGB8V7PkyEUNS9/NoBx18Jr906RRn
         26qhTI1g4SJl/5GPL/PdjhLKSy89xHCJ6qAlgr24cmYllTw8czSOsdYRQDbq2OWuo7
         mnqQnmid2Aneh1AQ9c7O/ONx70bISkm/S3CfX/xLEdZdMWfZlqe1Zv3kVdr2M8/0oY
         D793LKLOi65Ng==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0EBE327C0054;
        Mon, 10 Jul 2023 15:26:21 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 10 Jul 2023 15:26:21 -0400
X-ME-Sender: <xms:XFusZGTcFBWon11bjmUfPXCnQcv7bxhX3-LvSZx8qfTMhb4c3nqf5Q>
    <xme:XFusZLzKCeQ8lASp8yqJ3tius8er-l_FQX1vVHDMa4s7rdeehGIlT1K8WKEs1eoOx
    b71EbfTMKg7faBTn_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:XFusZD2SAMl4sWYl6jI671q5Y9kbIvL-UkfdG8EwBz9d2XEve6g8NQ>
    <xmx:XFusZCB-wBOCDRCQ8X4t7Hh3Kh-rBqMu276tGTQK5oxtMW_UHsOYVQ>
    <xmx:XFusZPg3CpxzNeWBjhN5EmM3eHW7kyjPNzYgpXq7qUJR8Xw6zzoDww>
    <xmx:XVusZAWEnGXpe89WMuyy7Wb5iY4-bqf6T-kC5QKUGZhOZg3G1q5sFg>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 593281700090; Mon, 10 Jul 2023 15:26:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <786918b1-d93e-4039-9061-0e3e75e47a90@app.fastmail.com>
In-Reply-To: <47505d6f-a0a5-46ce-a3dc-78fda3256381@app.fastmail.com>
References: <20230705140117.795478-1-arnd@kernel.org>
 <20230710165506.GA30916@twin.jikos.cz>
 <47505d6f-a0a5-46ce-a3dc-78fda3256381@app.fastmail.com>
Date:   Mon, 10 Jul 2023 21:25:23 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>, "David Sterba" <dsterba@suse.cz>
Cc:     "Chris Mason" <clm@fb.com>, "Josef Bacik" <josef@toxicpanda.com>,
        "David Sterba" <dsterba@suse.com>,
        "Johannes Thumshirn" <johannes.thumshirn@wdc.com>,
        "Anand Jain" <anand.jain@oracle.com>,
        "Filipe Manana" <fdmanana@suse.com>, "Qu Wenruo" <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: avoid Wmaybe-uninitialized warnings
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 10, 2023, at 21:12, Arnd Bergmann wrote:
>
> building for arm32 (see below), I get maybe 20 failed builds, but
> for x86 this is lower, maybe 2. I had attempted to work around
> each one of the ones I saw, but ended up with a huge patch to
> cover all architectures and compilers in random versions.

FWIW, this is the last version of my workaround patch from January
before I gave up on trying to fix all the btrfs warnings on
uninitialized variables.

     Arnd

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index db79e6b0a693f..ab2e54930ee5f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5656,7 +5656,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
-	struct btrfs_key location;
+	struct btrfs_key location = {};
 	u8 di_type = 0;
 	int ret = 0;
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ba769a1eb87ab..79e0c3a14c7fd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1730,7 +1730,7 @@ static noinline int btrfs_ioctl_tree_search(struct inode *inode,
 					    void __user *argp)
 {
 	struct btrfs_ioctl_search_args __user *uargs = argp;
-	struct btrfs_ioctl_search_key sk;
+	struct btrfs_ioctl_search_key sk = {};
 	int ret;
 	size_t buf_size;
 
@@ -1760,7 +1760,7 @@ static noinline int btrfs_ioctl_tree_search_v2(struct inode *inode,
 					       void __user *argp)
 {
 	struct btrfs_ioctl_search_args_v2 __user *uarg = argp;
-	struct btrfs_ioctl_search_args_v2 args;
+	struct btrfs_ioctl_search_args_v2 args = {};
 	int ret;
 	size_t buf_size;
 	const size_t buf_limit = SZ_16M;
@@ -2971,7 +2971,7 @@ static void get_block_group_info(struct list_head *groups_list,
 static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 				   void __user *arg)
 {
-	struct btrfs_ioctl_space_args space_args;
+	struct btrfs_ioctl_space_args space_args = {};
 	struct btrfs_ioctl_space_info space;
 	struct btrfs_ioctl_space_info *dest;
 	struct btrfs_ioctl_space_info *dest_orig;
@@ -3132,7 +3132,7 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 static noinline long btrfs_ioctl_wait_sync(struct btrfs_fs_info *fs_info,
 					   void __user *argp)
 {
-	u64 transid;
+	u64 transid = 0;
 
 	if (argp) {
 		if (copy_from_user(&transid, argp, sizeof(transid)))
@@ -4106,7 +4106,7 @@ static int btrfs_ioctl_set_fslabel(struct file *file, void __user *arg)
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_super_block *super_block = fs_info->super_copy;
 	struct btrfs_trans_handle *trans;
-	char label[BTRFS_LABEL_SIZE];
+	char label[BTRFS_LABEL_SIZE] = {};
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -4248,7 +4248,7 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_super_block *super_block = fs_info->super_copy;
-	struct btrfs_ioctl_feature_flags flags[2];
+	struct btrfs_ioctl_feature_flags flags[2] = {};
 	struct btrfs_trans_handle *trans;
 	u64 newflags;
 	int ret;
@@ -4320,7 +4320,7 @@ static int _btrfs_ioctl_send(struct inode *inode, void __user *argp, bool compat
 
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
-		struct btrfs_ioctl_send_args_32 args32;
+		struct btrfs_ioctl_send_args_32 args32 = {};
 
 		ret = copy_from_user(&args32, argp, sizeof(args32));
 		if (ret)
@@ -4369,7 +4369,7 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
-		struct btrfs_ioctl_encoded_io_args_32 args32;
+		struct btrfs_ioctl_encoded_io_args_32 args32 = {};
 
 		copy_end = offsetofend(struct btrfs_ioctl_encoded_io_args_32,
 				       flags);
@@ -4433,7 +4433,7 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 
 static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool compat)
 {
-	struct btrfs_ioctl_encoded_io_args args;
+	struct btrfs_ioctl_encoded_io_args args = {};
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
@@ -4453,7 +4453,7 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
 
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
-		struct btrfs_ioctl_encoded_io_args_32 args32;
+		struct btrfs_ioctl_encoded_io_args_32 args32 = {};
 
 		if (copy_from_user(&args32, argp, sizeof(args32))) {
 			ret = -EFAULT;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f41da7ac360d8..e93583f3f928b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4362,6 +4362,10 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	}
 	node = blocks->blocks[level].rb_node;
 
+	if (!node) {
+		spin_unlock(&blocks->lock);
+		goto out;
+	}
 	while (node) {
 		block = rb_entry(node, struct btrfs_qgroup_swapped_block, node);
 		if (block->subvol_bytenr < subvol_eb->start) {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e5c963bb873db..af2e153543a5c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 	int left_ret;
 	int right_ret;
 	u64 left_gen;
-	u64 right_gen;
+	u64 right_gen = 0;
 	struct btrfs_inode_info info;
 
 	ret = get_inode_info(sctx->send_root, ino, &info);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index de96d26f81f64..43b200102d1e6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2618,7 +2618,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct block_device *bdev;
 	struct super_block *sb = fs_info->sb;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_fs_devices *seed_devices;
+	struct btrfs_fs_devices *seed_devices = NULL;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;
