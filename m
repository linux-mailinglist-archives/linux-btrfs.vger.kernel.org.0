Return-Path: <linux-btrfs+bounces-20676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09230D39ED6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 07:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E69A30081A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 06:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE24822576E;
	Mon, 19 Jan 2026 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCsy8+VC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77497270ED7
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804801; cv=none; b=MMWEyBlgceMBkc6KaFVsFbHNfLlPoZcLWRuuGtzMSnOKg8fmgXN/5JNrjAAz1zcg6owGz3LR1Zyliul3QlOd0zRD2VETRDXaFNJ4JQyw7rB78c1GDz575t9sEbFIrmEMkzUAthtdBDgJKJmSXdUXhsICn5A3wuy+38lIsm8tlQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804801; c=relaxed/simple;
	bh=YE5jezai2biwr3Gnu5tpda+uRI0xIpqVr5jQ76BFhaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GAD7iwJuaMVRWtO2CYaRsqjhgnzLv/Wtp3bWKwIuWhhcCKXwYoyWrTT3KGSVBXjieQVN8FViNE0vjcFuWkIDKJrJ0Q+AuZhokFSgVdf7Ykk4kmJ4KbfG85qPsq05zyxm21BYL2k4Hfk4zaoXLu+N+n682JkMLi3syxUbuxVnvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PCsy8+VC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47edffe5540so34687305e9.0
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 22:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768804798; x=1769409598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhpuhf8aqRruGu7L/fSfGH0BgTbK0i1Gv5JjSOJHbPQ=;
        b=PCsy8+VCPX4wwY8a4+DXeJojOe6uBWwzMYdbfvtCRDCbVqCP6x3n5dhddDGfQH0kBf
         C+KNyCb83oT26lhZc+eV8Fr+y3mIuEMGzhRzNUQ6vfXjEg3xGDM9vC+3x1ZgnIEban6y
         4VvSbJcffs20KtRAdKX5YwvcRfOhMHPlX9wp/WL2iiKeZRqG8P0p4iYCHYHl0UREQcBP
         9C87Ayup0QL6zmMzmkn2vwuYZFq16dWgoHSbhh0Ulju+jI9f/NAngfXrBN5dtJgVK2NP
         EYX5I+sKBYoLsyPkA2WUQfW1/XMkh3Hn+c/wDl155cSW3Xq4UMjB1Q5D1dwmdQcciCu0
         eEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768804798; x=1769409598;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhpuhf8aqRruGu7L/fSfGH0BgTbK0i1Gv5JjSOJHbPQ=;
        b=c2W7XGD6XSphR1grvdBj6qeQrv75PhkxHMKKOq1NDYH+FmFtov62gFhta7bHp2lozT
         LrbyRjzP1X+KnGM4f4RkTruZpJWOQfk8ra30mv6fxM1KVhoJyPZFE9LmfebS0c4FYTzy
         DXajYea8sngbv6RpNiayME5em1KldV7V6mg0osM0eeAX8zatBMegOiIm8xrIW3OYkhY0
         BIvBsUJBa5uwY2hpYMt+bqxrpGhStQ+YX5pwd91UJ+9yy+EFzeUPu1eGDlFpaqnrxCOA
         P2KIUEcV4QtQGn6/IEboX/I9jC/jyqNiJShJH0uDxOu7vTqDQ9nPaeedsl69mZIg0cwh
         5OhA==
X-Forwarded-Encrypted: i=1; AJvYcCXtkZ5DU2xl0TOEpxNwKwmfv2L3YJ0ALpBgs2P1ttkZtN5xV3OwBVnu6b+P9gMds5ZMYMROwU2iADId1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw456VWXq10p5AH+OionV3WMpVaRj9O38YnpFW/mwt0FGomg9tD
	BCnSULWm4Jbcae1KQYZceT6dArY9+tIqFt2bk8nrBRIC7ZZNUQNWNcULH8P4TFJA8Z8=
