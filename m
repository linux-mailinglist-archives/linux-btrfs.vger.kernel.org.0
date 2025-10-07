Return-Path: <linux-btrfs+bounces-17501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05034BC087D
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 09:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA8D04F37E6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6E256C89;
	Tue,  7 Oct 2025 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSGEGxr3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66F253B42;
	Tue,  7 Oct 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759823699; cv=none; b=P4+v0u2kCENH8hGYHAxfttWz/yWf2TTcTmzdICFMbaKPPIRY/lnIxJaDUaaFSAiMYU5WvssVQn8qTvdbfSHJwMmp56VYpczEH9gl1Og0X1G9QsZxnyH+ZHSRAgH2q0jU74aYOBAQ84JOfz1hCqt4RB7kGCOzU8mr4dV2R/TIWNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759823699; c=relaxed/simple;
	bh=/Pbn7A+9ytijygVRfmY/5/2+Y6t6ujnH219ws8HfL2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBe0XQ1W7GXp3CNtDpNlervFOX7U4fKEGGVqoUNoRA1pRgGO0CNckcIB8MXYWVZF+lWrEuUJA/XBFzmmf75FUbLeBrEoK0CWocLdWOvP+rRx6Di0u8PkuZf2uuMtPkAvowi841g724XUVQLgZCOsg3Zk4z6xU89BzYF59EDDXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSGEGxr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33C7C4CEF1;
	Tue,  7 Oct 2025 07:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759823699;
	bh=/Pbn7A+9ytijygVRfmY/5/2+Y6t6ujnH219ws8HfL2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSGEGxr37CiaTJPpX/SRpZjOiGDPm3pwV1dkeFSaXnCiwsQJ4HpLizrWlUJRFsHoK
	 /rF4+CNRtkwqO41jdps66Y16gU7w7T2/9wVkNg3PuByuj7GH4WZiyV4vCT18F5uVya
	 wZKGWdoq3rUDgriecV3/09pzgdGil4ll4XsdsDyWFb0nFvwOjS8Rm0pru2lU+yfOpG
	 jnkDkAtwTbcmtpkUGQdFDcZAtlO7MPGFbsJDUvEOlqkFEo3XbF2JHRkjap+H4D+oAr
	 0CpRL7YmwfQc0s4RDJ5RkXjmzjoOKnyGcKTGt3EmDnx6NezUnCehWHI/Vt4G8vYY3d
	 v8glk8gZMMLzw==
Date: Tue, 7 Oct 2025 09:54:53 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>, 
	Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	Hans Holmberg <Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] generic: basic smoke for filesystems on zoned block
 devices
Message-ID: <n64zgha736wog4njyvyaxatx752gi4bz6f72ndvopufmkjrcbg@koomim4nc5we>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
 <OtglCyTJgl3RCnletH8ai3IsE0wk2nR5CISvt5ZfvYPj85MMxGBFHEw9UmPSHvpve5QOIFQCXD9LFB1DpsNuAQ==@protonmail.internalid>
 <20251006132455.140149-3-johannes.thumshirn@wdc.com>
 <iqwkuhobfvpeiktvk6pba6ahirgzngltj3ilrifcfgaugme67s@r54pl6d6foys>
 <HrmrQh5_tyYRG7-S4mXfT51r0I3fEYRRn_bmQrtFUEC4pzDysiMvmPFKOt8LljOoC4M9aqBl6h-UkXVmuPfNCw==@protonmail.internalid>
 <78e121bd-8f6c-4b79-808c-9f5f75c90d8c@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78e121bd-8f6c-4b79-808c-9f5f75c90d8c@wdc.com>

On Tue, Oct 07, 2025 at 06:20:42AM +0000, Johannes Thumshirn wrote:
> On 10/6/25 8:40 PM, Carlos Maiolino wrote:
> > On Mon, Oct 06, 2025 at 03:24:55PM +0200, Johannes Thumshirn wrote:
> >> Add a basic smoke test for filesystems that support running on zoned
> >> block devices.
> >>
> >> It creates a zloop device with 2 sequential and 62 sequential zones,
> > This seems wrong? Don't you mean 2 conventional zones?
> > Also, won't the arguments used to create the zone dev end up creating 64
> > sequential zones? I might be very wrong here, so my apologies in advance
> > but looking into the zloop code this seems that 256MiB zone size will end
> > up creating 64 sequential zones instead of 62?
> 
> 2 conventional zones and 62 sequential zones, my mistake:

Ah, 64 is the total zone number not sequential only.

Other than the nitpick on the description, this looks fine then:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>


> 
> root@virtme-ng:/mnt# echo "$zloop_args" > /dev/zloop-control
> [   75.986238] zloop: Added device 0: 64 zones of 256 MB, 4096 B block size
> root@virtme-ng:/mnt# ls $zloopdir/0
> cnv-000000  seq-000011  seq-000022  seq-000033  seq-000044 seq-000055
> cnv-000001  seq-000012  seq-000023  seq-000034  seq-000045 seq-000056
> seq-000002  seq-000013  seq-000024  seq-000035  seq-000046 seq-000057
> seq-000003  seq-000014  seq-000025  seq-000036  seq-000047 seq-000058
> seq-000004  seq-000015  seq-000026  seq-000037  seq-000048 seq-000059
> seq-000005  seq-000016  seq-000027  seq-000038  seq-000049 seq-000060
> seq-000006  seq-000017  seq-000028  seq-000039  seq-000050 seq-000061
> seq-000007  seq-000018  seq-000029  seq-000040  seq-000051 seq-000062
> seq-000008  seq-000019  seq-000030  seq-000041  seq-000052 seq-000063
> seq-000009  seq-000020  seq-000031  seq-000042  seq-000053
> seq-000010  seq-000021  seq-000032  seq-000043  seq-000054
> 
> 

