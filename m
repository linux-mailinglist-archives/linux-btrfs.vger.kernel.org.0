Return-Path: <linux-btrfs+bounces-1567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE503832600
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 09:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E711F23895
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2822087;
	Fri, 19 Jan 2024 08:55:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9901DDC3;
	Fri, 19 Jan 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654520; cv=none; b=pAwB1C0WDJ0gO19WFgSsIbt2RLbP/aJkI3zClR9YsLWrPCmVn7PqVm0CbHVWMA16yBNq2Pn2CLm2nCHHLHOYKfhsIJ7uvv1H9UFyyFzFICN+nl2ASijedXuet/Qhv5K3EOSdS7DGcDhddypNar73GH41dYPRlBjWlWoZnkEYwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654520; c=relaxed/simple;
	bh=+R/lQMLSXdFLtudwYkMQlXMERsykxGaEK7YzpgFiN4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reg6CtCUINQLLHgbpxEw0Bkx//NWYwVgmFqHoPxL8WnSda4ob1EoZVXnyA+Bii2iSxXvlIO1Op+6DbV0cVXTmn87I3Xr2IZgX8QwOVPlDyWN2CI3/9BPyMLvp6wbWso5yiikHlnLZz5WDY41Ub7enHGdJHj56p2M4EUBpU0hq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rQkec-0001GU-Um; Fri, 19 Jan 2024 09:55:11 +0100
Message-ID: <02c0a0c9-91b7-4766-9c15-8059b8e7c09d@leemhuis.info>
Date: Fri, 19 Jan 2024 09:55:08 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Disk write deterioration in 5.x kernel
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>, Gowtham <trgowtham123@gmail.com>,
 Linux btrfs <linux-btrfs@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
References: <CA+XNQ=j6re4bhRDUebzPLDvMtZecqtx+GRRPgpd9apss+vOaBg@mail.gmail.com>
 <CA+XNQ=hGxYsMAo6Gc+Up5QctbWjkER17uK97YXWc9uyx_7+3uw@mail.gmail.com>
 <ZaodrO8QjCqSXPHe@archie.me>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZaodrO8QjCqSXPHe@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705654518;90d12ab1;
X-HE-SMSGID: 1rQkec-0001GU-Um

On 19.01.24 07:58, Bagas Sanjaya wrote:
> [also Cc: btrfs maintainers]
> 
> On Fri, Jan 19, 2024 at 09:37:50AM +0530, Gowtham wrote:
>>
>> Is there anything I can collect to debug what is the problem in the new kernel?

From the version numbers you provided it seems you are using vendor
kernels containing patches. You thus might want to ask the vendor for
support. Most upstream developers are unlikely to help and some even
complete ignore reports using such kernels.

You also need to try latest mainline and bisect, as Bagas already
pointed out, as that problem might be solved already and might have
nothing to do with Btrfs at all.

> Please don't top-post, reply inline with appropriate context instead.

Bagas, FWIW, I think telling users this is not helpful at all and maybe
counter productive; please consider to stop doing this.

Yes, kernel development uses inline replies -- hence it's a good idea to
point that out *to developers* that submit patches et. al.

But most people in the world uses top-posting; you and I might not like
that, but that's how it is. Telling non-developers to adjust their
behavior to our habits will often just come over as rude. It might
nevertheless be worth it. But it's best to leave that decision to the
developers that handle the report, as they have to interact way more
with the reporter that you or I will have to.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

