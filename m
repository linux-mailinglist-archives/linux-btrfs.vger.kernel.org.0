Return-Path: <linux-btrfs+bounces-16692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599DB47AF2
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Sep 2025 13:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2757B17E14E
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Sep 2025 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EEB261B60;
	Sun,  7 Sep 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVk2BKv+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07F25FA3B
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Sep 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244327; cv=none; b=IUqdnXgt2diiBlZ1+MlF0ac9dAxCOfkDBLIyRpkHtfsKxOjOy1SXLrrvfxV/Z5NVrbbiDYoBK62AXmzOVYNVLBqcLFwiG6Co7A7P+xORka3OLb6/aqnZoeVbwXZjapc1yDByl81T/ZY0eJ0tByGDL1imSanBerumGOTGjG/94Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244327; c=relaxed/simple;
	bh=fRy/1QBXVJl34spbLCzK3r5SskGfBF0ojBe6pJKK/oo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NL2CaZ+hjv9Vs1GIWhe+0iLDn4ywYloKk71br1wLNr8GQsuKyI2u0s2vjqRLBeZBymbGgmCuWa5Uv+q/U7DSUCfMeCBWo8GrpsOZtN8GxgQYEHJMKjyl7TFVrsheTUUYQB0rlphKyUfvBLPFgyb3cyc/HFOr0fyh6urRLeMvYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xVk2BKv+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45cb659e858so24241075e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Sep 2025 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757244323; x=1757849123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSPKDjoB+/14LTyGjnG7vKOzHvRtv5uQ+TOYEsbAAgg=;
        b=xVk2BKv+pEynMih6uoKilULTuHe6VzwE2yL9U26N0Z5PK9bnQEy3j080jDxZpuJa1j
         cVA44OeFAbd7q1ZWcqHruTHDYLoMnKfSzlywJP++f25Zf+OLA8fyT8JtFV9VTrp0/1f7
         Dbg7fBtkU1b+uNOaTcv1ev5o9vwE30dEhdiNmWPqyF5temGOXBEskK0pya7VVqlTsKal
         uDkbhHgaxJSiTPSz0+ElhOK74Moa7GVhxUn5LwG5lTqdO6ckywoTs10Xjufs7uK4J5In
         Hw1ekAUYOJY7FpGw/oGpXzXh6nB9LnCwEl/4uF13Mda79+wiHjudUTa2rHL+5G80mk3E
         aCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757244323; x=1757849123;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSPKDjoB+/14LTyGjnG7vKOzHvRtv5uQ+TOYEsbAAgg=;
        b=FyjAuXE8u3jUBNWm7Gx/jrjO1FfP53zrM1YeQA4OOAJKfVQSp9aX42/CmtzAWZApml
         93EfGW9HGXmbv6ZQ9290DQ3c8XKCoh3CoXWLOgZgFEKpFNBC8pLL54C4fZseAB9ZdtfS
         uV7sjuSYDJGzzFVbosCij2qGwuW2QYD5kz7kFjbgNszUkMB8sacSb9Syztams4UAQStE
         Jx7VmhANHMr0d9ZIH6SbM6Udi57Gi3anoeFHxNuSmWFytIcsGlZ02VUz7zMBZwZJmby1
         cgJ81A5SqokevM4DQk5/yLKn5iMkeAkXMYHlkJAtLU5Bwsv+h4J9/FMf9ZALts34NVwp
         8FiA==
X-Forwarded-Encrypted: i=1; AJvYcCVow+TMAZ1xDaw9sjlphHdGbw73hLrQA0tZAu8PBYYR1Mff4jAe/Wrhu+z/4rQQU1DiyR/Khl5Y9Jhh2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBtpFBsGCO85gMyRWH6z/Cg2zb6SXFU+gQOaHq4cKCBzL9Ie6
	67ZP7VJMWh/9UcFF5CpxcYt068qc3WDatve5qYX/yortuqZ4lCDNdBYWBUAOC/TXg8k=
