Return-Path: <linux-btrfs+bounces-4960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB238C4D85
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D181F2258D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A3617C7C;
	Tue, 14 May 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKGZAYWm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD817583
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715674322; cv=none; b=ghLl9Miff8cfHKI6g3zGEQlPCpjmwEanq5f+rrBMua1F+RN0yOiuta4QE4Zo5OHT2YJb9RaPpbGHlHi/okUQRwsZ/KLCRdtWuXgtdjmLIvFZGztu4gCsR16L9ZEEtwHG86ozVDfEyGH9GAKJNWjgpHY97HXdUbfV1xYDfPk2EBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715674322; c=relaxed/simple;
	bh=4OXk2vr900qFQm13gLCZNKyS7Poo+1EoPrsL4pqszqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EnTZVl3muTOWp8S1o99Dmlu423Xz2ZRWpCV6w/jVpULaLDi7ZaBlSl+tXUbhuS4NrfqEiR91wLaJcY8FfHqdB7QWSbHDMYLo+68fuXLDCjBzGKDLUp/GkmRzgSWcFbXe8h90yhLmDDCdavjekdUevwPjV6pkQRxa2ZDC/F8z6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKGZAYWm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5221e161fa4so955113e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715674318; x=1716279118; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OXk2vr900qFQm13gLCZNKyS7Poo+1EoPrsL4pqszqQ=;
        b=DKGZAYWmu0teSRQND04kc5RPuTwzhcoi+IuEDzK+W+AUShZPwYnm3+nhReG/mv5PcB
         ebS48q0/EDa4Q8xja4qSs/s+0B1iIG7BKHywLcxxzrnSB9RhKbBkqP+NALcutPhsQh9P
         JiAbq7vb7RRjSEL6gmw2/LLsiaCRcWXbLzPsxevZbNRYk1xet1XfO8ZHCm3TvDQ3GGPg
         uWJl0vIi2lb6KO0GNb1avT0iJ06IhRpX6l4sU3NHJdnbdKIZbNwOOgEsC0so/u26W1HK
         RexSpc4mjGkT04V35rlGzxPSQUGkQWMBNQ+/euGERLZQwmGT0admph6j8JG/uCKeBFZo
         96gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715674318; x=1716279118;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OXk2vr900qFQm13gLCZNKyS7Poo+1EoPrsL4pqszqQ=;
        b=FAND5yOqjBkTpTfdjQOniuleaMSjuVxFryrAG15Hba9ck3zCmXZ277N/1PZrEtECl9
         wM3JKK7W8nRkEdhWkTDo15p+Zj3+oGLQXyStTDlED92Zs0GERErOF2Smf6i9Zk517KP/
         k0lUWK/6/wtB14OYeMfQkX/OZA5KEDp2O1Vaup6E5u9Njg3C+OvU/weTUo9kWiQHT37S
         fYh82eaB5jNblEzrU63vZ7+VdmKTmrLzBfG/j4oIPcw7ePabGCfpAQdmas3GxOjmDugK
         zA0CNmKicSfjM1RlIlTzKpfSCO1o0iFlx20f1kdvafS5LXwIap+Kbb2AkGrtzG1Z1me0
         aamQ==
X-Gm-Message-State: AOJu0Yzw6r8kV7dumFc6M+HqUNv4+tbAQwCj7jVTfftL6d2zts87Zv1l
	RSC4BiJUX5EdY6rJEGDwY9agO4xLyxwpt+KYFoPMleW+OXsKwRYY/Yy4gOxYqY1ubWtE/1uvQ2R
	2JtQt+RIegz4ihOsUo6W56mD7O/kT8Q==
X-Google-Smtp-Source: AGHT+IEb2Nd1AH7IVGd1YOTWdM8QLD8qw+EWeRW+62koDbZmQbn0bV7eZTkBCwr21cXmTUDof89+8AzZwom8nf0eE5k=
X-Received: by 2002:a2e:3c0e:0:b0:2e5:67a8:2e59 with SMTP id
 38308e7fff4ca-2e567a83391mr51493851fa.0.1715674317573; Tue, 14 May 2024
 01:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514072238.GA110925@tik.uni-stuttgart.de>
In-Reply-To: <20240514072238.GA110925@tik.uni-stuttgart.de>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Tue, 14 May 2024 11:11:45 +0300
Message-ID: <CAA91j0XJcCw3+p_owtwA8FWj3A=e5jWHyoLbF1s_ZC1-xKW=Bw@mail.gmail.com>
Subject: Re: list all subvolumes below given path?
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:30=E2=80=AFAM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
>
> I need to know all subvolumes below a given path.
>

That is rather vague.

