Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2711CFC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 15:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfLLO2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 09:28:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:37174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729392AbfLLO2I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 09:28:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02B8DB213;
        Thu, 12 Dec 2019 14:28:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F157DA82A; Thu, 12 Dec 2019 15:28:07 +0100 (CET)
Date:   Thu, 12 Dec 2019 15:28:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
Message-ID: <20191212142807.GS3929@twin.jikos.cz>
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

On Thu, Dec 12, 2019 at 08:39:43AM +0800, Qu Wenruo wrote:
> 
> 
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

The spinlock should be safe as well, do you mean to take it to verify
that reloc_root is valid everywhere?

> > Clearing of the bit is done when there are not potential other users so
> > that part does not need the barrier (I think).
> > 
> > The checking part could use a helper so we don't have barriers scattered
> > around code.
> > 
> I'm still not confident enough for the "reloc_root = NULL" assignment
> and "reloc_root == NULL" test.
> 
> But since the set_bit()/test_bit() is safe, and it happens before we
> modify reloc_root, it's safer and is what we used in this quick fix.
> 
> Still, I'm really looking forward to Josef's root refcount work, that
> should be the real fix for all the problems.

That's a huge series and unsuitable for backports to stable, we need
something like your patches first.
