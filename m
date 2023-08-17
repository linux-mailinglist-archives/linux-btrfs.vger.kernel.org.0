Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A85E77F74C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbjHQNGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 09:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351398AbjHQNG0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 09:06:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC56835AD
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 06:06:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DFBD21F37F;
        Thu, 17 Aug 2023 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692277490;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwXsIqenf9XGMRSYvbrzux5xj71G55coXZCD8QvMWRE=;
        b=cEQriW2ALYVijVk6QCrYmMbFwSaYbv73CaP37eUSHLHzhTB8zFffOXpjY/uygie5ynnhN5
        vXKSqF+k7QCgxOqYCycp22d/aU0SXX8PIyasDtMPYEoXpES88ihYy/rZ3xQDOIOJA3Qt6n
        Iv/ZAd1h3/RM91Ji9/4k1lazTZXWsQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692277490;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwXsIqenf9XGMRSYvbrzux5xj71G55coXZCD8QvMWRE=;
        b=ATp4saVzhdnIBRYwoUvDaDCVqVbidCr5jJS2cHfSeQxTRQlDtmUw9FLr4QvFs2XY0gnXyk
        h7Z7ysi/1rFBuLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA2681392B;
        Thu, 17 Aug 2023 13:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W9+OMPIa3mTzcgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 13:04:50 +0000
Date:   Thu, 17 Aug 2023 14:58:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/17] btrfs: some misc stuff around space flushing and
 enospc handling
Message-ID: <20230817125822.GR2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
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

On Wed, Jul 26, 2023 at 04:56:56PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A few fixes, improvements, cleanups around space flushing, enospc handling,
> debugging. These came out while debugging an image of a fs that fails to
> mount due to being out of unallocated space and having only about 1.6M of
> free metadata space, which is not enough to commit any transaction triggered
> during mount while doing orphan cleanup, resulting in transactions aborts
> either when running delayed refs or somewhere in the critical section of a
> transaction commit. These patches do not prevent getting into that situation,
> but that will be attempted by other patches in a separate patchset.
> 
> Filipe Manana (17):
>   btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART
>   btrfs: update comment for btrfs_join_transaction_nostart()
>   btrfs: print target number of bytes when dumping free space
>   btrfs: print block group super and delalloc bytes when dumping space info
>   btrfs: print available space for a block group when dumping a space info
>   btrfs: print available space across all block groups when dumping space info
>   btrfs: don't steal space from global rsv after a transaction abort
>   btrfs: store the error that turned the fs into error state
>   btrfs: return real error when orphan cleanup fails due to a transaction abort
>   btrfs: fail priority metadata ticket with real fs error
>   btrfs: make btrfs_cleanup_fs_roots() static
>   btrfs: make find_free_dev_extent() static
>   btrfs: merge find_free_dev_extent() and find_free_dev_extent_start()
>   btrfs: avoid starting new transaction when flushing delayed items and refs
>   btrfs: avoid starting and committing empty transaction when flushing space
>   btrfs: avoid start and commit empty transaction when starting qgroup rescan
>   btrfs: avoid start and commit empty transaction when flushing qgroups

Looks like I forgot to reply, the patchset has been in misc-next for
some time. Thanks.
