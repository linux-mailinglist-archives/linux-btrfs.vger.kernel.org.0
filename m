Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2727941CB
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbjIFRAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 13:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjIFRAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 13:00:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF974E6A
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 10:00:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7464220292;
        Wed,  6 Sep 2023 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694019600;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c4xv/dEkBgueA+utBrj++W5EgL+2e5olOERjEj8wdtk=;
        b=UycyljyVlPkHSq4ivCgDvHEuh/G6non3/C8ucNnNETluhVuQkop9kRpj1l2t1b23SikwtK
        oYJDLZLyGSM2gFh6UE0OEjKsvPkE167fBXYHENk+eX+jqQQA4naTozTrH2F5aWCKtQgtex
        VKcxUOL6zkJoWxAf7AmX0HMYPZ03MCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694019600;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c4xv/dEkBgueA+utBrj++W5EgL+2e5olOERjEj8wdtk=;
        b=Gp6z4/rpeYsq3YNhw4gJ9Yoe1kGluuY/O2zF2PuSlkBLXGYlpMkowgBgs3smINQSnq+vKA
        gZEybxu7RbhXnXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 479191346C;
        Wed,  6 Sep 2023 17:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VOxaEBCw+GQ2EQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 17:00:00 +0000
Date:   Wed, 6 Sep 2023 18:53:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: warn on tree blocks which are not nodesize
 aligned
Message-ID: <20230906165320.GT14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692858397.git.wqu@suse.com>
 <09481f8720302e0c4aaee7e460c142f632c72fe8.1692858397.git.wqu@suse.com>
 <bb023679-f804-97a6-601b-56a161ef5a0e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb023679-f804-97a6-601b-56a161ef5a0e@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 06, 2023 at 05:34:15PM +0800, Anand Jain wrote:
> On 8/24/23 14:33, Qu Wenruo wrote:
> > A long time ago, we have some metadata chunks which starts at sector
> > boundary but not aligned at nodesize boundary.
> > 
> > +	if (!IS_ALIGNED(start, fs_info->nodesize) &&
> > +	    !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK,
> > +			      &fs_info->flags)) {
> > +		btrfs_warn(fs_info,
> > +		"tree block not nodesize aligned, start %llu nodesize %u",
> > +			      start, fs_info->nodesize);
> > +		btrfs_warn(fs_info, "this can be solved by a full metadata balance");
> > +	}
> >   	return 0;
> 
> I don't know if ratelimited is required here. But, that shouldn't be a 
> no-go for the patch.

There will be only one such message as it's tracked by the global state
bit BTRFS_FS_UNALIGNED_TREE_BLOCK. However the message should be printed
in one go so it's not mixed with other system messages.
