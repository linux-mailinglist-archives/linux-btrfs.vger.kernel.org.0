Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D650F513C79
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 22:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiD1URA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbiD1UQ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 16:16:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCEAC0D05
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:13:43 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r27so2776160iot.1
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FE05hV1LM47AzcJWn+O+kMtdIz6VyWAmO9uX1XNDDo=;
        b=OIaj6FsmGzdHiOpLAQTG7/GBFgXNZKx36DF/kfV6Xa9Ok0aBxwBY8R2Yig1KE3qbpn
         0eQq4Io5duobH6KnpiYAcQyPaKbNMPqaLZR0YHzlCzr2+8z4mai2Vy9q+xbPzs6R/YPz
         F7QjTMJx2nYMoffN4ihg15ldpprJlxRSkoaWkrlmMXlnPt4tgIezxemCr+259Vs8NA1z
         GiLXmn+KMokZ9AY9Rx8M2UqiEIItKkoEVy1HOoy2vjtMy1MI8qQbPZzT/Pp6uAgpdoPk
         d++KB8GXP+LnbYR8Rvvw2bl/ozPwPTqBq1QlP1P/4nHbbY6N0z/hfwbZKVlRy94+hoEX
         FE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FE05hV1LM47AzcJWn+O+kMtdIz6VyWAmO9uX1XNDDo=;
        b=cawqn/sG/8E21UflKLgrEpQvYH+9AFtxsj6meLPssgMK030dUHWmq1a3T0VktUA2HW
         3rZR6lq8ifr3L73rBJpKR5NECxdgfLaRoIKFtCCva4qJ4uJ19fAqvoqthQg9qFEvfyCH
         1L+vFI3dWTlI0R4jAQxMv3Rz0kFxI6vwMZKce8qm0nXSfkHLpcKYDel++z7X5uMT+2W0
         wXg2ZRBNPUi3O/TuZyeDmSDZVdd3HpfmZBeo8c9xbwlbpkjsjDiUNKOY2K1ENInNQTvW
         VTZmyxxE8t9dtj7bAf2u4zuZvnz4bIXF68NtW1Wr4gVSyEcFKn1KsGpLH6tROxR7rKwC
         rQ8A==
X-Gm-Message-State: AOAM5307qpoHc3X+2TE1dUPx5iGG7QGRVT0Ufv63yO9+AvH8+YDs73lz
        I8TA8I+dNapUG5MpLxVNpEWOgb8e7R91khxQ611oWjOTJbUU4Q==
X-Google-Smtp-Source: ABdhPJxmQ5wwuAs1zSD+J3o5eOpcg0SAfzGESmoeFk6sdaXvHuCLL7m22a0VdZxjbS7P6ZWppkh0XZyjLBzr/El/6Mg=
X-Received: by 2002:a6b:590d:0:b0:657:b658:b00b with SMTP id
 n13-20020a6b590d000000b00657b658b00bmr3871346iob.166.1651176822554; Thu, 28
 Apr 2022 13:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
 <20220428001822.GZ12542@merlins.org> <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
 <20220428030002.GB12542@merlins.org> <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
 <20220428031131.GO29107@merlins.org> <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
 <20220428041245.GP29107@merlins.org> <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
 <20220428162746.GR29107@merlins.org>
In-Reply-To: <20220428162746.GR29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 28 Apr 2022 16:13:31 -0400
Message-ID: <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 12:27 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 28, 2022 at 11:30:35AM -0400, Josef Bacik wrote:
> > Hell yes we're in the fs tree's now, in the home stretch hopefully.
> > I've pushed new debugging, you may have another overlapping extent.
> > I'm going to have to wire up a tool for that, but hopefully we can
> > just target delete a few things and get you up and running.  Thanks,
>
> Delete Xilinx_Unified_2020.1_0602_1208/tps/lnx64/jre9.0.4/lib/modules ?

Cool, do

./btrfs-corrupt-block -d "3700677820416,168,53248" -r 11223 <device>

Then you should be able to run the init-extent-tree and get past that
part.  Thanks,

Josef
