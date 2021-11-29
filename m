Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE88C462097
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 20:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345067AbhK2ThP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 14:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347496AbhK2TfO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 14:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638214316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yaRvpoInOnEEHMP7nyqwnXQsh6SAlooVZxGGKWanykI=;
        b=g3ysvnMWMSLafJrQ7CpXnsCzTsfuzBBOdlwYROYS9WlO4WAq3UWd/I/b4fyCra5SUkAhs8
        r+kXVgyWxNsNh6cZqyddTBFEs/uCLKR6HmIKhVQBve0YEcmh9wQDC2gewIT2EcUOVDPTdL
        wWnn8bYtqVG/VwWVXKBVjiIbVTgvBN0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478--M0PDbNGMk2wsS3ud5yWbw-1; Mon, 29 Nov 2021 14:31:52 -0500
X-MC-Unique: -M0PDbNGMk2wsS3ud5yWbw-1
Received: by mail-wr1-f72.google.com with SMTP id q17-20020adff791000000b00183e734ba48so3128258wrp.8
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 11:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yaRvpoInOnEEHMP7nyqwnXQsh6SAlooVZxGGKWanykI=;
        b=AbLeWkNg0ZhiY9cVrj65aHur9n1bmXA72KPdT5GQ408QWQcs2/QcbtGJSUtkcXVJ4P
         tp1rJCBwIAFvApwrfZGxHfJfAjAjCsldG+XBfHjr51gG1SmirQS+2oX/XTOD4299/1qu
         /rCIK14ytg+55CApyHGS7GeAzwO7g0VEcxRWFEUVxhe0i726Gszx96Njispmm+fwfap8
         gKT8Wj4UU7OTL9DkwC/DMWJGiJvMtUVtpFk38bfxQ+ITJjTWfWyaJAgU8CRQ4hDnZ3g2
         qcHI4+SaEdRjyDgydrk7d0wREi8cTcDJssiRkcdc+kmVof1dKv4ka4+oahljjILW6xzM
         rw4w==
X-Gm-Message-State: AOAM533y3wYX+wa4XsLN0mTk+2FnN7fBjfmovJ9Az6OPUqQl9W9GYuSG
        x13mX5dt3SM4lQPAVZIM5rNgfjuOItgI0VLjs41gwNv9dCoPG3pqe3Cw8/x1OQvJ718u4xBri+i
        y70cjwJOKxgY9ErW/gJ0eJoX+i9OHCKqZm94ofa4=
X-Received: by 2002:adf:f749:: with SMTP id z9mr36910289wrp.379.1638214311587;
        Mon, 29 Nov 2021 11:31:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSv2WybHRedA4NST/0L7m41HCQb6LRVF5wHW9P5FzzrZgkSDOaniNFjz8BjqBW06bNnR5BfRT4OlQsVo6M068=
X-Received: by 2002:adf:f749:: with SMTP id z9mr36910269wrp.379.1638214311399;
 Mon, 29 Nov 2021 11:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com> <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com> <YaJM4n31gDeVzUGA@arm.com>
 <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com>
 <YaTEkAahkCwuQdPN@arm.com> <CAHc6FU6zVi9A2D3V3T5zE71YAdkBiJTs0ao1Q6ysSuEp=bz8fQ@mail.gmail.com>
 <YaTziROgnFwB6Ddj@arm.com> <CAHk-=wiZgAgcynfLsop+D1xBUAZ-Z+NUBxe9mb-AedecFRNm+w@mail.gmail.com>
In-Reply-To: <CAHk-=wiZgAgcynfLsop+D1xBUAZ-Z+NUBxe9mb-AedecFRNm+w@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 29 Nov 2021 20:31:39 +0100
Message-ID: <CAHc6FU4bdwTo72d-ULdW=9vxH09qW1Z+_6ksZrkefuXEtLSOkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 7:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Nov 29, 2021 at 7:36 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > That's what this series does when it probes the whole range in
> > fault_in_writeable(). The main reason was that it's more efficient to do
> > a read than a write on a large range (the latter dirtying the cache
> > lines).
>
> The more this thread goes on, the more I'm starting to think that we
> should just make "fault_in_writable()" (and readable, of course) only
> really work on the beginning of the area.
>
> Not just for the finer-granularity pointer color probing, but for the
> page probing too.
>
> I'm looking at our current fault_in_writeable(), and I'm going
>
>  (a) it uses __put_user() without range checks, which is really not great
>
>  (b) it looks like a disaster from another standpoint: essentially
> user-controlled loop size with no limit checking, no preemption, and
> no check for fatal signals.
>
> Now, (a) should be fixed with a access_ok() or similar.
>
> And (b) can easily be fixed multiple ways, with one option simply just
> being adding a can_resched() call and checking for fatal signals.
>
> But faulting in the whole region is actually fundamentally wrong in
> low-memory situations - the beginning of the region might be swapped
> out by the time we get to the end. That's unlikely to be a problem in
> real life, but it's an example of how it's simply not conceptually
> sensible.
>
> So I do wonder why we don't just say "fault_in_writable will fault in
> _at_most_ X bytes", and simply limit the actual fault-in size to
> something reasonable.
>
> That solves _all_ the problems. It solves the lack of preemption and
> fatal signals (by virtue of just limiting the amount of work we do).
> It solves the low memory situation. And it solves the "excessive dirty
> cachelines" case too.
>
> Of course, we want to have some minimum bytes we fault in too, but
> that minimum range might well be "we guarantee at least a full page
> worth of data" (and in practice make it a couple of pages).
>
> It's not like fault_in_writeable() avoids page faults or anything like
> that - it just moves them around. So there's really very little reason
> to fault in a large range, and there are multiple reasons _not_ to do
> it.
>
> Hmm?

This would mean that we could get rid of gfs2's
should_fault_in_pages() logic, which is based on what's in
btrfs_buffered_write().

Andreas

>
>                Linus
>

