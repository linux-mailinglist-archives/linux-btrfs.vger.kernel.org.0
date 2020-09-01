Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88962259E44
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 20:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgIASkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 14:40:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIASkp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 14:40:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99198B1BD;
        Tue,  1 Sep 2020 18:40:44 +0000 (UTC)
Date:   Tue, 1 Sep 2020 13:40:40 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "fdmanana@gmail.com" <fdmanana@gmail.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200901184040.gxa3bh3nvrddi7ai@fiona>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <CAL3q7H6PqGagcRXoGswKhxyOJoFc23c7_1tTu183xCCiEPC5RQ@mail.gmail.com>
 <SN4PR0401MB3598F35FDA34EF5DE377C2CE9B2E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598F35FDA34EF5DE377C2CE9B2E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14:44 01/09, Johannes Thumshirn wrote:
> On 01/09/2020 16:37, Filipe Manana wrote:
> >> +               iocb->ki_flags |= IOCB_DSYNC;
> > 
> > This should be set before calling generic_write_sync() above,
> > otherwise we don't do the persistence required by dsync.
> > 
> > I have to be honest, I don't like this approach that much, it's a bit
> > fragile - what if some other code, invoked in between clearing and
> > setting back the flag, needs that flag to operate correctly?
> 
> Yes I don't like it either. 
> 
> I've compared btrfs to ext4 and xfs and both don't hold on the inode 
> lock for (nearly) the whole xxx_file_write_iter() time, so I think 
> the correct fix would be to relax this time. But I haven't found any 
> documentation yet on which functions need to be under the inode_lock 
> and which not.

I think you have got this reversed. ext4 and xfs hold the inode lock for
the entire xxx_file_write_iter(). OTOH, they don't take the inode lock
during fsync operations. The comments in btrfs_sync_file() mention that
it needs to make sure inode lock is acquired to make sure no other
process dirty the pages while sync is running.

> 
> Any input is appreciated here.
> 

-- 
Goldwyn
