Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A284EE6B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 05:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbiDAD1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 23:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiDAD1m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 23:27:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC8222475B
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 20:25:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s8so1385063pfk.12
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 20:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4Jm1MaJPyKAjHjgj/afOkY+KuKybPrh/cZ4bMnfBDY=;
        b=Td2LWiZ3kKSVv3d23qXjrB+RIxpJeO6hfnhyJ1Hn6rxhabDJIRnbKlptcdtWAShYPB
         S6EXMwXhSt7PGVu9FVTPQykiQaYDkZxO97sAvMvg4W4GdD5WVtjGRPuC+eP6pafyn0oQ
         KWg2UNqJY9lWzTR/xTM9oLjepg0wkGiFCCTrWNaYj/Sss3BJGuQ4zj+ms/5etBYEltnV
         xRvLAiRfKNnWwmG39hga1Gb/O8UVRjsiVzTqHqNFbUp9ER55sciALVi16V//OmvPIKiV
         zVdqJfgSL7Ibfg9z2mhJ/Ji58gxueOxQwA1efxdRMQt4G1KYoboQrklRgjc8UYU13FB1
         LGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4Jm1MaJPyKAjHjgj/afOkY+KuKybPrh/cZ4bMnfBDY=;
        b=cx14EbCUpzXVOjT1VPCy0Bb0SlpxB1JWh+s9x6QQo8BdwE2arxu1do97LxfF+BXexS
         N0HyHzTv1YkztO1R85e/uArHU2KORjbFRt9PqEmc0TevYhQFWX/H19kglasRMuRyCHUK
         5XU2DRU4gvhJ9gw7lmJWqOKSgxZA/x2mextyDFFfqpk7nXfgSfoDOGyiIqK1vMHcabOk
         QIimAGvLSiZBairpy46jphpdPmjahsK+dHKtkAcmu2WyzMhdSZSJ8US4t9XKRXFDwxKU
         BVLxynT63+/axD6dUjm+xsQVDwa+27J4FfnYjWTjUfeG7DFPu7Ugfru06UhlOoRNjNYt
         UjVg==
X-Gm-Message-State: AOAM5308L/IisGX2OaVM5rijWEAOS8fpp3faBE57mhtBp0+nlkK5drkR
        mBYMdUHJp1vfoRpBHIYCqOedE+q194/N6btejBCdm9uAe1c=
X-Google-Smtp-Source: ABdhPJyaNShAjli8u1iPHBtBdIDaHORK9TXjSyBzs/tQ1FG3yHou2w2+kz79wHqfZoU7iBw8oDeQcXDx/fujFVRb37w=
X-Received: by 2002:a63:7f15:0:b0:398:5224:9b52 with SMTP id
 a21-20020a637f15000000b0039852249b52mr13288481pgd.249.1648783552320; Thu, 31
 Mar 2022 20:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
 <562b797f-49b6-80a0-4a1e-7dafa1975e86@gmx.com> <CAKxU2N9bzKpt94i53vzKgYKaDEGZ7tAj_nE-KFm-71qK3yXDjw@mail.gmail.com>
 <bfa7ae69-6a2b-af93-cfae-9b7c929d115b@suse.com> <CAKxU2N8JiE9n+qEM8LMKz60v46k0+P2whjzK49Z=jUooNdkDRQ@mail.gmail.com>
 <d70042e2-1f05-1052-d6a1-2d8b57b0300f@gmx.com> <CAKxU2N9Lg-Xnwc45Ej8-ewO1WQYEwTe2wwJvRNppDjkMq3xoOA@mail.gmail.com>
 <190b793d-4f31-2993-42d6-931ec8d0b039@gmx.com>
In-Reply-To: <190b793d-4f31-2993-42d6-931ec8d0b039@gmx.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Thu, 31 Mar 2022 20:25:45 -0700
Message-ID: <CAKxU2N_X12tZ49pGkoip7ALPc_tc5XZpB2HCria9ou2k-j5P-w@mail.gmail.com>
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

