Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9845AC3A2
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 11:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiIDJba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIDJb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 05:31:28 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F103F1F0
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 02:31:27 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id q6-20020a4aa886000000b0044b06d0c453so1077803oom.11
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Sep 2022 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=GosYQN6akbnyxc5DZ4z+7L2angCGfSC+YIDmZr7zjN8=;
        b=orH20ypPeOxEnGtXqtfoSgJzJk2gzxDUTtbWLwDbAw/qEFi2dIKhRm/EG4mge/AB6l
         7eEzFUyMRZHWjGic/xKouyrkDZbiI5gr+63qovG5fryM2SY9P0SUsSNV/MTHjnlO3YSv
         fz2tvnpSLIKn8M2ApmHqU22syvmKmvHOuoG/IGxnRHH4B2zan8zTUaCVPe0Dt99HXOGI
         k7Tef09xU1kgMLsRLt6T46fD2yynL5DrTFQk84hMfzu+6gYb7pYAyIIPA3qLJrNLhrMW
         YxrZKIMsHM1SG+oTPICXpv3gERXZcF2eXu+5CsZ+2Sl+bFKqr418ncuK2WDkyxHDh522
         i1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GosYQN6akbnyxc5DZ4z+7L2angCGfSC+YIDmZr7zjN8=;
        b=btW2vrF3kkhiir61codahWMXYN87Stmk76ERA6GYQNGGFvhY2HEUDocA+F1vUbIHq0
         RkuJSARLYCrMMlMJNlWMXhFR5KkxeD6Mn5i2JTOr8sf1sA/eNRLR+i6mEVbPPLIPf/Vt
         Bc0FTkzP0WvxT1Q0iNVVj5f1ViT774N4CKurtZgTr8IRYzDWPwpkvuqDN7qeYarvGUlR
         x/vdnJfRVSnZmsAHjZuvfdIursYnkJGoxawnTUVe4GoASUK6HR4NIllCSicH2Mi2mU06
         k94Nz1euEZPoN/oIG696dabvyPaB9DY4Opd2GhO41UdxdkwOL4kjMzXItp6DWKTULSfQ
         6DhA==
X-Gm-Message-State: ACgBeo0E3rDerVtoam0Wp3sJz0DJEtcwkPW0sEA5V+y4dCQs5kWq6yPt
        8MGJAYSx1Fw7lD7uyMRtY+nGhoN+POodALXuxr4=
X-Google-Smtp-Source: AA6agR7qQI1ncVc53zHwIaboVYrihSdob1y6kZLW6oU7j9apL0rXXSlNWoi5m0Txf9nGPdeO4jd2zsUYf8nrpskbLnI=
X-Received: by 2002:a4a:c215:0:b0:442:75f3:61b2 with SMTP id
 z21-20020a4ac215000000b0044275f361b2mr15227586oop.93.1662283886595; Sun, 04
 Sep 2022 02:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <1662279863-17114-1-git-send-email-zhanglikernel@gmail.com> <c4aa8e99-1613-e453-4a3a-be9d0de4b021@gmx.com>
In-Reply-To: <c4aa8e99-1613-e453-4a3a-be9d0de4b021@gmx.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Sun, 4 Sep 2022 17:31:15 +0800
Message-ID: <CAAa-AGmyFx470zcd9DgCnRRDoQHC7inLEts4RU2JXww1GeXYsA@mail.gmail.com>
Subject: Re: [PATCH V4] btrfs-progs: Make btrfs_prepare_device parallel during mkfs.btrfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
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

My first thought was that we should give the default value a least privileg=
e,
so when others want to use this global value they should think about what
privileges they really need, so at first I initialized opt_oflags with 0,
but scripts/checkpatch. pl(btrfs-devel) says I can't initialize global vari=
ables
with 0 and opt_zoned with false. So I compromised to initialize opt_oflags
with O_RDONLY and opt_zoned with false .

