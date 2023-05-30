Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A82271605C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 14:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjE3MrY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 08:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjE3MrU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 08:47:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58CD124
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 05:47:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35A0821A39;
        Tue, 30 May 2023 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685450819;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQyDY5Y6XPo2RJxyYZr5FSxwfk1xqsD7ReDPPwSFgns=;
        b=u8vrLhK+RD6OD6yXrjwhxlgePYxJEVVrM997obqTF/Q3UTGdnXIK4tP5JyxZkCsenRV2Bp
        6fmEw9nGuKk43BU6APeS8N8j0EwtAfr5TDREnF+gvTbV/C23GzR80SE702khkZIyy0wxlx
        V7QG6UWRBmFYFS6M9bNTIEo/A8sUS/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685450819;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQyDY5Y6XPo2RJxyYZr5FSxwfk1xqsD7ReDPPwSFgns=;
        b=83m4XPc7OAD++Iwd+wbDbBSEuDmdadsoQy44JO6xiH4gzWyLr4wb4KeFEoc++Y4hU2st0o
        eOhJDdFlX7nY8zAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 106D713478;
        Tue, 30 May 2023 12:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RTpNA0PwdWTYKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 12:46:59 +0000
Date:   Tue, 30 May 2023 14:40:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: convert: follow the default free space
 tree setting
Message-ID: <20230530124048.GN575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bd49c49f1e1c8b816b5e1b7d0adc0461d2737601.1685344169.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd49c49f1e1c8b816b5e1b7d0adc0461d2737601.1685344169.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 29, 2023 at 03:10:10PM +0800, Qu Wenruo wrote:
> [BUG]
> We got some test failures related to btrfs-convert with subpage, e.g.
> btrfs/012, the failure would cause the following dmesg:
> 
>  BTRFS warning (device nvme0n1p7): v1 space cache is not supported for page size 16384 with sectorsize 4096
>  BTRFS error (device nvme0n1p7): open_ctree failed
> 
> [CAUSE]
> v1 space cache has tons of hardcoded PAGE_SIZE usage, and considering v2
> space cache is going to replace it (which is already the new default
> since v5.15 btrfs-progs), thus for btrfs subpage support, we just simply
> reject the v1 space cache, and utilize v2 space cache when possible.
> 
> But there is special catch in btrfs-convert, although we're specifying
> v2 space cache as the new default for btrfs-convert, it doesn't really
> follow the specification at all.
> 
> Thus the converted btrfs will still go v1 space cache.
> 
> [FIX]
> It can be a huge change to btrfs-convert to make the initial btrfs image
> to support v2 cache.
> 
> Thus this patch would change the fs at the final stage, just before we
> finalize the btrfs.

This sounds like the safest approach, though a bit wasteful.

> This patch would drop all the v1 cache created, then call
> btrfs_create_free_space_tree() to populate the free space tree and
> commit the superblock with needed compat_ro flags.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
