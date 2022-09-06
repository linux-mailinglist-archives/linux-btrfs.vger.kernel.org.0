Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2AD5AF0D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiIFQnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 12:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbiIFQlz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 12:41:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58097FF5
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 09:20:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 06A39336FB;
        Tue,  6 Sep 2022 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662481234;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ZHqv9yU7lkBkBah81/eXLIan1gfgvBp94X980m8TCQ=;
        b=e6+t1oqxrBoT26kNdzjoNHZjGYxpjM13CbWp+cn3N5ZOQ+YVhJ5G8iE6hxWRF1k/zMVyL7
        mB+NXGAfjqYxu8dWxBC0ZxhHdvZGGFeMbbm0wmbZxItxG/yVe/XEunyW7YVilINRJP/5wz
        WtCA68PHbBwc+1RdZepyd/xPb67RWSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662481234;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ZHqv9yU7lkBkBah81/eXLIan1gfgvBp94X980m8TCQ=;
        b=kr9kHE16GFfXU1Bf9IRF+WK4b9n7p0Zhxx7KKA7gm9rWJTdTtADemPMp8wKJieKIkIIDMu
        IYB/4yIs8yDBgnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D18DF13A19;
        Tue,  6 Sep 2022 16:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lo32MVFzF2PUNAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Sep 2022 16:20:33 +0000
Date:   Tue, 6 Sep 2022 18:15:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/3] btrfs: separate BLOCK_GROUP_TREE compat RO flag
 from EXTENT_TREE_V2
Message-ID: <20220906161511.GQ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1660021230.git.wqu@suse.com>
 <5c396cb280e441bf37df48e05f406424859a03d3.1660021230.git.wqu@suse.com>
 <20220905150127.GG13489@twin.jikos.cz>
 <67b45a55-058e-55ca-9327-deb23e6ee7c0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b45a55-058e-55ca-9327-deb23e6ee7c0@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 06, 2022 at 06:37:50AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/9/5 23:01, David Sterba wrote:
> > On Tue, Aug 09, 2022 at 01:02:18PM +0800, Qu Wenruo wrote:
> >> --- a/include/uapi/linux/btrfs.h
> >> +++ b/include/uapi/linux/btrfs.h
> >> @@ -290,6 +290,12 @@ struct btrfs_ioctl_fs_info_args {
> >>   #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
> >>   #define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
> >>
> >> +/*
> >> + * Put all block group items into a dedicate block group tree, greatly
> >> + * reduce mount time for large fs.
> >> + */
> >> +#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 5)
> >
> > Is there a reason to skip the bits 3 and 4? Ie. why isn't this (1 << 3) ?
> 
> I was saving 3 and 4 for EXTRA_SUPER_RESERVE (extra reserved space after
> 1MiB, needs a new member in super block) and WRITE_INTENT for raid56.
> 
> But obviously bg-tree is way easier to push, so would you mind to change
> it (1<<3)?

I see, the other patchset is not even in the queue yet so 1<<3 is the
first free value, changed in git.