X-Gm-Gg: AY/fxX4lRpJM2hm+byfyggOgAQgapatToYqmAYtPgMdsgXZcrSX8n0WCedjFzk0qef+
	zA1IdEOP5xArSL22XAYjcLuBBkLHSgu0Xv2SwzD2Uim4SpM9aHx5abxOY5gujowYlLimnNMMsQt
	kBqiceGOyKn8SX0MnXrPs+gwDf2F0X8oVqNYJ+tIwfOKn6Jf9iD1c/LckXiqITy2RzOsWXTiUfN
	ea/SWC94tRvyxKXPvUigqItNG8pY5W0iwfTLf3uUbbPd9AP4ddsZCYk2NeSTSK3KIbqoogalwbc
	Z3xh30PdTsjZkvgS8IH6hyFV5TyWpstVPrHRizDIj/59yNc883hb3uI32O5bdfNLjgWHNwUw9qR
	BgvZ7YAsoUDJ8bCmWWcye89/QsMgt6BeRMUArfK75vLf/QruDvBsqGQ3GMQ91uLVoGs1ZQ/WqT6
	JMM69k7Z592zIrub3l
X-Received: by 2002:a05:600c:4f8f:b0:477:aed0:f40a with SMTP id 5b1f17b1804b1-4801e33c2a5mr130322625e9.19.1768804797300;
        Sun, 18 Jan 2026 22:39:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe3ae95sm77473395e9.4.2026.01.18.22.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 22:39:56 -0800 (PST)
Date: Mon, 19 Jan 2026 09:39:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, fdmanana@kernel.org,
	linux-btrfs@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: use the btrfs_block_group_end() helper everywhere
Message-ID: <202601170636.WsePMV5H-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7afa4b2c9350b08695cc34cd917dea3bf766bce.1768559305.git.fdmanana@suse.com>

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-org/btrfs-use-the-btrfs_block_group_end-helper-everywhere/20260116-183655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/f7afa4b2c9350b08695cc34cd917dea3bf766bce.1768559305.git.fdmanana%40suse.com
patch subject: [PATCH] btrfs: use the btrfs_block_group_end() helper everywhere
config: alpha-randconfig-r072-20260117 (https://download.01.org/0day-ci/archive/20260117/202601170636.WsePMV5H-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 10.5.0
smatch version: v0.5.0-8985-g2614ff1a

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202601170636.WsePMV5H-lkp@intel.com/

New smatch warnings:
fs/btrfs/free-space-cache.c:1207 write_pinned_extent_entries() warn: variable dereferenced before check 'block_group' (see line 1203)

vim +/block_group +1207 fs/btrfs/free-space-cache.c

6701bdb39ceb48 David Sterba    2019-03-20  1196  static noinline_for_stack int write_pinned_extent_entries(
6b45f64172e130 Nikolay Borisov 2020-01-20  1197  			    struct btrfs_trans_handle *trans,
32da5386d9a4fd David Sterba    2019-10-29  1198  			    struct btrfs_block_group *block_group,
4c6d1d85ad89fd Chris Mason     2015-04-06  1199  			    struct btrfs_io_ctl *io_ctl,
d4452bc526c431 Chris Mason     2014-05-19  1200  			    int *entries)
d4452bc526c431 Chris Mason     2014-05-19  1201  {
d4452bc526c431 Chris Mason     2014-05-19  1202  	u64 start, extent_start, extent_end, len;
7fc5a6968403c7 Filipe Manana   2026-01-16 @1203  	const u64 block_group_end = btrfs_block_group_end(block_group);
                                                                                                          ^^^^^^^^^^^^
Dereferenced.

d4452bc526c431 Chris Mason     2014-05-19  1204  	struct extent_io_tree *unpin = NULL;
d4452bc526c431 Chris Mason     2014-05-19  1205  	int ret;
43be21462d8c26 Josef Bacik     2011-04-01  1206  
5349d6c3ffead2 Miao Xie        2014-06-19 @1207  	if (!block_group)
                                                             ^^^^^^^^^^^
Too late.

5349d6c3ffead2 Miao Xie        2014-06-19  1208  		return 0;
5349d6c3ffead2 Miao Xie        2014-06-19  1209  
43be21462d8c26 Josef Bacik     2011-04-01  1210  	/*
43be21462d8c26 Josef Bacik     2011-04-01  1211  	 * We want to add any pinned extents to our free space cache
43be21462d8c26 Josef Bacik     2011-04-01  1212  	 * so we don't leak the space

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


