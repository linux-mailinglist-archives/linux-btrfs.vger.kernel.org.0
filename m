Return-Path: <linux-btrfs+bounces-8425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F898D344
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 14:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74501C21697
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2641CFECE;
	Wed,  2 Oct 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kgh2kqmq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE0372;
	Wed,  2 Oct 2024 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872211; cv=none; b=HpBFfM68gPvQlqGClzTa8Vx0KJZkUfZXN4J6RVXwwOLEooPkAD/vpP86x4FH57zsbWEcCAaYEWEYohwUnTMrPoxIsdkullSV195EXYHlZMSPdpKvsEstNZau11k/lPFk1A2aFwZGe413Mx+FXIOXlZCEmxSWRMtjvEdgrgQGwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872211; c=relaxed/simple;
	bh=5te1jA6MZJm94aFg74XhdSUmGAaw6U6NUmCvJZ6ELro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTRIGkZLsrEN13VVpmKP3besQes/1l8j0IJLwP8L2eBpAvLzQ5SV3T6zOwyPpV+btdOzEXja40wGiH1EBXD7oszFg2Q0pcGGgZQXtLUDajWeOfpZPw53+dMctbuHqwvbrEvPcn1/OidV0pLV9eBU4gHrIVgcmwm8DfMKbDnI46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kgh2kqmq; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=IykoVkNuqPqaFqRA7nQuLR7DdnoOJ5S/uNaQK0BCEko=;
	t=1727872209; x=1728304209; b=kgh2kqmqecfUcG2dGU71kNc8ArmTEV1wYX1+vzLeMiPS21q
	m4j+ugKlCnB5SMFbdvp//ZzKe6QjI9si2zOugFierz2fee9ueBEY0L+sCO1r4GVtSULIf9ppuVJv5
	Yk0uBC585q43SWBpR5Fz2mzyG8enniy0YSLEya8cYoz2GjiRNTKH9lxZ8C2nn6XHulGWAsedgctep
	z+R2Qn7LBlexsq5Il9MMqjT7UmQdFb/FFfU+IhGnpdIXQo0TxZ91n2YPHz4MLFxtaPBTDICT/t05r
	hvudt4N84S3pbjn5xna+iRj/LxNEIh9KLMdHAy+SC/MrNFwSuP+oZQ9I6yVhBXBw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1svyUS-00015H-Nb; Wed, 02 Oct 2024 14:30:00 +0200
Message-ID: <056770ff-90e6-4140-b964-862a1503fa3b@leemhuis.info>
Date: Wed, 2 Oct 2024 14:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] AMD SFH Driver Causes Memory Errors / Page Faults /
 btrfs on-disk corruption [Was: .../ btrfs going read-only]
To: linux-kernel-bugs@hixontech.com,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 akshata.mukundshetty@amd.com, LKML <linux-kernel@vger.kernel.org>,
 Skyler <skpu@pm.me>, Richard <hobbes1069@gmail.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <90f6ee64-df5e-43b2-ad04-fa3a35efc1d5@leemhuis.info>
 <3a9b2925-57fb-4139-8cf5-a761209c03cc@hixontech.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3a9b2925-57fb-4139-8cf5-a761209c03cc@hixontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727872209;2a400154;
X-HE-SMSGID: 1svyUS-00015H-Nb

[CCing Richard, who apparently faces the same problem according to a
recent comment in the bugzilla ticket mentioned earlier:
https://bugzilla.kernel.org/show_bug.cgi?id=219331#c8

CCing Mario, who might be interested in this and is a good contact when
it comes to issues with AMD stuff like this.

CCing the Btrfs list as JFYI, as all three reporters afaics see Btrfs
misbehavior or corruptions due to this.

Considered to bring Linus in, but decided to wait a bit before doing so.]

On 01.10.24 23:40, Chris Hixon wrote:
> On 10/1/2024, 12:56:49 PM, "Linux regression tracking (Thorsten Leemhuis)" wrote:

>> Basavaraj Natikar, I noticed a report about a regression in
>> bugzilla.kernel.org that appears to be caused by a change of yours:
>>
>> 2105e8e00da467 ("HID: amd_sfh: Improve boot time when SFH is available")
>> [v6.9-rc1]
>>
>> As many (most?) kernel developers don't keep an eye on the bug tracker,
>> I decided to write this mail. To quote from
>> https://bugzilla.kernel.org/show_bug.cgi?id=219331 :
>>
>>> I am getting bad page map errors on kernel version 6.9 or newer.
>>> They always appear within a few minutes of the system being on, if
>>> not immediately upon booting. My system is a Dell Inspiron 7405.
> [...]
>>> [   23.234632] systemd-journald[611]: File /var/log/journal/a4e3170bc5be4f52a2080fb7b9f93cf0/user-1000.journal corrupted or uncleanly shut down, renaming and replacing.
>>> [   23.580724] rfkill: input handler enabled
>>> [   25.652067] rfkill: input handler disabled
> 
>>> [   34.222362] pcie_mp2_amd 0000:03:00.7: Failed to discover, sensors not enabled is 0
>>> [   34.222379] pcie_mp2_amd 0000:03:00.7: amd_sfh_hid_client_init failed err -95
> 
> No sensors detected - do we all have that in common?

Skyler, Richard?

>>> [...]
>> See the ticket for more details and the bisection result. Skyler, the
>> reporter (CCed), later also added:
>>
>>> Occasionally I will not get the usual bad page map error, but
>>> instead some BTRFS  errors followed by the file system going read-only.
>>
>> Note, we had and earlier regression caused by this change reported by
>> Chris Hixon that maybe was not solved completely:
>> https://lore.kernel.org/all/3b129b1f-8636-456a-80b4-0f6cce0eef63@hixontech.com/
> 
> This looks like the same issue I reported.

And sounds a lot like what Richard sees, who also sees disk corruption
with Btrfs (see https://bugzilla.redhat.com/show_bug.cgi?id=2314331 ).

>> Chris Hixon: do you still encounter errors, or was your issue
>> resolved/vanished somehow?
> 
> I still encounter errors with every kernel/patch I've tested. I've blacklisted 
> the amd_sfh module as a workaround, but when the module is inserted, a crash
> similar to those reported will happen soon after the (45 second?) 
> detection/initialization timeout. It seems to affect whatever part of the
> kernel next becomes active. I've had disk corruption as well, when BTRFS is
> affected by the memory corruption,

Skyler, did you see btrfs disk corruption as well, just like Chris and
Richard did?

> so I've ended up testing on a USB stick I
> can reformat if necessary. I haven't tested new patches/kernels in a while
> though. I'll get back to you after I've tried the latest mainline. Also note
> that I've tried Fedora Rawhide's debug kernel,

From what I see it seems all three of you are using Fedora. Wonder if
that is a coincidence.

> which has a ton of debugging
> options including KASAN, but nothing seems to point the finger at something
> originating in amd_sfh code. Is it possible the hardware itself (the mp2/sfh
> chip) is corrupting memory somehow after some misstep in
> initialization/de-initialization? Also if you look at my report, you'll see I
> have no devices/sensors detected by amd_sfh - I wonder if other reporters all
> have this in common? (noted in dmesg output above from another user)   

Given that Basavaraj Natikar never really addressed Chris earlier report
from months ago and the severeness of the problem I'd wonder if we
should revert the culprit to resolve this quickly, unless some proper
fix comes into sight soon. Sadly from a quick look that would require
multiple reverts afaics. :-/

Ciao, Thorsten

