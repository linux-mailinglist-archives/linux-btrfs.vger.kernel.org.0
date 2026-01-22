Return-Path: <linux-btrfs+bounces-20910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPvcLVkAcmmvZwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20910-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 11:47:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E56579C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AEEB884081
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1CA3E958C;
	Thu, 22 Jan 2026 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As6iBhe4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35343A9D80
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078341; cv=none; b=QRseb59QhpnUNDQaTkYpVPXYnTxbN5Mv+7kFu2HWVqPCQbpJHjkAM5jVjqt47pLTV5yh0jGB97Btq/AWSsICJG1TJObFp5PBQ4Vg9g2wSKGr6qRHqpk5Rk6SzWvsLIvQkFIKSBvTYT27ZCGvxRdmtkcToZlbpIA2KU2dPFrVSN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078341; c=relaxed/simple;
	bh=Er2PILDtmBIwjw3DR1lIx7c+nlO43/jjpZJHN3ytAO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vz+4pyumo+c0EjTUhMCcSb06JfhF2nLF+xgiAzrAu2p0nKChL9nU29Aaxqlc152lwuWc2oyhLS5hGf1W5r3v90afBDKe+jRQgLLOCB7BNo6oKfHBDrjLzP1HnkwRLt+xZOHeEGZO8Wv5SGAnSrwFXEkbLnbbLpIc3HnP9ZmhaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As6iBhe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E91C19423
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078339;
	bh=Er2PILDtmBIwjw3DR1lIx7c+nlO43/jjpZJHN3ytAO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=As6iBhe4/C+5ZZKEdLrOfkFXFkRwAbzul8F/4HSZ7levaqB539JVj8BrUFojUFDrM
	 zBA6wXCMEB69OPhs0i/NlI/VmjfZKPwLdvkLEg3NzUuoDJ6O77Q8e+8JRIT2/pvDPN
	 F8h5fPlpCHJCgpZ4g4IKwXQec9ExU2x/ol8+6tGBykhFD7HTxoe1upUnEZ4WfGgMLF
	 N+n5rjlrG6RUh9z1K68eGLoY9PW1kkGv0XZP/C9y0wot3NG+sCa9bTGvc390/yue62
	 SDUz8wXWosEcXLe0ecPLbh84kmBryTbM9t/qAFX01w4KA5JfN4IgRRUaGeWEZgCkU6
	 gPWi1PkuCurjw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-658078d6655so1614286a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 02:38:59 -0800 (PST)
X-Gm-Message-State: AOJu0YzfB0qR7SfY7QrSCJCGhOJ0wCWbp5TRIvODU23h6vrXCDUpbKnH
	ZcCwg+duXj0Nc+sFhGUGzOGylldyt+Z3+JGH1en905UC6IQAogA1R+rUtmrJtTWJCrp0tUT583Q
	N1crYnBPr79d+R78G4e+X43R3eouZ+nw=
X-Received: by 2002:a17:907:8693:b0:b87:1e94:ef6a with SMTP id
 a640c23a62f3a-b8796b37454mr1540178866b.47.1769078337701; Thu, 22 Jan 2026
 02:38:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122063350.503383-1-jinbaohong@synology.com> <CAL3q7H6h0fnp6-QxQAty4XULJ0pmG=_kY_Puv32Jp+EN+MLsCw@mail.gmail.com>
In-Reply-To: <CAL3q7H6h0fnp6-QxQAty4XULJ0pmG=_kY_Puv32Jp+EN+MLsCw@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 22 Jan 2026 10:38:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H69QyeobkY-+YO9JsCKfrQ1EYeZN0fVOFFkkC5fXh90SQ@mail.gmail.com>
X-Gm-Features: AZwV_QhczaYMYTKBKTx0HsQgt78Gdi6_Eenbfx4B6ReXWd0SZF9cdpG0GLZs4Ik
Message-ID: <CAL3q7H69QyeobkY-+YO9JsCKfrQ1EYeZN0fVOFFkkC5fXh90SQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix transaction commit blocking during trim of
 unallocated space
To: jinbaohong <jinbaohong@synology.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, 
	robbieko <robbieko@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20910-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,suse.com:email,mail.gmail.com:mid,synology.com:email]
