Return-Path: <linux-btrfs+bounces-3248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BB687A89E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 14:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BAF1C21F69
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AA41757;
	Wed, 13 Mar 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="RS4frlmb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067040872;
	Wed, 13 Mar 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337356; cv=none; b=lu9mr8lMxkbfoI2PqF05mhjN3cNFIBWkkq6SNHJW0RdqaTSEmbbbFNRouthImEAQc7FZ3hXJY71YbWpKFCkP5C/U7urYZzFmi4c+iOHQ65S+ZSLSMJUyIcXQQESGp6Hm7VyzK+d4rf1VnuuSztPgPbc5oeo/nsBMj2rgoGL/0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337356; c=relaxed/simple;
	bh=UyOhCjSML0VfOog5YATAYY8b1aciv63c9TKupf5crvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ktak511zW/hZFYsGtFJRxHL+Eu5bLlztI+oZiScVQ/RpE19/0EcI80WntRueNPGGeslfwTw15CvdbNXwCSwp7+bRVevYEsBO2SgCO4fXgEIf1LbmgdZVG1HJqrVvag3v9cAcNPBvCEbbcfj1vNoA2rKdinopSj8jAFTIf1kmko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=RS4frlmb; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Y3oMhcZME0r0444aBXodVZ/n3VCs9nbwgGmgbmvNTYI=;
	t=1710337353; x=1710769353; b=RS4frlmbol/P6bE3Sn+42G0oFr8eu4XhdYbqfP+M2RaF0eC
	p6Umntr/gz4QNjVu41Xv7bCWWW+ha6mu0E0V18FlvfzSql5A3LolrTaD7kCzz1pH9rOai/ZptWyfX
	UI0/GAYh0+1GvngLFlRHELS/MO7eyjgk859/B2SfXnrYq21c3VOwzB76jJVQOuNMTObH574fkZvPY
	K9/5BldsDrA6TnNtPylcaQwaQIJ/giwf5wATDflJA/HWAhTZ2SlFkeSL9/ClfPxKSyR/ZBOov8liq
	DL8NLRPHEPki68/ClUYY94XGOES8REsiO6XuJypUgVePCtYBZwanuua6K8QevapA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rkOsI-0001T5-O0; Wed, 13 Mar 2024 14:42:30 +0100
Message-ID: <5f7b720c-3516-42b2-826c-68fb5ba18353@leemhuis.info>
Date: Wed, 13 Mar 2024 14:42:29 +0100
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
To: Filipe Manana <fdmanana@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dsterba@suse.cz, Filipe Manana <fdmanana@suse.com>,
 David Sterba <dsterba@suse.com>, stable@vger.kernel.org,
 patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
 Sasha Levin <sashal@kernel.org>, Chris Mason <clm@fb.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
 <20240304211551.880347593@linuxfoundation.org>
 <CAKisOQGCiJUUc62ptxp08LkR88T5t1swcBPYi84y2fLP6Tag7g@mail.gmail.com>
 <da17e97b-1880-415d-8cdb-07e79808e702@leemhuis.info>
 <20240311184108.GS2604@twin.jikos.cz>
 <d9d46e16-ae73-4495-98a4-ab08ac501132@leemhuis.info>
 <CAL3q7H7kZkTMfzb0Xg_m1EbNyjj1eqqs4m=ovHM80MqCCCD7gw@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAL3q7H7kZkTMfzb0Xg_m1EbNyjj1eqqs4m=ovHM80MqCCCD7gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710337353;0a49aaee;
X-HE-SMSGID: 1rkOsI-0001T5-O0

On 11.03.24 21:06, Filipe Manana wrote:
> On Mon, Mar 11, 2024 at 7:23 PM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 11.03.24 19:41, David Sterba wrote:
>>> On Mon, Mar 11, 2024 at 10:15:31AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 06.03.24 13:39, Filipe Manana wrote:
>>>>> On Mon, Mar 4, 2024 at 9:26 PM Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> 6.7-stable review patch.  If anyone has any objections, please let me know.
>>>>> It would be better to delay the backport of this patch (and the
>>>>> followup fix) to any stable release, because it introduced another
>>>>> regression for which there is a reviewed fix but it's not yet in
>>>>> Linus' tree:
>>>>> https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@suse.com/
>>>> Those two missed 6.8 afaics. Will those be heading to mainline any time
>>>> soon?
>>> Yes, in the 6.9 pull request.
>> Great!
>>
>>>> And how fast afterwards will it be wise to backport them to 6.8?
>>>> Will anyone ask Greg for that when the time has come?
>>> The commits have stable tags and will be processed in the usual way.
>
>> I'm missing something. The first change from Filipe's series linked
>> above has a fixes tag, but no stable tag afaics:
>> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=for-6.9&id=978b63f7464abcfd364a6c95f734282c50f3decf
> 
> It has no stable tag because when I sent the patch there was yet no
> kernel release with the buggy commit

Obviously, no need to explain, the discussion got unintentionally
sideways after David mistakenly said "The commits have stable tags
[...]". Happens, no worries.

>> So there is no guarantee that Greg will pick it up; and I assume if he
>> does he only will do so after -rc1 (or later, if the CVE stuff continues
>> to keep him busy).
> 
> Don't worry, we are paying attention to that and we'll remind Greg if necessary.

Thx. But well, for the record: I would really have liked if you or David
would simply have just answered my earlier "And how fast afterwards will
it be wise to backport them to 6.8?" question instead of avoiding it.
Just knowing a rough estimate would have helped. And I guess Greg might
have liked to know the answer, too. But whatever.

Side note: I'm here to "worry". It's not that I don't trust you or would
ask Greg behind your back to pick the patches up. It's just that we are
all humans[1]. And regression tracking is here to help with the flaws
humans have: they miss things, they suddenly need to go to hospitals for
a while, they become preoccupied with solving the next complicated and
big bug of the month, or just forget something they wanted to do because
something unexpected happens, like aliens landing in a unidentified
flying object. And from all the regressions I see that are not handled
well and the feedback I got it seems doing this work seems to be worth it.

Ciao, Thorsten

[1] at least I think so...
https://en.wikipedia.org/wiki/On_the_Internet,_nobody_knows_you%27re_a_dog
:-D

