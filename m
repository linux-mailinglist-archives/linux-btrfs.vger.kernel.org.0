Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF731C8B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 11:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPKXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 05:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhBPKWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 05:22:40 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43F2C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 02:21:59 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t62so8896997qke.7
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 02:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pIY2PD5IkDqmmhcYCPfNvVbuDgbZWQrKXS3I0QmoTDw=;
        b=DCjSES4xpFAGyr9gRH/8oeO1MvsgSKwznKxNVwfM0sY/1XUfWKEjNSNG1mko7sfq1e
         hqvBy7wN+ru3MNkEmVhAvja8SHUrstYH7rA1HXoW4MuyGtK1hk3+dR9VfQgc489FjVBH
         igEJ9HI894v4g4lxrl+YXb4cXE2uYjdZINjEAllTunL8L5NApmEZnEOmO1tdMAEI6No0
         Wf1ua2QLE2BrsZoCflLAvyM0eur5Y31lIxGyUwSv64CY8IWPcjYqKKscsUp3v3LlUsIa
         rf0X49YQp5RGu3WC/zYE6YK/Zt+4TLLY3j9mYcpnfoi19up6I1uQXuojoBiIB4TdlP6h
         6jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pIY2PD5IkDqmmhcYCPfNvVbuDgbZWQrKXS3I0QmoTDw=;
        b=MtWztc6gsqUcY5vxPhz5dYRKOqTb7xDWJ2lVeyLNTdF0TOLPUOu0dRb8RIvWt/Dkab
         u1e+J1R+p8uBs7OEf91A6LwdbkMSdXG0LRFio73Ws+0LRTosAHtEQPLn1gmHQcjVzBMj
         TFQt0I0GVtq9Ha4uhkVDKHeMwf8Ekg98YeEt0YbBXXFfHmZRSvS0NvMbT4dfGsLrMw0j
         Z7+/BOx63zdXKl1kWlyhIaa83zD2dyVRVVpmVMRx6EtBki7rcACUwkb7y6M9duUT7Rs3
         vBEvmfxIRrIB9yMDWrhGnbtBJ8z6ti2FUAY7EKW6OnBm8zksUR5BbibN8Fq1NjTfT5Zh
         48qw==
X-Gm-Message-State: AOAM53296c5Kb0FscXgFNQvvDnw1qHou6Nb1jJ+3XcG/9MqrwpoUW+UY
        MB2TOP95OFhDo4tKJZQXVVZeAo/5OAY17+KukREjfDlElRMGmw==
X-Google-Smtp-Source: ABdhPJyP2OdJKaVWY+jDkCt5EFY+PPIyDAOHEClTEW+j/g8cSggJXVFoDp301UKpG6cmmtK9C1G9+eprAXdY3XAZeXc=
X-Received: by 2002:a37:65d8:: with SMTP id z207mr18581883qkb.479.1613470919123;
 Tue, 16 Feb 2021 02:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20201111163909.3968-1-realwakka@gmail.com> <20201111163909.3968-2-realwakka@gmail.com>
In-Reply-To: <20201111163909.3968-2-realwakka@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 16 Feb 2021 10:21:48 +0000
Message-ID: <CAL3q7H4b7QhL02aSOpN0-k_9P2EAbj1t+NkA6VwidKEg4S996w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs-progs: device stats: add json output format
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 11, 2020 at 4:42 PM Sidong Yang <realwakka@gmail.com> wrote:
>
> Add supports for json formatting, this patch changes hard coded printing
> code to formatted print with output formatter. Json output would be
> useful for other programs that parse output of the command. but it
> changes the text format.
>
> Example text format:
>
> device:                 /dev/vdb
> devid                   1
> write_io_errs:          0
> read_io_errs:           0
> flush_io_errs:          0
> corruption_errs:        0
> generation_errs:        0
>
> Example json format:
>
> {
>   "__header": {
>     "version": "1"
>   },
>   "device-stats": [
>     {
>       "device": "/dev/vdb",
>       "devid": "1",
>       "write_io_errs": "0",
>       "read_io_errs": "0",
>       "flush_io_errs": "0",
>       "corruption_errs": "0",
>       "generation_errs": "0"
>     }
>   ],
> }
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Hi,

This breaks at least one test case from fstests:

$ ./check btrfs/006
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian8 5.11.0-rc6-btrfs-next-80 #1 SMP
PREEMPT Wed Feb 3 11:28:05 WET 2021
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/006 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/006.out.bad)
    --- tests/btrfs/006.out 2020-06-10 19:29:03.810518987 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/006.out.bad
2021-02-16 10:18:53.967066620 +0000
    @@ -15,12 +15,14 @@

     =3D=3D Sync filesystem
     =3D=3D Show device stats by mountpoint
    + 1
     <NUMDEVS> [SCRATCH_DEV].corruption_errs <NUM>
     <NUMDEVS> [SCRATCH_DEV].flush_io_errs <NUM>
     <NUMDEVS> [SCRATCH_DEV].generation_errs <NUM>
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/006.out
/home/fdmanana/git/hub/xfstests/results//btrfs/006.out.bad'  to see
the entire diff)
Ran: btrfs/006
Failures: btrfs/006
Failed 1 of 1 tests

