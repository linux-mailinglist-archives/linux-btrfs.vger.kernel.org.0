Return-Path: <linux-btrfs+bounces-20907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFO+MnH4cWmvZwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20907-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 11:14:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2565177
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 240968638C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90456357A4E;
	Thu, 22 Jan 2026 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMpSknY2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3156364EB9
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076443; cv=none; b=e8fYNDBBXFsehJW//m2gJeL3PQ7UKwc/5X8zb8AfVeqs7tK2TwZcHB73cBdP4UqkvnUxDMvywCZeyl7Y41TWiV/Kv+952iREQAs2dlmnvaLSieqaIQDQsbgXciSH4bjJXMRCjARze7wzXpqd0KW+3m0KIIpMMHM8jvjpAzhaPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076443; c=relaxed/simple;
	bh=jwlR9zHpZnSCFaUaK0t0RP882rZyJh6oOKswJCyNoBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUsAbuRPWVchgQsCtO4ZKd1r/fqBRp5LS7Q4bLqlUUOYyu9bhcdRbaut59KYSra9sHbnHMRp37fHKK5BBoTtor/52LtuuVZdxBWvYTpXK64Q/LjIMBQYnErvPP61Cjjey12ZkblVfiixQN7avIxGAbWrHkAXXO3F9ofI2rMlqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMpSknY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445A0C4AF09
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769076441;
	bh=jwlR9zHpZnSCFaUaK0t0RP882rZyJh6oOKswJCyNoBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oMpSknY2CLvaT0OUBrdsm/IVMwcqmnLe6u1jJTrWvNfRZuOiPhTxevvhMayKWfWFX
	 Tp/wnWc1yhOsZ4tW1MevHbECp0nutqFziC3CSunh7c46USYJM4KMYTQKQYmeq5haPi
	 nXBb3Pm98rn/D4SWyoRWmZIyAn4rSXhPPVudJl5EUcyzRZy9z5XCgEEigJBu6y0hv5
	 D8LRuZvUcyz5Z4CeJZrEOMj5jusuHN2pHAbUBJsP0q9zQaBFx0mJT5NXgRo//xndm+
	 Xtx4sXdtoW8VxCZdspehdw8kktkhavszfPxckbkCiSV2CO2j1Jlz9I5En8KHRoUUW1
	 gxMq4S9L38G2w==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so1215152a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 02:07:21 -0800 (PST)
X-Gm-Message-State: AOJu0YwoTmLKiQD7gbZef2aV4PNWL6XamxFh6S/h+TiFGnUaHhDb58eA
	cV12dfJO21vdLjy6uML8jQNJTXy4fCLRe2mfBHr+w5saNYDgszhjFgQiFfP4sPBU9tGmzmQNuCC
	/5IkeN6286hEkHZ/wnIQ8TobNRnydVuk=
X-Received: by 2002:a17:907:3e12:b0:b87:322d:a8d0 with SMTP id
 a640c23a62f3a-b8792f8b97cmr1805425766b.41.1769076439704; Thu, 22 Jan 2026
 02:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122063350.503383-1-jinbaohong@synology.com>
