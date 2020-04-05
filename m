Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1BF19EE58
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDEV6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 17:58:08 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:44678 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEV6H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Apr 2020 17:58:07 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1jLDHH-00010y-Vn; Sun, 05 Apr 2020 23:58:03 +0200
Date:   Sun, 5 Apr 2020 23:58:03 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     kreijack@inwind.it
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
Message-ID: <20200405215803.GA21928@angband.pl>
References: <20200405082636.18016-1-kreijack@libero.it>
 <58e315a1-0307-9a26-8fb4-fd5220c1d5a6@cobb.uk.net>
 <4f10882a-fa89-25e0-901c-aff8010d46cd@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f10882a-fa89-25e0-901c-aff8010d46cd@libero.it>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 05, 2020 at 08:47:15PM +0200, Goffredo Baroncelli wrote:
> Currently BTRFS allocates the chunk on the basis of the free space.
> 
> For my tests I have a smaller ssd (20GB) and a bigger hdd (230GB).
> This means that the latter has higher priority for the allocation,
> until the free space became equal.
> 
> The rationale behind my patch is the following:
> - is quite simple (even tough in 3 iteration I put two errors :-) )
> - BTRFS has already two kind of information to store: data and metadata.
>   The former is (a lot ) bigger, than the latter. Having two kind of storage,
>   one faster (and expensive) than the other, it is natural to put the metadata
>   in the faster one, and the data in the slower one.

But why do you assume that SSD means fast?  Even with traditional disks
only, you can have a SATA-connected array for data and NVMe for metadata,
legacy NVMe for data and NVMe Optane for metadata -- but the real fun starts
if you put metadata on Optane pmem.

There are many storage tiers, and your patch hard-codes the lowest one as
the only determinator.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
⠈⠳⣄⠀⠀⠀⠀
