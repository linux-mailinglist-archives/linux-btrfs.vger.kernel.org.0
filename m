Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8668113776D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 20:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgAJTqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 14:46:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:49252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgAJTqi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 14:46:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E6526AAC2;
        Fri, 10 Jan 2020 19:46:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10A02DA78B; Fri, 10 Jan 2020 20:46:22 +0100 (CET)
Date:   Fri, 10 Jan 2020 20:46:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20200110194622.GS3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
 <20191217152954.GH3929@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217152954.GH3929@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 17, 2019 at 04:29:54PM +0100, David Sterba wrote:
> Separating the definitions by #ifdef looks ok, I'd rather do separate
> definitions of ASSERT too, to avoid the ternary operator. I'll send the
> patch.

Subject: [PATCH] btrfs: separate definition of assertion failure handlers

There's a report where objtool detects unreachable instructions, eg.:

  fs/btrfs/ctree.o: warning: objtool: btrfs_search_slot()+0x2d4: unreachable instruction

This seems to be a false positive due to compiler version. The cause is
in the ASSERT macro implementation that does the conditional check as
IS_DEFINED(CONFIG_BTRFS_ASSERT) and not an #ifdef.

To avoid that, use the ifdefs directly.

CC: Josh Poimboeuf <jpoimboe@redhat.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 569931dd0ce5..f90b82050d2d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3157,17 +3157,21 @@ do {								\
 	rcu_read_unlock();					\
 } while (0)
 
-__cold
-static inline void assfail(const char *expr, const char *file, int line)
+#ifdef CONFIG_BTRFS_ASSERT
+__cold __noreturn
+static inline void assertfail(const char *expr, const char *file, int line)
 {
-	if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
-		pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
-		BUG();
-	}
+	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
+	BUG();
 }
 
-#define ASSERT(expr)	\
-	(likely(expr) ? (void)0 : assfail(#expr, __FILE__, __LINE__))
+#define ASSERT(expr)						\
+	(likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
+
+#else
+static inline void assertfail(const char *expr, const char* file, int line) { }
+#define ASSERT(expr)	(void)(expr)
+#endif
 
 /*
  * Use that for functions that are conditionally exported for sanity tests but
-- 
