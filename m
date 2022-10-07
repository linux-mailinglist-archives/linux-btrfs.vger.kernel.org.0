Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627485F7BFE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJGRHb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJGRH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 13:07:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02266BC62B
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 10:07:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AEF081F7AB;
        Fri,  7 Oct 2022 17:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665162446;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oorkie7gbF19BF4Ji3d5GFw3bnAPb8YZxne+LvxW/SQ=;
        b=r+4axt/nDH2M0mvskRaxymdrym7jHkJVf2kDcMZJUBVdDw8l5qTMREI1k6RJqxDEhne8h2
        GW5QvY8bCCCCpL0Abce712D9xyLseHaUW+RVzv2eyLaFWQUdqD5I63RHI+yPeCts2oTZeb
        aPJY/SuvcyBPQaGcsteNlRvksTWHQvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665162446;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oorkie7gbF19BF4Ji3d5GFw3bnAPb8YZxne+LvxW/SQ=;
        b=OSTEHkTwYlMasWiFt4dW0MNIgYs8Eav+hUUYt6rOQsdqS84wt77m/RvUkJbNa0Db7ubYn+
        yRDwIfIbojXUIVDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 872BB13A3D;
        Fri,  7 Oct 2022 17:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 68cPIM5cQGNLUwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 17:07:26 +0000
Date:   Fri, 7 Oct 2022 19:07:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 04/17] btrfs: move btrfs on disk definitions out of
 ctree.h
Message-ID: <20221007170723.GW13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663167823.git.josef@toxicpanda.com>
 <058e41f7732823196f030916c04134418688cbe9.1663167823.git.josef@toxicpanda.com>
 <a67b963c-1f2a-bf68-c0b3-08dda678c629@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a67b963c-1f2a-bf68-c0b3-08dda678c629@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 05:07:42PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/9/14 23:06, Josef Bacik wrote:
> > The bulk of our on-disk definitions exist in btrfs_tree.h, which user
> > space can use.
> 
> Previously I tried to move some members to btrfs_tree.h, but didn't get 
> approved, mostly due to the fact that, we have those members exposed 
> through uapi is for TREE_SEARCH ioctl.
> 
> But I'm not buying that reason at all.
> 
> To me, all on-disk format, no matter if it's exposed through tree-search 
> should be in btrfs_tree.h.

All the structures are internal and not a guaranteed public API, we may
want to change them any time. So if we move the definitions to UAPI then
with a disclaimer that it's not a stable api and any compilation
failures outside of kernel are up to the users to fix.

Which does not work in practice as easy as said and we have reverted
some changes. See 34c51814b2b8 ("btrfs: re-instantiate the removed
BTRFS_SUBVOL_CREATE_ASYNC definition").

> Although I'd prefer to rename btrfs_tree.h to btrfs_ondisk_format.h.
> 
> Thus to David:
> 
> Can we make it clear that, btrfs_tree.h is not only for tree search 
> ioctl, but also all the on-disk format thing?

It is for on-disk format defitions, but that's a different problem than
the internal/external API.

> Reject once that's fine, but reject twice from two different guys, I 
> think it's not correct.
> 
> >  Keep things consistent and move the rest of the on disk
> > definitions out of ctree.h into btrfs_tree.h.  Note I did have to update
> > all u8's to __u8, but otherwise this is a strict copy and paste.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
