Return-Path: <linux-btrfs+bounces-3195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D328788DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 20:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910D52813B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 19:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829925644B;
	Mon, 11 Mar 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="3E3aDg3p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB056458;
	Mon, 11 Mar 2024 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185009; cv=none; b=CEu8dBRLB119SAJfSSHleIQmTuEtX4HT39+4JR1Nswi/oXI708ZqqW8s09uW1VFM2dKCUFUaBZ8WbhMzeJ4nGmnLay6zJX1TvQt9e21fNn3h4kAkve3xSn3YEutNJH3MZ01q67HmMj187ZehrUdjs9MDqBFjwKn0/Wmud8TIDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185009; c=relaxed/simple;
	bh=mXOkelzSlNTD9YLjdJ0mWOyIRK64Ws4HhM9c4k9sdsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRcAWEaGoHBNuRUYL+XuR1587SxPPI4pyh1k+aqfxcbFKKebNXposoQPfwLdxgAuPSbE0eJImRS5jG5mbw+Iy5lNG3VYc9YL8BW407s9h469hy8A+Y/GDx0mP7N4O4WP4VhytSgbeFtvciAGNVcdXp71Q9eWcgiQOl484ebFQw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=3E3aDg3p; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=7+duhrutayVk1vYmksu3mizx9qnNZWt/qaKHFxBPqNA=;
	t=1710185007; x=1710617007; b=3E3aDg3pf75JhbJ8lHybGYNJ6IMx03vX8wVM5znUit/P79j
	wrPxX3IY6F/d/dj6LXNZAYIhrSKwUtU5P46rEAE5buXoAcC5x0TeZHFVt3+GT2I07oVjdtk2wyFEh
	IFBqw773Kwbyz95ddK0HWj6qVidxBh1F1uDv4zuxlFAiHE7uihIMB+v1OSR/CHZkXaTnLnb9f0+4G
	Q2d/Btgd8DIRzBO2qRop4zGYvj47sYOL4AiKBgZeZxCY4qSCDVSWj/peVa1SzoqOzAVdlgz5hUnxi
	21/gmqz25G+W8zcMZRiwUbvUHyKn7+XU3+kgYRRRlyaBwNlIMtdwuAOrGAyrndTQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rjlF6-0000WJ-IH; Mon, 11 Mar 2024 20:23:24 +0100
Message-ID: <d9d46e16-ae73-4495-98a4-ab08ac501132@leemhuis.info>
Date: Mon, 11 Mar 2024 20:23:23 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 001/162] btrfs: fix deadlock with fiemap and extent
 locking
Content-Language: en-US, de-DE
To: dsterba@suse.cz,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
 stable@vger.kernel.org, patches@lists.linux.dev,
 Josef Bacik <josef@toxicpanda.com>, Sasha Levin <sashal@kernel.org>,
 Chris Mason <clm@fb.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
 <20240304211551.880347593@linuxfoundation.org>
 <CAKisOQGCiJUUc62ptxp08LkR88T5t1swcBPYi84y2fLP6Tag7g@mail.gmail.com>
 <da17e97b-1880-415d-8cdb-07e79808e702@leemhuis.info>
 <20240311184108.GS2604@twin.jikos.cz>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240311184108.GS2604@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710185007;aaf5e701;
X-HE-SMSGID: 1rjlF6-0000WJ-IH

On 11.03.24 19:41, David Sterba wrote:
> On Mon, Mar 11, 2024 at 10:15:31AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 06.03.24 13:39, Filipe Manana wrote:
>>> On Mon, Mar 4, 2024 at 9:26 PM Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> 6.7-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> It would be better to delay the backport of this patch (and the
>>> followup fix) to any stable release, because it introduced another
>>> regression for which there is a reviewed fix but it's not yet in
>>> Linus' tree:
>>>
>>> https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@suse.com/
>>
>> Those two missed 6.8 afaics. Will those be heading to mainline any time
>> soon?
> 
> Yes, in the 6.9 pull request.

Great!

>> And how fast afterwards will it be wise to backport them to 6.8?
>> Will anyone ask Greg for that when the time has come?
> The commits have stable tags and will be processed in the usual way.

I'm missing something. The first change from Filipe's series linked
above has a fixes tag, but no stable tag afaics:
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=for-6.9&id=978b63f7464abcfd364a6c95f734282c50f3decf

So there is no guarantee that Greg will pick it up; and I assume if he
does he only will do so after -rc1 (or later, if the CVE stuff continues
to keep him busy). As Filipe wrote "can actually have serious
consequences" this got me slightly worried. That's why I'm a PITA here,
sorry -- but as I said, maybe I'm missing something.

The second of the patches has none of those tags, but well, from the
patch descriptions it seems that is just a optimization, so that is
likely not something to worry about:
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=for-6.9&id=1cab1375ba6d5337a25acb346996106c12bb2dd0

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

