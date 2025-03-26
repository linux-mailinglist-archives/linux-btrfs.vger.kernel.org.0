Return-Path: <linux-btrfs+bounces-12592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0390EA71655
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 13:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE87170186
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFEE1DED5F;
	Wed, 26 Mar 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="E3KChqIM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F920311
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991424; cv=none; b=jHjSpfw7UjGkw2ZE0WQVXuNOZR3RQRLsSNwGYJGu/UZBuiYScrLDk1ONFUJaGjJt3OSK9B4eskVa0S97LAFmHURndXhc5PjhCAwHLGJqdKphpI27btsKl+6i/gBmTFDxywIVoNaRpY74CIQvRxjp8LuROU4DKEeb1Zrri+/M9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991424; c=relaxed/simple;
	bh=js6aCO1aTwYb1EhmpWmhGPAXiY0eQ2rcKyv8QyVQqQE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XlM28VTlJ6i0ZG42GuHuCLzof3uq/FrGJlbG6a2UM988X53+qMe4IPjfc/u7bIzrKw/B4zheI7A4tja6Cs6TZd6xrri3VXVJQmPkwpSJvDTLVUKhyYu2j3JP1T6EgrWFraCM7S9IxKSyX6NVu4xlIw8g+YhXWFl5402HzLF2K1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=E3KChqIM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1742991352; x=1743596152; i=jimis@gmx.net;
	bh=5cOJjDLS1t1CukGA1iPJjoF2+Vsq3uYbXeFXNmxQ7J4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E3KChqIMam9oB6xBg/wodK/i2KQmtpM8rdpPljFG2yZ1aiL67l/nUcQ0kzIsv1KR
	 ZrhGrs16TQ8EXaeLrfPiEVaxzEHnyju/cfk8lC8xq8tqnsoIJ/WSoVmqpuJ6k/+1x
	 MD63kj88VqGCsK1IPULpSj9FDQfPq+V5qD/QxLsCr0xYnXiml0LdDx65x7fIgEM1k
	 aIlEKmKHB48JUCh5GH8PbkH/6CnxG3rWeqiM4rMvefpmx6LO7RPpaYprzeRCg9lmR
	 g8Ne9jyxVAJ9oh1uMNf06EjVIC7MghjYC6EU4heJILzfA8DE4PGjeE5CyeX0ClJk3
	 kv7foQx9tgTPBDr9Jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHEP-1tTrD10NoZ-00jQZi; Wed, 26
 Mar 2025 13:15:52 +0100
