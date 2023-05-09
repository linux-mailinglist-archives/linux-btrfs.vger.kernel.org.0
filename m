Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD56FD257
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 00:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjEIWN3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjEIWN1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 18:13:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E610A3A8D
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 15:13:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86B6F21AF0;
        Tue,  9 May 2023 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683670401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F7KS1zB0JmjHF/vCKs2/7rYMaTEvlFchc4tiXT02yGg=;
        b=rVxRQ/86D2Aptk8KLYCHSdHpj3PNaNuJUNCdVi9zV8st0kgV4kyBsDw9E2dMkaXPCarwcw
        AhOzSJY5zVExO5F7iGgu15zM+88+qGn50ukzJinmm7awY37hzc5t2vaLH7a7NU61k5vN6W
        fsG7C5ARUZaQOcEPicH67p4ZkEK/gCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683670401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F7KS1zB0JmjHF/vCKs2/7rYMaTEvlFchc4tiXT02yGg=;
        b=kZ4XamDWjMeFQxcUtOXvVt4AAQ9jW6BygZiZTKVk7Q6zVvz7Yl0cEolTsXy1pc4+A/UZV2
        O0TJjIUC+bXDkfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53EF013581;
        Tue,  9 May 2023 22:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6vlzE4HFWmRubQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 22:13:21 +0000
Date:   Wed, 10 May 2023 00:07:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 07/12] btrfs: add __btrfs_check_node helper
Message-ID: <20230509220722.GD32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682798736.git.josef@toxicpanda.com>
 <c78571e0ea619aefd33e2c6d1a6ac274cb15581f.1682798736.git.josef@toxicpanda.com>
 <ed882c49-7947-bfff-2b93-07872528fea3@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed882c49-7947-bfff-2b93-07872528fea3@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 02, 2023 at 12:10:20PM +0000, Johannes Thumshirn wrote:
> On 29.04.23 22:08, Josef Bacik wrote:
> > diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
> > index 3b8de6d36141..c0861ce1429b 100644
> > --- a/fs/btrfs/tree-checker.h
> > +++ b/fs/btrfs/tree-checker.h
> > @@ -58,6 +58,7 @@ enum btrfs_tree_block_status {
> >   * btrfs_tree_block_status return codes.
> >   */
> >  enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf);
> > +enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node);
> 
> Sorry for only  noticing now, but shouldn't we do something like
> 
> #ifndef KERNEL
> enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf);
> enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node);
> #endif
> 
> and in fs/btrfs/tree-checker.c (or fs.h):
> 
> #ifdef KERNEL
> #define EXPORT_FOR_PROGS static
> #else
> #define EXPORT_FOR_PROGS
> #endif
> 
> Just like we did with EXPORT_FOR_TESTS?

That's a good idea. Could we do it at the end of the series though? It's
not the cleanest way but the patches are otherwise simple and we won't
need to backport them so having the change split like that should not
cause trouble. I can also edit the patches in place if we insist.

With a separate patch I'd like to see how the conditional definitions
for kernel and userspace should be done first.
