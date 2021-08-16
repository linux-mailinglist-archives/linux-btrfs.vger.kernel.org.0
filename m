Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED7A3ED5AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhHPNNO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 09:13:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45100 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbhHPNLb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 09:11:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 937041FE69;
        Mon, 16 Aug 2021 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629119458;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/u6zdalyqa+5+vMaqrWzA2uKZg7pUjc2eXI+1VED3As=;
        b=keFdcG4zwRhJl6p4eRQmSBTmUtCny94Pt29DFToOpAKfvFjvKRc5P8WKC1JKZb7I/z7Z3J
        KVzLGHUJ8iuB+Ux6x2hK4PTO//k0//PTn5lUPTHmBqtqH7Sv8lAA4y+Iqd7jKtO4oiTYWA
        xbE1rDRdgcFDdiXI00tbscsn0Z1Jo0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629119458;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/u6zdalyqa+5+vMaqrWzA2uKZg7pUjc2eXI+1VED3As=;
        b=rrBMd2/az9c+YDhzWEynqjQn5qWfefGpqZyHRGyUZMPUtpp/SF4KlaoE9wCRFGRU9RjQPt
        Nr6dqelFgwv6D4CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 89D35A3BA5;
        Mon, 16 Aug 2021 13:10:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CFACADA72C; Mon, 16 Aug 2021 15:08:02 +0200 (CEST)
Date:   Mon, 16 Aug 2021 15:08:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, fdmanana@suse.com
Subject: Re: [PATCH] btrfs: tree-log: Check btrfs_lookup_data_extent return
 value
Message-ID: <20210816130802.GA5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, fdmanana@suse.com
References: <20210802123400.2687-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802123400.2687-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 02, 2021 at 09:34:00AM -0300, Marcos Paulo de Souza wrote:
> Function btrfs_lookup_data_extent calls btrfs_search_slot to verify if
> the EXTENT_ITEM exists in the extent tree. btrfs_search_slot can return
> values bellow zero if an error happened.
> 
> Function replay_one_extent currently check if the search found something
> (0 returned) and increments the reference, and if not, it seems to evaluate as
> 'not found'.
> 
> Fix the condition by checking if the value was bellow zero and return early.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to misc-next, thanks.
