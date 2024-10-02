Return-Path: <linux-btrfs+bounces-8422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA5D98CECB
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76273B20D56
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164B195FD5;
	Wed,  2 Oct 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="gVhkQpqM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DC194ACC
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857943; cv=none; b=mDTbU1ELjC3FFpJau8JSzcDC/RmYKg4Y6Xro3ND97znLsd212cDxkqUewruEW3/BXfDI9aGcJ0XwGp+D0SoqCq0gfC+EZSf5+nmjB0BhCoWKr71fjEwh+1GfOMxVrCbYWlwLamWrPIvs8h2CIC4N3PqU4lNBdTz18pr5vhKj+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857943; c=relaxed/simple;
	bh=81w1uyZWDFt81xEUzhMKjFLC+TXdWlBKloW1H5Sxxqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ly7gcHsiXmPDpnKPLcW1vNg2XA31KwW8z1guh+pOo60PR9NF5M3vLXV8ypE1CieAQQQc5cNcpWFD+anblltTp+DsUNStYlzuPsUN5CL8xqq5aUODmT6Ze4WTSDwzRYYS5WRJE0BYTBJmUUkqj+ZUmO8NwBFEel0wM10zCq5t2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=gVhkQpqM; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27d0e994ae3so3430984fac.3
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 01:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1727857937; x=1728462737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIuHWCkHowFMJURZtW/PtJAqgU7EyDaGzzFv/0Qw5Sc=;
        b=gVhkQpqMuErxbMqGbmsyGundoTEbDxn5PP4KIeBsbR2hqHJ/t1n5d2b0BwNVb72HND
         HMdjnCQr/JzFKuxpGNdIg5TOnEOk8Zi+OqkeQgGW01QM1we/UY4rca7CUpTvnitHnRnP
         kamiBxluY7xJa+wvVLwccJc3Oxbg97NPmBN5Cn1aV0Eh+df4BDCvqCs0U2IdGd98nqKo
         P3PZC8cSdnWzW9K1WnClBKvixX1OTPTiTdqvZYR44WxDGJ3bDB6k8x4LSDk0X+DHAH7E
         WU+UUbnU70x+JAmoYw9OsTuIS8jgF8drxy6IT84JziKIHBX4DSmdb4XMy0cG3KP/4YPM
         Z6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727857937; x=1728462737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIuHWCkHowFMJURZtW/PtJAqgU7EyDaGzzFv/0Qw5Sc=;
        b=Gd4QSlC/SHesjmciRN8rsntwUo48m96cG2/YvYIU08XCc+ijd9mXPwSJgiX3+cKQdc
         Nzb545vS0MnZ8YfC58v+aMiMNNH5GfF2J7y67TOlSh1qNkaj/1/QIrNAhnVg4W+ofX4W
         h5E22WpjgxMbw4dn2uDXsTTkYpmUQ3v1CvQtTFqcp5KlFqWpQlNKE92nQcYrOxVLoKmS
         +DywPW/CmbBQogls58j9WJrmFhb6hZ6TVCeODSGYrQgzn9666kzCUTA3NGWYKFjosFRS
         fqalK3U1AEUtmmY3nBEZJrpnNYw5t2uF2etjECwMcVXTJMoYOroh8nUXBGylnT138VfG
         rayQ==
X-Gm-Message-State: AOJu0YxA/iqAc+YAInTCdV4EasDASRLTzc6pqXh/VhJmwgyTCg6MTcH4
	JLMfoD199bzeIyR7YwZmoiP+qKpwQ58GVPxn3jF/SE/i8KNmyX2vTqZmA0i/TxAEB3vHKuCXS3P
	+8jZApyHR4vqwhor/Rb5iztekUY+FDCa9uK8amA==
X-Google-Smtp-Source: AGHT+IFMypSwxkBODIRh+pXezYr7ZfUET6JI6ux9mHNOt3wPzwTs9YSzIAptNKBd28sHoEPdGloA6Ap4esDRImC/mw0=
X-Received: by 2002:a05:6870:9724:b0:277:f722:45e1 with SMTP id
 586e51a60fabf-28788bc9f90mr1573308fac.17.1727857937249; Wed, 02 Oct 2024
 01:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOcd+r1Cwaa9SG=ND4RtuT0CBP4gmCE1tvj0uW-VybD2hry_uQ@mail.gmail.com>
 <CAL3q7H6xcBs20+O5T5yOkJ4KYnPjZjgzU2JsFpo29MDvb6_yEw@mail.gmail.com>
In-Reply-To: <CAL3q7H6xcBs20+O5T5yOkJ4KYnPjZjgzU2JsFpo29MDvb6_yEw@mail.gmail.com>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Wed, 2 Oct 2024 11:32:07 +0300
Message-ID: <CAOcd+r3XEEbFLrC_7Zs7bvah_Mms7R5-6ypweGKMaPC7VTRGYA@mail.gmail.com>
Subject: Re: assertion failed: ctl->total_bitmaps <= max_bitmaps
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <quwenruo@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Filipe,

Thank you for your response.

