Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB44FF96B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 16:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiDMOwm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbiDMOwf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 10:52:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC824966
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 07:50:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C770C1F868;
        Wed, 13 Apr 2022 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649861411;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j3cVwitPmC8+atW+QKd5HxJQCPyWf6TNpGQdzoJYJIA=;
        b=W8WJ9luGKbtqcfFhv9UfszLkfXScUEQ1OusgseLkM8Tum4f6jMKQIPs0jSvwZhbUxm5/Ud
        DtehmVf0pj4vpXjugb6wAXR+cQ8Cbg695ID9mF+yPe4V1jsjvaKFAKS8phCCgyzQQ4oo97
        ZbjOYAmffLubsi45N79eVgzzjd7XMk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649861411;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j3cVwitPmC8+atW+QKd5HxJQCPyWf6TNpGQdzoJYJIA=;
        b=ORpvBssyBHgVhJlqKJ2ZiLuaL1y8CTW3fo+mYorHfDlAvxh8nI2PykXCXBOeDz3/RvXT2U
        dXybmwtN3uMShiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4FEF13A91;
        Wed, 13 Apr 2022 14:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GYaJJyPjVmK+IgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Apr 2022 14:50:11 +0000
Date:   Wed, 13 Apr 2022 16:46:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/17] btrfs: add subpage support for RAID56
Message-ID: <20220413144605.GK15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <20220412174225.GY15609@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412174225.GY15609@twin.jikos.cz>
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

On Tue, Apr 12, 2022 at 07:42:25PM +0200, David Sterba wrote:
> On Tue, Apr 12, 2022 at 05:32:50PM +0800, Qu Wenruo wrote:
> > The branch can be fetched from github, based on latest misc-next branch
> > (with bio and memory allocation refactors):
> > https://github.com/adam900710/linux/tree/subpage_raid56
> > 
> > [CHANGELOG]
> > v2:
> > - Rebased to latest misc-next
> >   There are several conflicts caused by bio interface change and page
> >   allocation update.
> > 
> > - A new patch to reduce the width of @stripe_len to u32
> >   Currently @stripe_len is fixed to 64K, and even in the future we
> >   choose to enlarge the value, I see no reason to go beyond 4G for
> >   stripe length.
> > 
> >   Thus change it u32 to avoid some u64-divided-by-u32 situations.
> > 
> >   This will reduce memory usage for map_lookup (which has a lifespan as
> >   long as the mounted fs) and btrfs_io_geometry (which only has a very
> >   short lifespan, mostly bounded to bio).
> > 
> >   Furthermore, add some extra alignment check and use right bit shift
> >   to replace involved division to avoid possible problems on 32bit
> >   systems.
> > 
> > - Pack sector_ptr::pgoff and sector_ptr::uptodate into one u32
> >   This will reduce memory usage and reduce unaligned memory access
> > 
> >   Please note that, even with it packed, we still have a 4 bytes padding
> >   (it's u64 + u32, thus not perfectly aligned).
> >   Without packed attribute, it will cost more memory usage anyway.
> > 
> > - Call kunmap_local() using address with pgoff
> >   As it can handle it without problem, no need to bother extra search
> >   just for pgoff.
> > 
> > - Use "= { 0 }" for structure initialization
> > 
> > - Reduce comment updates to minimal
> >   If one comment line is not really touched, then don't touch it just to
> >   fix some bad styles.
> 
> v2 updated in for-next, I had a local branch with more changes so I
> transferred the changes manually.

Now moved to misc-next as it's an isolated functionality and should not
affect anything else. Thanks.
