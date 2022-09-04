Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4631D5AC3E4
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 12:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiIDK2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 06:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiIDK2V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 06:28:21 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013534332D
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 03:28:20 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so15584515fac.4
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Sep 2022 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=J1lLq3dkCnFXhJh/rcWFRz35aWK4unf65fJA4CUuA54=;
        b=hOeNE1GUyzKCsIwdXrX1GnwPqBtzc2DhCEjNBLeLTref/t6IKggfW530vY6S4KBqWa
         fB7VV81s7s4wKVHg7nbRRW90sxdbsV6gq5NXpjqGlL03v+C4v4kWTFef7CIzRBuJhD+x
         O56HuEjGOliuGkXsV/1noWBaXqGziWqoQGJHGRF2YowEZ6X2elIXtWBb88rlUyInx6jg
         bvAbSdgv29b5EebBB/DyLJk9UKF9XoZIAm1A0i2REIPf0S+fjoY3JVZHrKZDG5tO1waS
         gs0Gjj5kG7w5gwcy12aMJdvRRMFZ2Tw3q8shmrf+r6gxTPqAllRHtkiutJwel3JQC7Ha
         5NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J1lLq3dkCnFXhJh/rcWFRz35aWK4unf65fJA4CUuA54=;
        b=VQLkJXoaohuiSQ8jsQpQxXp4DqpAfntL0W/SW3uQNRsowh5WzHY7F6E+wZl9vlp0ga
         hmeqItL7chkgT0Jc2+vJtVd4vsFNwjfAB58Ws67Dj9GpIcxsnc5Gzt6x59NslJsId/pW
         o21x+VRWzxpRQCzhRP57uXcrNsKU3x+d9IMgtxCRu9sgj8mEqub7OlmzmWAnVaNvQOpV
         vMLlwuo/YD42mOVCyZhDArt8kmhmqQAxSv3KN0v4VDcC4AAtRG2fpxdPiTxHYg8/flGa
         e4dX6RpmFAP6IXjsUYAFw0EZKBmi7rrOQw9GZ7aTjRmwDpEOhRZZK339AlLa+4HMgZYz
         auog==
X-Gm-Message-State: ACgBeo3Biv/8JgXEOTfiVhpSML6hA8rEDA1lUITzkejnd/MrSI73XYV4
        GEViZNSBDKF88KRGNBMwFoD6EMBzQ000lcrNUuI=
X-Google-Smtp-Source: AA6agR5xEZeCW/0St1Y939k4hljcCxDoWOvwbj3JYJfHwFU0ic+j7A+8jf8MqZ7wgvTaQHRjWzriZITLyvPVpDFUQy4=
X-Received: by 2002:a05:6808:209c:b0:345:c3ec:639c with SMTP id
 s28-20020a056808209c00b00345c3ec639cmr5301016oiw.42.1662287299156; Sun, 04
 Sep 2022 03:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <1662279863-17114-1-git-send-email-zhanglikernel@gmail.com>
 <c4aa8e99-1613-e453-4a3a-be9d0de4b021@gmx.com> <CAAa-AGmyFx470zcd9DgCnRRDoQHC7inLEts4RU2JXww1GeXYsA@mail.gmail.com>
 <90233ce0-04a5-d97f-6d64-33db1045b762@suse.com>
In-Reply-To: <90233ce0-04a5-d97f-6d64-33db1045b762@suse.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Sun, 4 Sep 2022 18:28:07 +0800
Message-ID: <CAAa-AG=k2+KomNkuxMwYARbxXaZVshFtDtN_kV6nPwjE5mC9xg@mail.gmail.com>
Subject: Re: [PATCH V4] btrfs-progs: Make btrfs_prepare_device parallel during mkfs.btrfs
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ok, I got you.

Thanks,
Li

