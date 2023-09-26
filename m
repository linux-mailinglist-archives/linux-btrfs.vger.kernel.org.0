Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE197AF0CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 18:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjIZQdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQdx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 12:33:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E973BF
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 09:33:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FB121F8B5;
        Tue, 26 Sep 2023 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695746025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YSHnZzYR24MW7lpOelCCaxoZTQ3dJUlSojwmar12Tk0=;
        b=bpwMtKWfgQkOTybPBgsURe+L77NwdX3T6CKb8NRd7/CyBpKJiZCIckox78Jx+7xBJCf1bk
        d9biPs4NYDQu6VUCeVADIxVLUdsyZetzzbBVnLA3AeLk7YLOSMP7H54e0pinufbsCr3YfK
        GFkTuk3ir9UqIbON41fztgXS+BcyoGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695746025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YSHnZzYR24MW7lpOelCCaxoZTQ3dJUlSojwmar12Tk0=;
        b=ZLrP5pmNNnGNDaNQorLhmPM80OeSDPaQbgAqlZmwAkrJPraMPm+JcD0YAoLGfeKjqRU5kp
        fbqKWkuy/t4yy8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F173E1390B;
        Tue, 26 Sep 2023 16:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XmjnOegHE2WeIwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Sep 2023 16:33:44 +0000
Date:   Tue, 26 Sep 2023 18:27:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     fdmanana@kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-btrfs@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH 7/8] btrfs: use extent_io_tree_release() to empty dirty
 log pages
Message-ID: <20230926162707.GT13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <459c0d25abdfecdc7c57192fa656c6abda11af31.1695333278.git.fdmanana@suse.com>
 <202309261438.d1bebb50-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309261438.d1bebb50-oliver.sang@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 02:25:06PM +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_fs/btrfs/extent-io-tree.c" on:
> 
> commit: 84b23544b95acd2e4c05fc473816d19b749fe17b ("[PATCH 7/8] btrfs: use extent_io_tree_release() to empty dirty log pages")
> url: https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-org/btrfs-make-extent-state-merges-more-efficient-during-insertions/20230922-184038
> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
> patch link: https://lore.kernel.org/all/459c0d25abdfecdc7c57192fa656c6abda11af31.1695333278.git.fdmanana@suse.com/
> patch subject: [PATCH 7/8] btrfs: use extent_io_tree_release() to empty dirty log pages

Known and fixed in the git branch.
