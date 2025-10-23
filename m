Return-Path: <linux-btrfs+bounces-18223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BEC0353E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 22:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ADF19A0BA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3F34679D;
	Thu, 23 Oct 2025 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="0mPPjs9e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDE7jEc5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBF2C11D5
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250194; cv=none; b=NaYDPhyUhLtHvU8uUUEzphsPqJ3u9b6ZBFZWmuSkl/FHdMEDMF0EfirnQ8UZVH8RzgTR4NvfPSHEDLClB6loDki8gmyb1OLSq41+UO2ZkHeb6RnwlzFVU/2ijAx8khyDVRR41WIa8WEQrwd8pYNixaXI3tkS+9qFMDH/NCOz+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250194; c=relaxed/simple;
	bh=udegA/N1oOhfucDkt/fRmwoeWv19DnGQCuglTA8d7Bg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AEi1nfScH+5mOgP0IsHFbP7ErqmjPLPlRURasfS+UpvgTjaxRgvUBnffjgxCMW+wqM6LVYjicSY5o61sqU5/o/MFiADyheFGzISZrOTbk8DwJlEzg2Xxg6FyKIZdPtJT0hgp34B5+bgCGNo/rrLMXJzNw5BrGnClrWDT2m3SJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=0mPPjs9e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDE7jEc5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 54D43EC0057;
	Thu, 23 Oct 2025 16:09:48 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 16:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761250188; x=1761336588; bh=udegA/N1oO
	hfucDkt/fRmwoeWv19DnGQCuglTA8d7Bg=; b=0mPPjs9eTggScobZreZ/nnWjKj
	XbcP8nSZDU7SH/VjvgBpovCeNEDPnUOScC+E/nAU4YglzFZ7iBWx0dyc/5Ea/Mo+
	6xUSsu3xGIgDh0M2kwfjc0yV7S348bNIVkjAijibNBIZDGJ1RTy19vpwQug8aELR
	CtXSH4Ge9Rpv0CSnGb/rm3F8bER1gCo5H8S2EnoeGBi6JO1IPk7gLQua2Sg7G/Xg
	VniNVpTPXwwYAo8DQB/hEkjugq4gxkktfBuo5hwId2JB0/ts/rYVFhJYQkGvTJ2M
	Y+snC0JSiotOBXGjCK3NPu8jNcsRAWRgvY01DMLz14SnC8G/C/beLejG3VuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761250188; x=
	1761336588; bh=udegA/N1oOhfucDkt/fRmwoeWv19DnGQCuglTA8d7Bg=; b=T
	DE7jEc5bieZ64Qp9eqyq9LbmPkyD1pLFE3in2J3xSoFKhmlRZldc9VEpPS3+luql
	h+8lJgunRhG+kS+s3KIvYzqoJshJlL9b38PuOAlpYBPfpcEpGdYaQx7NdiCjrq0p
	x2BvwdpJyNb4+iFT1n1Phewl7N7RdGtkn99FO0QK4Sd7248fgyCVzgYTBpP5NbJA
	d5dbCoX5txCT641qLlaC+3uQohMWFFKIJOosiba+Im4MwXQlZJ5h5l5SgsviOvkH
	KRpGzbiCOZHsO89Bevn3ajfAbgJ7C6XYtRKCjkDkHvSVP2fWuIC9gd4pqmk07rxZ
	4ix36F0fr1BMJ5xj55aAQ==
