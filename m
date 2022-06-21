Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5CA55397A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiFUSX7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFUSX6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 14:23:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F2140DC
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 11:23:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C3BE21BF0;
        Tue, 21 Jun 2022 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655835835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKSgvwj8jAZTfqB7d3PGx8hkdKKvWe1N9t/tvRgpJrE=;
        b=02ZnU1UuBmL1ssoxafkk4+Zlt1hK0tJ9Z/MWpTFgCeMrM0A0aEZt9k/ZLF0SbAr7s9wjxS
        mkU1eK+WLAql4Qb/NJ0HiR1G+9VSJtBTRz5DucKdF/D46fU7VmEW4dwKGcLte8ABrixO2H
        G8JlqvuDvOHG0d61tCs7fc89AOs9KSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655835835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKSgvwj8jAZTfqB7d3PGx8hkdKKvWe1N9t/tvRgpJrE=;
        b=tEhlLbGTEZRCPBJoHsVBowgDdKoY2q5NcdBtc3107GLqLcT1jkhsZL3C9uNrD9SzHuHO9H
        4uK+KiheeamafBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5120B13A88;
        Tue, 21 Jun 2022 18:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b9RVErsMsmKJPwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Jun 2022 18:23:55 +0000
Date:   Tue, 21 Jun 2022 20:19:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] btrfs: zlib: refactor how we prepare the buffers
Message-ID: <20220621181917.GE20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
References: <aa6f4902ae200435d9da603dd092e91c4dfdf69e.1655791043.git.wqu@suse.com>
 <20220621131521.GW20633@twin.jikos.cz>
 <YrH9VNQnVqHgUKAC@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrH9VNQnVqHgUKAC@iweiny-desk3>
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

On Tue, Jun 21, 2022 at 10:18:12AM -0700, Ira Weiny wrote:
> On Tue, Jun 21, 2022 at 03:15:21PM +0200, David Sterba wrote:
> > On Tue, Jun 21, 2022 at 01:59:46PM +0800, Qu Wenruo wrote:
> > > 
> > >   As kmap_local_page() have strict requirement on the sequence of nested
> > >   kmap:
> > >                    OK              |            BAD
> > >   ---------------------------------+---------------------------------
> > >   in = kmap_local_page(in_page);   | in = kmap_local_page(in_page);
> > >   out = kmap_local_page(out_page); | out = kmap_local_page(out_page);
> > 
> > The input pages come from page cache and could be allocated from
> > highmem but the output pages are allocated by us and only with GFP_NOFS
> > so they don't need to be kmapped at all, right?
> 
> How important is it to optimize the HIGHMEM systems?

We optimize for 64bit architectures and add maybe cheap fallbacks or
warnings but specifically high memory is not supposed to be anywhere if
possible, all highmem allocations have been dropped. The kmap
requirement comes only when pages are from page cache and filesystem
can't affect that.

> On !HIGHMEM systems the kmap_local_page() calls fall out anyway.

Right, but as long as it's kmap_local it must follow the nesting rules
and this complicates the code or requires restructuring. My point is
that we can drop kmap for the output page thus getting rid of the
nesting. Then the mapping of input pages should be straightforward and
working on 32bit architectures.
