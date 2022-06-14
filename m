Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7661B54B334
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 16:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbiFNO36 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 10:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244639AbiFNO35 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 10:29:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5523615E;
        Tue, 14 Jun 2022 07:29:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEC371F930;
        Tue, 14 Jun 2022 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655216994;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sUM5JezTgOeH5YJB4qMver/nDgsiIG+jHJ6CxJ8KWo=;
        b=AHIc1T+T63d/dp4JPI0aPXI1J/Ffvkhgx7JM2UYhD8elN+0r+3Ifs6Zwg+7ULyghHhiiUh
        YibkkXoirEqLwGb6CsleFLJh0ahhdn+M8hJP8upt3BMf2Gf3HpuUDfgxsASJFHkjVJTCAV
        kz3izirGp2dwYelsC7ghMHp4B0Fr1VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655216994;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sUM5JezTgOeH5YJB4qMver/nDgsiIG+jHJ6CxJ8KWo=;
        b=lX0I1sytpWX/NIHU0zaVY6xhxK9HYG/KBdugW8wblolTfSY7A1Tzt4qT/olWouWPCNuvr+
        EHSGJU2RJ+IvSmCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69A61139EC;
        Tue, 14 Jun 2022 14:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HbrBGGKbqGJDRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Jun 2022 14:29:54 +0000
Date:   Tue, 14 Jun 2022 16:25:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Message-ID: <20220614142521.GN20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com>
 <20220613183913.GD20633@twin.jikos.cz>
 <1936552.usQuhbGJ8B@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1936552.usQuhbGJ8B@opensuse>
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

On Tue, Jun 14, 2022 at 01:22:50AM +0200, Fabio M. De Francesco wrote:
> On lunedì 13 giugno 2022 20:39:13 CEST David Sterba wrote:
> > On Sat, Jun 11, 2022 at 03:52:03PM +0200, Fabio M. De Francesco wrote:
> > > The use of kmap() is being deprecated in favor of kmap_local_page(). 
> With
> > > kmap_local_page(), the mapping is per thread, CPU local and not 
> globally
> > > visible.
> > > 
> > > Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in
> > > this file the mappings are per thread and are not visible in other
> > > contexts; meanwhile refactor zstd_compress_pages() to comply with 
> nested
> > > local mapping / unmapping ordering rules.
> > > 
> > > Tested with xfstests on a QEMU + KVM 32 bits VM with 4GB of RAM and
> > > HIGHMEM64G enabled.
> > > 
> > > Cc: Filipe Manana <fdmanana@kernel.org>
> > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > > @@ -477,15 +479,16 @@ int zstd_compress_pages(struct list_head *ws, 
> struct address_space *mapping,
> > >  		/* Check if we need more input */
> > >  		if (workspace->in_buf.pos == workspace->in_buf.size) {
> > >  			tot_in += PAGE_SIZE;
> > > -			kunmap(in_page);
> > > +			kunmap_local(workspace->out_buf.dst);
> > > +			kunmap_local((void *)workspace->in_buf.src);
> > 
> > Why is the cast needed?
> 
> As I wrote in an email I sent some days ago ("[RFC PATCH] btrfs: Replace 
> kmap() with kmap_local_page() in zstd.c")[1] I get a series of errors like 
> the following:
> 
> /usr/src/git/kernels/linux/fs/btrfs/zstd.c:547:33: warning: passing 
> argument 1 of '__kunmap_local' discards 'const' qualifier from pointer 
> target type [-Wdiscarded-qualifiers]
>   547 |   kunmap_local(workspace->in_buf.src);
>       |                ~~~~~~~~~~~~~~~~~^~~~
> /usr/src/git/kernels/linux/include/linux/highmem-internal.h:284:17: note: 
> in definition of macro 'kunmap_local'
>   284 |  __kunmap_local(__addr);     \
>       |                 ^~~~~~
> /usr/src/git/kernels/linux/include/linux/highmem-internal.h:92:41: note: 
> expected 'void *' but argument is of type 'const void *'
>    92 | static inline void __kunmap_local(void *vaddr)
>       |                                   ~~~~~~^~~~~
> 
> Therefore, this is a (bad?) hack to make these changes compile.

I think it's a bad practice and that API that does not modify parameters
should declare the pointers const. Type casts should be used in
justified cases and not to paper over fixable issues.

> A better solution is changing the prototype of __kunmap_local(); I
> suppose that Andrew won't object, but who knows?
> 
> (+Cc Andrew Morton).
> 
> I was waiting for your comments. At now I've done about 15 conversions 
> across the kernel but it's the first time I had to pass a pointer to const 
> void to kunmap_local(). Therefore, I was not sure if changing the API were 
> better suited (however I have already discussed this with Ira).

IMHO it should be fixed in the API.
