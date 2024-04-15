Return-Path: <linux-btrfs+bounces-4253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C88A48FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB13C1F23D51
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7A3249F5;
	Mon, 15 Apr 2024 07:26:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6B22612;
	Mon, 15 Apr 2024 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165970; cv=none; b=jhzLP64oIgW2ru1qoFAb8gZMNT8CoXaflKrl/uBkqHtnLVZkQVwsfGk3wVAHv3s9FaBSiVtLrq+X5KL+MOZ6Yq1lg/cyN1wCe6kFMdTxql6WuBQgI0EKWyGjAsu37lwI/u7uk8uZwsfAkB3y+sYwLSDuj3udFT3StRws7Up/pZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165970; c=relaxed/simple;
	bh=UHRabD4J37CzG2OAN2G/qgBWL6PoomL+Ho/mMLyFhoQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pmN39vHGeJSVF5d8gSIxNBtLTGLWKdcwxkeV4AAkPEe0TqcB7svSAgGQb5jUtIyLPc5vYfFLjViY1v77s79YyHDsQP6RIRKnfdJe98478L6zLz0ZJuT5ejpoxIV+UT4bnNO/RrzbGBRpRu0VLu3KSwEDS+qUpelSCI9uVj0yG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd7672.dip0.t-ipconnect.de [93.221.118.114])
	by mail.itouring.de (Postfix) with ESMTPSA id B930310376E;
	Mon, 15 Apr 2024 09:25:58 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 6305DF01605;
	Mon, 15 Apr 2024 09:25:58 +0200 (CEST)
Subject: Re: btrfs: sanity tests fails on 6.8.3
To: Naohiro Aota <Naohiro.Aota@wdc.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Hiroshi Takekawa <sian@big.or.jp>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, LKML <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240415.125625.2060132070860882181.sian@big.or.jp>
 <bd8492f4-a12e-48ae-8ea6-a9d4596a6f72@leemhuis.info>
 <igqfzsnyclopilimyy27ualcf2g5g44x3ru5v3tkjpb3ukgabs@2yuc57sxoxvv>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <3b2d9a1c-37d2-47f4-b0b4-a9d6c34d2c7d@applied-asynchrony.com>
Date: Mon, 15 Apr 2024 09:25:58 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <igqfzsnyclopilimyy27ualcf2g5g44x3ru5v3tkjpb3ukgabs@2yuc57sxoxvv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2024-04-15 07:24, Naohiro Aota wrote:
> On Mon, Apr 15, 2024 at 07:11:15AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [adding the authors of the two commits mentioned as well as the Btrfs
>> maintainers and the regressions & stable list to the list of recipients]
>>
>> On 15.04.24 05:56, Hiroshi Takekawa wrote:
>>>
>>> Module loading fails with CONFIG_BTRFS_FS_RUN_SANITY_TESTS enabled on
>>> 6.8.3-6.8.6.
>>>
>>> Bisected:
>>> Reverting these commits, then module loading succeeds.
>>> 70f49f7b9aa3dfa70e7a2e3163ab4cae7c9a457a
>>
>> FWIW, that is a linux-stable commit-id for 41044b41ad2c8c ("btrfs: add
>> helper to get fs_info from struct inode pointer") [v6.9-rc1, v6.8.3
>> (70f49f7b9aa3df)]
>>
>>> 86211eea8ae1676cc819d2b4fdc8d995394be07d
> 
> It looks like the stable tree lacks this commit, which is necessary for the
> commit above.
> 
> b2136cc288fc ("btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()")
> 

This was previously reported during the last stable cycle, and the missing
patch is already queued up. You can see the queue here:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.8

cheers
Holger

