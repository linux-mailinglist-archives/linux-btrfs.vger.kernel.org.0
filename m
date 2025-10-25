Return-Path: <linux-btrfs+bounces-18334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F3C09D7F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 19:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726261C81201
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2B2FFDF9;
	Sat, 25 Oct 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="rCt64ymk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PdFEagAC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF0302746
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761412014; cv=none; b=t7ZlbzpTgLjmytBdA5GyRr5WBsL8qQAU96UplEKwfpcJ4navT1tT716/H129PYcpv1pqACZoHzvYkviFaxmo0/afYhuqlzyjivqNLVvT/+qnhyhkOqzkobXwi5YJly5DUAcL+ZiQpyKCKT0GIlgVVZIHtF6BhxE+r8YMrnZgX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761412014; c=relaxed/simple;
	bh=64+rOM3NtvFYHPlcXzCdOXWtqQRdru/OXoOuyoBzbpk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UIsd8L8dmXuRE4j9hUs1+A/LfoHXpwv6hcbVYjLAeieWR/P/VKD+PnQe7nwKG2FCHbaGDwPbO/RDoqDFWpsCCMQkVM6CW4pcxkuTrZsXxGvoiFmC10RbJmj/LikXRXYb8nHIwIXgz+2EtDKsNUgMMDO0t/6FTf+HytBr/e3opNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=rCt64ymk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PdFEagAC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E2142EC00F8;
	Sat, 25 Oct 2025 13:06:49 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sat, 25 Oct 2025 13:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761412009; x=1761498409; bh=/MLT7uwB8l
	AdCDX38uct7FpB2vzEZPzAqITHD8mjeok=; b=rCt64ymk/1YLp2tWrDrnacG43L
	/C9ugMWO+EOSatQrU/Obkix+V9yld/m8LQWomOxKTd4brkGEv+wTQmopIrE21UX2
	47P+DRsW5B4sHCrGVNGvJ99SNW7wORwSC9G8z2Ghzw8DtTcvRKFCtc0SHLNXA+UO
	I+Kk9X912h2WUfMD/B+8h3ubroPLMzwrEeqaIdFE8t3jkomVk0+ZroHQMXd5YwcZ
	dhIwl1hU7VYuBbIXVj9lywvkr61SeRCFz8bUQbMsb4Lp28IXgyTdbtyaAfdq6bsq
	Jj0UtkEfTzwy0207t+om3KYiLPtk8mKERq4jAn3qCuQuvwax9tDbV9LoJwuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761412009; x=
	1761498409; bh=/MLT7uwB8lAdCDX38uct7FpB2vzEZPzAqITHD8mjeok=; b=P
	dFEagACBzvR+j2lCeC5b9pSDeLjDNdEbR7Zd5P8bWVPqM8oFhAuoMyeYqy9aEmt0
	d/5JgHS1EEC6HJgW3+GWOOcdcXusiX9aUPhXZ0eSFais7KAF/HDYdjbIiC6PG7Y4
	S7vB77eDm7T+/p6A3UDi8tPRKMxD0aYq6oTCJRZkBg+1d/z3VLb9Aum3IfmH4qoG
	VPRYO7nd21LJhUO37zhjiaxO14pIJkjOthnDA/80ytfmI7qrhv2m6qo5VvSB6az3
	qZ4+bEKOaA1fXtSY0xoC7mdPSeFsMJU3eVEGiz+VtVmZXaLvK1V1f8sFIOhxn8yp
	xHShJ+B5+MvpZAHjWYHXQ==
X-ME-Sender: <xms:qQP9aCgXvZqqzMwB8Oe8GcfXg9hkgmFd-V_ozokq-GPUQeOSYF5tHA>
    <xme:qQP9aN2fv6nv2vJHLCNNcLFRJmvlfM-zW8F3Lfqfrd7W594kFV-kGrqLW6Im7uv6T
    WjTQL0NN0_FCBEC4eCBAVBXCPNOB8r3DiBnHA7Me7Atv_bWiwva7zre>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeekhedtieejleeuleetvefgvefgtedvhfegtdejieffhffg
    tdeutdeljeevgfdvueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehunhhfrgdttdesgh
    hmrghilhdrtghomhdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qQP9aD9V1h3VhkBgkg5mcc8O81_zgByNdWRjs81i8fNWbtFxxBwfxQ>
    <xmx:qQP9aHdpt2WnPo6EEZKGs_Mzlmj0fUAbBpHMhlE3uEeieHGKL8QcdA>
    <xmx:qQP9aEFN7u0O8s4_UwUASLdERFEysT6EYIfyPLtJkJj6gt2iWralSQ>
    <xmx:qQP9aNfLXAhxZWN_YRqfnNrUoaKGJttUMsM3WhaAtscipm3VPEQZJg>
    <xmx:qQP9aGzKNoFZOpNO9DC5Kas4J8HoBG1J1mSQz1QkxtwYbvGKHiQuAup3>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 72F6418C0066; Sat, 25 Oct 2025 13:06:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9jZGU0JwjF3
