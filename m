Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB54751496
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 01:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjGLXk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 19:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGLXk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 19:40:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329B119
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 16:40:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 205FA21D22;
        Wed, 12 Jul 2023 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689205254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOgNxq6uCETkJENVuYinuyjPEdDs1iR72zd30dMGEKI=;
        b=G3rAjJ85js5fqY7STT3G5NJUMNCW/SnLAMV7Xmkmq42Oq+aI6vtnRsyT3gMTDaN3ukYsd9
        3rGRzouXnqC2c7Od4+G7k49aez2NpHPAD3M8XtB2UHgBSbXZN7e+BPHaxSbGglwKel1dE3
        6+GK5KgoxlnG4Y7RilBc21hANMpMb3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689205254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOgNxq6uCETkJENVuYinuyjPEdDs1iR72zd30dMGEKI=;
        b=BsQMfbsBhyY71I1Pg6gcntI/6Y7JCsRstPfVpQqla8g2OU/4/fg/9E1929k0DBO2Ov3o/9
        33VjG9EwO4XkVlDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00F7113336;
        Wed, 12 Jul 2023 23:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DPwLOwU6r2QMJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 12 Jul 2023 23:40:53 +0000
Date:   Thu, 13 Jul 2023 01:34:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: deprecate check_int* feature
Message-ID: <20230712233418.GN30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d1b4174922a786884a1a3bfdcbbc208925797f4b.1687773318.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b4174922a786884a1a3bfdcbbc208925797f4b.1687773318.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 26, 2023 at 05:55:25PM +0800, Qu Wenruo wrote:
> Check_int feature needs to be enabled at compile time and then enable
> through mount option.
> 
> Although it provides some unique feature which can not be provided by
> any other sanity checks, it does not only have high CPU and memory
> overhead, but also maintenance burden.
> 
> For example, check_int is the only caller of btrfs_map_block() with
> @need_raid_map = 0.
> 
> Considering most btrfs developers are not even testing this feature, I'm
> here to purpose the deprecation of this feature.

I'm on the fence regarding the integrity checker. It once was very
useful and discovered a very serious problem when metadata block could
have been left uncommitted before the superblock due to missing
serialization. I can't find the commit though. The whole idea of
tracking the metadata blocks separately makes sense but it is true the
memory and CPU overhead is high.

The new approach by tree-checker is not the same but does not need to be
compiled and enabled separately and works on all builds.

Maintenance burden hasn't been high but there are quite a few changes in
the interfaces, types or other cleanups that basically change the
original code from 2011.

I tried to build it and run some time ago, in combination with KASAN it
produced lots of warnings (use-after-free) and ended by a crash at some
point. So I doubt anybody is actively using it or maybe without the
debugging functionality.

The points for keeping it are not many, only the strength of the
verification is the highest of what we have. But at a high runtime cost,
no interest and unknown state regarding reliability of the
implementation.

In summary:

Pro:
- can verify metadata/data integrity in a broder scope than tree-checker

Against:
- maintenance burden (not high but still)
- probably lots of unused code
- unknown implementation status

With my maintainer hat on I'd rather see it fixed and used more, but
this requires somebody willing doing the work. Otherwise I'm personally
not against removing it.

Even if it's a feature for developers, a deprecation period makes to
give people time to react. The closest target is 6.7, i.e. deprecation
will start at 6.6. Possibly it could go to 6.5 just to give us a two
release period.
