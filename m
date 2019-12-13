Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 443D911EEDB
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 00:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLMXvG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 18:51:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51236 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726623AbfLMXvG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 18:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576281065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x5PAZo0wJg9ltSEENqy1gIgguVq0EPcJb5spZC5EjJE=;
        b=D+2KD7Z/+JDLl0G8qaxLRMYPEN74wab8r86bFJPRXsvrCEWlFR82uut1xeFeUCJN4GjMiH
        9oK+aEwUMmHBdDCRXWkdfRPP5beQdyfmAIZSrDgZQ6cnQQjSF4PlyJgMDFmKAjzHtSLiDb
        Whnw52w1lGfoKDHdSnMuOVrmLUsTySo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-n94zhLJ0P3KzX6ZVYlCO8A-1; Fri, 13 Dec 2019 18:50:59 -0500
X-MC-Unique: n94zhLJ0P3KzX6ZVYlCO8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B0A2107ACC4;
        Fri, 13 Dec 2019 23:50:57 +0000 (UTC)
Received: from treble (ovpn-123-178.rdu2.redhat.com [10.10.123.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D03663BD9;
        Fri, 13 Dec 2019 23:50:56 +0000 (UTC)
Date:   Fri, 13 Dec 2019 17:50:54 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20191213235054.6k2lcnwa63r26zwi@treble>
References: <20191206135406.563336e7@canb.auug.org.au>
 <cd4091e4-1c04-a880-f239-00bc053f46a2@infradead.org>
 <20191211134929.GL3929@twin.jikos.cz>
 <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
 <20191212184725.db3ost7rcopotr5u@treble>
 <b9b0c81b-0ca8-dfb7-958f-cd58a449b6fb@infradead.org>
 <ba2a7a9b-933b-d4e4-8970-85b6c1291fca@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba2a7a9b-933b-d4e4-8970-85b6c1291fca@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 03:03:11PM -0800, Randy Dunlap wrote:
> On 12/12/19 12:25 PM, Randy Dunlap wrote:
> > On 12/12/19 10:47 AM, Josh Poimboeuf wrote:
> >> On Wed, Dec 11, 2019 at 08:21:38AM -0800, Randy Dunlap wrote:
> >>> [oops, forgot to add Josh and PeterZ]
> >>>
> >>> On 12/11/19 5:49 AM, David Sterba wrote:
> >>>> On Fri, Dec 06, 2019 at 08:17:30AM -0800, Randy Dunlap wrote:
> >>>>> On 12/5/19 6:54 PM, Stephen Rothwell wrote:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> Please do not add any material for v5.6 to your linux-next included
> >>>>>> trees until after v5.5-rc1 has been released.
> >>>>>>
> >>>>>> Changes since 20191204:
> >>>>>>
> >>>>>
> >>>>> on x86_64:
> >>>>>
> >>>>> fs/btrfs/ctree.o: warning: objtool: btrfs_search_slot()+0x2d4: unreachable instruction
> >>>>
> >>>> Can somebody enlighten me what is one supposed to do to address the
> >>>> warnings? Function names reported in the list contain our ASSERT macro
> >>>> that conditionally calls BUG() that I believe is what could cause the
> >>>> unreachable instructions but I don't see how.
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/ctree.h#n3113
> >>>>
> >>>> __cold
> >>>> static inline void assfail(const char *expr, const char *file, int line)
> >>>> {
> >>>> 	if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
> >>>> 		pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
> >>>> 		BUG();
> >>>> 	}
> >>>> }
> >>>>
> >>>> #define ASSERT(expr)	\
> >>>> 	(likely(expr) ? (void)0 : assfail(#expr, __FILE__, __LINE__))
> >>>>
> >>
> >> Randy, can you share one of the btrfs .o files?  I'm not able to
> >> recreate.
> >>
> > 
> > Hm. I'll have to try to recreate this. I no longer have files from 20191206
> > (lack of space).
> > 
> > I'll let you know if/when I can recreate it.
> 
> OK, 40 builds later, I have reproduced it.
> 
> I am attaching one of the btrfs .o files and the kernel config file (FTR).
> (gzipped)
> Let me know if you want more of the .o files.

Thanks.  This is arguably a compiler bug, but the below produces better
code generation by adding a noreturn annotation.  I think GCC gets
tripped up by the IS_ENABLED conditional and can't always tell that
assfail (sic) doesn't return.

BTW, I'm on my way out the door for a week of much-needed PTO but I can
handle this patch (and several others I have pending which were reported
by you) when I get back.

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e8fd8a8e59..bbd68520f5f1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3110,14 +3110,16 @@ do {								\
 	rcu_read_unlock();					\
 } while (0)
 
-__cold
+#ifdef CONFIG_BTRFS_ASSERT
+__cold __unlikely
 static inline void assfail(const char *expr, const char *file, int line)
 {
-	if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
-		pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
-		BUG();
-	}
+	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
+	BUG();
 }
+#else
+static inline void assfail(const char *expr, const char *file, int line) {}
+#endif
 
 #define ASSERT(expr)	\
 	(likely(expr) ? (void)0 : assfail(#expr, __FILE__, __LINE__))

