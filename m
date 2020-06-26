Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3420B0B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgFZLkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 07:40:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:53742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFZLkX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 07:40:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF297AFB1;
        Fri, 26 Jun 2020 11:40:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7FA2DAA08; Fri, 26 Jun 2020 13:40:08 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:40:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200626114008.GD27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200619015946.65638-1-wqu@suse.com>
 <20200626104628.GB27795@twin.jikos.cz>
 <8e086b89-b76e-7441-494c-ec33cf133959@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e086b89-b76e-7441-494c-ec33cf133959@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 26, 2020 at 07:09:41PM +0800, Qu Wenruo wrote:
> > [   26.508136] BTRFS: selftest: running qgroup tests
> > [   26.509820] BTRFS: selftest: running qgroup add/remove tests
> > [   26.511566] BUG: sleeping function called from invalid context at mm/slab.h:567
> > [   26.514058] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 117, name: modprobe
> > [   26.516671] 2 locks held by modprobe/117:
> > [   26.517980]  #0: ffff968162761a08 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_create_qgroup+0x29/0xf0 [btrfs]
> > [   26.521114]  #1: ffff968162761960 (&fs_info->qgroup_lock){+.+.}-{2:2}, at: btrfs_create_qgroup+0x75/0xf0 [btrfs]
> > [   26.524120] CPU: 1 PID: 117 Comm: modprobe Not tainted 5.8.0-rc2-default+ #1154
> > [   26.526439] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> > [   26.529612] Call Trace:
> > [   26.530731]  dump_stack+0x78/0xa0
> > [   26.531983]  ___might_sleep.cold+0xa6/0xf9
> > [   26.533290]  ? kobject_set_name_vargs+0x1e/0x90
> > [   26.534674]  __kmalloc_track_caller+0x143/0x340
> > [   26.536122]  kvasprintf+0x64/0xc0
> 
> But according to the call trace, it's indeed allocating the memory.
> 
> And my test machine has lockdep enabled, not sure why this is not working.

CONFIG_DEBUG_ATOMIC_SLEEP
