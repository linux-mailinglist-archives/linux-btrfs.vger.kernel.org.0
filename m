Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256E059FF79
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 18:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiHXQ1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbiHXQ1X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 12:27:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E609C1D8
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 09:27:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10B8D3457E;
        Wed, 24 Aug 2022 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661358441;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akXnjMwMR46BYTwOc9AgBx8SD28eaaj6zn+OrIrhXTo=;
        b=WwrLKp5jdlYV1AvrZXwxu86gM6KHaCnRk+lBFqou5zmK6NvvpN60EHw3qXomj4yfE8g468
        AnVt6ah/M+ZZRgh1HhxBPJqU7ll4jAvNmHpsSowAiYK+l07DWKPuDGgkVVTzhAYRP48mtI
        RhgDbcYbW5C6BJ9Swc/TZ6q/FaFYA6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661358441;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akXnjMwMR46BYTwOc9AgBx8SD28eaaj6zn+OrIrhXTo=;
        b=7X51MomAPWgxs5RUS9lCApuVea5xPPOxw1gswJwJ7yt+wZugNh3Ut4nSEVS3jyeZ06u5Uq
        CY9wskAzT2m6MODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D156213780;
        Wed, 24 Aug 2022 16:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FTfiMWhRBmO5NgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 24 Aug 2022 16:27:20 +0000
Date:   Wed, 24 Aug 2022 18:22:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5] btrfs: qgroup: address the performance penalty
 for subvolume dropping
Message-ID: <20220824162206.GZ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1657260271.git.wqu@suse.com>
 <20220822174541.GB13489@twin.jikos.cz>
 <5efc6c8b-94d3-992f-aed2-8f0026790f54@gmx.com>
 <7cfc677c-80aa-ffe2-09f6-f221e7a41987@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cfc677c-80aa-ffe2-09f6-f221e7a41987@gmx.com>
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

On Tue, Aug 23, 2022 at 06:13:56AM +0800, Qu Wenruo wrote:
> On 2022/8/23 06:02, Qu Wenruo wrote:
> > On 2022/8/23 01:45, David Sterba wrote:
> >> On Fri, Jul 08, 2022 at 02:07:25PM +0800, Qu Wenruo wrote:
> >>> Changelog:
> >>> v2:
> >>> - Split /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags into two
> >>>    entries
> >>>
> >>> - Update the cover letter to explain the drop_subtree_threshold better
> >>>
> >>> v3:
> >>> - Rebased to latest misc-next
> >>
> >> I'll add this to misc-next, but regarding the overall design how to
> >> set/unset the quota recalculation I'm not sure it's a clean solution.
> >
> > Yep, that's always the main concern.
> >
> > Alternatives includes new on-disk item for qgroup, something like
> > QGROUP_CONFIG items.
> >
> > But that would need a new compat RO flags.
> 
> Wait, this doesn't even need to be compat RO, just compat flags.
> 
> Since the behavior doesn't affect qgroup consistency at all, purely a
> performance related issue.
> 
> Even old kernel can still do the old qgroup tricks, just much slower.
> 
> Maybe it's the time for our first compat flags?

That could work, but we may not even need to track the bit if it's just
the config item that can be BTRFS_PERSISTENT_ITEM_KEY, not a completely
new key and item. The compat bit could possibly be just in pair when the
item exists but we can do the same check just by looking up the item.
