Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C1587C83
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiHBMhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 08:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiHBMhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 08:37:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB6221277;
        Tue,  2 Aug 2022 05:37:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 11FDF3738F;
        Tue,  2 Aug 2022 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659443837;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3HfC4HYHoemQeatFoai8aWeqbtAIvEIrdWu0ZbndmPA=;
        b=NsXkFLAGYRQ/94SoOj3ILjVrtbb+NTvgSb+xWx1Za8zLOJ16Sb7yz3IRdQ5W1rb+FfWT3N
        CFJjKsXNtdXPftnCqPMyxeUBI3zHTuBb9PCZ4kKg/A2fkvO885CAZ2KtMjU187NCuwGmLR
        +mBybjSpvUqkKVkgOPMoX3UTTk26oXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659443837;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3HfC4HYHoemQeatFoai8aWeqbtAIvEIrdWu0ZbndmPA=;
        b=MbuVwMeZFtMLmOT0+f/eCJD9TlhKHH6SUYG3RW0fyJVk+mLe/ztwI6I+HCRMD3/p/W1X56
        gcMS8l+t1rR2FgAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E005013A8E;
        Tue,  2 Aug 2022 12:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4Ja/NXwa6WLyQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 12:37:16 +0000
Date:   Tue, 2 Aug 2022 14:32:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 5.20
Message-ID: <20220802123215.GJ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1659357652.git.dsterba@suse.com>
 <c360943e-c922-9688-5956-e3e5a35c06d8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c360943e-c922-9688-5956-e3e5a35c06d8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 09:11:09AM +0800, Qu Wenruo wrote:
> On 2022/8/2 00:40, David Sterba wrote:
> > Notable fixes:
> >
> > - raid56
> >    - reduce parity writes, skip sectors of stripe when there are no data
> >      updates
> >    - restore reading from stripe cache instead of triggering new read
> 
> Small typo I guess.
> It's the opposite, restore reading from on-disk data instead of using
> stripe cache.

Thanks.

Linus, please replace the sentence with

       - restore reading from on-disk data instead of using stripe
	 cache, this reduces chances to damage correct data due to RMW
	 cycle