> An example:
>
> /local/test is a subvolume of /local and contains some subvolumes itself:
>
> root@fex:/local/test# mount | grep /local
> /dev/sde1 on /local type btrfs (rw,relatime,space_cache,user_subvol_rm_al=
lowed,subvolid=3D5,subvol=3D/)
>
>
> This works but it is very slow on BIG filesystems:
>
> root@fex:/local/test# find . -inum 256
> .
> ./sv1
> ./sv1/sv1_1
> ./sv1/sv1_1/ss
> ./sv1/sv1_2
> ./sv2
>

Any number of different btrfs filesystems can be mounted below any
given path. You conflate "mount point" with "btrfs path". Can you
describe more precisely what you mean?

>
> This does not list sub-subvolumes and it contains the whole path up to th=
e
> btrfs root subvolume:
>

And that will not list any subvolume of any btrfs filesystem that does
not contain the $PWD. Your original requirement included them (or,
better, did not exclude them).

> root@fex:/local/test# btrfs subvolume list -o .
> ID 62531 gen 6079120 top level 62530 path test/sv1
> ID 62532 gen 6079120 top level 62530 path test/sv2
>
>
> This lists all subvolumes of the filesystem:
>
> root@fex:/local/test# btrfs subvolume list .
> ID 350 gen 6079851 top level 5 path home
> ID 505 gen 6079123 top level 350 path home/smc/test
> ID 621 gen 6079123 top level 350 path home/framstag/blubb
> ID 2524 gen 3666531 top level 621 path home/framstag/blubb/.snapshot/2017=
-12-02_1026.test
> ID 18082 gen 3666531 top level 621 path home/framstag/blubb/.snapshot/201=
9-07-18_0139.test
> ID 18091 gen 6079833 top level 5 path tmp/test
> ID 27760 gen 3666531 top level 621 path home/framstag/blubb/.snapshot/202=
0-07-10_1123.test
> ID 36104 gen 3666531 top level 621 path home/framstag/blubb/.snapshot/202=
1-05-31_1052.test
> ID 60430 gen 5849702 top level 621 path home/framstag/blubb/.snapshot/202=
4-02-16_1148.test
> ID 62480 gen 6073978 top level 350 path home/.snapshot/2024-05-11_0000.da=
ily
> ID 62504 gen 6073978 top level 350 path home/.snapshot/2024-05-12_0000.we=
ekly
> ID 62530 gen 6079831 top level 5 path test
> ID 62531 gen 6079120 top level 62530 path sv1
> ID 62532 gen 6079120 top level 62530 path sv2
> ID 62533 gen 6079120 top level 62531 path sv1/sv1_1
> ID 62534 gen 6079120 top level 62531 path sv1/sv1_2
> ID 62540 gen 6076249 top level 350 path home/.snapshot/2024-05-13_0000.da=
ily
> ID 62545 gen 6076377 top level 62533 path sv1/sv1_1/ss
> ID 62565 gen 6078533 top level 350 path home/.snapshot/2024-05-13_2100.ho=
urly
> ID 62566 gen 6078643 top level 350 path home/.snapshot/2024-05-13_2200.ho=
urly
> ID 62567 gen 6078751 top level 350 path home/.snapshot/2024-05-13_2300.ho=
urly
> ID 62568 gen 6078859 top level 350 path home/.snapshot/2024-05-14_0000.da=
ily
> ID 62569 gen 6078967 top level 350 path home/.snapshot/2024-05-14_0100.ho=
urly
> ID 62570 gen 6079075 top level 350 path home/.snapshot/2024-05-14_0200.ho=
urly
> ID 62571 gen 6079183 top level 350 path home/.snapshot/2024-05-14_0300.ho=
urly
> ID 62572 gen 6079292 top level 350 path home/.snapshot/2024-05-14_0400.ho=
urly
> ID 62573 gen 6079401 top level 350 path home/.snapshot/2024-05-14_0500.ho=
urly
> ID 62574 gen 6079509 top level 350 path home/.snapshot/2024-05-14_0600.ho=
urly
> ID 62575 gen 6079617 top level 350 path home/.snapshot/2024-05-14_0700.ho=
urly
> ID 62576 gen 6079725 top level 350 path home/.snapshot/2024-05-14_0800.ho=
urly
> ID 62577 gen 6079833 top level 350 path home/.snapshot/2024-05-14_0900.ho=
urly
>
> How do I know which subvolumes are below $PWD ?
>

You parse the current mount table to find out what subvolume contains
$PWD. But again - you may have arbitrary subvolumes from the same and
different filesystems mounted anywhere below $PWD and you only can
find it out by parsing the current mount table.

