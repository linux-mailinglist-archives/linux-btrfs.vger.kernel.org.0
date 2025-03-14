Return-Path: <linux-btrfs+bounces-12282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0131DA61183
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 13:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC443ABD92
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4E11FF1D1;
	Fri, 14 Mar 2025 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="wmKnjtcN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B501FDA8A
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955851; cv=none; b=Ri5Z3+RY4HgJ5maaP6+b1oFwEBQS9EqtnQEW11OA/zJHb+7AtJHN3UEUo9F+DfuOk7dBu4QtLcQHwEc4x8XXKWEwiCduHejOiYli/O1borZwhBgL0qQyIVYCZfzvTiVwPZJape5YN/W7CdYJSmV1p+WNcDVBLNpdde/H/LBaAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955851; c=relaxed/simple;
	bh=Ikio2+MjmC7G4ScGF71RBWBGRqiSuOjsKXcjRr+zlLU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9t/+En3gQ6wDe2r5MIVhmTHK5uq18LH7D6e9EO11g6U8KAB7FY9eHnakOZ2+xFzXtrtDqVDO5olGFsgcruf2MM41cgGaPdweybM20gjbmYUOgPRc5QijVASfLtUFmri4tGH5edWWSdfqYpGkbcNRLuF1VUlUN097F2hjvvcM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=wmKnjtcN; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1741955278;
	bh=FV0yWDZoO7MFKbpsnx9fu0LKmdUBvkYv2psh22wWkM8=; l=3122;
	h=From:To:Reply-To:Subject:Date:In-Reply-To:References:From;
	b=wmKnjtcNU5tCjlvmFk0clIvSdt/vzRiXwb4Nta9QEcC41wr4XSasZt2yVlovPYbGF
	 iTq10yjJ2MskLCJmevbmCXzvRNtnIH08I+YlOPASsn1bnpkIs88SCMe3ZMqVD2pv7h
	 Hvz1NLUkllxZ3zNkrFFEj1jKoupO8AZ/06LNFHto=
Received: from xev.localnet (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.sws.net.au (Postfix) with ESMTPS id 37775179DD;
	Fri, 14 Mar 2025 23:27:56 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Reply-To: russell@coker.com.au
Subject: Re: strangely uncorrectable errors with RAID-5
Date: Fri, 14 Mar 2025 23:27:51 +1100
Message-ID: <1924801.tdWV9SEqCh@xev>
In-Reply-To: <0bedb9d8-0924-4c19-a5d1-9951b04f2781@suse.com>
References:
 <23840777.EfDdHjke4D@xev> <8439012.T7Z3S40VBb@cupcakke>
 <0bedb9d8-0924-4c19-a5d1-9951b04f2781@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 21 October 2024 15:26:19 AEDT Qu Wenruo wrote:
> With the recent RAID56 improves, I'd say RAID5 data + RAID1 metadata is
> usable, but I'm not sure how it will survive in a production environment.
> 
> Considering we have a lot of other problems out of our control, like bad
> disk flush behavior, and even hardware memory bitflips, I won't
> recommend RAID5 data for now, but I believe RAID56 for data has improved
> a lot.
> 
> If you want to experiment RAID1 metadata with RAID5 data and report
> back, I would appreciate the effort a lot.
> And from my last work on RAID56 (for data), it should survive your
> random corruption script.

Just to see if anything had changed I ran the same tests with RAID-5 data and 
metadata again with the Debian kernel 6.12.17-amd64 and this time got properly 
uncorrectable errors in less than a minute.  I don't know if the error 
happened faster and worse than before because of some kernel difference, luck, 
or some timing difference when running on different hardware.

The system is a Dell PowerEdge T630 with advanced ECC enabled so I don't think 
that memory bitflips are an issue here.

[  398.486860] BTRFS warning (device vdc): checksum error at logical 
5073338368 on dev /dev/vdc, physical 1705771008: metadata leaf (level 0) in 
tree 5
[  398.487367] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5073338368 on dev /dev/vdc physical 1705771008
[  398.487826] BTRFS warning (device vdc): checksum error at logical 
5073338368 on dev /dev/vdc, physical 1705771008: metadata leaf (level 0) in 
tree 5
[  398.488333] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5073338368 on dev /dev/vdc physical 1705771008
[  398.488792] BTRFS warning (device vdc): checksum error at logical 
5073338368 on dev /dev/vdc, physical 1705771008: metadata leaf (level 0) in 
tree 5
[  398.489308] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5073338368 on dev /dev/vdc physical 1705771008
[  398.489772] BTRFS warning (device vdc): checksum error at logical 
5073338368 on dev /dev/vdc, physical 1705771008: metadata leaf (level 0) in 
tree 5
[  398.490459] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5073338368 on dev /dev/vdc physical 1705771008
[  398.490926] BTRFS warning (device vdc): checksum error at logical 
5073338368 on dev /dev/vdc, physical 1705771008: metadata leaf (level 0) in 
tree 5
[  398.491435] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5073338368 on dev /dev/vdc physical 1705771008
[  398.491898] BTRFS warning (device vdc): checksum error at logical 
5073338368 on dev /dev/vdc, physical 1705771008: metadata leaf (level 0) in 
tree 5
[  398.492406] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5073338368 on dev /dev/vdc physical 1705771008
[  398.492868] BTRFS warning (device vdc): checksum error at logical 
5073338368 on dev /dev/vdc, physical 1705771008: metadata leaf (level 0) in 
tree 5

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




