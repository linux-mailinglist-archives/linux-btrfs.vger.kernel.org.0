Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA48523200
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiEKLnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 07:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbiEKLnn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 07:43:43 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45C243134
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 04:43:41 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e15so1765297iob.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RH006oZiZ+JCv1Nt/nllCaqcecR6kSxpTfv/P6s7Yas=;
        b=Yj6EQ6xbNXWZeduzmaseJ6QRgsMK5QxKG5wbdwAJ44n8noguFePsCKqA83TvVLpQb7
         FqP0PoPAG/jzSpsdRj9JjCtcNaEYZGZ8aC/YYnDno/ZhXz0Tii4jd209nIiaIo5WCx9z
         ZVxWy68epGKljc67FbOeWqurk9yAHajYpwq7rbe4Xz2AnXPoqQH3tA0soLMCcU/sOZ5R
         SrUmBmT8Wc9ycFjQNO/KO8zuw9XU1irjA35TBhWAnhWzSuC8qI469RQCx3eprAZYsDE3
         wV1ynTPIFviUUqHfs7XRjoSqAY3vqHZ5rsF8b4Hwhj3U/X4i5ABbCI9aRYOlM6HdzJhN
         aEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RH006oZiZ+JCv1Nt/nllCaqcecR6kSxpTfv/P6s7Yas=;
        b=gW8RTrnSQUUrZ6He2CC5dwSWDEMg/+DSsVLq5LELEWSTbzNDdrpHELRzwvh2bHZFEw
         n/FteYeJq6U+IeSLZgKKo0ogb5QMJLPDJGxVvwLF4uiQt9ED5IqXmo5prtPHpxXdwIwC
         yxqC42rHsqR+lT45izoMeTjeH/pqg0ntLzxtr3T0ciz1fkJPN2gJ2or8Ml1NbyoGSPWL
         VXx2HznUFEAgRyX7IiSO6FpY5b4dALwluSEtiiufXlDIiUzb84VZv6e4GxwjIy15d4Va
         sL+AtJvPzjqtUxESXtJk1BuuMmcg/ari0r6C00Sxw+VRrWTSiHaHQ/j+h/D0hTwudRc9
         ff/Q==
X-Gm-Message-State: AOAM530w6S1sjlRkBisrr8tj/7gHXUsHbQPGGRBNR0EDhfNxn+D7xrCo
        UdZOV23meHj1T3NWa+ZbUw90GUvTOKrwizf7qH43ZUdYdUk=
X-Google-Smtp-Source: ABdhPJxg+7I/IqVc1oLClewTPVvvW+NoaSt2W7YcRCWK25K5TAb4vSZC3nRfM0fkGd9rsWkIhetAqVoxy8kIO+feGGo=
X-Received: by 2002:a05:6602:3429:b0:65a:a4a6:13b9 with SMTP id
 n41-20020a056602342900b0065aa4a613b9mr11036188ioz.166.1652269420668; Wed, 11
 May 2022 04:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
 <20220510143739.GC12542@merlins.org> <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
 <20220510160600.GG12542@merlins.org> <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org> <20220510211507.GJ12542@merlins.org>
 <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
 <20220511000815.GK12542@merlins.org> <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
 <20220511014827.GL12542@merlins.org>
In-Reply-To: <20220511014827.GL12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 11 May 2022 07:43:29 -0400
Message-ID: <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
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

