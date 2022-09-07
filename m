Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD385B0CAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 20:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiIGSrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 14:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIGSrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 14:47:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A73844E0
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 11:47:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C7653403D;
        Wed,  7 Sep 2022 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662576459;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y92W8rO1jtl3QZIPTOuNXvoO+oPCAVNtyzn98T+64+k=;
        b=NwITRp6gXocyDqA/yJi7E8sJtIXcylXKhiq9I3bU1Tz/5A8EpAITovL7BaMo4bzPuCeCuA
        Gf+F4VnPrHcskcaN+bA5mH16i9F4Xt5UDuifSmBUuxLWHdVi2nLH5kOx6v2uyvtHLYFn9g
        3xJHVS8PXVVarPEHA6GfUzcaStNtJd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662576459;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y92W8rO1jtl3QZIPTOuNXvoO+oPCAVNtyzn98T+64+k=;
        b=VIW/D25d+qvD1VIGO0U5HHbdJcfCv6eK0PjsKdz6KZXNFi6IF4rX/3RW1hVgYg0iBXKIBj
        iJadF+YYYrbYczBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B9C413486;
        Wed,  7 Sep 2022 18:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ly++CUvnGGOAIwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 07 Sep 2022 18:47:39 +0000
Date:   Wed, 7 Sep 2022 20:42:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/31] btrfs: move extent_io_tree code and cleanups
Message-ID: <20220907184215.GA32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
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

On Fri, Sep 02, 2022 at 04:16:05PM -0400, Josef Bacik wrote:
> Josef Bacik (31):
>   btrfs: cleanup clean_io_failure
>   btrfs: unexport internal failrec functions
>   btrfs: stop using extent_io_tree for io_failure_record's
>   btrfs: use find_first_extent_bit in btrfs_clean_io_failure
>   btrfs: separate out the extent state and extent buffer init code
>   btrfs: separate out the eb and extent state leak helpers
>   btrfs: temporarily export alloc_extent_state helpers
>   btrfs: move extent state init and alloc functions to their own file
>   btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to ASSERT's
>   btrfs: move simple extent bit helpers out of extent_io.c
>   btrfs: export wait_extent_bit
>   btrfs: move the core extent_io_tree code into extent-io-tree.c
>   btrfs: remove struct tree_entry
>   btrfs: use next_state instead of rb_next where we can
>   btrfs: make tree_search return struct extent_state
>   btrfs: make tree_search_for_insert return extent_state
>   btrfs: make tree_search_prev_next return extent_state's
>   btrfs: use next_state/prev_state in merge_state
>   btrfs: remove temporary exports for extent_state movement
>   btrfs: move irrelevant prototypes to their appropriate header
>   btrfs: drop exclusive_bits from set_extent_bit
>   btrfs: remove the wake argument from clear_extent_bits
>   btrfs: remove failed_start argument from set_extent_bit
>   btrfs: drop extent_changeset from set_extent_bit
>   btrfs: unify the lock/unlock extent variants
>   btrfs: get rid of track_uptodate
>   btrfs: get rid of ->dirty_bytes
>   btrfs: don't clear CTL bits when trying to release extent state
>   btrfs: replace delete argument with EXTENT_CLEAR_ALL_BITS
>   btrfs: don't init io tree with private data for non inodes
>   btrfs: remove is_data_inode() checks in extent-io-tree.c

The self tests don't pass

[   13.933867] Btrfs loaded, crc32c=crc32c-generic, debug=on, assert=on, integrity-checker=on, ref-verify=on, zoned=yes, fsverity=yes                                                                                
[   13.936232] BTRFS: selftest: sectorsize: 4096  nodesize: 4096                                                                                                                                                     
[   13.937186] BTRFS: selftest: running btrfs free space cache tests                                                                                                                                                 
[   13.938314] BTRFS: selftest: running extent only tests                                                                                                                                                            
[   13.939327] BTRFS: selftest: running bitmap only tests                                                                                                                                                            
[   13.940285] BTRFS: selftest: running bitmap and extent tests                                                                                                                                                      
[   13.941288] BTRFS: selftest: running space stealing from bitmap to extent tests                                                                                                                                   
[   13.942627] BTRFS: selftest: running bytes index tests                                                                                                                                                            
[   13.943681] BTRFS: selftest: running extent buffer operation tests                                                                                                                                                
[   13.944868] BTRFS: selftest: running btrfs_split_item tests                                                                                                                                                       
[   13.945641] BTRFS: selftest: running extent I/O tests                                                                                                                                                             
[   13.946662] BTRFS: selftest: running find delalloc tests                                                                                                                                                          
[   14.226329] BTRFS: selftest: running find_first_clear_extent_bit test                                                                                                                                             
[   14.227517] BTRFS: selftest: fs/btrfs/tests/extent-io-tests.c:528 error finding trimmed range: start 67108864 end 33554431                                                                                        
[   14.229160] BTRFS: selftest: io tree content:                                                                                                                                                                     
[   14.229873] BTRFS: selftest:   start=1048576 len=3145728 flags=DIRTY|DEFRAG                                                                                                                                       
[   14.231208] BTRFS: selftest:   start=33554432 len=33554432 flags=DIRTY|DEFRAG
