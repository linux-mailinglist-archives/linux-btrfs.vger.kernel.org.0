Return-Path: <linux-btrfs+bounces-2685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F727861C89
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 20:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38313B21B2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59203146E87;
	Fri, 23 Feb 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="uk3bH7ep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MiRXRtxi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F313145B08
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716509; cv=none; b=FZbZOWJjhjN2xyOHaqZKyctHmeDP00h4c6cI74ExY/Z/NqziygA8kQqkU1Qr7Ztsua4+G/0KBe01gITH43XIxH3m0yi/gLInWMHVZRhOipdx3YPzYKv+aCbNDk7p5tZbnVBUO50h7P7k30imcd87m7gdjMGWDjSSBxbkixEaNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716509; c=relaxed/simple;
	bh=PZQsitnq/ki2PByNCNXwX5X3hdfsQbx35JgevWKp51o=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=eTzzaF4rVabP+xbmdj0yEI6qkmlPnanRkYMVG4XnNhzpyJmGZ1kef1wyliPYjrCu1XOu1Grj1T5Ip6JOzT3Hz6Kd+X/EDrKWBl3UVgg2icGtk3r8zf/dmfdY8R084q0ik8gVWflQQofLTRLy5xUVXgve1CRI/o81svuQm/TCd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=uk3bH7ep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MiRXRtxi; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 880D55C005D;
	Fri, 23 Feb 2024 14:28:25 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Fri, 23 Feb 2024 14:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1708716505; x=1708802905; bh=FJongf9MTMtWxOYbBgciR
	qOFsAUaxkUpEn5c7ryapvQ=; b=uk3bH7epHa6/HCoMLjNlFDkUEfmVABVk+yXFR
	zPg6BvhMWNczMwsbO0GzMx00GEFmd2EX9e+yaqiwfV6x+zrprIpfswqwQlfmx1Cd
	e5xJzQvgzZsu4nwjlwgfQjJO9CF0R8lKw5dcTW3LtVZOVj6Q0popWuIzC1kJ4A5l
	6rOX5TahscJ0xD6JNYHkLbXqrw7cV657rXAaUS0j+y1RsFxX2TOImJq8wCcE0cBj
	o4mdW6n99UYoU6y0FmgG1FEvjE3n/Z7WAy2gGAuTOq+cswIUdevhCUsTUyFU8irP
	GMW9+wa/o7mjXe6ELKH32ckdEclUi+c2Yi+5CA0QNDdTNTKsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708716505; x=
	1708802905; bh=FJongf9MTMtWxOYbBgciRqOFsAUaxkUpEn5c7ryapvQ=; b=M
	iRXRtxi+xUKr/Xlnk5LKA+K/T7U0IYuS5we9075ZBAhy9Oy53D55ZwedzzSUjekn
	D544orztEx5qHUeu0ALChTuu8aFd4WaCP3FAHswyat/9SNJTa5AvdI/n3fhxOpvr
	Br8MGMZcPO6o9lyQcwTs7K0MzBOkhKwDp2uYoEym1aDRrUoGejIvdzmZceQEgdJ0
	atNvGI2Gra8kv54haMaRkqsWwv3HPaDvXjmDGyaGmbulXtZywxAf31SbxNAgDkum
	/UZSlkKm9LnguR9xf86bZN96QSPjnlodKelrCPj4i2rycoGinCGd55KhNXp/sCiC
	zmovjZbqIaZNLRkjLpeGA==
X-ME-Sender: <xms:2PHYZeyP0eCoHFAff1Jj_hmA8JRYkNvuyEMulvsoqPtwNxt219h0dg>
    <xme:2PHYZaRrDp7I-zHchZLVttTwdEz2FSx2Gx9SErflHAUCZUwxnNDDh_9U6mBqojU72
    yvIQxcKCrJFdTabWYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeehvdeiteejhfehgedtleffffehleetffeikefhfeeh
    keejhfetueehkeevueeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:2PHYZQWFaauG_Ky0pouVg115D0gfdToCmwpfMjT0SJwmHinR74k-HQ>
    <xmx:2PHYZUiN7wQAcIFY7UQIoFyamOOqRoiHECMJ0h3BQDA_wlSGS2mrlQ>
    <xmx:2PHYZQCckT0wQDx7VwRkndvvxHDH93w239sX6yl89Kn5v_m7duSx8g>
    <xmx:2fHYZf_uLi-n-WcLz8QPDRqhc5K1aos62ZBp7UOLvfrD9yBXJNCfGw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AA16D1700093; Fri, 23 Feb 2024 14:28:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <811716d2-fb98-4cf7-beab-c1960ee8c8e8@app.fastmail.com>
In-Reply-To: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
Date: Fri, 23 Feb 2024 12:28:04 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Matthew Jurgens" <default@edcint.co.nz>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: How to repair BTRFS
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Feb 23, 2024, at 4:09 AM, Matthew Jurgens wrote:

> Then I ran a btrfs check while mounted which looks like:
>
> WARNING: filesystem mounted, continuing because of --force


