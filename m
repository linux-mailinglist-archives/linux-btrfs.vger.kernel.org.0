Return-Path: <linux-btrfs+bounces-21064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP1ENj6Md2m9hgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21064-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 16:46:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9178A4D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 16:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7586303A856
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E234029E;
	Mon, 26 Jan 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWBIEbnP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76849272E6A
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442330; cv=none; b=mRQ8Aw1DGkPZ2CP7UFV2lnmXoNM3cIe7E11o4OOttbc07wG2l7y9TgvotEP5Ubxiwkj2xHtlUxLqI44tb0+LuSihPfCYjAO0iVTcQssZBbWJLfjaK1bV/Mi/74s2U75LWkcuxCn29ZTpKT5YykOYx8H2oJsujZsQi5Q1VEdegmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442330; c=relaxed/simple;
	bh=x8F/p6wVj9VEmmnwGNvnpmH+jwP/B7/MyvP9vvhxtT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClhipeCWXBomFz7Om0UgN3+trNUUUJQwJcGfidzSiGM6smEp3+ntp3u8PCRHPe8TMTmQgkNvDQXQpYbabJ6f3Kk1st9pejCtiChIg9dNCamaWelprbEaoMOgHbVR0x4jx0Fwu3WBtdNWGjM0mHxpRIoHq101Jy+cWcpjvyODTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWBIEbnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C45C2BC86
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442330;
	bh=x8F/p6wVj9VEmmnwGNvnpmH+jwP/B7/MyvP9vvhxtT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NWBIEbnPb0rMmtZI0L9g1u/XHe94jpWUj4LABmS30HMg/S+V7CfHEiI7pL3kaiC5R
	 s3Junq0O9y3uPzuDTprZTzFWcWJg1gaI3Ne1Zrx/6s08WZFp3wCVz39tgij3s1Bb8f
	 qMTIGN4rCpWJ9pOF8iNxX9bUk/cT/basmj8ZsXhHcf9MJme0vtfHp633/njZs5XL8q
	 r+JZamKDdgWTpxbMGc+uBa6r3ERDLqaudrb33Re8g7ZtGJ9xv853v1W/SOJpFYUueH
	 2H+AFiLEJPDBOD5yx/IwvdSTozmlM5eh5mO/lDXcXaM/ug9NPtU+jdLYj2/iHxiVdm
	 tXX550U+uA4Mg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so6415433a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 07:45:29 -0800 (PST)
X-Gm-Message-State: AOJu0YwND4tTU3rUXlZEE5H6TISf+N8+/YRReCiZ6azObOtjyAT1u7e2
	oRvixShZFro50am6ecj4kMk2pmAygMoK5ikEt8LBRxJsk046PxsYHU6WeMAgnDx2/xudm4b04jj
	72FKR077YzGuk95roW515qsC1+67Fo+Q=
X-Received: by 2002:a17:906:fd87:b0:b73:6b24:14ba with SMTP id
 a640c23a62f3a-b8cfedfcb48mr328351166b.8.1769442328444; Mon, 26 Jan 2026
 07:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126083639.602258-1-jinbaohong@synology.com> <20260126083639.602258-3-jinbaohong@synology.com>
In-Reply-To: <20260126083639.602258-3-jinbaohong@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Jan 2026 15:44:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4=9vH3UP6=i1zTe7MVKf6aWAqEqb7i+Fmxoc3q4qDyKA@mail.gmail.com>
X-Gm-Features: AZwV_Qi00Cy_nM9vlkUifxF5bgBQgjq6Km_vCzU_1XsTs4TEEQbglNy1QlXshTw
Message-ID: <CAL3q7H4=9vH3UP6=i1zTe7MVKf6aWAqEqb7i+Fmxoc3q4qDyKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] btrfs: fix transaction commit blocking during trim
 of unallocated space
