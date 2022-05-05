Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE3551C415
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380786AbiEEPmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiEEPmu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 11:42:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C32182B
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 08:39:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB3661F8D3;
        Thu,  5 May 2022 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651765148;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LgoV2x2L22bE4jHPgJxPs92QCgRaewaOsN/Y+Nzo6Nw=;
        b=GPxUcLdK5xJhV/mx4FUH0uvvPgdFVLDNCfkGCw8xOSMvFZBg8okWmeHr0rINukp6kjaKk+
        dTUsrCPyldCt2WKsmXkm544w9Aq0awPNOHanGp1uZPtZY3I8qzi43aa81wH9KaO40+wPsy
        jM3G49LegQgbR2rzpMQrpqKOC2zKP74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651765148;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LgoV2x2L22bE4jHPgJxPs92QCgRaewaOsN/Y+Nzo6Nw=;
        b=WQVZ2FMaO6ynMACC3E94cEcOLLsvHwe1oC5xsOjBgxVkZAzctT0grk1ChfzpBObl1jSj3H
        o2QihBfBpbdWiPBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8799813B11;
        Thu,  5 May 2022 15:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v2IzIJzvc2J/VAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 05 May 2022 15:39:08 +0000
Date:   Thu, 5 May 2022 17:34:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: cleanup btrfs bio handling, part 2 v3
Message-ID: <20220505153456.GW18596@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <a6952ff4-1e4e-5650-7d57-8fd442e9d5aa@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6952ff4-1e4e-5650-7d57-8fd442e9d5aa@gmx.com>
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

On Thu, May 05, 2022 at 02:56:49PM +0800, Qu Wenruo wrote:
> On 2022/5/4 20:25, Christoph Hellwig wrote:
> > Hi all,
> >
> > this series removes the need to allocate a separate object for I/O
> > completions for all read and some write I/Os, and reduced the memory
> > usage of the low-level bios cloned by btrfs_map_bio by using plain bios
> > instead of the much larger btrfs_bio.
> 
> The most important part of this series is the patch "btrfs: remove
> btrfs_end_io_wq()" I guess.
> 
> As a guy growing up mostly reading btrfs code, the btrfs_end_io_wq()
> function looks straightforward to me initially, just put everything into
> wq context and call it a day.
> 
> But as I started to look into how other fses handle their delayed work,
> the btrfs way turns more "unique" other than straightforward.
> 
> So yes, aligning us to other fses, by only delaying into wq context when
> necessary, should be a good thing.
> Not reducing the memory allocation for the btrfs_end_io_wq structure,
> but also making the atomic part of the endio function executed with less
> delay.
> 
> But here I'm not sure if the btrfs way is a legacy from the past, or has
> some hidden intention (possible related to performance?).

Same here, I'm a bit worried about the implications of removing the
current end io way. I don't have a hard argument against, simplifying
the path is a good thing but as it's one of the fundamental
functionality I'd rather have it at least one cycle in the development
queue. As we're in rc5, there's not enough time to do evaluation on
various loads. Besides the test rig reports some performance degradation
on misc-next so it would be hard to evaluate this series as we don't
have a clean base line.

So current plan is to take what is safe from this patchset to 5.19
queue, the rest will appear in for-next. The misc-next will be frozen by
the end of the week, then 5.19 forked with selected fixes applied. In
parallel the for-next open is for any future development until 5.19-rc1.
