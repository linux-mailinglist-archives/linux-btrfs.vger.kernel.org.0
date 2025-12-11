Return-Path: <linux-btrfs+bounces-19671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D943CB732C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 22:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D6BE3011ECB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E05524E4B4;
	Thu, 11 Dec 2025 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="k6Y22ozg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6fIl29F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32004236451
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765487269; cv=none; b=MOq56YMTz52xvZhPwTUTiheGwUHxxWuy221dcNW8Ar0jMShRXm6Jsmwz8Fcacf8T9UgmZO7K+7FjuGo80fcDsYBQ7FcyeZnpH39H5n6JGZkuP/f4ncSzYtI5co0krbq5cw3arW31rHr7s8pJXa32N4Y90hdZBM3bSAzOQA8eHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765487269; c=relaxed/simple;
	bh=l4AvqlZz/wEM9+sF0AK6uNh2q4fkr0klLGfiWeSHJ1o=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YT8UGHMe1YL5uhdS0WylrMRYK04PtJBfpGOzMLRDADMhdrjXw3QkvpiloA7P3O0GhP653+ChGobZ5v3w5uRhDXtidOHN04QFnInpyKdUzDCr32Z3fgswHdQ19TLhfDUivLgxhVny+Rx5RxeezVXNQJM2DLcznIDcuIGQtnvCQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=k6Y22ozg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W6fIl29F; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 563C814000CA;
	Thu, 11 Dec 2025 16:07:45 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Thu, 11 Dec 2025 16:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1765487265; x=1765573665; bh=9orTRRM3RFzd2njlKby7U
	6FOXnYVE8to95619PxF3JU=; b=k6Y22ozgOKCT6wjIHz4ppULTFLkKAsJjZjJMj
	RtPouVtwNQXMvN7XCvDRnVE7F0TA3gKcQQX4Ivc7fx9iPabqDcacx1JHbnFXQ4zH
	LRVcMOgJrheKEEhxkDXpkxnWCOw1MbicLYicpp+7XC9lyKL3iSh6seGNzjd3Qzn7
	3yCzR+WS+p2xH1RIG6tbYQXiJM7EmVBWpQwlcUvaEOXAP3eTfQKax5e/Uim4ywya
	tR85KoZIoTHEhyLRAF4ZzLUPr+53Y8pEsXuz8OlnXtSE78m2VqxqNu6Wml4IXtlA
	8J2Ck71fOimZBAGjB+S4s1mgBk/q9rixlJqopL77wGzbdC8ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765487265; x=1765573665; bh=9
	orTRRM3RFzd2njlKby7U6FOXnYVE8to95619PxF3JU=; b=W6fIl29FO7+qefPkS
	cTT4G9731w4rx3IqdNHKHGgnPfUbu9Z5kavOe15iE8SJNrxLGtpJu+slp7wByEc2
	Fre1K/LK4dc1sbmSt1yP2aCy6QhCRBLzJRP6VT8kjk1G5mvG/RuxE3jFybGabgaJ
	UhiyKaA6iRjVVYKfOEkluYWOSMOxXeRbT8vdyxLjPExOpl3DvPmpuXPTI0ZlUkOC
	JgKZiY8OvlwDpNZ0Y0pdaTnML/CBtiG6L/sXx8L38BHLBwJuyZT3lqDj6jESj/Fd
	sMUn0/rue/EJznJRTLvttewxDYbBQD3JKWHaPTElz9EWeqLMdlybtjdGPmQDckUE
	sDaWw==
X-ME-Sender: <xms:oTI7acOwkzPiMekUZyr6pdQyM6FlS_7hlV0r7EIZqjvlBYaceF1iZw>
    <xme:oTI7adxIBJD0VuiEylCZjzEJoJLnWDOjYWck3AP8BLk8MG8v-MPbZXMUUk3hdiJBl
    3-A4LHemJ55_kEHLXeGt_fwqibkwH9G84CWgRaQV6xX_MJZbEMrcSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdduhedmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvg
    hmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepleffteeuiefgffevudeitddu
    teetleeiteeffeetgeetleeuteejudffjeevgedtnecuffhomhgrihhnpehmihhkkhgvlh
    drtggtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    lhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthhtohepvd
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oTI7aa7Oh3Ot3nNm5389RZzWUH8cfXvIDyeN3j7j0kO7BOfQGc4WCA>
    <xmx:oTI7aR2dxcgnft__7-lK3-Wanv0P5S4M_7Jw4xM_iW1ZbQL1IhhYPA>
    <xmx:oTI7aRBxzu3rfkzYeeSt2EIuGwcL9EDNpmr-_CVdbtrG9bkDKJKxpA>
    <xmx:oTI7aT1v0nIPDNedgQYO8Z9hmut12PZM56eV5irbdicwCa0-xJDIlg>
    <xmx:oTI7aQsTo_SRStRJKMOyFUaL_hjDLZW0WdTE8kpjVmAv8JAn0d_wnj7P>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2430818C004E; Thu, 11 Dec 2025 16:07:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5g2OpuDMuvg