Date: Sat, 25 Oct 2025 13:06:22 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>, "Qu WenRuo" <wqu@suse.com>
Message-Id: <dab1f9d3-6b21-4df9-8217-faf1aff7ba0a@app.fastmail.com>
In-Reply-To: 
 <CAOsCCbPRE-kXtBXHLxu179q63_HoRby0a4fZukziMUxjzYRhuQ@mail.gmail.com>
References: 
 <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
 <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com>
 <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
 <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com>
 <CAOsCCbOeNGTS+MK4ZMDkg+PfVC0D9DR7iRXr+Hy6qK9sHgYjJg@mail.gmail.com>
 <CAOsCCbPRE-kXtBXHLxu179q63_HoRby0a4fZukziMUxjzYRhuQ@mail.gmail.com>
Subject: Re: Damaged filesystem - request for support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, Oct 25, 2025, at 4:58 AM, Tobiasz Karo=C5=84 wrote:
> Here's scrub status:
>
>
> UUID:             a11787a5-de1d-421c-ac2e-b669f948b1f0
> Scrub started:    Fri Oct 24 11:21:29 2025
> Status:           finished
> Duration:         15:49:35
> Total to scrub:   9.09TiB
> Rate:             167.21MiB/s
> Error summary:    csum=3D1068
>  Corrected:      172
>  Uncorrectable:  896
>  Unverified:     0
>
> I assume this means I can continue to use the filesystem, accepting
> that a number of files will be inaccessible and result in i/o errors
> when accessed?

Qu, does `btrfs check` verify both copies of metadata when available? Or=
 only one copy? Does btrfs check ignore csum mismatches?

From first post, this file system is:

#  btrfs fi df /mnt/backup/=20
Data, single: total=3D9.07TiB, used=3D9.07TiB=20
System, RAID1: total=3D32.00MiB, used=3D1.19MiB=20
Metadata, RAID1: total=3D11.03GiB, used=3D9.91GiB=20

Since btrfs check says the fs is clean, but then scrub finds and correct=
s 172 errors, that must mean those csum mismatches for some of the metad=
ata that btrfs check did not detect? It's a little confusing what state =
the file system is in now because the results don't explicitly tell us. =
We have to infer it.

Tobiasz, I think you need to run the btrfs check again (normal mode only=
 is ok I think)  to be sure the metadata is OK. It's a little tedious bu=
t that is pretty important as you point out.

Note that the scrub is actually performed by btrfs kernel code and all m=
essages about the scrub will be in dmesg. All of those 1068 csum mismatc=
hes will produces at least one message each. What is affected, whether a=
 fixup was attempted, and whether the fixup worked. Metadata csum mismat=
ch error looks different from data csum mismatch error. The data error w=
ill show path to the file affected. So the dmesg will leak file names.


> Since the data is replacable (assuming I don't need to go back to an
> older backup, which I don't currently have a need for), I can destroy
> this filesystem and start anew with a clean borg backup.

I'm not super familiar with borg, but I expect that it has an option to =
verify all data blocks on both sides. It probably takes quite a bit long=
er since both sides have to read and compare data. Btrfs never hands ove=
r corrupt data in normal operation, instead it returns EIO for any block=
s that fail checksum verification. The handling in case of EIO is up to =
the application. What I'd like to think happens is borg will see EIO, kn=
ow the target file is bad (or missing some blocks) and will replace it w=
ith a good copy from the source.


> I am not sure what would be better.
> I don't want the FS to constantly remount in ro mode due to i/o errors.

Right. Which is why the first order of business is to make sure the IO e=
rrors aren't happening anymore. Either new kernel has fixed that problem=
, or disabling uas will fix it, or using a USB hub will fix it (I would =
borrow a hub before buying one for testing purposes if it comes to that).

--=20
Chris Murphy

