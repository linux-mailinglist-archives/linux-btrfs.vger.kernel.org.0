Return-Path: <linux-btrfs+bounces-18752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8019EC39120
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 05:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26C494EF2CD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 04:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9140D2BD582;
	Thu,  6 Nov 2025 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="JDKL0/Un";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3Rkmp6T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3CF34D3A3
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402545; cv=none; b=qENwEFg7S0Pkw0BLiU71Yh522yBM9yszGiwbdTchM5g74dYzbwKeD2yFTCzmCfEeYo83gKXip44y7BVbnhqp/MuzsMZX/lugWigIMKjZc5QjiGQz8C13sKaGa+ZjzHTOoZ4loVBWNZ50em4tUSP24KtET0M4UF3qaQnJc2ZVi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402545; c=relaxed/simple;
	bh=wu8Jm4yKqJAHdzJV67s5nWVFgQ8rzVOoswryiiAT72s=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aO1In4iIL/Ru89dYh0PBkc2uxXHmJaRFLogO2qX2zQhyt25Ubk+c9SA5wjCEAgL6KeycoN430Ikr5OBZVsLj3ooLufG9nqmYJaKYMWF85GUsjgB3irzjk6IX4GP5kSRvtKzyy5cyDnQecyuiH5bO5yIyMaVnZb63zix5pmj7VzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=JDKL0/Un; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b3Rkmp6T; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D33F714001BA;
	Wed,  5 Nov 2025 23:15:41 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 23:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1762402541; x=1762488941; bh=e1IgRGzOEZuWp2/p0J7Ib
	dG6GeicTtHqGlPCXDbMXvg=; b=JDKL0/UnAnoQYJNRnOtZtojNEo4dJyNkE7pGU
	th6OaV1tXUdYvwx/jCzo1i2UbQl6eUPsIXgOSGWyoMZCsETP+xGmo7/5zH2HUSil
	CYqxKcuxj3DRM3xa459sqn8umAnHfR7Dz8ZHoSpzVJkAZeZ/4iIMikDE6hJNg9Bx
	OLiU0sFn1acct2LsT1lKdvnayHTGUjNupMgJ5wIQ6r2Zw0G9edvxrBvmXf48TmW6
	17ZROoORii4PclguI8v2YeP2SkV0EOijUChzkayOhDC3HHWFvmKHk8hWkOA2cE6N
	a9vaor/o8rF5KzW/tga5DQ5pQDyO1ojEAfylblYiY0Yy7iHww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762402541; x=1762488941; bh=e
	1IgRGzOEZuWp2/p0J7IbdG6GeicTtHqGlPCXDbMXvg=; b=b3Rkmp6Tc77nvAAPv
	N/q3tQLwWcCsfPY5Xpqujd3DYE1IqcSYScxqagooKqUMJpZw2whLIGq/mwE4/6z7
	bGm/NSNZIgZwKiMVcJfkWWZS+uASZtHzkjvkDxne0ZMf3xKfLNXJcPJd0CRBM7FP
	6SdqU/X7C8hS0dr/+9i/5iXhFb3W/kuUDhsJMuERS4nJqvhXQdWYOXc5RmwpebMu
	78yNmhPEwocKBEfSkqN3y8GaH+9D96bR2CO8wz9M6IWytyefTYQKOHcCngLJLAL3
	hw00u2ThdBlssVTSYZQVkrz417lzHV5v8PGYZ+3wELKJNM7EbZU0eK9vOMu+TLvb
	P2+Lw==
X-ME-Sender: <xms:7SAMaSC8zwaYddgLnOrbJgZt-7x9JaXZ9hoEF4xRoCcG6jZ85h_Rtw>
    <xme:7SAMaXWthpKVR4QCMimLeYorcMEGm0Yi9BlUf2RLfB63l77juDkPpl1nbFsFG7jZO
    TUw-v5rFHWFOAsGehPge-gWBAAlAKOfySV-o9xOf6qspYuGc6orsDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepteefudehkeehgeekhfdvgefhjedvveeuhfdtgfejgfevieev
    iedvfedvhfevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvnhgurhhikhesfh
    hrihgvuggvlhhsrdhnrghmvgdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7SAMaUtrAZQeJsgDmNCG26zfjO0sebnaXh2iMq6wJLaQMpyRnn7eVw>
    <xmx:7SAMafZZ_mXIq5imrqn9bQ46AW3ezjvxX3E1J_G_v7-cQGkcf_mFqw>
    <xmx:7SAMaXXPrR7bJRK4R8D6GVKsom0eskru7iiHvtXQoLmmsILivjyyiQ>
    <xmx:7SAMaT5e2IvjxGpvokMXGQ4P8D3WG2QDpjREBeY5lq55M3Wx6SB2Nw>
    <xmx:7SAMaVz3pHFqPFK9cz3EbJOp0MRqjGGXU2jDexUMzOl-VkwS0HqVySoV>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8319218C004E; Wed,  5 Nov 2025 23:15:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVMxPOgRNBic
Date: Wed, 05 Nov 2025 23:15:21 -0500
From: "Chris Murphy" <lists@colorremedies.com>
To: "Hendrik Friedel" <hendrik@friedels.name>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <27964904-b200-46d1-87c6-0dc5d8174036@app.fastmail.com>
In-Reply-To: <eddf3273-d7f9-4bef-865d-dfec1d7ffb66@friedels.name>
References: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
 <12716866-2ffe-4cbb-8e2f-8b2e4abd0237@app.fastmail.com>
 <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
 <f6858f97-1fe2-49d7-b1ad-dc688142fdcb@app.fastmail.com>
 <eddf3273-d7f9-4bef-865d-dfec1d7ffb66@friedels.name>
Subject: Re: Corrupt Filesystem (Mirror) despite previously successful scrub
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Nov 4, 2025, at 5:50 PM, Hendrik Friedel wrote:

> It was. This is because I do not need this Filesystem anymore. But I am 
> a bit worried now that I had corrupt data before.
>
> The history:
>
> 1) I did run this as my main home-server until two weeks ago.
>
> 2) I copied all data over to another, new machine
>
> 3) I want to use these drives in that new machine as (onsite) backup
>
> 4) I do have an offsite backup
>
> The problem is: If my data has been corrupted earlier - before two weeks 
> ago - then the data on my new machine is also corrupt.

Btrfs doesn't permit corrupt data from getting to user space. So I'm not sure why you think corruption has replicated from this source to a new destination.

What could happen is corrupt files are requested for transfer, Btrfs detects corrupt blocks, returns EIO to user space for those corrupt blocks, and the user space app just inserts holes for those blocks, or truncates the file at that point. So it should be pretty easy to discover from either the destination files having issues OR the journal history will contain btrfs errors for these transfers. Anytime data corruption is detected, Btrfs reports to dmesg with the exact root (subvolume) and inode an offset and block size. There is no reference to path to file in this case.


>> Over 2 million dropped writes on sda1? That doesn't tell us for sure they're missing, they might have gotten fixed later. But it's so many missing writes, that if there is even 1 copy wrong, corrupt, or missing on sdb1 then Btrfs can't fix itself.
> This is what was causing me to be worried.
>> No the file system could be inconsistent.
>
> So, the file system would point to a wrong chunk which in itself has 
> correct data and csum?

It's not likely because the wrong chunk even with the correct checksum would have wrong generation and be rejected, even with an older kernel.


> Why would not the metadata redundancy spot this? Would this be caused by 
> a bug that corrupts both copies (rather than some hardware error)?

The metadata redundancy did spot this and fixed up many of the problems, but like it's millions of errors. It could be one problem with the file system detected millions of times, or millions of problems detected once - it's a very simple counter and you'd have to go through the log from the very start of the problem and look at all of these messages to find out what's going on.

Also the counter doesn't reset itself. You need to use -z option to clear the statistics. It should be zero for all devices all of the time - so if it's not then you need to completely understand and resolve why this is happening.

Btrfs is very good about detecting problems. It's not great at plain language explaining the source of the problem, you have to understand the error messages in context and that usually takes someone with more experience than I do or a Btrfs developer. And most  folks on this list and in #btrfs channel on libera.chat are using mainline or stable kernels and just aren't often committing their memory to older kernel behavior. That's generally the territory of distributions that provide support.

>
> - what could have caused it / what can I do better in future

Manual or automatic detection of errors so you can start troubleshooting sooner. I'm vaguely familiar with nagios for this. It might be overkill for your purposes. 

There's so many errors it's really tedious for anyone to go through them to find out what happened. But for sure both drives dropping writes at the same time is fatal for any setup.

And also keep up to date kernel and btrfs-progs with current stable kernels. Yes it's possible to encounter new bugs but generally a lot more bugs are being fixed than introduced these days.

In my experience, I don't often run btrfs check. I'm not even sure the last time I ran it on all my btrfs file systems. But for all the hardware, during a long qualification phase including intentional and unintentional power failures while doing writes, I would do btrfs check more often to make sure I understood whether the device behavior was correct.

In some cases in which SATA drives were in USB enclosures that cause flush and fua to no longer be honored, I either took the risk knowing there could be a bad outcome during power failure - or I would disable the write cache on those drives.

On drives that don't need the performance, but I care about how much of a pain it would be to have to rebuild them, I tend to preemptively avoid unknown problems (mainly with drive firmware bugs which I have no insight into, they aren't documented, and aren't always consistent, and tend to manifest only right after a crash or power failure) by disabling write cache, turning off logtree, and enabling flushoncommit. This is rare. But so are the drives I use for maintaining long term archive (not merely backups) and don't want to have to rebuild them anytime soon.

Backups are almost throw away. And I have enough healthy and current ones that even if one backup goes bad it's something I can deal with. Fortunately this doesn't happen anymore since I got a good externally powered USB hub, and also the kernel fixed some UAS driver issues with other drive enclosures.



>
> - was my data corrupted before I transferred it to the new machine

I think the data isn't corrupt, I think the file system is inconsistent. What I don't know is whether that means some files are not accessible anymore by the file system, and therefore might be missing in the transfer. So you'd need to check for this.


>
> - is there some bug in btrfs that we could find

I think the most effective use of limited resources is to salvage all the data you can from this file system, to a new file system, using newer btrfs-progs and kernel, and setup periodic manual or automated monitoring for errors.

If the problem is reproducible, and the logs show only one drive is affected by hardware (or firmware) issues, then that suggests a software bug or missing feature. But I do not  think it's worth the time to speculate about an old and EOL kernel. Just do data recovery and move forward.


-- 
Chris Murphy