X-Rspamd-Queue-Id: 564E56579C
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:06=E2=80=AFAM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Thu, Jan 22, 2026 at 6:33=E2=80=AFAM jinbaohong <jinbaohong@synology.c=
om> wrote:
> >
> > When trimming unallocated space, btrfs_trim_fs() holds device_list_mute=
x
> > for the entire duration while iterating through all devices. On large
> > filesystems with significant unallocated space, this operation can take
> > minutes to hours on large storage systems.
> >
> > This causes a problem because btrfs_run_dev_stats(), which is called
> > during transaction commit, also requires device_list_mutex:
> >
> >   btrfs_trim_fs()
> >     mutex_lock(&fs_devices->device_list_mutex)
> >     list_for_each_entry(device, ...)
> >       btrfs_trim_free_extents(device)
> >     mutex_unlock(&fs_devices->device_list_mutex)
> >
> >   commit_transaction()
> >     btrfs_run_dev_stats()
> >       mutex_lock(&fs_devices->device_list_mutex)  // blocked!
> >       ...
> >
> > While trim is running, all transaction commits are blocked waiting for
> > the mutex.
> >
> > Fix this by refactoring btrfs_trim_free_extents() to process devices in
> > bounded chunks (up to 2GB per iteration) and release device_list_mutex
> > between chunks.
> >
> > Signed-off-by: robbieko <robbieko@synology.com>
> > Signed-off-by: jinbaohong <jinbaohong@synology.com>
> > ---
> > Changes in v2:
> > - Add #define BTRFS_MAX_TRIM_LENGTH, remove maxlen parameter (Filipe)
> > - Move loop-only variables into loop scope (Filipe)
> > - Fix comment style: capitalization and punctuation (Filipe)
> > - Replace goto patterns with direct returns (Filipe)
> > ---
> >  fs/btrfs/extent-tree.c | 148 +++++++++++++++++++++++++++++++++++------
> >  1 file changed, 128 insertions(+), 20 deletions(-)
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 89495e6f8269..04b6c36418c4 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -6380,6 +6380,9 @@ void btrfs_error_unpin_extent_range(struct btrfs_=
fs_info *fs_info, u64 start, u6
> >         unpin_extent_range(fs_info, start, end, false);
> >  }
> >
> > +/* Maximum length to trim in a single iteration to avoid holding mutex=
 too long. */
