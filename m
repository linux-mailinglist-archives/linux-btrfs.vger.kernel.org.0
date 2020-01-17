Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D591412E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAQV1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34805 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729081AbgAQV1A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579296419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2vnulubJD8mSbDRt53yuy9p1BI2iN8qpqQuvtoRp26c=;
        b=ivmlj8nNlBxGwwJHQU8C/JORg5GLy7wUyKY2MpBcC7vU90EDoXynTGrFeCvrbyTfMIqRN5
        6/jpkTUkM79tRH9CXo1N1SWNDzcTTuOtdAqzNs3KGXZFyjGYTWaZHmP8gDHxcxn8fpUg4P
        o6lXyQeEJd8HK29wxyx9gCt5HOswtQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-EKAgyNHDPSSLzbE8S-KphQ-1; Fri, 17 Jan 2020 16:26:54 -0500
X-MC-Unique: EKAgyNHDPSSLzbE8S-KphQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 004D1DBA6;
        Fri, 17 Jan 2020 21:26:53 +0000 (UTC)
Received: from treble (ovpn-123-54.rdu2.redhat.com [10.10.123.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7556B5D9CD;
        Fri, 17 Jan 2020 21:26:51 +0000 (UTC)
Date:   Fri, 17 Jan 2020 15:26:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20200117212649.opf4lt4w4jgwmrt7@treble>
References: <20191212184725.db3ost7rcopotr5u@treble>
 <b9b0c81b-0ca8-dfb7-958f-cd58a449b6fb@infradead.org>
 <ba2a7a9b-933b-d4e4-8970-85b6c1291fca@infradead.org>
 <20191213235054.6k2lcnwa63r26zwi@treble>
 <c6a33c21-3e71-ac98-cc95-db008764917c@infradead.org>
 <20191214054515.ougsr5ykhl3vvy57@treble>
 <fe1e0318-9b74-7ae0-07bd-d7a6c908e79a@infradead.org>
 <20191217152511.GG3929@suse.cz>
 <20200117172629.yqowxl642hdx4vcm@treble>
 <CANpmjNP6Q5-uOVi5TvbnHKbHkubqrbzW1+QZqvoEVty6X7ZDXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNP6Q5-uOVi5TvbnHKbHkubqrbzW1+QZqvoEVty6X7ZDXw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 09:28:27PM +0100, Marco Elver wrote:
> On Fri, 17 Jan 2020 at 18:26, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Tue, Dec 17, 2019 at 04:25:11PM +0100, David Sterba wrote:
> > > On Fri, Dec 13, 2019 at 11:05:18PM -0800, Randy Dunlap wrote:
> > > > OK, that fixes most of them, but still leaves these 2:
> > > >
> > > > btrfs006.out:fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit()+0x536: unreachable instruction
> > >
> > > Hard to read from the assembly what C statement is it referring to. I
> > > think there are also several functions inlined, I don't see anything
> > > suspicious inside __set_extent_bit itself.
> > >
> > > > btrfs006.out:fs/btrfs/relocation.o: warning: objtool: add_tree_block()+0x501: unreachable instruction
> > >
> > > Probably also heavily inlined, the function has like 50 lines, a few
> > > non-trivial function calls but the offset in the warning suggests a
> > > larger size.
> > >
> > > While browsing the callees I noticed that both have in common a function
> > > that is supposed to print and stop at fatal errors. They're
> > > extent_io_tree_panic (extent_io.c) and backref_tree_panic
> > > (relocation.c). Both call btrfs_panic which is a macro:
> > >
> > > 3239 #define btrfs_panic(fs_info, errno, fmt, args...)                       \
> > > 3240 do {                                                                    \
> > > 3241         __btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args); \
> > > 3242         BUG();                                                          \
> > > 3243 } while (0)
> > >
> > > There are no conditionals and BUG has the __noreturn annotation
> > > (unreachable()) so all is in place and I don't have better ideas what's
> > > causing the reports.
> >
> > I think KCSAN is somehow disabling GCC's detection of implicit noreturn
> > functions -- or at least some calls to them.  So GCC is inserting dead
> > code after the calls.  BUG() uses __builtin_unreachable(), so GCC should
> > know better.
> >
> > If this is specific to KCSAN then I might just disable these warnings
> > for KCSAN configs.
> 
> I noticed that this is also a CC_OPTIMIZE_FOR_SIZE config. I recently
> sent some patches to turn some inlines into __always_inlines because
> CC_OPTIMIZE_FOR_SIZE decides to not inline functions that should
> always be inlined.
> 
> I noticed that 'assfail' is a 'static inline' function and you
> mentioned earlier that GCC seems to not be able to determine if it
> returns or not. If CC_OPTIMIZE_FOR_SIZE decides to not inline, then
> maybe this could be a problem?  It could also be the compiler having
> some trouble here with the CC_OPTIMIZE_FOR_SIZE + KCSAN combination.

Even for a non-inlined static function, GCC typically detects when it's
implicitly "noreturn", and optimizes the call sites accordingly.  And
that has also been true even for CC_OPTIMIZE_FOR_SIZE in the past.  So
something changed apparently.  (KCSAN was just a guess.)

-- 
Josh

