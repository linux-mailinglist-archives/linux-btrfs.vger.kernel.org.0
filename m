Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9A7A6911
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 18:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjISQlH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Sep 2023 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjISQlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Sep 2023 12:41:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5990
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 09:40:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C99822297E;
        Tue, 19 Sep 2023 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695141657;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbd8Ey4gucX3h3CCAXf6QtNbqT9dbsLvI05zPtQHRUw=;
        b=STSiP+YA0nAwDM5hjPTQtj5BRLxiv4Vg/zCb/tgCY9m8W9djWk60yQRnGEzzPEuQCQ+o5l
        tBMHT644upd4IgUjxArlW95BcfuduWyd7TxFOzraZY8SVFl1bJa43gtRu9n+fmDnlbBnlq
        LhrKqdCsyGGsChrWowWpCprhXpQ3SOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695141657;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbd8Ey4gucX3h3CCAXf6QtNbqT9dbsLvI05zPtQHRUw=;
        b=WB0BFn9Y0IZOxvHxgFvI7TX1Z6zro7LZavIMvTmRIAsNCzCEDeV+5VQRGHl5RymUYTIFc2
        W0N3gz47Jsc+etCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EB24134F3;
        Tue, 19 Sep 2023 16:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PJsbERnPCWVlIAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Sep 2023 16:40:57 +0000
Date:   Tue, 19 Sep 2023 18:34:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] btrfs: set the destination memory to zero if
 read_extent_buffer() got invalid ranges
Message-ID: <20230919163420.GW2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e5c99e50cd4f95af1cd8c6c7f9e756c7f9256e58.1695089675.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c99e50cd4f95af1cd8c6c7f9e756c7f9256e58.1695089675.git.wqu@suse.com>
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

On Tue, Sep 19, 2023 at 11:44:42AM +0930, Qu Wenruo wrote:
> Commit f98b6215d7d1 ("btrfs: extent_io: do extra check for extent buffer
> read write functions") changed how we handle invalid extent buffer range
> for read_extent_buffer().
> 
> Previously if the range is invalid we just set the destination to zero,
> but after the patch we do nothing but erroring out.
> 
> This can lead to smatch static checker errors like:
> 
>   fs/btrfs/print-tree.c:186 print_uuid_item() error: uninitialized symbol 'subvol_id'.
>   fs/btrfs/tests/extent-io-tests.c:338 check_eb_bitmap() error: uninitialized symbol 'has'.
>   fs/btrfs/tests/extent-io-tests.c:353 check_eb_bitmap() error: uninitialized symbol 'has'.
>   fs/btrfs/uuid-tree.c:203 btrfs_uuid_tree_remove() error: uninitialized symbol 'read_subid'.
>   fs/btrfs/uuid-tree.c:353 btrfs_uuid_tree_iterate() error: uninitialized symbol 'subid_le'.
>   fs/btrfs/uuid-tree.c:72 btrfs_uuid_tree_lookup() error: uninitialized symbol 'data'.
>   fs/btrfs/volumes.c:7415 btrfs_dev_stats_value() error: uninitialized symbol 'val'.
> 
> Fix those warnings by reverting back to the old memset() behavior.
> By this we keep the static checker happy and would still make a lot of
> noise when such invalid ranges are passed in.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: f98b6215d7d1 ("btrfs: extent_io: do extra check for extent buffer read write functions")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This looks useful to be fixed independ of the contig eb pages patchset
so I'll apply it now. The warnings reported by linux-next shoud be fixed
by that too. Thanks.
