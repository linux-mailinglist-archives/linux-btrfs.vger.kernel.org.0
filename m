Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC37450DE7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiDYLMD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 07:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbiDYLLz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 07:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F788CF1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 04:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650884926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mVcdSe0PHoJRh6aQ4K1v60KgaaEyFYrz6ExO46haELU=;
        b=BLlzht4r7IrB+bTz7VCL3JoOcVNpbCbrjrgYQdnSvciiteiRpSaBvrS/6nlr2mOh2YY77b
        SHmBTi2Wn0heV2M9pRGFGqy6Zhbt49JDT4YIlrj7BenW6mESHQnvL9t8tm4ny7m6g7g5nh
        XGKApaBWJOGK/+4ZsRuKDzSQHD1Zlyg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-MI9zUrEcOdqi-KXzRVYupA-1; Mon, 25 Apr 2022 07:08:45 -0400
X-MC-Unique: MI9zUrEcOdqi-KXzRVYupA-1
Received: by mail-wm1-f70.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so7034677wmb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 04:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVcdSe0PHoJRh6aQ4K1v60KgaaEyFYrz6ExO46haELU=;
        b=4A+O+Zx0m3OLyqnPcLaPmx+/M8DMbzi9v04cRWMAEiK3iH9wLMdhOrLBNISr9Q7s04
         LACmVDkkt3mgtJ/5rL6W75G4rm7N6nJz8AmVMzZPVie5iD9NBGJOiritD18WWgr4XdmX
         r8wbmqtPZyQkey25Vii+dXPb37vdIfNw5thqC1d288bNjcSvcHCeQ4aMEOBzp2BGlHx5
         Ev+MVyOvaVbXmyYjcS/ofrlUu+386NaXn9LPmTBZih/nLJBF+s4Ld4h7h5ASvvMoqOf8
         TuGmBM79QK2g4gZcJwALWQVwU0p7DXGmJ8UQzpV51JbKIs0EzGZ7T3GpqgvjI0i5e+42
         +sYQ==
X-Gm-Message-State: AOAM533YhjMJY2yqddBrsgLHt2RqoK5YjLCGgUTBxeVPiGh/Nn5oe7l1
        huhL54ZCGQCNpy4TrmNmlAVtVYmjhJTY82nGFwNQ3GegV7AQ3z2tCw+/zjxPLquvcJc5cdT6acT
        TbTgXpTebwKREhM+O/Tbjim0E2/uo7NkXL0qfoE0=
X-Received: by 2002:a7b:c190:0:b0:38e:7e47:744a with SMTP id y16-20020a7bc190000000b0038e7e47744amr15998344wmi.38.1650884923466;
        Mon, 25 Apr 2022 04:08:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDKLmIMrpvfVqSfQXeOM3IZoY6CJIygyQmTkeybfTwkSGNSamWbKhJrjBUyM9EjD7/gvQBEZBvI8Q4SN2rjNQ=
X-Received: by 2002:a7b:c190:0:b0:38e:7e47:744a with SMTP id
 y16-20020a7bc190000000b0038e7e47744amr15998315wmi.38.1650884923163; Mon, 25
 Apr 2022 04:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220423100751.1870771-1-catalin.marinas@arm.com>
 <CAHk-=wgafGgBC9JEu397YxFD8o8qiCZHQS+f5i+BSXOkOFqX3w@mail.gmail.com> <YmRIKJSr0xSRHliN@arm.com>
In-Reply-To: <YmRIKJSr0xSRHliN@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 25 Apr 2022 13:08:32 +0200
Message-ID: <CAHc6FU5Sm6jR-NM5t7qEEHs3z42BzLHgZ5FG-kjg5VjUwXJjNQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Avoid live-lock in btrfs fault-in+uaccess loop
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Catalin,

On Sat, Apr 23, 2022 at 8:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Sat, Apr 23, 2022 at 09:35:42AM -0700, Linus Torvalds wrote:
> > On Sat, Apr 23, 2022 at 3:07 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > The series introduces fault_in_subpage_writeable() together with the
> > > arm64 probing counterpart and the btrfs fix.
> >
> > Looks fine to me - and I think it can probably go through the arm64
> > tree since you'd be the only one really testing it anyway.
>
> I'll queue it via arm64 then.

sounds good to me, thank you.

> > I assume you checked that btrfs is the only one that uses
> > fault_in_writeable() in this way? Everybody else updates to the right
> > byte boundary and retries (or returns immediately)?
>
> I couldn't find any other places (by inspection or testing). The
> buffered file I/O can already make progress in current fault_in_*() +
> copy_*_user() loops.

This started working correctly with commit bc1bb416bbb9
("generic_perform_write()/iomap_write_actor(): saner logics for short
copy") by Al from last May.

> O_DIRECT either goes via GUP (and memcpy() doesn't
> fault) or, if the user buffer is not PAGE aligned, it may fall back to
> buffered I/O. That's why I simplified the series, AFAICT it's only btrfs
> search_ioctl() with this problem.

Thanks,
Andreas

