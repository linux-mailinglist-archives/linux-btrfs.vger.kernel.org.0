Return-Path: <linux-btrfs+bounces-16191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB66AB2F51A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 12:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D975E29C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F4A2D374D;
	Thu, 21 Aug 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIG362vf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332C2472B5
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771570; cv=none; b=TCishaBcTyYn9jbJ6HtJoDfVD7Cxvefnx9bvpOuBCZocrWvzbeFKa/dDv0hG42jMBuQFS2v4vjqYlRTdYyZShAZjiytbZBCezPDznY3BOGLZpSN592hEVCo0SPzgoxMqbEMWHEnc5tm0uT7XIVIUShuvGXFJZMpEiYGK58f8HPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771570; c=relaxed/simple;
	bh=prHxZP8DezTOtIsD9ru7f5OfrrRQ8e7yhSJmObU25JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJyn8M+7Zh2jlV3+Ai2lvMt4In3pZw6wWhLnzsmKTs2xYHXrOu4P1sTChRcVXYLCstRsMGVLzZ560gaC3GRmfuAgqYSx7zF0iXHsDa687IotHmfezw/p3rdmmob1kphRHOaEhP57vdxfi3EEz8eDx/8Gwi3005R9Ul7dc/IIZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIG362vf; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-24617d3f077so403125ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755771568; x=1756376368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hgWuSWiryAgM40ut5FSjSWMSxIyK/0obeUx3L93sik=;
        b=nIG362vfX/NCOPtDwkaZYU+gvUYVIM5t+5iU7ZUE4tqFzjAuysbRxTzLUgYXRjNHMR
         IKIX3/UdSnX1FVtubC0Z8V43kIF9jWChApyMxckFV1Os3o0E2+VhXHhEkPgM9bzdO6HL
         ps+FxOmH4Q7IpOcZRIlHCm0LbrgQh9zAf8XwIjgV3+zxjJXQzIqQ8F2TT/VDL/2Ty+qS
         tmjLFnEGOCSrMFP0aWyHSjNufO5Z8vkl3oriR3pz79gEtx7GsG28j2s6Ialk2e4z+wQX
         GLAmK/TXD/9KML+LVcSvYr6NqQ2XRJLnnaoIRQNVnFN++oTFto4NWLbpoQi9zokd16dd
         AQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755771568; x=1756376368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hgWuSWiryAgM40ut5FSjSWMSxIyK/0obeUx3L93sik=;
        b=Xi4FSFlj47AgFPck0iNKj3hhh+avOdYlA2uQUyvSDIC8FuHV8JbknP9MCkhb1JPR9o
         r5PVBa8MBl9SHnalRXwUQnOpcUpPkN/bIpsOi5Vz3s6Zht2wZk1fT1OnxaCH+ggyIZDb
         qJ7H4QylyMeCEncXVUStMKcy8tpJlFNYFQLotRuAwANCVFxmZ45puYfV2nUYGigyVYrk
         2DFH+xllUQEs+fJzGni2h/eFqm+m/SjSJKBZ82edKvygUzFQRJwhUgedLeV6eu4aPEFw
         dwGUY5pF3OZ6ZgZM5xFMXZgoH7atGVzrqL0iQpXLkJofwr+oFf7mdJ17UinppHUs5kgA
         EKEg==
X-Gm-Message-State: AOJu0Yx6Z8a1OkKjhaVTZpq3/QzpsRRmd5+iNY5pxwjC4Xg5DZH/1g9m
	9RA2Bgm/lasXejK5Rd2UCoUMKyrUavVRuGqiwpu5loCbfJbZwvGS3j2y
X-Gm-Gg: ASbGncviiRgwOiLYjcI2zgAuW2yLi0w4rc6JrX2LxurZKDSMd6LqdpMS+0kkATRg9xe
	Gy/ZY3zIApVHahgGIb9KBXmZzUXC+PmwWips8wVRRR39lERCC0yF78tpESTSOwUv9GEzTPsmGAl
	ZldDSUx5YLZRutF6XhPqJshDzU/yUcDDh9xgfKccpJIOom6gHpzc5fYB1fEIxRaa1g+lhQ8V0Vo
	DJ6t4yg2sA0wCXrOC9QDup4aVndzdNMg6+v+1pJ1Cmikm5RzUUkQe06ddQ2yFDkbAOTuF84QKoO
	McNh29hcg1c4uyyINJHZTrEOPEVSpzYfkDYTaz6sNYPr6CRM4joO0WdDbnbujoV8uuPQvDiyjd3
	aEqt8EkuIlY+s9eFKJcZQjBjENxXOSYP3lWcbdMX5vU5SnSZ3ZqXsRmk=