That extra 1 is coming somewhere from this patch.


> ---
> v2:
>  - use json array for print
> ---
>  cmds/device.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/cmds/device.c b/cmds/device.c
> index d72881f8..8b8fc85c 100644
> --- a/cmds/device.c
> +++ b/cmds/device.c
> @@ -36,6 +36,7 @@
>  #include "common/path-utils.h"
>  #include "common/device-utils.h"
>  #include "common/device-scan.h"
> +#include "common/format-output.h"
>  #include "mkfs/common.h"
>
>  static const char * const device_cmd_group_usage[] =3D {
> @@ -459,6 +460,17 @@ out:
>  }
>  static DEFINE_SIMPLE_COMMAND(device_ready, "ready");
>
> +static const struct rowspec device_stats_rowspec[] =3D {
> +       { .key =3D "device", .fmt =3D "%s", .out_text =3D "device", .out_=
json =3D "device" },
> +       { .key =3D "devid", .fmt =3D "%u", .out_text =3D "devid", .out_js=
on =3D "devid" },
> +       { .key =3D "write_io_errs", .fmt =3D "%llu", .out_text =3D "write=
_io_errs", .out_json =3D "write_io_errs" },
> +       { .key =3D "read_io_errs", .fmt =3D "%llu", .out_text =3D "read_i=
o_errs", .out_json =3D "read_io_errs" },
> +       { .key =3D "flush_io_errs", .fmt =3D "%llu", .out_text =3D "flush=
_io_errs", .out_json =3D "flush_io_errs" },
> +       { .key =3D "corruption_errs", .fmt =3D "%llu", .out_text =3D "cor=
ruption_errs", .out_json =3D "corruption_errs" },
> +       { .key =3D "generation_errs", .fmt =3D "%llu", .out_text =3D "gen=
eration_errs", .out_json =3D "generation_errs" },
> +       ROWSPEC_END
> +};
> +
>  static const char * const cmd_device_stats_usage[] =3D {
>         "btrfs device stats [options] <path>|<device>",
>         "Show device IO error statistics",
> @@ -482,6 +494,7 @@ static int cmd_device_stats(const struct cmd_struct *=
cmd, int argc, char **argv)
>         int check =3D 0;
>         __u64 flags =3D 0;
>         DIR *dirstream =3D NULL;
> +       struct format_ctx fctx;
>
>         optind =3D 0;
>         while (1) {
> @@ -530,6 +543,8 @@ static int cmd_device_stats(const struct cmd_struct *=
cmd, int argc, char **argv)
>                 goto out;
>         }
>
> +       fmt_start(&fctx, device_stats_rowspec, 24, 0);
> +       fmt_print_start_group(&fctx, "device-stats", JSON_TYPE_ARRAY);
>         for (i =3D 0; i < fi_args.num_devices; i++) {
>                 struct btrfs_ioctl_get_dev_stats args =3D {0};
>                 char path[BTRFS_DEVICE_PATH_NAME_MAX + 1];
> @@ -548,6 +563,7 @@ static int cmd_device_stats(const struct cmd_struct *=
cmd, int argc, char **argv)
>                         err |=3D 1;
>                 } else {
>                         char *canonical_path;
> +                       char devid_str[32];
>                         int j;
>                         static const struct {
>                                 const char name[32];
> @@ -574,31 +590,36 @@ static int cmd_device_stats(const struct cmd_struct=
 *cmd, int argc, char **argv)
>                                 snprintf(canonical_path, 32,
>                                          "devid:%llu", args.devid);
>                         }
> +                       snprintf(devid_str, 32, "%llu", args.devid);
> +                       fmt_print_start_object(&fctx);
> +                       fmt_print(&fctx, "device", canonical_path);
> +                       fmt_print(&fctx, "devid", di_args[i].devid);
>
>                         for (j =3D 0; j < ARRAY_SIZE(dev_stats); j++) {
>                                 /* We got fewer items than we know */
>                                 if (args.nr_items < dev_stats[j].num + 1)
>                                         continue;
> -                               printf("[%s].%-16s %llu\n", canonical_pat=
h,
> -                                       dev_stats[j].name,
> -                                       (unsigned long long)
> -                                        args.values[dev_stats[j].num]);
> +
> +                               fmt_print(&fctx, dev_stats[j].name, args.=
values[dev_stats[j].num]);
>                                 if ((check =3D=3D 1)
>                                     && (args.values[dev_stats[j].num] > 0=
))
>                                         err |=3D 64;
>                         }
> -
> +                       fmt_print_end_object(&fctx);
>                         free(canonical_path);
>                 }
>         }
>
> +       fmt_print_end_group(&fctx, "device-stats");
> +       fmt_end(&fctx);
> +
>  out:
>         free(di_args);
>         close_file_or_dir(fdmnt, dirstream);
>
>         return err;
>  }
> -static DEFINE_SIMPLE_COMMAND(device_stats, "stats");
> +static DEFINE_COMMAND_WITH_FLAGS(device_stats, "stats", CMD_FORMAT_JSON)=
;
>
>  static const char * const cmd_device_usage_usage[] =3D {
>         "btrfs device usage [options] <path> [<path>..]",
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
