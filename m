Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D56F8092
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjEEKJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEEKJA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 06:09:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5B014E72;
        Fri,  5 May 2023 03:08:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F6352230D;
        Fri,  5 May 2023 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683281338;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PbaIlZvU9o7/fv9VcxV35lya7cUgUdtTUBf9Eafk3ck=;
        b=bWWcjGB+weuiBocT1YlhXLOiHgfJpHZJFjbDK6FYCFwbfuS97n8ZnQyuvvXHnmn8U7MCT0
        tKF5K+cZBDiZ0BN+vFkVC2M5iYloNaANfHLI0SnqGha7rYgr5PQzBpP3YvhbP2kyvL3yLg
        Tw2EDMUY82tQI4rMrMG6MFp5RD+RDyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683281338;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PbaIlZvU9o7/fv9VcxV35lya7cUgUdtTUBf9Eafk3ck=;
        b=0pG7NVErDPUD45yLW6bSCXUCmfsKFrvZWTGpk591hJQsLk8Iek47FnUKpkysh7UNGwBeMm
        +yJQtRQ7Sml1ePCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6273813513;
        Fri,  5 May 2023 10:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e51JF7rVVGSjbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 10:08:58 +0000
Date:   Fri, 5 May 2023 12:03:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, git@vladimir.panteleev.md,
        Filipe Manana <fdmanana@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix backref walking not returning all inode
 refs
Message-ID: <20230505100301.GJ6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <77994dd9ede2084d45dd0a36938c67de70d8e859.1683123587.git.fdmanana@suse.com>
 <b04cbeb31e221edea8afa75679e4a55633748af7.1683194376.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b04cbeb31e221edea8afa75679e4a55633748af7.1683194376.git.fdmanana@suse.com>
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

On Thu, May 04, 2023 at 11:12:03AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the logical to ino ioctl v2, if the flag to ignore offsets of
> file extent items (BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET) is given, the
> backref walking code ends up not returning references for all file offsets
> of an inode that point to the given logical bytenr. This happens since
> kernel 6.2, commit 6ce6ba534418 ("btrfs: use a single argument for extent
> offset in backref walking functions"), as it mistakenly skipped the search
> for file extent items in a leaf that point to the target extent if that
> flag is given. Instead it should only skip the filtering done by
> check_extent_in_eb() - that is, it should not avoid the calls to that
> function (or find_extent_in_eb(), which uses it).
> 
> So fix this by always calling check_extent_in_eb() and find_extent_in_eb()
> and have check_extent_in_eb() do the filtering only if the flag to ignore
> offsets is set.
> 
> Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in backref walking functions")
> Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
> Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> CC: stable@vger.kernel.org # 6.2+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Remove wrong check for a non-zero extent item offset.
>     Apply the same logic at find_parent_nodes(), that is, search for file
>     extent items on a leaf if the ignore flag is given - the filtering
>     will be done later at check_extent_in_eb(). Spotted by Vladimir Panteleev
>     in the thread mentioned above.

Replaced in misc-next, thanks for the quick fix.
