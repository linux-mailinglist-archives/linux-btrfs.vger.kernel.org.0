Return-Path: <linux-btrfs+bounces-12751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04365A79130
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABB03A716B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911623A9A0;
	Wed,  2 Apr 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="Tkv3qT3C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D72D7BF
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743604256; cv=none; b=I6JGeeYpfMjrqnULC1HPSsTIknxI94+Y1vm/FtABmcldjU2krJIV8D3wr0/Hsyka09t8F3gU2sjXm9FSiWS+WAQXuu5JNE+oJPs8VpweaCxBG1Bae6qdWSK9wR6GptETbvYAo5cpqnGJPl40V19s/MKAq184mqiN94q/EnxBaOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743604256; c=relaxed/simple;
	bh=L4VJcd0sHxrOW/L6llRoEqIwmrjzEc3aWXMopy/7HIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bmZ0Ya7t39x+u2rTmLhAtJgUjb8zxDn1jDPO2/5ZI7S/jsa9si4xKEH3ge9YpUohXMgdX8ysxV2Xmb9RiB7rl3tt2tGfJwR8w/PxCTIYgQAZMaskkMNXXoGN2PwjQZzTKwnoIZ5n/HwKDhmM0aOO2cr/h4A4KMNAZkbrsD1dSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=Tkv3qT3C; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1743604246; x=1744209046; i=jimis@gmx.net;
	bh=UFFrocO51roItbgVkQtW1GT1kbROpx71mFYGlQKIGZ8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Tkv3qT3CJL7shrKgnfjP3N0J9/NiBL0AXN7RoNQ5UbANxld8EMOZOR/s9v/y91K+
	 5swxyTNLYlwkAcUQTMlQ3bp3yOYULgfVf6EHQJImT2/FO7mF9TSkNdtGmJDKupViN
	 MvcTrKHhIqMkb8NTd0ifOU9J3KUtfTwQoBqZX7Td4LzAIK2F/APsQ7uPaJrLENAGf
	 NU5aO5RUYPH5E/Qlb1evUzpagNU9DYsNO0ds9uWifN7vH6G5U367+0gap1Cud9gg7
	 fWBznlWPCZZ6+n48aORqjjt1KKNzbwoxypbalRIkTeiehXfkRAgrCPzgINp5l4hW+
	 gwwmMyYE+r7lE+CsQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1tiaik3M4B-00UjyX; Wed, 02
 Apr 2025 16:30:45 +0200
Date: Wed, 2 Apr 2025 16:30:44 +0200 (CEST)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net>
Message-ID: <b1bfd7a9-a6b3-708e-869b-c641fe381e2a@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com> <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net> <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
 <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net> <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com> <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:Id8X8FDkd0oLHysNhclpNWENWe7EJzS3lPc3fcown4FrGy4gmEP
 /vOnoP2pxuC8YDg1Q6vYKKD45eVeW7PCfF11HMXzAXhDrcjkb/GBPm2jY9HflRdHv53QclC
 Rln+zSyv2z5uWJ2mc2cWYLBSU3qylvitFWiXt95jyhwASZ8Kwo7AHz0nq2293rJPrMfWL1D
 +AWhhcM0laNaS59Rbjbag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5UmbJcIchvs=;LIk0AfccsabkEjK10OfRxwBmhW6
 21/lqP5BRo1kkwqQv+pIfQ7EC/MF907lzMkfiB5niaXN4JNwEQYPQGZRKKa0IgFlYyogWesp+
 bsfSNqRPw11+JJX6ZI3rX4+RfO6+rZYqKalQyATp4Ik0Frx41GuV5b0g+Ozq/wBtYta6+5KfW
 vWTk/ZkQetrDeNucyO0oRtL5gfsL8M/SFqCZplP6QfFyBOqkel5uVvhl/IUV7dNFSuRGBN3sI
 2/A2w+Rf/SOVZg2DRdrcildxfUYbFDekyqceJRbgZxOiCfaZXcQRN0KmC8MQ5ozXPt7bA3c+r
 8c3L/4JJtpR0mLwvqjTSoY2W21sPhI9o9x802UCTIvg4zUFkEx95KCcdoy2iueIHnz7Sh0M/O
 brfnCvygXNUxaiasMiU5qdL8MvMu3KXgScBb0LDuTiQTdKZNEpUW9LmxxV07ttk9DA6g4dpQg
 ERxyiBg+Gz0on5Mn2mwynmL5btZvRB3MFZ0r1mMVG0DRRU7hLtXja5StZKD0sNkUrOb8vRBR1
 55eqjHeOvBri5YtD369temLnzxUdQYjVjxPWQ13jlQqsq0/Te9A29dDk3/i/wX4DWUQrlQB4O
 3nGhUjm3fEvloBTavUHveZNE7UCQWGfX3aPPyfNebSg6Dvsdl9nGvK1HIpOEnNCAMThyhJG36
 wkZy5DQMyHx6dcvgvGMyNubdXVAPU0278Kp+u7Umq/6cTBwW5NxiL2owh4nG3d/ohzMG2M7/c
 2qc+34Y1kRUaZi/h3WApS6axT99Cl6SUqOvC9G4WJcsjGHRaWR4uDs7h99dPaagZEZJiWXjnC
 yxhr45ZChMKFvD7frufDPbN1i40p4Cb71fNFTd/caGIYx82rVvps70WZGHQDWssvRQZB2GCrJ
 Vi1Wr2rovjSVHZyJhOOoB6oB5IQF2CdE+kOC8ucNbS0UBhJSnkNZTDQH5/I83JfJvSfsJ+WHB
 tbi1GwaUZlRd9532iVtJhpe0SyLVLzFac0MbFu78qjmjm5bTUJEVS2Lju8OCldbFxMM4p3F81
 lgcactNxMuNsdqw+MlZZOYTHLSlnjgPKZSkphs9PsRrVKwBiUEloPvaWa7C1M5Li4rWrtpI+U
 muIQhKr7/uJVIT1KvKpYmWaY0nMN0MsIiNG+LqU4Q1T1O4uzTzdzNnshZdsfTztYy9vuHsfVM
 NsQDke5lfJI/NRqF9FzTU4kmdu21JPrYbh+XrgTtXVpujJIoJ6Aj5MSh9KxQ+kMSHRXEyIDVT
 L92C+scbqYI+wkjl++dVIF/FwXY0LBRFWi0CSuqijDoleD6Jdln0bneDct2oafRmL9udUb5e0
 jYh3jyuXHldXGVm9EwnMNJsN6l5cM+x5eZs1fXor7fNNPap6Kp8tUAqt8qce+adCipIPAp8oD
 suAYgRTWPro9InGF4Ew5hq+az1iC/APei9C4F15LqLlVYSC7P+FkMvLIiEGvyFXMVBhXU3up4
 oUP3a52HLdBurEzZ6O2RQfo3R4wE=
