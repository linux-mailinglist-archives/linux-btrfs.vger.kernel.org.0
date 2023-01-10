Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C800664510
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 16:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjAJPji (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 10:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbjAJPjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 10:39:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBD1B1DA
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 07:39:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 967B56A972;
        Tue, 10 Jan 2023 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673365157;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lP4AbsfIcbgfiqZpFlN2PtZubJ6rD2fuqbfa4MYtxf4=;
        b=aaMw9ZYN0vCsepp4YoPZgRN4C8qVk3guFd1ZT6Y6wixw6boC/wfIGPzjUaWUG3S+Y6Owz0
        SwbyGZg7GkowlAXLy4yHp/0nHB/w4ux7/iG/V0DgNgOopuQ88GNjx3v6XVss4ayGNpJdxQ
        sy6wp67zqtqjHZbqHAQvS71vWuVPPVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673365157;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lP4AbsfIcbgfiqZpFlN2PtZubJ6rD2fuqbfa4MYtxf4=;
        b=hN0fseWvpQFl0hEuiN4miB+Xtk7s9nGcpebqRXIpNZ5xb7Z/cTibDtEQe+hV5xVKW3xzhu
        Jd4w/cu95Y9UoxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 692E213338;
        Tue, 10 Jan 2023 15:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BCedGKWGvWMkCAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Jan 2023 15:39:17 +0000
Date:   Tue, 10 Jan 2023 16:33:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/8] btrfs: do not check header generation in
 btrfs_clean_tree_block
Message-ID: <20230110153343.GF11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1670451918.git.josef@toxicpanda.com>
 <ef73c4c67028f9e7d770dca236367f1ea0b56b55.1670451918.git.josef@toxicpanda.com>
 <0507a942-2a82-f086-2be5-a9ac64e4c1d3@gmx.com>
 <6f22220e-f660-92d2-5241-fb9a353090ac@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f22220e-f660-92d2-5241-fb9a353090ac@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 17, 2022 at 10:10:24AM +0800, Qu Wenruo wrote:
> On 2022/12/16 13:32, Qu Wenruo wrote:
> > On 2022/12/8 06:28, Josef Bacik wrote:
> >> This check is from an era where we didn't have a per-extent buffer dirty
> >> flag, we just messed with the page bits.  All the places we call this
> >> function are when we have a transaction open, so just skip this check
> >> and rely on the dirty flag.
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > This patch is failing a lot of test cases, mostly scrub related 
> > (btrfs/072, btrfs/074).
> > 
> > Now we will report all kinds of errors during scrub.
> > Which seems weird, as scrub doesn't use the regular extent buffer 
> > helpers at all...
> > 
> > Maybe it's related to the generation we got during the extent tree search?
> > As all the failures points to generation mismatch during scrub.
> 
> I got some extra digging, and it turns out that, if we unconditionally 
> clear the EXTENT_BUFFER_DIRTY flags, we can miss some tree blocks 
> writeback for commit root.
> 
> Here is some trace for one extent buffer:
> 
>      btrfs_init_new_buffer: eb 7110656 set generation 13
>      btrfs_clean_tree_block: eb 7110656 gen 13 dirty 0 running trans 13
>      __btrfs_cow_block: eb 7110656 set generation 13
> 
> Above 3 lines are where the eb 7110656 got created as a cowed tree block.
> 
>      update_ref_for_cow: root 1 buf 6930432 gen 12 cow 7110656 gen 13
> 
> The eb 7110656 is cowed from 6930432, and that's created at transid 13.
> 
>      update_ref_for_cow: root 1 buf 7110656 gen 13 cow 7192576 gen 14
> 
> But that eb 7110656 got CoWed again in transaction 14. Which means, eb 
> 7110656 is no longer referred in transid 14, but is still referred in 
> transid 13.
> 
>      btrfs_clean_tree_block: eb 7110656 gen 13 dirty 1 running trans 14
> 
> Here inside update_ref_for_cow(), we clear the dirty flag for eb 7110656.
> 
> This has a consequence that, the tree block 7110656 will not be written 
> back, even it's still referred in transid 13.
> 
> This is where the problem is, previously we will continue writing back 
> eb 7110656, as its transid is not the running transid, meaning some 
> commit root still needs it.
> 
> Especially note that, I have added trace output for any tree block write 
> back (in btree_csum_one_bio()).
> But there is no such trace, meaning the tree block is never properly 
> written back.
> 
> This also exposed another problem, if we didn't properly writeback tree 
> blocks in commit root, we break COW, thus no proper transactional 
> protection for our metadata.
> 
>      scrub_simple_mirror: tree 7110656 mirror 1 wanted generation 13
>                           running trans 14
>      scrub_checksum_tree_block: tree generation mismatch, tree 7110656
>                                 mirror 1 running trans 14, has 15 want 13
>      scrub_checksum_tree_block: tree generation mismatch, tree 7110656
>                                 mirror 0 running trans 14, has 15 want 13
> 
> The above lines just shows the scrub failure for it.
> As the tree block is not properly written back, we just read out some 
> garbage.
> 
> And unfortunately our scrub code only checks bytenr, then generation, 
> not even checking the fsid, thus we got the generation mismatch error.
> 
>      ...
>      btree_csum_one_bio: eb 7110656 gen 26
> 
> There is an example to prove that, I have added tree block writeback 
> trace event.
> 
> Thus I'd prefer to have at least a comment explaining why we can not 
> just clean the dirty bit for a dirty eb which is not dirtied during the 
> current running transaction.

I've temporarily removed the patchset from for-next so we don't have
test failures over the holidays, now it's time to add it back, but based
on the above there are changes needed, right? If yes, I'll wait for the
update.
