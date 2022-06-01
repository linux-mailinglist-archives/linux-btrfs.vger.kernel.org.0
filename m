Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0276453A574
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 14:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349117AbiFAMse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiFAMsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 08:48:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3503E1056C
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 05:48:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E125721A14;
        Wed,  1 Jun 2022 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654087710;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9feJQ2kwgHvceTiExLU0IlpxXiWKC5XmrZEj24TlJY=;
        b=hU8KAxBri1QfKU4MkzJyxL7/VC7WsrxW0khwtlDzxOkDFHrcoW0e6pE3LNRum64u/XI7cf
        ZEP0GlrC4TarirM3YoQRHRYvqo91Yrjpzk/DFiP51xLsuPuL6lrJTgHUWXy9rnzngit0yI
        C58jIatISo/PjY2bx1KUnSACyssYzOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654087710;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9feJQ2kwgHvceTiExLU0IlpxXiWKC5XmrZEj24TlJY=;
        b=xXFAnKwfGlPe7lC71UJ1UWasVJGmpx8rbqz4J/NaP95c3bR6ZuAYqb3zVJepY9+w+n9U6s
        lCxpXPePKLDX1bDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0C081330F;
        Wed,  1 Jun 2022 12:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AK8eLh5gl2IAXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Jun 2022 12:48:30 +0000
Date:   Wed, 1 Jun 2022 14:44:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove redundant calls to flush_dcache_page
Message-ID: <20220601124404.GK20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220601114754.21771-1-dsterba@suse.com>
 <YpdYHT0tq+zoOG3U@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpdYHT0tq+zoOG3U@infradead.org>
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

On Wed, Jun 01, 2022 at 05:14:21AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 01, 2022 at 01:47:54PM +0200, David Sterba wrote:
> > memzero_page already calls flush_dcache_page so we can remove the calls
> > from btrfs code.
> 
> This is for a mix of memcpy_to_page and memzero_page, but the statement
> is true for both of them.  So with a slightly fixed commit log:

Right, I'll update it, thanks.
