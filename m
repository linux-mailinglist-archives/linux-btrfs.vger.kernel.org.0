Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F96F8A76
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjEEU5j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 16:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjEEU5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 16:57:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB8C0
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 13:57:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CEDE022AFC;
        Fri,  5 May 2023 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683320255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iuR/EL3Fx2rds2+ls9WQmoflpvqcbi7Fe/lOJd1Ysto=;
        b=Sq1cFbY851+ZRpEUix4cl3TOB4WzqlzEXEsq1bn/Wzau40D/kpOGZdkJy2heHd24Qwm+sh
        qKkceuGgIk5bU6lkq+RF7YLyLQO3xBI9LlkUkCI02Mrz1PCHy64AdPKIg5j4h6ydERJXjJ
        wHxYpXmf2YVicRAZ9zJIqYrCMc3LmI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683320255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iuR/EL3Fx2rds2+ls9WQmoflpvqcbi7Fe/lOJd1Ysto=;
        b=wtCM/Z7evkYe06yFduEE34b7Mz7YTsI+kBrNbzkKuw7NVRS/7cOqnMPnrtF4deAb/HWJGB
        P0SY7So68t5FVkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8C2113488;
        Fri,  5 May 2023 20:57:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o3xmKL9tVWQiEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 20:57:35 +0000
Date:   Fri, 5 May 2023 22:51:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs: some free space cache fixes and updates
Message-ID: <20230505205138.GT6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1683196407.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683196407.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 04, 2023 at 12:04:17PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Several updates to the free space cache code (most of it to the in memory
> data structure, shared between the free space cache and the free space
> tree). A bug fix, some cleanups, minor optimizations and adding several
> asserts to verify we are holding the necessary lock(s) when udpating the
> in memory space cache - this was motivated by an attempt to debug an
> invalid memory access when manipulating the in memory free space cache,
> as I suspected we had some code path not taking a required lock before
> manipulating the in memory red black tree of free space entries.
> 
> Filipe Manana (9):
>   btrfs: fix space cache inconsistency after error loading it from disk

Oh, that was an old bug.

>   btrfs: avoid extra memory allocation when copying free space cache
>   btrfs: avoid searching twice for previous node when merging free space entries
>   btrfs: use precomputed end offsets at do_trimming()
>   btrfs: simplify arguments to tree_insert_offset()
>   btrfs: assert proper locks are held at tree_insert_offset()
>   btrfs: assert tree lock is held when searching for free space entries
>   btrfs: assert tree lock is held when linking free space
>   btrfs: assert tree lock is held when removing free space entries

Added to misc-next, thanks.