X-Google-Smtp-Source: AGHT+IHO4Fs0EZv6RK0M3Dz9B+uEs16lq3+ogXifupeHlOXBJPhiWohY4ZgIoE6/EC741L941GK9OQ==
X-Received: by 2002:a17:903:610:b0:240:764e:afab with SMTP id d9443c01a7336-245ff89cafdmr10823705ad.6.1755771567867;
        Thu, 21 Aug 2025 03:19:27 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.112.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed336002sm51597345ad.5.2025.08.21.03.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:19:27 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Thu, 21 Aug 2025 18:19:23 +0800
Message-ID: <1940532.tdWV9SEqCh@saltykitkat>
In-Reply-To: <202508211534.QmDKCbTm-lkp@intel.com>
References: <202508211534.QmDKCbTm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> Hi Sun,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:   
> https://github.com/intel-lab-lkp/linux/commits/Sun-YangKai/btrfs-more-trivi
> al-BTRFS_PATH_AUTO_FREE-conversions/20250819-114252 base:   v6.17-rc2
> patch link:   
> https://lore.kernel.org/r/20250819033819.19826-1-sunk67188%40gmail.com
> patch subject: [PATCH] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
> config: parisc-randconfig-r071-20250821
> (https://download.01.org/0day-ci/archive/20250821/202508211534.QmDKCbTm-lkp
> @intel.com/config) compiler: hppa-linux-gcc (GCC) 9.5.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version
> of the same patch/commit), kindly add following tags
> 
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202508211534.QmDKCbTm-lkp@intel.com/
> 
> smatch warnings:
> fs/btrfs/send.c:931 get_inode_info() warn: missing error code? 'ret'
> 
> vim +/ret +931 fs/btrfs/send.c
> 
> 7e93f6dc11d9128 BingJing Chang  2022-08-12  908  static int
> get_inode_info(struct btrfs_root *root, u64 ino, 7e93f6dc11d9128 BingJing
> Chang  2022-08-12  909  			  struct btrfs_inode_info *info) 
31db9f7c23fbf7e
> Alexander Block 2012-07-25  910  {
> 31db9f7c23fbf7e Alexander Block 2012-07-25  911  	int ret;
> c8ce1e5fe626333 Sun YangKai     2025-08-19  912 
> 	BTRFS_PATH_AUTO_FREE(path); 31db9f7c23fbf7e Alexander Block 2012-07-25 
> 913  	struct btrfs_inode_item *ii; 31db9f7c23fbf7e Alexander Block
> 2012-07-25  914  	struct btrfs_key key; 31db9f7c23fbf7e Alexander Block
> 2012-07-25  915
> 7e93f6dc11d9128 BingJing Chang  2022-08-12  916  	path =
> alloc_path_for_send(); 7e93f6dc11d9128 BingJing Chang  2022-08-12  917  	
if
> (!path)
> 7e93f6dc11d9128 BingJing Chang  2022-08-12  918  		return -ENOMEM;
> 7e93f6dc11d9128 BingJing Chang  2022-08-12  919
> 31db9f7c23fbf7e Alexander Block 2012-07-25  920  	key.objectid = ino;
> 31db9f7c23fbf7e Alexander Block 2012-07-25  921  	key.type =
> BTRFS_INODE_ITEM_KEY; 31db9f7c23fbf7e Alexander Block 2012-07-25  922 
> 	key.offset = 0;
> 31db9f7c23fbf7e Alexander Block 2012-07-25  923  	ret =
> btrfs_search_slot(NULL, root, &key, path, 0, 0); 31db9f7c23fbf7e Alexander
> Block 2012-07-25  924  	if (ret) {
> 3f8a18cc53bd1be Josef Bacik     2014-03-28  925  		if (ret > 0)
> 31db9f7c23fbf7e Alexander Block 2012-07-25  926  			ret = -ENOENT;
> c8ce1e5fe626333 Sun YangKai     2025-08-19  927  		return ret;
> 31db9f7c23fbf7e Alexander Block 2012-07-25  928  	}
> 31db9f7c23fbf7e Alexander Block 2012-07-25  929
> 7e93f6dc11d9128 BingJing Chang  2022-08-12  930  	if (!info)
> c8ce1e5fe626333 Sun YangKai     2025-08-19 @931  		return ret;
This early return should be done at the beginning of this function instead of 
after btrfs_search_slot() since info is the pointer to the output. With a NULL 
output, we should do nothing. I'll change this in patch v2.
> 
> ret is zero, but it should be an error code.
> 
> 7e93f6dc11d9128 BingJing Chang  2022-08-12  932
> 31db9f7c23fbf7e Alexander Block 2012-07-25  933  	ii =
> btrfs_item_ptr(path->nodes[0], path->slots[0], 31db9f7c23fbf7e Alexander
> Block 2012-07-25  934  			struct btrfs_inode_item); 
7e93f6dc11d9128
> BingJing Chang  2022-08-12  935  	info->size =
> btrfs_inode_size(path->nodes[0], ii); 7e93f6dc11d9128 BingJing Chang 
> 2022-08-12  936  	info->gen = btrfs_inode_generation(path->nodes[0], ii);

Thanks,
Sun Yangkai





