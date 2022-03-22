Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5B4E46DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 20:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiCVTpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 15:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiCVTpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 15:45:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C566812605
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 12:43:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3C74B210F0;
        Tue, 22 Mar 2022 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647978215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zGXDRapJSeHSWrhl/9GFaGIWaHjRDCzv1Ffah+/YMoU=;
        b=anZVIMo6/ttePrUguXk6oxqLA/qT7bwkyJNZ4Acqm1R+Isfs/4vnnXxAeyLrMvxyl08/rn
        cxq8PuSeGVier6uSFOJPGHoZKcr+HPXm0HA3siF6uHf+06Yje3xC56em3eMMv4lbYDCvFD
        pYHzAilMhZ/sPb8OJISTg6/vYebAiQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647978215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zGXDRapJSeHSWrhl/9GFaGIWaHjRDCzv1Ffah+/YMoU=;
        b=hUmYPWZrn/IpAI86otVJscpR/TexsqjwE3e801zv6NjD2Wpssw/e3IQ1CHEW3nyGaQB5Oz
        +k5V8cGgYB0fHuDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 32C30A3B88;
        Tue, 22 Mar 2022 19:43:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B71D7DA818; Tue, 22 Mar 2022 20:39:32 +0100 (CET)
Date:   Tue, 22 Mar 2022 20:39:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Kaiwen Hu <kevinhu@synology.com>, linux-btrfs@vger.kernel.org,
        robbieko@synology.com, cccheng@synology.com, seanding@synology.com
Subject: Re: [PATCH] btrfs: prevent subvol with swapfile from being deleted
Message-ID: <20220322193932.GI12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Kaiwen Hu <kevinhu@synology.com>, linux-btrfs@vger.kernel.org,
        robbieko@synology.com, cccheng@synology.com, seanding@synology.com
References: <20220322102705.1252830-1-kevinhu@synology.com>
 <b1c66869-2920-9055-faa1-a84b05958289@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c66869-2920-9055-faa1-a84b05958289@gmx.com>
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

On Tue, Mar 22, 2022 at 06:47:59PM +0800, Qu Wenruo wrote:
> > @@ -10419,7 +10425,17 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
> >   	 * before walking the extents because we don't want a concurrent
> >   	 * snapshot to run after we've already checked the extents.
> >   	 */
> > +	spin_lock(&root->root_item_lock);
> > +	if (btrfs_root_dead(root)) {
> 
> This looks a little weird to me.
> 
> If the root is already dead, it means we should not be able to access
> any file inside the subvolume.
> 
> How could we go into btrfs_swap_activate() while the root is already dead?
> 
> Or is there some special race I missed?

The deletion has a few steps, eg. the dentry is removed, root is marked
as dead and different thing locking protection.

I was wondering about file descriptor access to the subvolume and
calling swapon on that, but swapon/swapoff is a syscall and work with a
path argument so that can't happen. I haven't checked in what order are
the dentry removal and dead flag done, it could be theoretically
possible that there's a short window where the dentry is accessible and
subvolume already marked.