> > +#define BTRFS_MAX_TRIM_LENGTH SZ_2G
> > +
> >  /*
> >   * It used to be that old block groups would be left around forever.
> >   * Iterating over them would be enough to trim unused space.  Since we
> > @@ -6400,10 +6403,12 @@ void btrfs_error_unpin_extent_range(struct btrf=
s_fs_info *fs_info, u64 start, u6
> >   * it while performing the free space search since we have already
> >   * held back allocations.
> >   */
> > -static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *t=
rimmed)
> > +static int btrfs_trim_free_extents_throttle(struct btrfs_device *devic=
e,
> > +               u64 *trimmed, u64 pos, u64 *ret_next_pos)
> >  {
> > -       u64 start =3D BTRFS_DEVICE_RANGE_RESERVED, len =3D 0, end =3D 0=
;
> >         int ret;
> > +       u64 start =3D pos;
> > +       u64 trim_len =3D 0;
> >
> >         *trimmed =3D 0;
> >
> > @@ -6423,17 +6428,22 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device, u64 *trimmed)
> >
> >         while (1) {
> >                 struct btrfs_fs_info *fs_info =3D device->fs_info;
> > +               u64 cur_start;
> > +               u64 end;
> > +               u64 len;
> >                 u64 bytes;
> >
> >                 ret =3D mutex_lock_interruptible(&fs_info->chunk_mutex)=
;
> >                 if (ret)
> >                         break;
> >
> > +               cur_start =3D start;
> >                 btrfs_find_first_clear_extent_bit(&device->alloc_state,=
 start,
> >                                                   &start, &end,
> >                                                   CHUNK_TRIMMED | CHUNK=
_ALLOCATED);
> > +               start =3D max(start, cur_start);
> >
> > -               /* Check if there are any CHUNK_* bits left */
> > +               /* Check if there are any CHUNK_* bits left. */
>
> By the way, when I told you that sentences in comments should end with
> punctuation, that didn't mean to update existing comments.
> The idea is to do it only for new comments or when one needs to update
> an existing comment.
>
> If no one objects, I'm fine with it this time.
>
> >                 if (start > device->total_bytes) {
> >                         DEBUG_WARN();
> >                         btrfs_warn(fs_info,
> > @@ -6457,8 +6467,9 @@ static int btrfs_trim_free_extents(struct btrfs_d=
evice *device, u64 *trimmed)
> >                 end =3D min(end, device->total_bytes - 1);
> >
> >                 len =3D end - start + 1;
> > +               len =3D min(len, BTRFS_MAX_TRIM_LENGTH);
> >
> > -               /* We didn't find any extents */
> > +               /* We didn't find any extents. */
> >                 if (!len) {
> >                         mutex_unlock(&fs_info->chunk_mutex);
> >                         ret =3D 0;
> > @@ -6477,6 +6488,12 @@ static int btrfs_trim_free_extents(struct btrfs_=
device *device, u64 *trimmed)
> >
> >                 start +=3D len;
> >                 *trimmed +=3D bytes;
> > +               trim_len +=3D len;
> > +               if (trim_len >=3D BTRFS_MAX_TRIM_LENGTH) {
> > +                       *ret_next_pos =3D start;
> > +                       ret =3D -EAGAIN;
> > +                       break;
> > +               }
> >
> >                 if (btrfs_trim_interrupted()) {
> >                         ret =3D -ERESTARTSYS;
> > @@ -6489,6 +6506,108 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device, u64 *trimmed)
> >         return ret;
> >  }
> >
> > +static int btrfs_trim_free_extents(struct btrfs_fs_info *fs_info, u64 =
*trimmed)
> > +{
> > +       int ret;
> > +       struct btrfs_device *dev;
> > +       struct btrfs_device *working_dev =3D NULL;
> > +       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> > +       u8 uuid[BTRFS_UUID_SIZE];
> > +       u64 start =3D BTRFS_DEVICE_RANGE_RESERVED;
> > +
> > +       *trimmed =3D 0;
> > +
> > +       mutex_lock(&fs_devices->device_list_mutex);
> > +       list_for_each_entry(dev, &fs_devices->devices, dev_list) {
> > +               if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> > +                       continue;
> > +               if (!working_dev ||
> > +                   memcmp(dev->uuid, working_dev->uuid, BTRFS_UUID_SIZ=
E) < 0)
> > +                       working_dev =3D dev;
> > +       }
> > +       if (working_dev)
> > +               memcpy(uuid, working_dev->uuid, BTRFS_UUID_SIZE);
> > +       mutex_unlock(&fs_devices->device_list_mutex);
> > +       if (!working_dev)
> > +               return 0;
> > +
> > +       while (1) {
> > +               u64 group_trimmed =3D 0;
> > +               u64 next_pos =3D 0;
> > +
> > +               ret =3D 0;
> > +
> > +               mutex_lock(&fs_devices->device_list_mutex);
> > +
> > +               list_for_each_entry(dev, &fs_devices->devices, dev_list=
) {
> > +                       if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev=
_state))
> > +                               continue;
> > +                       if (dev =3D=3D working_dev) {
> > +                               ret =3D btrfs_trim_free_extents_throttl=
e(working_dev,
> > +                                       &group_trimmed, start, &next_po=
s);
> > +                               break;
> > +                       }
> > +               }
> > +               *trimmed +=3D group_trimmed;
>
> This increment can be done outside the critical section delimited by
> the device_list_mutex.
> I'll move it below the mutex_unlock() before pushing the patch to for-nex=
t.
>
> Anyway, looks good to me:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> I'll push it to the for-next branch later today if no one has other
> review comments.
> Thanks!
>
>
> > +
> > +               if (!ret) {
> > +                       /*
> > +                        * Device completed, go next device.
> > +                        * Find a device which has the smallest uuid bu=
t larger than
> > +                        * current one.
> > +                        * Note: Devices added during trim with UUID sm=
aller than the
> > +                        * current device will be skipped.
> > +                        */
> > +                       working_dev =3D NULL;
> > +                       list_for_each_entry(dev, &fs_devices->devices, =
dev_list) {
> > +                               if (test_bit(BTRFS_DEV_STATE_MISSING, &=
dev->dev_state))
> > +                                       continue;
> > +
> > +                               /* Must be larger than current uuid. */
> > +                               if (memcmp(dev->uuid, uuid, BTRFS_UUID_=
SIZE) <=3D 0)
> > +                                       continue;
> > +
> > +                               /* Find the smallest. */
> > +                               if (!working_dev ||
> > +                                   memcmp(dev->uuid, working_dev->uuid=
, BTRFS_UUID_SIZE) < 0)
> > +                                       working_dev =3D dev;
> > +                       }
> > +                       if (working_dev)
> > +                               memcpy(uuid, working_dev->uuid, BTRFS_U=
UID_SIZE);
> > +                       start =3D BTRFS_DEVICE_RANGE_RESERVED;
> > +               }
> > +               mutex_unlock(&fs_devices->device_list_mutex);
> > +
> > +               if (ret =3D=3D -EAGAIN) {
> > +                       /*
> > +                        * Ensure next_pos actually progressed beyond s=
tart.
> > +                        * If not, we're stuck and must break to avoid =
infinite loop.
> > +                        */
> > +                       if (next_pos <=3D start) {
> > +                               btrfs_warn(fs_info,
> > +                                  "trim throttle: no progress, start=
=3D%llu next_pos=3D%llu, aborting",
> > +                                  start, next_pos);
> > +                               return ret;
> > +                       }
> > +                       start =3D next_pos;
> > +                       ret =3D 0;
> > +               }
> > +
> > +               if (ret)
> > +                       return ret;
> > +
> > +               /* Error or no more device. */
> > +               if (!working_dev)
> > +                       break;
> > +
> > +               if (btrfs_trim_interrupted())
> > +                       return -ERESTARTSYS;
> > +
> > +               cond_resched();
> > +       }
> > +       return 0;
> > +}
> > +
> >  /*
> >   * Trim the whole filesystem by:
> >   * 1) trimming the free space in each block group
> > @@ -6500,9 +6619,7 @@ static int btrfs_trim_free_extents(struct btrfs_d=
evice *device, u64 *trimmed)
> >   */
> >  int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *=
range)
> >  {
> > -       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> >         struct btrfs_block_group *cache =3D NULL;
> > -       struct btrfs_device *device;
> >         u64 group_trimmed;
> >         u64 range_end =3D U64_MAX;
> >         u64 start;
> > @@ -6564,21 +6681,12 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info=
, struct fstrim_range *range)
> >                         "failed to trim %llu block group(s), last error=
 %d",