In my opinion btrfs check while mounted is sufficiently unreliable to be=
 useless. In theory, if there's no pending transactions, you can get a c=
lean btrfs check while mounted. But otherwise, all bets are off. A btrfs=
 check taking longer than the amount of time for another transaction to =
begin, can be seen as a file system inconsistency.





> Opening filesystem to check...
> Checking filesystem on /dev/sdg
> UUID: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
> parent transid verify failed on 18344238039040 wanted 4416296 found=20
> 4416299s checked)
> parent transid verify failed on 18344238039040 wanted 4416296 found 44=
16299
> parent transid verify failed on 18344238039040 wanted 4416296 found 44=
16299
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D18344237924352 item=3D1 par=
ent=20
> level=3D2 child bytenr=3D18344238039040 child level=3D0
> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0:00:06 elapsed, 69349=20
> items checked)
> ERROR: failed to repair root items: Input/output error
> parent transid verify failed on 18344253374464 wanted 4416296 found 44=
16300
> parent transid verify failed on 18344253374464 wanted 4416296 found 44=
16300
> parent transid verify failed on 18344253374464 wanted 4416296 found 44=
16300
> Ignoring transid failure
> parent transid verify failed on 18344264335360 wanted 4416296 found 44=
16301
> parent transid verify failed on 18344264335360 wanted 4416296 found 44=
16301
> parent transid verify failed on 18344264335360 wanted 4416296 found 44=
16301
> Ignoring transid failure
> parent transid verify failed on 18344243511296 wanted 4416296 found 44=
16301
> parent transid verify failed on 18344243511296 wanted 4416296 found 44=
16301
> parent transid verify failed on 18344243511296 wanted 4416296 found 44=
16301
> Ignoring transid failure
> parent transid verify failed on 18344246345728 wanted 4416296 found 44=
16301
> parent transid verify failed on 18344246345728 wanted 4416296 found 44=
16301
> parent transid verify failed on 18344246345728 wanted 4416296 found 44=
16301

Looks to me like the file system is changing as the check progresses and=
 therefore the check becomes confused, being unable to distinguish betwe=
en normal file system updates and inconsistency from the time the check =
started.


> ERROR: free space cache inode 958233742 has invalid mode: has 0100644=20
> expect 0100600

I'm not sure if these are real problems, or again if it's possible the f=
ree space cache is changing as the check progresses. But also I'm not su=
re why there's a free space cache inode if this is a file system using f=
ree space tree (space cache v2).

>
> I then ran a btrfs check again whilst not mounted and I won't put the=20
> output here since the file is 1.5GB and full of things like:

> root 5 inode 437187144 errors 2000, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 9425133=
56 index 9 namelen 14 name=20
> _tokenizer.pyc filetype 1 errors 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 9456966=
31 index 9 namelen 14 name=20
> _tokenizer.pyc filetype 1 errors 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 9489987=
53 index 9 namelen 14 name=20
> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 9525103=
65 index 9 namelen 14 name=20
> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 9544210=
30 index 9 namelen 14 name=20
> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index

These are fixable by recent versions of btrfs-progs, so I think it's saf=
e to --repair as long as it's not mounted and not forced.


>
> and
>
> root 5 inode 957948416 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 690084 =
index 17960 namelen 19 name=20
> 20240222_084117.jpg filetype 1 errors 4, no inode ref
> root 5 inode 957957996 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 8908194=
70 index 4463 namelen 8 name hourly.3=20
> filetype 2 errors 4, no inode ref

same for these



>
> I have also run
>
> btrfs rescue clear-uuid-tree /dev/sdg
> btrfs rescue clear-space-cache v1 /dev/sdg
> btrfs rescue clear-space-cache v2 /dev/sdg

After removing the space caches, you should explicitly mount one time wi=
th space_cachev2 mount option to set the free space tree flag on the fil=
e system. This still isn't done in the kernel automatically. Whereas rec=
ent versions of mkfs will set the flag, therefore the kernel honors it. =
So it's a bit confusing that you need to do a one time mount with v2 opt=
ion still, if you've manually cleared the caches.


>
>
> I am currently running another scrub so I will see what that looks lik=
e=20
> in a few hours

Keep in mind they check for different things. The scrub will check data =
and metadata for checksum mismatches, i.e. if there's corruption like bi=
t flips or media errors. Whereas file system inconsistency (perhaps more=
 likely due to a bug at some point in the past, but could also be the re=
sult of a drive firmware bug) is what btrfs check is looking for; metada=
ta only unless you use the extra flag to check data csums.

It's probably a good idea to scrub first, then run the repair. If I thin=
k about it, I will disable the write cache on all the drives when doing =
repairs, if the drive supports disabling it. Be super clear about hdparm=
 -w vs -W, one of those can be dangerous. Cute huh?=20

Also, I suggest using current stable which is 6.7.6. 6.5 series is EOL, =
no more bug fixes. Yes there could be new bugs in 6.7.6 but you're still=
 overall likely better off with current stable. Or if that's not possibl=
e at least the most recent longterm, which is 6.6.18.



--=20
Chris Murphy

