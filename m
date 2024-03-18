Return-Path: <linux-btrfs+bounces-3364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65EB87F09D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 20:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C65D1F229D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C813557870;
	Mon, 18 Mar 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo0nF5R6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61D56B65;
	Mon, 18 Mar 2024 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791687; cv=none; b=ujea2S4uFqRfXQgYO4KrAkueMwX3PVTM7m8hfV9xlKrKi9RL41bRqgHfp0YR6Ujx+j1ecuK7X5Xas7y0ZOqCV6WP4lyMF0/Zz+kW+GJwlT/cZXEp/MFmWDKhTcKKCrtowp2GwGcmRFufsDIHJU6eMDNruDU1VXVik6o+/GHa5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791687; c=relaxed/simple;
	bh=s/GlI77nhpoyF7nqB57RZS8CBs9kgoviJP8LQwcdaAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbZvES+J1nCWSSfOcW/bNuKihgTMjUIG99QIPGl66VJ2TMxjCE+Fo8w50n97QTSLffzpaQkCAYKaRIFG0QXQQUqMDdNBijGxdUhxgDmTFbJArFB5zcKOd5LXruxBXhZWSaqhJaQrpKnQqN1vh0+gqI4jIVw00Ivrj2O//KmsZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo0nF5R6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C052C433F1;
	Mon, 18 Mar 2024 19:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710791686;
	bh=s/GlI77nhpoyF7nqB57RZS8CBs9kgoviJP8LQwcdaAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Eo0nF5R6r9txrHFwPWE5OTKXgMViY/YI6pJWiihFa/b1kVkuHiHfO9xATgklQZbgN
	 S6Q5IJV4ADBIV5GvhJ66VeGJProypYVi0eNsvbVPVjA4YLpb6xn191t/qIe8mNCZ+q
	 GzyvbFMg5KKp6c71RpMERyYCBzhCgma6E1OZt+twLD8d7pEwsN1l7NztYeeo+VBF+/
	 n7Hci9VCaI78l4aAxuINA9kYorLjyCZFn09zfGn9JK2rF2us4n5W5VH3UgVueVkX8y
	 ac5oaHhKqJpUAt+5bRW5IThFLUnio6U3DO/uHa7rimVBrYH0ncDXUrDqmgxbcFbOez
	 rgW6qjQFDGCrA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a468004667aso496311366b.2;
        Mon, 18 Mar 2024 12:54:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXHtB2pTyng8vr6CwVFrykP1/yPBSLSU6O+GjTcCVGRuDIlAI4Mx5Hg4ZnXNeosIdEWPncsbjVOg9ryziO2NbDXKvQio7IA08J0ypLqsBhwmEAfFlGLkubYuS9s9qWNWj7aqY=
X-Gm-Message-State: AOJu0YxHyvAIuI1ijBIZNAujFkMvZ/r0Z+FYnPIOUkOiJbGYsJmbccf3
	d9NavdV90xIJwgY3ZgyOzt54DF5JtpRlreFDBfOgjbMDMDpyIDhsXQhC21LcfFwUvPAU6CJ+tt1
	PqSQwASKuqHb8qg5VtxsByrKzQgQ=
X-Google-Smtp-Source: AGHT+IFcvmpMRMxhrxS0jPVzAOQddA1tbYien6oVUFIPuNadw5dSlNWCK60hq0TBhfPIBVFlcSsxup1vREoeUoq7p2s=
X-Received: by 2002:a17:906:33c8:b0:a46:8daa:436f with SMTP id
 w8-20020a17090633c800b00a468daa436fmr5825491eja.69.1710791685020; Mon, 18 Mar
 2024 12:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <c54030e9a9e202f36e6002fb533810bc5e8a6b9b.1710409033.git.wqu@suse.com>
 <CAL3q7H7hMVH+YcTY1LufgjTHjKKc6AQyOb-RmppHBskf4h0wDQ@mail.gmail.com> <0d28c03f-56f1-4c7c-b278-bf5ea6de08e7@gmx.com>
In-Reply-To: <0d28c03f-56f1-4c7c-b278-bf5ea6de08e7@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 18 Mar 2024 19:54:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Q=VjLemvU15D7tnUJNPi3spctDbnk06SPxdDKcqSJrg@mail.gmail.com>
Message-ID: <CAL3q7H6Q=VjLemvU15D7tnUJNPi3spctDbnk06SPxdDKcqSJrg@mail.gmail.com>
Subject: Re: [PATCH 2/7] btrfs: reduce the log level for btrfs_dev_stat_inc_and_print()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 8:26=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/3/15 03:47, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Mar 14, 2024 at 9:54=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Currently when we increase the device statistics, it would always lead
> >> to an error message in the kernel log.
> >>
> >> I would argue this behavior is not ideal:
> >>
> >> - It would flood the dmesg and bury real important messages
> >>    One common scenario is scrub.
> >>    If scrub hit some errors, it would cause both scrub and
> >>    btrfs_dev_stat_inc_and_print() to print error messages.
> >>
> >>    And in that case, btrfs_dev_stat_inc_and_print() is completely
> >>    useless.
> >>
> >> - The results of btrfs_dev_stat_inc_and_print() is mostly for history
> >>    monitoring, doesn't has enough details
> >>
> >>    If we trigger the errors during regular read, such messages from
> >>    btrfs_dev_stat_inc_and_print() won't help us to locate the cause
> >>    either.
> >>
> >> The real usage for the btrfs device statistics is for some user space
> >> daemon to check if there is any new errors, acting like some checks on
> >> SMART, thus we don't really need/want those messages in dmesg.
> >>
> >> This patch would reduce the log level to debug (disabled by default) f=
or
> >> btrfs_dev_stat_inc_and_print().
> >> For users really want to utilize btrfs devices statistics, they should
> >> go check "btrfs device stats" periodically, and we should focus the
> >> kernel error messages to more important things.
> >
> > Not sure if this is the right thing to do.
> >
> > In the scrub context it can be annoying for sure.
> > Other cases I'm not so sure about, because having error messages in
> > dmesg/syslog may help notice issues more quickly.
>
> For non-scrub cases, I'd argue we already have enough output:
>
> No matter if the error is fixed or not, every time a mirror got csum
> mismatch or other errors, we already have error message output:
>
>   Data: btrfs_print_data_csum_error()
>   Meta: btrfs_validate_extent_buffer()
>
> For repaired ones, we have extra output from bio layer for both metadata
> and data:
>   btrfs_repair_io_failure()
>
> So I'd say the dev_stat ones are already duplicated.

Ok, I suppose it's fine then.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Thanks,
> Qu
> >
> >>
> >> CC: stable@vger.kernel.org
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/volumes.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index e49935a54da0..126145950ed3 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -7828,7 +7828,7 @@ void btrfs_dev_stat_inc_and_print(struct btrfs_d=
evice *dev, int index)
> >>
> >>          if (!dev->dev_stats_valid)
> >>                  return;
> >> -       btrfs_err_rl_in_rcu(dev->fs_info,
> >> +       btrfs_debug_rl_in_rcu(dev->fs_info,
> >>                  "bdev %s errs: wr %u, rd %u, flush %u, corrupt %u, ge=
n %u",
> >>                             btrfs_dev_name(dev),
> >>                             btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_WR=
ITE_ERRS),
> >> --
> >> 2.44.0
> >>
> >>
> >

