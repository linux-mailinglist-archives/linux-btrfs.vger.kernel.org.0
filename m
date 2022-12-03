Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4764D641771
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Dec 2022 16:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiLCPKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Dec 2022 10:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLCPKl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Dec 2022 10:10:41 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF9D222B6
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Dec 2022 07:10:40 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id n205so8304009oib.1
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Dec 2022 07:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcisi9f0Jez7UVUR29fyd1xrTRLf6cuxlidt3bTjxdw=;
        b=DYs/CqDQEBkyZp9Gb0ocovPwmzHZr1Ajf9nFfieGiNV/vKpKpAzAwXF9kZAjaLsgGR
         4wWRpuf8OLz0cwnCt8J2jXV+3kFme9VVMeMEelUHC7E6ufG4Vg1PTxb8keVvzguDJiht
         C2z4u7ue7UMi1dCMNMM7PbiDHmv4YcvE3n2TAcObQ2gwpVHgeAJ7nEQ+VeQEq1m7pOmT
         NDiMYVkHhMMSWRYFOa5/NktyORlQqkv9G5r9qlPsvW/XtLI8mGlQFUkmthQ0BNXpq6N8
         rDlE08OihgLko7OeEsR37RJMIgFzHwtMObtmXN4nJUl1CY6Qkz8WRIrGALvCm02iw5Fb
         svOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcisi9f0Jez7UVUR29fyd1xrTRLf6cuxlidt3bTjxdw=;
        b=wCMLYgsbA1kVhpK/+S3Ge9TWSPoNiXOeBdwnilAQhTk2NK9WY3XavVkDWZ5ipYjJ5v
         YvwGmHTjmJFkJZAGKJS61cP74vGKgitoCLJn7sihypZk6mWlB88tRxM4h+giml7tiUPp
         gmR31cHLJJZ8xV/bdnVleUJgcuVls7SkDR+re2lxTF2UXoe3sYbER6oQNUTnP+MY3gbF
         w5+9IlB7yy4e410ya+IHzWDzU1l9QhUq18cB+H3fUmAOc1w2V4fEuU5JdXjIlSMuydOm
         KphLgMLU4P8MsmKA4M3j9FRog4jKe4GwlOgaNZ7KJoQfpONxIkvHUDViAPuUtKqS21CZ
         0d1Q==
X-Gm-Message-State: ANoB5plQL316PV8pEIOYnIlMpMd9GIjYkZabe5qJT7zuZJPTiXPgslu4
        PZJtbVoxvLIaUvWWDe+mfCcTnDuihsILfUd86jk=
X-Google-Smtp-Source: AA0mqf6OHNgxWEzgrbAwO9DbF+pwV41XmUVtY3hy/f0ANDJ9xzS21FINQbJk6JSX2AYyXZLTqc2YDra20PN93VNSA18=
X-Received: by 2002:a05:6808:1482:b0:359:c6de:916a with SMTP id
 e2-20020a056808148200b00359c6de916amr26643356oiw.42.1670080239311; Sat, 03
 Dec 2022 07:10:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1664353497.git.wqu@suse.com> <36c909e90fa85813afa206e7f0e0a10177c841b3.1664353497.git.wqu@suse.com>
