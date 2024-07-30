Return-Path: <linux-btrfs+bounces-6864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B1940917
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 09:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C04DB23B0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DD18F2CA;
	Tue, 30 Jul 2024 07:09:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A37183098
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323390; cv=none; b=PMfShjlaUAwA+4wdm2BSsxPwloqAE9Ni++G9VVN+falGsdnMLZWk01n9RL2ZRmUO+UGcNMrGFx3YWJmcp4HKS5UyGt3T2tsl3X+8EaCiweD+PLqUMvqCLYNlS+E2qiHXpOG/iVQm9XoTA0L9joR7Uw+Dhqs8d5gnkangxCY4ZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323390; c=relaxed/simple;
	bh=vDZlFVhEr4OFYI4ADZNYw4bA46rS/zfbSEkpHJ3+hBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgoHA/20xgQyKcfDGMeGDjbs0I/bb3ec2rYoR7dfgxzt2Nb07zCfxTTFei9XK9NpeOGtou4AnLKvaaVdeyvzxK4yjtrvo55gMy5kaWIdcGXImOQN54/TELAs9XgOFQ0T2bXVcg1Q7KaUyA4doR8yChvAB19KbvBnBrEcqrGwisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6694b50a937so34688997b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 00:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323383; x=1722928183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGkdH9FO1XTKaYwteGz78RcXoBrvVOvSNu1wOlYUoYQ=;
        b=KLOzhqMJR/OhOiceKQvu1VA0d3PJN6jd43XWnKLFaan/Y+4rwizOUHJzJ0e0PWh/AV
         Dd73dDZKOfRd6P6/RHTBWP8CJN4xqJ3Ge3QccydIrXsf58QEIINLZ1iAxsiyt+eJ/ByX
         ER9o3w4atS5fiilW9f+E48dexg0DElJ5W6SETQonp9NgFABLJTU7Ripo84Clay8GdEji
         SR2RfAIfzZQC157kWdk5212u/8dkOngjPG8yal+N0Cy7ublBIcUpv56P5hudzofjrvQF
         dtALijggo3Vq5ADKlr5qv8mcUr+CBso2uceEgeqOCsuowBgn9wlNpRDwcYG3EO9QRoxE
         PKVw==
X-Gm-Message-State: AOJu0YxihB39enr2vJ8BEqmmGYBbeW/Q7KdNWhfMkJ6EljOuEHNimyf7
	G1ue19iwIICJ8RlvzhRE3SIpn9054dPLoi2RKYmvxAX0m5flgnX0kbDZZ0T6
X-Google-Smtp-Source: AGHT+IFj38Q4bDEr59oMrYReRFR2eX81ZTTVG2QAGJQA/e3dSPhLbQny0VZqUZSKVpb+pT+FPJMhCA==
X-Received: by 2002:a81:8187:0:b0:64b:75d8:5002 with SMTP id 00721157ae682-67a055ca8d2mr116885737b3.9.1722323383390;
        Tue, 30 Jul 2024 00:09:43 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024da8sm24323577b3.84.2024.07.30.00.09.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 00:09:43 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6519528f44fso28004027b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 00:09:43 -0700 (PDT)
X-Received: by 2002:a05:690c:23c1:b0:62c:c62e:e0db with SMTP id
 00721157ae682-67a0a60d465mr134863807b3.44.1722323383028; Tue, 30 Jul 2024
 00:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729200608.10722-1-dsterba@suse.com>
In-Reply-To: <20240729200608.10722-1-dsterba@suse.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jul 2024 09:09:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWj6eYUVVrUA1N4Vzpa9hpWAnCXd=gJzT8MgN1fUp9JAA@mail.gmail.com>
Message-ID: <CAMuHMdWj6eYUVVrUA1N4Vzpa9hpWAnCXd=gJzT8MgN1fUp9JAA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: initialize location to fix -Wmaybe-uninitialized
 in btrfs_lookup_dentry()
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Jul 29, 2024 at 10:06=E2=80=AFPM David Sterba <dsterba@suse.com> wr=
ote:
> Some arch + compiler combinations report a potentially unused variable
> location in btrfs_lookup_dentry(). This is a false alert as the variable
> is passed by value and always valid or there's an error. The compilers
> cannot probably reason about that although btrfs_inode_by_name() is in
> the same file.
>
>    >  + /kisskb/src/fs/btrfs/inode.c: error: 'location.objectid' may be u=
sed
>    +uninitialized in this function [-Werror=3Dmaybe-uninitialized]:  =3D>=
 5603:9
>    >  + /kisskb/src/fs/btrfs/inode.c: error: 'location.type' may be used
>    +uninitialized in this function [-Werror=3Dmaybe-uninitialized]:  =3D>=
 5674:5
>
>    m68k-gcc8/m68k-allmodconfig
>    mips-gcc8/mips-allmodconfig
>    powerpc-gcc5/powerpc-all{mod,yes}config
>    powerpc-gcc5/ppc64_defconfig
>
> Initialize it to zero, this should fix the warnings and won't change the
> behaviour as btrfs_inode_by_name() accepts only a root or inode item
> types, otherwise returns an error.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/linux-btrfs/bd4e9928-17b3-9257-8ba7-6b7f9bb=
b639a@linux-m68k.org/
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 32010127710d..333b0e8587a2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5667,7 +5667,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir=
, struct dentry *dentry)
>         struct inode *inode;
>         struct btrfs_root *root =3D BTRFS_I(dir)->root;
>         struct btrfs_root *sub_root =3D root;
> -       struct btrfs_key location;
> +       struct btrfs_key location =3D { 0 };
>         u8 di_type =3D 0;
>         int ret =3D 0;
>

Thanks, this gets rid of the failure for m68k/allmodconfig
(gcc version 8.4.0 (Ubuntu 8.4.0-3ubuntu1) and 9.5.0 (Ubuntu
9.5.0-1ubuntu1~22.04)).

On m68k, it didn't show up with gcc 10, 11, and 12.
Also, enabling CONFIG_CC_OPTIMIZE_FOR_SIZE fixed it for gcc 8/9.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

