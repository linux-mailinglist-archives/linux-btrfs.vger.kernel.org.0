Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206E74EE66D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 05:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiDADHP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 23:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244372AbiDADHN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 23:07:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E47194566
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 20:05:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id s11so1349280pfu.13
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 20:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEYI31PKlD9GKhiK/Y1OY3jCuVo76b1z6y/y6FIRv20=;
        b=XCHP7vFKLGO4MDJtunkikkikxQlywP5qqpbfaa4nljc3bFs6KKpMsi2LuUhYTcbGV8
         V+mbGf3byOZ8KpWg2YZT70s1jYQs+kHVXoIAVG5afSO82CJmFMIu1uJOmtfdXMSBEeP6
         odQXJ4Wb/uKiqHy1VmacomMA/10GObikFZXI99CKZN+nVw6v44y1boVdDF8l1sc5tnAz
         nJ6B0oqtb7KvQPsoHqQppAONuRD/uF922Z7TSmXclf99t8ePFF2R8k+gsP0W8/qThpce
         zcA23xu9Jwlr2syF5F6bUTYgN38V9uTxA2yVRsNN5gTq8lfp6Okt4iThsi4TboqmS9vR
         TtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEYI31PKlD9GKhiK/Y1OY3jCuVo76b1z6y/y6FIRv20=;
        b=xL6h2X/J1jtmvzlbl+/F1+fmls9c3i0Z0phZ97HSJIpZZDCdKuKDESZk3zNr/rfP4K
         vfncA2+lH00Sl0lNenCTm9VuuWvHxKYJtq+sGfW91Ale+YQhWrLiJdKJ0YH2v290+D12
         tAl1BdEzcYntwpxC62HDHqrOCVf6M8dXEcsymWeeSHc0tw0rtfCTfkt1zFHBL4k8XxEm
         rtR8TJ86uc+YKera+dyMOZraGmwN+PuawOVjDEOks3vhpxV39gnqpZ+74AQGfGk7YI8a
         MERtbdFsGir9jkww2v3ancTfQ2H7zVcY/TD4YfeGe4emhSfPdRS8eLG/RS0aUCOSECc0
         i8/w==
X-Gm-Message-State: AOAM5339S8KrLeauFdaTc05JkGcypJUpIm0zEZH8x9VOMFE85RKhE9UD
        ipzGOLm/U/sqrVd73j5EIXIuUc0XuydeEchtmozyEekrhPI=
X-Google-Smtp-Source: ABdhPJyygO/iZeRiCF8Am3GjRO6hM12Enn/8kc9Uo0GBA5ZEduNTBfEk/vR1tkdNnox8AlGXimQ89EOxlLZVkKaVr7k=
X-Received: by 2002:a63:680a:0:b0:383:dd15:fe68 with SMTP id
 d10-20020a63680a000000b00383dd15fe68mr13406808pgc.467.1648782324398; Thu, 31
 Mar 2022 20:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
 <562b797f-49b6-80a0-4a1e-7dafa1975e86@gmx.com> <CAKxU2N9bzKpt94i53vzKgYKaDEGZ7tAj_nE-KFm-71qK3yXDjw@mail.gmail.com>
 <bfa7ae69-6a2b-af93-cfae-9b7c929d115b@suse.com> <CAKxU2N8JiE9n+qEM8LMKz60v46k0+P2whjzK49Z=jUooNdkDRQ@mail.gmail.com>
 <d70042e2-1f05-1052-d6a1-2d8b57b0300f@gmx.com>
