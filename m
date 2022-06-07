Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452CC5401CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 16:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiFGOvs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiFGOvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 10:51:48 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855CF504A
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 07:51:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z197so11547265iof.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xh3WR7nuRufnHQ6qZsT6qM30J6keAyecrcg5LWFv2Yk=;
        b=h8CrBK+6gRCvBeKfcj7XdX9HtGzdBND2QWAVSbZcWIBBNZ5n8YLpHgIM+tokEW5hsQ
         efbo10OD58QXdwamhk7VOwuhhoRNLyzqbR2o4FYAUU88qED/mjn5wkxvJoJHSjElWTYk
         1mxZuOPB85gXdo5u5UipBZ7YIgjT15Bpua2zYruaPPl6HJLYnHx6f1F5XFtPU9VaRRI5
         2K8GtlqAb/pJxYU71Eq/VxGfTl6ZjeIcdYGVoK8SDWSEqWdxPiDnJyS0OYq1HfTcEh0u
         BV5ZOCAPHmBmRJ21uur2WWS3JMTFozqIxWAmvL8nP+rGhlyiaLkKkcSdedLLGJ/SWpra
         boxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xh3WR7nuRufnHQ6qZsT6qM30J6keAyecrcg5LWFv2Yk=;
        b=fFt2GFCPGCGGP04J4CMsT1XDn0NHPmbMksL0PNTea5K1WZyd3gNKAmxJ5Q6Anebs0O
         uSw8N8QXZvd+axExu2Cv4PLp66nIt8EUSaN3owIAAokm0NBB+ymb2QNX9PiQ6uirqNyC
         FqsLmH2wg59jDuIVam8xV/shsHBg87HUHmN+Zn5sHB63QexHGm2jefCx8EWwFo/RV0QQ
         +B8PbFSTAofN+Ct+WmUeVacVZ27cAcNYn4s/hjQeEQIAA+9ArrO2w7yDYNMP2xE//yO+
         2Tu1swkvS/Fa9Gdtzf2IUBusnv2KRZbY2Rn+3Byn9KHdEhFKvhKvT9m00SpUsCAwYFVh
         Y5Dg==
X-Gm-Message-State: AOAM532pJfKM/fAmdbUs8Y4Yc9HT6aIK94nlftPPhsPaONiSxCYbOe/7
        +q/Trw7lcp5U3+v5YPhh5H412X+3T5e8T6+MxkyfoJj00Ag=
X-Google-Smtp-Source: ABdhPJynLsmKXXTLwtIVwD4xQHLjB20yHjgKtEmH3lag4Hk5U1hh1Zv0jdslTOV9lrLzPoKN+JD2bxZCGwWu/1AES5s=
X-Received: by 2002:a05:6638:22cf:b0:331:a5b9:22f2 with SMTP id
 j15-20020a05663822cf00b00331a5b922f2mr6775860jat.218.1654613506519; Tue, 07
 Jun 2022 07:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220606210855.GL22722@merlins.org> <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
 <20220606212301.GM22722@merlins.org> <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
 <20220606215013.GN22722@merlins.org> <CAEzrpqcn_BRL7p3gPmS5OVn5D-m8hMB-5JcAHwEHwKpxGxOMqw@mail.gmail.com>
 <20220606221755.GO22722@merlins.org> <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
 <20220607023740.GQ22722@merlins.org> <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
 <20220607032240.GS22722@merlins.org>
In-Reply-To: <20220607032240.GS22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 10:51:35 -0400
Message-ID: <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
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

On Mon, Jun 6, 2022 at 11:22 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Jun 06, 2022 at 10:57:17PM -0400, Josef Bacik wrote:
> > Ah my bad, added all the repair code but not the code to notice it was
> > broken, try again please.  Thanks,
>
> FS_INFO IS 0x5641505c3bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x5641505c3bc0
> Checking root 2 bytenr 15645019553792
> Checking root 4 bytenr 15645019078656
> Checking root 5 bytenr 15645018161152
> Checking root 7 bytenr 15645019521024
> Checking root 9 bytenr 15645740367872
> Checking root 161197 bytenr 15645018341376
> Checking root 161199 bytenr 15645018652672
> Checking root 161200 bytenr 15645018750976
> Checking root 161889 bytenr 11160502124544
> Checking root 162628 bytenr 15645018931200
> Checking root 162632 bytenr 15645018210304
> Checking root 163298 bytenr 15645019045888
> Checking root 163302 bytenr 15645018685440
> Checking root 163303 bytenr 15645019095040
> Checking root 163316 bytenr 15645018996736
> Checking root 163920 bytenr 15645019144192
> Checking root 164620 bytenr 15645019275264
> Checking root 164623 bytenr 15645019226112
> Checking root 164624 bytenr 15645019602944
> scanning, best has 0 found 0 bad
> checking block 15645019602944 generation 2588164 fs info generation 2588170
> trying bytenr 15645019602944 got 145 blocks 1 bad
> checking block 15645502210048 generation 1601068 fs info generation 2588170
> trying bytenr 15645502210048 got 146 blocks 1 bad
> checking block 15645022208000 generation 1739020 fs info generation 2588170
> scan for best root 164624 wants to use 15645502210048 as the root bytenr
> Repairing root 164624 bad_blocks 1 update 1
> Segmentation fault
>
>
> again, under gdb
> scanning, best has 0 found 0 bad
> checking block 15645019602944 generation 2588164 fs info generation 2588170
> trying bytenr 15645019602944 got 145 blocks 1 bad
> checking block 15645502210048 generation 1601068 fs info generation 2588170
> trying bytenr 15645502210048 got 122 blocks 0 bad
> checking block 15645022208000 generation 1739020 fs info generation 2588170
> scan for best root 164624 wants to use 15645019602944 as the root bytenr
> Repairing root 164624 bad_blocks 1 update 1
> we're pointing at an empty node, delete slot 1 in block 15645019602944
>
> Program received signal SIGSEGV, Segmentation fault.
> repair_tree (fs_info=fs_info@entry=0x555555651bc0, root_info=root_info@entry=0x7fffffffdc20, eb=eb@entry=0x55555574bfb0)
>     at ./kernel-shared/ctree.h:2136
> 2136    BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,

Hmm weird, I think I spotted it, give it a try again please.  Thanks,

Josef
