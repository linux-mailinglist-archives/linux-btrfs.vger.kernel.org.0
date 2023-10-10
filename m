Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39397C021D
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjJJRCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 13:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjJJRCT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 13:02:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C9C97
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 10:02:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9959A1F45E;
        Tue, 10 Oct 2023 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696957334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJco9WMUyu6ORJOsTjlqSky/9umvquWGmNXCYCCrugI=;
        b=YBjFlM6YAByx/Hp4LlPFQ4NhA8T+dwVDOUqL8SNCqzNwODGKMCPZxutAdjgveup7muH7cY
        aBdEdmqIHGHNGocp5VZsT3esYkNRBZ7zcICeMZ/E+fj7SMf9l0Y75/poblTBkmnBQ+fMEk
        d9FD5eR73+nRsJBZpIf0VaFOArwTq/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696957334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJco9WMUyu6ORJOsTjlqSky/9umvquWGmNXCYCCrugI=;
        b=xHTq8KZD4b4POlKTbz7DxCAO4xCuTkMPrfsPUTV+9qwk1eAXyq9vp2q5XIDZANLbeKTrFu
        q5Lhk62IFKPdyjDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CFBE1348E;
        Tue, 10 Oct 2023 17:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tlDXHZaDJWVmQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Oct 2023 17:02:14 +0000
Date:   Tue, 10 Oct 2023 18:55:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: introduce a basic metadata free space
 reservation check
Message-ID: <20231010165528.GD2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6081e57fe6f43b3ab44c883814c6a197513c66c0.1696489737.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6081e57fe6f43b3ab44c883814c6a197513c66c0.1696489737.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 05, 2023 at 05:40:04PM +1030, Qu Wenruo wrote:
> Unlike kernel, in btrfs-progs btrfs_start_transaction() never checks if
> there is enough metadata space.
> 
> This can lead to very dangerous situation where there is no metadata
> space left at all, deadlocking future tree operations.
> 
> This patch introuce a very basic version of metadata/system free space
> check by:
> 
> - Check if there is enough metadata/system space left
>   If there is enough, go as usual.
> 
> - If there is not enough space left, try allocating a new chunk
> 
> - Recheck if the new space can meet our demand
>   If not, return ERR_PTR(-ENOSPC).
>   Otherwise, allocate a new trans handle to the caller.
> 
> This is possible thanks to the simplified transaction model in
> btrfs-progs:
> 
> - We don't allow joining a transaction
>   This means we don't need to handle complex cases like data ordered
>   extents, which needs to reserve space first, then join the current
>   transaction and use the reserved blocks.
> 
> - We don't allow multiple trans handlers for one transaction
>   Since btrfs-progs is single threaded, we always start a transaction
>   and then commit it.
> 
> However there is a feature that must be an exception for the new
> metadata/system free space check:
> 
> - btrfs check --init-extent-tree
>   As all the meta/system free space check is based on the space info,
>   which is loaded from block group items.
>   Thus when rebuilding extent tree, we can no longer have an accurate
>   view, thus we have to disable the feature for the whole execution if
>   we're rebuilding the extent tree.
> 
> For now, there is no regression exposed during the self tests, but I
> really hope this can be an extra safenet to prevent causing ENOSPC
> deadlock from btrfs-progs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
