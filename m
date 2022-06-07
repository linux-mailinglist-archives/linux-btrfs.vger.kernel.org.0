Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DCE54024B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 17:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbiFGPWM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiFGPWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 11:22:11 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B15523F
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 08:22:09 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p130so11486165iod.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wM3YMxXTvyeCxWyRbmkQ+YRCjHdZh1qWci8wsYhmpvg=;
        b=ZdLvKnWpWsA74xi3m3jDdTHx2hUiZHNg1/6EuX+AxMYP68rhZuP5bn50UVB4XMZh3L
         OQCiTAJI1w7bi8BOq3oGcKQGxbdRT73eGNwrWuYd2s6ptngoWiVqVbAkYkUrxSsug04a
         ENw1M0InTvXVyJcRvaSJTonTX+lY08LYqVNNCoC7kZcSjZ3e9TBN0UJ/ZXbc79uKnj1D
         E0VtRPjFurIAzIYSW1apx1IUR4CQJOpyXQNS4fJGW1yLzY6o1+crVEtZ8Ytnyi8ioS+J
         vQK+qoJMjwSCRCO9ZeKveGQB/gQayVkqX/Q2rhO0IXCw+Prd9ElzIDysKgDN06QWdErh
         BkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wM3YMxXTvyeCxWyRbmkQ+YRCjHdZh1qWci8wsYhmpvg=;
        b=ylURL578+jvj08fpssLK7nrQjUu5RDUaqRF5OE+uI7weJpe5yxhnRh0T818KqhaiI2
         qwTnE7RofNT6q9qj4hBRfRrD6txZqjt8cvg0dZecJmdjb4JKr7PXsJIZhv5zOE1RrWCx
         +c15pDZts9rWhgw/7sPieayn9496G135y9RaGjsyLwjpa60+VCZRZXUIuXhQPQeY/jX0
         81BZvUfoIVlj1tRW8HB4U4Nwt3/BcT6LrmFrtewin3HO0QuDFrElXz0jK1cLMiaukAvW
         kmc59myHHoFjoSlatrvAcbgtWQ7wIEKFGa+0s0A6T1IqfdNEKOOzYkXXokKokfvpoJOP
         u6vg==
X-Gm-Message-State: AOAM531GjgLBQNILeT1HeACdPT2XyQH+AA+aNDBHXYgRK1PoPDVCXtJl
        rXt8PvSgSiNDZlHcHrnT4ikpPMKIYEyiqBxp6OyJMFZs2Dw=
X-Google-Smtp-Source: ABdhPJy1zyLOOWlhg/Ho01AjTHSJV2LH6Zr6X9g5124Jiq8/gHHkykQqW4QDX0pWqnsAK7v7JfPBxIloMXNkyB6oOUY=
X-Received: by 2002:a05:6638:238b:b0:32e:e939:fee6 with SMTP id
 q11-20020a056638238b00b0032ee939fee6mr16796682jat.281.1654615328657; Tue, 07
 Jun 2022 08:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220606212301.GM22722@merlins.org> <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
 <20220606215013.GN22722@merlins.org> <CAEzrpqcn_BRL7p3gPmS5OVn5D-m8hMB-5JcAHwEHwKpxGxOMqw@mail.gmail.com>
 <20220606221755.GO22722@merlins.org> <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
 <20220607023740.GQ22722@merlins.org> <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
 <20220607032240.GS22722@merlins.org> <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
 <20220607151829.GQ1745079@merlins.org>
In-Reply-To: <20220607151829.GQ1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 11:21:57 -0400
Message-ID: <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
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

On Tue, Jun 7, 2022 at 11:18 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 10:51:35AM -0400, Josef Bacik wrote:
> > Hmm weird, I think I spotted it, give it a try again please.  Thanks,
>
> No more errors, and now init-extent-tree is deleting a lot of inodes again, let it continue?
>
> FS_INFO IS 0x555555651bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x555555651bc0
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
> Checking root 164629 bytenr 15645485137920
> Checking root 164631 bytenr 15645496983552
> Checking root 164633 bytenr 15645526884352
> Checking root 164823 bytenr 15645999005696
> Tree recovery finished, you can run check now
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
> FS_INFO IS 0x56090c17bbc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x56090c17bbc0
> Walking all our trees and pinning down the currently accessible blocks
> Clearing the extent root and re-init'ing the block groups
> deleting space cache for 11106814787584
> deleting space cache for 11108962271232
> deleting space cache for 11110036013056
> deleting space cache for 11111109754880
> (...)
> inserting block group 15932780969984
> inserting block group 15933854711808

Can you capture all of these lines and paste them?  We found a bunch
of old block groups but we may not have found everything.  I might
want to try manually going and looking for those chunks just so we can
avoid mass deleting things.  Thanks,

Josef
