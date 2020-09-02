Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9111325B329
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgIBRrE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 13:47:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:45252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgIBRrD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Sep 2020 13:47:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D5FDAD5C;
        Wed,  2 Sep 2020 17:47:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D8AABDA7CF; Wed,  2 Sep 2020 19:45:49 +0200 (CEST)
Date:   Wed, 2 Sep 2020 19:45:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/4] btrfs: init sysfs for devices outside of the
 chunk_mutex
Message-ID: <20200902174549.GL28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1598996236.git.josef@toxicpanda.com>
 <5dccee8f9d7fe7b5072090327854fcbfdbd45b28.1598996236.git.josef@toxicpanda.com>
 <79ace2bf-6f01-39ee-0566-727182c5ff85@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ace2bf-6f01-39ee-0566-727182c5ff85@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 02, 2020 at 02:21:31PM +0800, Anand Jain wrote:
> > @@ -2609,6 +2606,10 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >   	btrfs_clear_space_info_full(fs_info);
> >   
> >   	mutex_unlock(&fs_info->chunk_mutex);
> > +
> > +	/* add sysfs device entry */
> > +	btrfs_sysfs_add_devices_dir(fs_devices, device);
> > +
> >   	mutex_unlock(&fs_devices->device_list_mutex);
> >   
> >   	if (seeding_dev) {
> > 
> 
> Strange we should get this splat when btrfs_sysfs_add_devices_dir()
> already has implicit GFP_NOFS allocation scope right? What did I
> miss?

The problem is the sysfs' kernfs_mutex, all sysfs allocations are
GFP_KERNEL thus it can grab fs_reclaim at some point.
