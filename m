Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3571598331
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244528AbiHRMbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 08:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiHRMbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 08:31:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B15A895C
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 05:31:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 442083EFAE;
        Thu, 18 Aug 2022 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660825895;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRkeYUzVeeUIxe8cRr+i0WuQkv6oODN7FignUlqV91k=;
        b=G40Sa7LAH/pAaRhpViFJ+qFyCW+5Oo15YZWkvMlWJUJMLH6IU67OlAq+lcrOt4bjrZJGAK
        3kCojRylQyXpOD/mthv3CnhRCLot0cOrKleDB7DjY+jd2oXprJMAC1TS73eFbffsM9DqbI
        +LR4PDF8KZymh1zy2UYlkJimXVhqt/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660825895;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRkeYUzVeeUIxe8cRr+i0WuQkv6oODN7FignUlqV91k=;
        b=JlSYVEeHF7T6UI+O2QEOpRPHd/ksH86lguJr7wnUNg1Wo1lJgM5NfqKLd+2nqK0RsUCISa
        Q1LJPedxetm6T7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A949133B5;
        Thu, 18 Aug 2022 12:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /gGRBScx/mKPRgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 18 Aug 2022 12:31:35 +0000
Date:   Thu, 18 Aug 2022 14:26:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't update the block group item if used bytes
 are the same
Message-ID: <20220818122624.GJ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
 <5db1f702-f6fa-3b0e-e34b-30c7ac6358e4@suse.com>
 <ab444642-8a17-cc97-8fff-3446d1ddef0e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab444642-8a17-cc97-8fff-3446d1ddef0e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 11, 2022 at 04:47:25PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/7/11 16:30, Nikolay Borisov wrote:
> >
> >
> > On 11.07.22 г. 9:37 ч., Qu Wenruo wrote:
> >> When committing a transaction, we will update block group items for all
> >> dirty block groups.
> >>
> >> But in fact, dirty block groups don't always need to update their block
> >> group items.
> >> It's pretty common to have a metadata block group which experienced
> >> several CoW operations, but still have the same amount of used bytes.
> >
> > This could happen if for example the allocated/freed extents in a single
> > transaction cancel each other out, right? Are there other cases where it
> > could matter?
> 
> No need to completely cancel each other.
> 
> In fact, just COWing a path without adding/deleting new cousins would be
> enough, and that would be very common for a lot of tree block operations.

I would be interested in numbers too, a percentage of skip/total would
be good for some workloads so we have at least some idea.

> >> In that case, we may unnecessarily CoW a tree block doing nothing.
> >>
> >> This patch will introduce btrfs_block_group::commit_used member to
> >> remember the last used bytes, and use that new member to skip
> >> unnecessary block group item update.
> >>
> >> This would be more common for large fs, which metadata block group can
> >> be as large as 1GiB, containing at most 64K metadata items.
> >>
> >> In that case, if CoW added and the deleted one metadata item near the end
> >> of the block group, then it's completely possible we don't need to touch
> >> the block group item at all.
> >>
> >> I don't have any benchmark to prove this, but this should not cause any
> >> hurt either.
> >
> > It should not but adds more state and is overall a maintenance burden.
> > One way to test this would be to rig up the fs to count how many times
> > the optimization has been hit over the course of, say, a full xfstest
> > run or at least demonstrate a particular workload where this makes
> > tangible difference.
> 
> But in this particular case, there is really not that much status to bother.
> 
> In fact, we don't care about if there is any status, we only care about
> the block_group::used is different from committed one.
> Even no change to lock schemes.

Looking to update_block_group_item, there are other block grup items
updated too:

- used - the one one you check
- flags - can't change on the fly, we'd have to do relocation, ie. a new
  block group
- chunk_objectid - that stays for the whole fileystem lifetime

So I think it's safe to just check the 'used' value but it increases
memory size of block group (that's been increasing in size recently) so
I'd rather have a better idea about the justification.
