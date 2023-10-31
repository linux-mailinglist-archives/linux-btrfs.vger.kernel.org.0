Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718F87DCF70
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjJaOdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjJaOdP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 10:33:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096CFED
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 07:33:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF4AF2185D;
        Tue, 31 Oct 2023 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698762791;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qaXAbXjRTvkyXCE2eBGbhkm03ewFhr7hcmudwyvOUc=;
        b=g5sOv1DtEbUFYTcGGSIsRtOfDM8o055qRsurzW2AgCUo36tm/v5VonraYkT3OdAQp+THeu
        ZH4SFAaVduBgwrsyc1rjwMEkplkrKcmfBV8zJUCwreJzBhf2N4NwFnoIZNTo9F2iR4Gue3
        DHZvaF3ZBt9oU8g8H7H8RkRmfxM+APU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698762791;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qaXAbXjRTvkyXCE2eBGbhkm03ewFhr7hcmudwyvOUc=;
        b=4oxtctvYFH/JOjV1lzSJN57HN2ZsRQBLKiQ97rMJry28tLwTS21b+DKJ2GFuJqR7wYSzOE
        MBYy+ggwVq1LpDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9506C1391B;
        Tue, 31 Oct 2023 14:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nLqkIycQQWVBFQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 31 Oct 2023 14:33:11 +0000
Date:   Tue, 31 Oct 2023 15:26:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: do not utilize goto to implement delayed inode
 ref deletion
Message-ID: <20231031142613.GE11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e81eab657c200a78dd43747fb28e942289082f98.1698698978.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81eab657c200a78dd43747fb28e942289082f98.1698698978.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 31, 2023 at 07:37:20AM +1030, Qu Wenruo wrote:
> [PROBLEM]
> The function __btrfs_update_delayed_inode() is doing something not
> meeting the code standard of today:
> 
> 	path->slots[0]++
> 	if (path->slots[0] >= btrfs_header_nritems(leaf))
> 		goto search;
> again:
> 	if (!is_the_target_inode_ref())
> 		goto out;
> 	ret = btrfs_delete_item();
> 	/* Some cleanup. */
> 	return ret;
> 
> search:
> 	ret = search_for_the_last_inode_ref();
> 	goto again;
> 
> With the tag named "again", it's pretty common to think it's a loop, but
> the truth is, we only need to do the search once, to locate the last
> (also the first, since there should only be one INODE_REF or
> INODE_EXTREF now) ref of the inode.
> 
> [FIX]
> Instead of the weird jumps, just do them in a stream-lined fashion.
> This removes those weird tags, and add extra comments on why we can do
> the different searches.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
