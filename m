Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52679BF0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356175AbjIKWDG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbjIKSNj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 14:13:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B420110
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 11:13:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E7201F38D;
        Mon, 11 Sep 2023 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694456013;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3at3BnDSC9T9FhP6/SVAArWcPwIkxfA2v4bak7bjtFo=;
        b=pHTG5Yvx1i+mqOrFR0EsKuIpwOxBicWZtw/mTdnuQZUsoTxdl+fgmr5kpL0AlA2GEGN+aP
        tECab56d1fzkxRHxkv6qAwl2+qYM1TZXqr0hcf4C30x4sAD6kp+8evUCQmZnELhyjbrRsZ
        x1ketjd1FUw86DobR0HTJ3H7hz2SMV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694456013;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3at3BnDSC9T9FhP6/SVAArWcPwIkxfA2v4bak7bjtFo=;
        b=DjJfkpj2BW81K7/nK6L2pghWt1cWTskKJZ7PlhRfiWSSxjYlaUd583EI284UUJhiMfR1JW
        q5ijo3XnWOM3FtBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2835513780;
        Mon, 11 Sep 2023 18:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YnwWCc1Y/2R8OgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Sep 2023 18:13:33 +0000
Date:   Mon, 11 Sep 2023 20:06:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 00/18] btrfs: simple quotas
Message-ID: <20230911180658.GG3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <20230907105115.GA3159@twin.jikos.cz>
 <20230907205131.GA5581@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907205131.GA5581@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 01:51:31PM -0700, Boris Burkov wrote:
> On Thu, Sep 07, 2023 at 12:51:15PM +0200, David Sterba wrote:
> > On Thu, Jul 27, 2023 at 03:12:47PM -0700, Boris Burkov wrote:
> > > btrfs quota groups (qgroups) are a compelling feature of btrfs that
> > > allow flexible control for limiting subvolume data and metadata usage.
> > > However, due to btrfs's high level decision to tradeoff snapshot
> > > performance against ref-counting performance, qgroups suffer from
> > > non-trivial performance issues that make them unattractive in certain
> > > workloads. Particularly, frequent backref walking during writes and
> > > during commits can make operations increasingly expensive as the number
> > > of snapshots scales up. For that reason, we have never been able to
> > > commit to using qgroups in production at Meta, despite significant
> > > interest from people running container workloads, where we would benefit
> > > from protecting the rest of the host from a buggy application in a
> > > container running away with disk usage. This patch series introduces a
> > > simplified version of qgroups called
> > > simple quotas (squotas) which never computes global reference counts
> > > for extents, and thus has similar performance characteristics to normal,
> > > quotas disabled, btrfs. The "trick" is that in simple quotas mode, we
> > > account all extents permanently to the subvolume in which they were
> > > originally created. That allows us to make all accounting 1:1 with
> > > extent item lifetime, removing the need to walk backrefs. However,
> > > this sacrifices the ability to compute shared vs. exclusive usage. It
> > > also results in counter-intuitive, though still predictable and simple
> > > accounting in the cases where an original extent is removed while a
> > > shared copy still exists. Qgroups is able to detect that case and count
> > > the remaining copy as an exclusive owner, while squotas is not. As a
> > > result, squotas works best when the original extent is immutable and
> > > outlives any clones.
> > > 
> > > ==Format Change==
> > > In order to track the original creating subvolume of a data extent in
> > > the face of reflinks, it is necessary to add additional accounting to
> > > the extent item. To save space, this is done with a new inline ref item.
> > > However, the downside of this approach is that it makes enabling squota
> > > an incompat change, denoted by the new incompat bit SIMPLE_QUOTA. When
> > > this bit is set and quotas are enabled, new extent items get the extra
> > > accounting, and freed extent items check for the accounting to find
> > > their creating subvolume. In addition, 1:1 with this incompat bit,
> > > the quota status item now tracks a "quota enablement generation" needed
> > > for properly handling deleting extents with predate enablement.
> > > 
> > > ==API==
> > > Squotas reuses the api of qgroups.
> > 
> > So apart from the accounting, the hierarchy of qgroups can be still
> > built as before, right? In the example you create a group 1/100 so I
> > assume that it's still qgroups from the outside, and that the limits can
> > be set.
> 
> Yes, you can create quota group hierarchies with the same nesting
> behavior. I am only changing the accounting methodology (and added auto
> hierarchy)

OK, makes sense. The hierarchy does not need to be used and is probably
less practical for the simple accounting. What I had in mind was some
kind of flat hierarchy, now that the simple accounting is there. People
were asking about that in the past, wit the drawback of lack of
shared/exclusive accounting. Adding a separate subcommands and tooling
around flat quotas could be done but with squotas as well, just "don't
use the hierarchy".

> > Because if not, then squotas would make more sense as a separate
> > infrastructure, under quotas. Like that quotas are the abstraction while
> > qgroups or squota would be the implementation.
> > 
> > > The only difference is that when you
> > > enable quotas via `btrfs quota enable`, you pass the `--simple` flag.
> > > Squotas will always report exclusive == shared for each qgroup. Squotas
> > > deal with extent_item/metadata_item sizes and thus do not do anything
> > > special with compression. Squotas also introduce auto inheritance for
> > > nested subvols. The API is documented more fully in the documentation
> > > patches in btrfs-progs.
> > 
> > The lack of exclusive size sharing will be confusing I guess, so we need
> > to make it clear in the documentation and in the UI that it's either
> > full or simple mode.
> 
> I am happy to iterate on that. I think always reporting as shared=0,
> since the *ownership* is exclusive. I opted for making them equal since
> it sort of both shared usage (we don't know if it's shared nor when it
> will be freed) and exclusive usage (belongs to this subvol by owner ref)

I agree with that reasoning.
