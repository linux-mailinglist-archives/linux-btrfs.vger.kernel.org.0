Return-Path: <linux-btrfs+bounces-1584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A186833516
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 15:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A33282E82
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D57FC10;
	Sat, 20 Jan 2024 14:46:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A8FBEB;
	Sat, 20 Jan 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705761980; cv=none; b=tTMP0PYwqYVFUZ4GPBFPUZHvr0bGBmbrQVW32Msyac3BZit5AjfZkdpXfGmqyV7/2TpKaAbb1caO1+nh9e5TafDVK93wu8RVbzgy0bz+7A8wiROEARnFeheSQXhkElCDfr2NLkoRYUhSKcG2JJh4SgHoSP7dkr1JFunD7uWH4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705761980; c=relaxed/simple;
	bh=QU3FgwJ/0Ld1Hp6t3egT5lYDEqBT49cETqdT5eeFNXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oSQIWODCknyS5DRk8pBybKQv2ijADTCnwm3aZn4eLxkmAdhg0BFWQsPRvL97B9VXPmixgT7vJertGWd3XyNGKmDV97XdzHnjP5yWbI79ZY4/T8pq7khrZizXlPePl0GkLi5xsDHCqFNHW97vdnE41GBZoDLYGLrGcCYYc6h6xAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rRCbv-00079k-WC; Sat, 20 Jan 2024 15:46:16 +0100
Message-ID: <ae81abbb-3a7b-46a4-851e-455c0dfee078@leemhuis.info>
Date: Sat, 20 Jan 2024 15:46:15 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.7 regression] [BISECTED] 28270e25c69a causes overallocation of
 metadata space
Content-Language: en-US, de-DE
To: linux-btrfs@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <9cdbf0ca9cdda1b4c84e15e548af7d7f9f926382.camel@intelfx.name>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <9cdbf0ca9cdda1b4c84e15e548af7d7f9f926382.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705761978;8e1b9815;
X-HE-SMSGID: 1rRCbv-00079k-WC

On 17.01.24 07:04, Ivan Shapovalov wrote:
> Hi all,
> 
> Starting from v6.7 I've noticed severe overallocation of metadata space
> on both of my btrfs root filesystems (both NVMe SSDs, both use
> snapshots):
> 
> ```
> # mount | grep -w /
> rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=<...>
> 
> # btrfs fi usage /
> <...>
> 
> Data,single: Size:550.00GiB, Used:497.12GiB (90.39%)
>    /dev/mapper/root      550.00GiB
> 
> Metadata,DUP: Size:72.00GiB, Used:8.38GiB (11.64%)
>    /dev/mapper/root      144.00GiB
> 
> <...>
> ```
> 
> Running a full metadata balance (`btrfs balance start -m /`) or a
> "staged" balance
> (e. g. `for u in {0..90..5}; do btrfs balance start -musage=$u /`)
> does not help / makes the overallocation worse.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 28270e25c69a
#regzbot title btrfs: severe overallocation of metadata space
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

