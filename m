Return-Path: <linux-btrfs+bounces-812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E46280CE20
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 15:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98E21F21499
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6A487A8;
	Mon, 11 Dec 2023 14:18:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DA0824B;
	Mon, 11 Dec 2023 06:17:44 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a1e35c2807fso601095966b.3;
        Mon, 11 Dec 2023 06:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304262; x=1702909062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FeyufrOe65ZibAeQSako8BHcEODv5E1MPLsl6l5HtI=;
        b=fO6OzB0K2KNG1anlqD/oBq5jSfBeyJF83zhsJzP7ZWKwMkchP3fmUXDI6iiya5f38+
         G2hmBV2+W0a9XUZb2pJ7hC8niYharroqUjufcXYCPn0GuAxz/iqEs/Wxw17obUthgFDL
         zY27coh822FRBfkjtQwUHPWgsMi8XiKHMomNG9Zm4UOOFuTdtNnWxxHpClydS9K2+Cez
         +zBp4teEKVbM5M2ty+y+EBju7ELyveiRxzt7ib/GntGE7/eKxJld/mtbmdIsDT+Bt63I
         WQZnYVzoWMFhpMhhZcZRxGaX5O1sZWSwTfSp3zdAlo8jgpLAaQYwrOamhhoowPnOEAns
         MmSg==
X-Gm-Message-State: AOJu0Yz9uqJ309693OgpPJHuHVDSXIUl7qY+E6H8mg56bvog6hUoHw/2
	dmzxEAta2oAzz5EQb+sHdVXPK7EdEU3KLfXP
X-Google-Smtp-Source: AGHT+IElSDIxJjWSVnMjDAAtT2qsXohdRhPZR+zEeZhwnYUjsdGpL2ftL7TJVbc0Q0uo68D+fHJDSw==
X-Received: by 2002:a17:907:968c:b0:a1b:70fe:e896 with SMTP id hd12-20020a170907968c00b00a1b70fee896mr2542319ejc.130.1702304261904;
        Mon, 11 Dec 2023 06:17:41 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b00a1d754b30a9sm4839608ejc.86.2023.12.11.06.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 06:17:41 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so5724873a12.1;
        Mon, 11 Dec 2023 06:17:41 -0800 (PST)
X-Received: by 2002:a05:6402:1a59:b0:54c:4837:a659 with SMTP id
 bf25-20020a0564021a5900b0054c4837a659mr2627320edb.70.1702304261586; Mon, 11
 Dec 2023 06:17:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
In-Reply-To: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 11 Dec 2023 09:17:04 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_TFh9wF3K0JU2SPkskHB4A-KBkxVKKQ5yn1=PNSZQRdw@mail.gmail.com>
Message-ID: <CAEg-Je_TFh9wF3K0JU2SPkskHB4A-KBkxVKKQ5yn1=PNSZQRdw@mail.gmail.com>
Subject: Re: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
To: Eric Curtin <ecurtin@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Stephen Smoogen <ssmoogen@redhat.com>, Yariv Rachmani <yrachman@redhat.com>, 
	Daniel Walsh <dwalsh@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>, 
	Alexander Larsson <alexl@redhat.com>, Colin Walters <walters@redhat.com>, Brian Masney <bmasney@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>, Pavol Brilla <pbrilla@redhat.com>, 
	Lokesh Mandvekar <lmandvek@redhat.com>, =?UTF-8?B?UGV0ciDFoGFiYXRh?= <psabata@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, 
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 8:46=E2=80=AFAM Eric Curtin <ecurtin@redhat.com> wr=
ote:
>
> Hi All,
>
> We have recently been working on something called initoverlayfs, which
> we sent an RFC email to the systemd and dracut mailing lists to gather
> feedback. This is an exploratory email as we are unsure if a solution
> like this fits in userspace or kernelspace and we would like to gather
> feedback from the community.
>
> To describe this briefly, the idea is to use erofs+overlayfs as an
> initial filesystem rather than an initramfs. The benefits are, we can
> start userspace significantly faster as we do not have to unpack,
> decompress and populate a tmpfs upfront, instead we can rely on
> transparent decompression like lz4hc instead. What we believe is the
> greater benefit, is that we can have less fear of initial filesystem
> bloat, as when you are using transparent decompression you only pay
> for decompressing the bytes you actually use.
>
> We implemented the first version of this, by creating a small
> initramfs that only contains storage drivers, udev and a couple of 100
> lines of C code, just enough userspace to mount an erofs with
> transient overlay. Then we build a second initramfs which has all the
> contents of a normal everyday initramfs with all the bells and
> whistles and convert this into an erofs.
>
> Then at boot time you basically transition to this erofs+overlayfs in
> userspace and everything works as normal as it would in a traditional
> initramfs.
>
> The current implementation looks like this:
>
> ```
> From the filesystem perspective (roughly):
>
> fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs
>
> From the process perspective (roughly):
>
> fw -> bootloader -> kernel -> storage-init   -> init ----------------->
> ```
>
> But we have been asking the question whether we should be implementing
> this in kernelspace so it looks more like:
>
> ```
> From the filesystem perspective (roughly):
>
> fw -> bootloader -> kernel -> initoverlayfs -> rootfs
>
> From the process perspective (roughly):
>
> fw -> bootloader -> kernel -> init ----------------->
> ```
>
> The kind of questions we are asking are: Would it be possible to
> implement this in kernelspace so we could just mount the initial
> filesystem data as an erofs+overlayfs filesystem without unpacking,
> decompressing, copying the data to a tmpfs, etc.? Could we memmap the
> initramfs buffer and mount it like an erofs? What other considerations
> should be taken into account?
>
> Echo'ing Lennart we must also "keep in mind from the beginning how
> authentication of every component of your process shall work" as
> that's essential to a couple of different Linux distributions today.
>
> We kept this email short because we want people to read it and avoid
> duplicating information from elsewhere. The effort is described from
> different perspectives in the systemd/dracut RFC email and github
> README.md if you'd like to learn more, it's worth reading the
> discussion in the systemd mailing list:
>
> https://marc.info/?l=3Dsystemd-devel&m=3D170214639006704&w=3D2
>
> https://github.com/containers/initoverlayfs/blob/main/README.md
>
> We also received feedback informally in the community that it would be
> nice if we could optionally use btrfs as an alternative.
>
> Is mise le meas/Regards,
>
> Eric Curtin
>

Adding linux-btrfs@ to the discussion, because I think it'd be useful
to include them for what handling btrfs as an alternative to
erofs+overlayfs would look like.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

