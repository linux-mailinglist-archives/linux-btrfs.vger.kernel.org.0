Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7C5599EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiFXMx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiFXMxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 08:53:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F29625A
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 05:53:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 028781F8D2;
        Fri, 24 Jun 2022 12:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656075233;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ae3k/C5xy2A4qPhLK4KCVjEVTZi9XTibrwrSczDZ0eU=;
        b=zaSsWLKWvob88Sy+jXR66LA384noxgMb48Tky2N0iUzPv2eIMEEtqfjgdBY/RHP8jJCOSK
        2+F7Xcp0v/j1on8Qpl9gyyw3MAb9BGoAdgyOLoPkaEfTAoJIGDmrKpq10INFMu5MeaoeAP
        azAkFR+U5YDnoFoDyXUhwDzy8kBxSoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656075233;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ae3k/C5xy2A4qPhLK4KCVjEVTZi9XTibrwrSczDZ0eU=;
        b=zvXfKIDbAKRIZzI/BFFFLI+adqiVvSEAn6vM+3yV4JpYMGwh9c/HaHMmRTAmkAmIfFxlDh
        Y9pQ6y+rzmrdsACw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D178D13480;
        Fri, 24 Jun 2022 12:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q0pOMuCztWJwcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 24 Jun 2022 12:53:52 +0000
Date:   Fri, 24 Jun 2022 14:49:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220624124913.GS20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20220624122334.80603-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624122334.80603-1-hch@lst.de>
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

On Fri, Jun 24, 2022 at 02:23:34PM +0200, Christoph Hellwig wrote:
> Since the page_mkwrite address space operation was added, starting with
> commit 9637a5efd4fb ("[PATCH] add page_mkwrite() vm_operations method")
> in 2006, the kernel does not just dirty random pages without telling
> the file system.

It does and there's a history behind the fixup worker. tl;dr it can't be
removed, though every now and then somebody comes and tries to.

On s390 the page status is tracked in two places, hw and in memory and
this needs to be synchronized manually.

On x86_64 it's not a simple reason but it happens as well in some edge
case where the mappings get removed and dirty page is set deep in the
arch mm code.  We've been chasing it long time ago, I don't recall exact
details and it's been a painful experience.

If there's been any change on the s390 side or in arch/x86/mm code I
don't know but to be on the safe side, I strongly assume the fixup code
is needed unless proven otherwise.
