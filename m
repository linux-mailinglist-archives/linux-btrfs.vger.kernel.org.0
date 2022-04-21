Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DD50A399
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389841AbiDUPGQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 11:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiDUPGK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 11:06:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF43946141
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 08:03:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 985A51F37B;
        Thu, 21 Apr 2022 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650553399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaphcZIx3tPeP27+d6f0/GF+Qcvtz17yfTqu7qlWP9Y=;
        b=xdm9Wtd3YhIq7InxcBMARU3Kf6anTgmCE6dGgooAlKt+KyBzfsPT1kDYw5MP7+/IKSKAcm
        63axIL2AM5HpmwMtOmL3dXDT2eq3xDWRc+F+jsFHTP84HvOmNCJaajpiRVDIwQOXG+uqjJ
        c8TnwY7UxlEJVx4wmK8JSSLOcYoQcMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650553399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaphcZIx3tPeP27+d6f0/GF+Qcvtz17yfTqu7qlWP9Y=;
        b=chPCCnFGIErUiHU6ZeC6pLatvtvI+cla4KNVZ1JmW+7b1vIBHNn6lN648/Q0AM6FFGYq6V
        k6WcWGj3Dcj4/0Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7593113A84;
        Thu, 21 Apr 2022 15:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XCqMGzdyYWL9WgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 21 Apr 2022 15:03:19 +0000
Date:   Thu, 21 Apr 2022 16:59:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: always log symlinks in full mode
Message-ID: <20220421145915.GB18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <058da244fe15b0c5f0d55eaccd9af9f7c039d0a8.1650534831.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <058da244fe15b0c5f0d55eaccd9af9f7c039d0a8.1650534831.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 21, 2022 at 10:56:39AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> On Linux, empty symlinks are invalid, and attempting to create one with
> the system call symlink(2) results in an -ENOENT error and this is
> explicitly documented in the man page.
> 
> If we rename a symlink that was created in the current transaction and its
> parent directory was logged before, we actually end up logging the symlink
> without logging its content, which is stored in an inline extent. That
> means that after a power failure we can end up with an empty symlink,
> having no content and an i_size of 0 bytes.
> 
> It can be easily reproduced like this:
> 
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt
> 
>   $ mkdir /mnt/testdir
>   $ sync
> 
>   # Create a file inside the directory and fsync the directory.
>   $ touch /mnt/testdir/foo
>   $ xfs_io -c "fsync" /mnt/testdir
> 
>   # Create a symlink inside the directory and then rename the symlink.
>   $ ln -s /mnt/testdir/foo /mnt/testdir/bar
>   $ mv /mnt/testdir/bar /mnt/testdir/baz
> 
>   # Now fsync again the directory, this persist the log tree.
>   $ xfs_io -c "fsync" /mnt/testdir
> 
>   <power failure>
> 
>   $ mount /dev/sdc /mnt
>   $ stat -c %s /mnt/testdir/baz
>   0
>   $ readlink /mnt/testdir/baz
>   $
> 
> Fix this by always logging symlinks in full mode (LOG_INODE_ALL), so that
> their content is also logged.
> 
> A test case for fstests will follow.
> 
> CC: stable@vger.kernel.org # 4.9+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
