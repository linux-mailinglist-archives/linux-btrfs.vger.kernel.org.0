Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8606F69A6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEDLPU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEDLPT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:15:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92271FC4
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:15:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70E3D21C12;
        Thu,  4 May 2023 11:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683198916;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yaPu+WByK2LYXw1UQKE0vg1gK+Oi/OII7ff3hCITK24=;
        b=XCiLBO4KWBldIq9z0CNR4JTt2LjXFTobPyX+jZcwHFaIQL/tT27AlVUGME4z02s7lLXmRh
        Ht/tu+rzxRFYfT7/vSLTKBTlSYfV9z7aSQ7I+MR0dd4/iq7Hd37843EneqPYEw8+bgQnGh
        fg1ba/hlw/CPFnCzJHbvEOn6IWoS2gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683198916;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yaPu+WByK2LYXw1UQKE0vg1gK+Oi/OII7ff3hCITK24=;
        b=M6LFLo0HseMO4WpmRNJgufhc/vpSa75C4KnLOT9ZLaWH57K0G5agD/H2rqJvL0JkHkiUUX
        nMh1T9eitdscIyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 482D013444;
        Thu,  4 May 2023 11:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ERLMEMSTU2RmFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 May 2023 11:15:16 +0000
Date:   Thu, 4 May 2023 13:09:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: print assertion failure report and stack
 trace from the same line
Message-ID: <20230504110920.GE6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230503190816.8800-1-dsterba@suse.com>
 <20230504091932.69E7.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504091932.69E7.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 04, 2023 at 09:19:33AM +0800, Wang Yugui wrote:
> >  #ifdef CONFIG_BTRFS_ASSERT
> > -void __cold __noreturn btrfs_assertfail(const char *expr, const char *file, int line);
> > +
> > +#define btrfs_assertfail(expr, file, line)	({				\
> > +	pr_err("assertion failed: %s, in %s:%d\n", (expr), (file), (line));	\
> > +	BUG();								\
> > +})
> >  
> >  #define ASSERT(expr)						\
> >  	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
> > -- 
> > 2.40.0
> 
> We need remove btrfs_assertfail in tools/objtool/check.c
> that come from commit f372463124df ?

Yes if we agree to merge this patch in the end. As I'm reading the
objtool checks, it's not a hard bug if the function does not exist (but
is in the list of exceptions). Thanks for noticing it, I'll keep it
in mind.
