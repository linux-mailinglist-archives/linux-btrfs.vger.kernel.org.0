Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF53C14124F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 21:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgAQU2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 15:28:41 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41945 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQU2k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 15:28:40 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so23329564oie.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 12:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifSeHTLkCJ+s/M6PHGLFtjMc8/13EXrvf1VQ6xzIHv8=;
        b=Khu9MGHAeMc+f/Ccjs0+v4wGnJKK2Z6PQc1oe4VV0Lzhkv54hce0mRhMS3l49+DV0t
         t8UaAU1C6AIN7/hUHEMoR7sNo2vFN4rglpmsl68LrMAFnbdFSdSCDvLU1nJ12hZGeB0e
         JHmAso6A0vCTkHzPr8V38f3ERv0HhYLuY7+ZaJyUDw5GwkZJpq0ug43yvrebYyUk0cM4
         1TeLxBNfKevgEWGvO4KzffVyhmffdPA2ePUw4v70zsVgN256N6lUi3ZofwaTMd9fdalL
         w2FcgMuKo+vehA/hnswupcCCMv5AnaoK9eNn10xV/NxWm84gDKxT4w2sOmlJ00OdzK1w
         ObUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifSeHTLkCJ+s/M6PHGLFtjMc8/13EXrvf1VQ6xzIHv8=;
        b=UcSmBvQxLn+mfleKcR0s+Fs2UlSTU17RXDHsBG+1LSYGA7He2hNryhpEU/+maIGCKK
         55Qvp/1CcQG5pXswBA5c07EBW8HetMKNgelcub22UQHqjBcaq+ctUR6hwkbb8abQHIXU
         ifr3Bx0ezEuFr7DO8fPAemqAXnnUUHBNkBNSftaOEVXT5y4sw3jSmaBbBpvgNhOFoNUo
         IxKvf93ssuSl+lPDPoiUR3tYBGI+BU+qgKEB/PYakeVOUX5gaJt8k+B3b9QBoThivNBE
         hIG0tscO4bgdjy02wkegAg4+nqsHInPAExfaqBGwzpQPstGSU50MiphbBUlLV+MdQkMe
         4Ltw==
X-Gm-Message-State: APjAAAXrL0y3QXmHqxh7B1Au6/rnl8+IH+P8ZO+X8gBIpdWILcglN7Pj
        oMYzkYRmPX8TSxlqId/7eoj/uFA1UK2wPQLQf7bCuw==
X-Google-Smtp-Source: APXvYqxm76D4pmOXCLLR7qo5PjZO5/+ATidP3kWVQcuIiQ2VkNvyYB5a8Gpt7ldvW0lYUM4qljGG9FJh1otZ7lpNNjY=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr4832137oig.172.1579292919605;
 Fri, 17 Jan 2020 12:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20191211134929.GL3929@twin.jikos.cz> <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
 <20191212184725.db3ost7rcopotr5u@treble> <b9b0c81b-0ca8-dfb7-958f-cd58a449b6fb@infradead.org>
 <ba2a7a9b-933b-d4e4-8970-85b6c1291fca@infradead.org> <20191213235054.6k2lcnwa63r26zwi@treble>
 <c6a33c21-3e71-ac98-cc95-db008764917c@infradead.org> <20191214054515.ougsr5ykhl3vvy57@treble>
 <fe1e0318-9b74-7ae0-07bd-d7a6c908e79a@infradead.org> <20191217152511.GG3929@suse.cz>
 <20200117172629.yqowxl642hdx4vcm@treble>
In-Reply-To: <20200117172629.yqowxl642hdx4vcm@treble>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Jan 2020 21:28:27 +0100
Message-ID: <CANpmjNP6Q5-uOVi5TvbnHKbHkubqrbzW1+QZqvoEVty6X7ZDXw@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 17 Jan 2020 at 18:26, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Dec 17, 2019 at 04:25:11PM +0100, David Sterba wrote:
> > On Fri, Dec 13, 2019 at 11:05:18PM -0800, Randy Dunlap wrote:
> > > OK, that fixes most of them, but still leaves these 2:
> > >
> > > btrfs006.out:fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit()+0x536: unreachable instruction
> >
> > Hard to read from the assembly what C statement is it referring to. I
> > think there are also several functions inlined, I don't see anything
> > suspicious inside __set_extent_bit itself.
> >
> > > btrfs006.out:fs/btrfs/relocation.o: warning: objtool: add_tree_block()+0x501: unreachable instruction
> >
> > Probably also heavily inlined, the function has like 50 lines, a few
> > non-trivial function calls but the offset in the warning suggests a
> > larger size.
> >
> > While browsing the callees I noticed that both have in common a function
> > that is supposed to print and stop at fatal errors. They're
> > extent_io_tree_panic (extent_io.c) and backref_tree_panic
> > (relocation.c). Both call btrfs_panic which is a macro:
> >
> > 3239 #define btrfs_panic(fs_info, errno, fmt, args...)                       \
> > 3240 do {                                                                    \
> > 3241         __btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args); \
> > 3242         BUG();                                                          \
> > 3243 } while (0)
> >
> > There are no conditionals and BUG has the __noreturn annotation
> > (unreachable()) so all is in place and I don't have better ideas what's
> > causing the reports.
>
> I think KCSAN is somehow disabling GCC's detection of implicit noreturn
> functions -- or at least some calls to them.  So GCC is inserting dead
> code after the calls.  BUG() uses __builtin_unreachable(), so GCC should
> know better.
>
> If this is specific to KCSAN then I might just disable these warnings
> for KCSAN configs.

I noticed that this is also a CC_OPTIMIZE_FOR_SIZE config. I recently
sent some patches to turn some inlines into __always_inlines because
CC_OPTIMIZE_FOR_SIZE decides to not inline functions that should
always be inlined.

I noticed that 'assfail' is a 'static inline' function and you
mentioned earlier that GCC seems to not be able to determine if it
returns or not. If CC_OPTIMIZE_FOR_SIZE decides to not inline, then
maybe this could be a problem?  It could also be the compiler having
some trouble here with the CC_OPTIMIZE_FOR_SIZE + KCSAN combination.

Thanks,
-- Marco
