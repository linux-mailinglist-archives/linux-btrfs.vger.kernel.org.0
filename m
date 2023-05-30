Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FF1716A0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjE3Qv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjE3QvZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 12:51:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A42EA
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 09:51:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 108C01F38A;
        Tue, 30 May 2023 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685465481;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3iA7oGZ4o7TxFNHCNB9ePSIDzoRs0F26u7ILvLibxI=;
        b=qZIXhBPrUv5B+VQtnjZ75fKW+ue/wOIBDBvWJjzoFH3fihs8ve6q17jqzsV2/ZMchZOf/T
        jTQAeOrg6X7AoGP6QVTZVJn5feEov9TAmkhVboPbX0B85Sy/gU+TVvfP09IogLKWGtf1Fy
        xmb68Wdk9JUSqbw0YQOToai39BztX+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685465481;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3iA7oGZ4o7TxFNHCNB9ePSIDzoRs0F26u7ILvLibxI=;
        b=uN4KM8jrUTMaRqkEPednkRjGorYiCR5Gn5wngrKgkgWSJDleCbBvUC+k5PV5T+uynQtlTc
        tm3KufZama5PEtBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC27813478;
        Tue, 30 May 2023 16:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UvUUMYgpdmQEOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 16:51:20 +0000
Date:   Tue, 30 May 2023 18:45:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/14] btrfs: mark the len field in struct
 btrfs_ordered_sum as unsigned
Message-ID: <20230530164509.GC30110@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524150317.1767981-4-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 24, 2023 at 05:03:06PM +0200, Christoph Hellwig wrote:
> len can't ever be negative, so mark it as an u32 instead of int.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/ordered-data.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index f0f1138d23c331..2e54820a5e6ff7 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -20,7 +20,7 @@ struct btrfs_ordered_sum {
>  	/*
>  	 * this is the length in bytes covered by the sums array below.
>  	 */
> -	int len;
> +	u32 len;

Due to the int there was one cast to be removed

--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -561,7 +561,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
                        }
 
                        sums->bytenr = start;
-                       sums->len = (int)size;
+                       sums->len = size;