In-Reply-To: <36c909e90fa85813afa206e7f0e0a10177c841b3.1664353497.git.wqu@suse.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Sat, 3 Dec 2022 23:10:27 +0800
Message-ID: <CAAa-AGnd4qRbQ-MRNsTMNKJLP7j+NZrMOV2KRDaKDhUtrrnowQ@mail.gmail.com>
Subject: Re: [PATCH PoC v2 01/10] btrfs: introduce BTRFS_IOC_SCRUB_FS family
 of ioctls
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <wqu@suse.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8828=E6=97=A5=E5=91=
=A8=E4=B8=89 16:40=E5=86=99=E9=81=93=EF=BC=9A
>
> The new ioctls are to address the disadvantages of the existing
> btrfs_scrub_dev():
>
> a One thread per-device
>   This can cause multiple block groups to be marked read-only for scrub,
>   reducing available space temporarily.
>
>   This also causes higher CPU/IO usage.
>   For scrub, we should use the minimal amount of CPU and cause less
>   IO when possible.
>
> b Extra IO for RAID56
>   For data stripes, we will cause at least 2x IO if we run "btrfs scrub
>   start <mnt>".
>   1x from scrubbing the device of data stripe.
>   The other 1x from scrubbing the parity stripe.
>
>   This duplicated IO should definitely be avoided
>
> c Bad progress report for RAID56
>   We can not report any repaired P/Q bytes at all.
>
> The a and b will be addressed by the new one thread per-fs
> btrfs_scrub_fs ioctl.
>
> While c will be addressed by the new btrfs_scrub_fs_progress structure,
> which has better comments and classification for all errors.
>
> This patch is only a skeleton for the new family of ioctls, will return
> -EOPNOTSUPP for now.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c           |   6 ++
>  include/uapi/linux/btrfs.h | 174 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 180 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index d5dd8bed1488..6944216e1425 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -5508,6 +5508,12 @@ long btrfs_ioctl(struct file *file, unsigned int
>                 return btrfs_ioctl_scrub_cancel(fs_info);
>         case BTRFS_IOC_SCRUB_PROGRESS:
>                 return btrfs_ioctl_scrub_progress(fs_info, argp);
> +       case BTRFS_IOC_SCRUB_FS:
> +               return -EOPNOTSUPP;
> +       case BTRFS_IOC_SCRUB_FS_CANCEL:
> +               return -EOPNOTSUPP;
> +       case BTRFS_IOC_SCRUB_FS_PROGRESS:
> +               return -EOPNOTSUPP;
>         case BTRFS_IOC_BALANCE_V2:
>                 return btrfs_ioctl_balance(file, argp);
>         case BTRFS_IOC_BALANCE_CTL:
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 5655e89b962b..86169e2ffefe 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -191,6 +191,175 @@ struct btrfs_ioctl_scrub_args {
>         __u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
>  };
>
> +struct btrfs_scrub_fs_progress {
> +       /*
> +        * Fatal errors, including -ENOMEM, or csum/extent tree search er=
rors.
> +        *
> +        * Normally after hitting such fatal errors, we error out, thus l=
ater
> +        * accounting will no longer be reliable.
> +        */
> +       __u16   nr_fatal_errors;
> +
> +       /*
> +        * All super errors, from invalid members and IO error all go int=
o
> +        * nr_super_errors.
> +        */
> +       __u16   nr_super_errors;
> +
> +       /* Super block accounting. */
> +       __u16   nr_super_scrubbed;
> +       __u16   nr_super_repaired;
> +
> +       /*
> +        * Data accounting in bytes.
> +        *
> +        * We only care about how many bytes we scrubbed, thus no
> +        * accounting for number of extents.
> +        *
> +        * This accounting includes the extra mirrors.
> +        * E.g. for RAID1, one 16KiB extent will cause 32KiB in @data_scr=
ubbed.
> +        */
> +       __u64   data_scrubbed;
> +
> +       /* How many bytes can be recovered. */
> +       __u64   data_recoverable;
> +
> +       /*
> +        * How many bytes don't have csum.
> +        *
> +        * For nocsum case we won't even try to compare the different cop=
ies.
> +        * As for NOCSUM case we can not distignuish NODATASUM data and
> +        * pre-allocated extents without doing expensive backref walk.
> +        */
> +       __u64   data_nocsum;
> +
> +       /*
> +        * For data error bytes, these means determining errors, includin=
g:
> +        *
> +        * - IO failure, including missing dev.
> +        * - Data csum mismatch
> +        *   Csum tree search failure must go above case.
> +        */
> +       __u64   data_io_fail;
> +       __u64   data_csum_mismatch;
> +
> +       /*
> +        * All the unmentioned cases, including data matching its csum (o=
f
> +        * course, implies IO suceeded) and data has no csum but matches =
all
> +        * other copies/parities, are the expected cases, no need to reco=
rd.
> +        */
> +
> +       /*
> +        * Metadata accounting in bytes, pretty much the same as data.
> +        *
> +        * And since metadata has mandatory csum, there is no uncertain c=
ase.
> +        */
> +       __u64   meta_scrubbed;
> +       __u64   meta_recoverable;
> +
> +       /*
> +        * For meta, the checks are mostly progressive:
> +        *
> +        * - Unable to read
> +        *   @meta_io_fail
> +        *
> +        * - Unable to pass basic sanity checks (e.g. bytenr check)
> +        *   @meta_invalid
> +        *
> +        * - Pass basic sanity checks, but bad csum
> +        *   @meta_bad_csum
> +        *
> +        * - Pass basic checks and csum, but bad transid
> +        *   @meta_bad_transid
> +        *
> +        * - Pass all checks
> +        *   The expected case, no special accounting needed.
> +        */
> +       __u64 meta_io_fail;
> +       __u64 meta_invalid;
> +       __u64 meta_bad_csum;
> +       __u64 meta_bad_transid;
> +
> +       /*
> +        * Parity accounting.
> +        *
> +        * NOTE: for unused data sectors (but still contributes to P/Q
> +        * calculation, like the following case), they don't contribute
> +        * to any accounting.
> +        *
> +        * Data 1:      |<--- Unused ---->| <<<
> +        * Data 2:      |<- Data extent ->|
> +        * Parity:      |<--- Parity ---->|
> +        */
> +       __u64 parity_scrubbed;
> +       __u64 parity_recoverable;
> +
> +       /*
> +        * This happens when there is not enough info to determine if the
> +        * parity is correct, mostly happens when vertical stripes are
> +        * *all* NODATASUM sectors.
> +        *
> +        * If there is any sector with checksum in the vertical stripe,
> +        * parity itself will be no longer uncertain.
> +        */
> +       __u64 parity_uncertain;
> +
> +       /*
> +        * For parity, the checks are progressive too:
> +        *
> +        * - Unable to read
> +        *   @parity_io_fail
> +        *
> +        * - Mismatch and any veritical data stripe has csum and
> +        *   the data stripe csum matches
> +        *   @parity_mismatch
> +        *   We want to repair the parity then.
> +        *
> +        * - Mismatch and veritical data stripe has csum, and data
> +        *   csum mismatch. And rebuilt data passes csum.
> +        *   This will go @data_recoverable or @data_csum_mismatch instea=
d.
> +        *
> +        * - Mismatch but no veritical data stripe has csum
> +        *   @parity_uncertain
> +        *
> +        */
> +       __u64 parity_io_fail;
> +       __u64 parity_mismatch;
> +
> +       /* Padding to 256 bytes, and for later expansion. */
> +       __u64 __unused[15];
> +};
It looks like this btrfs_scrub_fs_progress is missing
a member for unverified errors like the old btrfs_scrub_progress used to
indicate that an error came up but went away during a recheck. But
this is a poc patch,
just wondering if this recheck feature will be added to the official patch.

Also, just curious, what kind of situation would cause the first read
of a block that appears
to be corrupted, but the second read everything is fine. Could bad
sectors on the hard drive cause this?

> +static_assert(sizeof(struct btrfs_scrub_fs_progress) =3D=3D 256);
> +
> +/*
> + * Readonly scrub fs will not try any repair (thus *_repaired member
> + * in scrub_fs_progress should always be 0).
> + */
> +#define BTRFS_SCRUB_FS_FLAG_READONLY   (1ULL << 0)
> +
> +/*
> + * All supported flags.
> + *
> + * From the very beginning, scrub_fs ioctl would reject any unsupported
> + * flags, making later expansion much simper.
> + */
> +#define BTRFS_SCRUB_FS_FLAG_SUPP       (BTRFS_SCRUB_FS_FLAG_READONLY)
> +
> +struct btrfs_ioctl_scrub_fs_args {
> +       /* Input, logical bytenr to start the scrub */
> +       __u64 start;
> +
> +       /* Input, the logical bytenr end (inclusive) */
> +       __u64 end;
> +
> +       __u64 flags;
> +       __u64 reserved[8];
> +       struct btrfs_scrub_fs_progress progress; /* out */
> +
> +       /* pad to 1K */
> +       __u8 unused[1024 - 24 - 64 - sizeof(struct btrfs_scrub_fs_progres=
s)];
> +};
> +
>  #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS   0
>  #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_AVOID    1
>  struct btrfs_ioctl_dev_replace_start_params {
> @@ -1143,5 +1312,10 @@ enum btrfs_err_code {
>                                     struct btrfs_ioctl_encoded_io_args)
>  #define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
>                                      struct btrfs_ioctl_encoded_io_args)
> +#define BTRFS_IOC_SCRUB_FS     _IOWR(BTRFS_IOCTL_MAGIC, 65, \
> +                                     struct btrfs_ioctl_scrub_fs_args)
> +#define BTRFS_IOC_SCRUB_FS_CANCEL _IO(BTRFS_IOCTL_MAGIC, 66)
> +#define BTRFS_IOC_SCRUB_FS_PROGRESS _IOWR(BTRFS_IOCTL_MAGIC, 67, \
> +                                      struct btrfs_ioctl_scrub_fs_args)
>
>  #endif /* _UAPI_LINUX_BTRFS_H */
> --
> 2.37.3
>


Best Regards
Li
