Return-Path: <linux-btrfs+bounces-19663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F034DCB6DB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 19:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB2E3058A66
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5FC316180;
	Thu, 11 Dec 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="WMxFEvxP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHrfhhHf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94F25EFB6
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476123; cv=none; b=FACT24oFNyCrwwi2WfR2jxZ9ZLOgqasHY4qYYf6LNbQLrEzTtXI4989e5mG2DEP2T3F2Sqv9O15I/3WM+ppC7taAec/a2rToTfBXNfkD8j4K49zCEmr5DmsNQQfC1E7DFjlZc9RdKhGgjMOjp+aLSN5x5Ibyl2njZaUrY+yr3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476123; c=relaxed/simple;
	bh=e/lZLenQD9tNR3snTanrZgO0l3UCgD4aZUenls1efLg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h+YSbADBwka7smaOdkrvKjq0DScBbwZOrdd0fK7MkaLbwqALYpCWBtV8GTmMTapVPHTR9mhue7UPYmUtc1BS5VwmlFKK2rYlEZ8LiMN/iExj+2gBnwZgRL5z/+37w5Eoq5qepRaGhjBiNMNBU4QI+bS9nYlEIDubeT6nX6Pi5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=WMxFEvxP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHrfhhHf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 120D9EC043E;
	Thu, 11 Dec 2025 13:01:58 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Thu, 11 Dec 2025 13:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1765476118; x=1765562518; bh=jcNH+F+ocofTZcCIux5Q3
	monByi9zGLSX/NHqIAT0L8=; b=WMxFEvxP8Y1/32jzce4/o+auI4vLWgYf48PXp
	ycLR19LpkHOlesK2XdnXqkyUKU1Y4L6z5jG8sQZoSM+aWrXFsUZGGhTzoUqtD5jt
	aaOY5W5UCiR3g8ju9lvsX9bJJ5Kzizfg3kJODI5aEnBsFzbdnvdav/IvpLqW1zAq
	PKbtBR5NmuVO2v4FF0JVcuSdYwrOF4NSaCWJzJL6fkR4L7X8rzG/t6TtDwXOoyeD
	u0jKpummG1e8o8AIH9ECL9Xl69o5EcNR8yo4TXRKZt8rMpiwRsafT0GUdENJxdfz
	+p/ftPUGmyyCE7Qvx0JyhZB/2KXY1kiXJrDAOZLetwCJpZfeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765476118; x=1765562518; bh=j
	cNH+F+ocofTZcCIux5Q3monByi9zGLSX/NHqIAT0L8=; b=dHrfhhHfdkobaGs/B
	d7U93uVlklhOHA5/LCLWoCkbv4tfyDo070sAPOBk/03zD4psPVt0blWjIdaMCyfd
	3xYQ6XYLKc1savvljOpKju7PqXkApEm9dq+jXfleOOWgFIfhEZb2a2uWp2sLzovE
	rQCPx0Va7yZl0aGRLEraGOHc2dZl0C1rvcUGS+7EAnlExOJ2V3XUda3M4VXaNEFA
	E27PegADuWmpJmZW/rtPkqD+OI6592VbkDIEdaLQh9HWz5MWtoxTHlJLBPO0OduS
	nORNyc9amWFzAgNBfPiOKi4cW8QPOXiKR2BGbrj1fA1vHrKnT2lRzu71nglzl1M/
	5KtDA==
X-ME-Sender: <xms:FQc7aRi79rYP4mVo99QY6VvRv6OWXqbX3gLcma0KoL6EpkDaI-v-gA>
    <xme:FQc7aQ0N1Lg1pYpWdXjOwqzoNqf_zcWsHrFPz5drksE_th2cP8BrdrnRC21USmvgn
    dopojmToN7Z1Q95UnsjHGrejXc_Fg_MNPRt4VSzgUZji6kmmHaqQMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeekieeujeekfffhvedvfeegfefflefflefgjeeiveetveelffeu
    uedvgffhudejhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtg
    homhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:FQc7aUMYRiTpzVOezMch2g2MpderVlnXrgqnvfpLekqiEydrq8w1dg>
    <xmx:FQc7aY7PQgvGGtcWfFHZfplJfah6l7FepN2OJOr4wLm2z9Tw7EGBLQ>
    <xmx:FQc7aS1xmjZjF3dgQ-KiBLIjoTntka3IvGk3C0c-O1hiLB1HyDN3iA>
    <xmx:FQc7aZaJhPqcCqZ_Hj9XjwIi2MWubzn8kayea5sEXsGWnZVFj56Klw>
    <xmx:Fgc7aTRmXX4dVRvwf5oWsXqJar1DmcrCLZCHj1N3T37nl3WfGeGW3fH3>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF0C818C004E; Thu, 11 Dec 2025 13:01:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5g2OpuDMuvg
Date: Thu, 11 Dec 2025 11:01:36 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu WenRuo" <wqu@suse.com>, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <651e259c-ac24-49d0-8eba-4d9c7c9f11c8@app.fastmail.com>
In-Reply-To: <d9ab1004-a7ff-4939-9692-0c8f32df27a9@suse.com>
References: <e2095d93-fa47-46b2-b894-0918b6ce348c@app.fastmail.com>
 <d9ab1004-a7ff-4939-9692-0c8f32df27a9@suse.com>
Subject: Re: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at fs/btrfs/inode.c:4297
 __btrfs_unlink_inode, forced readonly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Dec 10, 2025, at 6:55 PM, Qu Wenruo wrote:
> =E5=9C=A8 2025/12/11 11:58, Chris Murphy =E5=86=99=E9=81=93:
>> User reports root file system going read-only at some point after sta=
rtup. Seems to be when a Firefox cache file is accessed.
>>=20
>> Initial report is kernel 6.17.8-300.fc43.x86_64, but the problem also=
 happens with 6.18.0-65.fc44.x86_64.
>>=20
>> User previously discovered bad RAM and has replaced it, so I guess it=
's possible we have a bad write that made it to disk despite write time =
tree checker (?) and now can't handle the issue when reading the file. B=
ut I haven't seen this kind of error or call trace before, so I'm not su=
re what to recommend next. If --repair can fix it.
>
> This looks like a previous memory corruption caused on-disk metadata=20
> corruption.
>
> Tree-checker is not a memtest tool, it can only detect very obvious=20
> problems, it can not do cross-reference, and unfortunately this is exa=
ct=20
> cross-reference case.
>
> For this particular one, I'd recommend to do a "btrfs check --repair"=20
> then "btrfs check" to verify.

Looks like --repair changed from "errors 4" to "errors 6"


[1/8] checking log
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
[5/8] checking fs roots
	unresolved ref dir 1924 index 0 namelen 40 name AC1E6A9C763DC6BC77494D6=
E8DE724C240D36C9E filetype 1 errors 6, no dir index, no inode ref
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
found 140964491264 bytes used, error(s) found
total csum bytes: 136339904
total tree bytes: 969474048
total fs tree bytes: 751108096
total extent tree bytes: 62439424
btree space waste bytes: 178561905
file data blocks allocated: 490371264512
 referenced 162984435712

End user has btrfs-image before and after repair if that's useful. But a=
dditional --repair attempts do not appear to fix the "errors 6" message =
- and the kernel still produces a warning and goes read-only if the file=
 is accessed.



--=20
Chris Murphy

