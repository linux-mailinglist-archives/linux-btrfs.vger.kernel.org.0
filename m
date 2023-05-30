Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA7771718B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjE3XUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 19:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjE3XUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 19:20:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03973E8
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 16:20:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DBD21F898;
        Tue, 30 May 2023 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685488813;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bFd8X6FMQIAC3oB8oXMFlNzTESgv9yWQhmRs9jxk3w=;
        b=dZSRLBG6IFpc125coOaZOFwFxBKGzmaBkSQR4SeeludwobBmAqU8mBCmNigkAT9+ab0gBo
        TUI47FYpIWtq9SdfdZI8arZjmtjGaqXRmpYMoo5tCNAhOPOcnoimwJtmOgwiFrCDxgCIzP
        k0T72kC8dQxixnNTiImlKR6zluoaiB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685488813;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bFd8X6FMQIAC3oB8oXMFlNzTESgv9yWQhmRs9jxk3w=;
        b=dTT/PtT/e+U3w66HDsa3qtQEqiaSZnYBEs6h3POuMhbUTwAdS5Ek3AcABI7AF8HuPXS7aQ
        3DVDazxMLbc+GCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6126113597;
        Tue, 30 May 2023 23:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +i+SFq2EdmRqawAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 23:20:13 +0000
Date:   Wed, 31 May 2023 01:14:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: please fold some fix into misc-next(btrfs: print assertion
 failure report and stack trace from the same line)
Message-ID: <20230530231402.GE32581@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230528060227.AF10.409509F4@e16-tech.com>
 <20230529134758.GF575@twin.jikos.cz>
 <20230529221531.FEDF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529221531.FEDF.409509F4@e16-tech.com>
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

On Mon, May 29, 2023 at 10:15:32PM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Sun, May 28, 2023 at 06:02:28AM +0800, Wang Yugui wrote:
> > > Hi,
> > > 
> > > please fold some fix into misc-next(btrfs: print assertion failure report and stack trace from the same line).
> > > 
> > > Because 'btrfs_assertfail' become macro(inline), we should drop it from objtools.
> > > 
> > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > index f937be1afe65..060032cfb046 100644
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -170,7 +170,6 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
> > >  		"__reiserfs_panic",
> > >  		"__stack_chk_fail",
> > >  		"__ubsan_handle_builtin_unreachable",
> > > -		"btrfs_assertfail",
> > 
> > If this is not in objtool, does it produce any warning? I'm not sure if
> > I want to do the change in the same patch and last time I checked
> > objtool was fine with the listed function not existing.
> 
> yes, it produce no warning, but this funciton in here become a noisy.
> 
> we need to do this in the same patch, because in this patch, 
> it become from necessary to noisy.

Ok, I'll update the patch and let Josh know.
