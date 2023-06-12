Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7EC72CB1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjFLQMj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 12:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjFLQMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 12:12:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B092F9
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 09:12:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55FC7227BD;
        Mon, 12 Jun 2023 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686586356;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fA6y8YlOt9/7eUgR5Q9NzFfev/JEP8hkoRAmN6uECDU=;
        b=aCYLDI+IUumH/5DukdqfRkd3FhGjzsa0YinjwpU6TYFfR++9BQiqTvBt/2E/kmTzFpS+Ou
        idy3Ks4nBqNsZu+3gftv3zL78VPmRDerOc0gAn1BSk/BlNJJbrWjku6Ia8U352iMXY11jJ
        re9h6H6eOQ+EFgpRvtLQ2/NdOe0djMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686586356;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fA6y8YlOt9/7eUgR5Q9NzFfev/JEP8hkoRAmN6uECDU=;
        b=th8HMjmZzhWmUqivFj8CNyue3zIX4seDhbMoPngpxwskpWRKnifAbqnOy0BTiyKOEuktTH
        BQVG5UmN5s7uksBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C2C11357F;
        Mon, 12 Jun 2023 16:12:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lgv8DPRDh2TqTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Jun 2023 16:12:36 +0000
Date:   Mon, 12 Jun 2023 18:06:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not BUG_ON() when dropping inode items from
 log root
Message-ID: <20230612160617.GE13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <05225b2c8b1848cfb68125b858998111e18dd5cb.1686566185.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05225b2c8b1848cfb68125b858998111e18dd5cb.1686566185.git.fdmanana@suse.com>
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

On Mon, Jun 12, 2023 at 11:40:17AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When dropping inode items from a log tree at drop_inode_items(), we this
> BUG_ON() on the result of btrfs_search_slot() because we don't expect an
> exact match since having a key with an offset of (u64)-1 is unexpected.
> That is generally true, but for dir index keys for example, we can get a
> key with such an offset value, even though it's very unlikely and it would
> take ages to increase the sequence counter for a dir index up to (u64)-1.
> We can deal with an exact match, we just have to delete the key at that
> slot, so there is really no need to BUG_ON(), error out or trigger any
> warning. So remove the BUG_ON().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next (without change), thanks. If you want to fold the
change suggested by Johannes please let me know.
