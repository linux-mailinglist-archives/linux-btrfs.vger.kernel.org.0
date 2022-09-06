Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4D5AF0DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiIFQoR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiIFQnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 12:43:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A71A4
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 09:21:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1C91336FB;
        Tue,  6 Sep 2022 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662481300;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RnBlQW0CB04WWl9Hddv/b4aEa9T8+inB/WUADdFyyig=;
        b=0bu+OnZXPqGEOxCm2S1fA9P43cTTcgV8kIqmxFg8hbvrUaSRoLr1ZrSHcqzEqVgmSaosEv
        m3vP0MeFKLedEmSajVqkpp4/8gzohOhHSKtZysGNI5SkE6VI+Q1XDnVZ22KBktW+r2KMkd
        5kM/ccFObP7Ei9CVMFvGxRxo/Ru/aEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662481300;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RnBlQW0CB04WWl9Hddv/b4aEa9T8+inB/WUADdFyyig=;
        b=tSuKhVrW2s9MGnKSAAYGJYsymfmTMT00AXPf64Y0yWtPl4HIpJsKId3dymtd0eC9QVpzHF
        twz1Qjva45LtPMAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C017D13A19;
        Tue,  6 Sep 2022 16:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M+QALpRzF2NWNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Sep 2022 16:21:40 +0000
Date:   Tue, 6 Sep 2022 18:16:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs: separate BLOCK_GROUP_TREE feature from
 extent-tree-v2
Message-ID: <20220906161618.GR13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1660021230.git.wqu@suse.com>
 <20220823200106.GN13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823200106.GN13489@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 23, 2022 at 10:01:06PM +0200, David Sterba wrote:
> On Tue, Aug 09, 2022 at 01:02:15PM +0800, Qu Wenruo wrote:
> > [Changelog]
> > v3:
> > - Add artificial requirement on fst and no-holes
> >   This is to address the concern from Josef on too many feature
> >   combinations.
> >   In fact I believe future features should also have hard requirement
> >   on the latest default features.
> > 
> > v2:
> > - Rebased to latest misc-next
> >   This fixes some random crash not related to btrfs.
> > 
> > - Fix some missing conversion due to bad branch
> >   I got my code messed up due to some bad local branch naming.
> >   The previous version sent to the ML lacks some essential conversion.
> > 
> >   Now it can properly pass full fstest run with block group tree.
> > 
> > This is the kernel part to revive block-group-tree feature.
> > 
> > Thanfully unlike btrfs-progs, the changes to kernel is much smaller, and
> > we can re-use most of the infrastructures from the extent-tree-v2
> > preparation patches.
> > 
> > But there are still some changes needed:
> > 
> > - Enhance unsupporter compat RO flags handling
> >   Extent tree is only needed for read-write opeartions, and for
> >   unsupported compat RO flags, we should not do any write into the fs.
> > 
> >   So this patch will make the kernel to skip block group items search
> >   if there is any unsupport RO compat flags.
> > 
> >   And really make the incoming block-group-tree feature compat RO.
> > 
> >   Unfortunately, we need that patch to be backported, or older kernels
> >   will still reject RO mounts of fses with block-group-tree feature.
> > 
> > - Don't store block group root into super block
> >   There is no special reason for block group root to be stored in super
> >   block.
> >   We should review those preparation patches with more scrutiny.
> > 
> > 
> > For the proper time reduction introduced by this patchset, the old data
> > should still be correct, as the on-disk format is not changed.
> > https://lwn.net/Articles/801990/
> > 
> > 
> > Qu Wenruo (3):
> >   btrfs: enhance unsupported compat RO flags handling
> >   btrfs: don't save block group root into super block
> >   btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_V2
> 
> Adding this to for-next.

Moved to misc-next, thanks.