Qu Wenruo <wqu@suse.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=884=E6=97=A5=E5=91=
=A8=E6=97=A5 17:50=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/9/4 17:31, li zhang wrote:
> > My first thought was that we should give the default value a least priv=
ilege,
> > so when others want to use this global value they should think about wh=
at
> > privileges they really need, so at first I initialized opt_oflags with =
0,
> > but scripts/checkpatch. pl(btrfs-devel) says I can't initialize global =
variables
> > with 0 and opt_zoned with false.
>
> For checkpatch, I guess the reason is, static global variable is already
> initialized to 0, thus no need to specificially assign it to 0/false.
>
> But if you can provide some context, like the checkpatch error, maybe
> I'm totally wrong.
>
>
> Another thing related the privillege is, the global variables are only
> for mkfs usage.
>
> I can hardly come up any reason that we want read-only open flags for
> mkfs...
>
> Thanks,
> Qu
>
> > So I compromised to initialize opt_oflags
> > with O_RDONLY and opt_zoned with false .
> >
> > Thanks,
> > Li
> >
> > Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=884=E6=
=97=A5=E5=91=A8=E6=97=A5 16:40=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>
> >>
> >> On 2022/9/4 16:24, Li Zhang wrote:
> >>> [enhancement]
> >>> When a disk is formatted as btrfs, it calls
> >>> btrfs_prepare_device for each device, which takes too much time.
> >>>
> >>> [implementation]
> >>> Put each btrfs_prepare_device into a thread,
> >>> wait for the first thread to complete to mkfs.btrfs,
> >>> and wait for other threads to complete before adding
> >>> other devices to the file system.
> >>>
> >>> [test]
> >>> Using the btrfs-progs test case mkfs-tests, mkfs.btrfs works fine.
> >>>
> >>> Use tcmu-runner emulation to simulate two devices for testing.
> >>> Each device is 2000G (about 19.53 TiB), the region size is 4MB,
> >>> Use the following parameters for targetcli
> >>> create name=3Dzbc0 size=3D20000G cfgstring=3Dmodel-HM/zsize-4/conv-10=
0@~/zbc0.raw
> >>>
> >>> Call difftime to calculate the running time of the function btrfs_pre=
pare_device.
> >>> Calculate the time from thread creation to completion of all threads =
after
> >>> patching (time calculation is not included in patch submission)
> >>> The test results are as follows.
> >>>
> >>> $ lsscsi -p
> >>> [10:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdb   -    =
      none
> >>> [11:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdc   -    =
      none
> >>>
> >>> $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
> >>> ....
> >>> time for prepare devices:4.000000.
> >>> ....
> >>>
> >>> $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
> >>> ...
> >>> time for prepare devices:2.000000.
> >>> ...
> >>>
> >>> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> >>> ---
> >>> Issue: 496
> >>>
> >>> V1:
> >>> * Put btrfs_prepare_device into threads and make them parallel
> >>>
> >>> V2:
> >>> * Set the 4 variables used by btrfs_prepare_device as global variable=
s.
> >>> * Use pthread_mutex to ensure error messages are not messed up.
> >>> * Correct the error message
> >>> * Wait for all threads to exit in a loop
> >>>
> >>> V3:
> >>> * Add prefix opt to the global variables
> >>> * Format code
> >>> * Add error handler for open
> >>>
> >>> V4:
> >>> * initialize the global options
> >>>
> >>>    mkfs/main.c | 154 +++++++++++++++++++++++++++++++++++++++++-------=
------------
> >>>    1 file changed, 107 insertions(+), 47 deletions(-)
> >>>
> >>> diff --git a/mkfs/main.c b/mkfs/main.c
> >>> index ce096d3..3e16a0e 100644
> >>> --- a/mkfs/main.c
> >>> +++ b/mkfs/main.c
> >>> @@ -31,6 +31,7 @@
> >>>    #include <uuid/uuid.h>
> >>>    #include <ctype.h>
> >>>    #include <blkid/blkid.h>
> >>> +#include <pthread.h>
> >>>    #include "kernel-shared/ctree.h"
> >>>    #include "kernel-shared/disk-io.h"
> >>>    #include "kernel-shared/free-space-tree.h"
> >>> @@ -60,6 +61,20 @@ struct mkfs_allocation {
> >>>        u64 system;
> >>>    };
> >>>
> >>> +static bool opt_zero_end =3D true;
> >>> +static bool opt_discard =3D true;
> >>> +static bool opt_zoned =3D true;
> >>> +static int opt_oflags =3D O_RDONLY;
> >>
> >> Isn't the default one should be O_RDWR?
> >>
> >> Despite that, feel free to addd my reviewed by tag:
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>
> >> Thanks,
> >> Qu
> >>> +
> >>> +static pthread_mutex_t prepare_mutex;
> >>> +
> >>> +struct prepare_device_progress {
> >>> +     char *file;
> >>> +     u64 dev_block_count;
> >>> +     u64 block_count;
> >>> +     int ret;
> >>> +};
> >>> +
> >>>    static int create_metadata_block_groups(struct btrfs_root *root, b=
ool mixed,
> >>>                                struct mkfs_allocation *allocation)
> >>>    {
> >>> @@ -969,6 +984,31 @@ fail:
> >>>        return ret;
> >>>    }
> >>>
> >>> +static void *prepare_one_dev(void *ctx)
> >>> +{
> >>> +     struct prepare_device_progress *prepare_ctx =3D ctx;
> >>> +     int fd;
> >>> +
> >>> +     fd =3D open(prepare_ctx->file, opt_oflags);
> >>> +     if (fd < 0) {
> >>> +             pthread_mutex_lock(&prepare_mutex);
> >>> +             error("unable to open %s: %m", prepare_ctx->file);
> >>> +             pthread_mutex_unlock(&prepare_mutex);
> >>> +             prepare_ctx->ret =3D fd;
> >>> +             return NULL;
> >>> +     }
> >>> +     prepare_ctx->ret =3D btrfs_prepare_device(fd,
> >>> +                     prepare_ctx->file,
> >>> +                     &prepare_ctx->dev_block_count,
> >>> +                     prepare_ctx->block_count,
> >>> +                     (bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> >>> +                     (opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
> >>> +                     (opt_discard ? PREP_DEVICE_DISCARD : 0) |
> >>> +                     (opt_zoned ? PREP_DEVICE_ZONED : 0));
> >>> +     close(fd);
> >>> +     return NULL;
> >>> +}
> >>> +
> >>>    int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>    {
> >>>        char *file;
> >>> @@ -984,7 +1024,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>        u32 nodesize =3D 0;
> >>>        u32 sectorsize =3D 0;
> >>>        u32 stripesize =3D 4096;
> >>> -     bool zero_end =3D true;
> >>>        int fd =3D -1;
> >>>        int ret =3D 0;
> >>>        int close_ret;
> >>> @@ -993,11 +1032,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>        bool nodesize_forced =3D false;
> >>>        bool data_profile_opt =3D false;
> >>>        bool metadata_profile_opt =3D false;
> >>> -     bool discard =3D true;
> >>>        bool ssd =3D false;
> >>> -     bool zoned =3D false;
> >>>        bool force_overwrite =3D false;
> >>> -     int oflags;
> >>>        char *source_dir =3D NULL;
> >>>        bool source_dir_set =3D false;
> >>>        bool shrink_rootdir =3D false;
> >>> @@ -1006,6 +1042,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>        u64 shrink_size;
> >>>        int dev_cnt =3D 0;
> >>>        int saved_optind;
> >>> +     pthread_t *t_prepare =3D NULL;
> >>> +     struct prepare_device_progress *prepare_ctx =3D NULL;
> >>>        char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] =3D { 0 };
> >>>        u64 features =3D BTRFS_MKFS_DEFAULT_FEATURES;
> >>>        u64 runtime_features =3D BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
> >>> @@ -1126,7 +1164,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>                                break;
> >>>                        case 'b':
> >>>                                block_count =3D parse_size_from_string=
(optarg);
> >>> -                             zero_end =3D false;
> >>> +                             opt_zero_end =3D false;
> >>>                                break;
> >>>                        case 'v':
> >>>                                bconf_be_verbose();
> >>> @@ -1144,7 +1182,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>                                        BTRFS_UUID_UNPARSED_SIZE - 1);
> >>>                                break;
> >>>                        case 'K':
> >>> -                             discard =3D false;
> >>> +                             opt_discard =3D false;
> >>>                                break;
> >>>                        case 'q':
> >>>                                bconf_be_quiet();
> >>> @@ -1183,7 +1221,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>        if (dev_cnt =3D=3D 0)
> >>>                print_usage(1);
> >>>
> >>> -     zoned =3D !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
> >>> +     opt_zoned =3D !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
> >>>
> >>>        if (source_dir_set && dev_cnt > 1) {
> >>>                error("the option -r is limited to a single device");
> >>> @@ -1225,7 +1263,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>
> >>>        file =3D argv[optind++];
> >>>        ssd =3D is_ssd(file);
> >>> -     if (zoned) {
> >>> +     if (opt_zoned) {
> >>>                if (!zone_size(file)) {
> >>>                        error("zoned: %s: zone size undefined", file);
> >>>                        exit(1);
> >>> @@ -1235,7 +1273,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>                        printf(
> >>>        "Zoned: %s: host-managed device detected, setting zoned featur=
e\n",
> >>>                               file);
> >>> -             zoned =3D true;
> >>> +             opt_zoned =3D true;
> >>>                features |=3D BTRFS_FEATURE_INCOMPAT_ZONED;
> >>>        }
> >>>
> >>> @@ -1302,7 +1340,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>                }
> >>>        }
> >>>
> >>> -     if (zoned) {
> >>> +     if (opt_zoned) {
> >>>                if (source_dir_set) {
> >>>                        error("the option -r and zoned mode are incomp=
atible");
> >>>                        exit(1);
> >>> @@ -1392,7 +1430,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>         * 1 zone for a metadata block group
> >>>         * 1 zone for a data block group
> >>>         */
> >>> -     if (zoned && block_count && block_count < 5 * zone_size(file)) =
{
> >>> +     if (opt_zoned && block_count && block_count < 5 * zone_size(fil=
e)) {
> >>>                error("size %llu is too small to make a usable filesys=
tem",
> >>>                        block_count);
> >>>                error("minimum size for a zoned btrfs filesystem is %l=
lu",
> >>> @@ -1422,35 +1460,58 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>        if (ret)
> >>>                goto error;
> >>>
> >>> -     if (zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADA=
TA | metadata_profile) ||
> >>> +     if (opt_zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_ME=
TADATA | metadata_profile) ||
> >>>                      !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA =
| data_profile))) {
> >>>                error("zoned mode does not yet support RAID/DUP profil=
es, please specify '-d single -m single' manually");
> >>>                goto error;
> >>>        }
> >>>
> >>> -     dev_cnt--;
> >>> +     t_prepare =3D calloc(dev_cnt, sizeof(*t_prepare));
> >>> +     prepare_ctx =3D calloc(dev_cnt, sizeof(*prepare_ctx));
> >>>
> >>> -     oflags =3D O_RDWR;
> >>> -     if (zoned && zoned_model(file) =3D=3D ZONED_HOST_MANAGED)
> >>> -             oflags |=3D O_DIRECT;
> >>> +     if (!t_prepare || !prepare_ctx) {
> >>> +             error("unable to alloc thread for preparing dev");
> >>> +             goto error;
> >>> +     }
> >>>
> >>> -     /*
> >>> -      * Open without O_EXCL so that the problem should not occur by =
the
> >>> -      * following operation in kernel:
> >>> -      * (btrfs_register_one_device() fails if O_EXCL is on)
> >>> -      */
> >>> -     fd =3D open(file, oflags);
> >>> +     pthread_mutex_init(&prepare_mutex, NULL);
> >>> +     opt_oflags =3D O_RDWR;
> >>> +     for (i =3D 0; i < dev_cnt; i++) {
> >>> +             if (opt_zoned && zoned_model(argv[optind + i - 1]) =3D=
=3D
> >>> +                     ZONED_HOST_MANAGED) {
> >>> +                     opt_oflags |=3D O_DIRECT;
> >>> +                     break;
> >>> +             }
> >>> +     }
> >>> +     for (i =3D 0; i < dev_cnt; i++) {
> >>> +             prepare_ctx[i].file =3D argv[optind + i - 1];
> >>> +             prepare_ctx[i].block_count =3D block_count;
> >>> +             prepare_ctx[i].dev_block_count =3D block_count;
> >>> +             ret =3D pthread_create(&t_prepare[i], NULL,
> >>> +                     prepare_one_dev, &prepare_ctx[i]);
> >>> +             if (ret) {
> >>> +                     error("create thread for prepare devices: %s fa=
iled, "
> >>> +                                     "errno: %d",
> >>> +                                     prepare_ctx[i].file, ret);
> >>> +                     goto error;
> >>> +             }
> >>> +     }
> >>> +     for (i =3D 0; i < dev_cnt; i++)
> >>> +             pthread_join(t_prepare[i], NULL);
> >>> +     ret =3D prepare_ctx[0].ret;
> >>> +
> >>> +     if (ret) {
> >>> +             error("unable prepare device: %s\n", prepare_ctx[0].fil=
e);
> >>> +             goto error;
> >>> +     }
> >>> +
> >>> +     dev_cnt--;
> >>> +     fd =3D open(file, opt_oflags);
> >>>        if (fd < 0) {
> >>>                error("unable to open %s: %m", file);
> >>>                goto error;
> >>>        }
> >>> -     ret =3D btrfs_prepare_device(fd, file, &dev_block_count, block_=
count,
> >>> -                     (zero_end ? PREP_DEVICE_ZERO_END : 0) |
> >>> -                     (discard ? PREP_DEVICE_DISCARD : 0) |
> >>> -                     (bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> >>> -                     (zoned ? PREP_DEVICE_ZONED : 0));
> >>> -     if (ret)
> >>> -             goto error;
> >>> +     dev_block_count =3D prepare_ctx[0].dev_block_count;
> >>>        if (block_count && block_count > dev_block_count) {
> >>>                error("%s is smaller than requested size, expected %ll=
u, found %llu",
> >>>                      file, (unsigned long long)block_count,
> >>> @@ -1459,7 +1520,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>        }
> >>>
> >>>        /* To create the first block group and chunk 0 in make_btrfs *=
/
> >>> -     system_group_size =3D zoned ?  zone_size(file) : BTRFS_MKFS_SYS=
TEM_GROUP_SIZE;
> >>> +     system_group_size =3D opt_zoned ? zone_size(file) : BTRFS_MKFS_=
SYSTEM_GROUP_SIZE;
> >>>        if (dev_block_count < system_group_size) {
> >>>                error("device is too small to make filesystem, must be=
 at least %llu",
> >>>                                (unsigned long long)system_group_size)=
;
> >>> @@ -1487,7 +1548,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>        mkfs_cfg.runtime_features =3D runtime_features;
> >>>        mkfs_cfg.csum_type =3D csum_type;
> >>>        mkfs_cfg.leaf_data_size =3D __BTRFS_LEAF_DATA_SIZE(nodesize);
> >>> -     if (zoned)
> >>> +     if (opt_zoned)
> >>>                mkfs_cfg.zone_size =3D zone_size(file);
> >>>        else
> >>>                mkfs_cfg.zone_size =3D 0;
> >>> @@ -1558,14 +1619,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>                goto raid_groups;
> >>>
> >>>        while (dev_cnt-- > 0) {
> >>> +             int dev_index =3D argc - saved_optind - dev_cnt - 1;
> >>>                file =3D argv[optind++];
> >>>
> >>> -             /*
> >>> -              * open without O_EXCL so that the problem should not
> >>> -              * occur by the following processing.
> >>> -              * (btrfs_register_one_device() fails if O_EXCL is on)
> >>> -              */
> >>> -             fd =3D open(file, O_RDWR);
> >>> +             fd =3D open(file, opt_oflags);
> >>>                if (fd < 0) {
> >>>                        error("unable to open %s: %m", file);
> >>>                        goto error;
> >>> @@ -1578,13 +1635,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >>>                        close(fd);
> >>>                        continue;
> >>>                }
> >>> -             ret =3D btrfs_prepare_device(fd, file, &dev_block_count=
,
> >>> -                             block_count,
> >>> -                             (bconf.verbose ? PREP_DEVICE_VERBOSE : =
0) |
> >>> -                             (zero_end ? PREP_DEVICE_ZERO_END : 0) |
> >>> -                             (discard ? PREP_DEVICE_DISCARD : 0) |
> >>> -                             (zoned ? PREP_DEVICE_ZONED : 0));
> >>> -             if (ret) {
> >>> +             dev_block_count =3D prepare_ctx[dev_index]
> >>> +                     .dev_block_count;
> >>> +
> >>> +             if (prepare_ctx[dev_index].ret) {
> >>> +                     error("unable prepare device: %s.\n",
> >>> +                                     prepare_ctx[dev_index].file);
> >>>                        goto error;
> >>>                }
> >>>
> >>> @@ -1714,8 +1770,8 @@ raid_groups:
> >>>                        btrfs_group_profile_str(metadata_profile),
> >>>                        pretty_size(allocation.system));
> >>>                printf("SSD detected:       %s\n", ssd ? "yes" : "no")=
;
> >>> -             printf("Zoned device:       %s\n", zoned ? "yes" : "no"=
);
> >>> -             if (zoned)
> >>> +             printf("Zoned device:       %s\n", opt_zoned ? "yes" : =
"no");
> >>> +             if (opt_zoned)
> >>>                        printf("  Zone size:        %s\n",
> >>>                               pretty_size(fs_info->zone_size));
> >>>                btrfs_parse_fs_features_to_string(features_buf, featur=
es);
> >>> @@ -1763,12 +1819,16 @@ out:
> >>>
> >>>        btrfs_close_all_devices();
> >>>        free(label);
> >>> -
> >>> +     free(t_prepare);
> >>> +     free(prepare_ctx);
> >>>        return !!ret;
> >>> +
> >>>    error:
> >>>        if (fd > 0)
> >>>                close(fd);
> >>>
> >>> +     free(t_prepare);
> >>> +     free(prepare_ctx);
> >>>        free(label);
> >>>        exit(1);
> >>>    success:
