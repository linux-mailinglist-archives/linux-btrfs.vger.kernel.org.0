Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A436549E38
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbiFMT7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 15:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350193AbiFMT6a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 15:58:30 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2241EA888C
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 11:29:42 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b138so162089iof.13
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVOZDdFgEOHcEvkVtOUhis/1IMWLqvn1MQI0jOuXQr0=;
        b=BGy+hzh4aJu9ueWV3FHTUffic0lppZ2Vnf8/UMk1DjIfmjb5Q62KKKYBMAo5oUk1pQ
         bpHIPhSaKqbZhnllciZYVqKTYgIHYcjnsXsDnODUfJPBsk2hAbpbmkPgSFF33/6NaXpP
         L04dxTKqpdRYIE8EdY9f3mrHg/EN1WaIgD0dvK+FSvXe88tv1DtGAoCI6YG8xyMlyWjc
         mDEjRaVA0Q48UE8bhHH0qMWwq99PKWKTnNqxL8Q/EnmoNW3+/9gU/TXZ8eXYsmN04QMD
         069SWtkpEbo/YB/xIQPmdE1HvtyS4e0TWO17fRTGKkcx/gib4VUBvEGvFVhQdRevfvXo
         gCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVOZDdFgEOHcEvkVtOUhis/1IMWLqvn1MQI0jOuXQr0=;
        b=wj8OUMrnCCqv3jakSh4kS+ktdT2JaasIVSHwnqWbXuxasCdUc36IOe4hxGIkMs7j1M
         Ih7FKDWtyW4RuWRSEbRzhksAoRDDD7Fl0t4m4Gbnf3Iz7TBUOhXejbajd4sn2tF/dBqi
         4MMoBlg1vmOyRMExF6L/JGw2hHIbjJiawZ3mAJdyG/wk7bF/0ZbJHQ1KoshxaJijiyNx
         1f3rVgZtmgbGjgay7xOiUekawR8xRIJgeQkktt+4BzvYShYDE5APox3mkTH4WG1NVwPh
         o/bLTV+4gRCuLkWmQAofG683zFMVzX0nXbaSwREtfWi1mw65DHytsGoD3Jny+FENtqrI
         G1yg==
X-Gm-Message-State: AOAM530VmJZvnANGyGmp7Bg7geS9vOYES0hTss8yWMFIBiZu+zJ7tfsN
        TcUC9OpaIlbAVzO9e8OFy/HQj0YRVPbZfIta21jIRoxLd2I=
X-Google-Smtp-Source: ABdhPJwIRwSiGgOgbpPX44S2IDffP52qpeDBVtMvILfzZd78DEvQtD5+32KDIRyCsHg8ylFj7h2kE0Bu4gaQ2MFLvE4=
X-Received: by 2002:a05:6602:2a45:b0:669:17b2:b71c with SMTP id
 k5-20020a0566022a4500b0066917b2b71cmr585727iov.10.1655144981313; Mon, 13 Jun
 2022 11:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220608213030.GG22722@merlins.org> <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org> <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org>
