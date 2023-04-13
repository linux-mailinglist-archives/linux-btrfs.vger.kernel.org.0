Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F516E1841
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 01:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjDMXZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 19:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDMXZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 19:25:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8FFE63
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 16:25:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 798F621992;
        Thu, 13 Apr 2023 23:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681428334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hkgYhYpkHJa37G5h5CEzktoEC5fssHY0VuFvPNW0Gvc=;
        b=gK5wZFR+CdLO0LC7+OjxJ77XTzqfa4nh79syNTW7BFbnlcB+AjnMY2/RK7WB1gIVvfoFsr
        41Sy8aKTjh2MssT0CmKcSyTr3eLzyYlCid/L3mPA64IHDBYiE/MTcsGOVio7eRy9wHLt6p
        z/vWG22M8jCgCo1mjQ2Uxq1LFaDiqIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681428334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hkgYhYpkHJa37G5h5CEzktoEC5fssHY0VuFvPNW0Gvc=;
        b=kIBCIkMXUUYu1nQ/t5UFSQECwAZsfW1lkFoxzfNZ4YwgGsXjs50GrJ6UkJ3kz1piosCBdF
        ZI1XVnKPb4efbpAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B54613421;
        Thu, 13 Apr 2023 23:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iImdEW6POGTiHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Apr 2023 23:25:34 +0000
Date:   Fri, 14 Apr 2023 01:25:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: move block-group-tree out of
 experimental features
Message-ID: <20230413232527.GJ19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681180159.git.wqu@suse.com>
 <20230413162057.GG19619@twin.jikos.cz>
 <b646d7bb-2160-39d3-9d40-c2358b416a4f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b646d7bb-2160-39d3-9d40-c2358b416a4f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 14, 2023 at 06:55:36AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/4/14 00:20, David Sterba wrote:
> > On Tue, Apr 11, 2023 at 10:31:04AM +0800, Qu Wenruo wrote:
> >> People are complaining block-group-tree features are not accessible for
> >> non-experimental builds.
> >>
> >> So let's make it a stable feature.
> >>
> >> Since we're here, it's also a good time to deprecate
> >> -R|--runtime-features option.
> > 
> > As a major release is near it's a good time to do such changes. Merging
> > -R back to -O is OK. I looked again how robust the conversion to bgt is
> > wrt to a crash in the middle. If the process is restarted it should be
> > fine, though I'm not sure what happens when the fs would be mounted and
> > written to with the ongoing conversion.
> 
> It would be rejected by kernel, as I intentionally introduced a super 
> flag which kernel is not aware of (SUPER_FLAG_CHANGING_BG_TREE).

Ah right, all the CHANGING bits are automatically rejected, we don't
need to define them in kernel.

> > We don't have any test coverage of the feature, at least what is
> > possible from user space. Mount and other things need kernel 6.1 which
> > is not in CI.
> 
> Yeah, that's one of the problem unfortunately.

I'm revisiting all tests due to the changes in CI, for example the
defaults from 5.15 are not reflected in mkfs tests so I'm going to
update that and will add the block-group-tree tests too.
