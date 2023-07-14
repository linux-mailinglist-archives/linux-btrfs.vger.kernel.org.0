Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FC8753DEA
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjGNOox (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 10:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbjGNOop (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 10:44:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63830C6
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vJk35rvFHpvUB7HtE11pmxeUU/js7CK8/4AS1fSYUMc=; b=KT5bxFFTfGFEG6GG7k4JlOlIdy
        XRcEepifOJDCnDVzJijUxIQb9TsK48bfETwZ+nK9bQD8ezmvNcV5W/yrVdmd8szwq0inZ9xfyNL7i
        y/MWf+/QrqgIbxhqgJ4MDVmtMJoIqhJvC8iUFGGvMG6KV8kmXYSIuDX77Ec+ULoc7/fA8SqP1a3CT
        rfTgeKRGLTcXJe2Xv6d0ljcqnj4OPO/ntqccqW/OsA4j3Qm99K0pxJMOkkv8GnsdTt//O6sIZOhVG
        aqI1obkaY7RxtG1PZoNr+WPW/DTKX5FFYg5OWc9UgUpiRufHDRBc/GvAQPIv9A3YbTpv6Z2aHhs+L
        MnPewwOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qKK29-006QaG-29;
        Fri, 14 Jul 2023 14:44:37 +0000
Date:   Fri, 14 Jul 2023 07:44:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: replace unsigned char with u8 for type casts
Message-ID: <ZLFfVSY3+Lwp8l4v@infradead.org>
References: <cover.1689257327.git.dsterba@suse.com>
 <903ef08411ce5f8456f1c5b7a099c526d19dbf21.1689257327.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903ef08411ce5f8456f1c5b7a099c526d19dbf21.1689257327.git.dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 13, 2023 at 04:10:24PM +0200, David Sterba wrote:
> There's no reason to use 'unsigned char' when we can simply use u8
> for byte buffers like for checksums or send buffers. The char could be
> signed or unsigned depending on the compiler settings, per [1] it's not
> simple.
> 
> [1] https://lore.kernel.org/lkml/CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com/

I don't understand how this link is related.  Plain char is indeed
a mess because it could be signed or not.  unsigned char vs u8 is
just plain preference as the latter is always an alias to the former.

u8 tends to look nice to my eyes, but this is a simple cleanup / style
change and not relatded to the above.

> 
> Checksum buffer item already uses u8 so this unifies the types and in
> btrfs_readdir_delayed_dir_index() the unsigned char has been probably
> inherited from fs_ftype_to_dtype() bit it's not strictly necessary

That one isn't used by a cast anyway..

>  	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
> +	item = (struct btrfs_csum_item *)((u8 *)item + csum_offset * csum_size);

This still looks a bit odd to me, because btrfs_csum_item returns the
pointer as the last argument, and the next thing we'd do here is to cast
that away.  If you don't mind using the gcc extention of void pointer
arithmetics that we use all over the kernel this could become:

	item = btrfs_item_ptr(leaf, path->slots[0], void) +
		csum_offset * csum_size;

which I find quite a bit readable.

>  	leaf = path->nodes[0];
>  csum:
>  	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
> -	item_end = (struct btrfs_csum_item *)((unsigned char *)item +
> +	item_end = (struct btrfs_csum_item *)((u8 *)item +
>  				      btrfs_item_size(leaf, path->slots[0]));
> -	item = (struct btrfs_csum_item *)((unsigned char *)item +
> -					  csum_offset * csum_size);
> +	item = (struct btrfs_csum_item *)((u8 *)item + csum_offset * csum_size);

And something similar here.  No point in asking btrfs_item_ptr
to cast to a a btrfs_csum_item, when you then instantly cast it to u8
(or void per the above) for pointer arithmetic.

