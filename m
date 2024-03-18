Return-Path: <linux-btrfs+bounces-3359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EE187ED45
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 17:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4116E1F229E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553C854665;
	Mon, 18 Mar 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4Qfm1g3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3D54279
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778656; cv=none; b=L7oOcNlGV8V749DGOD5TVyGu4mEG6VnOOJ1qyxYTQn2/8SpXC/kxnJRr1odrNjBejLnqi8vnDctBvVxe1F/mrjwEhwR9uhCj/tN7z7DMzJVSCrcoMUIMG5P8YF0VlYTfAR7k+P8zgS8XQ8hwWD5mFQ8JHxgVDsy4RAjmrBFOrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778656; c=relaxed/simple;
	bh=Jq7JUAck3p6gLBZKHIJJGgqROC2Itkcyh1of8e1v3rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUf1xcRgZbXlpwWADNzr4UcH/dDce40oLoDyFyLpLz/3ELIJ4An9qwE9qK2DZZDsLBYswyciazdtPIwWugXJXl61BwLrjmqdQhU3CX8V+yU4vyStbloxGomWkUrsB1e0wG0mxpOQ2Gk/N5Xak/1w1wlkaZOUKtuxiZskhDYdAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4Qfm1g3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1274DC43390
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710778656;
	bh=Jq7JUAck3p6gLBZKHIJJGgqROC2Itkcyh1of8e1v3rY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s4Qfm1g3lNDO3MB1+KbxN+sNOBpTrW2Ay+IaUHQeL2sXKEgUD6rDwRJQDgfROO+qx
	 RgZcLuG4KTKQKPEmedaaEfdei9zmmV+8eS4PLv2wWjEdQoIiYoWAsacQq2Z8lyBKGP
	 Luvgu0SRJ+myuTZsqK9zD0ZaZocs2GEAUsDyRmhftMRzIN/+n/ILIUFFKP7+V1XqyD
	 7bnhUxj+zjLyMx59iekES8hPQSRBvFWKKaMerJkivU7DE7svTloTDzG1hF+ZlmtNU5
	 aObMREUs+0OHOejUZlRnz1bzwJDUTHsSF3DLbM4oTaAiV0q5OnqrL4qg/3U4Zut3dz
	 ikhmuiyUgehPQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46ba938de0so192341666b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 09:17:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUE0O77jB9bgKAFd8FyMHgzRK5oD/F7/pZBqC+0KJz3e3s5Iou1US70hD/aCask1I7OIxddj2qL68xKCs25w0qb+A9esQBNxDiX1KY=
X-Gm-Message-State: AOJu0YxAMh665yNEavkX3jomMoQzvDe+nA9a6JQamwiBpmCZeCAc9ooe
	WJCQgOakmMs/mt78HrLmvR1pHzIe99nrAkK5dzJY3MwbEioYSaWyhYPhQOHUXtBViTJW3F71hnu
	JRih6mqj4UP/CPkvBf/fCCpR4E3c=
X-Google-Smtp-Source: AGHT+IH5wVReZxVBtiO86YaM9vkCw+DMDdvhzxTvlIS1ry5E49FQsBD/tylm+ExK1C3CAs24+T0/qUIlpgIOlqqLBuI=
X-Received: by 2002:a17:906:370c:b0:a46:c183:9ed8 with SMTP id
 d12-20020a170906370c00b00a46c1839ed8mr1944484ejc.10.1710778654608; Mon, 18
 Mar 2024 09:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <348c07314744f4914f5d613c516e9790f8c725b5.1710409033.git.wqu@suse.com>
 <CAL3q7H5Wgh4VEiNjX5_UOEftg55FAsi9Gy3SMZOVtkfKCszGoQ@mail.gmail.com> <c3f5aafc-9c9b-4b16-a71c-56985964318c@gmx.com>
In-Reply-To: <c3f5aafc-9c9b-4b16-a71c-56985964318c@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 18 Mar 2024 16:16:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H67XsqdDXAS57r8i8QZZsSVoMsEZZjGSeY=si7GNbiM1A@mail.gmail.com>
Message-ID: <CAL3q7H67XsqdDXAS57r8i8QZZsSVoMsEZZjGSeY=si7GNbiM1A@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs: scrub: remove unnecessary dev/physical lookup
 for scrub_stripe_report_errors()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 8:28=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/3/15 03:56, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Mar 14, 2024 at 9:50=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> The @stripe passed into scrub_stripe_report_errors() either has
