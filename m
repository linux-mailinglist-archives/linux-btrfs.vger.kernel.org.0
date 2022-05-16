Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD545287FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbiEPPG3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244941AbiEPPGJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 11:06:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D03B020;
        Mon, 16 May 2022 08:06:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F00421FEA;
        Mon, 16 May 2022 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652713566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+0GsqPsSThaO2MnPpjoOsweO+GYaCoEg31L+IwHhqg=;
        b=lKfTMpyCVoWa0JJn/rnPzzTlVHx2ecJ0azO4Oq8wJ918JZPwvcWiiwqptLzYfsfvHOcvva
        eVKYcq2zMputu65NcBAD/BZxd32XuV4kL1bQPo4YcbyAmorFWXRa4KrC4saRreDnu2vpLQ
        qSfuwKGQ4yAD8j7VmcEwQ2hgTQWYzRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652713566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+0GsqPsSThaO2MnPpjoOsweO+GYaCoEg31L+IwHhqg=;
        b=KUJhBgqvq8Nn18KvbQkJlvarVwEdcKV7K3hS0z2sv/TIdtUHzz4hHoz90zQ8V2mTb1xCeD
        ficdnjVImsf/EiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5404813ADC;
        Mon, 16 May 2022 15:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7FWcE15ogmLfKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 16 May 2022 15:06:06 +0000
Date:   Mon, 16 May 2022 17:01:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix an error handling path in
 btrfs_read_sys_array()
Message-ID: <20220516150148.GX18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <d915ceb4d459aff89c0264113db21592a6806db1.1652517184.git.christophe.jaillet@wanadoo.fr>
 <120e4c34-da48-7d86-4a50-c31a3804600d@gmx.com>
 <20220516135407.GM4009@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516135407.GM4009@kadam>
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

On Mon, May 16, 2022 at 04:54:07PM +0300, Dan Carpenter wrote:
> On Sun, May 15, 2022 at 06:57:25AM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2022/5/14 20:01, Christophe JAILLET wrote:
> > > If alloc_dummy_extent_buffer() we should return an error code, not 0 that
> > > would mean success.
> > > 
> > > Fixes: a1fc41ac28d3 ("btrfs: use dummy extent buffer for super block sys chunk array read")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > 
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > 
> > All my fault, thanks for catching it.
> > Qu
> > 
> 
> I sent this patch in January and David was going to fold it into the
> original patch but it got lost.  Thanks, Christophe!

I found my reply to your fix that I folded the fixup, but then it got
lost for some reason. Probably because I picked the patchset from
mailing list again and did not take the local branch. I'll fold the fix
again as it' still in the unmerged branch. Thanks.
