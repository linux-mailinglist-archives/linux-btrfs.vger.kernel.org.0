Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239C84BE9A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 19:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380407AbiBUQ05 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 11:26:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380767AbiBUQ0B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 11:26:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532EA2714D
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 08:24:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B7A481F38E;
        Mon, 21 Feb 2022 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645460659;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17Cj3NRJ+Aa6aNKDFRSFsd4XddpcvcV3GfNjUAMPXrE=;
        b=gSLl3mWO8Ex4WMFJcG69wBWIs0jq/Z8NoqTzEcqa2SNaJAg2hbXNNKi0cRmlM1UL3BMX6h
        yvS6UqFxfNlscnZv1O831+7q/AY2ABhuZrgvnlgud8bhueKh5qB1QmbRB64JFFjhuen8fd
        bNzb6DVAhnwJWJRdtCaKot5uM9cUyng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645460659;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17Cj3NRJ+Aa6aNKDFRSFsd4XddpcvcV3GfNjUAMPXrE=;
        b=AeYco4XWBw8ldKdCDY6F8p08L65FtXJRHIKgFYiQggWgsRP+UjgMrPNo76/HGG0Yw72QNU
        mufP/XuVA4im0qBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AE594A3B8E;
        Mon, 21 Feb 2022 16:24:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6DEE6DA823; Mon, 21 Feb 2022 17:20:32 +0100 (CET)
Date:   Mon, 21 Feb 2022 17:20:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/3] btrfs: fix problem with balance recovery and snap
 delete
Message-ID: <20220221162032.GH12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645214059.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645214059.git.josef@toxicpanda.com>
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

On Fri, Feb 18, 2022 at 02:56:09PM -0500, Josef Bacik wrote:
> v1->v2:
> - reworked the fix based on Filipe's feedback.  Instead of just doing all the
>   snapshot delete at mount time simply keep track of any in-progress drops.
>   Then gate relocation on those drops finishing.  Once the drops finish we
>   unblock relocation and carry on like normal.
> 
> --- Original email ---
> Hello,
> 
> I found a problem where we'll try to add refs to blocks that no longer have
> references because we started a relocation while we had a half deleted snapshot
> in the file system.  This only occurs on a clean mount with a pending snapshot
> delete in place.  I saw this in production but lost the file system before I
> could test my patch.  However I reproduced it locally with some error injection.
> Without my patch we'd fail to run delayed refs with the warning in the commit
> message in the first patch, with my patch we mount and can use the file system.
> 
> The other two patches are just cleanups that i noticed while messing with this
> code.  Thanks,
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs: do not start relocation until in progress drops are done
>   btrfs: use btrfs_fs_info for deleting snapshots and cleaner
>   btrfs: pass btrfs_fs_info to btrfs_recover_relocation

Added as topic branch to for-next, thanks.
