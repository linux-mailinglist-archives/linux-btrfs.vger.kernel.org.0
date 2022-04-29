Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3315153E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378588AbiD2SrD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347973AbiD2SrC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:47:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDF6C3E10
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:43:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D48321872;
        Fri, 29 Apr 2022 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651257822;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QjtN2vYhrYeSgqETQTiPfFy71HRggf154wIGZCj9cQ=;
        b=il90qZiybuDfr9C+kxIZxWBbhWkmwtgCKdLvre4gOtnD4WguZZw0yFsTgbcEwITjVuTGIH
        m+fMlnnFiFhoezyQzD0misws6dYgJjJGiDSac3nSzCojdAaH2Z3aDS0TALe5jMqZFDhCFF
        aHQ37V/oT8xLSoGJ7QWwJNz39eSpJVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651257822;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QjtN2vYhrYeSgqETQTiPfFy71HRggf154wIGZCj9cQ=;
        b=SPoXQbwB8lIN62UcK+FuMMOXrpVZUCHZrIakKj4Fo3QykLNKourTGg9JvtHKEsRtAJqyv/
        gQKz6VKVri3FKvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEF0F13AE0;
        Fri, 29 Apr 2022 18:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nxoiOd0xbGJidAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Apr 2022 18:43:41 +0000
Date:   Fri, 29 Apr 2022 20:39:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: Turn fs_info member buffer_radix into XArray
Message-ID: <20220429183932.GF18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20220421154538.413-1-gniebler@suse.com>
 <8fa5a2af-7335-108b-9ce3-a45270331b4a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa5a2af-7335-108b-9ce3-a45270331b4a@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 05:14:15PM +0300, Nikolay Borisov wrote:
> > -		cur = gang[ret - 1]->start + gang[ret - 1]->len;
> >   	}
> 
> nit: The body of the loop can be turned into:
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index da3d9dc186cd..7c1d5fec59dd 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -7318,16 +7318,13 @@ static struct extent_buffer *get_next_extent_buffer(
> 
>          xa_for_each_start(&fs_info->extent_buffers, index, eb,
>                            page_start >> fs_info->sectorsize_bits) {
> -               if (eb->start >= page_start + PAGE_SIZE)
> +               if (in_range(eb->start, page_start, PAGE_SIZE))
> +                       return eb;
> +               else if (eb->start >= page_start + PAGE_SIZE)
>                          /* Already beyond page end */
> -                       break;
> -               if (eb->start >= bytenr) {
> -                       /* Found one */
> -                       found = eb;
> -                       break;
> -               }
> +                       return NULL;
>          }
> -       return found;
> +       return NULL;
>   }
> 
> 
> That is use the in_range macro to detect when we have an eb between 
> page_start and page_start + PAGE_SIZE in which case we can directly 
> return it, and the in_range is self-documenting. And directly return 
> NULL in case of eb->start going beyond the current page and in case we 
> didn't find anything.  David, what do you think?

I like it and folded to the patch, thanks. The variable 'found' becomes
unused so removed as well.
