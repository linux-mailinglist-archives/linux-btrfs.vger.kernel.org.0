Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887DC54036F
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 18:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbiFGQLI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbiFGQLH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 12:11:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BFFF5BD
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 09:11:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6C5E21B6C;
        Tue,  7 Jun 2022 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654618263;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nQxsD/TivTHk+ReL6w5tYoKse7WOrGPU5BUik5bpqjA=;
        b=MapaznKytIR9v0xwHRW/g4RjfR3NJ/G9KTzxWJT/DNdk6Z2jI7WLR7kqXhaKQNNxXVtLnH
        ykXR3MZNE9ZcdDanPWKJFtpYQaYyNukzG3yelv9k8z8wvfs4gZ8sZCndLm0qhDsoHDi8Cr
        E39450VLgffF9A9uHLMBGIzEXDcvuDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654618263;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nQxsD/TivTHk+ReL6w5tYoKse7WOrGPU5BUik5bpqjA=;
        b=0Q4l8lJyVsQv2ncgWUsJSbRornQrBhzUoRgV2RgFwtlLt0uFtxRIm4PcsBQUvsrBTBrs6S
        7cftRT6vI7kMl9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95E8A13638;
        Tue,  7 Jun 2022 16:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1vOZI5d4n2KVcwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 07 Jun 2022 16:11:03 +0000
Date:   Tue, 7 Jun 2022 18:06:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: split discard handling out of btrfs_map_block
Message-ID: <20220607160634.GN20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20220603065725.40708-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603065725.40708-1-hch@lst.de>
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

On Fri, Jun 03, 2022 at 08:57:25AM +0200, Christoph Hellwig wrote:
> Mapping block for discard doesn't really share any code with the regular
> block mapping case.  Split it out into an entirely separate helper
> that just returns an array of btrfs_discard_stripe structures and the
> number of stripes.
> 
> This removes the need for the length field in the btrfs_io_context
> structure, so remove tht.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, thanks.

>  	/* we don't discard raid56 yet */
> -	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> +	ret = -EOPNOTSUPP;
> +	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> +		goto out_free_map;

Please don't use this error value pattern in btrfs code, the preferred
style is

	if (condition()) {
		ret = ERROR;
		goto label;
	}