X-Gm-Gg: ASbGncsA6b0baORjiQJlZ1ZEJzkWluMaIGVJ8JJesd3WGanrZ1lTF7ONbN59hFGKxLr
	1klM8oPnAps0yCA7WyO+ZhdC3/EYByvG31bD4pa7VT46CT8MyU4XlSLInFp0XfdlI1HAef/2IT+
	UPPunUHRMsreiANDZ40Gv0Un4y7nfV/gx0WyqWJVFrkrv4u5MwX0Vkx02GO5SzOB/NzrlTDPlfX
	Vm/SwrBAiiWAGqjo5UzHDBg3YJF0GMG32oGv636tuyxunGhqLQlPLFgkqb5yPXD1J405BOb2Tos
	DoRm73Ii8rw4AUn6lTAns9FdDr8q/LMEuvbS+0SOv91Z6KHoPkEZTkvJosB/WfrxVhRqW3hzykT
	ssm1vd79yTQF5C7Gvx+HCL/3UtNXBPhRg/R05Yg7D020NEPxz
X-Google-Smtp-Source: AGHT+IFhX3bc4HM9TfjGZWp4sNETa8SI98RSfUn4Pac/zDEO850YPWeDn5f+/GLzMsYJA3HtsueRIg==
X-Received: by 2002:a5d:5d02:0:b0:3c8:c89d:6b5b with SMTP id ffacd0b85a97d-3e643e0ad4amr3473293f8f.48.1757244323439;
        Sun, 07 Sep 2025 04:25:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45de24ab648sm33087065e9.5.2025.09.07.04.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 04:25:22 -0700 (PDT)
Date: Sun, 7 Sep 2025 14:25:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, fdmanana@kernel.org,
	linux-btrfs@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 33/33] btrfs: dump detailed info and specific messages on
 log replay failures
