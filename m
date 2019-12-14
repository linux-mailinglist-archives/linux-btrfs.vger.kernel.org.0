Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7011F06C
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 06:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfLNFpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Dec 2019 00:45:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23816 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbfLNFpX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Dec 2019 00:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576302321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMoyw7B5Pg5yQ9QR7aJ058W9/8V7Fq7avIzK4TkKuto=;
        b=XsxT2zrYCd+our2E4bwUlI7kK8Ng1S9o3JrMQvkwlmPXmDh6nrJFfnvKDXf45VQHj8igyN
        sGBro0PKBafRn0uqxxmbbykw15HjlYMHt2ag2oOG3WGTj8aMqzPigk0RqyoZIxDzcLr3rt
        6usVvyNBSiMtltMfz//Db7utu94Ji1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-Pc9bSVpXPkSN5mt7IhrOJA-1; Sat, 14 Dec 2019 00:45:20 -0500
X-MC-Unique: Pc9bSVpXPkSN5mt7IhrOJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB8DB107ACC7;
        Sat, 14 Dec 2019 05:45:18 +0000 (UTC)
Received: from treble (ovpn-123-178.rdu2.redhat.com [10.10.123.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87F5063BCD;
        Sat, 14 Dec 2019 05:45:17 +0000 (UTC)
Date:   Fri, 13 Dec 2019 23:45:15 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20191214054515.ougsr5ykhl3vvy57@treble>
References: <20191206135406.563336e7@canb.auug.org.au>
 <cd4091e4-1c04-a880-f239-00bc053f46a2@infradead.org>
 <20191211134929.GL3929@twin.jikos.cz>
 <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
 <20191212184725.db3ost7rcopotr5u@treble>
 <b9b0c81b-0ca8-dfb7-958f-cd58a449b6fb@infradead.org>
 <ba2a7a9b-933b-d4e4-8970-85b6c1291fca@infradead.org>
 <20191213235054.6k2lcnwa63r26zwi@treble>
 <c6a33c21-3e71-ac98-cc95-db008764917c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6a33c21-3e71-ac98-cc95-db008764917c@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 04:04:58PM -0800, Randy Dunlap wrote:
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index b2e8fd8a8e59..bbd68520f5f1 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3110,14 +3110,16 @@ do {								\
> >  	rcu_read_unlock();					\
> >  } while (0)
> >  
> > -__cold
> > +#ifdef CONFIG_BTRFS_ASSERT
> > +__cold __unlikely
> 
> what provides __unlikely?  It is causing build errors.
> 
> and if I remove the "__unlikely", I still see the objtool warnings
> (unreachable instructions).

Ha, not sure how that happened... Should be __noreturn instead of
__unlikely.  Cheers...

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e8fd8a8e59..398bd010dfc5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3110,14 +3110,16 @@ do {								\
 	rcu_read_unlock();					\
 } while (0)
 
-__cold
+#ifdef CONFIG_BTRFS_ASSERT
+__cold __noreturn
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

