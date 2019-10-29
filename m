Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08073E8E1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 18:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfJ2Rdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 13:33:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfJ2Rdd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 13:33:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1FF43B249;
        Tue, 29 Oct 2019 17:33:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BEBD2DA734; Tue, 29 Oct 2019 18:33:41 +0100 (CET)
Date:   Tue, 29 Oct 2019 18:33:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: document extent buffer locking
Message-ID: <20191029173341.GZ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <ed989ccddbc8822e61df533d861d907ce0a43040.1571340084.git.dsterba@suse.com>
 <ca92c081-7991-fd12-70e6-b392ba107260@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca92c081-7991-fd12-70e6-b392ba107260@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 02:16:26PM +0300, Nikolay Borisov wrote:
> >  void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
> >  {
> 
> I think for this and it's write counterpart a
> lockdep_assert_held(eb->lock) will be a better way to document the fact
> the lock needs to be held when those functions are called.

Ok, will add it.

> >  	trace_btrfs_set_lock_blocking_read(eb);
> 
> <snip>
> 
> >  /*
> > - * drop a blocking read lock
> > + * Release read lock, previously set to blocking by a pairing call to
> > + * btrfs_set_lock_blocking_read(). Can be nested in write lock by the same
> > + * thread.
> > + *
> > + * State of rwlock is unchanged, last reader wakes waiting threads.
> >   */
> >  void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
> >  {
> > @@ -279,8 +354,10 @@ void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
> >  }
> >  
> >  /*
> > - * take a spinning write lock.  This will wait for both
> > - * blocking readers or writers
> > + * Lock for write. Wait for all blocking and spinning readers and writers. This
> > + * starts context where reader lock could be nested by the same thread.
> 
> Imo you shouldn't ommit the explicit mention this takes a spinning lock.

But

> > + * The rwlock is held for write upon exit.

the next line in the commit says that. There's no explicit 'spinning'
but I find it sufficient. Feel free to suggest better wording.
