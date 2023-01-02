Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95865B44E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 16:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjABPf2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 10:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjABPf1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 10:35:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F3A459
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 07:35:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 27FD034215;
        Mon,  2 Jan 2023 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672673725;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryX+Xq4OZDf/F0piZ5MmqKzKd8Kw/UsRkwBg3diDcHg=;
        b=t9NMSWW/QDHhvMPDv0XMrwHqsgP+TyPGg/Q3qlA+cEDZd2EZWF4Je49faoUQqgGEKXMspT
        jScSSq33FfDnWv25AbKx4C147nGktjjLl5ndRJG2SCyZllOAb42KBbUDNniKwDu78GbqSC
        G9msH7fEFxF1xLIIc1i9/yBvnLzRZCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672673725;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryX+Xq4OZDf/F0piZ5MmqKzKd8Kw/UsRkwBg3diDcHg=;
        b=tCNtXldmb2+SCHFupS8KF+3j7HijzSvKLbTyVlNfOZszJTIwEq7Z3CPl16MkMffHq5WAsM
        5+jV/AZw6ixLCaCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F24CB13427;
        Mon,  2 Jan 2023 15:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0T1JOrz5smO0bAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 15:35:24 +0000
Date:   Mon, 2 Jan 2023 16:29:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix off-by-one in delalloc search during lseek
Message-ID: <20230102152954.GI11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <da314182610b43632ca81ba78ff73fac5ae1bf06.1671820088.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da314182610b43632ca81ba78ff73fac5ae1bf06.1671820088.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 23, 2022 at 06:28:53PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During lseek, when searching for delalloc in a range that represents a
> hole and that range has a length of 1 byte, we end up not doing the actual
> delalloc search in the inode's io tree, resulting in not correctly
> reporting the offset with data or a hole. This actually only happens when
> the start offset is 0 because with any other start offset we round it down
> by sector size.
> 
> Reproducer:
> 
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt/sdc
> 
>   $ xfs_io -f -c "pwrite -q 0 1" /mnt/sdc/foo
> 
>   $ xfs_io -c "seek -d 0" /mnt/sdc/foo
>   Whence   Result
>   DATA	   EOF
> 
> It should have reported an offset of 0 instead of EOF.
> 
> Fix this by updating btrfs_find_delalloc_in_range() and count_range_bits()
> to deal with inclusive ranges properly. These functions are already
> suppossed to work with inclusive end offsets, they just got it wrong in a
> couple places due to off-by-one mistakes.
> 
> A test case for fstests will be added later.
> 
> Reported-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/20221223020509.457113-1-joanbrugueram@gmail.com/
> Fixes: b6e833567ea1 ("btrfs: make hole and data seeking a lot more efficient")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
