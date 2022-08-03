Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13C58929F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 21:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbiHCTQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 15:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbiHCTPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 15:15:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BACD18360
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 12:15:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF8D133744;
        Wed,  3 Aug 2022 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659554140;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulq2ZESnc3SkgFWGL9j1qQc7OHFMx5Zuc4oZQSnLVB8=;
        b=Prkqy1rBXvjhedUa04xUepXblLignl9PV3tc+mnVmcv0KCyw4yPFRNPET38ShN2ODzXHWt
        PvdI7idKeqDFV4F8Tqpf+XTGiki2Av0lOu+aI6tlfxt7mZrr+2OFJk4tKK5ZoqeGhN2v9q
        OAwmdFXgnKrIBWkp03VXPdgGuR7wLpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659554140;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulq2ZESnc3SkgFWGL9j1qQc7OHFMx5Zuc4oZQSnLVB8=;
        b=hCuf/83ID4G4DUgCzitb3GMuOU1fsibfzeCYNjKNAOQCxmyGv0HzXAaXOOfwMLpFNVXHB9
        54DQP5Sd/gD5pCBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 914A513AD8;
        Wed,  3 Aug 2022 19:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wZ5wIlzJ6mJ9EwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 19:15:40 +0000
Date:   Wed, 3 Aug 2022 21:10:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: separate BLOCK_GROUP_TREE feature from
 extent-tree-v2
Message-ID: <20220803191038.GI13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1658293417.git.wqu@suse.com>
 <20220726175922.GH13489@twin.jikos.cz>
 <56492a5b-8d98-38af-50f2-57a75a3417fc@gmx.com>
 <20220726215252.GQ13489@twin.jikos.cz>
 <27f3ed12-6b94-d370-279d-aba825d5a643@gmx.com>
 <46235fd6-8b31-9291-5025-b4305be1c678@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46235fd6-8b31-9291-5025-b4305be1c678@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 28, 2022 at 06:02:44PM +0800, Qu Wenruo wrote:
> >> Ok, good. I'm thinking if we should go for an online conversion too or
> >> not, because on a many-TB filesystem it would possibly take a long time
> >> but the benefit is not to unmount and do the conversion.
> >
> > For my previous tests, even TB level (used space) fs, it only takes
> > seconds to do the convert (although on SSD).
> >
> > For HDD systems, it would be as slow as the mount time for the convert.
> > Most of time spent would be just searching the block group items,
> > writing them into bg tree would be super fast though.
> 
> Despite the incoming multi-transaction bg tree convert tool
> (bidirectional), mind me to update the kernel series to address one of
> the concern from Josef?
> 
> To reduce the test matrix, I'd like to make bg tree to rely on free
> space tree and no holes features.
> 
> Although those features have no linkage to each other, such artificial
> requirement should greatly reduce our test combinations.

That's a good idea, we add the features incrementally and we've probably
reached the point where we should have a basic set that everybody wants
and should use.

Features that are clear optimizations or improvements should be easy to
decide, the other depend eg. on hardware (zoned) or are individual
features like quotas or raid1c34.

On mkfs side it would require more checks so that selecting
block-group-tree and disabling free-space-tree can't be done and
additional checks in kernel.
