Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF5D54A028
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 22:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244476AbiFMUvH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347664AbiFMUtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 16:49:19 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C94FC369DD
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 13:08:07 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 4132F3BDD29; Mon, 13 Jun 2022 16:08:07 -0400 (EDT)
Date:   Mon, 13 Jun 2022 16:08:07 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Andrea Gelmini <andrea.gelmini@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <YqeZJ1j2ZYGpvY7v@hungrycats.org>
References: <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
 <20220611145259.GF1664812@merlins.org>
 <20220613022107.6eafbc1c@nvm>
 <20220613181322.GP1664812@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613181322.GP1664812@merlins.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 11:13:22AM -0700, Marc MERLIN wrote:
> On Mon, Jun 13, 2022 at 02:21:07AM +0500, Roman Mamedov wrote:
> > I'd suggest to put the LUKS volume onto an LV still (in case you don't), so you
> > can add and remove cache just to see how it works; unlike with bcache, an LVM
> 
> In case I decide to give that a shot, what would the actual LVM
> command(s) look like to create a null LVM? You'd just make a single PV
> using the cryptestup decrypted version of the mdadm raid5 and then an LV
> that takes all of it, but after the fact you can modify the LV and add a
> cache?

Some variables:

	vg=name of VG...
	device=name of cache device (SSD) PV...
	base=name of existing backing (HDD) LV...
	meta=meta$base
	pool=pool$base

Add a cache LV to an existing LV with:

	lvcreate $vg -n $meta -L 1G $device
	lvcreate $vg -n $pool -l 90%PVS $device
	lvconvert -f --type cache-pool --poolmetadata $vg/$meta $vg/$pool
	lvconvert -f --type cache --cachepool $vg/$pool $vg/$data --cachemode writethrough

Uncache with:

	lvconvert -f --uncache $vg/$data

Note that 'lvconvert' will flush the entire cache back to the backing
store during uncache at minimum IO priority, so it will take some time
and can be prolonged indefinitely by a continuous IO workload on top.
Also, the uncache operation will propagate any corruption in the SSD
cache back to the HDD LV, even in writethrough mode.

> Mart
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
> 
