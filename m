Return-Path: <linux-btrfs+bounces-4013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FBB89B4D3
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3F52812BA
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2BBA94B;
	Mon,  8 Apr 2024 00:00:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-69.mail.aliyun.com (out28-69.mail.aliyun.com [115.124.28.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85297D2F5;
	Mon,  8 Apr 2024 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712534428; cv=none; b=NjlfTuZwkoVLEzHQjH1C7KvTMs2gl9x8hpC4PMtXnP8tu0E+Yjov5A1XWOaGrPqn4o6oRlZoz92lD9UFZ+dbwZw3zNRf18zQDgsOsyDM5ifP3TPjwnNJ0m9Qt4p7TrNCCZ3+Nya7h4obXydjm2CCnmrQkYvxbmmUqNnOy3NZR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712534428; c=relaxed/simple;
	bh=VYoTCMahrqGMLq/wVZiFhH4HAP4gWEo41IECyqjr6Kk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=fAk8ZgE4ohNMGN22+1fv8WIn7/UxHmSbk+yN5RvFMB/pBzqguSN+LTChiCRuFkzxKaCZWrcT2++1Vk0kcw7K4G1xXpQFqEN1ut97QbnSxVCa1a110+O2qKR3OSEBfrLcQTzNzRr4YpyHiBnoeMYqPR8WBhM3ewrsS9yrCoBsjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04792926|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0308407-0.000406287-0.968753;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.X4fYkYZ_1712534413;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.X4fYkYZ_1712534413)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 08:00:14 +0800
Date: Mon, 08 Apr 2024 08:00:15 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()
Cc: linux-btrfs@vger.kernel.org,
 stable@vger.kernel.org
In-Reply-To: <4240e179e2439dd1698798e2de79ec59990cbaa0.1712452660.git.wqu@suse.com>
References: <4240e179e2439dd1698798e2de79ec59990cbaa0.1712452660.git.wqu@suse.com>
Message-Id: <20240408080014.74B2.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.06 [en]

Hi,

> [BUG]
> During my extent_map cleanup/refactor, with more than too strict sanity
> checks, extent-map-tests::test_case_7() would crash my extent_map sanity
> checks.
> 
> The problem is, after btrfs_drop_extent_map_range(), the resulted
> extent_map has a @block_start way too large.
> Meanwhile my btrfs_file_extent_item based members are returning a
> correct @disk_bytenr along with correct @offset.
> 
> The extent map layout looks like this:
> 
>      0        16K    32K       48K
>      | PINNED |      | Regular |
> 
> The regular em at [32K, 48K) also has 32K @block_start.
> 
> Then drop range [0, 36K), which should shrink the regular one to be
> [36K, 48K).
> However the @block_start is incorrect, we expect 32K + 4K, but got 52K.
> 
> [CAUSE]
> Inside btrfs_drop_extent_map_range() function, if we hit an extent_map
> that covers the target range but is still beyond it, we need to split
> that extent map into half:
> 
> 	|<-- drop range -->|
> 		 |<----- existing extent_map --->|
> 
> And if the extent map is not compressed, we need to forward
> extent_map::block_start by the difference between the end of drop range
> and the extent map start.
> 
> However in that particular case, the difference is calculated using
> (start + len - em->start).
> 
> The problem is @start can be modified if the drop range covers any
> pinned extent.
> 
> This leads to wrong calculation, and would be caught by my later
> extent_map sanity checks, which checks the em::block_start against
> btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset.
> 
> And unfortunately this is going to cause data corruption, as the
> splitted em is pointing an incorrect location, can cause either
> unexpected read error or wild writes.
> 
> [FIX]
> Fix it by avoiding using @start completely, and use @end - em->start
> instead, which @end is exclusive bytenr number.
> 
> And update the test case to verify the @block_start to prevent such
> problem from happening.
> 
> CC: stable@vger.kernel.org # 6.7+
> Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent_map_range")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

$ git describe --contains c962098ca4af
v6.5-rc7~4^2

so it should be
CC: stable@vger.kernel.org # 6.5+

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/04/08



