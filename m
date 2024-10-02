Return-Path: <linux-btrfs+bounces-8463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694FF98E4D0
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 23:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D20FB203E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC01946B9;
	Wed,  2 Oct 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNQVcf+k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E9216A33
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904092; cv=none; b=ofJbZka/XKu+poYx1WbHSLQ7yyFg0C3ZkcSReY8du6peHaDQYr5ZKTqc/GsQq8hCH2sXXmESFa/RnfxO5DFKDZh1SCoj/heDgvkhBBP07B5Eyc8iEoPkbTCA5PO1RdmSZn0oQO+lL0V434KHHCe/pTMxeyMiQ/r8J72+/26sCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904092; c=relaxed/simple;
	bh=oWpbKrfVw8zXx7VLXmUm6GSVHxnCP8fvZq5HCSPItuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nErMBhP6imQPmM9yHWAqWxwSKQ1z5mIZng4WxAYwcuK0V6guHkC5ILSEi1yqn62y2N1/Vo2FPA+Mn1bNrfc/t0x/1yAYKEPd1BWX9iNqX6ThPy2X1dbNB8Oj1SWyFtnW/+ZCJnVky71d4/e4GedX4VaGZ4XGWqzRxul0nzg97e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNQVcf+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B32EC4CED0
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 21:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904090;
	bh=oWpbKrfVw8zXx7VLXmUm6GSVHxnCP8fvZq5HCSPItuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pNQVcf+kyFuN9uolFT2ArFVGUOAGocJ5rgEL1c4QvkJGhBYpOtk0zPa3o8e8kNHFC
	 PtWVOgdKvTgApcyR6OU+qLBGQgGzldnAfJHqNlYwX+JlJrrojhNzYObUSD/qbeb57w
	 zhNnC2m1vd+vgHX+ScYiYC4cOHGqQEjPc5IAsSN5bhI7Rbw2a2FBKl00H+KLlu/b1n
	 H98topFNtwdeYLDnx+pyRkN/9MJsA/68BFcL3BcWD8K4wUBlqsAUUYEDtcSjlHywFm
	 iIducM5139s8DRrTIjytW9NAKBlFOdgUy75rXU+k0oqsb1bUIkgEBjxCrKnprLFpDt
	 6aQsCj6amvf0Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398e33155fso230126e87.3
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 14:21:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXX2GJPYS/SC92eWC+LVmelvI0yJ0UrVmlckfpbzDqywxfAseCXggNnlE/hkNTL1pg+drVtb+fECGz3DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0ZRhkdLBMghvu6fuLZ8mRsHKDIXpX6e6ceCFkTRpXd36HyPb
	zNpD8z8dQ/Mq4EXRvNylOya9qJZ1takMtsXKV2hEiDzmOg1EMVuPcNmqr+kbj2UIsfDGBZ5ZUM5
	1rNmGSPjoGCxovqhGl72LnLCaogI=
X-Google-Smtp-Source: AGHT+IF+60Y6cnkyyIFXFRaPcco7qnGUs5ZnQislwqWOo8KeAev5xo95jV9E7YzHMyGspBwLEwyS2nlMGBvmXLpNy7s=
X-Received: by 2002:a05:6512:10c9:b0:539:94c4:d9cb with SMTP id
 2adb3069b0e04-539a06783afmr2941638e87.31.1727904088632; Wed, 02 Oct 2024
 14:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727222308.git.wqu@suse.com> <3b02eabf87e477dd25e21a4c2cf7720e530d7531.1727222308.git.wqu@suse.com>
 <CAL3q7H50O_LA8vje8JSH+xVM07VA55G286bWtUwfCdpzfVavfQ@mail.gmail.com> <421d016b-672e-4eb7-bd0c-3269eb675f66@gmx.com>
In-Reply-To: <421d016b-672e-4eb7-bd0c-3269eb675f66@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 2 Oct 2024 22:20:51 +0100
X-Gmail-Original-Message-ID: <CAL3q7H66XxddXSiOZ3AC1=fbpyJb+Q5TQrw9ZR=ac4e-wR72Nw@mail.gmail.com>
Message-ID: <CAL3q7H66XxddXSiOZ3AC1=fbpyJb+Q5TQrw9ZR=ac4e-wR72Nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: avoid unnecessary device path update for
 the same device
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Fabian Vogt <fvogt@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:09=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/10/2 23:44, Filipe Manana =E5=86=99=E9=81=93:
> > On Wed, Sep 25, 2024 at 1:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [PROBLEM]
> >> It is very common for udev to trigger device scan, and every time a
> >> mounted btrfs device got re-scan from different soft links, we will ge=
t
> >> some of unnecessary device path updates, this is especially common
> >> for LVM based storage:
> >>
> >>   # lvs
> >>    scratch1 test -wi-ao---- 10.00g
> >>    scratch2 test -wi-a----- 10.00g
> >>    scratch3 test -wi-a----- 10.00g
> >>    scratch4 test -wi-a----- 10.00g
> >>    scratch5 test -wi-a----- 10.00g
> >>    test     test -wi-a----- 10.00g
> >>
> >>   # mkfs.btrfs -f /dev/test/scratch1
> >>   # mount /dev/test/scratch1 /mnt/btrfs
> >>   # dmesg -c
> >>   [  205.705234] BTRFS: device fsid 7be2602f-9e35-4ecf-a6ff-9e91d2c182=
c9 devid 1 transid 6 /dev/mapper/test-scratch1 (253:4) scanned by mount (11=
54)
> >>   [  205.710864] BTRFS info (device dm-4): first mount of filesystem 7=
be2602f-9e35-4ecf-a6ff-9e91d2c182c9
> >>   [  205.711923] BTRFS info (device dm-4): using crc32c (crc32c-intel)=
 checksum algorithm
