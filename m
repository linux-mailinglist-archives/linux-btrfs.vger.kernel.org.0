Return-Path: <linux-btrfs+bounces-16187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940CEB2F1BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 10:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CADB602D04
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D4D2F0665;
	Thu, 21 Aug 2025 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EvAQtQJR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974212EFD91
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764499; cv=none; b=poi81XD8GRawseLgCD+SAP8jn/3BiAc7g1ZFW/ktVMuk+pioOahlvIBVLfVfbvMvXPrnhQtA2rRDINPZUJ002nCp8zcXBIWi4cPCBsZg5G99iiS24pJ7UnxL/nF0SsBwej27Zs3WZ+yGJlt/NZwPYokmguhGg5frt0oQuDM6Ifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764499; c=relaxed/simple;
	bh=JXocULCsBo7/n98cmVoNOqykInxPZnjLVNBTREPdg0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k1EEZ+6SM1n6lrgHx9yLOGpJ/WwX8iaAtt+3M63vWJ5pzmy+1O6E9xZjyrrbwory1YpoXWKdQkHEJSLPGeriXs7RCbDLC2VP26gWcG5/UArT6YoHkBHooHtk2kykLG6KmI3dzQx+9PeUXZNbsng+yBas8/mIxHcrcoEyX5iKGBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EvAQtQJR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c44dfa7739so183412f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755764494; x=1756369294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6F9MVHoGttGvZi9mtKapX8wE+xXVK++WzjAWqNNFy5w=;
        b=EvAQtQJRBlzT+epmpzEGGEcEY7UGGykjJRQtuStcTnJUSxJpMyfmZSWg7BwV9Dixjo
         zhHmcj6cB0iJOeQgGrQhHTfJM/pOcpUdpIwwCP+aDM27Gfm2xnNx3VSmtTneSmSON35b
         VQZP71R5T8y7UPfxm1PDf9Cg1Ij5kOMJvyXLvp6T1is+eiiHzyBVqoS3989so+nlv0dQ
         sfGdj3T4lOO/+a7qqRHVecwyJh5/jUoToAYbzX4fT2CoGTMFS+hi1PVPdjvZ/hmAkcMs
         V5re3CDOgQ5uTjKDo5iwm0E0E2M80scVKAy/Om4rWG1RL9joOKf388UTeanSlOCGSdnJ
         n1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764494; x=1756369294;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6F9MVHoGttGvZi9mtKapX8wE+xXVK++WzjAWqNNFy5w=;
        b=rZsOE5XoAhi7IBze/FjSeRppwniHTK2o+gbbfs0XAyiVyU4bmYC7XY+sV7uM7/vjBG
         FJyMh5yEeGrDqJYJ3NR6C8WhJeW2eFu8lE+hUF7V9CMZSdseY6c0KOjMKyE1tJHLcIxO
         P5MvRPSS4GkA0rGdievLbKLwfxU3LwhAszyU3MrEviH1Rr4QLElfK4ed8X8G1qljkJeF
         G6CiCKZfvHJE6WZV7oXO2o7Mj7zKVlL9Oyg/uQcacmD55o8Vj3zFmkRLnZOVVx5ohyt3
         jzN7dGHE/A2EYfx4/LxVRZN/8aqZIz3BlpRDQGt6vWiQeEvm5tM+YUksrT9pPzp0UYpH
         Pszw==
X-Forwarded-Encrypted: i=1; AJvYcCV7rB8k2+8mboFePBA0KVr5VqNkPL0oOifq8l/zY7sTp2p3/gYEMXeRoAe8uFYzfm1rU6w5ddExWadRhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLKLeUMgurlJwmOT6BRsrRJNXavSb1Lj8E4CsZPrJ4Eypulqg
	zR+WfSfIAct7fZXpc+jbbDlWtx7q4JBMpO4ZZ8PiG6eRGE2x2VPuU1tMdnwwXYsYbCw=
X-Gm-Gg: ASbGncu8WVyI9GFm88JLfU41iayy2mxLcxX4vMib9gM9qwxmUlrNyHMH0wk5wBedwDp
	6/b+TrI/P4fsmyt2UAGJfR6l1vJFj7kxY7m6E+wXm39XJDjsAa57FZdxcdzimCIDaiD5zhg+Qjf
	L0dO4LWZRsvpJ8+iG5fc8hi5zqLht7vjGWD75ksXYuyhHfxUUtap/Q4Q9Ya8ejp4RXl/d4DwTRC
	szyqShsL2bfCqu0hwMVU1mH/vhc6rgLYQYq8T9uggbqgfHzFagLZrPIcKYxhmNNMDqbOZ6TnSY+
	+JJdHlPwTijYu3A/4Vzc1GOvSNa+3hhtNb76GGOoB2T06dk7yrLy1UMQTWIrifz7/0J9nu5FW1u
	IspgO/SnsezBvLtS6jWA8CcefUE8=
