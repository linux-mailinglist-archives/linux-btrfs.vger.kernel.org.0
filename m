Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6F79428C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 19:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbjIFR5C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 13:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjIFR5A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 13:57:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7A01FD7
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 10:56:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44D4122272;
        Wed,  6 Sep 2023 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694022948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YS4TqNxV8dJucQWQekRmVLi9rMvnZKpqZqhURrlRF2U=;
        b=uf3nIg2bZmsi09ooUCBE5IxMzKa2wsT9MWFjoSqd51D9CgvlYqqWH2cizkt0gNYGlEtipd
        iQ5TzMxAxrfukcvUNWGvl6pRUsUKM0qERB2LNmPg5dGfpewrmrBPpdPT38bFfaUyxwsmxY
        2D5qJWGHtun8UnB/rZcwz0b8H70jYj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694022948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YS4TqNxV8dJucQWQekRmVLi9rMvnZKpqZqhURrlRF2U=;
        b=LwWuKDUNdNm1g/uQPBne0qR1/naIngciYrBFdDhnFTKWV1v3CHDm5wmI0XjKwI/BKh6j+7
        lAq9jGASXOgJt0BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 120DF1333E;
        Wed,  6 Sep 2023 17:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E0zHAyS9+GQuKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 17:55:48 +0000
Date:   Wed, 6 Sep 2023 19:49:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: make extent buffer memory continuous
Message-ID: <20230906174907.GU14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692858397.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692858397.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_SOFTFAIL,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 02:33:35PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> RFC->v1:
> - Rebased to the latest misc-next branch
>   Just a small conflicts in extent_buffer_memmove().
> 
> - Further cleanup the extent buffer bitmap operations
> 
> [REPO]
> https://github.com/adam900710/linux/tree/eb_page_cleanups
> 
> This includes the submitted extent buffer accessors cleanup as
> the dependency.
> 
> [BACKGROUND]
> We have a lot of extent buffer code addressing the cross-page accesses, on
> the other hand, other filesystems like XFS is mapping its xfs_buf into
> kernel virtual address space, so that they can access the content of
> xfs_buf without bothering the page boundaries.
> 
> [OBJECTIVE]
> This patchset is mostly learning from the xfs_buf, to greatly simplify
> the extent buffer accessors.
> 
> Now all the extent buffer accessors are turned into wrappers of
> memcpy()/memcmp()/memmove().
> 
> For now, it can pass test cases from btrfs group without new
> regressions.
> 
> Qu Wenruo (3):
>   btrfs: warn on tree blocks which are not nodesize aligned
>   btrfs: map uncontinuous extent buffer pages into virtual address space
>   btrfs: utilize the physically/virtually continuous extent buffer
>     memory

My objections stand and we can continue the discussion under the RFC
series, but for testing purposes I'll add the series to for-next.
