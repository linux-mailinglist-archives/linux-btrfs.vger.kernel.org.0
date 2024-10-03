Return-Path: <linux-btrfs+bounces-8514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B039598F591
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 19:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574FF1F2514A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03FA1AAE31;
	Thu,  3 Oct 2024 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hixontech.com header.i=linux-kernel-bugs@hixontech.com header.b="DXKfSwHc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922A1AAE00;
	Thu,  3 Oct 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977794; cv=pass; b=JTzBE+0JSw0p2EWe+j6zVzQMWmlIvfMMHWqzBgZo1uD7puu5xy/WC+o6qHxWtGprwN3DUibfjcifNrHm9DvxrhNIl947H82TE6r93pGoeUyh4qv+gcgn7sjhB4hPDsw02CWEkqdvwd82wn2T95QspZxMv/cS0tHm+QZw7d1p8uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977794; c=relaxed/simple;
	bh=hR+e9OePYExvP7EAJ37urcVKISLWEHPPc8qnvYj/dC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bz1GBKeZJpL68z1fcmFVNNvglVhw0V3+S7lSUTEM9xRXpzLNRLKwDa7HGcIKJBRnbxDTLfSzdiD1Q9iY4ITv0iuCujZODdCCh6UfEJPHLTlWTXko5K2vvFYf6biPRemXik4mJyndOy22+ElpdRZXEKD1IbjuzG/LAiMKUrQI5kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hixontech.com; spf=pass smtp.mailfrom=hixontech.com; dkim=pass (1024-bit key) header.d=hixontech.com header.i=linux-kernel-bugs@hixontech.com header.b=DXKfSwHc; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hixontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hixontech.com
ARC-Seal: i=1; a=rsa-sha256; t=1727977769; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SM7zHObONjfOGxTVyBdB92QGHoZf8cIKyrR21kXVFsKgvLp8KZgdaJ204n9iKrRWcwnNLKH2PAhW4p6+TmaNVs7Kk1ajYHNpR6H0yZQrPMHlwcvUMR5LmdCjFXmC5oxHAXzPtfejLlfk7nZ5vElmWP2BhgMXNcudwRUrGb757a0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727977769; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Reply-To:References:Subject:Subject:To:To:Message-Id; 
	bh=kkUScEqJNg9brIJOi0NUV5FRWLz61DIRBIQvF/UZTqQ=; 
	b=U6MBgqV4UmI9ApNvWDdqkmPM5n0ZHoNSdvmB52icRBd7CrzOCM0PfWxIgYKZiwyt/D+coUrEWlLi2xGQMVxCK3EUPfyBCb00yB+dts4LOfeN0177b4QuV/qyDv03/qCmw4ROoNFh80/2X0oPZ98PQu/WVBF06HE74sZATYyuDjo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=hixontech.com;
	spf=pass  smtp.mailfrom=linux-kernel-bugs@hixontech.com;
	dmarc=pass header.from=<linux-kernel-bugs@hixontech.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727977769;
	s=zoho; d=hixontech.com; i=linux-kernel-bugs@hixontech.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:Reply-To:Reply-To:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id;
	bh=kkUScEqJNg9brIJOi0NUV5FRWLz61DIRBIQvF/UZTqQ=;
	b=DXKfSwHcOD7UIFp+KXqaKMtWuBC3eDoWY9R2L6t2Cdmomz8dNim8L9q7ca5b4Jtf
	uoXUR6CImcZPS4EYNpV9Xv8GiA2kvyUJPXwqEN07MF6yn7vvnt15CH/N0fxLcV56G+F
	uZdxuLvUHu1Oga/S8GqImd7IiMw5zTHTjQ8LPonQ=
Received: by mx.zohomail.com with SMTPS id 1727977767705568.6452099080866;
	Thu, 3 Oct 2024 10:49:27 -0700 (PDT)
Message-ID: <58fac815-e630-4ece-9dba-18dc255a0d1b@hixontech.com>
Date: Thu, 3 Oct 2024 11:49:25 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [regression] AMD SFH Driver Causes Memory Errors / Page Faults /
 btrfs on-disk corruption [Was: .../ btrfs going read-only]
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 akshata.mukundshetty@amd.com, LKML <linux-kernel@vger.kernel.org>,
 Skyler <skpu@pm.me>, Richard <hobbes1069@gmail.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <90f6ee64-df5e-43b2-ad04-fa3a35efc1d5@leemhuis.info>
 <3a9b2925-57fb-4139-8cf5-a761209c03cc@hixontech.com>
 <056770ff-90e6-4140-b964-862a1503fa3b@leemhuis.info>
From: Chris Hixon <linux-kernel-bugs@hixontech.com>
Content-Language: en-US
Reply-To: linux-kernel-bugs@hixontech.com
In-Reply-To: <056770ff-90e6-4140-b964-862a1503fa3b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/2/2024, 6:29:59 AM, "Linux regression tracking (Thorsten Leemhuis)" wrote:
> [CCing Richard, who apparently faces the same problem according to a
> recent comment in the bugzilla ticket mentioned earlier:
> https://bugzilla.kernel.org/show_bug.cgi?id=219331#c8
> 
> CCing Mario, who might be interested in this and is a good contact when
> it comes to issues with AMD stuff like this.
> 
> CCing the Btrfs list as JFYI, as all three reporters afaics see Btrfs
> misbehavior or corruptions due to this.
> 
> Considered to bring Linus in, but decided to wait a bit before doing so.]