Message-ID: <202509070931.zy8HHIta-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0623e4f3a69cd61238551c1e5b44fc31077db16.1757075118.git.fdmanana@suse.com>

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-org/btrfs-fix-invalid-extref-key-setup-when-replaying-dentry/20250906-001715
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/f0623e4f3a69cd61238551c1e5b44fc31077db16.1757075118.git.fdmanana%40suse.com
patch subject: [PATCH 33/33] btrfs: dump detailed info and specific messages on log replay failures
config: i386-randconfig-141-20250906 (https://download.01.org/0day-ci/archive/20250907/202509070931.zy8HHIta-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509070931.zy8HHIta-lkp@intel.com/

New smatch warnings:
fs/btrfs/tree-log.c:2591 replay_xattr_deletes() warn: passing freed memory 'name' (line 2588)

Old smatch warnings:
fs/btrfs/tree-log.c:2601 replay_xattr_deletes() warn: passing freed memory 'name' (line 2588)
fs/btrfs/tree-log.c:2614 replay_xattr_deletes() warn: passing freed memory 'name' (line 2611)

vim +/name +2591 fs/btrfs/tree-log.c

51abc774a9b1d4 Filipe Manana 2025-09-05  2517  static int replay_xattr_deletes(struct walk_control *wc)
4f764e5153616f Filipe Manana 2015-02-23  2518  {
b75ff3e7b377e8 Filipe Manana 2025-09-05  2519  	struct btrfs_trans_handle *trans = wc->trans;
b75ff3e7b377e8 Filipe Manana 2025-09-05  2520  	struct btrfs_root *root = wc->root;
b75ff3e7b377e8 Filipe Manana 2025-09-05  2521  	struct btrfs_root *log = wc->log;
4f764e5153616f Filipe Manana 2015-02-23  2522  	struct btrfs_key search_key;
4f764e5153616f Filipe Manana 2015-02-23  2523  	struct btrfs_path *log_path;
b048ef711534b2 Filipe Manana 2025-09-05  2524  	const u64 ino = wc->log_key.objectid;
4f764e5153616f Filipe Manana 2015-02-23  2525  	int nritems;
4f764e5153616f Filipe Manana 2015-02-23  2526  	int ret;
4f764e5153616f Filipe Manana 2015-02-23  2527  
4f764e5153616f Filipe Manana 2015-02-23  2528  	log_path = btrfs_alloc_path();
fa7c5927bfe412 Filipe Manana 2025-07-18  2529  	if (!log_path) {
c2bd309cef030f Filipe Manana 2025-09-05  2530  		btrfs_abort_log_replay(wc, -ENOMEM, "failed to allocate path");
4f764e5153616f Filipe Manana 2015-02-23  2531  		return -ENOMEM;
fa7c5927bfe412 Filipe Manana 2025-07-18  2532  	}
4f764e5153616f Filipe Manana 2015-02-23  2533  
4f764e5153616f Filipe Manana 2015-02-23  2534  	search_key.objectid = ino;
4f764e5153616f Filipe Manana 2015-02-23  2535  	search_key.type = BTRFS_XATTR_ITEM_KEY;
4f764e5153616f Filipe Manana 2015-02-23  2536  	search_key.offset = 0;
4f764e5153616f Filipe Manana 2015-02-23  2537  again:
51abc774a9b1d4 Filipe Manana 2025-09-05  2538  	ret = btrfs_search_slot(NULL, root, &search_key, wc->subvol_path, 0, 0);
fa7c5927bfe412 Filipe Manana 2025-07-18  2539  	if (ret < 0) {
c2bd309cef030f Filipe Manana 2025-09-05  2540  		btrfs_abort_log_replay(wc, ret,
c2bd309cef030f Filipe Manana 2025-09-05  2541  			       "failed to search xattrs for inode %llu root %llu",
c2bd309cef030f Filipe Manana 2025-09-05  2542  				       ino, btrfs_root_id(root));
4f764e5153616f Filipe Manana 2015-02-23  2543  		goto out;
fa7c5927bfe412 Filipe Manana 2025-07-18  2544  	}
4f764e5153616f Filipe Manana 2015-02-23  2545  process_leaf:
51abc774a9b1d4 Filipe Manana 2025-09-05  2546  	nritems = btrfs_header_nritems(wc->subvol_path->nodes[0]);
51abc774a9b1d4 Filipe Manana 2025-09-05  2547  	for (int i = wc->subvol_path->slots[0]; i < nritems; i++) {
4f764e5153616f Filipe Manana 2015-02-23  2548  		struct btrfs_key key;
4f764e5153616f Filipe Manana 2015-02-23  2549  		struct btrfs_dir_item *di;
4f764e5153616f Filipe Manana 2015-02-23  2550  		struct btrfs_dir_item *log_di;
4f764e5153616f Filipe Manana 2015-02-23  2551  		u32 total_size;
4f764e5153616f Filipe Manana 2015-02-23  2552  		u32 cur;
4f764e5153616f Filipe Manana 2015-02-23  2553  
51abc774a9b1d4 Filipe Manana 2025-09-05  2554  		btrfs_item_key_to_cpu(wc->subvol_path->nodes[0], &key, i);
4f764e5153616f Filipe Manana 2015-02-23  2555  		if (key.objectid != ino || key.type != BTRFS_XATTR_ITEM_KEY) {
4f764e5153616f Filipe Manana 2015-02-23  2556  			ret = 0;
4f764e5153616f Filipe Manana 2015-02-23  2557  			goto out;
4f764e5153616f Filipe Manana 2015-02-23  2558  		}
4f764e5153616f Filipe Manana 2015-02-23  2559  
51abc774a9b1d4 Filipe Manana 2025-09-05  2560  		di = btrfs_item_ptr(wc->subvol_path->nodes[0], i, struct btrfs_dir_item);
51abc774a9b1d4 Filipe Manana 2025-09-05  2561  		total_size = btrfs_item_size(wc->subvol_path->nodes[0], i);
4f764e5153616f Filipe Manana 2015-02-23  2562  		cur = 0;
4f764e5153616f Filipe Manana 2015-02-23  2563  		while (cur < total_size) {
51abc774a9b1d4 Filipe Manana 2025-09-05  2564  			u16 name_len = btrfs_dir_name_len(wc->subvol_path->nodes[0], di);
51abc774a9b1d4 Filipe Manana 2025-09-05  2565  			u16 data_len = btrfs_dir_data_len(wc->subvol_path->nodes[0], di);
4f764e5153616f Filipe Manana 2015-02-23  2566  			u32 this_len = sizeof(*di) + name_len + data_len;
4f764e5153616f Filipe Manana 2015-02-23  2567  			char *name;
4f764e5153616f Filipe Manana 2015-02-23  2568  
4f764e5153616f Filipe Manana 2015-02-23  2569  			name = kmalloc(name_len, GFP_NOFS);
4f764e5153616f Filipe Manana 2015-02-23  2570  			if (!name) {
4f764e5153616f Filipe Manana 2015-02-23  2571  				ret = -ENOMEM;
c2bd309cef030f Filipe Manana 2025-09-05  2572  				btrfs_abort_log_replay(wc, ret,
c2bd309cef030f Filipe Manana 2025-09-05  2573  				       "failed to allocate memory for name of length %u",
c2bd309cef030f Filipe Manana 2025-09-05  2574  						       name_len);
4f764e5153616f Filipe Manana 2015-02-23  2575  				goto out;
4f764e5153616f Filipe Manana 2015-02-23  2576  			}
51abc774a9b1d4 Filipe Manana 2025-09-05  2577  			read_extent_buffer(wc->subvol_path->nodes[0], name,
4f764e5153616f Filipe Manana 2015-02-23  2578  					   (unsigned long)(di + 1), name_len);
4f764e5153616f Filipe Manana 2015-02-23  2579  
4f764e5153616f Filipe Manana 2015-02-23  2580  			log_di = btrfs_lookup_xattr(NULL, log, log_path, ino,
4f764e5153616f Filipe Manana 2015-02-23  2581  						    name, name_len, 0);
4f764e5153616f Filipe Manana 2015-02-23  2582  			btrfs_release_path(log_path);
4f764e5153616f Filipe Manana 2015-02-23  2583  			if (!log_di) {
4f764e5153616f Filipe Manana 2015-02-23  2584  				/* Doesn't exist in log tree, so delete it. */
51abc774a9b1d4 Filipe Manana 2025-09-05  2585  				btrfs_release_path(wc->subvol_path);
51abc774a9b1d4 Filipe Manana 2025-09-05  2586  				di = btrfs_lookup_xattr(trans, root, wc->subvol_path, ino,
4f764e5153616f Filipe Manana 2015-02-23  2587  							name, name_len, -1);
4f764e5153616f Filipe Manana 2015-02-23 @2588  				kfree(name);
                                                                              ^^^^

kfree()

4f764e5153616f Filipe Manana 2015-02-23  2589  				if (IS_ERR(di)) {
4f764e5153616f Filipe Manana 2015-02-23  2590  					ret = PTR_ERR(di);
c2bd309cef030f Filipe Manana 2025-09-05 @2591  					btrfs_abort_log_replay(wc, ret,
c2bd309cef030f Filipe Manana 2025-09-05  2592  		       "failed to lookup xattr with name %.*s for inode %llu root %llu",
c2bd309cef030f Filipe Manana 2025-09-05  2593  							       name_len, name, ino,
                                                                                                                 ^^^^
Use after free

c2bd309cef030f Filipe Manana 2025-09-05  2594  							       btrfs_root_id(root));
4f764e5153616f Filipe Manana 2015-02-23  2595  					goto out;
4f764e5153616f Filipe Manana 2015-02-23  2596  				}
4f764e5153616f Filipe Manana 2015-02-23  2597  				ASSERT(di);
4f764e5153616f Filipe Manana 2015-02-23  2598  				ret = btrfs_delete_one_dir_name(trans, root,
51abc774a9b1d4 Filipe Manana 2025-09-05  2599  								wc->subvol_path, di);
fa7c5927bfe412 Filipe Manana 2025-07-18  2600  				if (ret) {
c2bd309cef030f Filipe Manana 2025-09-05  2601  					btrfs_abort_log_replay(wc, ret,
c2bd309cef030f Filipe Manana 2025-09-05  2602  		       "failed to delete xattr with name %.*s for inode %llu root %llu",
c2bd309cef030f Filipe Manana 2025-09-05  2603  							       name_len, name, ino,
                                                                                                                 ^^^^
First print the name, then free it.

c2bd309cef030f Filipe Manana 2025-09-05  2604  							       btrfs_root_id(root));
4f764e5153616f Filipe Manana 2015-02-23  2605  					goto out;
fa7c5927bfe412 Filipe Manana 2025-07-18  2606  				}
51abc774a9b1d4 Filipe Manana 2025-09-05  2607  				btrfs_release_path(wc->subvol_path);
4f764e5153616f Filipe Manana 2015-02-23  2608  				search_key = key;
4f764e5153616f Filipe Manana 2015-02-23  2609  				goto again;
4f764e5153616f Filipe Manana 2015-02-23  2610  			}
4f764e5153616f Filipe Manana 2015-02-23  2611  			kfree(name);
                                                                      ^^^^^
4f764e5153616f Filipe Manana 2015-02-23  2612  			if (IS_ERR(log_di)) {
4f764e5153616f Filipe Manana 2015-02-23  2613  				ret = PTR_ERR(log_di);
c2bd309cef030f Filipe Manana 2025-09-05  2614  				btrfs_abort_log_replay(wc, ret,
c2bd309cef030f Filipe Manana 2025-09-05  2615  	"failed to lookup xattr in log tree with name %.*s for inode %llu root %llu",
c2bd309cef030f Filipe Manana 2025-09-05  2616  						       name_len, name, ino,
                                                                                                         ^^^^
same.


c2bd309cef030f Filipe Manana 2025-09-05  2617  						       btrfs_root_id(root));
4f764e5153616f Filipe Manana 2015-02-23  2618  				goto out;
4f764e5153616f Filipe Manana 2015-02-23  2619  			}
4f764e5153616f Filipe Manana 2015-02-23  2620  			cur += this_len;
4f764e5153616f Filipe Manana 2015-02-23  2621  			di = (struct btrfs_dir_item *)((char *)di + this_len);
4f764e5153616f Filipe Manana 2015-02-23  2622  		}
4f764e5153616f Filipe Manana 2015-02-23  2623  	}
51abc774a9b1d4 Filipe Manana 2025-09-05  2624  	ret = btrfs_next_leaf(root, wc->subvol_path);
4f764e5153616f Filipe Manana 2015-02-23  2625  	if (ret > 0)
4f764e5153616f Filipe Manana 2015-02-23  2626  		ret = 0;
4f764e5153616f Filipe Manana 2015-02-23  2627  	else if (ret == 0)
4f764e5153616f Filipe Manana 2015-02-23  2628  		goto process_leaf;
fa7c5927bfe412 Filipe Manana 2025-07-18  2629  	else
c2bd309cef030f Filipe Manana 2025-09-05  2630  		btrfs_abort_log_replay(wc, ret,
c2bd309cef030f Filipe Manana 2025-09-05  2631  			       "failed to get next leaf in subvolume root %llu",
c2bd309cef030f Filipe Manana 2025-09-05  2632  				       btrfs_root_id(root));
4f764e5153616f Filipe Manana 2015-02-23  2633  out:
4f764e5153616f Filipe Manana 2015-02-23  2634  	btrfs_free_path(log_path);
51abc774a9b1d4 Filipe Manana 2025-09-05  2635  	btrfs_release_path(wc->subvol_path);
4f764e5153616f Filipe Manana 2015-02-23  2636  	return ret;
4f764e5153616f Filipe Manana 2015-02-23  2637  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


