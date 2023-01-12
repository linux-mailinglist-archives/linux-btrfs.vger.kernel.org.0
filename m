Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC6667898
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 16:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbjALPHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 10:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbjALPGo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 10:06:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC12C46
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 06:55:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10CB34003F;
        Thu, 12 Jan 2023 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673535334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/XdPeBJgkd/S1YhBPc9tzria1Oa4o4PTphBzx7X9jWc=;
        b=XXCEWcXY5mTblNGYFvnrbWs26/Z083SNv466gSwTNV/4zUuSO0LwvKApvUSUo2HNJDzolf
        E3zqHWRHlvpbp8kJaZpbF9PYqhaABC19O/Kh9c/c5/hUiVziD8mlQxcH1Kx905yWa0uxl8
        clcmHBdW6FUaKDC4SiHTdi0/dumAxFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673535334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/XdPeBJgkd/S1YhBPc9tzria1Oa4o4PTphBzx7X9jWc=;
        b=8EWiEGEsYrrrS+Pk861kf+X8sNgAY3wbr0VI/IuuOr01V1mLHER4/78sl7Ud24tQ4fmeXE
        bkPBUZDWmqxu/PAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9F3C13776;
        Thu, 12 Jan 2023 14:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ICfrM2UfwGOKFQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Jan 2023 14:55:33 +0000
Date:   Thu, 12 Jan 2023 15:49:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix invalid leaf access due to inline extent
 during lseek
Message-ID: <20230112144958.GN11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <860221a4cf1642689ed17404c12b920d1acf1019.1673532966.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860221a4cf1642689ed17404c12b920d1acf1019.1673532966.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 12, 2023 at 02:17:20PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During lseek, for SEEK_DATA and SEEK_HOLE modes, we access the disk_bytenr
> of anextent without checking its type. However inline extents have their
> data starting the offset of the disk_bytenr field, so accessing that field
> when we have an inline extent can result in either of the following:
> 
> 1) Interpret the inline extent's data as a disk_bytenr value;
> 
> 2) In case the inline data is less than 8 bytes, we access part of some
>    other item in the leaf, or unused space in the leaf;
> 
> 3) In case the inline data is less than 8 bytes and the extent item is
>    the first item in the leaf, we can access beyond the leaf's limit.
> 
> So fix this by not accessing the disk_bytenr field if we have an inline
> extent.
> 
> Fixes: b6e833567ea1 ("btrfs: make hole and data seeking a lot more efficient")
> Reported-by: Matthias Schoepfer <matthias.schoepfer@googlemail.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216908
> Link: https://lore.kernel.org/linux-btrfs/7f25442f-b121-2a3a-5a3d-22bcaae83cd4@leemhuis.info/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
