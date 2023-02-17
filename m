Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B097769A43E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 04:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBQDUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 22:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBQDUd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 22:20:33 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 963CF3773C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 19:20:28 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 4588975DF7C; Thu, 16 Feb 2023 22:19:10 -0500 (EST)
Date:   Thu, 16 Feb 2023 22:19:08 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Jukka Larja <roskakori@aarghimedes.fi>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, waxhead@dirtcellar.net
Subject: Re: Never balance metadata?
Message-ID: <Y+7yLJ7O0oz65rpm@hungrycats.org>
References: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
 <1755726.VLH7GnMWUR@lichtvoll.de>
 <c7c1eda1-d0a9-c924-2900-9158c34fc016@gmail.com>
 <17b150a2-c817-f2fd-ec32-029bc724dc36@aarghimedes.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17b150a2-c817-f2fd-ec32-029bc724dc36@aarghimedes.fi>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 12, 2023 at 12:10:16PM +0200, Jukka Larja wrote:
> After balance, the everyday
> scanning for changes only takes couple of seconds. Backups are also much
> faster, though as they run during night, it doesn't much matter.

It would be interesting to compare the results of a metadata balance with
a metadata defrag ('btrfs fi defrag /path/to/subvolume' _without_ -r).

I suspect a metadata defrag has much the same side-effect as the metadata
balance (reduce average seek distance between pages), but metadata defrag
won't reduce spare metadata allocations to zero.

> The filesystem was created June 2010 (probably) and every one of the
> original disks and some that came after have been replaced. This was the
> first time I balanced metadata, as far as I can remember. I think it does
> make sense to balance every now and then, if only once a decade :D .
> 
> -JLarja
> 
> -- 
>      ...Elämälle vierasta toimintaa...
>     Jukka Larja, Roskakori@aarghimedes.fi
> 
> <saylan> I just set up port forwards to defense.gov
> <saylan> anyone scanning me now will be scanning/attacking the DoD :D
> <renderbod> O.o
> <bolt> that's... not exactly how port forwarding works
> <saylan> ?
> - Quote Database, http://www.bash.org/?954232 -
