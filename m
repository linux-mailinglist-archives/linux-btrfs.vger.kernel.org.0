Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0405E6442
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiIVNwf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiIVNw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 09:52:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3FE48
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 06:52:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E7501F904;
        Thu, 22 Sep 2022 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663854729;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDh0RDFaD9keLfhVmCzHplFIN9fl2Kfi8+pdUYKA2Ck=;
        b=MEV0aVJfadcO6kd8rIFwxLVyT8m3qOuF2NUNYF8goKhE6yZX3EFy7NnvSv+ADxMdAOiauu
        HD5szV3e0/gvGEuq1X0mODz/egVZztlsL4AQLqNhFuGZx1NFhIaOEXdlZhPrDy9FL0fRwD
        h8mbto/L2n+Cjh+AP1SBzUHZ7O4xsLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663854729;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDh0RDFaD9keLfhVmCzHplFIN9fl2Kfi8+pdUYKA2Ck=;
        b=ekW2WtUvVHxixT5wsjnxgHWTv+++3A7/SV0rfCgrXEbyk6/sUo9RDyN7VdMNp1qLtMDiXN
        MI+VxH3fOxToeqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F03713AA5;
        Thu, 22 Sep 2022 13:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8XdeEoloLGNdAwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 22 Sep 2022 13:52:09 +0000
Date:   Thu, 22 Sep 2022 15:46:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: hide block group tree behind experimental
 feature
Message-ID: <20220922134637.GJ32411@suse.cz>
Reply-To: dsterba@suse.cz
References: <0b8f20ae26661e040dfcaae90928bbc1c6fff5cd.1662952308.git.wqu@suse.com>
 <20220921140611.GG32411@twin.jikos.cz>
 <ecd14905-6ff1-3d26-7354-93631684fa0c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd14905-6ff1-3d26-7354-93631684fa0c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 22, 2022 at 06:20:25AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/9/21 22:06, David Sterba wrote:
> > On Mon, Sep 12, 2022 at 11:12:01AM +0800, Qu Wenruo wrote:
> >> The block group tree doesn't yet have full bi-directional conversion
> >> support from btrfstune, and it seems we may want one or two release
> >> cycles to rule out some extra bugs before really releasing the progs
> >> support.
> >>
> >> This patch will hide the block group tree feature behind experimental
> >> flag for the following tools:
> >>
> >> - btrfstune
> >>    "-b" option to convert to bg tree.
> >>
> >> - mkfs.btrfs
> >>    hide "block-group-tree" feature from both -O (the new default position
> >>    for all features) and -R (the old, soon to be deprecated one).
> >
> > The block group tree is going to 6.1, so the progs support will be
> > experimental in 6.0 and enabled no later than 6.1. It might be enabled
> > earlier so we can use the normal build in testing.
> 
> Personally speaking, I'd hope bg tree would be hidden behind
> experimental until the bi-directional convert is implemented.

As with other new features we need a stabilization period, mkfs support
is the first step and the user space tools should provide feature parity
in the same release number at the latest.

That we have the btrfstune to do the conversions is a nice to have that
we do want to have eventually because we know that the bg tree will
solve slow mounts on large filesystems. So the experimental status for
btrfstune is fine, but not for mkfs.
