Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C7B53F430
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 04:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiFGC5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 22:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiFGC5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 22:57:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1EF140A6
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 19:57:29 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s26so4284948ioa.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jun 2022 19:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJ371VUg0RW0O41QQx2j1Pbb5NtBCtF5B1peZ4H2vq0=;
        b=OficLyWwU+grMuMYkXFROF3UGX3zEr8MW989KiZ6gpDaBgfOag99aUTqGICVyNrCe3
         ZOFsCY6TtKhZEsliowQrfXnSHREr8kN0f9b8Y7ZfNEK+XkNdvu98gWqljuUQVqMBk+qs
         UBNru5NHHsaEdH93WCBXZTJ/akNWUyqsl26UBUvmuzzBZqmj+z9boerSJV82p/NPkVBi
         GoLFP99CoMbulVNN7rdA3/uEmxLNPbwGYlMpjjuAvGPXVbNYCytvNXapPLBcOKHyMTZe
         OOskRGUxGPv3pPtHtknYSuR6RwfKTXnjKy4dtDA+gSMioqgdIeo5+EnEkeEnoGdZMt6C
         Cr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJ371VUg0RW0O41QQx2j1Pbb5NtBCtF5B1peZ4H2vq0=;
        b=t1798tf/QQpoP6R2bbMjW55MXVCCVGJfWGS/TW4j9wRiT1vtXoZDOzivnH0Z7s4nUr
         DDqwZAIPAca8a5i5dYxJcsz3ZBa9QBc2Oetqsx+fU+t4h7IeUY0hRGi7i3kM0tTL2bIz
         wr37g4oqfviDGRo9fpDNatUXwFvUa/ecwdV56bEidCdPMPYROs500yYbvowdKmFnNF+V
         c31qTVwDB3lscRwTVccu81CnyrsZuaWhIWtWc0/YlPQaR2g8VcHfGVPEdxyl8A7OiyxX
         lynMX1KXcvbbOVn8leywTURDeHVLX6S/KcIotYs5rqftq8fvcEGsUzb2uiikCiq6624J
         BYqw==
X-Gm-Message-State: AOAM533ARD1fnAyss0XiGCzaMb1lUrQgKukI3Gr5UsgrQp94/bJtheRB
        yeynVIPcLhZ1mlVhYFF3HP1NqKInUD6xl+taJwzRiPWFaes=
X-Google-Smtp-Source: ABdhPJzsgdn1rO6btVgTG8Bft6RnFXXK29uLfqY1oM1SFKNKey11LVblI/i4Y6eBXZqmF5unw3+5Oz0sDT4xrYaDTxc=
X-Received: by 2002:a02:9984:0:b0:32d:aeff:c592 with SMTP id
 a4-20020a029984000000b0032daeffc592mr14645905jal.46.1654570648907; Mon, 06
 Jun 2022 19:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220606012204.GP1745079@merlins.org> <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
 <20220606210855.GL22722@merlins.org> <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
 <20220606212301.GM22722@merlins.org> <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
 <20220606215013.GN22722@merlins.org> <CAEzrpqcn_BRL7p3gPmS5OVn5D-m8hMB-5JcAHwEHwKpxGxOMqw@mail.gmail.com>
 <20220606221755.GO22722@merlins.org> <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
 <20220607023740.GQ22722@merlins.org>
In-Reply-To: <20220607023740.GQ22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 6 Jun 2022 22:57:17 -0400
Message-ID: <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
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

On Mon, Jun 6, 2022 at 10:37 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Jun 06, 2022 at 10:28:25PM -0400, Josef Bacik wrote:
> > Ok I thought I caught this particular problem but I don't, so I fixed
> > tree-recover to handle unordered keys in different nodes.  Pull and
> > build, run tree-recover.  It's going to start deleting slots for
> > unordered keys, picking whichever node is newer as the source of
> > truth.  You should only see this happen on 164624, if you see it fire
> > a bunch right away stop it and send me the output so I can make sure I
> > didn't screw anything up.  I went over the code and diff a few times
> > to make sure I didn't mess anything up, but I could have missed
> > something.  If that runs and fixes stuff, run it again just to make
> > sure it doesn't find anything the second time.  It shouldn't since I
> > re-start the loop if we adjust things, but just in case.  I assume
> > this will blow up, but if it doesn't you can try running
> > init-extent-tree again and see how that goes.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> FS_INFO IS 0x557d47c7ebc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x557d47c7ebc0
> Checking root 2 bytenr 15645018587136
> Checking root 4 bytenr 15645019078656
> Checking root 5 bytenr 15645018161152
> Checking root 7 bytenr 15645018570752
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

Ah my bad, added all the repair code but not the code to notice it was
broken, try again please.  Thanks,

Josef
