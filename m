Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B293513868
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349209AbiD1PeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349206AbiD1PeB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 11:34:01 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74DB19284
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 08:30:46 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id i20so5201657ion.0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZn/6LWhJsvrFmioZWpoK7hdfqkHwrmPKJZPsZlixow=;
        b=ATaCIKUswGeJlw37wt/YsJneZE7lu5m6u9JIc7kcj5vo+GMYLJerUWH+FmxIoKDTf9
         zYFcY+H5AImEbzpwwnpQF+Emqt+cB/o2jH/lqIKUQiSgjPn0BzutPjc8i27BGrmmR6Dz
         0xzAzTwllJCZspwoXKNRpUBXIbFMdBochiFPoLlnDvMMtECNGtNlWk+xZu2rKZKvVuHH
         yTABdlZOYDfeGO8CLxzkAfifn2o4d3IQIEwy5QJXct4zivFoErZ/zEQ2EztkchZZbTpN
         wxBsEYNV4v5/Af8i5+zhdbr/iuJpfC5CSZc/xZ4LDrL/l3sjytrH5NMxrLe9+4icjJna
         ye6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZn/6LWhJsvrFmioZWpoK7hdfqkHwrmPKJZPsZlixow=;
        b=CpjpLCrgJgCKMVZPb6vkcw0qv3XiJY4TIWUAM8U4KT32cDCs6qhd6yoiFiLcJBreMb
         WAWEPcebXhTDf8IdVXlhioSkLBJxf182pY+XZoYhKACx2laWCrFZcPR6UC7IpP0fBngW
         JrOq37AV7AZazDm0nQ2Tjz3mBZ94O7C+pSw0dycmAAjqsZw7BCnC7NmHa7hlRSEIgVW7
         xTFI0re2Be2WjGThxZGoj96HFF54B2WNxcJn9Np4tbtMuXNzGuMcxLVp07ZYiWHeDkPj
         RMFF1UL1yfbr6weKIjmrV/SCzqjmN1z6DTazfi+nF2bCl0F0D1IA/YPfLwQs/avQ9IhW
         qsIg==
X-Gm-Message-State: AOAM533l7vpuhtAStbizOQgfrH6P0gEEexo5aMCxvURykNp3uRNDDdzv
        RzP2rofJXP6Ok7wPifKexlXDpULjadscaw5svD6zaxt3WK4=
X-Google-Smtp-Source: ABdhPJwNBXs1OWbtX4hoKzBVeUI41f/lCsJIqeizquLtt9YWvattOeKa70qoBRC8KwRFvT8AdtFkXoFBRnfhKH90iCM=
X-Received: by 2002:a5d:9152:0:b0:652:e5c8:1c4c with SMTP id
 y18-20020a5d9152000000b00652e5c81c4cmr14391310ioq.10.1651159845965; Thu, 28
 Apr 2022 08:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org> <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
 <20220428001822.GZ12542@merlins.org> <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
 <20220428030002.GB12542@merlins.org> <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
 <20220428031131.GO29107@merlins.org> <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
 <20220428041245.GP29107@merlins.org>
In-Reply-To: <20220428041245.GP29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 28 Apr 2022 11:30:35 -0400
Message-ID: <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 12:12 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 28, 2022 at 12:03:29AM -0400, Josef Bacik wrote:
> > Cool, we're pointing at the same block in different places in the same
> > tree.  I should make tree-recover catch that and fix it, but since
> > you're going to re-generate your csum tree anyway I've adjusted
> > init-extent-tree to just clear the csum tree too, lets see how far we
> > get with this.  Thanks,
>
> inserting block group 15835070464000
> inserting block group 15836144205824
> inserting block group 15837217947648
> inserting block group 15838291689472
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1474560 of 0 possible bytes
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
> Recording extents for root 11223
> processed 1634992128 of 1635549184 possible bytesFailed to find [3700677820416, 168, 53248]
>

Hell yes we're in the fs tree's now, in the home stretch hopefully.
I've pushed new debugging, you may have another overlapping extent.
I'm going to have to wire up a tool for that, but hopefully we can
just target delete a few things and get you up and running.  Thanks,

Josef
