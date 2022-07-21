Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3961357CE1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiGUOuI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUOuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 10:50:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F0398;
        Thu, 21 Jul 2022 07:50:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DB43337AC;
        Thu, 21 Jul 2022 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658415003;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qLqX20kX0c8/dwSrIy5tveSz988NxNgvcZN6f83my3c=;
        b=RAK/RnIZxP90PNjbRwNHz1m0Pf3e6+uYmOp3ZiBt14oiSJKkxVwqth7b7YWl8vsn2qAqf9
        ZQ2pPxKvg4d2VzaoR74LpNhhhYO241zogYIq7BJJrgwqVYJxSG/ZoznsX7tpQH92ZlsWB2
        MgtaE+6vdMxll9rJ2WqCHpJfEUxjErY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658415003;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qLqX20kX0c8/dwSrIy5tveSz988NxNgvcZN6f83my3c=;
        b=W0UT7tnuMSAWxs2fwTaj92BfDMmuawAi+W2OhaVzXrdEO9mP7rnmKCJAwvE6vttP5Dhytg
        3qdKkRyIV+UqJpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65E8B13A89;
        Thu, 21 Jul 2022 14:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SXFMF5tn2WLLSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 21 Jul 2022 14:50:03 +0000
Date:   Thu, 21 Jul 2022 16:45:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 5.19-rc7
Message-ID: <20220721144508.GU13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657976305.git.dsterba@suse.com>
 <YtLadOkHl0lDNwbM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtLadOkHl0lDNwbM@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 16, 2022 at 04:34:12PM +0100, Matthew Wilcox wrote:
> On Sat, Jul 16, 2022 at 04:06:20PM +0200, David Sterba wrote:
> > Note about the xarray API:
> > 
> > The possible sleeping is documented next to xa_insert, however there's
> > no runtime check for that, like is eg. in radix_tree_preload.  The
> > context does not need to be atomic so it's not as simple as
> > 
> >   might_sleep_if(gfpflags_allow_blocking(gfp));
> > 
> > or
> > 
> >   WARN_ON_ONCE(gfpflags_allow_blocking(gfp));
> > 
> > Some kind of development time debugging/assertion aid would be nice.
> 
> Are you saying that
> https://git.infradead.org/users/willy/xarray.git/commitdiff/c195d497ca1ff673c2e6935152a0a5b6be2efdc9
> 
> is wrong?  It's been in linux-next for the last week since you drew it
> to my attention that this would be useful.

I have misinterpreted what might_sleep_if does in case it's under mutex,
it won't warn so the linked commit (adding might_alloc) should be
enough, thanks.
