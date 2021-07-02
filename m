Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C8A3B9A26
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 02:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhGBAkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 20:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhGBAkP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 20:40:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABA28613B6;
        Fri,  2 Jul 2021 00:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625186264;
        bh=VeKMN5XB9NMLXLzIS1obkCJlssa2K40AupSBI+KSH48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=meZc2NpWTJiSKUA+GHmEBJ33nfMUO/SXqHjJ2Li1I1HE7OARWecUQ1K/b84ebWlU4
         iEMEx5PTluhYBJOsPWthCZUVHCWe2ByFprD+pohPWWt8zhF43z2rx7vUBaysKBRA8U
         ar8FQg4qJ0Eh8hPZaMXiOhYmpeJXfKn2zKYUe4srO9JXAEvO1i1fzIXG33WCLQzYLl
         LXifeJQxVPSgyshCxpCkp0SlkS2WmChKn7yWbhNVkvSDRW7+1exnp083geRLKUUEzV
         96/pVBmFFohyBnDxiwezGGfuj6uRvpnwcDqSytAXJeKNn9Fm6HBD884Wav5BzAeWJ9
         uaRIgn0WsEOsA==
Date:   Thu, 1 Jul 2021 19:39:36 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
Message-ID: <20210702003936.GA13456@embeddedor>
References: <20210701160039.12518-1-dsterba@suse.com>
 <20210701215740.GA12099@embeddedor>
 <fc90ec53-1632-e796-3bf0-f46c5df790bb@gmx.com>
 <dd4346f9-bc3d-b12f-3b32-1e1ecabb5b8b@embeddedor.com>
 <62ec2948-77a3-6e50-7940-8de259b8671f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62ec2948-77a3-6e50-7940-8de259b8671f@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 02, 2021 at 08:21:31AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/2 上午8:09, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 7/1/21 18:59, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/7/2 上午5:57, Gustavo A. R. Silva wrote:
> > > > On Thu, Jul 01, 2021 at 06:00:39PM +0200, David Sterba wrote:
> > > > > On 64K pages the size of the extent_buffer::pages array is 1 and
> > > > > compilation with -Warray-bounds warns due to
> > > > > 
> > > > >     kaddr = page_address(eb->pages[idx + 1]);
> > > > > 
> > > > > when reading byte range crossing page boundary.
> > > > > 
> > > > > This does never actually overflow the array because on 64K because all
> > > > > the data fit in one page and bounds are checked by check_setget_bounds.
> > > > > 
> > > > > To fix the reported overflow and warning add a copy of the non-crossing
> > > > > read/write code and put it behind a condition that's evaluated at
> > > > > compile time. That way only one implementation remains due to dead code
> > > > > elimination.
> > > > 
> > > > Any chance we can use a flexible-array in struct extent_buffer instead,
> > > > so all the warnings are removed?
> > > > 
> > > > Something like this:
> > > > 
> > > > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > > > index 62027f551b44..b82e8b694a3b 100644
> > > > --- a/fs/btrfs/extent_io.h
> > > > +++ b/fs/btrfs/extent_io.h
> > > > @@ -94,11 +94,11 @@ struct extent_buffer {
> > > > 
> > > >           struct rw_semaphore lock;
> > > > 
> > > > -       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
> > > >           struct list_head release_list;
> > > >    #ifdef CONFIG_BTRFS_DEBUG
> > > >           struct list_head leak_list;
> > > >    #endif
> > > > +       struct page *pages[];
> > > >    };
> > > 
> > > But wouldn't that make the the size of extent_buffer structure change
> > > and affect the kmem cache for it?
> > 
> > Could you please point out the places in the code that would be
> > affected?
> 
> Sure, the direct code get affected is here:
> 
> extent_io.c:
> int __init extent_io_init(void)
> {
>         extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
>                         sizeof(struct extent_buffer), 0,
>                         SLAB_MEM_SPREAD, NULL);
> 
> So here we can no longer use sizeof(struct extent_buffer);
> 
> Furthermore, this function is called at btrfs module load time,
> at that time we have no idea how large the extent buffer could be, thus we
> must allocate a large enough cache for extent buffer.
> 
> Thus the size will be fixed to the current size, no matter if we use flex
> array or not.
> 
> Though I'm not sure if using such flex array with fixed real size can silent
> the warning though.

