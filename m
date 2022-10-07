Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ED25F7C42
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 19:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJGRbr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 13:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJGRbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 13:31:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3935D18C5
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 10:31:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58C661F7AB;
        Fri,  7 Oct 2022 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665163903;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0oIPRJbwUsCsnSBHC4ti1AlRBo+ZRXOuIM8NL5XLCo=;
        b=oeEjIeGRif9WsHLmAz2mjYLv1wjgGSZJRXHtT+SOsL0+iwskZTWVD9RHtHnkIrWeqRjeUr
        uatwdwkJhDrpk/R+baOweeur6XzOXf/OY9jdAa175WMJjy7V+ngZZOK9Y3hLKibFnmxR0P
        znKq8+SMh3/h3tXKtXe9AfMtzKMd0Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665163903;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0oIPRJbwUsCsnSBHC4ti1AlRBo+ZRXOuIM8NL5XLCo=;
        b=O/RzLnaymPUpF5HRe3fSsCMvSpOiLMJ6CiAVF1ntzl+j37NZbKCBnBLV7S+tsepGdo5Eky
        J02PBZVsD6SaVkDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B05813A9A;
        Fri,  7 Oct 2022 17:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ADuwAH9iQGOhWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 17:31:43 +0000
Date:   Fri, 7 Oct 2022 19:31:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 12/17] btrfs: move btrfs_print_data_csum_error into
 inode.c
Message-ID: <20221007173139.GB13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663167823.git.josef@toxicpanda.com>
 <95d99a944771363259f2de25de22dffd7867d127.1663167823.git.josef@toxicpanda.com>
 <048bd930-6634-1dc2-1551-52766d4fefeb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048bd930-6634-1dc2-1551-52766d4fefeb@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 05:22:48PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/9/14 23:06, Josef Bacik wrote:
> > This isn't used outside of inode.c, there's no reason to define it in
> > btrfs_inode.h.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Just a small nitpick below.
> 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 6fde13f62c1d..998d1c7134ff 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -125,6 +125,31 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
> >   				       u64 ram_bytes, int compress_type,
> >   				       int type);
> >   
> > +static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
> 
> IIRC for static function there is no need for explicit inline keyword.
> 
> Under most cases the compiler should be more clever than us.

For error printing function we don't need inlining at all and if we'd
want to micro optimize the function can be put to __cold section.
