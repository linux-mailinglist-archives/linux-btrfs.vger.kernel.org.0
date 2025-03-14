Return-Path: <linux-btrfs+bounces-12280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308CA60E62
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 11:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111B617EC05
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CB71F4178;
	Fri, 14 Mar 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtP+rdUB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770B1F153C
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947086; cv=none; b=FgPEA05RUcr5iiXd6DICjop3RB5KRELLJBfganHKmUnereYxAbQDtYeIjvU4t/IjzuMX2Ox1wmWba+Wuzj6rxflpwdGPBinqemk8O29LEc6j3+5b8UJaXDrGkIn1sBsqf8b8wjg54EIBCRVeVv7+BZtczT9dKVLk5bPPEJAK6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947086; c=relaxed/simple;
	bh=suGdQPy5QLIQ4vhB5PXHyue88p+JC9ZMB03duic7Nu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HJJZkRk7eXTuKfqalz5g7kOS7ivdHXnzw8owrV4OX5GSA1vkfyYg3czbTnevOJ4EFnzo9diPVj2YN84TKvnLMHh8wPZhXpoWeEUBj3gJIMnGWg4NIFZRrS1YDbCjlMoDE3en/Y+pVXGzDrRkzivIgFs4x1Y8+pEoZNPXXV7gHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qtP+rdUB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1097617f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947083; x=1742551883; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72XOoU+a+zvQwQenWEJ9eKHjOKCMg7gntKJ82ZCC5Ok=;
        b=qtP+rdUBk5kAkyK7MKhtLxE55ZZkD98nJfAX9/PG6evvCVVOMsp9uYvhTFJxYjxad9
         RWQnN7EiamoG7GY48FGHZ1aHDkt/2MIUUANHNislAAsUNFAWgH6sESC7WD4pHSeJ0bK1
         YCImYrqDC1Pu1mDORRkTl/VaVmuAHPjK8wkByWc5DKuGmJmJMGkaMCBCH53jr+eVGMoX
         Q/qluCVP3CbvUmvzrzeOKdu9P0a4/ixwnfqZiSTPnOFsFh89VmnVZr6ay1NCq4gETq75
         bjW2BgC4oJcFsWDnJmLh7ih7XZccoPMsCpwhsjFaOjThEowq+nI/+DyR3N7Gu2y6Htee
         HtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947083; x=1742551883;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72XOoU+a+zvQwQenWEJ9eKHjOKCMg7gntKJ82ZCC5Ok=;
        b=KTUaPrSV5P4kv/UK4hc+7S6td7NASgN8u/+ao+as06AZ/h7QtEX2wiPtojE59VFUja
         iHYGyEpcubYEtIjzQcbUFew0gddUoH4Nz1z8on2ZqPsYUe1bygGcuFwU8jVtPfP62Kd/
         /r691HJ+DYYPwvBTTuOitRVzOi1I4L/kj4miHKYshQWZ6kRJ3WS3Ao59jYcESF7TuRqz
         I6a4sMcR4uGP6wEvudfa9jecHgjaR+gEwbT1wbWsBgm9X02SuuA14kAuSmBhPiprCrwz
         TFUbQqUiJFwGkt2odkRw5J988avuK5kuZLpAUo+nNtCwNUY28IcOI4NA0p9a+xhF4egt
         KGPQ==
X-Gm-Message-State: AOJu0Yzc5xCTtubNXQvd26I1y4ovCjoXUWECzWbepwupZX7RWfyOU/xO
	7g3TvVdessbyA+s9kyttPG+1qnMV0++DDPrjHIwG+7FN13spVfDJplakNZBIBO5yykuJgpBvAt2
	m
X-Gm-Gg: ASbGncus9rqMrd2Awdh8zFbKyEkErAKBlitkNhVvJ+Wp1qnZEQYxzSOed4nQbivru9O
	4IQmL/Td3+BfVrMW2VfOArsFqMj7uRU0+L3BcRe3DtZbX4woywJS88mA9jdt/Cy+2Pn6Fs1/ICp
	7UXXhE9U0Y6ucfd7gFkXVduVGC0YVRJG4SP/oRVuGtB7aqPZJG4v3xUf0F3ErYwkEc4q2GbaFtS
	NxAAM8Pj0fbZ+mfnXQy/twWNrdcUT6Ykd6KYrCmbBgEHvh4uEWwTKWI/XsfyflxMbDb7Q333Xe7
	PMyFpy+evte/JlUH5+vSOk7xT7Vd/HfhCZL+bVHXRCQrQUvbKA==
