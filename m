Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD96F1910
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjD1NN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 09:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346246AbjD1NNR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 09:13:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D6DE9
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 06:13:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29158200A9;
        Fri, 28 Apr 2023 13:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682687588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKQLsrXeFjE1btTnIIKfF4XeulFk+IEggbMqg4em53Y=;
        b=MQ11ULOdGJ9tSpb+H5aeVPIPZhWiYru/SZ9sOJJRURzLkXMyZC7JpVzRc4SpFpzZ3yutFN
        BebOcgvsuE9xbILst1GDRsQb1c5GG/WigLIwiK95FGZyN4+JO3qs38LVHV6+o0qWYMvDxV
        7EyGOuzdWcVJCCJK2/OZ/ag2pVq7aoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682687588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKQLsrXeFjE1btTnIIKfF4XeulFk+IEggbMqg4em53Y=;
        b=volI2xr44TBYzwLwHCC1m5zhEAK8Mo71rWXP7TPVHJ06xhtLxTDOHPzyEk5UCGEYBhhBES
        FTezaRkUrsqK8DDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF3A5138FA;
        Fri, 28 Apr 2023 13:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ahljOWPGS2SzFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 28 Apr 2023 13:13:07 +0000
Date:   Fri, 28 Apr 2023 15:07:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix extent state leaks after device replace
Message-ID: <20230428130710.GA9035@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682528751.git.fdmanana@suse.com>
 <20230427225223.GG19619@twin.jikos.cz>
 <8dee05c7-ae18-49cb-b855-c79364c953fc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dee05c7-ae18-49cb-b855-c79364c953fc@oracle.com>
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

On Fri, Apr 28, 2023 at 07:51:42AM +0800, Anand Jain wrote:
> On 28/4/23 06:52, David Sterba wrote:
> > On Wed, Apr 26, 2023 at 06:12:59PM +0100, fdmanana@kernel.org wrote:
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> This fixes a recent regression (on its way to Linus' tree) that results in
> >> leaking extent state records in the allocation io tree of a device used as
> >> a source device for a device replace. Also unexport btrfs_free_device().
> >>
> >> Filipe Manana (2):
> >>    btrfs: fix leak of source device allocation state after device replace
> >>    btrfs: make btrfs_free_device() static
> > 
> 
> 
> > Added to misc-next, thanks.
> 
> Oh, I hope you saw the discussions in the patch 1/2.
> We can address both calling extent_io_tree_release() twice and the
> leak after device replace. Or no need of it?

Yes I saw the discussion, I'd rather revert back to the known behaviour,
this does not seem to be worth the optimization, apparently it's easy to
miss some cases.
