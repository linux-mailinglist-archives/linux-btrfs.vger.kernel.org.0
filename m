Return-Path: <linux-btrfs+bounces-312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA07F4E93
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5F12812FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33325788A;
	Wed, 22 Nov 2023 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD81B8
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:42:11 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-507be298d2aso9213601e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700674929; x=1701279729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FJAOAWkMpb4IpmberTNs9YGWOz1IenKDAtSkd5Nd3k=;
        b=A7dC+rsdAQf33Kere4vPHWfJfWgvWhy5+wELs60tczvNKbs9F4MjJ6Wl+JVJj+Dike
         7ETie1y2Bi1kevIJuPlDwIbj6I2gsbhkRMaF+7/slLma3PmF8SM9FIw4DDT5pG19IITm
         26nuw8BPivkbXJvL2GsT/kF8hQmorZM39wCdHd474rZRja46HZfXniVLB035rAZw4wMi
         QdAdaevtvO4/PBw6TnFl8AdVaCeOkJKXLTWrXrWepFtaaofQQpM/QRm1k7YuqgcT+djC
         vM2L9I6RxszgYhktb4/LEP1x2GyME8dZCOeGnQ93QGC93L4XMVTYoXaVjFc3JdNP28ic
         3fZA==
X-Gm-Message-State: AOJu0Yyfbo53Z3TTStwZbWyqbFECP5jMHHaCZqRWz3Av8+paKRoRjnBO
	Q3ZWugf0LPDeOy1tI/qBrCcOHpLIGFKOzw==
X-Google-Smtp-Source: AGHT+IHzT8ZHiI7CiVv77dtsoRGH9gWMA3O0lYCZjaRnSWcwltqvtuchJllhvEcSJBFEWLJnPDK0tA==
X-Received: by 2002:ac2:561a:0:b0:50a:5df2:f30f with SMTP id v26-20020ac2561a000000b0050a5df2f30fmr2265881lfd.43.1700674928822;
        Wed, 22 Nov 2023 09:42:08 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id o14-20020a056512230e00b00501c51ab085sm1927351lfu.60.2023.11.22.09.42.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 09:42:08 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-507cee17b00so9202996e87.2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:42:08 -0800 (PST)
X-Received: by 2002:a05:6512:2397:b0:509:4424:2e0e with SMTP id
 c23-20020a056512239700b0050944242e0emr2785913lfv.0.1700674928238; Wed, 22 Nov
 2023 09:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700673401.git.josef@toxicpanda.com>
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 22 Nov 2023 12:41:30 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-oQ4Eh4vyidHWM-X_ppwE=_aV0Ra7EmL59ZKNQoT18SQ@mail.gmail.com>
Message-ID: <CAEg-Je-oQ4Eh4vyidHWM-X_ppwE=_aV0Ra7EmL59ZKNQoT18SQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] btrfs: convert to the new mount API
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 12:18=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> v2->v3:
> - Fixed up the various review comments from Dave and Anand.
> - Added a patch to drop the deprecated mount options we currently have.
>
> v1->v2:
> - Fixed up some nits and paste errors.
> - Fixed build failure with !ZONED.
> - Fixed accidentally dropping BINARY_MOUNTDATA flag.
> - Added Reviewed-by's collected up to this point.
>
> These have run through our CI a few times, they haven't introduced any
> regressions.
>
> --- Original email ---
> Hello,
>
> These patches convert us to use the new mount API.  Christian tried to do=
 this a
> few months ago, but ran afoul of our preference to have a bunch of small
> changes.  I started this series before I knew he had tried to convert us,=
 so
> there's a fair bit that's different, but I did copy his approach for the =
remount
> bit.  I've linked to the original patch where I took inspiration, Christi=
an let
> me know if you want some other annotation for credit, I wasn't really sur=
e the
> best way to do that.
>
> There are a few preparatory patches in the beginning, and then cleanups a=
t the
> end.  I took each call back one at a time to try and make it as small as
> possible.  The resulting code is less, but the diffstat shows more insert=
ions
> that deletions.  This is because there are some big comment blocks around=
 some
> of the more subtle things that we're doing to hopefully make it more clea=
r.
>
> This is currently running through our CI.  I thought it was fine last wee=
k but
> we had a bunch of new failures when I finished up the remount behavior.  =
However
> today I discovered this was a regression in btrfs-progs, and I'm re-runni=
ng the
> tests with the fixes.  If anything major breaks in the CI I'll resend wit=
h
> fixes, but I'm pretty sure these patches will pass without issue.
>
> I utilized __maybe_unused liberally to make sure everything compiled whil=
e
> applied.  The only "big" patch is where I went and removed the old API.  =
If
> requested I can break that up a bit more, but I didn't think it was neces=
sary.
> I did make sure to keep it in its own patch, so the switch to the new mou=
nt API
> path only has things we need to support the new mount API, and then the n=
ext
> patch removes the old code.  Thanks,
>
> Josef
>
> Christian Brauner (1):
>   fs: indicate request originates from old mount api
>
> Josef Bacik (18):
>   btrfs: split out the mount option validation code into its own helper
>   btrfs: set default compress type at btrfs_init_fs_info time
>   btrfs: move space cache settings into open_ctree
>   btrfs: do not allow free space tree rebuild on extent tree v2
>   btrfs: split out ro->rw and rw->ro helpers into their own functions
>   btrfs: add a NOSPACECACHE mount option flag
>   btrfs: add fs_parameter definitions
>   btrfs: add parse_param callback for the new mount api
>   btrfs: add fs context handling functions
>   btrfs: add reconfigure callback for fs_context
>   btrfs: add get_tree callback for new mount API
>   btrfs: handle the ro->rw transition for mounting different subovls
>   btrfs: switch to the new mount API
>   btrfs: move the device specific mount options to super.c
>   btrfs: remove old mount API code
>   btrfs: move one shot mount option clearing to super.c
>   btrfs: set clear_cache if we use usebackuproot
>   btrfs: remove code for inode_cache and recovery mount options
>
>  fs/btrfs/disk-io.c |   85 +-
>  fs/btrfs/disk-io.h |    1 -
>  fs/btrfs/fs.h      |   15 +-
>  fs/btrfs/super.c   | 2357 +++++++++++++++++++++++---------------------
>  fs/btrfs/super.h   |    5 +-
>  fs/btrfs/zoned.c   |   16 +-
>  fs/btrfs/zoned.h   |    6 +-
>  fs/namespace.c     |   11 +
>  8 files changed, 1263 insertions(+), 1233 deletions(-)
>
> --
> 2.41.0
>

Looks like my r-b wasn't picked up for this revision, but looking over
it, things seem to be fine.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

