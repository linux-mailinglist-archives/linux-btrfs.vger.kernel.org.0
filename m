Return-Path: <linux-btrfs+bounces-1276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D5825D0F
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 00:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A02E1C2350B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 23:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD55C360AF;
	Fri,  5 Jan 2024 23:11:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BE3609F
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so70630a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jan 2024 15:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704496259; x=1705101059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnW9mWezJzFnoOsXXfsEni1zeHgLaEiPfA2rSuqqDm4=;
        b=I2z9Wxw3rtFc3GtvfDU0k+qHVqTscbCZY3BQ2RVDr3AB4Bpued2a0Mksfbi30sQjLN
         tF7pLkytptgU5C4ROf1PH58RM9o8XkJmIpVA5xytlE/QMFmpedNW+V9cLARMPNfvJc2o
         WLXjM7Rg8/9xcrRRgk5GRTHhxPedBG+cWyADr3+rgs5infab0R4CmZ7KUrl6QrEbPQrN
         Dxuz1HhbmIJvniRB4RAhrLrM+FoEaGZ6iFXHoMdRWTmA7hqnYpvgvhb7WwjHVbvhslWP
         KFqZ1CBsooBUW+40+Ag7+rw1eSVcu0AOCQwTrWRl2ECGxfo6RVFmWWms5CHs5+QTLxif
         9gJA==
X-Gm-Message-State: AOJu0Yx8bzGtpMgkHTY9ZicJFY+1BJWMtqMja+na2/iGrrgQu4taXYj7
	N+bALofJ7MOFCgE84/1+LDaMA/MFVTdgIw==
X-Google-Smtp-Source: AGHT+IHDa3Hun8VaQcQjMGBBrdtH78vyyT16HewvAveaqoyWTW02HSK5NRujmv32CCwcFD088Z5X8w==
X-Received: by 2002:aa7:d294:0:b0:557:f97:4ec with SMTP id w20-20020aa7d294000000b005570f9704ecmr77726edq.79.1704496259244;
        Fri, 05 Jan 2024 15:10:59 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id s24-20020a056402015800b0054cb88a353dsm1437558edu.14.2024.01.05.15.10.58
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 15:10:58 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55745901085so88412a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jan 2024 15:10:58 -0800 (PST)
X-Received: by 2002:a17:906:6893:b0:a26:bd81:2cfb with SMTP id
 n19-20020a170906689300b00a26bd812cfbmr55245ejr.59.1704496258172; Fri, 05 Jan
 2024 15:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116160235.2708131-1-neal@gompa.dev> <20231213222529.GF3001@twin.jikos.cz>
In-Reply-To: <20231213222529.GF3001@twin.jikos.cz>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 5 Jan 2024 18:10:21 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9dqzz++FhTBA7ju_NV+3ZYBbC4KBDDwmz1hBgJyiUiSQ@mail.gmail.com>
Message-ID: <CAEg-Je9dqzz++FhTBA7ju_NV+3ZYBbC4KBDDwmz1hBgJyiUiSQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Enforce 4k sectorize by default for mkfs
To: dsterba@suse.cz
Cc: Linux BTRFS Development <linux-btrfs@vger.kernel.org>, Anand Jain <anand.jain@oracle.com>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Davide Cavalca <davide@cavalca.name>, Jens Axboe <axboe@fb.com>, 
	Asahi Lina <lina@asahilina.net>, Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 5:32=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Thu, Nov 16, 2023 at 11:02:23AM -0500, Neal Gompa wrote:
> > The Fedora Asahi SIG[0] is working on bringing up support for
> > Apple Silicon Macintosh computers through the Fedora Asahi Remix[1].
> >
> > Apple Silicon Macs are unusual in that they currently require 16k
> > page sizes, which means that the current default for mkfs.btrfs(8)
> > makes a filesystem that is unreadable on x86 PCs and most other ARM
> > PCs.
> >
> > This is now even more of a problem within Apple Silicon Macs as it is n=
ow
> > possible to nest 4K Fedora Linux VMs on 16K Fedora Asahi Remix machines=
 to
> > enable performant x86 emulation[2] and the host storage needs to be com=
patible
> > for both environments.
> >
> > Thus, I'd like to see us finally make the switchover to 4k sectorsize
> > for new filesystems by default, regardless of page size.
> >
> > The initial test run by Hector Martin[3] at request of Qu Wenruo
> > looked promising[4], and we've been running with this behavior on
> > Fedora Linux since Fedora Linux 36 (at around 6.2) with no issues.
> >
> > =3D=3D=3D Changelog =3D=3D=3D
> >
> > v4: Fixed minor errors in the cover letter and patch subject
> >
> > v3: Refreshed cover letter, rebased to latest, updated doc references f=
or v6.7
> >
> > v2: Rebased to latest, updated doc references for v6.6
> >
> > Final v1: Collected Reviewed-by tags for inclusion.
> >
> > RFC v2: Addressed documentation feedback
> >
> > RFC v1: Initial submission
> >
> > [0]: https://fedoraproject.org/wiki/SIGs/Asahi
> > [1]: https://fedora-asahi-remix.org/
> > [2]: https://sinrega.org/2023-10-06-using-microvms-for-gaming-on-fedora=
-asahi/
> > [3]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9cec=
a20263@suse.com/T/#m11d7939de96c43b3a7cdabc7c568d8bcafc7ca83
> > [4]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9cec=
a20263@suse.com/T/#mf382b78a8122b0cb82147a536c85b6a9098a2895
> >
> > Neal Gompa (1):
> >   btrfs-progs: mkfs: Enforce 4k sectorsize by default
>
> FYI, current plan is to add the change to 6.7 release with ETA in
> January. We've discussed this and given the increasing demand for that
> from various distros and testing coverage so done far it seems that it's
> sufficient.
>

Is this queued yet for the btrfs-progs v6.7 release? I don't see it in
your devel tree[1] yet...

[1]: https://github.com/kdave/btrfs-progs/commits/devel/


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