On Thu, Mar 31, 2022 at 8:18 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/4/1 11:05, Rosen Penev wrote:
> > On Thu, Mar 31, 2022 at 7:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2022/4/1 10:48, Rosen Penev wrote:
> >>> On Thu, Mar 31, 2022 at 5:59 PM Qu Wenruo <wqu@suse.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2022/4/1 08:24, Rosen Penev wrote:
> >>>>> On Thu, Mar 31, 2022 at 4:40 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2022/4/1 03:29, Rosen Penev wrote:
> >>>>>>> A specific folder has files in it. Directly accessing the path works
> >>>>>>> but ls in the directory returns empty.
> >>>>>>>
> >>>>>>> Any way to fix this issue? I believe it happened after a btrfs
> >>>>>>> replace(failed drive in RAID5) + btrfs balance.
> >>>>>>
> >>>>>> Btrfs check please.
> >>>>> btrfs check --force /dev/sda
> >>>>
> >>>> Force is not recommended unless it's your root fs and you don't really
> >>>> want to run btrfs check on an liveCD.
> >>> Same result without force and unmounted:
> >>>
> >>> btrfs check /dev/sda
> >>> Opening filesystem to check...
> >>> Checking filesystem on /dev/sda
> >>> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> [3/7] checking free space cache
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
> >>
> >> Only non-critical free space cache problem, and kernel can detect and
> >> rebuild them without problem.
> >>
> >>> [4/7] checking fs roots
> >>
> >> This is the most important part, and it turns no problem at all.
> >>
> >> So at least your fs is completely fine.
> >>
> >>
> >> It must be something else causing the problem.
> >>
> >> Mind to provide the subvolume id and the inode number (`stat` command
> >> can return the inode number) of the offending directory?
> >   stat .
> >    File: .
> >    Size: 0               Blocks: 0          IO Block: 4096   directory
> > Device: 44h/68d Inode: 259         Links: 1
> > Access: (0755/drwxr-xr-x)  Uid: ( 1000/  mangix)   Gid: ( 1000/  mangix)
> > Access: 2022-03-31 19:58:36.577915854 -0700
> > Modify: 2022-03-13 22:57:55.825138581 -0700
> > Change: 2022-03-13 22:57:55.825138581 -0700
> >   Birth: 2020-05-16 20:14:31.577476911 -0700
> >
> > btrfs subvolume list shows:
> > ID 259 gen 1084405 top level 5 path Torrents
> >>
> >> And some example command output when you can access the files inside the
> >> directory but `ls -alh` shows nothing?
> > shows . and .. . That's it.
>
> Mind to dump the the following contents?
> NOTE: this will include file names, feel free to censor filenames if needed:
>
> # btrfs ins dump-tree -t 259 <mnt> | grep "(259 " -A8
>
> This will dump all info related to inode 259 inside subvolume "Torrents".
Now it errors :)

btrfs ins dump-tree -t 259 /dev/sda | grep "(259 " -A8
file tree key (259 ROOT_ITEM 0)
node 3184169484288 level 2 items 37 free space 456 generation 1084405 owner 259
node 3184169484288 flags 0x1(WRITTEN) backref revision 1
fs uuid bfa267c0-df2c-45a6-ad88-9d76b3844326
chunk uuid 69378187-7a8d-42cc-a28d-a935000d8a94
        key (256 INODE_ITEM 0) block 3184169500672 gen 1084405
        key (1707 INODE_ITEM 0) block 3190334537728 gen 1081752
        key (3045 INODE_ITEM 0) block 3184776314880 gen 1082176
        key (7354 INODE_ITEM 0) block 3184775987200 gen 1082176
--
                location key (259 INODE_ITEM 0) type DIR
                transid 398 data_len 0 name_len 6
                name: B
        item 9 key (256 DIR_ITEM 2983476959) itemoff 15743 itemsize 35
                location key (257 INODE_ITEM 0) type DIR
                transid 398 data_len 0 name_len 5
                name: A
        item 10 key (256 DIR_ITEM 3061133479) itemoff 15682 itemsize 61
                location key (372987 INODE_ITEM 0) type FILE
--
                location key (259 INODE_ITEM 0) type DIR
                transid 398 data_len 0 name_len 6
                name: B
        item 19 key (256 DIR_INDEX 5) itemoff 15286 itemsize 36
                location key (260 INODE_ITEM 0) type DIR
                transid 398 data_len 0 name_len 6
                name: C
        item 20 key (256 DIR_INDEX 6) itemoff 15250 itemsize 36
                location key (261 INODE_ITEM 0) type DIR
--
        item 30 key (259 INODE_ITEM 0) itemoff 13737 itemsize 160
                generation 398 transid 1084405 size 0 nbytes 0
                block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
                sequence 176 flags 0x0(none)
                atime 1648781916.577915854 (2022-03-31 19:58:36)
                ctime 1647237475.825138581 (2022-03-13 22:57:55)
                mtime 1647237475.825138581 (2022-03-13 22:57:55)
                otime 1589685271.577476911 (2020-05-16 20:14:31)
        item 31 key (259 INODE_REF 256) itemoff 13721 itemsize 16
                index 4 namelen 6 name: B
        item 32 key (260 INODE_ITEM 0) itemoff 13561 itemsize 160
                generation 398 transid 1074067 size 56 nbytes 0
                block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
                sequence 405 flags 0x0(none)
                atime 1648367720.152037253 (2022-03-27 00:55:20)
                ctime 1646816503.726286540 (2022-03-09 01:01:43)
                mtime 1646816503.726286540 (2022-03-09 01:01:43)
