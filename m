Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC04667878
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 16:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbjALPD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 10:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbjALPDH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 10:03:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F7766A
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 06:50:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB03D20BC8;
        Thu, 12 Jan 2023 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673535035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/TgXMYKeQmkgydJbztUtpPEb5xfZe3rLUz8w3H8d2ws=;
        b=17JUpZHNfUx6wRh8jvgZbTKza2i5n7OWa83O3XC8Zh8VTU0XJp627y6rnWzmig/mrGBl+V
        61oUk8X7jSfJajwE8lXs/JAQnpwiRMNvIjXdZwGJkKrzk1KM91vaFTRXQt+WjaPWI39W+i
        7hoeobTAOc0VYFvRmYeZJ6K1qJSbWKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673535035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/TgXMYKeQmkgydJbztUtpPEb5xfZe3rLUz8w3H8d2ws=;
        b=ENs1odIoN9M4xPgNvlepH8JiHRUQhXz6xs/RM7Eu3LvmUQNrnSEaTLoSJ79R8/JXvr57fF
        n+Y8jHs09PFVqZAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEEBB13776;
        Thu, 12 Jan 2023 14:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vdKdMTsewGPgEgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Jan 2023 14:50:35 +0000
Date:   Thu, 12 Jan 2023 15:45:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: some log tree fixes and cleanups
Message-ID: <20230112144500.GM11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1673361215.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673361215.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 10, 2023 at 02:56:33PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some fixes mostly around directory logging and some cleanups (the last
> three patches).
> 
> Filipe Manana (8):
>   btrfs: fix missing error handling when logging directory items
>   btrfs: fix directory logging due to race with concurrent index key deletion
>   btrfs: add missing setup of log for full commit at add_conflicting_inode()
>   btrfs: do not abort transaction on failure to write log tree when syncing log
>   btrfs: do not abort transaction on failure to update log root
>   btrfs: simplify update of last_dir_index_offset when logging a directory
>   btrfs: use a negative value for BTRFS_LOG_FORCE_COMMIT
>   btrfs: use a single variable to track return value for log_dir_items()

Added to misc-next, thanks. The first 5 patches will go to the next pull
request to fix the recently reported tree-log bugs.