> >> stripe->dev and stripe->physical properly populated (regular data
> >> stripes) or stripe->flags would have SCRUB_STRIPE_FLAG_NO_REPORT
> >> (RAID56 P/Q stripes).
> >>
> >> Thus there is no need to go with btrfs_map_block() to get the
> >> dev/physical.
> >>
> >> Just add an extra ASSERT() to make sure we get stripe->dev populated
> >> correctly.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/scrub.c | 59 ++++++----------------------------------------=
--
> >>   1 file changed, 7 insertions(+), 52 deletions(-)
> >>
> >> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> >> index 5e371ffdb37b..277583464371 100644
> >> --- a/fs/btrfs/scrub.c
> >> +++ b/fs/btrfs/scrub.c
> >> @@ -860,10 +860,8 @@ static void scrub_stripe_submit_repair_read(struc=
t scrub_stripe *stripe,
> >>   static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
> >>                                         struct scrub_stripe *stripe)
> >>   {
> >> -       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> >> -                                     DEFAULT_RATELIMIT_BURST);
> >>          struct btrfs_fs_info *fs_info =3D sctx->fs_info;
> >> -       struct btrfs_device *dev =3D NULL;
> >> +       struct btrfs_device *dev =3D stripe->dev;
> >>          u64 stripe_physical =3D stripe->physical;
> >>          int nr_data_sectors =3D 0;
> >>          int nr_meta_sectors =3D 0;
> >> @@ -874,35 +872,7 @@ static void scrub_stripe_report_errors(struct scr=
ub_ctx *sctx,
> >>          if (test_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state))
> >>                  return;
> >>
> >> -       /*
> >> -        * Init needed infos for error reporting.
> >> -        *
> >> -        * Although our scrub_stripe infrastructure is mostly based on=
 btrfs_submit_bio()
> >> -        * thus no need for dev/physical, error reporting still needs =
dev and physical.
> >> -        */
> >> -       if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_secto=
rs)) {
> >> -               u64 mapped_len =3D fs_info->sectorsize;
> >> -               struct btrfs_io_context *bioc =3D NULL;
> >> -               int stripe_index =3D stripe->mirror_num - 1;
> >> -               int ret;
> >> -
> >> -               /* For scrub, our mirror_num should always start at 1.=
 */
> >> -               ASSERT(stripe->mirror_num >=3D 1);
> >> -               ret =3D btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MI=
RRORS,
> >> -                                     stripe->logical, &mapped_len, &b=
ioc,
> >> -                                     NULL, NULL);
> >> -               /*
> >> -                * If we failed, dev will be NULL, and later detailed =
reports
> >> -                * will just be skipped.
> >> -                */
> >> -               if (ret < 0)
> >> -                       goto skip;
> >> -               stripe_physical =3D bioc->stripes[stripe_index].physic=
al;
> >> -               dev =3D bioc->stripes[stripe_index].dev;
> >> -               btrfs_put_bioc(bioc);
> >> -       }
> >> -
> >> -skip:
> >> +       ASSERT(dev);
> >>          for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, st=
ripe->nr_sectors) {
> >>                  u64 logical =3D stripe->logical +
> >>                                (sector_nr << fs_info->sectorsize_bits)=
;
> >> @@ -933,42 +903,27 @@ static void scrub_stripe_report_errors(struct sc=
rub_ctx *sctx,
> >>                   * output the message of repaired message.
> >>                   */
> >>                  if (repaired) {
> >> -                       if (dev) {
> >> -                               btrfs_err_rl_in_rcu(fs_info,
> >> +                       btrfs_err_rl_in_rcu(fs_info,
> >>                          "fixed up error at logical %llu on dev %s phy=
sical %llu",
> >>                                              logical, btrfs_dev_name(d=
ev),
> >>                                              physical);
> >> -                       } else {
> >> -                               btrfs_err_rl_in_rcu(fs_info,
> >> -                       "fixed up error at logical %llu on mirror %u",
> >> -                                           logical, stripe->mirror_nu=
m);
> >> -                       }
> >>                          continue;
> >>                  }
> >>
> >>                  /* The remaining are all for unrepaired. */
> >> -               if (dev) {
> >> -                       btrfs_err_rl_in_rcu(fs_info,
> >> +               btrfs_err_rl_in_rcu(fs_info,
> >>          "unable to fixup (regular) error at logical %llu on dev %s ph=
ysical %llu",
> >>                                              logical, btrfs_dev_name(d=
ev),
> >>                                              physical);
> >> -               } else {
> >> -                       btrfs_err_rl_in_rcu(fs_info,
> >> -       "unable to fixup (regular) error at logical %llu on mirror %u"=
,
> >> -                                           logical, stripe->mirror_nu=
m);
> >> -               }
> >>
> >>                  if (test_bit(sector_nr, &stripe->io_error_bitmap))
> >> -                       if (__ratelimit(&rs) && dev)
> >> -                               scrub_print_common_warning("i/o error"=
, dev,
> >> +                       scrub_print_common_warning("i/o error", dev,
> >>                                                       logical, physica=
l);
> >>                  if (test_bit(sector_nr, &stripe->csum_error_bitmap))
> >> -                       if (__ratelimit(&rs) && dev)
> >> -                               scrub_print_common_warning("checksum e=
rror", dev,
> >> +                       scrub_print_common_warning("checksum error", d=
ev,
> >>                                                       logical, physica=
l);
> >>                  if (test_bit(sector_nr, &stripe->meta_error_bitmap))
> >> -                       if (__ratelimit(&rs) && dev)
> >> -                               scrub_print_common_warning("header err=
or", dev,
> >> +                       scrub_print_common_warning("header error", dev=
,
> >
> > Why are we removing the rate limiting?
> > This seems like an unrelated change.
>
> Because the ratelimit is not consistent.
>
> E.g. the "fixed up error" line is not rated limited by @rs, but by
> btrfs_err_rl_in_rcu().

That I don't understand.

What I see is that scrub_print_common_warning() calls
btrfs_warn_in_rcu() or btrfs_warn() or scrub_print_warning_inode()
(which calls btrfs_warn_in_rcu()).
I don't see where btrfs_err_rl_in_rcu() is called. So to me it seems
@rs is doing the rate limiting.

>
> And we would have scrub_print_common_warning() to go btrfs_*_rl() helper
> in the coming patches.

Ok, but if @rs is indeed doing the rate limiting here, then from an
organization point of view, it should be removed in the later patch
that makes scrub_print_common_warning() use the btrfs_*_rl() helpers.

Thanks.

>
> Thanks,
> Qu
> >
> > Everything else looks ok.
> >
> > Thanks.
> >
> >>                                                       logical, physica=
l);
> >>          }
> >>
> >> --
> >> 2.44.0
> >>
> >>
> >