On Tue, Oct 1, 2024 at 2:28=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Tue, Oct 1, 2024 at 12:09=E2=80=AFPM Alex Lyakas <alex.lyakas@zadara.c=
om> wrote:
> >
> > Greetings,
> >
> > We have hit the above assert a few times in kernel 4.14 LTS with
> > stacks [1] [2] [3]. In all times it happens on a METADATA block group.
> > We are not using free space caching - not v1 and not v2 (free space
> > tree).
> >
> > I looked over the free space cache code in kernel 6.6 which is the
> > latest LTS kernel. However, I did not see a fix related to this issue.
> >
> > I did see a patch that prints some information about the block group
> > in case the above assert is fired
> > (https://www.spinics.net/lists/linux-btrfs/msg127072.html). We will
> > apply that patch.
> >
> > Is there any other way to move forward with this issue?
>
> With a 4.4 kernel, which is no longer supported, and supposing it's a
> zadara storage fork, you are on your own.
I realize that we are on our own, however, same issue was reported to
community by Qu Wenruo in
https://www.spinics.net/lists/linux-btrfs/msg127072.html

>
> We had a fix for a bug that matches what you are experiencing, but it
> didn't end up merged to 4.4 stable:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D3c17916510428dbccdf657de050c34e208347089
>
I actually saw that change when browsing kernel 6.6 LTS code, but I
did not trace the change to the commit above. Indeed I see that
METADATA block groups are subject to clustered allocation, so it looks
like this scenario is possible in our kernel.
I see that Nikolay's commit is marked as:

CC: <stable@vger.kernel.org> # 4.4+

So it should have been ported to 4.14 as well, but it wasn't.Looking
at the fix, I see it can be applied to 4.14 as well.

Thank you for your help,
Alex.





>
>
> >
> > Thanks,
> > Alex.
> >
> > [1]
> > Call Trace:
> >  dump_stack+0x5c/0x85
> >  panic+0xe4/0x252
> >  assfail.constprop.18+0x50/0x50 [btrfs]
> >  recalculate_thresholds+0xa5/0xb0 [btrfs]
> >  __btrfs_add_free_space+0x2d2/0x430 [btrfs]
> >  ? _raw_spin_unlock+0xa/0x20
> >  btrfs_free_tree_block+0x19a/0x2e0 [btrfs]
> >  btrfs_del_leaf+0xa5/0xd0 [btrfs]
> >  btrfs_del_items+0x3f9/0x470 [btrfs]
> >  ? btrfs_get_token_64+0x103/0x120 [btrfs]
> >  __btrfs_free_extent.isra.63+0x626/0xf60 [btrfs]
> >  __btrfs_run_delayed_refs+0x74d/0x1cf0 [btrfs]
> >  ? walk_up_proc+0xa2/0x600 [btrfs]
> >  btrfs_run_delayed_refs+0x62/0x270 [btrfs]
> >  btrfs_should_end_transaction+0x3e/0x60 [btrfs]
> >  btrfs_drop_snapshot+0x3db/0xf70 [btrfs]
> >  ? __schedule+0x298/0x8a0
> >  ? __btree_submit_bio_start+0x10/0x10 [btrfs]
> >  btrfs_clean_one_deleted_snapshot+0xb6/0xf0 [btrfs]
> >  cleaner_kthread+0x330/0x3b0 [btrfs]
> >  kthread+0x11a/0x130
> >  ? kthread_create_on_node+0x70/0x70
> >  ret_from_fork+0x1f/0x40
> >
> > [2]
> > [2512545.669387]  dump_stack+0x5c/0x85
> > [2512545.670047]  panic+0xe4/0x252
> > [2512545.670660]  assfail.constprop.18+0x50/0x50 [btrfs]
> > [2512545.671612]  recalculate_thresholds+0xa5/0xb0 [btrfs]
> > [2512545.672622]  __btrfs_add_free_space+0x2d2/0x430 [btrfs]
> > [2512545.673629]  ? _raw_spin_unlock+0xa/0x20
> > [2512545.674405]  btrfs_free_tree_block+0x19a/0x2e0 [btrfs]
> > [2512545.675401]  btrfs_del_leaf+0xa5/0xd0 [btrfs]
> > [2512545.676259]  btrfs_del_items+0x3f9/0x470 [btrfs]
> > [2512545.677165]  ? btrfs_get_token_64+0x103/0x120 [btrfs]
> > [2512545.678156]  __btrfs_free_extent.isra.63+0x626/0xfa0 [btrfs]
> > [2512545.679245]  __btrfs_run_delayed_refs+0x74d/0x1cf0 [btrfs]
> > [2512545.680285]  ? finish_task_switch+0x74/0x210
> > [2512545.681112]  btrfs_run_delayed_refs+0x62/0x270 [btrfs]
> >
> > [3]
> > [1272566.513241] Call Trace:
> > [1272566.513764]  dump_stack+0x5c/0x85
> > [1272566.514442]  panic+0xe4/0x252
> > [1272566.515080]  assfail.constprop.18+0x50/0x50 [btrfs]
> > [1272566.516071]  recalculate_thresholds+0xa5/0xb0 [btrfs]
> > [1272566.517119]  __btrfs_add_free_space+0x2d2/0x430 [btrfs]
> > [1272566.518155]  ? _raw_spin_unlock+0xa/0x20
> > [1272566.518963]  btrfs_free_tree_block+0x19a/0x2e0 [btrfs]
> > [1272566.519993]  btrfs_del_leaf+0xa5/0xd0 [btrfs]
> > [1272566.520891]  btrfs_del_items+0x3f9/0x470 [btrfs]
> > [1272566.521833]  ? btrfs_get_token_64+0x103/0x120 [btrfs]
> > [1272566.522847]  __btrfs_free_extent.isra.63+0x626/0xfa0 [btrfs]
> > [1272566.523975]  __btrfs_run_delayed_refs+0x74d/0x1cf0 [btrfs]
> > [1272566.525082]  ? btrfs_add_delayed_data_ref+0x251/0x2b0 [btrfs]
> > [1272566.526235]  btrfs_run_delayed_refs+0x62/0x270 [btrfs]
> > [1272566.527283]  __btrfs_end_transaction+0x2fd/0x520 [btrfs]
> >

