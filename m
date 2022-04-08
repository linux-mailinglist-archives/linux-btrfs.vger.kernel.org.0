Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA7D4F9D23
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiDHSnu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 14:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiDHSnr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 14:43:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221AF1C7BB7;
        Fri,  8 Apr 2022 11:41:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F8BF21602;
        Fri,  8 Apr 2022 18:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649443297;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaTTqD9aZUtboVELKSbI3z4DsVuFax6sbvMw2Vl1jzk=;
        b=zoKdisOrhI+T9DmqblVP1a5mV5GlaCa97QaymbCbk0SxOUtBkkZkgbQNTZvoAn5REHH0zR
        sVMSvpNjNG7YZ+SHWyV27kFZxWslckB8u7U0vY2nvU/tTg6+d34lpuEQSLvzxJgKrXP2wO
        D4fpVHbAnxos4R3RWymmEV9jroAdHwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649443297;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaTTqD9aZUtboVELKSbI3z4DsVuFax6sbvMw2Vl1jzk=;
        b=Ai73YkpRKt9BkmpXSthGZNAfFpTUvUu4/ymvjQGmegsBCMHWKJbboWfjLSC9FehgzuYjPn
        asLjwY329KVC+FAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 373F1A3B96;
        Fri,  8 Apr 2022 18:41:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 366ADDA832; Fri,  8 Apr 2022 20:37:34 +0200 (CEST)
Date:   Fri, 8 Apr 2022 20:37:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Omar Sandoval <osandov@osandov.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: restore inode creation before xattr setting
Message-ID: <20220408183733.GA15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Omar Sandoval <osandov@osandov.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <8a60e54c02d8951cf5650cc8452ae583c130bbf7.1649437335.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a60e54c02d8951cf5650cc8452ae583c130bbf7.1649437335.git.sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 08, 2022 at 01:15:07PM -0400, Sweet Tea Dorminy wrote:
> According to the tree checker, "all xattrs with a given objectid follow
> the inode with that objectid in the tree" is an invariant. This was
> broken by the recent change "btrfs: move common inode creation code into
> btrfs_create_new_inode()", which moved acl creation and property
> inheritance (stored in xattrs) to before inode insertion into the tree.
> As a result, under certain timings, the xattrs could be written to the
> tree before the inode, causing the tree checker to report violation of
> the invariant.
> 
> Move property inheritance and acl creation back to their old ordering
> after the inode insertion.
> 
> Suggested-by: Omar Sandoval <osandov@osandov.com>
> Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
> This should apply on top of osandov's patch at
>  https://lore.kernel.org/linux-btrfs/da6cfa1b8e42db5c8954680cac1ca322d463b880.1647306546.git.osandov@fb.com/
> 
> It's survived a good dose of fstests, and several iterations of specific
> tests that were failing, e.g. generic/650.

Thanks.

> David: I don't know if you'd rather roll this into osandov's original
> patch, or whether you'd like me or osandov to resend the patch linked
> above with this addition rolled into it, or whether you'd like to apply
> it separately.

For simple fixups sent as replies I can apply it manually but sometimes
it's better for me to do the review instead of trying to figure out what
was the real intention.

So patch applied cleanly and now pushed to misc-next, thanks.
