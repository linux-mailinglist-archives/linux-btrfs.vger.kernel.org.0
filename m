Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469CF140FD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAQR0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 12:26:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22048 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726761AbgAQR0i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 12:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579281997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lK3eediDWtVCh47lizBT55QqgySEaj52x7m9+e9sBh8=;
        b=MUHlwK7x3pDWRrFJ+w28AThNDP4L3QgWfiatEmGRNIrxq/3vHD7b6wcHsK0MqIymX3xNsP
        4Wa6ALd63esbOzyy5va85AQZ7mnw8slfDsp0KIXxGDtnidbD8zE8lgxgpA5BCEkQ8gEkH4
        61LhXjKB+uvyPEtyUlTX47W+ddBLg94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-4Q0abMuQNvWwEwjouYkmuQ-1; Fri, 17 Jan 2020 12:26:34 -0500
X-MC-Unique: 4Q0abMuQNvWwEwjouYkmuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D0B8DB20;
        Fri, 17 Jan 2020 17:26:32 +0000 (UTC)
Received: from treble (ovpn-123-54.rdu2.redhat.com [10.10.123.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1906C9A84;
        Fri, 17 Jan 2020 17:26:31 +0000 (UTC)
Date:   Fri, 17 Jan 2020 11:26:29 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20200117172629.yqowxl642hdx4vcm@treble>
References: <20191211134929.GL3929@twin.jikos.cz>
 <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
 <20191212184725.db3ost7rcopotr5u@treble>
 <b9b0c81b-0ca8-dfb7-958f-cd58a449b6fb@infradead.org>
 <ba2a7a9b-933b-d4e4-8970-85b6c1291fca@infradead.org>
 <20191213235054.6k2lcnwa63r26zwi@treble>
 <c6a33c21-3e71-ac98-cc95-db008764917c@infradead.org>
 <20191214054515.ougsr5ykhl3vvy57@treble>
 <fe1e0318-9b74-7ae0-07bd-d7a6c908e79a@infradead.org>
 <20191217152511.GG3929@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217152511.GG3929@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 17, 2019 at 04:25:11PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 11:05:18PM -0800, Randy Dunlap wrote:
> > OK, that fixes most of them, but still leaves these 2:
> > 
> > btrfs006.out:fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit()+0x536: unreachable instruction
> 
> Hard to read from the assembly what C statement is it referring to. I
> think there are also several functions inlined, I don't see anything
> suspicious inside __set_extent_bit itself.
> 
> > btrfs006.out:fs/btrfs/relocation.o: warning: objtool: add_tree_block()+0x501: unreachable instruction
> 
> Probably also heavily inlined, the function has like 50 lines, a few
> non-trivial function calls but the offset in the warning suggests a
> larger size.
> 
> While browsing the callees I noticed that both have in common a function
> that is supposed to print and stop at fatal errors. They're
> extent_io_tree_panic (extent_io.c) and backref_tree_panic
> (relocation.c). Both call btrfs_panic which is a macro:
> 
> 3239 #define btrfs_panic(fs_info, errno, fmt, args...)                       \
> 3240 do {                                                                    \
> 3241         __btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args); \
> 3242         BUG();                                                          \
> 3243 } while (0)
> 
> There are no conditionals and BUG has the __noreturn annotation
> (unreachable()) so all is in place and I don't have better ideas what's
> causing the reports.

I think KCSAN is somehow disabling GCC's detection of implicit noreturn
functions -- or at least some calls to them.  So GCC is inserting dead
code after the calls.  BUG() uses __builtin_unreachable(), so GCC should
know better.

If this is specific to KCSAN then I might just disable these warnings
for KCSAN configs.

-- 
Josh