X-ME-Sender: <xms:jIv6aGv5bP2bVsiBi6bw2DpXNGSceq6OxA39Iap818QvMLjmrh0LRA>
    <xme:jIv6aGQor2NZcAi5gq2gh9uU3lIUhYRm_glBMQuuP8IcPY1eo6HEtefNZ5PgjllX2
    uK7f3ZGKfsgSFZHlEy0bq6FilHajxB5XvqOjp3Eulvv4lFD64ea1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeekhedtieejleeuleetvefgvefgtedvhfegtdejieffhffg
    tdeutdeljeevgfdvueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehunhhfrgdttdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jIv6aFaRZFJHKbU_sxheoqULDtAtZhV-E4Afn-mrOsi-kMNdyn_-Pg>
    <xmx:jIv6aKVuhybSHB82xcg-xWognQHKzVKtvaxcjOdcH1vNJda-Tz_xBw>
    <xmx:jIv6aPjX9BSrojfjy8AOxqi0gelVr5BPQLHAoYf6jfLIEOmD0ZynBA>
    <xmx:jIv6aAWwgKzErwYP_2RJas9X9QBeHVcSfJq8yqZxwzfxW5I-OfVGSw>
    <xmx:jIv6aLDNAYeod8B9eroKWVrdF0QEmR-ES-UWnbiVWk5cceQhQi9F6wfH>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 020B718C0068; Thu, 23 Oct 2025 16:09:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Oct 2025 16:09:27 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com>
In-Reply-To: 
 <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
References: 
 <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
 <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com>
 <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
Subject: Re: Damaged filesystem - request for support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Oct 23, 2025, at 4:53 AM, Tobiasz Karo=C5=84 wrote:
> Chris, thank you for such a detailed breakdown of what happened.
> I have disconnected the drives once or maybe even twice to try and res=
et things. I don't recall exact reasoning, but them disconnecting was no=
t due to power loss. The enclosure is powered with it's own 12-V power a=
dapter plugged into mains. The exact model is StarTech SDOCK2U33V.

OK so if the problem isn't power related, it's just a quirk/incompatibil=
ity between the kernel and the enclosure firmware.=20

If the new kernel doesn't resolve the problem, options are are to disabl=
e uas or use a good USB hub which will "normalizes" the USB stream, i.e.=
 the USB stream is not merely rebroadcast to the host, and vice versa.

But in any case, I advise disabling the write cache for both drives, tha=
t should ensure write order is honored, and protect in case of crash or =
power failure or forced reboots. But especially for doing repair because=
 if repair writes aren't fully flushed to disk, and then there's a crash=
 - I expect there'd be a lot of confusion, possibly unrepairable.

I can't tell from the dmesg if the out of order writes are due to the co=
mmand queue errors. It's actually pretty common that the drive firmware =
will silently ignore flush fua, and doesn't even always ignore. In which=
 case you never know about it until there's a crash or power failure and=
 then a problem appears.




>=20
> I have another Linux system I want to use to fix the Btrfs errors, it'=
s running MX Linux. I have updated btrfs-progs from Debian backports rep=
ository so the system is:
>=20
> unfa@mx-workstation ~> btrfs --version=20
> btrfs-progs v6.14=20
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=
=3Dbuiltin=20
> unfa@mx-workstation ~> uname -a=20
> Linux mx-workstation 6.15.11-1-liquorix-amd64 #1 ZEN SMP PREEMPT_DYNAM=
IC liquorix 6.15-12~mx23ahs (2025-08-23) x86_64 GNU/Linux
> Is that configuration of kernel + btrfs-progs versions safe to run btr=
fs check --repari on my broken Btrfs FS?

The versions are fine, but again the Btrfs probably isn't broken. The pr=
oblem reported by the older btrfs check is a minor issue and unrelated t=
o what's going on. It's a good idea to run the `btrfs check` (no repair)=
 with the new version and post that here and see if there are different =
problems.

Also, `btrfs check --mode=3Dlowmem` might reveal different problems sinc=
e it's a different implementation of check. So it's worth seeing that ou=
tput as well.


> Thank you once more for detailed write-up. I'll look into UDEV to disa=
ble the write cache for them and the UAS driver. I was hoping UAS can gi=
ve me better performance over USB 3.2, but if it's buggy it might be not=
 worth the risk.

It's possible the newer kernel will resolve the problem. These sorts of =
quirks are constantly being fixed in the kernel. But only if users repor=
t the problem to kernel usb folks.


--
Chris Murphy

