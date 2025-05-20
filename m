Return-Path: <linux-btrfs+bounces-14140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA83ABE0AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936F53A7220
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6103526A09A;
	Tue, 20 May 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC1TzDIW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061D1B6CE3
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758548; cv=none; b=k0VpNkpId+NpCO8lRVLBpNAJCBJslPVFYa/l2Pa7s8T3dR3mKIJ+0DYjQ8GhKG4WDTuewH5wO43dQ5Je/50T6bQMItehCt3+GaKh+fSexNE7qy2BprSSvuWf8ohZ/NZpnCFL1O6AdtnZzWJ15T2VTsbPJ18Ibp90dDg9kWZwn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758548; c=relaxed/simple;
	bh=qHvb3/iRGMH6d+qLfGLLwsrGXfK+7g4CaN2CaEGP8bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn22HuE94CBCsqP3EQ2Pji9cP+vhTcPAR8ylItt8jtNbKNLlBlFrCjfW5fC8+N5RW2jXtY/kbVjQMDM9bXUm4oNL6lSWzUQTcV51kjxpWMX5uKXKoPUEKpRcy4j9DEe+orJzPAYmsK4YMxIp0JR6Ve+DzfC6weoptK6ws3XUhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC1TzDIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031F1C4CEEA
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747758548;
	bh=qHvb3/iRGMH6d+qLfGLLwsrGXfK+7g4CaN2CaEGP8bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AC1TzDIW3jFONLv5M0RZXMejcER3NUMyZ40TKhffI3uWo8mVCGKaniPyD2xv5xYFY
	 aAK2JMjRhFpKLSEcx+rGiOMobC7ynj+VqIf8AW1RmWb9WKBUwDylVukVPvaRGDBL24
	 L7G32sERN7WPfZ0I45QKFXTbLQOcMxI+rlXCVx7vKixg8/t28IHSnv0HA/c6QZHwxe
	 gxAx4u79K3BFEMka64PhNqFdZCXgmEC9nlIoB9H0DPmDzD9Z/bbahTShHGuYizRqMP
	 v+7wFqRaXiFT0FCPtA32iI/Xk8yFnXBprruP6bphoZwb+mOfNfPoA7lTLCAQFytNnR
	 ndvhN9AP9xVYQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac34257295dso841131766b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 09:29:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YxYCa55qGDRSym4LcEdnNc5xxjWIuepOVYR1cqjS7lt/OJS3GKv
	yQYPrx/vMxnlxglQ1/KR0WyRHdBvUjZKjQV37sfeyWeJ/2O2LPFy/6BKo7juXQ9Oo38WN/z/TYL
	IuYHY0CP4bbIkTUiqP8zfnMthy3W7MsM=
X-Google-Smtp-Source: AGHT+IG0ByNltJfGul0VYzvB3XWhYh179w9SKorJ201zqHfto8JDHlw3JFSu9dO7YpHzUXdhkspuPjnCeaFl7Z4Ywmk=
X-Received: by 2002:a17:907:6eaa:b0:ad2:238e:4a1b with SMTP id
 a640c23a62f3a-ad52d498e5dmr1698820566b.15.1747758546480; Tue, 20 May 2025
 09:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
 <48119a4a4f85402b34f337d1660c08c29de9aaeb.1747741149.git.anand.jain@oracle.com>
