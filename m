Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44D85AAB4E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiIBJ1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiIBJ1D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 05:27:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A404B940E
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 02:27:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D66B1342A0;
        Fri,  2 Sep 2022 09:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662110820;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sB+anVqfGLVd447UcWFn53Do0/PsFPiEMe9BZ5/jr7o=;
        b=NHSj3PSTl0ojEcLjIJpO6Nh/JacHlObovD96WyZksohdX1Zs+iwx4VFUtpiYNKzPwVZ3EZ
        MU8CIrv5NyGSCSOKyGPYuMxRjEH85Km0UaQfYAGZRPY+IAv5JDthFJnSxVfMhM8cGvhboQ
        Rqs39XeG7a3mq0WUFJYnVQqUyYEUw8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662110820;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sB+anVqfGLVd447UcWFn53Do0/PsFPiEMe9BZ5/jr7o=;
        b=AuSHPKkSg/W7U6Wo0tb+2G87mYmRDx4ruzCYbU3nm8aLlRlkAnfHFYovV1hP/FZRg9M/VC
        /ZRfdwuUPF3aiWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A93C213328;
        Fri,  2 Sep 2022 09:27:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /Kz9J2TMEWMEEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 02 Sep 2022 09:27:00 +0000
Date:   Fri, 2 Sep 2022 11:21:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/5] btrfs-progs: separate block group tree from
 extent tree v2
Message-ID: <20220902092140.GP13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1660024949.git.wqu@suse.com>
 <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
 <20220831191442.GL13489@twin.jikos.cz>
 <66396669-7174-dd04-aaa9-d8322bc39fdb@gmx.com>
 <ab123921-773a-9e1b-1d49-9e82614a37d9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab123921-773a-9e1b-1d49-9e82614a37d9@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 08:15:07PM +0800, Qu Wenruo wrote:
> >>> --- a/common/fsfeatures.c
> >>> +++ b/common/fsfeatures.c
> >>> @@ -172,6 +172,14 @@ static const struct btrfs_feature
> >>> runtime_features[] = {
> >>>           VERSION_TO_STRING2(safe, 4,9),
> >>>           VERSION_TO_STRING2(default, 5,15),
> >>>           .desc        = "free space tree (space_cache=v2)"
> >>> +    }, {
> >>> +        .name        = "block-group-tree",
> >>> +        .flag        = BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
> >>> +        .sysfs_name = "block_group_tree",
> >>> +        VERSION_TO_STRING2(compat, 6,0),
> >>> +        VERSION_NULL(safe),
> >>> +        VERSION_NULL(default),
> >>> +        .desc        = "block group tree to reduce mount time"
> >>
> >> Like explaining that this is a runtime feature and I have not noticed
> >> until I tried to test it expecting to see it among the mkfs-time
> >> features but there was nothing in 'mkfs.btrfs -O list-all'.
> >>
> >> This is a mkfs-time feature as it creates a fundamental on-disk
> >> structure, basically a subset of extent tree.
> >
> > This comes to the decision to make bg-tree feature as a compat RO flag.
> >
> > As we didn't put free-space-tree into "-O" options, but "-R" options.
> > So the same should be done for most compat RO flags.
> >
> > Furthermore I remember I discussed about this before, extent tree change
> > should not need a full incompat flag, as pure read-only tools, like
> > btrfs-fuse should still be able to read the subvolume/csum/chunk/root
> > trees without any problem.
> >
> > So following above reasons, bg-tree is compat RO, and compat RO goes
> > into "-R" options, I see no reason to put it into "-O" options.
> 
> After more consideration, I believe we shouldn't split all the features
> (including quota) between "-O" and "-R" options.

After reading your previous I got to the same conclusion.

> Firstly, although free space tree is compat RO (and a lot of future
> features will also be compat RO), it's still a on-disk format change (a
> new tree, some new keys).
> 
> It's even a bigger change compared to NO_HOLES features.
> No to mention the block group tree.
> 
> Now we have a very bad split for -R and -O, some of them are on-disk
> format change that is large enough, but still compat RO.

Agreed.

> Some of them should be compat RO, but still set as incompt flags.
> 
> To me, end users should not really bother what the feature is
> implemented, they only need to bother:
> 
> - What the feature is doing
> - What is the compatibility
>    The incompat and compat RO doesn't make too much difference for most
>    users, they just care about which kernel version is compatible.
> 
> So from this point of view, -O/-R split it not really helpful from the
> very beginning.
> 
> It may make sense for quota, which is the only exception, it's supported
> from the very beginning, without a compat RO/incompat flag.
> 
> But for more and more features, -O/-R split doesn't make much sense.

Yeah, the free-space-tree is misplaced and I did not realize that back
then. That something is possible to switch on at run time by a mount
option should not be the only condition to put the option to the -R option.

Quota are maybe still a good example of the runtime feature, there's a
command to enable and disable it. There are additional structures
created or deleted but it's not something fundamental. The distinction
in the options should hint at what's the type "what if I don't select
this now, can I turn it on later?", perhaps documentation should be more
explicit about that.

For compatibility we need to keep free-space-tree under -R but we can
add an alias to -O and everything of that sort add there too, like the
block group tree.
