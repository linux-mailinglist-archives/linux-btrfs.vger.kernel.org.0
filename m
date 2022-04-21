Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F078C50A690
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbiDURJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 13:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiDURJX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 13:09:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9294B40905
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 10:06:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 378121F388;
        Thu, 21 Apr 2022 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650560792;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2mpKMfYw9llL6Tltd0AUsvr7nrGmwFaXx9gJ5bCeVyE=;
        b=hOZ9DhjESYY2D3SZV5CA0rXT8yIOgctL1ZP2JOZ8HCVE4zN4luoJrvQTa9HL0cVhULB7Qi
        nXSiyX4uA21FP8K6LQ1oaWTJBcclZ5y/be/qQlTJTGtSJwmXgEjewFMixG5o/lHH+A9m5O
        LR0XkZL7QBYEb8CzbD5KDz0hBU4GUdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650560792;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2mpKMfYw9llL6Tltd0AUsvr7nrGmwFaXx9gJ5bCeVyE=;
        b=LZO6VMKqDwQwThytxOdM1uA0yKX+2kOJFGN2FLn7sfWCv23jXxo/391vpeGaNjAhmsMOYA
        PhP4DN8GzlotRODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 203DF13A84;
        Thu, 21 Apr 2022 17:06:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lWMJBxiPYWJKBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 21 Apr 2022 17:06:32 +0000
Date:   Thu, 21 Apr 2022 19:02:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: skip compression property for anything other than
 files and dirs
Message-ID: <20220421170227.GF18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <bbb363e71d966670d8938898803dac2b8a581c7c.1650535137.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbb363e71d966670d8938898803dac2b8a581c7c.1650535137.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 21, 2022 at 11:01:22AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The compression property only has effect on regular files and directories
> (so that it's propagated to files and subdirectories created inside a
> directory). For any other inode type (symlink, fifo, device, socket),
> it's pointless to set the compression property because it does nothing
> and ends up unnecessarily wasting leaf space due to the pointless xattr
> (75 or 76 bytes, depending on the compression value). Symlinks in
> particular are very common (for example, I have almost 10k symlinks under
> /etc, /usr and /var alone) and therefore it's worth to avoid wasting
> leaf space with the compression xattr.
> 
> For example, the compression property can end up on a symlink or character
> device implicitly, through inheritance from a parent directory
> 
>   $ mkdir /mnt/testdir
>   $ btrfs property set /mnt/testdir compression lzo
> 
>   $ ln -s yadayada /mnt/testdir/lnk
>   $ mknod /mnt/testdir/dev c 0 0
> 
> Or explicitly like this:
> 
>   $ ln -s yadayda /mnt/lnk
>   $ setfattr -h -n btrfs.compression -v lzo /mnt/lnk
> 
> So skip the compression property on inodes that are neither a regular
> file nor a directory.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