In-Reply-To: <d70042e2-1f05-1052-d6a1-2d8b57b0300f@gmx.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Thu, 31 Mar 2022 20:05:17 -0700
Message-ID: <CAKxU2N9Lg-Xnwc45Ej8-ewO1WQYEwTe2wwJvRNppDjkMq3xoOA@mail.gmail.com>
Subject: Re: btrfs volume can't see files in folder
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 31, 2022 at 7:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/4/1 10:48, Rosen Penev wrote:
> > On Thu, Mar 31, 2022 at 5:59 PM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >>
> >>
> >> On 2022/4/1 08:24, Rosen Penev wrote:
> >>> On Thu, Mar 31, 2022 at 4:40 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2022/4/1 03:29, Rosen Penev wrote:
> >>>>> A specific folder has files in it. Directly accessing the path works
> >>>>> but ls in the directory returns empty.
> >>>>>
> >>>>> Any way to fix this issue? I believe it happened after a btrfs
> >>>>> replace(failed drive in RAID5) + btrfs balance.
> >>>>
> >>>> Btrfs check please.
> >>> btrfs check --force /dev/sda
> >>
> >> Force is not recommended unless it's your root fs and you don't really
> >> want to run btrfs check on an liveCD.
> > Same result without force and unmounted:
> >
> > btrfs check /dev/sda
> > Opening filesystem to check...
> > Checking filesystem on /dev/sda
> > UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > block group 4885757034496 has wrong amount of free space, free space
> > cache has 286720 block group has 290816
> > failed to load free space cache for block group 4885757034496
> > block group 4898641936384 has wrong amount of free space, free space
> > cache has 36864 block group has 53248
> > failed to load free space cache for block group 4898641936384
> > block group 4953402769408 has wrong amount of free space, free space
> > cache has 262144 block group has 274432
> > failed to load free space cache for block group 4953402769408
> > block group 5478462521344 has wrong amount of free space, free space
> > cache has 716800 block group has 729088
> > failed to load free space cache for block group 5478462521344
> > block group 5484904972288 has wrong amount of free space, free space
> > cache has 811008 block group has 819200
> > failed to load free space cache for block group 5484904972288
>
> Only non-critical free space cache problem, and kernel can detect and
> rebuild them without problem.
>
> > [4/7] checking fs roots
>
> This is the most important part, and it turns no problem at all.
>
> So at least your fs is completely fine.
>
>
> It must be something else causing the problem.
>
> Mind to provide the subvolume id and the inode number (`stat` command
> can return the inode number) of the offending directory?
 stat .
  File: .
  Size: 0               Blocks: 0          IO Block: 4096   directory
Device: 44h/68d Inode: 259         Links: 1
Access: (0755/drwxr-xr-x)  Uid: ( 1000/  mangix)   Gid: ( 1000/  mangix)
Access: 2022-03-31 19:58:36.577915854 -0700
Modify: 2022-03-13 22:57:55.825138581 -0700
Change: 2022-03-13 22:57:55.825138581 -0700
 Birth: 2020-05-16 20:14:31.577476911 -0700

btrfs subvolume list shows:
ID 259 gen 1084405 top level 5 path Torrents
>
> And some example command output when you can access the files inside the
> directory but `ls -alh` shows nothing?
shows . and .. . That's it.

The reason I know there are files here is because my torrent client is
currently seeding them. If I change the Catagory (which moves the
files elsewhere), the files show up in the given directory.
>
> Thanks,
> Qu
>
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 2689565679616 bytes used, no error found
> > total csum bytes: 2620609300
> > total tree bytes: 5374935040
> > total fs tree bytes: 1737539584
> > total extent tree bytes: 511115264
> > btree space waste bytes: 889131100
> > file data blocks allocated: 41913072627712
> >   referenced 2675025698816
> >
> >>
> >> As sometimes it can report false positive if the fs is not mounted
> >> read-only.
> >>
> >>> Opening filesystem to check...
> >>> Checking filesystem on /dev/sda
> >>> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> [3/7] checking free space cache
> >>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>> failed to load free space cache for block group 139616845824
> >>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>> failed to load free space cache for block group 146059296768
> >>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>> failed to load free space cache for block group 3183842689024
> >>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>> failed to load free space cache for block group 3184916430848
> >>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>> failed to load free space cache for block group 3185990172672
> >>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>> failed to load free space cache for block group 3187063914496
> >>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>> failed to load free space cache for block group 3190318694400
> >>> block group 4885757034496 has wrong amount of free space, free space
> >>> cache has 286720 block group has 290816
> >>> failed to load free space cache for block group 4885757034496
> >>> block group 4898641936384 has wrong amount of free space, free space
> >>> cache has 36864 block group has 53248
> >>> failed to load free space cache for block group 4898641936384
> >>> block group 4953402769408 has wrong amount of free space, free space
> >>> cache has 262144 block group has 274432
> >>> failed to load free space cache for block group 4953402769408
> >>> block group 5478462521344 has wrong amount of free space, free space
> >>> cache has 716800 block group has 729088
> >>> failed to load free space cache for block group 5478462521344
> >>> block group 5484904972288 has wrong amount of free space, free space
> >>> cache has 811008 block group has 819200
> >>> failed to load free space cache for block group 5484904972288
> >>> [4/7] checking fs roots
> >>>
> >>> It's currently stuck on that last one.
> >>
> >> If the fs is pretty large, it can take quite some time.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>>>
> >>>> It looks like an DIR_ITEM/DIR_INDEX corruption.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>
> >>
