Return-Path: <linux-btrfs+bounces-8478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3098E6B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 01:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD011C21008
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 23:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75219D09E;
	Wed,  2 Oct 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="Q3K7HMw7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055748286A
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911146; cv=none; b=CRlb5+Lgn3Ery6Cpc58o9pEHnxXpRgDIa+CqciydgGKYdIWH96Ibjr9lj25B+5KLVeM8uJ/mPhR9W7h0qHFlxVnwDUPEdxwICSgcRIuflxOZJYfcgiiLHfJQftNGM0P1pKFZqfhMIl+sUdKCVlKJHCBZ2eGbWPx21XAUk3km7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911146; c=relaxed/simple;
	bh=LwFcFCOPjFuuYAHMi0sHuP0YgQeid4vseeI3N88OJjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bCFfVyzJtirtl7PtXmrYFJROnpXzQ+oaFRof19bI+Uy2f1At40utsEDw5YLG7pLEC7pIPV4PkKE1bFSueAfmcbPyKxvrRZw+Xvaa3oozgewluW67zBgUxVn53BW3+f4IHMlKdD/wpHM2BxmNNPM8AICiea+by8KKuNzHpsi2JWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=Q3K7HMw7; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nkODDfQ4joIB8kzWi6CVntdUwPxA68IkYKXXuGuVO5k=; b=Q3K7HMw7s+prFnc8adIXrZ3CkX
	9v/lG1UIyVAP3e7dqD3a87hs+uzekLqZSsuvGseymNrPoru9P8+MDVhEJFeq55tweiFdpeB8mTRMY
	Ki6UU1n4KEr0lfmxijnNsiB5PsOemmn6iQVaYT3jJgsyIUQ4jAq/sk3tuZDdD+RtpLQUeJoDkQNqx
	hQyMXZQnlUzlldhQ+hK0zRX5EfS0Io9DIPRdfR3aVxfrOEkgbNdjKkVBrvmJG8CbFRBqTNbOHQ/FD
	2/5FbrY6Ot2EKwuNMdYtSe1xokEnSuAUpAf0uE0xIxk8mAJ6J82SdbwplXTLqoIDN//WtvyCnKOH9
	0fB7Q+3A==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1sw8cT-0003iA-6n
	for linux-btrfs@vger.kernel.org; Wed, 02 Oct 2024 23:18:57 +0000
Message-ID: <b5b3df31-627a-403c-af4d-7495e7c28bad@zetafleet.com>
Date: Wed, 2 Oct 2024 18:18:56 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS list of grievances
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
 <20240927212755.5b24ecd4@nvm>
 <03de7723-0be2-a153-d264-a1024be3c2b8@georgianit.com>
 <28059007-9d87-458d-ab4e-a498977d8268@zetafleet.com>
 <b33797e4-476f-4719-90ae-87218079499f@app.fastmail.com>
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
In-Reply-To: <b33797e4-476f-4719-90ae-87218079499f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001 autolearn=ham autolearn_force=no version=3.4.2

On 02/10/2024 14:31, Chris Murphy wrote:
> On Fri, Sep 27, 2024, at 3:01 PM, Colin S wrote:
>
>> Furthermore, if a lost device ever mounts rw on its own, it will cause
>> permanent split-brain, because btrfs doesn’t track lost devices so will
>> happily rejoin all devices again later.
> RW degraded mount makes transid ambiguous. There isn't a timestamp in the super, so we can't use that to help disambiguate matching or similar transids on multiple members that were mounted rw degraded.
>
> One idea I had is a "mounted degraded" flag that would cause the kernel to do some logic to prevent rw mount that will cause the split brain problem. i.e. do not permit the mount of a file system when 2+ devices present have the degraded rw flag set. Perhaps not even RO, I'm not sure.
>
> Would such a flag need to go in the super though? Or could we just make such a thing an item in the device tree? And for that matter, add fs create time, and the last mounted and unmounted times in device tree?

I suspect I may be missing something important because I am no FS expert 
and md-raid doesn’t appear to do this exactly, but I can’t think of a 
case where it doesn’t work to have a simple per-device bitmap that says 
which devices have up-to-date writes, from the perspective of each 
device. Using a bitwise-AND across all visible device bitmaps, whichever 
bits remain set must be the good device(s) because they were always seen 
by all devices as never having missed a write. If the bitwise-AND 
results in 0, then there is a split-brain, because it means each device 
saw some other device miss a write. When a lost device reappears, set 
its own up-to-date bit to 0 until it is recovered, and from there I 
think the existing btrfs-replace mechanism can be used to ‘replace’ the 
lost disk with itself.

> We also need a partial scrub, i.e. start a scrub from a certain point so that not all data and metadata needs to be read. Write intent bitmap would help do that but can we infer a write intent bitmap via transid?

Whether this is possible is beyond my knowledge level. This patch from 
2022[0] says some thing about why not btrfs btree, but I don’t know if 
that is talking about some implementation detail, or if it is saying 
that what you suggest is a fundamentally unsound approach. Either way, 
my understanding is that the write-intent bitmap is important to reduce 
the time/resource impact of a failure, but is not strictly necessary to 
solve the data corruption problem; doing a full device scan and updating 
mismatched blocks would be sufficient, just slow. (I think checksums 
cannot be used safely here due to the collision risk.)

> We really need some things in place with automatic degraded recovery and device readd before we could ever figure out how to have unattended degraded boot (for the 10 people on earth who want this - bad but funny joke). Right now we can't set degraded mount option persistently because split brain. And we can't even try to mount when not all devices are present because mount will fail (without degraded mount option). Therefore there's a udev rule in place to not even try to mount during boot if not all devices are found. Indefinitely waits. Kinda annoying!

I may be just repeating/agreeing with what you are saying, but just in 
case, most of the time a degraded mount will not result in split-brain, 
and in the case of a split-brain I don’t believe there is ever a safe 
way to automatically choose which one might be the right one for a 
degraded mount, so btrfs should not try. Timestamps would not account 
for errors during hardware recovery, like rw-mounting the wrong device 
and writing to it inadvertently. So long as btrfs does not try to rejoin 
split-brain then the user could take action to restore the correct half.

Thank you for sharing your thoughts, and I hope this is the start of a 
solution for this issue.

Best,

[0] 
https://lore.kernel.org/linux-btrfs/bd94acc1-5c1d-203b-8523-e6986206b267@suse.com/T/

