Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4CC6D69F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjDDRNa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjDDRN1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 13:13:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB665E48
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 10:13:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 345D72068A;
        Tue,  4 Apr 2023 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680628405;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nz+AKLRYPcgK+ZBsu2j6tiAO9RC6o1jtCy9kzX+eBFQ=;
        b=nr1zPuLFNW7rXAhZOlONMcee3Cks6NElVe7lF8jC1I6m3SqPB+Gma1NG6V9MycASwna9y+
        23AQaQ1Wwg06UMiyP+r0FbVSTegQvUfIxVtYVi1eZD4DEXdAdt3xsV0I1GCt9Jk+k3p8nL
        Og5nRM8g8nkqBjUhDf+olnf7H4j6hPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680628405;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nz+AKLRYPcgK+ZBsu2j6tiAO9RC6o1jtCy9kzX+eBFQ=;
        b=dt8UaGuBsbiVFypQCccp+7hWuqfkMh39wZepauzakNVgBpQRt+ZKGtLDf2LM/hfRBO/dQm
        vxhXAeHfBcmfKgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11A3813920;
        Tue,  4 Apr 2023 17:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LOFnA7VaLGSOOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 04 Apr 2023 17:13:25 +0000
Date:   Tue, 4 Apr 2023 19:13:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: fix fast csum detection
Message-ID: <20230404171323.GD19619@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230329001308.1275299-1-hch@lst.de>
 <20230329001308.1275299-2-hch@lst.de>
 <20230403183526.GC19619@twin.jikos.cz>
 <ZCuwSBClLwjkPkzs@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCuwSBClLwjkPkzs@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 03, 2023 at 10:06:16PM -0700, Christoph Hellwig wrote:
> > > +	if (btrfs_csum_is_fast(csum_type))
> > > +		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
> > 
> > This ^^^
> > 
> > >  	fs_info->csum_size = btrfs_super_csum_size(disk_super);
> > >  
> > >  	ret = btrfs_init_csum_hash(fs_info, csum_type);
> > 
> > should be moved after the initialization btrfs_init_csum_hash so it
> > would also detect accelerated implementation of other hashes.
> 
> Sure.  Something like this incremental fix.  Do you want to fold it in
> or should I resend the series?

I ended up with the same diff when reviewing the patch so I can fold it,
no need to resend. I'll send a separate patch to add xxhash as a fast
implementation, with some numbers.
