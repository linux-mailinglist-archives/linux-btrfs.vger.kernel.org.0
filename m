Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30095517C56
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 06:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiECERC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 00:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiECERA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 00:17:00 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DF38D89
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 21:13:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b5so9057993ile.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 21:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5ldldgNPVpBaBqcdCzh+Zf7GL/+6bRmIXo7pr7mnxg=;
        b=SiI4AsGevdTOv/pU72w1csbIgKEmZwqsHyc+tpwo8gUu05MtcyjD308f/PqsJ3uiQ3
         aZvtjxuJCLbxu9n0Y0OPgKuP2lv3WF/o5chaL6Cu+XxwC5+8dlMTFXRBObRk7eqTbM3T
         xXBjzKA2xA5duV2YRH4/pkzN/MI4g338fTsNeYWhbBLZcZUT7Rsmb/ShWMhJV/Wd8tzV
         L6UqduY+MfI0g3Q7MJWVMfGqyOalbzZWT33F77ENYigHnPBXia4G3SI9hKfIkYB8NsMS
         SDWhmWLkSrl2BSlPLIrAys0oezaBTxaFs1xSbEmh/Za6KNAvhhHfxYvNoPNYKC75HjUn
         bLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5ldldgNPVpBaBqcdCzh+Zf7GL/+6bRmIXo7pr7mnxg=;
        b=6DApcEm7bkBb42JObuluOL4rJGaFS856v+uIV7Jm22WyP2zwjKU7iuQ+zqfH9Gy+vQ
         p1z9VOOi0b26jlFY8CSczDu4tcDZgitev/0PwNyr7aGcRNJen5Qxw3Y2noRpu5uLDfL0
         0vicJVgbc3e6bGJcLWH8PQ+0L0Fu8nbeZehVR5bUAZ6tp85BSfbkn3s3XtkFrCq/PcUn
         mo5ZlUrlk/Urv2q6JJoZO3vgudpFKKDeVjEnHsLcmm1Eq8LUY1CmviKPmLQaWbhenu2y
         kGwOnDp3QBN/tp/n738Szyaja9rJ1wqSpHk5SNTBkZYPdo9pPP+uokj5mh0vEebAyPnr
         ddBQ==
X-Gm-Message-State: AOAM533EBZr1XKlB1T9ETCyJ7CvkY2fhsob+2swKnu/ihFqqVgEL1Q4T
        hVyaZUnUuvRTm3lTb5jY7Co6x8/f0+z9TMidQ8vmagYsHBw=
X-Google-Smtp-Source: ABdhPJz8cd2qMDaRs9vveZxpQpsUm2eoQk1Y2ttsYZqx4yNyXklqEULbp2pzCCd2xaSNXUalMpsyGB6NCW7Ph7uJdow=
X-Received: by 2002:a05:6e02:194d:b0:2cd:93bf:9569 with SMTP id
 x13-20020a056e02194d00b002cd93bf9569mr6193037ilu.152.1651551207270; Mon, 02
 May 2022 21:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220502173459.GP12542@merlins.org> <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
 <20220502200848.GR12542@merlins.org> <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
 <20220502214916.GB29107@merlins.org> <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org> <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org> <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
 <20220503040250.GW12542@merlins.org>
In-Reply-To: <20220503040250.GW12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 3 May 2022 00:13:16 -0400
Message-ID: <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
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

On Tue, May 3, 2022 at 12:02 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 02, 2022 at 10:38:03PM -0400, Josef Bacik wrote:
> > Ugh IDK why that happens every once and a while.  I pushed a fix for
> > btrfs-corrupt-block, it should work now.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819133,108,0" -r 11223 /dev/mapper/dshelf1
> FS_INFO IS 0x562d920a7600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x562d920a7600
> parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
> parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
> parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
> FS_INFO IS 0x5649e173dbc0
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x5649e173dbc0
> Walking all our trees and pinning down the currently accessible blocks
> (..,)
>
> doing roots
> Recording extents for root 4
> processed 1032192 of 1064960 possible bytes
> Recording extents for root 5
> processed 10960896 of 10977280 possible bytes
> Recording extents for root 7
> processed 16384 of 16545742848 possible bytes
> Recording extents for root 9
> processed 16384 of 16384 possible bytes
> Recording extents for root 11221
> processed 16384 of 255983616 possible bytes
> Recording extents for root 11222
> processed 49479680 of 49479680 possible bytes
> Ignoring transid failure
> Recording extents for root 11223
> processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819133,108,134217728 on root 11223
> inode ref info failed???
> elem_cnt 1 elem_missed 0 ret 0
> Xilinx_Unified_2020.1_0602_1208/payload/rdi_0410_2020.1_0602_1208.xz
> cmds/rescue-init-extent-tree.c:654: process_eb: BUG_ON `1` triggered, value 1
>
> Ignoring transid failure
> Recording extents for root 11223
> processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819135,108,0 on root 11223
> inode ref info failed???
> elem_cnt 1 elem_missed 0 ret 0
> Xilinx_Unified_2020.1_0602_1208/payload/ise_0007_2020.1_0602_1208.xz
> cmds/rescue-init-extent-tree.c:654: process_eb: BUG_ON `1` triggered, value 1
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819135,108,0" -r 11223 /dev/mapper/dshelf1
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819137,108,0" -r 11223 /dev/mapper/dshelf1
>
> Ok, now we're down to another one:

Ok I fixed the debugging to not be so noisy so I can see what's going
on, lets give that a try,

Josef
