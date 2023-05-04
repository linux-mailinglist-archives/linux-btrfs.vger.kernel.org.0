Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52856F7911
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 00:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjEDWYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEDWYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 18:24:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0742134
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 15:24:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CFE721AE6;
        Thu,  4 May 2023 22:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683239040;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlUijewmuUkL9G+xkmo8EcCLVi0Mz0afMwo+CpbxqU8=;
        b=pUvRTLIkfbxf9H5zh0yvu6BL5zO2VDYeuWBq/Ba49gV47ztRGhQZMVLUViM/bVni0HO72j
        YFM044xY4BnEX9RcwRfAyOjc+RSuo2AN6a1CFTAxtmp9Bw/93ikLKmuowAeXfgVVTw6jdJ
        C/qfQ4NRBHc6VqWfkTQs9au+8P7kIcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683239040;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlUijewmuUkL9G+xkmo8EcCLVi0Mz0afMwo+CpbxqU8=;
        b=kYgsXZmjrlXgsEr3hkUaIXjXGtHt56VOXRSO9nkyUHMZ4bgUiSTv+MJHbQe6Pd/cSTUwag
        F7REQZOkJLhzatDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2724613444;
        Thu,  4 May 2023 22:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ulq9CIAwVGQKVQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 May 2023 22:24:00 +0000
Date:   Fri, 5 May 2023 00:18:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/7] btrfs-progs: fix -Wmissing-prototypes warnings
 and enable that warning option
Message-ID: <20230504221803.GI6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1683093416.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683093416.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 02:03:36PM +0800, Qu Wenruo wrote:
> We have at least one case that some function is exported but never got
> utilized in the first place.
> 
> Let's prevent this problem from happening again by enable
> -Wmissing-prototypes to debug builds at least.
> 
> Fixes for  the existing warnings are split into several patches:
> 
> - Remove unused functions
>   Two patches, the first is to remove a function that never got
>   utilized from the introduction.
> 
>   The second is to remove a very old feature (only for <3.12 kernels)
>   in libbtrfs.
>   In fact this functionality for fs without an UUID tree is already
>   broken during previous cleanups.
>   (Need to export subvol_uuid_search_add() and
>    subvol_uuid_search_finit(), as it's callers' responsibility to
>    search for the target subvolume by themselves)
> 
>   And since no one is complaining ever since, there is really no need
>   to maintain such an old and deprecated feature in libbtrfs.
> 
> - Fixes for crypto related function
>   Two patches, one for each csum algo (blake2 and sha256).
>   Involves extra declarations in the headers.
> 
> - Trivial fixes
>   Mostly unexport and add needed headers.
> 
> Qu Wenruo (7):
>   btrfs-progs: remove function btrfs_check_allocatable_zones()
>   btrfs-progs: libbtrfs: remove the support for fs without uuid tree
>   btrfs-progs: crypto/blake2: remove blake2 simple API
>   btrfs-progs: crypto/blake2: move optimized declarations to blake2b.h
>   btrfs-progs: crypto/sha: declare the x86 optimized implementation
>   btrfs-progs: fix -Wmissing-prototypes warnings
>   btrfs-progs: Makefile: enable -Wmissing-prototypes

Added to devel, thanks.