To: jinbaohong <jinbaohong@synology.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, 
	robbieko <robbieko@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21064-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4C9178A4D2
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 8:36=E2=80=AFAM jinbaohong <jinbaohong@synology.com=
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
>  fs/btrfs/extent-tree.c | 164 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 140 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b299e369649b..57f6ed1665d1 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6493,6 +6493,9 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs=
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
> @@ -6513,10 +6516,12 @@ void btrfs_error_unpin_extent_range(struct btrfs_=
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
> @@ -6536,6 +6541,9 @@ static int btrfs_trim_free_extents(struct btrfs_dev=
ice *device, u64 *trimmed)
>
>         while (1) {
>                 struct btrfs_fs_info *fs_info =3D device->fs_info;
> +               u64 cur_start;
> +               u64 end;
> +               u64 len;
>                 u64 bytes;
>
>                 ret =3D mutex_lock_interruptible(&fs_info->chunk_mutex);
> @@ -6544,9 +6552,11 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>                         break;
>                 }
>
> +               cur_start =3D start;
>                 btrfs_find_first_clear_extent_bit(&device->alloc_state, s=
tart,
>                                                   &start, &end,
>                                                   CHUNK_TRIMMED | CHUNK_A=
LLOCATED);
> +               start =3D max(start, cur_start);
>
>                 /* Check if there are any CHUNK_* bits left */
>                 if (start > device->total_bytes) {
> @@ -6572,6 +6582,7 @@ static int btrfs_trim_free_extents(struct btrfs_dev=
ice *device, u64 *trimmed)
>                 end =3D min(end, device->total_bytes - 1);
>
>                 len =3D end - start + 1;
> +               len =3D min(len, BTRFS_MAX_TRIM_LENGTH);
>
>                 /* We didn't find any extents */
>                 if (!len) {
> @@ -6592,6 +6603,12 @@ static int btrfs_trim_free_extents(struct btrfs_de=
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
> @@ -6604,6 +6621,123 @@ static int btrfs_trim_free_extents(struct btrfs_d=
evice *device, u64 *trimmed)
>         return ret;
>  }
>
> +static int btrfs_trim_free_extents(struct btrfs_fs_info *fs_info, u64 *t=
rimmed,
> +                                  u64 *dev_failed, int *dev_ret)
> +{
> +       int ret;
> +       struct btrfs_device *dev;
> +       struct btrfs_device *working_dev =3D NULL;
> +       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> +       u8 uuid[BTRFS_UUID_SIZE];
> +       u64 start =3D BTRFS_DEVICE_RANGE_RESERVED;
> +
> +       *trimmed =3D 0;
> +       *dev_failed =3D 0;
> +       *dev_ret =3D 0;
> +
> +       /* Find the device with the smallest UUID to start. */
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
> +
> +       if (!working_dev)
> +               return 0;
> +
> +       while (1) {
> +               u64 group_trimmed =3D 0;
> +               u64 next_pos =3D 0;
> +
> +               ret =3D 0;


We can also declare ret here:

int ret =3D 0;

Since it's not used outside the loop.


> +
> +               mutex_lock(&fs_devices->device_list_mutex);
> +
> +               /* Find and trim the current device. */
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
> +
> +               /* Throttle: continue same device from new position. */
> +               if (ret =3D=3D -EAGAIN && next_pos > start) {
> +                       mutex_unlock(&fs_devices->device_list_mutex);
> +                       *trimmed +=3D group_trimmed;
> +                       start =3D next_pos;
> +                       cond_resched();
> +                       continue;
> +               }
> +
> +               /* User interrupted. */
> +               if (ret =3D=3D -ERESTARTSYS) {
> +                       mutex_unlock(&fs_devices->device_list_mutex);
> +                       *trimmed +=3D group_trimmed;
> +                       *dev_ret =3D -ERESTARTSYS;
> +                       return -ERESTARTSYS;
> +               }
> +
> +               /*
> +                * Device completed (ret =3D=3D 0), failed, or EAGAIN wit=
h no progress.
> +                * Record error if any, then move to next device.
> +                */
> +               if (ret =3D=3D -EAGAIN) {
> +                       /* No progress - log and skip device. */
> +                       btrfs_warn(fs_info,
> +                                  "trim throttle: no progress, offset=3D=
%llu device %s, skipping",
> +                                  start, btrfs_dev_name(working_dev));
> +                       (*dev_failed)++;
> +                       *dev_ret =3D ret;
> +               } else if (ret) {
> +                       /* Device failed with error. */
> +                       (*dev_failed)++;
> +                       *dev_ret =3D ret;
> +               }
> +
> +               /*
> +                * Find next device: smallest UUID larger than current.
> +                * Devices added during trim with smaller UUID will be sk=
ipped.
> +                */
> +               working_dev =3D NULL;
> +               list_for_each_entry(dev, &fs_devices->devices, dev_list) =
{
> +                       if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_s=
tate))
> +                               continue;
> +                       /* Must larger than current uuid. */
> +                       if (memcmp(dev->uuid, uuid, BTRFS_UUID_SIZE) <=3D=
 0)
> +                               continue;
> +                       /* Find the smallest. */
> +                       if (!working_dev ||
> +                           memcmp(dev->uuid, working_dev->uuid, BTRFS_UU=
ID_SIZE) < 0)
> +                               working_dev =3D dev;
> +               }
> +               if (working_dev)
> +                       memcpy(uuid, working_dev->uuid, BTRFS_UUID_SIZE);
> +
> +               mutex_unlock(&fs_devices->device_list_mutex);
> +
> +               *trimmed +=3D group_trimmed;
> +               start =3D BTRFS_DEVICE_RANGE_RESERVED;
> +
> +               /* No more devices. */
> +               if (!working_dev)
> +                       break;
> +
> +               cond_resched();
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * Trim the whole filesystem by:
>   * 1) trimming the free space in each block group
> @@ -6615,9 +6749,7 @@ static int btrfs_trim_free_extents(struct btrfs_dev=
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
> @@ -6648,7 +6780,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, st=
ruct fstrim_range *range)
>                 }
>
>                 start =3D max(range->start, cache->start);
> -               end =3D min(range_end, btrfs_block_group_end(cache));
> +               end =3D min(range_end, cache->start + cache->length);

Please don't do that. We should use the helper btrfs_block_group_end().
Why did you do this change? This seems completely unrelated.

Otherwise it looks fine, thanks.

>
>                 if (end - start >=3D range->minlen) {
>                         if (!btrfs_block_group_done(cache)) {
> @@ -6679,25 +6811,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, s=
truct fstrim_range *range)
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
> -               if (ret =3D=3D -ERESTARTSYS) {
> -                       dev_ret =3D -ERESTARTSYS;
> -                       break;
> -               }
> -               if (ret) {
> -                       dev_failed++;
> -                       dev_ret =3D ret;
> -                       continue;
> -               }
> -       }
> -       mutex_unlock(&fs_devices->device_list_mutex);
> +       btrfs_trim_free_extents(fs_info, &group_trimmed,
> +                               &dev_failed, &dev_ret);
> +       trimmed +=3D group_trimmed;
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