X-Google-Smtp-Source: AGHT+IEEH9J16IEfY7X5Ab8U3awn2/tTG/DyRWYmbtluKFWJrwnSi/zTjuUtoKU2yasvK1jGjM/f0A==
X-Received: by 2002:a05:6000:2911:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3c4b0445cbcmr1346807f8f.15.1755764494525;
        Thu, 21 Aug 2025 01:21:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07487986fsm11782149f8f.1.2025.08.21.01.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:21:34 -0700 (PDT)
Date: Thu, 21 Aug 2025 11:21:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Sun YangKai <sunk67188@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Sun YangKai <sunk67188@gmail.com>
Subject: Re: [PATCH] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Message-ID: <202508211534.QmDKCbTm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819033819.19826-1-sunk67188@gmail.com>

Hi Sun,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sun-YangKai/btrfs-more-trivial-BTRFS_PATH_AUTO_FREE-conversions/20250819-114252
base:   v6.17-rc2
patch link:    https://lore.kernel.org/r/20250819033819.19826-1-sunk67188%40gmail.com
patch subject: [PATCH] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
config: parisc-randconfig-r071-20250821 (https://download.01.org/0day-ci/archive/20250821/202508211534.QmDKCbTm-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 9.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508211534.QmDKCbTm-lkp@intel.com/

smatch warnings:
fs/btrfs/send.c:931 get_inode_info() warn: missing error code? 'ret'

vim +/ret +931 fs/btrfs/send.c

7e93f6dc11d9128 BingJing Chang  2022-08-12  908  static int get_inode_info(struct btrfs_root *root, u64 ino,
7e93f6dc11d9128 BingJing Chang  2022-08-12  909  			  struct btrfs_inode_info *info)
31db9f7c23fbf7e Alexander Block 2012-07-25  910  {
31db9f7c23fbf7e Alexander Block 2012-07-25  911  	int ret;
c8ce1e5fe626333 Sun YangKai     2025-08-19  912  	BTRFS_PATH_AUTO_FREE(path);
31db9f7c23fbf7e Alexander Block 2012-07-25  913  	struct btrfs_inode_item *ii;
31db9f7c23fbf7e Alexander Block 2012-07-25  914  	struct btrfs_key key;
31db9f7c23fbf7e Alexander Block 2012-07-25  915  
7e93f6dc11d9128 BingJing Chang  2022-08-12  916  	path = alloc_path_for_send();
7e93f6dc11d9128 BingJing Chang  2022-08-12  917  	if (!path)
7e93f6dc11d9128 BingJing Chang  2022-08-12  918  		return -ENOMEM;
7e93f6dc11d9128 BingJing Chang  2022-08-12  919  
31db9f7c23fbf7e Alexander Block 2012-07-25  920  	key.objectid = ino;
31db9f7c23fbf7e Alexander Block 2012-07-25  921  	key.type = BTRFS_INODE_ITEM_KEY;
31db9f7c23fbf7e Alexander Block 2012-07-25  922  	key.offset = 0;
31db9f7c23fbf7e Alexander Block 2012-07-25  923  	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
31db9f7c23fbf7e Alexander Block 2012-07-25  924  	if (ret) {
3f8a18cc53bd1be Josef Bacik     2014-03-28  925  		if (ret > 0)
31db9f7c23fbf7e Alexander Block 2012-07-25  926  			ret = -ENOENT;
c8ce1e5fe626333 Sun YangKai     2025-08-19  927  		return ret;
31db9f7c23fbf7e Alexander Block 2012-07-25  928  	}
31db9f7c23fbf7e Alexander Block 2012-07-25  929  
7e93f6dc11d9128 BingJing Chang  2022-08-12  930  	if (!info)
c8ce1e5fe626333 Sun YangKai     2025-08-19 @931  		return ret;

ret is zero, but it should be an error code.

7e93f6dc11d9128 BingJing Chang  2022-08-12  932  
31db9f7c23fbf7e Alexander Block 2012-07-25  933  	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
31db9f7c23fbf7e Alexander Block 2012-07-25  934  			struct btrfs_inode_item);
7e93f6dc11d9128 BingJing Chang  2022-08-12  935  	info->size = btrfs_inode_size(path->nodes[0], ii);
7e93f6dc11d9128 BingJing Chang  2022-08-12  936  	info->gen = btrfs_inode_generation(path->nodes[0], ii);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


