Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF112FA07
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgACPxK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 10:53:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:51296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbgACPxK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 10:53:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFF51AC3F;
        Fri,  3 Jan 2020 15:53:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6A38DA795; Fri,  3 Jan 2020 16:52:59 +0100 (CET)
Date:   Fri, 3 Jan 2020 16:52:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
Message-ID: <20200103155259.GA3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211153429.GO3929@twin.jikos.cz>
 <74a07fa4-ca35-57ee-2cd9-586a8db04712@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74a07fa4-ca35-57ee-2cd9-586a8db04712@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to get this series moving because the bug affects a few stable
versions.

On Thu, Dec 12, 2019 at 08:39:43AM +0800, Qu Wenruo wrote:
> On 2019/12/11 下午11:34, David Sterba wrote:
> > On Wed, Dec 11, 2019 at 01:00:01PM +0800, Qu Wenruo wrote:
> >> Due to commit d2311e698578 ("btrfs: relocation: Delay reloc tree
> >> deletion after merge_reloc_roots"), reloc tree lifespan is extended.
> >>
> >> Although we always set root->reloc_root to NULL before we drop the reloc
> >> tree, but that's not multi-core safe since we have no proper memory
> >> barrier to ensure other cores can see the same root->reloc_root.
> >>
> >> The proper root fix should be some proper root refcount, and make
> >> btrfs_drop_snapshot() to wait for all other root owner to release the
> >> root before dropping it.
> > 
> > This would block cleaning deleted subvolumes, no? We can skip the dead
> > tree (and add it back to the list) in that can and not wait. The
> > cleaner thread is able to process the list repeatedly.
> 
> What I mean is:
> - For consumer (reading root->reloc_root)
>   spin_lock(&root->reloc_lock);
>   if (!root->reloc_root) {
>       spin_unlock(&root->reloc_lock);
>       return NULL
>   }
>   refcount_inc(&root->reloc_root->refcount);
>   return(root->reloc_root);
>   spin_unlock(&root->reloc_lock);
> 
>   And of cource, release it after grabbing reloc_root.
> 
> - For cleaner
>   grab reloc_root just like consumer.
> retry:
>   wait_event(refcount_read(&root->reloc_root->ref_count) == 1);
>   spin_lock(&root->reloc_lock);
>   if (&root->reloc_root->ref_count != 1){
>       spin_unlock(); goto retry;
>   }
>   root->reloc_root = NULL;
>   spin_unlock(&root->reloc_lock);
>   /* Now we're the only owner, delete the root */

So it's one bit vs refcount and a lock. For the backports I'd go with
the bit, but this needs the barriers as mentioned in my previous reply.
Can you please update the patches?
