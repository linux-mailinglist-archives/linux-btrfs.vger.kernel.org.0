Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339BA36911C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhDWLb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 07:31:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:42306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhDWLb3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 07:31:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1056CB10B;
        Fri, 23 Apr 2021 11:30:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DE0B2DA7FE; Fri, 23 Apr 2021 13:28:31 +0200 (CEST)
Date:   Fri, 23 Apr 2021 13:28:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     riteshh <riteshh@linux.ibm.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/2] btrfs: Use reada_control pointer instead of void
 pointer
Message-ID: <20210423112831.GF7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, riteshh <riteshh@linux.ibm.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210406162404.11746-1-rgoldwyn@suse.de>
 <20210406162404.11746-2-rgoldwyn@suse.de>
 <20210407154946.xqvwajsmh77pejvt@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407154946.xqvwajsmh77pejvt@riteshh-domain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 07, 2021 at 09:19:46PM +0530, riteshh wrote:
> On 21/04/06 11:24AM, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> > Since struct reada_control is defined in ctree.h,
> > Use struct reada_control pointer as a function argument for
> > btrfs_reada_wait() instead of a void pointer in order
> > to avoid type-casting within the function.
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/btrfs/ctree.h | 2 +-
> >  fs/btrfs/reada.c | 6 ++----
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 2acbd8919611..8bf434a4f014 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3699,7 +3699,7 @@ struct reada_control {
> >  };
> >  struct reada_control *btrfs_reada_add(struct btrfs_root *root,
> >  			      struct btrfs_key *start, struct btrfs_key *end);
> > -int btrfs_reada_wait(void *handle);
> > +int btrfs_reada_wait(struct reada_control *rc);
> 
> While we are at it we may as well make this function return void.
> Since we anyways always return 0 and no one seems to be handling the return
> value anyways.

That nothing is handling the error is not a sufficient reason, it needs
to be at least verified that this is expected. Also if there are called
functions that could return error or just do the bug-on error handling
instead of proper error handling, the call path needs to be updated.
In this case it's reada_start_machine that needs to be fixed.

As readahead is only a hint, many errors are not considered fatal so the
actual fix could be to just return the error and let the callers decide.
btrfs_reada_wait could try to start it, if it fails, just bail out. Then
it would be ok to return void value.


> >  int btree_readahead_hook(struct extent_buffer *eb, int err);
> 
> I guess, you may want to look into return value from this function too.
> I don't think that too is being checked by any of it's callers.

That looks like it can follow the same pattern as described above.
