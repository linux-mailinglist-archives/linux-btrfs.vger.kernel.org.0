Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9310C555128
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 18:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376557AbiFVQSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 12:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiFVQS3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 12:18:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB361A812
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 09:18:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D57B1F86A;
        Wed, 22 Jun 2022 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655914704;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=askeZrLlJVImhXxV6qlwOH04LnOT2Y27zeRy1BrxKtw=;
        b=EIXlmOvJDph5ruUmWAk69KLtuv8a1Ym5tHGUwj2uPbMCPHJaJg7ncuRVeE2ZKR0W916GO2
        FqSzlK12vmgXU4tMUBsjh+rZiLsKV3GJ9pH6uV0zir6FMTIhpajBy6FydRndRkxVMYN70p
        ZkQh+cV4/0bLKtpR6/BAiZS9GBGOSnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655914704;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=askeZrLlJVImhXxV6qlwOH04LnOT2Y27zeRy1BrxKtw=;
        b=nxr3SKPcuEp1u1L3DBi8zvdnJ1DS9XFTuaIqbRgsrnnjCqFnWr8wiJVgW7EfbQBjJvqTpf
        DYUDhCtiWSQR/hCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BB99134A9;
        Wed, 22 Jun 2022 16:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id flNtCdBAs2KpDgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Jun 2022 16:18:24 +0000
Date:   Wed, 22 Jun 2022 18:13:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: reduce amount of reserved metadata for delayed
 item insertion
Message-ID: <20220622161343.GK20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <9290acc4c095b2191f33637948d8020b90ff302d.1655889343.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9290acc4c095b2191f33637948d8020b90ff302d.1655889343.git.fdmanana@suse.com>
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

On Wed, Jun 22, 2022 at 10:37:45AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
...
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> V2: Fixed an underflow on the size of the delayed block reserve's size,
>     which was caused by computing the number of leaves used by diving
>     the total dir index item byte size by the maximum leaf data size.
>     That computation works most of the time, but often its result is
>     not correct. For example for a leaf size of 4K, we have a max leaf
>     data size of 3995 bytes, and if we have 117 dir index items to
>     insert, each with a size of 68 bytes, then we had:
> 
>     (117 * 68) / 3995 = 1.99, rounded up to 2
> 
>     But that resulted in inserting 3 batches (use 3 leaves) and not 2:
> 
>     1) First batch with 58 items, total size of 3944 bytes;
>     2) Second batch with another 58 items, total size of 3944 bytes;
>     3) Third batch with a single item, total size of 68 bytes.
> 
>     This resulted in releasing space for a leaf that was never reserved,
>     and whence the underflow on the size of the delayed block reserve.
>     In practice that is actually very rare, because our limit on the
>     number of pending delayed items makes us flush delayed items before
>     we have enough items to cover more than 1 leaf, even with a leaf
>     size of 4K. This was initially reported by the lkp test robot at:
> 
>     https://lore.kernel.org/linux-btrfs/20220608152303.GB31193@xsang-OptiPlex-9020/
> 
>     It could also be sporadically triggered by generic/619.
> 
>     Also added missing tracepoints when releasing space from the delayed
>     block reserve and the transaction block reserve.

Patch replaced in misc-next, thanks.
