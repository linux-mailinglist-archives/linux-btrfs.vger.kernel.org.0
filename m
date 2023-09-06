Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7207942D5
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjIFSKy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 14:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbjIFSKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 14:10:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4C019BD
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 11:10:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ABDC21F459;
        Wed,  6 Sep 2023 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694023835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vVFCK//Jixzlu+0B55veKm+1p4HzWhtfK2MNito8Ym0=;
        b=PdC8NNpZRqhn4GjiXSGq+UV7zh6PAc6sASy2CkXoP9rCRbJ7P51gCYtNfyah3bDeJK9z2/
        sFWky7jgKVFDGVNz4g+yNQtvtfhHTcUSfeBvc3MH1DsUMuhs7ylXLaXkaSPNbNFJ2Zq2XH
        KZa4QJHbzaxCnyMtdJIzsu95d+e1bzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694023835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vVFCK//Jixzlu+0B55veKm+1p4HzWhtfK2MNito8Ym0=;
        b=3yUYYHsTJtl+UL+CMMC150wL/OI6r+aDA8TgN4HPHLa7XUmdMjwsxBqOTGhtLE3EsQbaky
        iOccWj//dprom0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A0DE1333E;
        Wed,  6 Sep 2023 18:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TwXtIJvA+GTOMQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 18:10:35 +0000
Date:   Wed, 6 Sep 2023 20:03:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Convert btrfs_read_merkle_tree_page() to use a
 folio
Message-ID: <20230906180355.GW14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230814175208.810785-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814175208.810785-1-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 14, 2023 at 06:52:08PM +0100, Matthew Wilcox (Oracle) wrote:
> Remove a number of hidden calls to compound_head() by using a folio
> throughout.  Also follow core kernel code style by adding the folio to
> the page cache immediately after allocation instead of doing the read
> first, then adding it to the page cache.  This ordering makes subsequent
> readers block waiting for the first reader instead of duplicating the
> work only to throw it away when they find out they lost the race.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Added to btrfs tree, thanks.
