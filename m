Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB95426F5
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349959AbiFHA2c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 20:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588652AbiFGXyx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 19:54:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590A17C6A9
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 16:33:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a15so15366797ilq.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aar/so+I2kLtl1zwQROcP9/GPIwmQgwuvw2NMQQ/ZWo=;
        b=7a1DYsGWkfEZEdPjGXxEizZ9dKYXZQQUSFqgx845FUYAi7RwxeYM2xiRYI9qXa6VxJ
         cU2fej5ARAUrwNBPbq50HKnePNcp66nCqcqISztyhfXM5N1Xw9kevYFYM4MDD09fXWNb
         YiUhhIe4MHqaGHssEj055NxI2bfNetJzS5ocEmBpWzzGHQKzH9pzH1bpPHwJjOVdVL/M
         8pAXK7THnciZH0vx3WPPKZcXler29A7oatKZp+TFwXpFzFgSXomWFVNHRDdsYibq2Lmo
         cO9+tD+eOu5yY8eQXbz1+xsPSUPCDZURCtiCNVeVlP4YlAFnKNRMEiKnkTK8iyc4rZKk
         qHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aar/so+I2kLtl1zwQROcP9/GPIwmQgwuvw2NMQQ/ZWo=;
        b=DLvo1y7rkGnTPIqVdDVoIUO39l16mzTLv67zNnGNPJmOdnHUxAM6Ot6yQxZcwc0hH3
         puJjxD1JNoNhlYFJFUP6dNOE8rCOT4K1kfiMx2dycpWa8DDVoFie3r/4+yzoorbcduAX
         v87z3Jfj3GXvOOFzCMA3Hvv4Z4cfqYgMp944ZWItLO1ylGDl0XLsKRUjq/WNKo2A/yWw
         y2coT27I+M4kYPqZ2pulVI6B0HxXSRl8sx9DWSawMAkMz0uGbfz7kRXL65pKtNmaz+ou
         EUi5geNarwKSn2LYV4NdoTj9G1f9mdkf2YQFA8SXmAB7/i4ZtcrCa/zLTgUeZuAvvQTy
         +0/g==
X-Gm-Message-State: AOAM530WxXiV1catOjeM8m+ImdZVNL00x1Xavg9YxwjB3sFib4fIqb5t
        YYGGI4g+bNOVST71b9GGiausTeO2u+0CQRImR/LTrtn7MqY=
X-Google-Smtp-Source: ABdhPJxwkuOU53BR64ipP9IlEbSvtg7k36E/tTgO8RUIeiaDNvBvYbQ4iHrQCN+DSznVVWGpV8sccl+XUPEP7AQNcuU=
X-Received: by 2002:a92:ca49:0:b0:2d3:9e94:1af8 with SMTP id
 q9-20020a92ca49000000b002d39e941af8mr18263371ilo.127.1654644791690; Tue, 07
 Jun 2022 16:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220607151829.GQ1745079@merlins.org> <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
 <20220607153257.GR1745079@merlins.org> <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
 <20220607182737.GU1745079@merlins.org> <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
 <20220607195744.GV22722@merlins.org> <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
 <20220607204406.GX22722@merlins.org> <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
 <20220607212523.GZ22722@merlins.org>
In-Reply-To: <20220607212523.GZ22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 19:33:00 -0400
Message-ID: <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
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

On Tue, Jun 7, 2022 at 5:25 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 04:58:57PM -0400, Josef Bacik wrote:
> > Ok I think I fixed that, but I also updated the loop to bulk delete as
> > many bad items in a leaf at a time, hopefully this will make it go
> > much faster.  Expect more fireworks with the new code.  Thanks,
>
> Found an extent we don't have a block group for in the file 10741731311616
> ref to path failed
> Couldn't find any paths for this inode
> Deleting [73101, 108, 0] root 15645020241920 path top 15645020241920 top slot 49 leaf 15645020766208 slot 26 nr 73
>
> searching 164629 for bad extents
> processed 802816 of 108838912 possible bytes, 0%
> Found an extent we don't have a block group for in the file 10741731311616
>
> Found an extent we don't have a block group for in the file 743378268160
>
> Found an extent we don't have a block group for in the file 946736541696
> ref to path failed
> Couldn't find any paths for this inode
> Deleting [73101, 108, 427687936] root 15645019537408 path top 15645019537408 top slot 49 leaf 15645020766208 slot 26 nr 148
>
> searching 164629 for bad extents
> processed 802816 of 108838912 possible bytes, 0%
> Found an extent we don't have a block group for in the file 946736541696
> ref to path failed
> Couldn't find any paths for this inode
> Deleting [73101, 108, 1747189760] root 15645020241920 path top 15645020241920 top slot 49 leaf 15645020782592 slot 26 nr 1
>
> searching 164629 for bad extents
> processed 835584 of 108838912 possible bytes, 0%
> corrupt leaf: root=164629 root bytenr 15645020241920 commit bytenr 0 block=15645020438528 physical=15054974140416 slot=0 level 0, invalid level for node, have 0 expect [1, 7]
> kernel-shared/ctree.c:148: btrfs_release_path: BUG_ON `ret` triggered, value -5

Ugh come on, this must get triggered because we clean up some stuff
and then the corrupt blocks are suddenly right next to eachother.  Can
you re-run tree-recover and see if it deletes those keys?  Thanks,

Josef