Date: Wed, 26 Mar 2025 13:15:47 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
Message-ID: <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:uDzpwtGv16lzYn/+IfwGDHpacxcu2FhPQf+8MIOo1C00OEaLtII
 jToVNH2XdObR+CViXclC7p4UeunUHXNKfnePLI8vdopy8YFW28A+JRPfim68jSG9dk50XyQ
 pm43S55EtNRR/GkGPlVT17ZxDGn1r94FmKssJemvaYb4uKznoc+4oam6B+Mmf6DKZLsyIEE
 v28bhdGIkCB6jWxdTAUVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ezshGa4zvIA=;AmUjvUmy4d1gqFta6HBcjECl3VQ
 dCXMbxwkD+DXHWA+i9O7CsPsAKlhQchv/9qOQM6AzUDzj4ambkxNZ9klUJm8s8H1LR9e8kj8b
 1he7JduxBEnZ+03Ul+QBY/HcA43p9uIVvcD54Y9oS3oSrUyrmvU4IFYUwIaj3IVWjNXKUPgQq
 os1VYnPSuqAGC2hhmYKo1MBe+H/pX4rdAP97oMYMhurdwknYvywa4S4M+zVnrJvjQX4B+08jo
 d+3elyl1Bg4uePA0QDsaTJ970KAntr/do/rysqH7zTH3D/asxMPRJrKmuj/yCkp72kr7qNQ6R
 SkjrBJD9WKMjb+KCF6wu3S9QR4xsE6WX67VmXR0XUOF/hpuCrZOzCraKfioIg5nEjqTM0h/F4
 hc+SqKVJ1y+mUx6QgQqNvv231v4dBfIvOst1guKmv8pR7wFJCao2Y2dwUj2PfL837ZbVckbZV
 TCjCRNEaGFByPQ/8l67LgEPb9xM4MyHNUeJqEgGyIBFKtJabbewxR8OTrshPyKUQy+Vx/qgmS
 /Ehc8EXVm16TGpwb3RE4Xl6dQ89wGxMWBJZOSy8U8Zfv3evRMD2X4BDo8pR6ki1l9fs+RN4Wa
 QIUiB7kEAz9BY3XxvrtsE6Jchp0jRFs+dZBsU6HPkncXWZ1T2r2YqFVDO+wfvX6o9fD0LUIrP
 J72R/y+7+rCFY2pZmJAigCVem7hAK120TUQjC7jWCZkXpUTK4ftz8GAbuYajNxQH3kcd7bKbj
 g3/lT7CSWAvaLGh4Yl0PQ8A2yZZSb+Ht3+XtEDCWNs9wi7JZa40Q8uqNP9ShXsxtcxUX38ebi
 8otTS3+yxnEvTy5EmZ7mgSzA17wJFJ+1WhNerPI5ZAuciNIA2t8WxcUIlzNgxhM6MouT+YQ4l
 wZxibMqAEvU4FcjPaHu+Oip3x7tOJbyOA3978B+AELaI0wYaz1QEbX3IQTVULnQ12l7/T7oDb
 IIdCb3F5z+HjpeXkym2sdVchqi658I+hfpXRkDdhXMI9wWBhGJx5Rdsc4xqtwPha+yWkHTsOo
 U9KT0WhyoZF9iVm3sqE71qRoz/vbyXSjJ9/Wi/2XTADNPVyAd4U3t1nW1SxpRvEsO+piOv4MR
 t0Hhwua7hrP0zpex8zNveELN/cH5LqpFGO+FUgwyveWQaf2H3RO7QcKXxGBBfXiIb8Uc0TMsH
 o5ZEO8xr9+ORTgSkF10iETICZFp+fgLZ7uKFtA9NJ0llSoahFiKiAYm3TLOwDMgSkyUjAOaUG
 eDv06M4Iqk2EPnoDjLs0Dm7Bn8dVNIGL+ZWnt+BfA8C1w7cTUo30NBqaQT0ooYa4zeJtk1kd0
 Ylc/GFMNtMxEABWQHbPTQh2camH3NINW6oC9CpFgFErRE/H8zoROwJ4yqxi3Z8cpXK6d636JB
 NPV7KyHCAgPe+Wzf7+OZ0Y5D0OMfIdOfaQNzC6Arkn/Ywc32hZ+ohu3x2dIJPzCgeux0Wg3nu
 9nK1RRA==
Content-Transfer-Encoding: quoted-printable

CC'ing Qu Wenruo from this thread

On Mon, 24 Mar 2025, Gerhard Wiesinger wrote:
>
> It's a known bug I also ran into, see the disucssion here:
> https://lore.kernel.org/all/b7995589-35a4-4595-baea-1dcdf1011d68@wiesing=
er.com/T/
> (It can't be easily fixed)

Hi Qu, reading this thread I understand that posix_fallocate() ends up
leaving files uncompressed forever in btrfs, regardless of mount options.
I see this in PostgreSQL that recently started using posix_fallocate().

You gave some information on why the solution is hard:
> There is a long existing problem with compression with preallocation.
>
> One easy example is, if we go compression for the preallocated range,
> what we do with the gap (compressed size is always smaller than the real
> size).
>
> If we leave the gap, then the read performance can be even worse, as now
> we have to read several small extents with gaps between them, vs a large
> contig read.

Can't the solution/workaround be way more simple, or stupid even?

* Either have fallocate(2) return EOPNOTSUPP on a force-compress
   filesystem, and leave the work-around to userspace,

* or fill up the holes with compressed zeros, basically implementing the
   work-around in kernelspace. I suspect this would be very cheap in a
   deduplicating filesystem like btrfs, since all the zero-filled
   compressed extents are essentially identical.


In any case, I think this should be documented in the btrfs documentation
about compression, [1] it would have saved me time. I can try to submit a
patch if you point me to the docs repo. Any other known cases where
compression is unexpectedly skipped?

[1] https://btrfs.readthedocs.io/en/latest/Compression.html


Thank you in advance,
Dimitris

