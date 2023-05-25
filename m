Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05518711A53
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 00:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjEYWwI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEYWwH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 18:52:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744D5B6
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 15:52:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A2F61FD86;
        Thu, 25 May 2023 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685055125;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzVpe4FDIeDd/dfLeCyUIfLQnTYIRlSoZvX/+jIdWf8=;
        b=oydqCoh7GnscikfjlfJO1ahHQOqe/jyjP+/4aFG2+PhMr9qdzwKrkzev95BalUbA1BKQgK
        8koTrPtbolcb345h1GSsLpICchJ/yb2uO8JtsHXJF5zpW//0rK2Tet66tZ4YALtQ5xanjm
        atWZ7c+OWHVoKUm9AMcTs9oDntq9dpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685055125;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzVpe4FDIeDd/dfLeCyUIfLQnTYIRlSoZvX/+jIdWf8=;
        b=wXwLVZBjOUQqWg7Npbjs75rViNkDzyv710UF3EwBsuvXB3Ux6PsAzv8dyTW9JrhxwixOma
        64QtUwsJMS1QWICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED6E113356;
        Thu, 25 May 2023 22:52:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +zJYOZTmb2R/UAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 25 May 2023 22:52:04 +0000
Date:   Fri, 26 May 2023 00:45:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/9] btrfs: open code set_extent_bits_nowait
Message-ID: <20230525224556.GK30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684967923.git.dsterba@suse.com>
 <a497320d91b1e08e0766f44844746e235478630e.1684967923.git.dsterba@suse.com>
 <ZG8kKU16PA8SF3Pg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG8kKU16PA8SF3Pg@infradead.org>
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

On Thu, May 25, 2023 at 02:02:33AM -0700, Christoph Hellwig wrote:
> The change itself looks ok to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> .. but:
> 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index bda301a55cbe..b82a350c4c59 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -1611,8 +1611,8 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
> >  	memzero_extent_buffer(eb, 0, eb->len);
> >  	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
> >  	set_extent_buffer_dirty(eb);
> > -	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
> > -			       eb->start + eb->len - 1, EXTENT_DIRTY);
> > +	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1,
> > +			EXTENT_DIRTY, NULL, GFP_NOWAIT);
> 
> .. there is no point in even using GFP_NOWAIT here, as we are always
> called in a context that can sleep, set_extent_buffer_dirty relies on
> that as well as it calls lock_page.

Right, this case of NOWAIT can be removed.