In-Reply-To: <48119a4a4f85402b34f337d1660c08c29de9aaeb.1747741149.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 May 2025 17:28:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4tSrYEsr2Q6Lp+9dxFCJ_6MegMfisVOaCBbQ8nJwX_EQ@mail.gmail.com>
X-Gm-Features: AX0GCFucSALLwm_w58dfWOamR9hPNtDyBoj3eIMTBb-63WUSAeihwBw3X1xnKXs
Message-ID: <CAL3q7H4tSrYEsr2Q6Lp+9dxFCJ_6MegMfisVOaCBbQ8nJwX_EQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add prefix for the scrub error message
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:43=E2=80=AFPM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> Add a "scrub: " prefix to all messages logged by scrub so that it's
> easy to filter them from dmesg for analysis.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
> v2: Improve scrub messages in ioctl.c (suggested by Qu).
>     Update commit log (suggested by Filipe).
>
>  fs/btrfs/ioctl.c |  2 +-
>  fs/btrfs/scrub.c | 53 +++++++++++++++++++++++++-----------------------
>  2 files changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a498fe524c90..1e8f7082239c 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3142,7 +3142,7 @@ static long btrfs_ioctl_scrub(struct file *file, vo=
id __user *arg)
>                 return -EPERM;
>
>         if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> -               btrfs_err(fs_info, "scrub is not supported on extent tree=
 v2 yet");
> +               btrfs_err(fs_info, "scrub: extent tree v2 not yet support=
ed");
>                 return -EINVAL;
>         }
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index ed120621021b..558f0d249dcf 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -557,7 +557,7 @@ static int scrub_print_warning_inode(u64 inum, u64 of=
fset, u64 num_bytes,
>          */
>         for (i =3D 0; i < ipath->fspath->elem_cnt; ++i)
>                 btrfs_warn_in_rcu(fs_info,
> -"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, off=
set %llu, length %u, links %u (path: %s)",
> +"scrub: %s at logical %llu on dev %s, physical %llu, root %llu, inode %l=
lu, offset %llu, length %u, links %u (path: %s)",
>                                   swarn->errstr, swarn->logical,
>                                   btrfs_dev_name(swarn->dev),
>                                   swarn->physical,
> @@ -571,7 +571,7 @@ static int scrub_print_warning_inode(u64 inum, u64 of=
fset, u64 num_bytes,
>
>  err:
>         btrfs_warn_in_rcu(fs_info,
> -                         "%s at logical %llu on dev %s, physical %llu, r=
oot %llu, inode %llu, offset %llu: path resolving failed with ret=3D%d",
> +                         "scrub: %s at logical %llu on dev %s, physical =
%llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=3D=
%d",
>                           swarn->errstr, swarn->logical,
>                           btrfs_dev_name(swarn->dev),
>                           swarn->physical,
> @@ -596,7 +596,8 @@ static void scrub_print_common_warning(const char *er=
rstr, struct btrfs_device *
>
>         /* Super block error, no need to search extent tree. */
>         if (is_super) {
> -               btrfs_warn_in_rcu(fs_info, "%s on device %s, physical %ll=
u",
> +               btrfs_warn_in_rcu(fs_info,
> +                                 "scrub: %s on device %s, physical %llu"=
,

There's no need to split this line. A length of 83 characters is ok
nowadays and improves readability.

>                                   errstr, btrfs_dev_name(dev), physical);
>                 return;
>         }
> @@ -631,14 +632,14 @@ static void scrub_print_common_warning(const char *=
errstr, struct btrfs_device *
>                                                       &ref_level);
>                         if (ret < 0) {
>                                 btrfs_warn(fs_info,
> -                               "failed to resolve tree backref for logic=
al %llu: %d",
> -                                                 swarn.logical, ret);
> +                  "scrub: failed to resolve tree backref for logical %ll=
u: %d",
> +                                          swarn.logical, ret);
>                                 break;
>                         }
>                         if (ret > 0)
>                                 break;
>                         btrfs_warn_in_rcu(fs_info,
> -"%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in =
tree %llu",
> +"scrub: %s at logical %llu on dev %s, physical %llu: metadata %s (level =
%d) in tree %llu",
>                                 errstr, swarn.logical, btrfs_dev_name(dev=
),
>                                 swarn.physical, (ref_level ? "node" : "le=
af"),
>                                 ref_level, ref_root);
> @@ -718,7 +719,7 @@ static void scrub_verify_one_metadata(struct scrub_st=
ripe *stripe, int sector_nr
>                 scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_pe=
r_tree);
>                 scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tre=
e);
>                 btrfs_warn_rl(fs_info,
> -               "tree block %llu mirror %u has bad bytenr, has %llu want =
%llu",
> +         "scrub: tree block %llu mirror %u has bad bytenr, has %llu want=
 %llu",
>                               logical, stripe->mirror_num,
>                               btrfs_stack_header_bytenr(header), logical)=
;
>                 return;
> @@ -728,7 +729,7 @@ static void scrub_verify_one_metadata(struct scrub_st=
ripe *stripe, int sector_nr
>                 scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_pe=
r_tree);
>                 scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tre=
e);
>                 btrfs_warn_rl(fs_info,
> -               "tree block %llu mirror %u has bad fsid, has %pU want %pU=
",
> +             "scrub: tree block %llu mirror %u has bad fsid, has %pU wan=
t %pU",
>                               logical, stripe->mirror_num,
>                               header->fsid, fs_info->fs_devices->fsid);
>                 return;
> @@ -738,7 +739,7 @@ static void scrub_verify_one_metadata(struct scrub_st=
ripe *stripe, int sector_nr
>                 scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_pe=
r_tree);
>                 scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tre=
e);
>                 btrfs_warn_rl(fs_info,
> -               "tree block %llu mirror %u has bad chunk tree uuid, has %=
pU want %pU",
> +   "scrub: tree block %llu mirror %u has bad chunk tree uuid, has %pU wa=
nt %pU",
>                               logical, stripe->mirror_num,
>                               header->chunk_tree_uuid, fs_info->chunk_tre=
e_uuid);
>                 return;
> @@ -760,7 +761,7 @@ static void scrub_verify_one_metadata(struct scrub_st=
ripe *stripe, int sector_nr
>                 scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_pe=
r_tree);
>                 scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tre=
e);
>                 btrfs_warn_rl(fs_info,
> -               "tree block %llu mirror %u has bad csum, has " CSUM_FMT "=
 want " CSUM_FMT,
> +"scrub: tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " =
CSUM_FMT,
>                               logical, stripe->mirror_num,
>                               CSUM_FMT_VALUE(fs_info->csum_size, on_disk_=
csum),
>                               CSUM_FMT_VALUE(fs_info->csum_size, calculat=
ed_csum));
> @@ -771,7 +772,7 @@ static void scrub_verify_one_metadata(struct scrub_st=
ripe *stripe, int sector_nr
>                 scrub_bitmap_set_meta_gen_error(stripe, sector_nr, sector=
s_per_tree);
>                 scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tre=
e);
>                 btrfs_warn_rl(fs_info,
> -               "tree block %llu mirror %u has bad generation, has %llu w=
ant %llu",
> +      "scrub: tree block %llu mirror %u has bad generation, has %llu wan=
t %llu",
>                               logical, stripe->mirror_num,
>                               btrfs_stack_header_generation(header),
>                               stripe->sectors[sector_nr].generation);
> @@ -814,7 +815,7 @@ static void scrub_verify_one_sector(struct scrub_stri=
pe *stripe, int sector_nr)
>                  */
>                 if (unlikely(sector_nr + sectors_per_tree > stripe->nr_se=
ctors)) {
>                         btrfs_warn_rl(fs_info,
> -                       "tree block at %llu crosses stripe boundary %llu"=
,
> +                      "scrub: tree block at %llu crosses stripe boundary=
 %llu",
>                                       stripe->logical +
>                                       (sector_nr << fs_info->sectorsize_b=
its),
>                                       stripe->logical);
> @@ -1046,12 +1047,12 @@ static void scrub_stripe_report_errors(struct scr=
ub_ctx *sctx,
>                 if (repaired) {
>                         if (dev) {
>                                 btrfs_err_rl_in_rcu(fs_info,
> -                       "fixed up error at logical %llu on dev %s physica=
l %llu",
> +               "scrub: fixed up error at logical %llu on dev %s physical=
 %llu",
>                                             stripe->logical, btrfs_dev_na=
me(dev),
>                                             physical);
>                         } else {
>                                 btrfs_err_rl_in_rcu(fs_info,
> -                       "fixed up error at logical %llu on mirror %u",
> +                          "scrub: fixed up error at logical %llu on mirr=
or %u",
>                                             stripe->logical, stripe->mirr=
or_num);
>                         }
>                         continue;
> @@ -1060,12 +1061,12 @@ static void scrub_stripe_report_errors(struct scr=
ub_ctx *sctx,
>                 /* The remaining are all for unrepaired. */
>                 if (dev) {
>                         btrfs_err_rl_in_rcu(fs_info,
> -       "unable to fixup (regular) error at logical %llu on dev %s physic=
al %llu",
> +"scrub: unable to fixup (regular) error at logical %llu on dev %s physic=
al %llu",
>                                             stripe->logical, btrfs_dev_na=
me(dev),
>                                             physical);
>                 } else {
>                         btrfs_err_rl_in_rcu(fs_info,
> -       "unable to fixup (regular) error at logical %llu on mirror %u",
> +         "scrub: unable to fixup (regular) error at logical %llu on mirr=
or %u",
>                                             stripe->logical, stripe->mirr=
or_num);
>                 }
>
> @@ -1594,7 +1595,7 @@ static int sync_write_pointer_for_zoned(struct scru=
b_ctx *sctx, u64 logical,
>                                                     sctx->write_pointer);
>                 if (ret)
>                         btrfs_err(fs_info,
> -                                 "zoned: failed to recover write pointer=
");
> +                              "scrub: zoned: failed to recover write poi=
nter");
>         }
>         mutex_unlock(&sctx->wr_lock);
>         btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
> @@ -1658,7 +1659,8 @@ static int scrub_find_fill_first_stripe(struct btrf=
s_block_group *bg,
>         int ret;
>
>         if (unlikely(!extent_root || !csum_root)) {
> -               btrfs_err(fs_info, "no valid extent or csum root for scru=
b");
> +               btrfs_err(fs_info,
> +                         "scrub: no valid extent or csum root found");

Same here. This one even stays at 80 characters.

>                 return -EUCLEAN;
>         }
>         memset(stripe->sectors, 0, sizeof(struct scrub_sector_verificatio=
n) *
> @@ -1907,7 +1909,7 @@ static bool stripe_has_metadata_error(struct scrub_=
stripe *stripe)
>                         struct btrfs_fs_info *fs_info =3D stripe->bg->fs_=
info;
>
>                         btrfs_err(fs_info,
> -                       "stripe %llu has unrepaired metadata sector at %l=
lu",
> +                   "scrub: stripe %llu has unrepaired metadata sector at=
 %llu",
>                                   stripe->logical,
>                                   stripe->logical + (i << fs_info->sector=
size_bits));
>                         return true;
> @@ -2167,7 +2169,7 @@ static int scrub_raid56_parity_stripe(struct scrub_=
ctx *sctx,
>                 bitmap_and(&error, &error, &has_extent, stripe->nr_sector=
s);
>                 if (!bitmap_empty(&error, stripe->nr_sectors)) {
>                         btrfs_err(fs_info,
> -"unrepaired sectors detected, full stripe %llu data stripe %u errors %*p=
bl",
> +"scrub: unrepaired sectors detected, full stripe %llu data stripe %u err=
ors %*pbl",
>                                   full_stripe_start, i, stripe->nr_sector=
s,
>                                   &error);
>                         ret =3D -EIO;
> @@ -2789,14 +2791,15 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx=
,
>                         ro_set =3D 0;
>                 } else if (ret =3D=3D -ETXTBSY) {
>                         btrfs_warn(fs_info,
> -                  "skipping scrub of block group %llu due to active swap=
file",
> +            "scrub: skipping scrub of block group %llu due to active swa=
pfile",
>                                    cache->start);
>                         scrub_pause_off(fs_info);
>                         ret =3D 0;
>                         goto skip_unfreeze;
>                 } else {
>                         btrfs_warn(fs_info,
> -                                  "failed setting block group ro: %d", r=
et);
> +                                  "scrub: failed setting block group ro:=
 %d",
> +                                  ret);

Same here.

These are things that can be adjusted at commit time, so no need to
resend just for that.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>                         btrfs_unfreeze_block_group(cache);
>                         btrfs_put_block_group(cache);
>                         scrub_pause_off(fs_info);
> @@ -2898,13 +2901,13 @@ static int scrub_one_super(struct scrub_ctx *sctx=
, struct btrfs_device *dev,
>         ret =3D btrfs_check_super_csum(fs_info, sb);
>         if (ret !=3D 0) {
>                 btrfs_err_rl(fs_info,
> -                       "super block at physical %llu devid %llu has bad =
csum",
> +                 "scrub: super block at physical %llu devid %llu has bad=
 csum",
>                         physical, dev->devid);
>                 return -EIO;
>         }
>         if (btrfs_super_generation(sb) !=3D generation) {
>                 btrfs_err_rl(fs_info,
> -"super block at physical %llu devid %llu has bad generation %llu expect =
%llu",
> +"scrub: super block at physical %llu devid %llu has bad generation %llu =
expect %llu",
>                              physical, dev->devid,
>                              btrfs_super_generation(sb), generation);
>                 return -EUCLEAN;
> @@ -3065,7 +3068,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, =
u64 devid, u64 start,
>             !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
>                 mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>                 btrfs_err_in_rcu(fs_info,
> -                       "scrub on devid %llu: filesystem on %s is not wri=
table",
> +                       "scrub: devid %llu: filesystem on %s is not writa=
ble",
>                                  devid, btrfs_dev_name(dev));
>                 ret =3D -EROFS;
>                 goto out;
> --
> 2.49.0
>

