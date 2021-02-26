Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C47F32648D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhBZPNa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 10:13:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:58892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhBZPNT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 10:13:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B599AAB8C;
        Fri, 26 Feb 2021 15:12:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D6D5DA7FF; Fri, 26 Feb 2021 16:10:44 +0100 (CET)
Date:   Fri, 26 Feb 2021 16:10:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Su Yue <l@damenly.su>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [report] lockdep warning when mounting seed device
Message-ID: <20210226151044.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Su Yue <l@damenly.su>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <tuq0pxpx.fsf@damenly.su>
 <50ff53e3-6e6f-bc6d-31dc-ac376ed944ce@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ff53e3-6e6f-bc6d-31dc-ac376ed944ce@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 26, 2021 at 01:01:02PM +0800, Anand Jain wrote:
> On 25/02/2021 12:39, Su Yue wrote:
> > 
> > While playing with seed device(misc/next and v5.11), lockdep complains 
> > the following:
> > 
> > To reproduce:
> > 
> > dev1=/dev/sdb1
> > dev2=/dev/sdb2
> > 
> > umount /mnt
> > 
> > mkfs.btrfs -f $dev1
> > 
> > btrfstune -S 1 $dev1
> > 
> > mount $dev1 /mnt
> > 
> > btrfs device add $dev2 /mnt/ -f
> > 
> > umount /mnt
> > 
> > mount $dev2 /mnt
> > 
> > umount /mnt
> > 
> > 
> 
> In my understanding the commit 01d01caf19ff7c537527d352d169c4368375c0a1
>   (btrfs: move the chunk_mutex in btrfs_read_chunk_tree
>   fixed this bug in 5.9.
> Could you please try this [1] patch,
> [1] 
> https://patchwork.kernel.org/project/linux-btrfs/patch/20200717100525.320697-1-anand.jain@oracle.com/
> Patch [1] still relevant as the device_list_mutex in clone_fs_devices() 
> is redundant. We could remove it as well.

So the fix 01d01caf19ff7c was not sufficient, the lockdep splat is
reproducible.