This patch from Basavaraj Natikar seems to solve the issue for me:

https://lore.kernel.org/linux-input/20241003160454.3017229-1-Basavaraj.Natikar@amd.com/

Tested-by: Chris Hixon <linux-kernel-bugs@hixontech.com>


My original report:

https://lore.kernel.org/all/3b129b1f-8636-456a-80b4-0f6cce0eef63@hixontech.com/

Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>


Thanks!

> 
> On 01.10.24 23:40, Chris Hixon wrote:
>> On 10/1/2024, 12:56:49 PM, "Linux regression tracking (Thorsten Leemhuis)" wrote:
> 
>>> Basavaraj Natikar, I noticed a report about a regression in
>>> bugzilla.kernel.org that appears to be caused by a change of yours:
>>>
>>> 2105e8e00da467 ("HID: amd_sfh: Improve boot time when SFH is available")
>>> [v6.9-rc1]
>>>
>>> As many (most?) kernel developers don't keep an eye on the bug tracker,
>>> I decided to write this mail. To quote from
>>> https://bugzilla.kernel.org/show_bug.cgi?id=219331 :
>>>
>>>> I am getting bad page map errors on kernel version 6.9 or newer.
>>>> They always appear within a few minutes of the system being on, if
>>>> not immediately upon booting. My system is a Dell Inspiron 7405.
>> [...]
>>>> [   23.234632] systemd-journald[611]: File /var/log/journal/a4e3170bc5be4f52a2080fb7b9f93cf0/user-1000.journal corrupted or uncleanly shut down, renaming and replacing.
>>>> [   23.580724] rfkill: input handler enabled
>>>> [   25.652067] rfkill: input handler disabled
>>
>>>> [   34.222362] pcie_mp2_amd 0000:03:00.7: Failed to discover, sensors not enabled is 0
>>>> [   34.222379] pcie_mp2_amd 0000:03:00.7: amd_sfh_hid_client_init failed err -95
>>
>> No sensors detected - do we all have that in common?
> 
> Skyler, Richard?
> 
>>>> [...]
>>> See the ticket for more details and the bisection result. Skyler, the
>>> reporter (CCed), later also added:
>>>
>>>> Occasionally I will not get the usual bad page map error, but
>>>> instead some BTRFS  errors followed by the file system going read-only.
>>>
>>> Note, we had and earlier regression caused by this change reported by
>>> Chris Hixon that maybe was not solved completely:
>>> https://lore.kernel.org/all/3b129b1f-8636-456a-80b4-0f6cce0eef63@hixontech.com/
>>
>> This looks like the same issue I reported.
> 
> And sounds a lot like what Richard sees, who also sees disk corruption
> with Btrfs (see https://bugzilla.redhat.com/show_bug.cgi?id=2314331 ).
> 
>>> Chris Hixon: do you still encounter errors, or was your issue
>>> resolved/vanished somehow?
>>
>> I still encounter errors with every kernel/patch I've tested. I've blacklisted 
>> the amd_sfh module as a workaround, but when the module is inserted, a crash
>> similar to those reported will happen soon after the (45 second?) 
>> detection/initialization timeout. It seems to affect whatever part of the
>> kernel next becomes active. I've had disk corruption as well, when BTRFS is
>> affected by the memory corruption,
> 
> Skyler, did you see btrfs disk corruption as well, just like Chris and
> Richard did?
> 
>> so I've ended up testing on a USB stick I
>> can reformat if necessary. I haven't tested new patches/kernels in a while
>> though. I'll get back to you after I've tried the latest mainline. Also note
>> that I've tried Fedora Rawhide's debug kernel,
> 
> From what I see it seems all three of you are using Fedora. Wonder if
> that is a coincidence.

Note: I don't think it's a Fedora issue. I've had the problem on multiple
distros, with any kernel >= 6.9 - anything with the "bad" commit.
 
>> which has a ton of debugging
>> options including KASAN, but nothing seems to point the finger at something
>> originating in amd_sfh code. Is it possible the hardware itself (the mp2/sfh
>> chip) is corrupting memory somehow after some misstep in
>> initialization/de-initialization? Also if you look at my report, you'll see I
>> have no devices/sensors detected by amd_sfh - I wonder if other reporters all
>> have this in common? (noted in dmesg output above from another user)   
> 
> Given that Basavaraj Natikar never really addressed Chris earlier report
> from months ago and the severeness of the problem I'd wonder if we
> should revert the culprit to resolve this quickly, unless some proper
> fix comes into sight soon. Sadly from a quick look that would require
> multiple reverts afaics. :-/
> 
> Ciao, Thorsten
> 


