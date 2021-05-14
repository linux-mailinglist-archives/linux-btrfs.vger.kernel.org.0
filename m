Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309D7380BD6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhENOca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 10:32:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:57158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230141AbhENOca (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 10:32:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3064FB19B;
        Fri, 14 May 2021 14:31:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C8E5DAF1B; Fri, 14 May 2021 16:28:47 +0200 (CEST)
Date:   Fri, 14 May 2021 16:28:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not BUG_ON if btrfs_add_to_fsid
 succeeded to write superblock
Message-ID: <20210514142846.GW7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <20210511042501.900731-1-l@damenly.su>
 <20210512140135.GR7604@twin.jikos.cz>
 <k0o3lb1d.fsf@damenly.su>
 <20210514112243.GT7604@suse.cz>
 <eee9l9iy.fsf@damenly.su>
 <347443f7-b26c-04ac-88c2-2d1e490b7115@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347443f7-b26c-04ac-88c2-2d1e490b7115@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 09:50:00PM +0800, Qu Wenruo wrote:
> > Right, I initially booted the kvm using Ubuntu kernel built with 4k
> > pages then compiled 16k pagesize kernel manully.
> 
> Are you sure it's really no 64K page support?
> 
> For example, maybe it's the fault of the VM UEFI you're using doesn't
> support 64K page size?

It's been said on various sites that analyzed the chip that it's 16k and
there's not much official specs. Here's the most specific number
regarding page size and also effects on caches (and other perf
characteristics).

https://www.anandtech.com/show/16226/apple-silicon-m1-a14-deep-dive/2
