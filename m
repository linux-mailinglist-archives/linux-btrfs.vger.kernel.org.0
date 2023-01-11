Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB36662F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 19:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjAKSqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 13:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjAKSqQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 13:46:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDC3AAB2;
        Wed, 11 Jan 2023 10:46:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 367D35088;
        Wed, 11 Jan 2023 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673462773;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yUkJcvnxxY1Jn5kE5z65aeQ6MoeLx+akC37sClk/HC0=;
        b=cjCMruIg2T5wnPuTYD9ou3FWF6oo5GAVz7pZlkx6rsVTy1Xljdzg3oZFkCovw6ZaJKLPkH
        9FjfUiIy0whj/sLKrb913GQD+3J5CAEH2aFW7e066sFRkoLNqUbbIoaRr9MITVFvskA77L
        PJiaaBQfyK39eraIF2u5kV8xzThSMos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673462773;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yUkJcvnxxY1Jn5kE5z65aeQ6MoeLx+akC37sClk/HC0=;
        b=sDOLyz6dtkL0chd4GsDQDt7xOTNpXrHrsR3XRZpu/nTZnnB+x7ai9KCetiGdP00WSipqH9
        0hGIy2gfTIQxg7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E81EE1358A;
        Wed, 11 Jan 2023 18:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id exh+N/QDv2PjGgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 11 Jan 2023 18:46:12 +0000
Date:   Wed, 11 Jan 2023 19:40:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     zys.zljxml@gmail.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v3] btrfs: use PAGE_{ALIGN, ALIGNED, ALIGN_DOWN} macro
Message-ID: <20230111184037.GI11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230103051137.4085572-1-zys.zljxml@gmail.com>
 <87d14908-dc9d-7ce4-c594-b28a9991efbb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d14908-dc9d-7ce4-c594-b28a9991efbb@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 03, 2023 at 01:47:43PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/1/3 13:11, zys.zljxml@gmail.com wrote:
> > From: Yushan Zhou <katrinzhou@tencent.com>
> > 
> > The header file linux/mm.h provides PAGE_ALIGN, PAGE_ALIGNED,
> > PAGE_ALIGN_DOWN macros. Use these macros to make code more
> > concise.
> 
> Is there anything benefit from the change?
> 
> In fact, PAGE_ALIGN()/PAGE_ALIGNED() is just using the same 
> ALIGN()/IS_ALIGNED() macro.
> 
> Thus I don't think your change is of any usefulness, not to mention it's 
> going to introduce confusion and extra effort.
> 
> I'm completely fine with regular ALIGN()/IS_ALIGNED() usage with PAGE_SIZE.

We already have PAGE_ALIGN in some places and I think it's a bit better
than the ALIGN/IS_ALIGN as it's clear that it's for a page.
