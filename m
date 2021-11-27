Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8123C45FE9E
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Nov 2021 13:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhK0MpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Nov 2021 07:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230411AbhK0MnX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Nov 2021 07:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638016808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yp0zZSYGAMbX/qvHvpy0YT3u+rVb+L6Ue2goXMoxgeM=;
        b=O2/rdZHW4nEFyEJUsqfKYsszmkah9Lfprk9+JS4yym3EzwdbdgYUkEYJTuB8A34o4nuCqo
        zCBxcNq9H2MPrCXpERyx6WsF3iaa8b+SGyt5RNyW71y4BNGyOEfYDUr0ffq+haufF4EFkI
        JW4BMBjEbaexBMuNW5dDAhrqE2N0Ffo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-afP2sVb5O-COhkzTfsIrTA-1; Sat, 27 Nov 2021 07:40:05 -0500
X-MC-Unique: afP2sVb5O-COhkzTfsIrTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A34363A9;
        Sat, 27 Nov 2021 12:40:03 +0000 (UTC)
Received: from max.com (unknown [10.40.193.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC0D15D9C0;
        Sat, 27 Nov 2021 12:39:59 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page faults
Date:   Sat, 27 Nov 2021 13:39:58 +0100
Message-Id: <20211127123958.588350-1-agruenba@redhat.com>
In-Reply-To: <CAHc6FU53gdXR4VjSQJUtUigVkgDY6yfRkNBYuBj4sv3eT=MBSQ@mail.gmail.com>
References:  <CAHc6FU53gdXR4VjSQJUtUigVkgDY6yfRkNBYuBj4sv3eT=MBSQ@mail.gmail.com> <YaAROdPCqNzSKCjh@arm.com> <20211124192024.2408218-1-catalin.marinas@arm.com> <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org> <YZ6idVy3zqQC4atv@arm.com> <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 27, 2021 at 4:52 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> On Sat, Nov 27, 2021 at 12:06 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Nov 26, 2021 at 11:29:45PM +0100, Andreas Gruenbacher wrote:
> > > On Thu, Nov 25, 2021 at 11:42 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > As per Linus' reply, we can work around this by doing
> > > > a sub-page fault_in_writable(point_of_failure, align) where 'align'
> > > > should cover the copy_to_user() impreciseness.
> > > >
> > > > (of course, fault_in_writable() takes the full size argument but behind
> > > > the scene it probes the 'align' prefix at sub-page fault granularity)
> > >
> > > That doesn't make sense; we don't want fault_in_writable() to fail or
> > > succeed depending on the alignment of the address range passed to it.
> >
> > If we know that the arch copy_to_user() has an error of say maximum 16
> > bytes (or 15 rather on arm64), we can instead get fault_in_writeable()
> > to probe the first 16 bytes rather than 1.
>
> That isn't going to help one bit: [raw_]copy_to_user() is allowed to
> copy as little or as much as it wants as long as it follows the rules
> documented in include/linux/uaccess.h:
>
> [] If copying succeeds, the return value must be 0.  If some data cannot be
> [] fetched, it is permitted to copy less than had been fetched; the only
> [] hard requirement is that not storing anything at all (i.e. returning size)
> [] should happen only when nothing could be copied.  In other words, you don't
> [] have to squeeze as much as possible - it is allowed, but not necessary.
>
> When fault_in_writeable() tells us that an address range is accessible
> in principle, that doesn't mean that copy_to_user() will allow us to
> access it in arbitrary chunks. It's also not the case that
> fault_in_writeable(addr, size) is always followed by
> copy_to_user(addr, ..., size) for the exact same address range, not
> even in this case.
>
> These alignment restrictions have nothing to do with page or sub-page faults.
>
> I'm also fairly sure that passing in an unaligned buffer will send
> search_ioctl into an endless loop on architectures with copy_to_user()
> alignment restrictions; there don't seem to be any buffer alignment
> checks.

Let me retract that ...

The description in include/linux/uaccess.h leaves out permissible
reasons for fetching/storing less than requested. Thinking about it, if
the address range passed to one of the copy functions includes an
address that faults, it kind of makes sense to allow the copy function
to stop short instead of copying every last byte right up to the address
that fails.

If that's the only reason, then it would be great to have that included
in the description.  And then we can indeed deal with the alignment
effects in fault_in_writeable().

> > > copy_to_user_nofault_unaligned() should be further optimized, maybe as
> > > mm/maccess.c:copy_from_kernel_nofault() and/or per architecture
> > > depending on the actual alignment rules; I'm not sure.
> > [...]
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -2051,13 +2051,30 @@ static noinline int key_in_sk(struct btrfs_key *key,
> > >       return 1;
> > >  }
> > >
> > > +size_t copy_to_user_nofault_unaligned(void __user *to, void *from, size_t size)
> > > +{
> > > +     size_t rest = copy_to_user_nofault(to, from, size);
> > > +
> > > +     if (rest) {
> > > +             size_t n;
> > > +
> > > +             for (n = size - rest; n < size; n++) {
> > > +                     if (copy_to_user_nofault(to + n, from + n, 1))
> > > +                             break;
> > > +             }
> > > +             rest = size - n;
> > > +     }
> > > +     return rest;
> >
> > That's what I was trying to avoid. That's basically a fall-back to byte
> > at a time copy (we do this in copy_mount_options(); at some point we
> > even had a copy_from_user_exact() IIRC).
>
> We could try 8/4/2 byte chunks if both buffers are 8/4/2-byte aligned.
> It's just not clear that it's worth it.
>
> > Linus' idea (if I got it correctly) was instead to slightly extend the
> > probing in fault_in_writeable() for the beginning of the buffer from 1
> > byte to some per-arch range.
> >
> > I attempted the above here and works ok:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/btrfs-live-lock-fix
> >
> > but too late to post it this evening, I'll do it in the next day or so
> > as an alternative to this series.

I've taken a quick look.  Under the assumption that alignment effects
are tied to page / sub-page faults, I think we can really solve this
generically as Willy has proposed.  Maybe as shown below; no need for
arch-specific code.

Thanks,
Andreas

diff --git a/mm/gup.c b/mm/gup.c
index 2c51e9748a6a..a9b3d916b625 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1658,6 +1658,8 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 }
 #endif /* !CONFIG_MMU */
 
+#define SUBPAGE_FAULT_SIZE 16
+
 /**
  * fault_in_writeable - fault in userspace address range for writing
  * @uaddr: start of address range
@@ -1673,8 +1675,19 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
 	if (unlikely(size == 0))
 		return 0;
 	if (!PAGE_ALIGNED(uaddr)) {
+		if (SUBPAGE_FAULT_SIZE &&
+		    !IS_ALIGNED((unsigned long)uaddr, SUBPAGE_FAULT_SIZE)) {
+			end = PTR_ALIGN(uaddr, SUBPAGE_FAULT_SIZE);
+			if (end - uaddr < size) {
+				if (unlikely(__put_user(0, uaddr) != 0))
+					return size;
+				uaddr = end;
+				if (unlikely(!end))
+					goto out;
+			}
+		}
 		if (unlikely(__put_user(0, uaddr) != 0))
-			return size;
+			goto out;
 		uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
 	}
 	end = (char __user *)PAGE_ALIGN((unsigned long)start + size);

