Return-Path: <linux-btrfs+bounces-318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFE7F5312
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 23:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239871F20D22
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 22:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4E9200CA;
	Wed, 22 Nov 2023 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961751B5
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 14:12:42 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so32019966b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 14:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691161; x=1701295961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jawrr/5r4Mhd56Ot/pdvxEGuQ/lS8IZgu4zcsuNvL6s=;
        b=RV6NN6qzJdbWXrjMzoazpzTDvWRiqF16/r+533JNyk2zAmQEMx2ePc1DzrPnDVeLzH
         uqmqIXB40Pr2uHPwrHfKpXSVLFjDzg9XCzaUzbEK/yD3+mRC3IZZVQptX1jEaL7GTfbS
         9eFnoCG0SsNzskiyT3d/iYTREsGY2XwuP8fcuNH0kRErlzq5Aa7bE0dbJUv1A2y7pLz/
         EntNytDaYUfx1z6ad0PyxKMbkqsKYl9ctB0rQXjoIY7IAFtA7I0prNQszxgJPZNa0EN0
         5B/2eaJbpyUjjkLnb2xZEacGMvJj/AC0wOu4e4N9twWlM+7WJwZoHAuZoWuiyabSSdii
         7gLQ==
X-Gm-Message-State: AOJu0YzfIbzzYvQs8VMHovfndyTKAwPRuhabN3QFPVe2gw7fTDzoHqZZ
	ePW9heQnOZRSTjNm5+69fjcshkcwk0u31lSA
X-Google-Smtp-Source: AGHT+IE60L7dZd7h2emfO7nNSTgKNckbmuBccQN0Su0sWlTCGpAKw4MiJwVVfVrNHRbse4jZkTEQYQ==
X-Received: by 2002:a17:906:29e:b0:9fe:325b:5a25 with SMTP id 30-20020a170906029e00b009fe325b5a25mr2863108ejf.6.1700691160479;
        Wed, 22 Nov 2023 14:12:40 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906689600b009fc22b3f619sm277235ejr.68.2023.11.22.14.12.40
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 14:12:40 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-548b54ed16eso369225a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 14:12:40 -0800 (PST)
X-Received: by 2002:a17:906:3f45:b0:a04:47f5:f9cb with SMTP id
 f5-20020a1709063f4500b00a0447f5f9cbmr2726766ejj.48.1700691159923; Wed, 22 Nov
 2023 14:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700673401.git.josef@toxicpanda.com> <CAEg-Je-oQ4Eh4vyidHWM-X_ppwE=_aV0Ra7EmL59ZKNQoT18SQ@mail.gmail.com>
 <20231122182946.GE11264@twin.jikos.cz>
In-Reply-To: <20231122182946.GE11264@twin.jikos.cz>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 22 Nov 2023 17:12:02 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_A+yuMc4XvM_e+4BKMu0wEDM6WFtKxaEiA2apJyuH2wQ@mail.gmail.com>
Message-ID: <CAEg-Je_A+yuMc4XvM_e+4BKMu0wEDM6WFtKxaEiA2apJyuH2wQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] btrfs: convert to the new mount API
To: dsterba@suse.cz
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 1:37=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, Nov 22, 2023 at 12:41:30PM -0500, Neal Gompa wrote:
> > On Wed, Nov 22, 2023 at 12:18=E2=80=AFPM Josef Bacik <josef@toxicpanda.=
com> wrote:
> > >
> > > v2->v3:
> > > - Fixed up the various review comments from Dave and Anand.
> > > - Added a patch to drop the deprecated mount options we currently hav=
e.
> > >
> > > v1->v2:
> > > - Fixed up some nits and paste errors.
> > > - Fixed build failure with !ZONED.
> > > - Fixed accidentally dropping BINARY_MOUNTDATA flag.
> > > - Added Reviewed-by's collected up to this point.
> > >
> > > These have run through our CI a few times, they haven't introduced an=
y
> > > regressions.
> > >
> > > --- Original email ---
> > > Hello,
> > >
> > > These patches convert us to use the new mount API.  Christian tried t=
o do this a
> > > few months ago, but ran afoul of our preference to have a bunch of sm=
all
> > > changes.  I started this series before I knew he had tried to convert=
 us, so
