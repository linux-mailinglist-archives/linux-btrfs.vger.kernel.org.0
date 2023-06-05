Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E06722DAD
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 19:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjFERbI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjFERbD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 13:31:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17DBF9
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 10:30:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 932F021BA0;
        Mon,  5 Jun 2023 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685986255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYK6OkqSrEbpCMnHIySE/RJVNZx5+IOPy+cbVmciuQg=;
        b=at1kvr5SJw4kcPK7vr0NLmBfY4TQZlD9ev9DPKa1+EzJLnuhuoW8/X5DnuC9DzB7xriIVV
        1/dGFQX1JBxGU6iuZPgQpsjj/pZFkJrDkyKqsp6yDeqUW5huGoKuqcrEUFED4yM2/3IsJW
        NFeU+PF2J876Y/A4I1EtIRzAbwZA6Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685986255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYK6OkqSrEbpCMnHIySE/RJVNZx5+IOPy+cbVmciuQg=;
        b=2asXgnL8+Gj7RjpzRGYWKbSZ8fVuLG9XOrJ1fP6NI1O7KDjRfV7VyKOJcug8DrFc5IANLX
        PWtNQ5tKqRC/F4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AB86139C8;
        Mon,  5 Jun 2023 17:30:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k6lLHc8bfmRhNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Jun 2023 17:30:55 +0000
Date:   Mon, 5 Jun 2023 19:24:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: make btrfs_destroy_delayed_refs() return void
Message-ID: <20230605172440.GD25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <44301b9e5e365a7b0f5bc57b72811aa4467427c2.1685704678.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44301b9e5e365a7b0f5bc57b72811aa4467427c2.1685704678.git.fdmanana@suse.com>
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

On Fri, Jun 02, 2023 at 12:19:42PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs_destroy_delayed_refs() always returns 0 and its single caller does
> not check its return value, as it also returns void, and so does the
> callers' caller and so on. This is because we are in the transaction abort
> path, where we have no way to deal with errors (we are in a critical
> situation) and all cleanup of resources works in a best effort fashion.
> So make btrfs_destroy_delayed_refs() return void.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Make it explicit in the changelog that we are in the transaction
>     abort path and therefore have no way to deal with errors.
> 
>     V1 was part of a patchset that was merged except for this patch:
>     https://lore.kernel.org/linux-btrfs/cover.1685363099.git.fdmanana@suse.com/

Added to misc-next, my previous objections were meant for clarity and
the core of the error handling and return value passing lies in
unpin_extent_range(), not so significant for transaction cleanup.
