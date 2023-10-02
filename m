Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3747B53ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjJBNQt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbjJBNQn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 09:16:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB30B0
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 06:16:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB4EF1F747;
        Mon,  2 Oct 2023 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696252599;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOW9G2zozQY18tBevIoC+Nqm5eE69IcSZAoItZNKL4A=;
        b=AZXoT1oT31Q/jwVUDTSByerX1mAvFkcKAB/BQF+P26np2MRdUnfiwmAjFOGgp8ETGrdm5N
        i7T+kBVIeqZZE/HIMUCo+0zadE4exW/I7x7treTerCB/2NkeOkEGxY2gnP7BszfmY7TC1l
        D4WYAIdiYWtVLHyF3nUh8ODMtNJoVD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696252599;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOW9G2zozQY18tBevIoC+Nqm5eE69IcSZAoItZNKL4A=;
        b=SokcXXSHQHmAgHrlvEv8AbWH3fQPdwsjUOMYMGbW3dFhnrtBiC4V8bNIu0Sy2I9MguW8rR
        ND7dhr5CMo1zE8Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80A0513456;
        Mon,  2 Oct 2023 13:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6eKKHrfCGmWWQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 13:16:39 +0000
Date:   Mon, 2 Oct 2023 15:09:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/3] btrfs: adjust overcommit logic and fixes
Message-ID: <20231002130958.GP13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695836511.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695836511.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 27, 2023 at 01:46:58PM -0400, Josef Bacik wrote:
> Hello,
> 
> This is an update to my original patch
> 
> https://lore.kernel.org/linux-btrfs/b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com/
> 
> This was causing failures with btrfs/156 and btrfs/177.  The btrfs/156 problem
> was caused by the fact that I was just subtracting 1g from the available space.
> I missed a spot where we also limit the chunk size to 10% of the file system, so
> I've updated the calculation to be exactly what we choose from the chunk
> allocator, and this resovled the btrfs/156 failure.
> 
> The btrfs/177 failure was actually due to a underflow in ->free_chunk_space
> where we weren't adding the new space we got from btrfs_grow_device.  I also
> noticed a slight issue with how we remove space from ->free_chunk_space in
> btrfs_srhink_device so I fixed that as well.
> 
> With these 3 patches we're no longer seeing the above failures and the original
> test case is also fixed.  Thanks,
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs: fix ->free_chunk_space math in btrfs_shrink_device
>   btrfs: increase ->free_chunk_space in btrfs_grow_device
>   btrfs: adjust overcommit logic when very close to full

Added to misc-next, thanks.
