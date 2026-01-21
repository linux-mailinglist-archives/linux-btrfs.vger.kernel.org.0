Return-Path: <linux-btrfs+bounces-20809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNQVBo21cGndZAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20809-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:16:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D155DB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 353E768571E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41393ECBFF;
	Wed, 21 Jan 2026 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDJTKq13"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A075326D65
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993629; cv=none; b=B5VWfHL4/KX/63WW4T7+NLY5uo7zW1cMyR94YvqsqZknG/ZRRJDlj7dXGkrKBCRYm8fUiVECnKxaumYYSzY2Q7sztJRvnXTYdfK6GJQa+jvz/Vj2DtnyUTpEFbcemjxojVWNQeLcu12SmELhrk5GJCKmoUTck8TqwAsoUEG4QXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993629; c=relaxed/simple;
	bh=VSFz1mtZAI7LVWJasVFxxYCmZEcOB5UIumVyp282rWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjEdjHDTe+27OmFslCQECH2/N1BgOeiJf5RQBiySXLTUoEnNl5AamdZMIcwiJjKUhzVy3dZyzoM98ssdDPpDTC9MKU7Jm1Mr4buCLElKqgaRP4dt4dtYMq6hzc361OVRi0GEbZuZcbudoEs+3ejVyR6cur+Zc2tlgAdvGxWb1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDJTKq13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86846C116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768993627;
	bh=VSFz1mtZAI7LVWJasVFxxYCmZEcOB5UIumVyp282rWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CDJTKq134wZxPzlnR5Redt6DJHGkj7M/k8Anf3iw3l3feYlRJ281UhmWDRbgD2Lfz
	 unA4bogcu1sqGldoFip2qy4cegLq5/eH9hVwv0S6ap3s6mwHPEwUrgFjMXHqpcW/vD
	 oFFh33tBGzP5RKx4vL70Zbm3c3SeBqTgSugYOPTlECE6Fuszps+7WfAkJCBzpH62Pb
	 lQY5BzEPTP8DHeLkj6v6r5qX6LNVPhazJpN14uRdPcz/V7OpR4SQ6ViFzcI3FC8hWL
	 0KB6YR+XCsZYebFbUTh1Rz98BvYuHr0aZhp/odHyrfIwMusT8J6LOCU64Zkg6x1OFr
	 UIUx18hcwBoEw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65807298140so2473819a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 03:07:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yx4sh4UqFzItdKBb31fI1nRb5Jb9PRxLAIMQntSXe3KJ4q5kmdn
	hrjX3WsAgb05rIeh+3jiinVm3d9KchCRxbRxxPF9upONga61ICz/NQ5CaQ4SZ3J6uFHK1n/bgJH
	0RIbS+qyGwHuZsm9m1vIqur916omugLk=
X-Received: by 2002:a17:907:9688:b0:b87:3809:6982 with SMTP id
 a640c23a62f3a-b88003ad9a9mr453547666b.57.1768993626099; Wed, 21 Jan 2026
 03:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120064305.439036-1-jinbaohong@synology.com>
In-Reply-To: <20260120064305.439036-1-jinbaohong@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 21 Jan 2026 11:06:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4NnuPgTfGs7+=Hf11k61V+1XJ_AXrjv5mhCDrvStVk5A@mail.gmail.com>
X-Gm-Features: AZwV_Qjrczbt-CXyte73Sd0hQaCtMK6xUxRL4DYqfEYRUR0SyqpPYzABnfa89ws
Message-ID: <CAL3q7H4NnuPgTfGs7+=Hf11k61V+1XJ_AXrjv5mhCDrvStVk5A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix transaction commit blocking during trim of
 unallocated space
To: jinbaohong <jinbaohong@synology.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, 
	robbieko <robbieko@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-20809-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,synology.com:email]
X-Rspamd-Queue-Id: CD6D155DB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 6:59=E2=80=AFAM jinbaohong <jinbaohong@synology.com=
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
>  fs/btrfs/extent-tree.c | 145 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 127 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 89495e6f8269..7b4708212be6 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6400,10 +6400,13 @@ void btrfs_error_unpin_extent_range(struct btrfs_=
fs_info *fs_info, u64 start, u6
>   * it while performing the free space search since we have already
>   * held back allocations.
>   */
> -static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *tri=
mmed)
> +static int btrfs_trim_free_extents_throttle(struct btrfs_device *device,
> +               u64 *trimmed, u64 pos, u64 maxlen, u64 *ret_next_pos)

Since maxlen never changes, please make it a #define and stop passing
it as a parameter and defining it as a local variable in the stack of
the caller function.