> > > there's a fair bit that's different, but I did copy his approach for =
the remount
> > > bit.  I've linked to the original patch where I took inspiration, Chr=
istian let
> > > me know if you want some other annotation for credit, I wasn't really=
 sure the
> > > best way to do that.
> > >
> > > There are a few preparatory patches in the beginning, and then cleanu=
ps at the
> > > end.  I took each call back one at a time to try and make it as small=
 as
> > > possible.  The resulting code is less, but the diffstat shows more in=
sertions
> > > that deletions.  This is because there are some big comment blocks ar=
ound some
> > > of the more subtle things that we're doing to hopefully make it more =
clear.
> > >
> > > This is currently running through our CI.  I thought it was fine last=
 week but
> > > we had a bunch of new failures when I finished up the remount behavio=
r.  However
> > > today I discovered this was a regression in btrfs-progs, and I'm re-r=
unning the
> > > tests with the fixes.  If anything major breaks in the CI I'll resend=
 with
> > > fixes, but I'm pretty sure these patches will pass without issue.
> > >
> > > I utilized __maybe_unused liberally to make sure everything compiled =
while
> > > applied.  The only "big" patch is where I went and removed the old AP=
I.  If
> > > requested I can break that up a bit more, but I didn't think it was n=
ecessary.
> > > I did make sure to keep it in its own patch, so the switch to the new=
 mount API
> > > path only has things we need to support the new mount API, and then t=
he next
> > > patch removes the old code.  Thanks,
> > >
> > > Josef
> > >
> > > Christian Brauner (1):
> > >   fs: indicate request originates from old mount api
> > >
> > > Josef Bacik (18):
> > >   btrfs: split out the mount option validation code into its own help=
er
> > >   btrfs: set default compress type at btrfs_init_fs_info time
> > >   btrfs: move space cache settings into open_ctree
> > >   btrfs: do not allow free space tree rebuild on extent tree v2
> > >   btrfs: split out ro->rw and rw->ro helpers into their own functions
> > >   btrfs: add a NOSPACECACHE mount option flag
> > >   btrfs: add fs_parameter definitions
> > >   btrfs: add parse_param callback for the new mount api
> > >   btrfs: add fs context handling functions
> > >   btrfs: add reconfigure callback for fs_context
> > >   btrfs: add get_tree callback for new mount API
> > >   btrfs: handle the ro->rw transition for mounting different subovls
> > >   btrfs: switch to the new mount API
> > >   btrfs: move the device specific mount options to super.c
> > >   btrfs: remove old mount API code
> > >   btrfs: move one shot mount option clearing to super.c
> > >   btrfs: set clear_cache if we use usebackuproot
> > >   btrfs: remove code for inode_cache and recovery mount options
> > >
> > >  fs/btrfs/disk-io.c |   85 +-
> > >  fs/btrfs/disk-io.h |    1 -
> > >  fs/btrfs/fs.h      |   15 +-
> > >  fs/btrfs/super.c   | 2357 +++++++++++++++++++++++-------------------=
--
> > >  fs/btrfs/super.h   |    5 +-
> > >  fs/btrfs/zoned.c   |   16 +-
> > >  fs/btrfs/zoned.h   |    6 +-
> > >  fs/namespace.c     |   11 +
> > >  8 files changed, 1263 insertions(+), 1233 deletions(-)
> > >
> > > --
> > > 2.41.0
> > >
> >
> > Looks like my r-b wasn't picked up for this revision, but looking over
> > it, things seem to be fine.
>
> Honestly Neal, I don't know how I should interpret your Reviewed-by. You
> don't contribute code or otherwise comment on other patches on the
> technical level. If you as an involved user want to give feedback that
> some feature is desired then it's fine to do so but the rev-by tag is
> not the way to do that.
>
> https://docs.kernel.org/process/submitting-patches.html#using-reported-by=
-tested-by-reviewed-by-suggested-by-and-fixes

If it helps, I put "Reviewed-by" on patch sets that I have downloaded
and applied to a local build that I test and read to check to see that
they make sense.

If the patches make sense, build, and work for me, I'll send a
"Reviewed-by" statement. I figured that would be sufficient for
"Reviewed-by" statements. If there's something more you're expecting
for that, then please let me know. It's pretty rare that I'd test code
without at least looking at it and checking it over, so I don't feel
"Tested-by" makes sense.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

