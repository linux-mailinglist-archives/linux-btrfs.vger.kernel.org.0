Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3856598304
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbiHRMPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 08:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbiHRMPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 08:15:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11103B24BB
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 05:15:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C424F5BEE2;
        Thu, 18 Aug 2022 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660824944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2tycvhl3yipeE9Adj0uGuTW/gBv3BTfknVbdYn0CWYU=;
        b=Al0dzHpYzrFP0ee+9D/WLMZFYonBF5/35TUgB0UcM91tvGqlUMgmfgFxw0JsTrGNT5Ugls
        X5ryUcu4f2k8Xh9rMoc27NP5oKohdTg+Vp/RMKkb36TNLpvQq5vOYihiz3AcLtG2mFESYq
        eviHPZVSKS0CQoHa8JSN3HqaEkFzcyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660824944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2tycvhl3yipeE9Adj0uGuTW/gBv3BTfknVbdYn0CWYU=;
        b=ltYCuTWyp1UQlcFwL3D2rGb87WKCo+BY2a0OMbm7cSSyVWK+jLnIib3fcsEuCNhB0twIgc
        qJYMJaaT/AeZliCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A568E139B7;
        Thu, 18 Aug 2022 12:15:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3F1rJ3At/mLxPwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 18 Aug 2022 12:15:44 +0000
Date:   Thu, 18 Aug 2022 14:10:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update generation of hole file extent item when
 merging holes
Message-ID: <20220818121033.GH13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <98d51d2ad8fca034c9605605394c15b516f13e5d.1659956764.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d51d2ad8fca034c9605605394c15b516f13e5d.1659956764.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 08, 2022 at 12:18:37PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When punching a hole into a file range that is adjacent with a hole and we
> are not using the no-holes feature, we expand the range of the adjacent
> file extent item that represents a hole, to save metadata space.
> 
> However we don't update the generation of hole file extent item, which
> means a full fsync will not log that file extent item if the fsync happens
> in a later transaction (since commit 7f30c07288bb9e ("btrfs: stop copying
> old file extents when doing a full fsync")).
> 
> For example, if we do this:
> 
>     $ mkfs.btrfs -f -O ^no-holes /dev/sdb
>     $ mount /dev/sdb /mnt
>     $ xfs_io -f -c "pwrite -S 0xab 2M 2M" /mnt/foobar
>     $ sync
> 
> We end up with 2 file extent items in our file:
> 
> 1) One that represents the hole for the file range [0, 2M), with a
>    generation of 7;
> 
> 2) Another one that represents an extent covering the range [2M, 4M).
> 
> After that if we do the following:
> 
>     $ xfs_io -c "fpunch 2M 2M" /mnt/foobar
> 
> We end up with a single file extent item in the file, which represents a
> hole for the range [0, 4M) and with a generation of 7 - because we end
> dropping the data extent for range [2M, 4M) and then update the file
> extent item that represented the hole at [0, 2M), by increasing
> length from 2M to 4M.
> 
> Then doing a full fsync and power failing:
> 
>     $ xfs_io -c "fsync" /mnt/foobar
>     <power failure>
> 
> will result in the full fsync not logging the file extent item that
> represents the hole for the range [0, 4M), because its generation is 7,
> which is lower than the generation of the current transaction (8).
> As a consequence, after mounting again the filesystem (after log replay),
> the region [2M, 4M) does not have a hole, it still points to the
> previous data extent.
> 
> So fix this by always updating the generation of existing file extent
> items representing holes when we merge/expand them. This solves the
> problem and it's the same approach as when we merge prealloc extents that
> got written (at btrfs_mark_extent_written()). Setting the generation to
> the current transaction's generation is also what we do when merging
> the new hole extent map with the previous one or the next one.
> 
> A test case for fstests, covering both cases of hole file extent item
> merging (to the left and to the right), will be sent soon.
> 
> Fixes: 7f30c07288bb9e ("btrfs: stop copying old file extents when doing a full fsync")
> CC: stable@vger.kernel.org # 5.18+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