> >                         bg_failed, bg_ret);
> >
> > -       mutex_lock(&fs_devices->device_list_mutex);
> > -       list_for_each_entry(device, &fs_devices->devices, dev_list) {
> > -               if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_stat=
e))
> > -                       continue;
> > -
> > -               ret =3D btrfs_trim_free_extents(device, &group_trimmed)=
;
> > -
> > -               trimmed +=3D group_trimmed;
> > -               if (ret) {
> > -                       dev_failed++;
> > -                       dev_ret =3D ret;
> > -                       break;
> > -               }
> > +       ret =3D btrfs_trim_free_extents(fs_info, &group_trimmed);
> > +       trimmed +=3D group_trimmed;
> > +       if (ret) {
> > +               dev_failed++;
> > +               dev_ret =3D ret;

Oh wait, there's a difference here from what we had before.

Before this patch, every time we failed to trim a device, we would
increment the counter and continue to the next device.
But now after this patch once we get a failure with one device, we
don't continue with the rest (and the dev_failed counter is always 1).




> >         }
> > -       mutex_unlock(&fs_devices->device_list_mutex);
> >
> >         if (dev_failed)
> >                 btrfs_warn(fs_info,
> > --
> > 2.34.1
> >
> >
> > Disclaimer: The contents of this e-mail message and any attachments are=
 confidential and are intended solely for addressee. The information may al=
so be legally privileged. This transmission is sent in trust, for the sole =
purpose of delivery to the intended recipient. If you have received this tr=
ansmission in error, any use, reproduction or dissemination of this transmi=
ssion is strictly prohibited. If you are not the intended recipient, please=
 immediately notify the sender by reply e-mail or phone and delete this mes=
sage and its attachments, if any.