> >>   [  205.713856] BTRFS info (device dm-4): using free-space-tree
> >>   [  205.722324] BTRFS info (device dm-4): checking UUID tree
> >>
> >> So far so good, but even if we just touched any soft link of
> >> "dm-4", we will get quite some unnecessary device path updates.
> >>
> >>   # touch /dev/mapper/test-scratch1
> >>   # dmesg -c
> >>   [  469.295796] BTRFS info: devid 1 device path /dev/mapper/test-scra=
tch1 changed to /dev/dm-4 scanned by (udev-worker) (1221)
> >>   [  469.300494] BTRFS info: devid 1 device path /dev/dm-4 changed to =
/dev/mapper/test-scratch1 scanned by (udev-worker) (1221)
> >>
> >> Such device path rename is unnecessary and can lead to random path
> >> change due to the udev race.
> >>
> >> [CAUSE]
> >> Inside device_list_add(), we are using a very primitive way checking i=
f
> >> the device has changed, strcmp().
> >>
> >> Which can never handle links well, no matter if it's hard or soft link=
s.
> >>
> >> So every different link of the same device will be treated as a differ=
ent
> >> device, causing the unnecessary device path update.
> >>
> >> [FIX]
> >> Introduce a helper, is_same_device(), and use path_equal() to properly
> >> detect the same block device.
> >> So that the different soft links won't trigger the rename race.
> >>
> >> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1230641
> >> Reported-by: Fabian Vogt <fvogt@suse.com>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/volumes.c | 28 +++++++++++++++++++++++++++-
> >>   1 file changed, 27 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 995b0647f538..b713e4ebb362 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -732,6 +732,32 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_su=
per_block *sb)
> >>          return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
> >>   }
> >>
> >> +static bool is_same_device(struct btrfs_device *device, const char *n=
ew_path)
> >> +{
> >> +       struct path old =3D { .mnt =3D NULL, .dentry =3D NULL };
> >> +       struct path new =3D { .mnt =3D NULL, .dentry =3D NULL };
> >> +       char *old_path;
> >> +       bool is_same =3D false;
> >> +       int ret;
> >> +
> >> +       if (!device->name)
> >> +               goto out;
> >> +
> >> +       old_path =3D rcu_str_deref(device->name);
> >
> > There's a missing rcu_read_lock / unlock btw. It's triggering warnings
> > in the test vms.
>
> Thanks a lot, I was also wondering if it's the case, but the zoned code
> gave me a bad example of not calling rcu_read_lock().

It doesn't call rcu_read_lock() explicitly because it uses the
btrfs_*_in_rcu() log functions, which do the locking.
Except for one place for which I've sent a patch earlier today.

>
> Shouldn't all btrfs_dev_name() and the usages inside zoned code also be
> fixed?

Except for that single case, there's no other case anywhere else,
zoned code or non-zoned code.

>
> Thanks,
> Qu
> >
> > Thanks.
> >
> >> +       ret =3D kern_path(old_path, LOOKUP_FOLLOW, &old);
> >> +       if (ret)
> >> +               goto out;
> >> +       ret =3D kern_path(new_path, LOOKUP_FOLLOW, &new);
> >> +       if (ret)
> >> +               goto out;
> >> +       if (path_equal(&old, &new))
> >> +               is_same =3D true;
> >> +out:
> >> +       path_put(&old);
> >> +       path_put(&new);
> >> +       return is_same;
> >> +}
> >> +
> >>   /*
> >>    * Add new device to list of registered devices
> >>    *
> >> @@ -852,7 +878,7 @@ static noinline struct btrfs_device *device_list_a=
dd(const char *path,
> >>                                  MAJOR(path_devt), MINOR(path_devt),
> >>                                  current->comm, task_pid_nr(current));
> >>
> >> -       } else if (!device->name || strcmp(device->name->str, path)) {
> >> +       } else if (!device->name || !is_same_device(device, path)) {
> >>                  /*
> >>                   * When FS is already mounted.
> >>                   * 1. If you are here and if the device->name is NULL=
 that
> >> --
> >> 2.46.1
> >>
> >>
> >
>