>  {
> -       u64 start =3D BTRFS_DEVICE_RANGE_RESERVED, len =3D 0, end =3D 0;
> +       u64 start =3D pos, len =3D 0, end =3D 0;
>         int ret;
> +       u64 cur_start;
> +       u64 trim_len =3D 0;
>
>         *trimmed =3D 0;
>
> @@ -6429,9 +6432,11 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
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
>                 /* Check if there are any CHUNK_* bits left */
>                 if (start > device->total_bytes) {
> @@ -6457,6 +6462,7 @@ static int btrfs_trim_free_extents(struct btrfs_dev=
ice *device, u64 *trimmed)
>                 end =3D min(end, device->total_bytes - 1);
>
>                 len =3D end - start + 1;
> +               len =3D min(len, maxlen);
>
>                 /* We didn't find any extents */
>                 if (!len) {
> @@ -6477,6 +6483,12 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>
>                 start +=3D len;
>                 *trimmed +=3D bytes;
> +               trim_len +=3D len;
> +               if (trim_len >=3D maxlen) {
> +                       *ret_next_pos =3D start;
> +                       ret =3D -EAGAIN;
> +                       break;
> +               }
>
>                 if (btrfs_trim_interrupted()) {
>                         ret =3D -ERESTARTSYS;
> @@ -6489,6 +6501,114 @@ static int btrfs_trim_free_extents(struct btrfs_d=
evice *device, u64 *trimmed)
>         return ret;
>  }
>
> +
> +static int btrfs_trim_free_extents(struct btrfs_fs_info *fs_info, u64 *t=
rimmed)
> +{
> +       int ret;
> +       struct btrfs_device *dev;
> +       struct btrfs_device *working_dev =3D NULL;
> +       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> +       u8 uuid[BTRFS_UUID_SIZE];
> +       u64 start =3D BTRFS_DEVICE_RANGE_RESERVED;
> +       u64 maxlen =3D SZ_2G;

As said above, make it a define like for example:

#define BTRFS_MAX_TRIM_LENGHT SZ_2G

> +       u64 next_pos =3D 0;
> +       u64 group_trimmed;

Also any variables that are used only inside the loop below, declare
them in the loop's scope.

> +
> +       *trimmed =3D 0;
> +
> +       mutex_lock(&fs_devices->device_list_mutex);
> +       list_for_each_entry(dev, &fs_devices->devices, dev_list) {
> +               if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> +                       continue;
> +               if (!working_dev ||
> +                       memcmp(dev->uuid, working_dev->uuid, BTRFS_UUID_S=
IZE) < 0)

This indentation is odd and confusing because it's indented to the
line below, i.e, the code that is part of the if statement.
Indent to the opening parentheses.

> +                       working_dev =3D dev;
> +       }
> +       if (working_dev)
> +               memcpy(uuid, working_dev->uuid, BTRFS_UUID_SIZE);
> +       mutex_unlock(&fs_devices->device_list_mutex);
> +       if (!working_dev) {
> +               ret =3D 0;
> +               goto out;
> +       }
> +
> +       while (1) {
> +               mutex_lock(&fs_devices->device_list_mutex);
> +               ret =3D 0;
> +
> +               group_trimmed =3D 0;

These variables can be initialized before taking the mutex.
Anything that can be done outside the critical section should be done
outside it.

> +               list_for_each_entry(dev, &fs_devices->devices, dev_list) =
{
> +                       if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_s=
tate))
> +                               continue;
> +                       if (dev =3D=3D working_dev) {
> +                               ret =3D btrfs_trim_free_extents_throttle(=
working_dev,
> +                                       &group_trimmed, start, maxlen, &n=
ext_pos);
> +                               break;
> +                       }
> +               }
> +               *trimmed +=3D group_trimmed;
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
> +                               /* must larger than current uuid */

Please always capitalize the first word in a comment and end the
sentence with punctation.

> +                               if (memcmp(dev->uuid, uuid, BTRFS_UUID_SI=
ZE) <=3D 0)
> +                                       continue;
> +
> +                               /* find the smallest */

Same here.

> +                               if (!working_dev ||
> +                                       memcmp(dev->uuid, working_dev->uu=
id, BTRFS_UUID_SIZE) < 0)

Same here about the confusing indentation.

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
> +                               goto out;
> +                       }
> +                       start =3D next_pos;
> +                       ret =3D 0;
> +               }
> +
> +               if (ret)
> +                       goto out;
> +
> +               if (!working_dev) /* error or no more device */

Same here about the comment and place it above the line with the if stateme=
nt.


> +                       break;
> +
> +               if (btrfs_trim_interrupted()) {
> +                       ret =3D -ERESTARTSYS;
> +                       goto out;
> +               }
> +               cond_resched();
> +       }
> +
> +       ret =3D 0;
> +out:
> +       return ret;

Please don't do this. This is a pointless label that makes the code
unnecessarily harder to read.
Just remove the label and make every goto do a "return ret" - much
more straightforward and makes the code shorter too.

And then here do a return 0 instead of

ret =3D 0;
return ret;

Thanks.

> +}
> +
>  /*
>   * Trim the whole filesystem by:
>   * 1) trimming the free space in each block group
> @@ -6500,9 +6620,7 @@ static int btrfs_trim_free_extents(struct btrfs_dev=
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
> @@ -6564,21 +6682,12 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, =
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
>

