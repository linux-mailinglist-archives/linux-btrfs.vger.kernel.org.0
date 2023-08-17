Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBCF78024E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 02:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356471AbjHQX7n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 19:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356413AbjHQX7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 19:59:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677333A9C
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 16:59:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24C511F45A;
        Thu, 17 Aug 2023 23:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692316753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlg2N4jlkV82nNPy0HuZiDO5qy7cUcZ17yQw8xZE8zM=;
        b=OUMqZjAC12Etx6XQpTC6tVtIHqGP/XVjDhMCgCLPgISdb6+kvS8AovRPjqKZxKnjOrAvMI
        q0BbpCaEiEc2SoscWHKXbd7PSWgS9Oe9WQBKHexlxpzMqtt3nEv7qConfIoIU2lqPtyuwa
        XkIUXqIwzxk0gui0bmnKhpICKt++3NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692316753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlg2N4jlkV82nNPy0HuZiDO5qy7cUcZ17yQw8xZE8zM=;
        b=8ygztBGg6SPx5YF9bIF55HGi8mFNqBM//c2qL9w9uwgPmQD81TvKq9iAIQbVBzCtUo1OAk
        iddMNqmHVY6PfXDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 067251342C;
        Thu, 17 Aug 2023 23:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wvrKAFG03mSXOQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 23:59:13 +0000
Date:   Fri, 18 Aug 2023 01:52:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Fix incorrect splitting logic in
 btrfs_drop_extent_map_range
Message-ID: <20230817235244.GZ2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692305624.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692305624.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 04:57:29PM -0400, Josef Bacik wrote:
> We have been hitting a fair number of warnings in btrfs_drop_extent_map_range
> and in unpin_extent_map in production.  Upon investigation I discovered we were
> splitting improperly when we call btrfs_drop_extent_map_range with skip_pinned.
> This results in invalid extent_maps in the inode's io_tree, which in turn wreaks
> all sorts of havoc, mostly in the form of these WARN_ON()'s.  This took me a
> while to spot so I have a bunch of self-tests that test various functionality of
> btrfs_drop_extent_map_range and btrfs_add_extent_mapping, with one test that
> actual exercises the bug.
> 
> This has been broken for a while, and thankfully is only triggered in certain
> cases with relocation on.  Our environment uses auto relocation heavily which is
> why we hit this reliably, but the incident rate is still relatively low.  The
> bug was introduced over 10 years ago, it probably could be limited to being
> backported to the most recent kernels, basically anytime after Filipe's cleaning
> up of this code.  Thanks,
> 
> Josef
> 
> Josef Bacik (4):
>   btrfs: fix incorrect splitting in btrfs_drop_extent_map_range
>   btrfs: add extent_map tests for dropping with odd layouts
>   btrfs: add a self test for btrfs_add_extent_mapping
>   btrfs: test invalid splitting when skipping pinned drop extent_map

Nice, we have a new record holder, thanks for tracking it down and for
adding the tests. I'll add the patches to misc-next but review is still open.