Date: Thu, 11 Dec 2025 14:07:17 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu WenRuo" <wqu@suse.com>, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <eff3e10d-65cb-43f4-bb51-bd6a25f02cc1@app.fastmail.com>
In-Reply-To: <91284ff1-bb1c-4f20-83a6-c1499d45a0e9@app.fastmail.com>
References: <e2095d93-fa47-46b2-b894-0918b6ce348c@app.fastmail.com>
 <d9ab1004-a7ff-4939-9692-0c8f32df27a9@suse.com>
 <651e259c-ac24-49d0-8eba-4d9c7c9f11c8@app.fastmail.com>
 <91284ff1-bb1c-4f20-83a6-c1499d45a0e9@app.fastmail.com>
Subject: Re: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at fs/btrfs/inode.c:4297
 __btrfs_unlink_inode, forced readonly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Dec 11, 2025, at 11:52 AM, Chris Murphy wrote:
> On Thu, Dec 11, 2025, at 11:01 AM, Chris Murphy wrote:
>> On Wed, Dec 10, 2025, at 6:55 PM, Qu Wenruo wrote:
>>> =E5=9C=A8 2025/12/11 11:58, Chris Murphy =E5=86=99=E9=81=93:
>>>> User reports root file system going read-only at some point after s=
tartup. Seems to be when a Firefox cache file is accessed.
>>>>=20
>>>> Initial report is kernel 6.17.8-300.fc43.x86_64, but the problem al=
so happens with 6.18.0-65.fc44.x86_64.
>>>>=20
>>>> User previously discovered bad RAM and has replaced it, so I guess =
it's possible we have a bad write that made it to disk despite write tim=
e tree checker (?) and now can't handle the issue when reading the file.=
 But I haven't seen this kind of error or call trace before, so I'm not =
sure what to recommend next. If --repair can fix it.
>>>
>>> This looks like a previous memory corruption caused on-disk metadata=20
>>> corruption.
>>>
>>> Tree-checker is not a memtest tool, it can only detect very obvious=20
>>> problems, it can not do cross-reference, and unfortunately this is e=
xact=20
>>> cross-reference case.
>>>
>>> For this particular one, I'd recommend to do a "btrfs check --repair=
"=20
>>> then "btrfs check" to verify.
>>
>> Looks like --repair changed from "errors 4" to "errors 6"
>>
>>
>> [1/8] checking log
>> [2/8] checking root items
>> [3/8] checking extents
>> [4/8] checking free space tree
>> [5/8] checking fs roots
>> 	unresolved ref dir 1924 index 0 namelen 40 name=20
>> AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E filetype 1 errors 6, no dir=20
>> index, no inode ref
>> ERROR: errors found in fs roots
>> Opening filesystem to check...
>> Checking filesystem on /dev/sda3
>> UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
>> found 140964491264 bytes used, error(s) found
>> total csum bytes: 136339904
>> total tree bytes: 969474048
>> total fs tree bytes: 751108096
>> total extent tree bytes: 62439424
>> btree space waste bytes: 178561905
>> file data blocks allocated: 490371264512
>>  referenced 162984435712
>>
>> End user has btrfs-image before and after repair if that's useful. Bu=
t=20
>> additional --repair attempts do not appear to fix the "errors 6"=20
>> message - and the kernel still produces a warning and goes read-only =
if=20
>> the file is accessed.
>
>
> Looks like inode 730455 is found in more than one leaf. I'm kinda=20
> wondering if there is a way to compel btrfs to delete the affected=20
> leafs, thus fixing the file system. Backups are done so none of the=20
> files in any of the leafs need saving. So if I were to have the user=20
> delete all the files in all the suspect leaves - is it possible Btrfs=20
> would just drop the leaf without hitting the splat?

search for inode 730455
https://paste.mikkel.cc/3gCsnhb2/+inline

The subvolid the file appears in is 256.

>[   46.847056] BTRFS info (device sda3): bdev /dev/sda3 errs: wr 0, rd =
0, flush 0, corrupt 33, gen 0

The corruption counter has increasing values but we're not seeing any cs=
um/checksum errors.


--=20
Chris Murphy