In-Reply-To: <20220613175651.GM1664812@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 13 Jun 2022 14:29:30 -0400
Message-ID: <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 1:56 PM Marc MERLIN <marc@merlins.org> wrote:
>
>  #####                                                    ###
> #     #  #    #   ####    ####   ######   ####    ####    ###
> #        #    #  #    #  #    #  #       #       #        ###
>  #####   #    #  #       #       #####    ####    ####     #
>       #  #    #  #       #       #            #       #
> #     #  #    #  #    #  #    #  #       #    #  #    #   ###
>  #####    ####    ####    ####   ######   ####    ####    ###
>
> On Fri, Jun 10, 2022 at 03:55:09PM -0400, Josef Bacik wrote:
> > btrfs rescue recover-chunks <device>
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> FS_INFO IS 0x56528f943bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x56528f943bc0
> Walking all our trees and pinning down the currently accessible blocks
> No missing chunks, we're all done
> doing close???
> Recover chunks succeeded, you can run check now
>
> > btrfs rescue init-extent-tree <device>
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
> FS_INFO IS 0x55fd039e2bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55fd039e2bc0
> Walking all our trees and pinning down the currently accessible blocks
> Clearing the extent root and re-init'ing the block groups
> deleting space cache for 20971520
> deleting space cache for 11106814787584
> deleting space cache for 11108962271232
> deleting space cache for 11110036013056
> deleting space cache for 11111109754880
> (...)
> doing roots
> (...)
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 164633
> processed 16384 of 75694080 possible bytes, 0%
> Recording extents for root 164823
> processed 507904 of 63504384 possible bytes, 0%
> Recording extents for root 18446744073709551607
> processed 16384 of 16384 possible bytes, 100%
> doing block accounting
> doing close???
> Init extent tree finished, you can run check now
>
> > btrfs check --repair <device>
>
> FS_INFO AFTER IS 0x5641f2a63bd0
> [1/7] checking root items
> checksum verify failed on 15645959372800 wanted 0x847c08bf found 0x17a9e2f1
> checksum verify failed on 15645959389184 wanted 0x3cc757a7 found 0x3b4eff03
> checksum verify failed on 15645681451008 wanted 0x7516a3d9 found 0x97f7437d
> checksum verify failed on 15646003970048 wanted 0xf18cc579 found 0x1bc64584
> checksum verify failed on 15645867720704 wanted 0x14cc427a found 0x9f516106
> checksum verify failed on 15645529604096 wanted 0xd11e24d5 found 0x8d01bc00
> checksum verify failed on 15645781344256 wanted 0xb81e3df4 found 0xb5c70846
> checksum verify failed on 15645959356416 wanted 0x2fa8537e found 0x90ac1f4e
> checksum verify failed on 15645692067840 wanted 0x7874ded3 found 0x1e94afcd
> checksum verify failed on 15645529620480 wanted 0x9ba9c3df found 0x1813c193
> checksum verify failed on 15645608165376 wanted 0x2af09d83 found 0xdc3aa13d
> checksum verify failed on 15645815291904 wanted 0x27e465d0 found 0x3e898f04
> checksum verify failed on 15645419667456 wanted 0xde0dab28 found 0x3ceddd16
> checksum verify failed on 15645815357440 wanted 0xeff7f183 found 0x21b9d056
> checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
> Fixed 0 roots.
> [2/7] checking extents
> Chunk[256, 228, 20971520] stripe[1, 20971520] is not found in dev extent
> Chunk[256, 228, 20971520] stripe[1, 29360128] is not found in dev extent
> [3/7] checking free space cache
> (...)
> root 164629 inode 73099 errors 1000, some csum missing
> root 164629 inode 73100 errors 1000, some csum missing
>         unresolved ref dir 791 index 0 namelen 25 name file filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 3676 index 0 namelen 62 name file2 filetype 1 errors 6, no dir index, no inode ref
> ERROR: errors found in fs roots
>
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/dshelf1
> UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
> No device size related problem found
> cache and super generation don't match, space cache will be invalidated
> found 21916200960 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 8765440
> total fs tree bytes: 6799360
> total extent tree bytes: 573440
> btree space waste bytes: 2514656
> file data blocks allocated:
>
>
> gargamel:~# mount /dev/mapper/dshelf1 /mnt/mnt
> gargamel:~#
> [4289823.922324] BTRFS info (device dm-1): trying to use backup root at mount time
> [4289823.922326] BTRFS info (device dm-1): disk space caching is enabled
> [4289823.922327] BTRFS info (device dm-1): has skinny extents
> [4289824.188614] BTRFS info (device dm-1): enabling ssd optimizations
> [4289847.574926] BTRFS info (device dm-1): flagging fs with big metadata feature
> [4289847.598104] BTRFS info (device dm-1): disk space caching is enabled
> [4289847.651582] BTRFS info (device dm-1): has skinny extents
> [4289847.699541] BTRFS info (device dm-1): enabling ssd optimizations
> [4289847.730931] BTRFS info (device dm-1): checking UUID tree
> [4289847.798826] BTRFS error (device dm-1): bad tree block level 19 on 15645959372800
> [4289847.912586] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959372800 (dev /dev/mapper/dshelf1 sector 29403983072)
> [4289847.956640] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959376896 (dev /dev/mapper/dshelf1 sector 29403983080)
> [4289848.000894] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959380992 (dev /dev/mapper/dshelf1 sector 29403983088)
> [4289848.045141] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959385088 (dev /dev/mapper/dshelf1 sector 29403983096)
> [4289848.083771] BTRFS error (device dm-1): bad tree block level 39 on 15645959389184
> [4289848.111468] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959389184 (dev /dev/mapper/dshelf1 sector 29403983104)
> [4289848.155838] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959393280 (dev /dev/mapper/dshelf1 sector 29403983112)
> [4289848.199940] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959397376 (dev /dev/mapper/dshelf1 sector 29403983120)
> [4289848.244198] BTRFS info (device dm-1): read error corrected: ino 0 off 15645959401472 (dev /dev/mapper/dshelf1 sector 29403983128)
> [4289848.281912] BTRFS error (device dm-1): bad tree block level 85 on 15645681451008
> [4289848.358339] BTRFS info (device dm-1): read error corrected: ino 0 off 15645681451008 (dev /dev/mapper/dshelf1 sector 29403440256)
> [4289848.396605] BTRFS info (device dm-1): read error corrected: ino 0 off 15645681455104 (dev /dev/mapper/dshelf1 sector 29403440264)
> [4289848.436740] BTRFS error (device dm-1): bad tree block level 22 on 15646003970048
> [4289848.493665] BTRFS error (device dm-1): bad tree block level 127 on 15645867720704
> [4289848.549485] BTRFS error (device dm-1): bad tree block level 165 on 15645529604096
> [4289848.640033] BTRFS error (device dm-1): bad tree block level 32 on 15645781344256
> [4289848.713594] BTRFS error (device dm-1): bad tree block level 16 on 15645959356416
> [4289848.786591] BTRFS warning (device dm-1): checksum verify failed on 15645692067840 wanted 0x7874ded3 found 0x1e94afcd level 7
> [4289848.837010] BTRFS error (device dm-1): bad tree block level 62 on 15645529620480
> [4289848.905220] BTRFS error (device dm-1): bad tree block level 151 on 15645608165376
> [4289848.941769] BTRFS error (device dm-1): bad tree block level 24 on 15645815291904
> [4289848.991611] BTRFS error (device dm-1): bad tree block level 34 on 15645419667456
> [4289849.061467] BTRFS error (device dm-1): bad tree block level 26 on 15645815357440
> [4289849.109509] BTRFS error (device dm-1): bad tree block level 18 on 15645781196800
>
> There is still some damage that maybe check/repair should fix, but it's
> mountable, that's definitely a huge success!
>
> Thanks Josef, that was a lot of work and determination :)
>
> Let me know if there is more you'd like to look at, and/or try and get
> the FS to a state where it's actually clean, but honestly as long as it
> mounts, that's already a lot, obviously.
>

Alright so we have the missing csum things, which can be fixed with

btrfs rescue init-csum-tree <device>

now that everything is back the way it's supposed to be.

After that you can mount the fs and run a scrub, because you have
copies of metadata that are fucked, but copies that were ok, which is
why I disabled the block error warnings since they were confusing me.
Scrub should go along and fix all of that up.

The next thing is to fix the fs errors, which I imagine will cause
other problems like not being able to find directories and files and
such.  Once we've gotten the csum tree and the scrub done we can
tackle the remaining fs error problems which should be less terrifying
to mess with.  Thanks,

Josef
