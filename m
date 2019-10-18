Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2A7DCCD3
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389783AbfJRRav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 13:30:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:42392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728833AbfJRRau (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 13:30:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E04CAF83;
        Fri, 18 Oct 2019 17:30:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F5D4DA785; Fri, 18 Oct 2019 19:31:03 +0200 (CEST)
Date:   Fri, 18 Oct 2019 19:31:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: set blocking_writers directly, no increment
 or decrement
Message-ID: <20191018173103.GE3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <6c64bb27ef5e0150db63c2415bb31f98331d2d4c.1571340084.git.dsterba@suse.com>
 <75bf572e-34ce-5f99-21b0-18359ce5581c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75bf572e-34ce-5f99-21b0-18359ce5581c@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 18, 2019 at 03:08:43PM +0300, Nikolay Borisov wrote:
> 
> 
> On 17.10.19 г. 22:38 ч., David Sterba wrote:
> > The increment and decrement was inherited from previous version that
> > used atomics, switched in commit 06297d8cefca ("btrfs: switch
> > extent_buffer blocking_writers from atomic to int"). The only possible
> > values are 0 and 1 so we can set them directly.
> > 
> > The generated assembly (gcc 9.x) did the direct value assignment in
> > btrfs_set_lock_blocking_write:
> > 
> >      5d:   test   %eax,%eax
> >      5f:   je     62 <btrfs_set_lock_blocking_write+0x22>
> >      61:   retq
> > 
> >   -  62:   lock incl 0x44(%rdi)
> >   -  66:   add    $0x50,%rdi
> >   -  6a:   jmpq   6f <btrfs_set_lock_blocking_write+0x2f>
> > 
> >   +  62:   movl   $0x1,0x44(%rdi)
> >   +  69:   add    $0x50,%rdi
> >   +  6d:   jmpq   72 <btrfs_set_lock_blocking_write+0x32>
> > 
> > The part in btrfs_tree_unlock did a decrement because
> > BUG_ON(blockers > 1) is probably not a strong hint for the compiler, but
> > otherwise the output looks safe:
> > 
> >   - lock decl 0x44(%rdi)
> > 
> >   + sub    $0x1,%eax
> >   + mov    %eax,0x44(%rdi)
> 
> I find it strange that plain inc/decs had the lock prefix in the
> resulting assembly. The sub instruction can have the lock prefix but
> here the compiler chooses not to. While this doesn't mean it's buggy I'm
> just curious what's happening.

The asm snippet is from the patch that did atomics -> int, which was
atomic_dec(blocking_writers) -> blocking_writers--, yet the result was
plain store.

It's probably not too clear from the context that it referes to the
menined commit 06297d8cefca.
