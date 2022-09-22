Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055A05E6875
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIVQcY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiIVQb6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 12:31:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BFEE8DBA
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 09:31:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 809081F920;
        Thu, 22 Sep 2022 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663864276;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WtNOyWaVGOe0/INfHF+PjXsTxITXabsm/TCA9MZAey8=;
        b=VyiI1RkoDaG/MPD+ULMmlOVCCcJnOs9Ga49ilMdCIzQbXR6U7GUVLCF+f7PSxK7QZCUIOY
        jQCAKvpSSnbHEY1h4a2LGbUHB35Vk7CppR8FkzlYbuV7yXOiXhGvxS2rz0rChHYW5B8KeG
        eS3yV5v5ztBgFoihw7wrf/vgS+PJe4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663864276;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WtNOyWaVGOe0/INfHF+PjXsTxITXabsm/TCA9MZAey8=;
        b=LJP9M6eF2z2YaCZSx5dSZ6tWff96Nt7Bj3Xm+/EHoXxyUaMI28YwiK3vDXw9HhWRvK+7F/
        mzWdOTbWSwY1vtCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59F0D13AA5;
        Thu, 22 Sep 2022 16:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P1YlFdSNLGPmSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 22 Sep 2022 16:31:16 +0000
Date:   Thu, 22 Sep 2022 18:25:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/13] btrfs: fixes and cleanups around extent maps
Message-ID: <20220922162543.GM32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663594828.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 19, 2022 at 03:06:27PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patchset fixes a bug related to dropping extent maps that
> can make an fsync miss a new extent, does several cleanups and some
> small performance improvements when dropping and searching for extent
> maps as well as when flushing delalloc in COW mode. These came out while
> working on some upcoming changes for fiemap, but since they are really
> independent, I'm sending them as a separate patchset.
> The last patch in the series has a test and results in its changelog.
> 
> Filipe Manana (13):
>   btrfs: fix missed extent on fsync after dropping extent maps
>   btrfs: move btrfs_drop_extent_cache() to extent_map.c
>   btrfs: use extent_map_end() at btrfs_drop_extent_map_range()
>   btrfs: use cond_resched_rwlock_write() during inode eviction
>   btrfs: move open coded extent map tree deletion out of inode eviction
>   btrfs: add helper to replace extent map range with a new extent map
>   btrfs: remove the refcount warning/check at free_extent_map()
>   btrfs: remove unnecessary extent map initializations
>   btrfs: assert tree is locked when clearing extent map from logging
>   btrfs: remove unnecessary NULL pointer checks when searching extent maps
>   btrfs: remove unnecessary next extent map search
>   btrfs: avoid pointless extent map tree search when flushing delalloc
>   btrfs: drop extent map range more efficiently

Added to misc-next, namely for the first fix but the cleanups seem safe
and the last patch with the performance improvement will be another one
for the 6.1. Thanks.