X-Google-Smtp-Source: AGHT+IHtRpzV13EVRb1tr4XQrT5CtvKwHos3ajSsjBBD6MQ0AAAS/CIHFXlHSTNROSTyjPY22W7LSg==
X-Received: by 2002:a5d:5f47:0:b0:391:2e0f:efec with SMTP id ffacd0b85a97d-3971ddd6136mr2407398f8f.7.1741947082696;
        Fri, 14 Mar 2025 03:11:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe60d37sm12512795e9.27.2025.03.14.03.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:11:22 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:11:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: make btrfs_iget() return a btrfs inode instead
Message-ID: <dac006d7-406b-4985-9a08-0d0a7a744e0d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Filipe Manana,

Commit 991961deef25 ("btrfs: make btrfs_iget() return a btrfs inode
instead") from Mar 7, 2025 (linux-next), leads to the following
Smatch static checker warning:

	fs/btrfs/export.c:222 btrfs_get_parent()
	error: double free of 'path' (line 217)

fs/btrfs/export.c
    146 struct dentry *btrfs_get_parent(struct dentry *child)
    147 {
    148         struct btrfs_inode *dir = BTRFS_I(d_inode(child));
    149         struct btrfs_inode *inode;
    150         struct btrfs_root *root = dir->root;
    151         struct btrfs_fs_info *fs_info = root->fs_info;
    152         struct btrfs_path *path;
    153         struct extent_buffer *leaf;
    154         struct btrfs_root_ref *ref;
    155         struct btrfs_key key;
    156         struct btrfs_key found_key;
    157         int ret;
    158 
    159         path = btrfs_alloc_path();
    160         if (!path)
    161                 return ERR_PTR(-ENOMEM);
    162 
    163         if (btrfs_ino(dir) == BTRFS_FIRST_FREE_OBJECTID) {
    164                 key.objectid = btrfs_root_id(root);
    165                 key.type = BTRFS_ROOT_BACKREF_KEY;
    166                 key.offset = (u64)-1;
    167                 root = fs_info->tree_root;
    168         } else {
    169                 key.objectid = btrfs_ino(dir);
    170                 key.type = BTRFS_INODE_REF_KEY;
    171                 key.offset = (u64)-1;
    172         }
    173 
    174         ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
    175         if (ret < 0)
    176                 goto fail;
    177         if (ret == 0) {
    178                 /*
    179                  * Key with offset of -1 found, there would have to exist an
    180                  * inode with such number or a root with such id.
    181                  */
    182                 ret = -EUCLEAN;
    183                 goto fail;
    184         }
    185 
    186         if (path->slots[0] == 0) {
    187                 ret = -ENOENT;
    188                 goto fail;
    189         }
    190 
    191         path->slots[0]--;
    192         leaf = path->nodes[0];
    193 
    194         btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
    195         if (found_key.objectid != key.objectid || found_key.type != key.type) {
    196                 ret = -ENOENT;
    197                 goto fail;
    198         }
    199 
    200         if (found_key.type == BTRFS_ROOT_BACKREF_KEY) {
    201                 ref = btrfs_item_ptr(leaf, path->slots[0],
    202                                      struct btrfs_root_ref);
    203                 key.objectid = btrfs_root_ref_dirid(leaf, ref);
    204         } else {
    205                 key.objectid = found_key.offset;
    206         }
    207         btrfs_free_path(path);
                                ^^^^

    208 
    209         if (found_key.type == BTRFS_ROOT_BACKREF_KEY) {
    210                 return btrfs_get_dentry(fs_info->sb, key.objectid,
    211                                         found_key.offset, 0);
    212         }
    213 
    214         inode = btrfs_iget(key.objectid, root);
    215         if (IS_ERR(inode)) {
    216                 ret = PTR_ERR(inode);
    217                 goto fail;
                        ^^^^^^^^^

    218         }
    219 
    220         return d_obtain_alias(&inode->vfs_inode);
    221 fail:
--> 222         btrfs_free_path(path);
                                ^^^^

    223         return ERR_PTR(ret);
    224 }

regards,
dan carpenter

