Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED15A4D85C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 14:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiCNNNI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241778AbiCNNNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 09:13:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9109CBC25
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 06:11:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4D1CD1F383;
        Mon, 14 Mar 2022 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647263515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=951wVNX9NBsWi7wezs0xMf5o5Y2DzHOiC3hYjxxLryM=;
        b=RDBP85hYclwDVK27OOWaxoDQHKAfFQhL8v8OoEGzQPhk8i55gH+QyadNNN+thNpiysi11H
        PqdRX2/Yn4BiQjW7Xx58lPGv4UypqWLJbC5IugMUJsfWd8MkwaNIMmJyFJLklRc3+BrTAL
        WllmwJSKtNXfzEJpJHOG1mVmMxswMFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647263515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=951wVNX9NBsWi7wezs0xMf5o5Y2DzHOiC3hYjxxLryM=;
        b=QBJKb5UUdd/5euOiFZLyDtjl+K5aue4KYxKa1ZTC+mtmTlvv6neQhK6eJvNftMZkt0YzD6
        wZRVeYMGpjrqEwDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4403BA3B83;
        Mon, 14 Mar 2022 13:11:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21A3DDA7E1; Mon, 14 Mar 2022 14:07:57 +0100 (CET)
Date:   Mon, 14 Mar 2022 14:07:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: fix inefficiencies when reading extent
 buffers and some cleanups
Message-ID: <20220314130756.GI12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1646998177.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646998177.git.fdmanana@suse.com>
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

On Fri, Mar 11, 2022 at 11:35:30AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a couple inefficiencies when reading an extent buffer while searching
> a btree plus a couple cleanups in the same area. Spotted while working on
> other stuff, but this is separate and independent enough to be in its own
> small patchset.
> 
> Filipe Manana (4):
>   btrfs: avoid unnecessary btree search restarts when reading node
>   btrfs: release upper nodes when reading stale btree node from disk
>   btrfs: update outdated comment for read_block_for_search()
>   btrfs: remove trivial wrapper btrfs_read_buffer()

Added to misc-next, thanks.