In-Reply-To: <20260122063350.503383-1-jinbaohong@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 22 Jan 2026 10:06:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6h0fnp6-QxQAty4XULJ0pmG=_kY_Puv32Jp+EN+MLsCw@mail.gmail.com>
X-Gm-Features: AZwV_QjmZQk3Fjspe1c-S2dLt5BFxNv5KoAiGMdYd6SmOvLsFYu2b0ibP8PPKMc
Message-ID: <CAL3q7H6h0fnp6-QxQAty4XULJ0pmG=_kY_Puv32Jp+EN+MLsCw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20907-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1BD2565177
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 6:33=E2=80=AFAM jinbaohong <jinbaohong@synology.com=
> wrote:
>
> When trimming unallocated space, btrfs_trim_fs() holds device_list_mutex
> for the entire duration while iterating through all devices. On large
> filesystems with significant unallocated space, this operation can take
> minutes to hours on large storage systems.
>
> This causes a problem because btrfs_run_dev_stats(), which is called
> during transaction commit, also requires device_list_mutex:
>
>   btrfs_trim_fs()
>     mutex_lock(&fs_devices->device_list_mutex)
>     list_for_each_entry(device, ...)
>       btrfs_trim_free_extents(device)
>     mutex_unlock(&fs_devices->device_list_mutex)
>
>   commit_transaction()
>     btrfs_run_dev_stats()
>       mutex_lock(&fs_devices->device_list_mutex)  // blocked!
>       ...
>
> While trim is running, all transaction commits are blocked waiting for
> the mutex.
>
> Fix this by refactoring btrfs_trim_free_extents() to process devices in
> bounded chunks (up to 2GB per iteration) and release device_list_mutex
> between chunks.
>
> Signed-off-by: robbieko <robbieko@synology.com>
> Signed-off-by: jinbaohong <jinbaohong@synology.com>
> ---
> Changes in v2:
> - Add #define BTRFS_MAX_TRIM_LENGTH, remove maxlen parameter (Filipe)
> - Move loop-only variables into loop scope (Filipe)
> - Fix comment style: capitalization and punctuation (Filipe)
> - Replace goto patterns with direct returns (Filipe)
> ---
>  fs/btrfs/extent-tree.c | 148 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 128 insertions(+), 20 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 89495e6f8269..04b6c36418c4 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6380,6 +6380,9 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs=
_info *fs_info, u64 start, u6
>         unpin_extent_range(fs_info, start, end, false);
>  }
>
> +/* Maximum length to trim in a single iteration to avoid holding mutex t=
oo long. */
> +#define BTRFS_MAX_TRIM_LENGTH SZ_2G
> +
>  /*
>   * It used to be that old block groups would be left around forever.
>   * Iterating over them would be enough to trim unused space.  Since we
> @@ -6400,10 +6403,12 @@ void btrfs_error_unpin_extent_range(struct btrfs_=
fs_info *fs_info, u64 start, u6
>   * it while performing the free space search since we have already
>   * held back allocations.
>   */
> -static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *tri=
mmed)
> +static int btrfs_trim_free_extents_throttle(struct btrfs_device *device,
> +               u64 *trimmed, u64 pos, u64 *ret_next_pos)
>  {
> -       u64 start =3D BTRFS_DEVICE_RANGE_RESERVED, len =3D 0, end =3D 0;
>         int ret;
> +       u64 start =3D pos;
> +       u64 trim_len =3D 0;
>
>         *trimmed =3D 0;
>
> @@ -6423,17 +6428,22 @@ static int btrfs_trim_free_extents(struct btrfs_d=
evice *device, u64 *trimmed)
>
>         while (1) {
>                 struct btrfs_fs_info *fs_info =3D device->fs_info;
> +               u64 cur_start;
> +               u64 end;
> +               u64 len;
>                 u64 bytes;
>
>                 ret =3D mutex_lock_interruptible(&fs_info->chunk_mutex);
>                 if (ret)
>                         break;
>
> +               cur_start =3D start;
>                 btrfs_find_first_clear_extent_bit(&device->alloc_state, s=
tart,
>                                                   &start, &end,
>                                                   CHUNK_TRIMMED | CHUNK_A=
LLOCATED);
> +               start =3D max(start, cur_start);
>
> -               /* Check if there are any CHUNK_* bits left */
> +               /* Check if there are any CHUNK_* bits left. */

By the way, when I told you that sentences in comments should end with
punctuation, that didn't mean to update existing comments.
The idea is to do it only for new comments or when one needs to update
an existing comment.

If no one objects, I'm fine with it this time.

>                 if (start > device->total_bytes) {
>                         DEBUG_WARN();
>                         btrfs_warn(fs_info,
> @@ -6457,8 +6467,9 @@ static int btrfs_trim_free_extents(struct btrfs_dev=
ice *device, u64 *trimmed)
>                 end =3D min(end, device->total_bytes - 1);
>
>                 len =3D end - start + 1;
> +               len =3D min(len, BTRFS_MAX_TRIM_LENGTH);
>
> -               /* We didn't find any extents */
> +               /* We didn't find any extents. */
>                 if (!len) {
>                         mutex_unlock(&fs_info->chunk_mutex);
>                         ret =3D 0;
> @@ -6477,6 +6488,12 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>
>                 start +=3D len;
>                 *trimmed +=3D bytes;
> +               trim_len +=3D len;
> +               if (trim_len >=3D BTRFS_MAX_TRIM_LENGTH) {
> +                       *ret_next_pos =3D start;
> +                       ret =3D -EAGAIN;
> +                       break;
> +               }
>
>                 if (btrfs_trim_interrupted()) {
>                         ret =3D -ERESTARTSYS;
> @@ -6489,6 +6506,108 @@ static int btrfs_trim_free_extents(struct btrfs_d=
evice *device, u64 *trimmed)
>         return ret;
>  }
>
> +static int btrfs_trim_free_extents(struct btrfs_fs_info *fs_info, u64 *t=
rimmed)
> +{
> +       int ret;
> +       struct btrfs_device *dev;
> +       struct btrfs_device *working_dev =3D NULL;
> +       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> +       u8 uuid[BTRFS_UUID_SIZE];
> +       u64 start =3D BTRFS_DEVICE_RANGE_RESERVED;
> +
> +       *trimmed =3D 0;
> +
> +       mutex_lock(&fs_devices->device_list_mutex);
> +       list_for_each_entry(dev, &fs_devices->devices, dev_list) {
> +               if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> +                       continue;
> +               if (!working_dev ||
> +                   memcmp(dev->uuid, working_dev->uuid, BTRFS_UUID_SIZE)=
 < 0)
> +                       working_dev =3D dev;
> +       }
> +       if (working_dev)
> +               memcpy(uuid, working_dev->uuid, BTRFS_UUID_SIZE);
> +       mutex_unlock(&fs_devices->device_list_mutex);
> +       if (!working_dev)
> +               return 0;
> +
> +       while (1) {
> +               u64 group_trimmed =3D 0;
> +               u64 next_pos =3D 0;
> +
> +               ret =3D 0;
> +
> +               mutex_lock(&fs_devices->device_list_mutex);
> +
> +               list_for_each_entry(dev, &fs_devices->devices, dev_list) =
{
> +                       if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_s=
tate))
> +                               continue;
> +                       if (dev =3D=3D working_dev) {
> +                               ret =3D btrfs_trim_free_extents_throttle(=
working_dev,
> +                                       &group_trimmed, start, &next_pos)=
;
> +                               break;
> +                       }
> +               }
> +               *trimmed +=3D group_trimmed;

This increment can be done outside the critical section delimited by
the device_list_mutex.
I'll move it below the mutex_unlock() before pushing the patch to for-next.

Anyway, looks good to me:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I'll push it to the for-next branch later today if no one has other
review comments.
Thanks!


> +
> +               if (!ret) {
> +                       /*
> +                        * Device completed, go next device.
> +                        * Find a device which has the smallest uuid but =
larger than
> +                        * current one.
> +                        * Note: Devices added during trim with UUID smal=
ler than the
> +                        * current device will be skipped.
> +                        */
> +                       working_dev =3D NULL;
> +                       list_for_each_entry(dev, &fs_devices->devices, de=
v_list) {
> +                               if (test_bit(BTRFS_DEV_STATE_MISSING, &de=
v->dev_state))
> +                                       continue;
> +
> +                               /* Must be larger than current uuid. */
> +                               if (memcmp(dev->uuid, uuid, BTRFS_UUID_SI=
ZE) <=3D 0)
> +                                       continue;
> +
> +                               /* Find the smallest. */
> +                               if (!working_dev ||
> +                                   memcmp(dev->uuid, working_dev->uuid, =
BTRFS_UUID_SIZE) < 0)
> +                                       working_dev =3D dev;
> +                       }
> +                       if (working_dev)
> +                               memcpy(uuid, working_dev->uuid, BTRFS_UUI=
D_SIZE);
> +                       start =3D BTRFS_DEVICE_RANGE_RESERVED;
> +               }
> +               mutex_unlock(&fs_devices->device_list_mutex);
> +
> +               if (ret =3D=3D -EAGAIN) {
> +                       /*
> +                        * Ensure next_pos actually progressed beyond sta=
rt.
> +                        * If not, we're stuck and must break to avoid in=
finite loop.
> +                        */
> +                       if (next_pos <=3D start) {
> +                               btrfs_warn(fs_info,
> +                                  "trim throttle: no progress, start=3D%=
llu next_pos=3D%llu, aborting",
> +                                  start, next_pos);
> +                               return ret;
> +                       }
> +                       start =3D next_pos;
> +                       ret =3D 0;
> +               }
> +
> +               if (ret)
> +                       return ret;
> +
> +               /* Error or no more device. */
> +               if (!working_dev)
> +                       break;
> +
> +               if (btrfs_trim_interrupted())
> +                       return -ERESTARTSYS;
> +
> +               cond_resched();
> +       }
> +       return 0;
> +}
> +
>  /*
>   * Trim the whole filesystem by:
>   * 1) trimming the free space in each block group
> @@ -6500,9 +6619,7 @@ static int btrfs_trim_free_extents(struct btrfs_dev=
ice *device, u64 *trimmed)
>   */
>  int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *ra=
nge)
>  {
> -       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
>         struct btrfs_block_group *cache =3D NULL;
> -       struct btrfs_device *device;
>         u64 group_trimmed;
>         u64 range_end =3D U64_MAX;
>         u64 start;
> @@ -6564,21 +6681,12 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, =
struct fstrim_range *range)
>                         "failed to trim %llu block group(s), last error %=
d",
>                         bg_failed, bg_ret);
>
> -       mutex_lock(&fs_devices->device_list_mutex);
> -       list_for_each_entry(device, &fs_devices->devices, dev_list) {
> -               if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)=
)
> -                       continue;
> -
> -               ret =3D btrfs_trim_free_extents(device, &group_trimmed);
> -
> -               trimmed +=3D group_trimmed;
> -               if (ret) {
> -                       dev_failed++;
> -                       dev_ret =3D ret;
> -                       break;
> -               }
> +       ret =3D btrfs_trim_free_extents(fs_info, &group_trimmed);
> +       trimmed +=3D group_trimmed;
> +       if (ret) {
> +               dev_failed++;
> +               dev_ret =3D ret;
>         }
> -       mutex_unlock(&fs_devices->device_list_mutex);
>
>         if (dev_failed)
>                 btrfs_warn(fs_info,
> --
> 2.34.1
>
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.

