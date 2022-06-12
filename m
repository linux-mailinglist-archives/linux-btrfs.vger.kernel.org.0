Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E00547C6A
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jun 2022 23:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiFLVVP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jun 2022 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiFLVVP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jun 2022 17:21:15 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B32EE19
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 14:21:13 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id CF39840B;
        Sun, 12 Jun 2022 21:21:08 +0000 (UTC)
Date:   Mon, 13 Jun 2022 02:21:07 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrea Gelmini <andrea.gelmini@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220613022107.6eafbc1c@nvm>
In-Reply-To: <20220611145259.GF1664812@merlins.org>
References: <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
        <20220611145259.GF1664812@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 11 Jun 2022 07:52:59 -0700
Marc MERLIN <marc@merlins.org> wrote:

> On Sat, Jun 11, 2022 at 02:30:33PM +0500, Roman Mamedov wrote:
> > > 2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach 
> > >    gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
> > >    [writethrough] writeback writearound none
> > 
> > Maybe try LVM Cache this time?
>  
> Hard to know either way, trading one layer for another, and LVM has
> always seemed heavier

I'd suggest to put the LUKS volume onto an LV still (in case you don't), so you
can add and remove cache just to see how it works; unlike with bcache, an LVM
cache can be added to an existing LV and then removed without a trace, all
without having to displace 44 TB of data for that.

And plain no-cache LVM doesn't add much in terms of being a "layer".

-- 
With respect,
Roman