Content-Transfer-Encoding: quoted-printable

Hi Qu, do you find my wording technically accurate? I'm lacking insight
into Btrfs internals, so I'd appreciate your feedback.

Also I can resend the patch as an attachment generated from git-patch if
you prefer, just let me know if needed.

Thanks, Dimitris


P.S. As I mentioned in the previous mail, I would like to add to the docs
      a userspace command that detects if a file is marked as fallocate'd,
      i.e. never to-be-compressed. Is there such a thing?



On Fri, 28 Mar 2025, Dimitrios Apostolou wrote:
>
> How about this patch:
>
>
> diff --git a/Documentation/ch-compression.rst
> b/Documentation/ch-compression.rst
> index 30b8849c..2553a60c 100644
> --- a/Documentation/ch-compression.rst
> +++ b/Documentation/ch-compression.rst
> @@ -92,18 +92,34 @@ The ZSTD support includes levels -15..15, a subset o=
f
> full range of what ZSTD
>  provides. Levels -15..-1 are real-time with worse compression ratio, le=
vels
>  1..3 are near real-time with good compression, 4..8 are slower with
>  improved
>  compression and 9..15 try even harder though the resulting size may not=
 be
>  significantly improved. Higher levels also require more memory and as t=
hey
>  need
>  more CPU the system performance is affected.
>
>  Level 0 always maps to the default. The compression level does not affe=
ct
>  compatibility.
>
> +Exceptions
> +----------
> +
> +Any file that has been extended with the *fallocate* system call (which=
 is
> +invoked by *posix_fallocate*) will always be excepted from compression,=
 even
> +if future file growth is without *fallocate*, even if *force-compress* =
mount
> +option is used.
> +
> +The reason for this is that a successful *fallocate* call must guarante=
e
> that
> +writing to the allocated range wil not fail because of lack of space. T=
o
> +achieve this, btrfs disables COW (thus compression too) for the file.
> +
> +As a workaround, one can trigger a compressed rewrite for such a file u=
sing
> +the *btrfs defrag* command.
> +
> +
>  Incompressible data
>  -------------------
>
>  Files with already compressed data or with data that won't compress wel=
l
>  with
>  the CPU and memory constraints of the kernel implementations are using =
a
>  simple
>  decision logic. If the first portion of data being compressed is not
>  smaller
>  than the original, the compression of the file is disabled -- unless th=
e
>  filesystem is mounted with *compress-force*. In that case compression w=
ill
>  always be attempted on the file only to be later discarded. This is not
>  optimal
>
>

