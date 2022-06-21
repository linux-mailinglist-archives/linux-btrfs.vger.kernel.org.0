Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB52552A72
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 07:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiFUF0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 01:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiFUF0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 01:26:09 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D8621822
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 22:26:08 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 1A4863DA738; Tue, 21 Jun 2022 01:26:08 -0400 (EDT)
Date:   Tue, 21 Jun 2022 01:26:07 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andrea Gelmini <andrea.gelmini@gmail.com>
Cc:     Marc MERLIN <marc@merlins.org>, Roman Mamedov <rm@romanrm.net>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <YrFWb52k5wu1L0cg@hungrycats.org>
References: <20220611143033.56ffa6af@nvm>
 <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
 <20220611145259.GF1664812@merlins.org>
 <CAK-xaQa0n8q9Fc5-t-pJfu4yrwO28A7dzEOgytzedbhL3N3v-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-xaQa0n8q9Fc5-t-pJfu4yrwO28A7dzEOgytzedbhL3N3v-A@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 20, 2022 at 10:37:25PM +0200, Andrea Gelmini wrote:
> Il giorno sab 11 giu 2022 alle ore 16:53 Marc MERLIN
> <marc@merlins.org> ha scritto:
> > Mmmh, bcachefs, I was not aware of this new one. Not sure if I want to
> > add yet another layer, esepcially if it's new.
>
> I share the link just to say: bcache author works in a great way.
> Bcachefs could be the idea to replace a few layers. Not to add new
> one.
>
> Just for the record.
> I'm using a 120TB array with BTRFS and bcache as caching over raid1 2TB ssd.
> I tried same setup with LVM, but - sadly - lvm tool complained about
> maximum cache size (16GB max, if I remember exactly, anyway no way to
> use the fully 2TB).
> Sad, because nowhere they mentioned this.

How many years ago was this?  There's no such limit today.  Here is a
500TB LV with 4TB of cache:

	# lvs -o +cachemode
	  LV          VG         Attr       LSize   Pool                Origin        Data%  Meta%  Move Log Cpy%Sync Convert CacheMode
	  lvol0       tv         Cwi-aoC--- 500.00t [lvol0_cache0_cvol] [lvol0_corig] 0.19   27.78           34.14            writeback
	  lvol0_cache tv         -wi-a-----   4.00t

There is a limit on metadata size, but you can override it in lvm.conf.
Presumably if you have a 100TB+ filesystem, you also have enough RAM lying
around to make the metadata size larger (it's 2.8GB at chunk size 128,
but that's not unreasonable for 4096GB of cache).

> Played a little bit with kernel source, but eventually didn't want to
> risk too much with a server I want to use in production at work.
>
> On my side, in the end, I really like cryptsetup for each HD, with
> mergerfs and snapraid (for my home setup).
> Very handy with replacing, playing, experimenting and so on.
> Each time I tried one big single volume setup, eventually I regret it.
>
> Ciao,
> Gelma
