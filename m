Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145DD50919E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382270AbiDTUwK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 16:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358062AbiDTUwJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 16:52:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EEB109D
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 13:49:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A1861F380;
        Wed, 20 Apr 2022 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650487761;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GxK7bGHqXnuTH3bkyw6m9PVbxPzhrEynT9xdl/my2w0=;
        b=nkf/KXiTj9oDQrAFiOUkOqx8oX0bQZEIk5SUNZZJuyJx1/Wy+RzemJIXxMG3AvhX4nWb5g
        2mFQCX0QN6UJpcMc13S1Zy6oPDDEPbVcmbgZTlxKGWnHMh1mgdTHAUGVKZe1spaVAp5Cv2
        JQ6WrQ9oK3Q51Nnf7XqeUiogfmkCe8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650487761;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GxK7bGHqXnuTH3bkyw6m9PVbxPzhrEynT9xdl/my2w0=;
        b=yHsa6L4YY54EXuZGo+qg97YnHtc4hKBVUFTP8MQedscR7z/wKMti4+dG4rho2dCKyBOj8z
        pQ9h7ZSbM++ZfCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD73F13A30;
        Wed, 20 Apr 2022 20:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eUsKNdBxYGLIJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 20:49:20 +0000
Date:   Wed, 20 Apr 2022 22:45:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: do not return errors from
 btrfs_submit_compressed_read
Message-ID: <20220420204516.GK1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220415143328.349010-1-hch@lst.de>
 <20220415143328.349010-5-hch@lst.de>
 <935e4667-2414-4620-382c-333075150f8f@gmx.com>
 <20220416044920.GB6162@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416044920.GB6162@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 16, 2022 at 06:49:20AM +0200, Christoph Hellwig wrote:
> On Sat, Apr 16, 2022 at 06:48:37AM +0800, Qu Wenruo wrote:
> > More and more bio submit functions are returning void and endio of the bio.
> >
> > But there are still quite some not doing this, like btrfs_map_bio().
> >
> > I'm wondering at which boundary we should return void and handle
> > everything in-house?
> 
> I don't think it is quite clear.  All the I/O errors with a bio should
> be handled through end_io, and we already have that, module the compressed
> case with it's extra layer of bios.  Now at what point we call the
> endio handler is a different question.  Duplicating it everywhere is
> a bit annoying, so having some low-level helpers that just return an
> error might be useful.  I plan a fair amount of refactoring around
> btrfs_map_bio, so I'll see if lifting the end_io call into it might
> or might no make sense while I'm at it.

Please try to limit number of patches in a series to 10ish, this works
much better when there's something to change in the early patches or
everything is fine and it will get merged for testing. Also there are
always other patches in flux so this helps me to schedule. Thanks.
