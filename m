Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A128955337B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351128AbiFUNUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 09:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351517AbiFUNUC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 09:20:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD8612AE0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 06:20:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0478A1F97F;
        Tue, 21 Jun 2022 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655817599;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7ke7A2nSXdiTxu2eMCbDO0T8C3rZpvGVDZ6BzDSSic=;
        b=ft/lo9lEXTCGLNzmycGHIo5P3Fa5r4lEdINYyLsJUdrMUz5Y2O+EMRBroKYfB5poGqllqr
        7EYYOOfTDuOY4xotB37IMcbj2pYEnujTPVv8ZHXQvQ44qmvHddeCeaI6nRX3uZ+v8OxHy8
        NH47tnonOqOXHryNCjSX5hv0RFcKBKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655817599;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7ke7A2nSXdiTxu2eMCbDO0T8C3rZpvGVDZ6BzDSSic=;
        b=XItmJAbyDWBiiSTGK9slw5EmCoU0sRVq6SC4HuOJCEeiNN4qml5HRxpb5GFxgBRSaZLodM
        APSDDuJXF14Ox3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0A2513A88;
        Tue, 21 Jun 2022 13:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WJrrMX7FsWLDKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Jun 2022 13:19:58 +0000
Date:   Tue, 21 Jun 2022 15:15:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] btrfs: zlib: refactor how we prepare the buffers
Message-ID: <20220621131521.GW20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
References: <aa6f4902ae200435d9da603dd092e91c4dfdf69e.1655791043.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6f4902ae200435d9da603dd092e91c4dfdf69e.1655791043.git.wqu@suse.com>
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

On Tue, Jun 21, 2022 at 01:59:46PM +0800, Qu Wenruo wrote:
> Inspired by recent kmap() change from Fabio M. De Francesco.
> 
> There are some weird behavior in zlib_compress_pages(), mostly around how
> we prepare the input and output buffers.
> 
> [BEFORE]
> - We hold a page mapped for a long time
>   This is making it much harder to convert kmap() to kmap_local_page(),
>   as such long mapped page can lead to nested mapped page.
> 
> - Different paths in the name of "optimization"
>   When we ran out of input buffer, we will grab the new input with two
>   different paths:
> 
>   * If there are more than one pages left, we copy the content into the
>     input buffer.
>     This behavior is introduced mostly for S390, as that arch needs
>     multiple pages as input buffer for hardware decompression.
> 
>   * If there is only one page left, we use that page from page cache
>     directly without copying the content.
> 
>   This is making page map/unmap much harder, especially due the latter
>   case.
> 
> - Input and output pages can be unmapped at different timing
>   This make it almost impossible to convert the kmap() into
>   kmap_local_page().
> 
>   As kmap_local_page() have strict requirement on the sequence of nested
>   kmap:
>                    OK              |            BAD
>   ---------------------------------+---------------------------------
>   in = kmap_local_page(in_page);   | in = kmap_local_page(in_page);
>   out = kmap_local_page(out_page); | out = kmap_local_page(out_page);

The input pages come from page cache and could be allocated from
highmem but the output pages are allocated by us and only with GFP_NOFS
so they don't need to be kmapped at all, right?

I sent the patches to remove kmap from the compression code but it was
buggy as it removed it from the input pages too. The revert was complete
so we get back to a known state but the output pages do not have to be
mapped. With that removed it should be straightforward to use kmap_local
without any nesting.
