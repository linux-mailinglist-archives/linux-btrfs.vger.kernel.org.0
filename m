Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18547E06FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 17:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbjKCQsh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 12:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbjKCQsg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 12:48:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1DE125
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 09:48:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01A2D1F388;
        Fri,  3 Nov 2023 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699030109;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0joV9BL9ir6oWKJsS78e2DFmkRAWjhGJr2PG9sxA42U=;
        b=G800OOLn4FYJL4tLSUAF3mTfnJnGI7gIm25xdZOp+yO5vP1WzSvWbWRw7S70QBu5aJOFxo
        vNzI+mWBDsgVs0/8wMniutXST17GtfeVLK1KkhW4fwKKfwfrRojVh87an/oHnpWnWBN01K
        ckZ3G3wjx7XiMeHxHQRd9gW5j+xYnuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699030109;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0joV9BL9ir6oWKJsS78e2DFmkRAWjhGJr2PG9sxA42U=;
        b=bJcHiA5cGKJKVDhDKV7O3iQiI0Lxg6oGv0tfMSxTvjpxfD+oWSyDrUAxR1chwc9Kxe2m/J
        ccMHmQecRdhMF3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C318313907;
        Fri,  3 Nov 2023 16:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b1vbLlwkRWXSUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 03 Nov 2023 16:48:28 +0000
Date:   Fri, 3 Nov 2023 17:41:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Su Yue <l@damenly.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject unknown mount options correctly
Message-ID: <20231103164129.GM11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a6a954a1f1c7d612104279c62916f49e47ba5811.1697085884.git.wqu@suse.com>
 <cyxk1i2x.fsf@damenly.org>
 <f72ce467-b8c8-4373-a0ab-23e0631a5b27@gmx.com>
 <20231012145546.GG2211@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012145546.GG2211@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 12, 2023 at 04:55:46PM +0200, David Sterba wrote:
> On Thu, Oct 12, 2023 at 05:37:32PM +1030, Qu Wenruo wrote:
> > On 2023/10/12 16:31, Su Yue wrote:
> > >>
> > >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> > >> ---
> > >> This would be the proper fix for the recently reverted commit
> > >> 5f521494cc73 ("btrfs: reject unknown mount options early").
> > >>
> > > I'm a noob about selinux though. Better to draft a new fstest case to
> > > avoid further regression?
> > 
> > For SELinux enabled environment, any test would fail, thus I wonder if
> > we really need a dedicated one.
> > 
> > But as an Arch fanboy, my VM completely failed to catch it, nor even has
> > the needed user space tools by default...
> > 
> > For the invalid options rejection, we could definitely have one test
> > case for it.
> 
> We'll need coverage tests for mount option parsing before we do the
> conversion to fs_context.

The conversion patches have been written and in testing, I think we
don't need to fix the old parsing code. The problem is there but I don't
see it as urgent, it's been there for a long time.
