Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683596F4673
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjEBO5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjEBO5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 10:57:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A002121
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 07:57:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C9EF1FD67;
        Tue,  2 May 2023 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683039435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hP1hu0Awo7X5Zes4IFdqmkWscpyMVV2Is/WmEhqbafI=;
        b=TYNzmEe0aLRXreGFuqlF+MK3GYU5Gn1nx4s7DMqs8sFoMxDgjEy17YDlQVML03XgSbmwwx
        XIsKBn2JKG3kfzV7fWq4kTsn3BmOUODtvex0vNpBra/23R6mDf9FbnF/HDplHRRtxSIFoC
        H5niO7swlW7oh0dGd6icyCvG1w6DICc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683039435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hP1hu0Awo7X5Zes4IFdqmkWscpyMVV2Is/WmEhqbafI=;
        b=QIwBXMziVd3sI9fUBtTeFYi2CMZkEJu1h4U5x+J49T5HkY50n+8QnKxNe1dBQ+HYsMNDnN
        OBmQt/XuBqw8KTDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25FC7139C3;
        Tue,  2 May 2023 14:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 61ZYCMskUWTjEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 14:57:15 +0000
Date:   Tue, 2 May 2023 16:51:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: enable -Wmissing-prototypes for debug builds
Message-ID: <20230502145120.GF8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8cf9b5f14a52067bec9c4bb9f2d2c13821e0d7b6.1682990969.git.wqu@suse.com>
 <20230502114142.GA8111@twin.jikos.cz>
 <f0af43f7-dd50-85aa-ff92-4bcac5d40ce5@suse.com>
 <20230502133045.GD8111@suse.cz>
 <20230502142533.GA1493492@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502142533.GA1493492@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 02, 2023 at 10:25:33AM -0400, Josef Bacik wrote:
> On Tue, May 02, 2023 at 03:30:45PM +0200, David Sterba wrote:
> > On Tue, May 02, 2023 at 08:00:57PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2023/5/2 19:41, David Sterba wrote:
> > > > On Tue, May 02, 2023 at 09:29:30AM +0800, Qu Wenruo wrote:
> > > >> During development I'm a little surpirsed we don't have
> > > >> -Wmissing-prototypes enabled even for debug builds.
> > > > 
> > > > The build supports W=levels like kernel and -Wmissing-prototypes is in
> > > > level 1. In some cases we may want to add the warnings to be on by
> > > > default for debugging builds though.
> > > 
> > > I just did a quick search for the word "missing" of progs Makefile, 
> > > unforunately no hit, thus I doubt if it's even in debug level 1.
> > > 
> > > And the missing prototypes warning is by default enabled for kernel.
> > 
> > $ grep missing Makefile.extrawarn
> > warning-1 += -Wmissing-declarations
> > warning-1 += -Wmissing-format-attribute
> > warning-1 += $(call cc-option, -Wmissing-prototypes)
> > warning-1 += $(call cc-option, -Wmissing-include-dirs)
> > warning-1 += $(call cc-disable-warning, missing-field-initializers)
> > warning-2 += $(call cc-option, -Wmissing-field-initializers)
> > 
> > > [...]
> > > >>   
> > > >> +#include "sha.h"
> > > > 
> > > > This does not seem necessary, include whole file just for one prototype.
> > > 
> > > This is necessary as we would define a global function, without 
> > > including the header we got the missing prototype warning.
> > > 
> > > All the other comments make sense and I would update the patchset.
> > > 
> > > 
> > > The only other concern is, would this extra warning causing more hassles 
> > > for Josef to sync the kernel and progs code?
> > 
> > I don't know yet but it is possible that it would.  In that case the separate
> > patch would make it easier to enable once all warnings are fixed, I can keep it
> > at the top of the branch.
> 
> Do you want me to run these warnings through my series and re-send?  That may be
> faster than trying to merge everything together.  Thanks,

I'd rather get the series merged first, fixing all the warnings can be
done right before release.
