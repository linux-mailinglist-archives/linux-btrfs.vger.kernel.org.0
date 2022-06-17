Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6854F924
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382687AbiFQOZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382476AbiFQOZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 10:25:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0B515AC;
        Fri, 17 Jun 2022 07:25:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6919B21E44;
        Fri, 17 Jun 2022 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655475899;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9HpK8AQFCPpZGHqOflUkPRS+AfBo7nezyoDwo5EOxw=;
        b=wON5Z+a8PY3NERVTywme/dw6SGBNU5E2zNjD+c2ZeDbwICsTtnV4w3RAuhibm88j/JmuGV
        g8S70bLRewWvY75g9gCfu0RHBB3T3Sf3WShC3IdZZkTlLGIayCG9St8vhwG72ocTa25VmL
        58dVm1pmwlVNQvWdEfcu/8XDtCq1DVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655475899;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9HpK8AQFCPpZGHqOflUkPRS+AfBo7nezyoDwo5EOxw=;
        b=Se/2b5X2lpR6pFkWpn6Hvd2pjIbTelvpE8uXqCZExx4u46Ub1zvNv6NMEnN8Wgx/B0w+D7
        GeGj8iyXGisMmABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08E481348E;
        Fri, 17 Jun 2022 14:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +29EAbuOrGIdLgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 17 Jun 2022 14:24:59 +0000
Date:   Fri, 17 Jun 2022 16:20:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] btrfs: Use kmap_local_page() on "in_page" in
 zlib_compress_pages()
Message-ID: <20220617142024.GL20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220617120538.18091-1-fmdefrancesco@gmail.com>
 <20220617120538.18091-4-fmdefrancesco@gmail.com>
 <8cbfc1ff-f86d-f2cc-d37e-ef874f4600bc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cbfc1ff-f86d-f2cc-d37e-ef874f4600bc@gmx.com>
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

On Fri, Jun 17, 2022 at 09:09:47PM +0800, Qu Wenruo wrote:
> On 2022/6/17 20:05, Fabio M. De Francesco wrote:
> > @@ -126,6 +128,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
> >   		ret = -ENOMEM;
> >   		goto out;
> >   	}
> > +	mstack[sind] = 'A';
> > +	sind++;
> >   	cpage_out = kmap_local_page(out_page);
> >   	pages[0] = out_page;
> >   	nr_pages = 1;
> > @@ -148,26 +152,32 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
> >   				int i;
> >
> >   				for (i = 0; i < in_buf_pages; i++) {
> > -					if (in_page) {
> > -						kunmap(in_page);
> 
> I don't think we really need to keep @in_page mapped for that long.
> 
> We only need the input pages (pages from inode page cache) when we run
> out of input.
> 
> So what we really need is just to map the input, copy the data to
> buffer, unmap the page.
> 
> > +					if (data_in) {
> > +						sind--;
> > +						kunmap_local(data_in);
> >   						put_page(in_page);
> >   					}
> >   					in_page = find_get_page(mapping,
> >   								start >> PAGE_SHIFT);
> > -					data_in = kmap(in_page);
> > +					mstack[sind] = 'B';
> > +					sind++;
> > +					data_in = kmap_local_page(in_page);
> >   					memcpy(workspace->buf + i * PAGE_SIZE,
> >   					       data_in, PAGE_SIZE);
> >   					start += PAGE_SIZE;
> >   				}
> >   				workspace->strm.next_in = workspace->buf;
> >   			} else {
> 
> I think we can clean up the code.
> 
> In fact the for loop can handle both case, I didn't see any special
> reason to do different handling, we can always use workspace->buf,
> instead of manually dancing using different paths.
> 
> I believe with all these cleanup, it should be much simpler to convert
> to kmap_local_page().
> 
> I'm pretty happy to provide help on this refactor if you don't feel
> confident enough on this part of btrfs.

My first thought was "why to clean up zlib loop if we want to just
replace kmap" but after seeing the whole stack and fiddling with the
indexes I agree that a simplification should be done first.
