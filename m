Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D83520509
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 21:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbiEITQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiEITQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 15:16:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF4F4B437
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 12:12:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2280A21C16;
        Mon,  9 May 2022 19:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652123551;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4vEO/IQFJBW5jsrYWZyp4Dstu7USz9LeMnz4Wdy1ZH8=;
        b=NfkizViIGQUloO0dF3zWHsJugIYg05j1Crv4wUcBQWPwpiaJFgG+JJv+3X3UlTJPou8XOr
        9WCTm0PkC4r0mqrgp+V6eVK91pGlxeXwMWAf6kV/7hGOi6sUBKx8PRubPXFNZjF0uedg8y
        1ygXG277zIh8/oYIrw+0zBHJ5wuLB1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652123551;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4vEO/IQFJBW5jsrYWZyp4Dstu7USz9LeMnz4Wdy1ZH8=;
        b=HXB5Nkyg4y3gpIjdQAoKCcvzHN50d8jJlCU41LbpTL/yz4LDxIiBqtidWZKlT5oSmvrblm
        lsMAjd1HcLqTLzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 057BB132C0;
        Mon,  9 May 2022 19:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XzJbAJ9neWK4dwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 May 2022 19:12:31 +0000
Date:   Mon, 9 May 2022 21:08:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: teach send to avoid trashing the page cache
 with data
Message-ID: <20220509190816.GD18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1651770555.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651770555.git.fdmanana@suse.com>
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

On Thu, May 05, 2022 at 06:16:13PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a send operation, we read the data of all extents we need to
> send into the page cache, which almost always is wasteful as it can lead
> to eviction of other things from the page cache that are more useful for
> applications (and maybe other kernel subsystems). This patchset makes send
> evict the data from the page cache once it has sent it. The actual work
> is in the second patch, while the first one is just preparatory work.
> More details in the changelogs.
> 
> Filipe Manana (2):
>   btrfs: send: keep the current inode open while processing it
>   btrfs: send: avoid trashing the page cache

Added to misc-next, thanks.