Yeah; I think this might be the right solution:

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9e81d25dea70..4cf0b72fdd9f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -232,8 +232,9 @@ int __init extent_state_cache_init(void)
 int __init extent_io_init(void)
 {
        extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
-                       sizeof(struct extent_buffer), 0,
-                       SLAB_MEM_SPREAD, NULL);
+                       struct_size((struct extent_buffer *)0, pages,
+                                   INLINE_EXTENT_BUFFER_PAGES),
+                       0, SLAB_MEM_SPREAD, NULL);
        if (!extent_buffer_cache)
                return -ENOMEM;

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 62027f551b44..b82e8b694a3b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -94,11 +94,11 @@ struct extent_buffer {

        struct rw_semaphore lock;

-       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
        struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
        struct list_head leak_list;
 #endif
+       struct page *pages[];
 };

 /*


I see zero warnings by building with
make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- ppc64_defconfig

and -Warray-bounds enabled by default:

diff --git a/Makefile b/Makefile
index c2cc2fa28525..310452119ab5 100644
--- a/Makefile
+++ b/Makefile
@@ -1068,7 +1068,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)

 # We'll want to enable this eventually, but it's not going away for 5.7 at least
 KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
-KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)

 # Another good warning that we'll want to enable eventually

Do you think there is any other place where we should update
the total size for extent_buffer?

--
Gustavo


> 
> Thanks,
> Qu
> > 
> > I'm trying to understand this code and see the possibility of
> > using a flex-array together with proper memory allocation, so
> > we can avoid having one-element array in extent_buffer.
> > 
> > Not sure at what extent this would be possible. So, any pointer
> > is greatly appreciate it. :)
> > 
> > Thanks
> > --
> > Gustavo
> > 
> > > 
> > > Thanks,
> > > Qu
> > > > 
> > > >    /*
> > > > 
> > > > which is actually what is needed in this case to silence the
> > > > array-bounds warnings: the replacement of the one-element array
> > > > with a flexible-array member[1] in struct extent_buffer.
> > > > 
> > > > -- 
> > > > Gustavo
> > > > 
> > > > [1] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
> > > > 
> > > > > 
> > > > > Link: https://lore.kernel.org/lkml/20210623083901.1d49d19d@canb.auug.org.au/
> > > > > CC: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > > > ---
> > > > >    fs/btrfs/struct-funcs.c | 66 +++++++++++++++++++++++++----------------
> > > > >    1 file changed, 41 insertions(+), 25 deletions(-)
> > > > > 
> > > > > diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
> > > > > index 8260f8bb3ff0..51204b280da8 100644
> > > > > --- a/fs/btrfs/struct-funcs.c
> > > > > +++ b/fs/btrfs/struct-funcs.c
> > > > > @@ -73,14 +73,18 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,        \
> > > > >        }                                \
> > > > >        token->kaddr = page_address(token->eb->pages[idx]);        \
> > > > >        token->offset = idx << PAGE_SHIFT;                \
> > > > > -    if (oip + size <= PAGE_SIZE)                    \
> > > > > +    if (INLINE_EXTENT_BUFFER_PAGES == 1) {                \
> > > > >            return get_unaligned_le##bits(token->kaddr + oip);    \
> > > > > +    } else {                            \
> > > > > +        if (oip + size <= PAGE_SIZE)                \
> > > > > +            return get_unaligned_le##bits(token->kaddr + oip); \
> > > > >                                        \
> > > > > -    memcpy(lebytes, token->kaddr + oip, part);            \
> > > > > -    token->kaddr = page_address(token->eb->pages[idx + 1]);        \
> > > > > -    token->offset = (idx + 1) << PAGE_SHIFT;            \
> > > > > -    memcpy(lebytes + part, token->kaddr, size - part);        \
> > > > > -    return get_unaligned_le##bits(lebytes);                \
> > > > > +        memcpy(lebytes, token->kaddr + oip, part);        \
> > > > > +        token->kaddr = page_address(token->eb->pages[idx + 1]);    \
> > > > > +        token->offset = (idx + 1) << PAGE_SHIFT;        \
> > > > > +        memcpy(lebytes + part, token->kaddr, size - part);    \
> > > > > +        return get_unaligned_le##bits(lebytes);            \
> > > > > +    }                                \
> > > > >    }                                    \
> > > > >    u##bits btrfs_get_##bits(const struct extent_buffer *eb,        \
> > > > >                 const void *ptr, unsigned long off)        \
> > > > > @@ -94,13 +98,17 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,        \
> > > > >        u8 lebytes[sizeof(u##bits)];                    \
> > > > >                                        \
> > > > >        ASSERT(check_setget_bounds(eb, ptr, off, size));        \
> > > > > -    if (oip + size <= PAGE_SIZE)                    \
> > > > > +    if (INLINE_EXTENT_BUFFER_PAGES == 1) {                \
> > > > >            return get_unaligned_le##bits(kaddr + oip);        \
> > > > > +    } else {                            \
> > > > > +        if (oip + size <= PAGE_SIZE)                \
> > > > > +            return get_unaligned_le##bits(kaddr + oip);    \
> > > > >                                        \
> > > > > -    memcpy(lebytes, kaddr + oip, part);                \
> > > > > -    kaddr = page_address(eb->pages[idx + 1]);            \
> > > > > -    memcpy(lebytes + part, kaddr, size - part);            \
> > > > > -    return get_unaligned_le##bits(lebytes);                \
> > > > > +        memcpy(lebytes, kaddr + oip, part);            \
> > > > > +        kaddr = page_address(eb->pages[idx + 1]);        \
> > > > > +        memcpy(lebytes + part, kaddr, size - part);        \
> > > > > +        return get_unaligned_le##bits(lebytes);            \
> > > > > +    }                                \
> > > > >    }                                    \
> > > > >    void btrfs_set_token_##bits(struct btrfs_map_token *token,        \
> > > > >                    const void *ptr, unsigned long off,        \
> > > > > @@ -124,15 +132,19 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,        \
> > > > >        }                                \
> > > > >        token->kaddr = page_address(token->eb->pages[idx]);        \
> > > > >        token->offset = idx << PAGE_SHIFT;                \
> > > > > -    if (oip + size <= PAGE_SIZE) {                    \
> > > > > +    if (INLINE_EXTENT_BUFFER_PAGES == 1) {                \
> > > > >            put_unaligned_le##bits(val, token->kaddr + oip);    \
> > > > > -        return;                            \
> > > > > +    } else {                            \
> > > > > +        if (oip + size <= PAGE_SIZE) {                \
> > > > > +            put_unaligned_le##bits(val, token->kaddr + oip); \
> > > > > +            return;                        \
> > > > > +        }                            \
> > > > > +        put_unaligned_le##bits(val, lebytes);            \
> > > > > +        memcpy(token->kaddr + oip, lebytes, part);        \
> > > > > +        token->kaddr = page_address(token->eb->pages[idx + 1]);    \
> > > > > +        token->offset = (idx + 1) << PAGE_SHIFT;        \
> > > > > +        memcpy(token->kaddr, lebytes + part, size - part);    \
> > > > >        }                                \
> > > > > -    put_unaligned_le##bits(val, lebytes);                \
> > > > > -    memcpy(token->kaddr + oip, lebytes, part);            \
> > > > > -    token->kaddr = page_address(token->eb->pages[idx + 1]);        \
> > > > > -    token->offset = (idx + 1) << PAGE_SHIFT;            \
> > > > > -    memcpy(token->kaddr, lebytes + part, size - part);        \
> > > > >    }                                    \
> > > > >    void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,    \
> > > > >                  unsigned long off, u##bits val)            \
> > > > > @@ -146,15 +158,19 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,    \
> > > > >        u8 lebytes[sizeof(u##bits)];                    \
> > > > >                                        \
> > > > >        ASSERT(check_setget_bounds(eb, ptr, off, size));        \
> > > > > -    if (oip + size <= PAGE_SIZE) {                    \
> > > > > +    if (INLINE_EXTENT_BUFFER_PAGES == 1) {                \
> > > > >            put_unaligned_le##bits(val, kaddr + oip);        \
> > > > > -        return;                            \
> > > > > -    }                                \
> > > > > +    } else {                            \
> > > > > +        if (oip + size <= PAGE_SIZE) {                \
> > > > > +            put_unaligned_le##bits(val, kaddr + oip);    \
> > > > > +            return;                        \
> > > > > +        }                            \
> > > > >                                        \
> > > > > -    put_unaligned_le##bits(val, lebytes);                \
> > > > > -    memcpy(kaddr + oip, lebytes, part);                \
> > > > > -    kaddr = page_address(eb->pages[idx + 1]);            \
> > > > > -    memcpy(kaddr, lebytes + part, size - part);            \
> > > > > +        put_unaligned_le##bits(val, lebytes);            \
> > > > > +        memcpy(kaddr + oip, lebytes, part);            \
> > > > > +        kaddr = page_address(eb->pages[idx + 1]);        \
> > > > > +        memcpy(kaddr, lebytes + part, size - part);        \
> > > > > +    }                                \
> > > > >    }
> > > > > 
> > > > >    DEFINE_BTRFS_SETGET_BITS(8)
> > > > > -- 
> > > > > 2.31.1
> > > > > 