Thanks,
Li

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=884=E6=97=
=A5=E5=91=A8=E6=97=A5 16:40=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/9/4 16:24, Li Zhang wrote:
> > [enhancement]
> > When a disk is formatted as btrfs, it calls
> > btrfs_prepare_device for each device, which takes too much time.
> >
> > [implementation]
> > Put each btrfs_prepare_device into a thread,
> > wait for the first thread to complete to mkfs.btrfs,
> > and wait for other threads to complete before adding
> > other devices to the file system.
> >
> > [test]
> > Using the btrfs-progs test case mkfs-tests, mkfs.btrfs works fine.
> >
> > Use tcmu-runner emulation to simulate two devices for testing.
> > Each device is 2000G (about 19.53 TiB), the region size is 4MB,
> > Use the following parameters for targetcli
> > create name=3Dzbc0 size=3D20000G cfgstring=3Dmodel-HM/zsize-4/conv-100@=
~/zbc0.raw
> >
> > Call difftime to calculate the running time of the function btrfs_prepa=
re_device.
> > Calculate the time from thread creation to completion of all threads af=
ter
> > patching (time calculation is not included in patch submission)
> > The test results are as follows.
> >
> > $ lsscsi -p
> > [10:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdb   -      =
    none
> > [11:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdc   -      =
    none
> >
> > $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
> > ....
> > time for prepare devices:4.000000.
> > ....
> >
> > $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
> > ...
> > time for prepare devices:2.000000.
> > ...
> >
> > Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> > ---
> > Issue: 496
> >
> > V1:
> > * Put btrfs_prepare_device into threads and make them parallel
> >
> > V2:
> > * Set the 4 variables used by btrfs_prepare_device as global variables.
> > * Use pthread_mutex to ensure error messages are not messed up.
> > * Correct the error message
> > * Wait for all threads to exit in a loop
> >
> > V3:
> > * Add prefix opt to the global variables
> > * Format code
> > * Add error handler for open
> >
> > V4:
> > * initialize the global options
> >
> >   mkfs/main.c | 154 +++++++++++++++++++++++++++++++++++++++++----------=
---------
> >   1 file changed, 107 insertions(+), 47 deletions(-)
> >
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index ce096d3..3e16a0e 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -31,6 +31,7 @@
> >   #include <uuid/uuid.h>
> >   #include <ctype.h>
> >   #include <blkid/blkid.h>
> > +#include <pthread.h>
> >   #include "kernel-shared/ctree.h"
> >   #include "kernel-shared/disk-io.h"
> >   #include "kernel-shared/free-space-tree.h"
> > @@ -60,6 +61,20 @@ struct mkfs_allocation {
> >       u64 system;
> >   };
> >
> > +static bool opt_zero_end =3D true;
> > +static bool opt_discard =3D true;
> > +static bool opt_zoned =3D true;
> > +static int opt_oflags =3D O_RDONLY;
>
> Isn't the default one should be O_RDWR?
>
> Despite that, feel free to addd my reviewed by tag:
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
> > +
> > +static pthread_mutex_t prepare_mutex;
> > +
> > +struct prepare_device_progress {
> > +     char *file;
> > +     u64 dev_block_count;
> > +     u64 block_count;
> > +     int ret;
> > +};
> > +
> >   static int create_metadata_block_groups(struct btrfs_root *root, bool=
 mixed,
> >                               struct mkfs_allocation *allocation)
> >   {
> > @@ -969,6 +984,31 @@ fail:
> >       return ret;
> >   }
> >
> > +static void *prepare_one_dev(void *ctx)
> > +{
> > +     struct prepare_device_progress *prepare_ctx =3D ctx;
> > +     int fd;
> > +
> > +     fd =3D open(prepare_ctx->file, opt_oflags);
> > +     if (fd < 0) {
> > +             pthread_mutex_lock(&prepare_mutex);
> > +             error("unable to open %s: %m", prepare_ctx->file);
> > +             pthread_mutex_unlock(&prepare_mutex);
> > +             prepare_ctx->ret =3D fd;
> > +             return NULL;
> > +     }
> > +     prepare_ctx->ret =3D btrfs_prepare_device(fd,
> > +                     prepare_ctx->file,
> > +                     &prepare_ctx->dev_block_count,
> > +                     prepare_ctx->block_count,
> > +                     (bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> > +                     (opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
> > +                     (opt_discard ? PREP_DEVICE_DISCARD : 0) |
> > +                     (opt_zoned ? PREP_DEVICE_ZONED : 0));
> > +     close(fd);
> > +     return NULL;
> > +}
> > +
> >   int BOX_MAIN(mkfs)(int argc, char **argv)
> >   {
> >       char *file;
> > @@ -984,7 +1024,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >       u32 nodesize =3D 0;
> >       u32 sectorsize =3D 0;
> >       u32 stripesize =3D 4096;
> > -     bool zero_end =3D true;
> >       int fd =3D -1;
> >       int ret =3D 0;
> >       int close_ret;
> > @@ -993,11 +1032,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >       bool nodesize_forced =3D false;
> >       bool data_profile_opt =3D false;
> >       bool metadata_profile_opt =3D false;
> > -     bool discard =3D true;
> >       bool ssd =3D false;
> > -     bool zoned =3D false;
> >       bool force_overwrite =3D false;
> > -     int oflags;
> >       char *source_dir =3D NULL;
> >       bool source_dir_set =3D false;
> >       bool shrink_rootdir =3D false;
> > @@ -1006,6 +1042,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >       u64 shrink_size;
> >       int dev_cnt =3D 0;
> >       int saved_optind;
> > +     pthread_t *t_prepare =3D NULL;
> > +     struct prepare_device_progress *prepare_ctx =3D NULL;
> >       char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] =3D { 0 };
> >       u64 features =3D BTRFS_MKFS_DEFAULT_FEATURES;
> >       u64 runtime_features =3D BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
> > @@ -1126,7 +1164,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >                               break;
> >                       case 'b':
> >                               block_count =3D parse_size_from_string(op=
targ);
> > -                             zero_end =3D false;
> > +                             opt_zero_end =3D false;
> >                               break;
> >                       case 'v':
> >                               bconf_be_verbose();
> > @@ -1144,7 +1182,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >                                       BTRFS_UUID_UNPARSED_SIZE - 1);
> >                               break;
> >                       case 'K':
> > -                             discard =3D false;
> > +                             opt_discard =3D false;
> >                               break;
> >                       case 'q':
> >                               bconf_be_quiet();
> > @@ -1183,7 +1221,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >       if (dev_cnt =3D=3D 0)
> >               print_usage(1);
> >
> > -     zoned =3D !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
> > +     opt_zoned =3D !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
> >
> >       if (source_dir_set && dev_cnt > 1) {
> >               error("the option -r is limited to a single device");
> > @@ -1225,7 +1263,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >
> >       file =3D argv[optind++];
> >       ssd =3D is_ssd(file);
> > -     if (zoned) {
> > +     if (opt_zoned) {
> >               if (!zone_size(file)) {
> >                       error("zoned: %s: zone size undefined", file);
> >                       exit(1);
> > @@ -1235,7 +1273,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >                       printf(
> >       "Zoned: %s: host-managed device detected, setting zoned feature\n=
",
> >                              file);
> > -             zoned =3D true;
> > +             opt_zoned =3D true;
> >               features |=3D BTRFS_FEATURE_INCOMPAT_ZONED;
> >       }
> >
> > @@ -1302,7 +1340,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >               }
> >       }
> >
> > -     if (zoned) {
> > +     if (opt_zoned) {
> >               if (source_dir_set) {
> >                       error("the option -r and zoned mode are incompati=
ble");
> >                       exit(1);
> > @@ -1392,7 +1430,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >        * 1 zone for a metadata block group
> >        * 1 zone for a data block group
> >        */
> > -     if (zoned && block_count && block_count < 5 * zone_size(file)) {
> > +     if (opt_zoned && block_count && block_count < 5 * zone_size(file)=
) {
> >               error("size %llu is too small to make a usable filesystem=
",
> >                       block_count);
> >               error("minimum size for a zoned btrfs filesystem is %llu"=
,
> > @@ -1422,35 +1460,58 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >       if (ret)
> >               goto error;
> >
> > -     if (zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA=
 | metadata_profile) ||
> > +     if (opt_zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_META=
DATA | metadata_profile) ||
> >                     !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA | d=
ata_profile))) {
> >               error("zoned mode does not yet support RAID/DUP profiles,=
 please specify '-d single -m single' manually");
> >               goto error;
> >       }
> >
> > -     dev_cnt--;
> > +     t_prepare =3D calloc(dev_cnt, sizeof(*t_prepare));
> > +     prepare_ctx =3D calloc(dev_cnt, sizeof(*prepare_ctx));
> >
> > -     oflags =3D O_RDWR;
> > -     if (zoned && zoned_model(file) =3D=3D ZONED_HOST_MANAGED)
> > -             oflags |=3D O_DIRECT;
> > +     if (!t_prepare || !prepare_ctx) {
> > +             error("unable to alloc thread for preparing dev");
> > +             goto error;
> > +     }
> >
> > -     /*
> > -      * Open without O_EXCL so that the problem should not occur by th=
e
> > -      * following operation in kernel:
> > -      * (btrfs_register_one_device() fails if O_EXCL is on)
> > -      */
> > -     fd =3D open(file, oflags);
> > +     pthread_mutex_init(&prepare_mutex, NULL);
> > +     opt_oflags =3D O_RDWR;
> > +     for (i =3D 0; i < dev_cnt; i++) {
> > +             if (opt_zoned && zoned_model(argv[optind + i - 1]) =3D=3D
> > +                     ZONED_HOST_MANAGED) {
> > +                     opt_oflags |=3D O_DIRECT;
> > +                     break;
> > +             }
> > +     }
> > +     for (i =3D 0; i < dev_cnt; i++) {
> > +             prepare_ctx[i].file =3D argv[optind + i - 1];
> > +             prepare_ctx[i].block_count =3D block_count;
> > +             prepare_ctx[i].dev_block_count =3D block_count;
> > +             ret =3D pthread_create(&t_prepare[i], NULL,
> > +                     prepare_one_dev, &prepare_ctx[i]);
> > +             if (ret) {
> > +                     error("create thread for prepare devices: %s fail=
ed, "
> > +                                     "errno: %d",
> > +                                     prepare_ctx[i].file, ret);
> > +                     goto error;
> > +             }
> > +     }
> > +     for (i =3D 0; i < dev_cnt; i++)
> > +             pthread_join(t_prepare[i], NULL);
> > +     ret =3D prepare_ctx[0].ret;
> > +
> > +     if (ret) {
> > +             error("unable prepare device: %s\n", prepare_ctx[0].file)=
;
> > +             goto error;
> > +     }
> > +
> > +     dev_cnt--;
> > +     fd =3D open(file, opt_oflags);
> >       if (fd < 0) {
> >               error("unable to open %s: %m", file);
> >               goto error;
> >       }
> > -     ret =3D btrfs_prepare_device(fd, file, &dev_block_count, block_co=
unt,
> > -                     (zero_end ? PREP_DEVICE_ZERO_END : 0) |
> > -                     (discard ? PREP_DEVICE_DISCARD : 0) |
> > -                     (bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> > -                     (zoned ? PREP_DEVICE_ZONED : 0));
> > -     if (ret)
> > -             goto error;
> > +     dev_block_count =3D prepare_ctx[0].dev_block_count;
> >       if (block_count && block_count > dev_block_count) {
> >               error("%s is smaller than requested size, expected %llu, =
found %llu",
> >                     file, (unsigned long long)block_count,
> > @@ -1459,7 +1520,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >       }
> >
> >       /* To create the first block group and chunk 0 in make_btrfs */
> > -     system_group_size =3D zoned ?  zone_size(file) : BTRFS_MKFS_SYSTE=
M_GROUP_SIZE;
> > +     system_group_size =3D opt_zoned ? zone_size(file) : BTRFS_MKFS_SY=
STEM_GROUP_SIZE;
> >       if (dev_block_count < system_group_size) {
> >               error("device is too small to make filesystem, must be at=
 least %llu",
> >                               (unsigned long long)system_group_size);
> > @@ -1487,7 +1548,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >       mkfs_cfg.runtime_features =3D runtime_features;
> >       mkfs_cfg.csum_type =3D csum_type;
> >       mkfs_cfg.leaf_data_size =3D __BTRFS_LEAF_DATA_SIZE(nodesize);
> > -     if (zoned)
> > +     if (opt_zoned)
> >               mkfs_cfg.zone_size =3D zone_size(file);
> >       else
> >               mkfs_cfg.zone_size =3D 0;
> > @@ -1558,14 +1619,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >               goto raid_groups;
> >
> >       while (dev_cnt-- > 0) {
> > +             int dev_index =3D argc - saved_optind - dev_cnt - 1;
> >               file =3D argv[optind++];
> >
> > -             /*
> > -              * open without O_EXCL so that the problem should not
> > -              * occur by the following processing.
> > -              * (btrfs_register_one_device() fails if O_EXCL is on)
> > -              */
> > -             fd =3D open(file, O_RDWR);
> > +             fd =3D open(file, opt_oflags);
> >               if (fd < 0) {
> >                       error("unable to open %s: %m", file);
> >                       goto error;
> > @@ -1578,13 +1635,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >                       close(fd);
> >                       continue;
> >               }
> > -             ret =3D btrfs_prepare_device(fd, file, &dev_block_count,
> > -                             block_count,
> > -                             (bconf.verbose ? PREP_DEVICE_VERBOSE : 0)=
 |
> > -                             (zero_end ? PREP_DEVICE_ZERO_END : 0) |
> > -                             (discard ? PREP_DEVICE_DISCARD : 0) |
> > -                             (zoned ? PREP_DEVICE_ZONED : 0));
> > -             if (ret) {
> > +             dev_block_count =3D prepare_ctx[dev_index]
> > +                     .dev_block_count;
> > +
> > +             if (prepare_ctx[dev_index].ret) {
> > +                     error("unable prepare device: %s.\n",
> > +                                     prepare_ctx[dev_index].file);
> >                       goto error;
> >               }
> >
> > @@ -1714,8 +1770,8 @@ raid_groups:
> >                       btrfs_group_profile_str(metadata_profile),
> >                       pretty_size(allocation.system));
> >               printf("SSD detected:       %s\n", ssd ? "yes" : "no");
> > -             printf("Zoned device:       %s\n", zoned ? "yes" : "no");
> > -             if (zoned)
> > +             printf("Zoned device:       %s\n", opt_zoned ? "yes" : "n=
o");
> > +             if (opt_zoned)
> >                       printf("  Zone size:        %s\n",
> >                              pretty_size(fs_info->zone_size));
> >               btrfs_parse_fs_features_to_string(features_buf, features)=
;
> > @@ -1763,12 +1819,16 @@ out:
> >
> >       btrfs_close_all_devices();
> >       free(label);
> > -
> > +     free(t_prepare);
> > +     free(prepare_ctx);
> >       return !!ret;
> > +
> >   error:
> >       if (fd > 0)
> >               close(fd);
> >
> > +     free(t_prepare);
> > +     free(prepare_ctx);
> >       free(label);
> >       exit(1);
> >   success:
