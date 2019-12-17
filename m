Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F1B123038
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfLQPZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:25:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:42974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfLQPZP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:25:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42562AC5F;
        Tue, 17 Dec 2019 15:25:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F254DA81D; Tue, 17 Dec 2019 16:25:11 +0100 (CET)
Date:   Tue, 17 Dec 2019 16:25:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20191217152511.GG3929@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <cd4091e4-1c04-a880-f239-00bc053f46a2@infradead.org>
 <20191211134929.GL3929@twin.jikos.cz>
 <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
 <20191212184725.db3ost7rcopotr5u@treble>
 <b9b0c81b-0ca8-dfb7-958f-cd58a449b6fb@infradead.org>
 <ba2a7a9b-933b-d4e4-8970-85b6c1291fca@infradead.org>
 <20191213235054.6k2lcnwa63r26zwi@treble>
 <c6a33c21-3e71-ac98-cc95-db008764917c@infradead.org>
 <20191214054515.ougsr5ykhl3vvy57@treble>
 <fe1e0318-9b74-7ae0-07bd-d7a6c908e79a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1e0318-9b74-7ae0-07bd-d7a6c908e79a@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 11:05:18PM -0800, Randy Dunlap wrote:
> OK, that fixes most of them, but still leaves these 2:
> 
> btrfs006.out:fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit()+0x536: unreachable instruction

Hard to read from the assembly what C statement is it referring to. I
think there are also several functions inlined, I don't see anything
suspicious inside __set_extent_bit itself.

> btrfs006.out:fs/btrfs/relocation.o: warning: objtool: add_tree_block()+0x501: unreachable instruction

Probably also heavily inlined, the function has like 50 lines, a few
non-trivial function calls but the offset in the warning suggests a
larger size.

While browsing the callees I noticed that both have in common a function
that is supposed to print and stop at fatal errors. They're
extent_io_tree_panic (extent_io.c) and backref_tree_panic
(relocation.c). Both call btrfs_panic which is a macro:

3239 #define btrfs_panic(fs_info, errno, fmt, args...)                       \
3240 do {                                                                    \
3241         __btrfs_panic(fs_info, __func__, __LINE__, errno, fmt, ##args); \
3242         BUG();                                                          \
3243 } while (0)

There are no conditionals and BUG has the __noreturn annotation
(unreachable()) so all is in place and I don't have better ideas what's
causing the reports.
