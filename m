Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6358549E9A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 22:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbiFMUJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiFMUJp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 16:09:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545B2646;
        Mon, 13 Jun 2022 11:43:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F34321B82;
        Mon, 13 Jun 2022 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655145826;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AX/+RA0lmZ3PC7RQsZdCzoesVFiJPYP6V1mryNynG5Y=;
        b=x5WMV1sCNz8I4lHXpXaVnTvXRRU16yh6He84tewjyDrRrs/4E/zlmN8dx0ND9OkjWgk71a
        aQ3zLx+I3RwtkBAiVIUyIYy4gk4ne7N5pgJpKhq50rT8EQPqEIEv+thUMqKGAzDxSCrnMq
        Fp5u8zKGTD+3XZ0kGuFvqpjgm50Qais=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655145826;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AX/+RA0lmZ3PC7RQsZdCzoesVFiJPYP6V1mryNynG5Y=;
        b=Zg4G+uKUbECnf4hmaH1iNz+wwSxO+y8Vlr5n+vJMT+DcZIZFaAZXreHjKjvt1pQp2Do22X
        w/3R8Q/iWtG8cgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D67AC134CF;
        Mon, 13 Jun 2022 18:43:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WjxBM2GFp2KhIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 13 Jun 2022 18:43:45 +0000
Date:   Mon, 13 Jun 2022 20:39:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Message-ID: <20220613183913.GD20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611135203.27992-1-fmdefrancesco@gmail.com>
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

On Sat, Jun 11, 2022 at 03:52:03PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page(). With
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
> 
> Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in
> this file the mappings are per thread and are not visible in other
> contexts; meanwhile refactor zstd_compress_pages() to comply with nested
> local mapping / unmapping ordering rules.
> 
> Tested with xfstests on a QEMU + KVM 32 bits VM with 4GB of RAM and
> HIGHMEM64G enabled.
> 
> Cc: Filipe Manana <fdmanana@kernel.org>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> @@ -477,15 +479,16 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		/* Check if we need more input */
>  		if (workspace->in_buf.pos == workspace->in_buf.size) {
>  			tot_in += PAGE_SIZE;
> -			kunmap(in_page);
> +			kunmap_local(workspace->out_buf.dst);
> +			kunmap_local((void *)workspace->in_buf.src);

Why is the cast needed? I see that it leads to a warning but we pass a
const buffer and that breaks the API contract as in kunmap it would be
accessed as non-const and potentially changed without warning or
compiler error. If kunmap_local does not touch the buffer and 'const
void*' would work too, then it should be fixed.