On Tue, May 10, 2022 at 9:48 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 10, 2022 at 08:28:09PM -0400, Josef Bacik wrote:
> > Ok the csum errors I expect.  I've made some changes and pushed them,
> > re-run the rescue init-extent-tree again.  Run check without --repair.
> > If it complains about extent backrefs then I fucked up, I just need
> > like 20ish lines of that output to see what I'm messing up.  If it
> > only complains about csums then we won, we can run btrfs check
> > --init-csum-tree, and then --repair.  Thanks,
>
> searching 165298 for bad extents
> processed 108756992 of 108756992 possible bytes, 100%
> searching 165299 for bad extents
> processed 75792384 of 75792384 possible bytes, 100%
> searching 18446744073709551607 for bad extents
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 3
> processed 1556480 of 0 possible bytes, 0%
> Recording extents for root 1
> processed 1474560 of 0 possible bytes, 0%
> doing roots
> Recording extents for root 4
> processed 1032192 of 1064960 possible bytes, 96%
> Recording extents for root 5
> processed 10960896 of 10977280 possible bytes, 99%
> Recording extents for root 7
> processed 16384 of 16545742848 possible bytes, 0%
> Recording extents for root 9
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 11221
> processed 49152 of 256016384 possible bytes, 0%
> Recording extents for root 11222
> processed 49479680 of 49479680 possible bytes, 100%
> Recording extents for root 11223
> processed 1619902464 of 1635549184 possible bytes, 99%Ignoring transid failure
> processed 1635319808 of 1635549184 possible bytes, 99%
> Recording extents for root 11224
> processed 75792384 of 75792384 possible bytes, 100%
> Recording extents for root 159785
> processed 108429312 of 108429312 possible bytes, 100%
> Recording extents for root 159787
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 160494
> processed 1425408 of 108560384 possible bytes, 1%
> Recording extents for root 160496
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 161197
> processed 770048 of 108544000 possible bytes, 0%
> Recording extents for root 161199
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 162628
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 162632
> processed 2441216 of 108691456 possible bytes, 2%
> Recording extents for root 162645
> processed 49152 of 75792384 possible bytes, 0%
> Recording extents for root 163298
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 163302
> processed 966656 of 108691456 possible bytes, 0%
> Recording extents for root 163303
> processed 49152 of 75792384 possible bytes, 0%
> Recording extents for root 163316
> processed 933888 of 108691456 possible bytes, 0%
> Recording extents for root 163318
> processed 16384 of 49479680 possible bytes, 0%
> Recording extents for root 163916
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 163920
> processed 966656 of 108691456 possible bytes, 0%
> Recording extents for root 163921
> processed 49152 of 75792384 possible bytes, 0%
> Recording extents for root 164620
> processed 49152 of 49479680 possible bytes, 0%
> Recording extents for root 164624
> processed 98304 of 109445120 possible bytes, 0%
> Recording extents for root 164633
> processed 49152 of 75792384 possible bytes, 0%
> Recording extents for root 165098
> processed 1015808 of 108756992 possible bytes, 0%
> Recording extents for root 165100
> processed 16384 of 49479680 possible bytes, 0%
> Recording extents for root 165198
> processed 491520 of 108756992 possible bytes, 0%adding a bytenr that overlaps our thing, dumping paths for [76300, 108, 0]
> misc/file
> doing an insert of the bytenr
> doing an insert that overlaps our bytenr 10467695652864 8675328
> processed 983040 of 108756992 possible bytes, 0%
> Recording extents for root 165200
> processed 16384 of 49479680 possible bytes, 0%
> Recording extents for root 165294
> processed 16384 of 49479680 possible bytes, 0%
> Recording extents for root 165298
> processed 524288 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
> misc/file
> processed 1015808 of 108756992 possible bytes, 0%
> Recording extents for root 165299
> processed 16384 of 75792384 possible bytes, 0%
> Recording extents for root 18446744073709551607
> processed 16384 of 16384 possible bytes, 100%
> doing block accounting
> doing close???
> Init extent tree finished, you can run check now
>
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check /dev/mapper/dshelf1
> Opening filesystem to check...
> FS_INFO IS 0x55611fc9ee50
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55611fc9ee50
> Checking filesystem on /dev/mapper/dshelf1
> UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
> [1/7] checking root items
> checksum verify failed on 15645954129920 wanted 0x085fc24a found 0x941acdde
> checksum verify failed on 15645954195456 wanted 0x6c1c72a4 found 0xb06d5dd9
> checksum verify failed on 15645608116224 wanted 0x31706547 found 0x314fad1d
> checksum verify failed on 15645262413824 wanted 0x3affbd35 found 0x96d53d25
> checksum verify failed on 13577199878144 wanted 0x6e9e8bc6 found 0x61063457
> checksum verify failed on 13577399156736 wanted 0x2869b8c7 found 0xbb1119e1
> checksum verify failed on 12512437698560 wanted 0xca43b3f8 found 0xd7f6db69
> checksum verify failed on 13577503686656 wanted 0xd81b7702 found 0x95a3c9a6
> checksum verify failed on 15645781344256 wanted 0xb81e3df4 found 0xb5c70846
> checksum verify failed on 13577178939392 wanted 0x2cb83118 found 0x63f0b6bf
> checksum verify failed on 15645419667456 wanted 0xde0dab28 found 0x3ceddd16
> checksum verify failed on 13577821011968 wanted 0x9a29aff5 found 0x2cdff391
> checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
> [2/7] checking extents

OMG we're almost done, that's awesome.  So no extent errors, just the
csum things and the fs things I expected.  Now we do

btrfs check --init-csum-tree <dev>
btrfs check --repair <dev>

and then you should be good.  Thanks,

Josef
