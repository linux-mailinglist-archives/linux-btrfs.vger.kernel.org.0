Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0171280B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbjEZOKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjEZOKG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 10:10:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CE6DF
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 07:10:03 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B4481FD8A;
        Fri, 26 May 2023 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685110202;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4894UTYfMoxv/r3Rm6CQXWsB4Y3+gmp+YjyCbktJmcg=;
        b=zZfZI8F0ASvMM0jwsaoYDoBkIZZvPbr6MG1HYCqaoTT2M7noBnL77yWL0yZq+YL1PPU29E
        NW53zIfuUoiy67QHQ0krdFaKa38gV89cNH0z9o9KlE7u8UPz8JnQEoK7R6FGcI29tCOSrR
        fFiDtXKgA2Gj8RmaEQ6O+AGUxN8gT/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685110202;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4894UTYfMoxv/r3Rm6CQXWsB4Y3+gmp+YjyCbktJmcg=;
        b=4ut8+xAQhmDKs1fREMj8op8GXnEcld/J17+UoBLX1RCFITQaNESy8tYDfqKJUtEv38nnzY
        YdfNBtfTSMTHMmCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 16B37134AB;
        Fri, 26 May 2023 14:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ZcoxBLq9cGRadAAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Fri, 26 May 2023 14:10:02 +0000
Date:   Fri, 26 May 2023 16:03:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.com, josef@toxicpanda.com, clm@fb.com,
        quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix the uptodate assert in btree_csum_one_bio
Message-ID: <20230526140353.GE14830@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230526090109.1982022-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526090109.1982022-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 26, 2023 at 11:01:09AM +0200, Christoph Hellwig wrote:
> btree_csum_one_bio needs to use the btrfs_page_test_uptodate helper
> to check for uptodate status as the page might not be marked uptodate
> for a sub-page size buffer.
> 
> Fixes: 5067444c99c3 ("btrfs: remove the extent_buffer lookup in btree block checksumming")

Folded to the patch, thanks.

> Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>

