Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED81645E2AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 22:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351128AbhKYVqU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 16:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239140AbhKYVoU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 16:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637876468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zy1D3BcfbmTkQAKQ8xyKaO+OdCXbfXv9jg1mQpYzJQU=;
        b=eFdPVysPfUn6i2C6KFj1OdMDjxV9inm+/XgxWjR+rJuD4zKCxxiQrz/4OWfJNwsp2Rli8s
        Tm8CMU0vX5KT8wWL6fywzDKk90Ja/EPuLF+g2HR/ToKfint9cWFC6a3KwIkZ+0jflUV1zL
        eM8OCBMwzGzM5TNrp7Uxojnr++OVJhI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-U7_2dZIyOQq7J4Yv4BcQNw-1; Thu, 25 Nov 2021 16:41:07 -0500
X-MC-Unique: U7_2dZIyOQq7J4Yv4BcQNw-1
Received: by mail-wm1-f69.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso4182949wms.0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Nov 2021 13:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zy1D3BcfbmTkQAKQ8xyKaO+OdCXbfXv9jg1mQpYzJQU=;
        b=SZdq+92NtKU5p39PEHMpqMsWKvpEah1LCJS0OEKf7lsqSLraAvnJQAJ6aGAyvrb9bf
         BrkY40bCeMQVu2MXyxxErPl6WPUO/+WuX1AFy84dS4CSMmpk8c7ZnYigQ/onYrNgTRKd
         U10YkkTrVpIJuVsZ9Isa50YBKC6moMg507vEeRhmhAmLYnAjHHzybXja6tHk9maJ7STo
         3+MI0FBizxIwgrm6/hFqa2/RyIfxyiMXwfZAkqiuODGUSxXyjzOcY1AmFRw1oXDZDMWi
         dYNvwKnhENgSG39ICuQwVsvJBh7B3AKZc9YCKGQVV9Lyy/Kijz+PHJnyAMTD0FabTyV/
         0V4w==
X-Gm-Message-State: AOAM533e+zYdi4o/xvy3cK/s6TbhMhv5jQ5MfEKSDc6MxtIWaVN3WLwa
        kj/oRXVv7zQga4w8BssElgrqZDXx8y6hKO+sKnSI6+MV1CG7rM0Q0+3hzHjWRfkhQa2Z4sLm5sT
        6e2GvxP2qlCjGWG6iQY4ciHw2VlFW+xQrAkSN73c=
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr11407736wmb.14.1637876465786;
        Thu, 25 Nov 2021 13:41:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBOJN0sKvw/32yrofU9l5xWSU9km9NEYBCalXaAIBq9JyTlz4/gcW6rG7s0RNEsFbdNvJaMjB37Li1S3SYJcE=
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr11407713wmb.14.1637876465617;
 Thu, 25 Nov 2021 13:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com>
 <YZ9vM91Uj8g36VQC@arm.com> <CAHk-=wgUn1vBReeNcZNEObkxPQGhN5EUq5MC94cwF0FaQvd2rQ@mail.gmail.com>
 <YZ/1jflaSjgRRl2o@arm.com> <YZ/55fYE0l7ewo/t@casper.infradead.org>
In-Reply-To: <YZ/55fYE0l7ewo/t@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 25 Nov 2021 22:40:54 +0100
Message-ID: <CAHc6FU6zwmwK3fEaDY_-Qxn2+PA8pnwXUPRKRZ=SGd_6RbKoQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 25, 2021 at 10:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Nov 25, 2021 at 08:43:57PM +0000, Catalin Marinas wrote:
> > > I really believe that the fix is to make the read/write probing just
> > > be more aggressive.
> > >
> > > Make the read/write probing require that AT LEAST <n> bytes be
> > > readable/writable at the beginning, where 'n' is 'min(len,ALIGN)', and
> > > ALIGN is whatever size that copy_from/to_user_xyz() might require just
> > > because it might do multi-byte accesses.
> > >
> > > In fact, make ALIGN be perhaps something reasonable like 512 bytes or
> > > whatever, and then you know you can handle the btrfs "copy a whole
> > > structure and reset if that fails" case too.
> >
> > IIUC what you are suggesting, we still need changes to the btrfs loop
> > similar to willy's but that should work fine together with a slightly
> > more aggressive fault_in_writable().
> >
> > A probing of at least sizeof(struct btrfs_ioctl_search_key) should
> > suffice without any loop changes and 512 would cover it but it doesn't
> > look generic enough. We could pass a 'probe_prefix' argument to
> > fault_in_exact_writeable() to only probe this and btrfs would just
> > specify the above sizeof().
>
> How about something like this?
>
> +++ b/mm/gup.c
> @@ -1672,6 +1672,13 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
>
>         if (unlikely(size == 0))
>                 return 0;
> +       if (SUBPAGE_PROBE_INTERVAL) {
> +               while (uaddr < PAGE_ALIGN((unsigned long)uaddr)) {
> +                       if (unlikely(__put_user(0, uaddr) != 0))
> +                               goto out;
> +                       uaddr += SUBPAGE_PROBE_INTERVAL;
> +               }
> +       }
>         if (!PAGE_ALIGNED(uaddr)) {
>                 if (unlikely(__put_user(0, uaddr) != 0))
>                         return size;
>
> ARM then defines SUBPAGE_PROBE_INTERVAL to be 16 and the rest of us
> leave it as 0.  That way we probe all the way to the end of the current
> page and the start of the next page.
>
> Oh, that needs to be checked to not exceed size as well ... anyway,
> you get the idea.

Note that we don't need this additional probing when accessing the
buffer with byte granularity. That's probably the common case.

Andreas

