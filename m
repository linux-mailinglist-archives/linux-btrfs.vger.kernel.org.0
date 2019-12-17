Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF95123050
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfLQP37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:29:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:45458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbfLQP36 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:29:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76D82AE8C;
        Tue, 17 Dec 2019 15:29:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D8D8FDA81D; Tue, 17 Dec 2019 16:29:54 +0100 (CET)
Date:   Tue, 17 Dec 2019 16:29:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20191217152954.GH3929@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20191206135406.563336e7@canb.auug.org.au>
 <cd4091e4-1c04-a880-f239-00bc053f46a2@infradead.org>
 <20191211134929.GL3929@twin.jikos.cz>
 <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
 <20191212184725.db3ost7rcopotr5u@treble>
 <b9b0c81b-0ca8-dfb7-958f-cd58a449b6fb@infradead.org>
 <ba2a7a9b-933b-d4e4-8970-85b6c1291fca@infradead.org>
 <20191213235054.6k2lcnwa63r26zwi@treble>
 <c6a33c21-3e71-ac98-cc95-db008764917c@infradead.org>
 <20191214054515.ougsr5ykhl3vvy57@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214054515.ougsr5ykhl3vvy57@treble>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 11:45:15PM -0600, Josh Poimboeuf wrote:
> On Fri, Dec 13, 2019 at 04:04:58PM -0800, Randy Dunlap wrote:
> > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > index b2e8fd8a8e59..bbd68520f5f1 100644
> > > --- a/fs/btrfs/ctree.h
> > > +++ b/fs/btrfs/ctree.h
> > > @@ -3110,14 +3110,16 @@ do {								\
> > >  	rcu_read_unlock();					\
> > >  } while (0)
> > >  
> > > -__cold
> > > +#ifdef CONFIG_BTRFS_ASSERT
> > > +__cold __unlikely
> > 
> > what provides __unlikely?  It is causing build errors.
> > 
> > and if I remove the "__unlikely", I still see the objtool warnings
> > (unreachable instructions).
> 
> Ha, not sure how that happened... Should be __noreturn instead of
> __unlikely.  Cheers...
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b2e8fd8a8e59..398bd010dfc5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3110,14 +3110,16 @@ do {								\
>  	rcu_read_unlock();					\
>  } while (0)
>  
> -__cold
> +#ifdef CONFIG_BTRFS_ASSERT
> +__cold __noreturn
>  static inline void assfail(const char *expr, const char *file, int line)
>  {
> -	if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
> -		pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
> -		BUG();
> -	}
> +	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
> +	BUG();
>  }
> +#else
> +static inline void assfail(const char *expr, const char *file, int line) {}
> +#endif
>  
>  #define ASSERT(expr)	\
>  	(likely(expr) ? (void)0 : assfail(#expr, __FILE__, __LINE__))

Separating the definitions by #ifdef looks ok, I'd rather do separate
definitions of ASSERT too, to avoid the ternary operator. I'll send the
patch.