parent transid verify failed on 3184315432960 wanted 1084439 found 1084442
parent transid verify failed on 3184315432960 wanted 1084439 found 1084442
parent transid verify failed on 3184315432960 wanted 1084439 found 1084442
parent transid verify failed on 3184315432960 wanted 1084439 found 1084442
Ignoring transid failure
parent transid verify failed on 3184315498496 wanted 1084439 found 1084442
parent transid verify failed on 3184315498496 wanted 1084439 found 1084442
parent transid verify failed on 3184315498496 wanted 1084439 found 1084442
parent transid verify failed on 3184315498496 wanted 1084439 found 1084442
Ignoring transid failure
parent transid verify failed on 3184317464576 wanted 1084439 found 1084443
parent transid verify failed on 3184317464576 wanted 1084439 found 1084443
parent transid verify failed on 3184317464576 wanted 1084439 found 1084443
parent transid verify failed on 3184317464576 wanted 1084439 found 1084443
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3184315416576 item=4 parent
level=1 child bytenr=3184317464576 child level=2

Note that name B is the problematic one. I can access A and C just
fine. Interestingly enough there are many more directories.

>
> If there is really nothing but the subvolume itself, it may be something
> else.
>
> Thanks,
> Qu
> >
> > The reason I know there are files here is because my torrent client is
> > currently seeding them. If I change the Catagory (which moves the
> > files elsewhere), the files show up in the given directory.
> >>
> >> Thanks,
> >> Qu
> >>
> >>> [5/7] checking only csums items (without verifying data)
> >>> [6/7] checking root refs
> >>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>> found 2689565679616 bytes used, no error found
> >>> total csum bytes: 2620609300
> >>> total tree bytes: 5374935040
> >>> total fs tree bytes: 1737539584
> >>> total extent tree bytes: 511115264
> >>> btree space waste bytes: 889131100
> >>> file data blocks allocated: 41913072627712
> >>>    referenced 2675025698816
> >>>
> >>>>
> >>>> As sometimes it can report false positive if the fs is not mounted
> >>>> read-only.
> >>>>
> >>>>> Opening filesystem to check...
> >>>>> Checking filesystem on /dev/sda
> >>>>> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
> >>>>> [1/7] checking root items
> >>>>> [2/7] checking extents
> >>>>> [3/7] checking free space cache
> >>>>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>>>> failed to load free space cache for block group 139616845824
> >>>>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>>>> failed to load free space cache for block group 146059296768
> >>>>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>>>> failed to load free space cache for block group 3183842689024
> >>>>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>>>> failed to load free space cache for block group 3184916430848
> >>>>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>>>> failed to load free space cache for block group 3185990172672
> >>>>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>>>> failed to load free space cache for block group 3187063914496
> >>>>> btrfs: space cache generation (1084391) does not match inode (1084389)
> >>>>> failed to load free space cache for block group 3190318694400
> >>>>> block group 4885757034496 has wrong amount of free space, free space
> >>>>> cache has 286720 block group has 290816
> >>>>> failed to load free space cache for block group 4885757034496
> >>>>> block group 4898641936384 has wrong amount of free space, free space
> >>>>> cache has 36864 block group has 53248
> >>>>> failed to load free space cache for block group 4898641936384
> >>>>> block group 4953402769408 has wrong amount of free space, free space
> >>>>> cache has 262144 block group has 274432
> >>>>> failed to load free space cache for block group 4953402769408
> >>>>> block group 5478462521344 has wrong amount of free space, free space
> >>>>> cache has 716800 block group has 729088
> >>>>> failed to load free space cache for block group 5478462521344
> >>>>> block group 5484904972288 has wrong amount of free space, free space
> >>>>> cache has 811008 block group has 819200
> >>>>> failed to load free space cache for block group 5484904972288
> >>>>> [4/7] checking fs roots
> >>>>>
> >>>>> It's currently stuck on that last one.
> >>>>
> >>>> If the fs is pretty large, it can take quite some time.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>>
> >>>>>>
> >>>>>> It looks like an DIR_ITEM/DIR_INDEX corruption.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Qu
> >>>>>
> >>>>
