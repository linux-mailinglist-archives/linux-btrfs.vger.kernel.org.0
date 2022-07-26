Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A149581980
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 20:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiGZSNw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiGZSNv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 14:13:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73672529D
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 11:13:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 640921F45E;
        Tue, 26 Jul 2022 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658859229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5XkWmofA1ssDnarVUf+2zrp4CmBBrGNTCwM09/oOgO8=;
        b=XILN/m/FmvLb1YLQL3oM26B/DxX+F7OXb4exnZsD6g2uX3CCXXd8KiTw2m+xIPgDCZu7zh
        +dYPYtR+ZYeGqAyokumx5gy2XD6GaDp2VrdWnQJbZ6xGVyyG/qmx2PWPZ5NkFCeXDd2VLF
        PF2sLCHhA3oDen9HC9gynos6y/C+iiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658859229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5XkWmofA1ssDnarVUf+2zrp4CmBBrGNTCwM09/oOgO8=;
        b=deHG0dSlwGoolNqYXyc687fOTeGj8NGGUeXFoOQNaE0APqD7hLPX9JSKVhDMUAOhxufW5l
        nRNhO3oH73V4lhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33CA213A7C;
        Tue, 26 Jul 2022 18:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t44vCt0u4GI+FgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 18:13:49 +0000
Date:   Tue, 26 Jul 2022 20:08:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/5] btrfs: scrub: introduce scrub_block::pages for
 more efficient memory usage for subpage
Message-ID: <20220726180851.GI13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1658215183.git.wqu@suse.com>
 <14ea03b93f2708cce7ccbdc1321df51938c468e9.1658215183.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ea03b93f2708cce7ccbdc1321df51938c468e9.1658215183.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 19, 2022 at 03:24:11PM +0800, Qu Wenruo wrote:
> -static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx)
> +#ifndef CONFIG_64BIT
> +/* This structure is for archtectures whose (void *) is smaller than u64 */
> +struct scrub_page_private {
> +	u64 logical;
> +};
> +#endif
> +
> +static int attach_scrub_page_private(struct page *page, u64 logical)
> +{
> +#ifdef CONFIG_64BIT
> +	attach_page_private(page, (void *)logical);
> +	return 0;
> +#else
> +	struct scrub_page_private *spp;
> +
> +	spp = kmalloc(sizeof(*spp), GFP_KERNEL);

That's allocating 8 bytes, there is a slab of that size but the
extra allocation adds overhead and failure point. As the scrub pages are
completely private you could possibly use some other member for the
remaining part of u64, eg. page::mapping.
