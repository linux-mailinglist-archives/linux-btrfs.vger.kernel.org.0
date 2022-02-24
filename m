Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3EF4C361B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 20:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiBXTs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 14:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiBXTs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 14:48:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EEE1B01A7
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 11:47:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D02A01F44D;
        Thu, 24 Feb 2022 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645732075;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAIQvN+lJ5KcZMeNnSzCHpI0GAhQuR83aooJ8irjWp0=;
        b=pyQHyfI58M1gogSF6YJgPoEbrOL/1GAa1PghiGwXIz99vadd23VuAsAk2wNbwr7h5ZHhVb
        B9S9VKTZ2ZCNP5b128JrEOMN7puwKMUuxTs75K23VYK8WYOERwDXtFuGO797l+dAp5Py4v
        gRtFVyNzTtB2tiA+XO93XB5xEwTH3Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645732075;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAIQvN+lJ5KcZMeNnSzCHpI0GAhQuR83aooJ8irjWp0=;
        b=lYpO5iU6LBneJAtblgFlDlC6N14Sup7NU+LQm1ibtQlPLbRQ3vIsBmnNNLiN9VxK8UCrzu
        Id3fim2ZzlkmtBDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C8BFAA3B83;
        Thu, 24 Feb 2022 19:47:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DFBE0DA818; Thu, 24 Feb 2022 20:44:06 +0100 (CET)
Date:   Thu, 24 Feb 2022 20:44:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: autodefrag: only scan one inode once
Message-ID: <20220224194406.GD12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1644737297.git.wqu@suse.com>
 <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
 <20220222173202.GL12643@twin.jikos.cz>
 <64987622-6786-6a67-ffac-65dc92ea90d0@gmx.com>
 <20220223155301.GP12643@twin.jikos.cz>
 <64e0cb5e-c5f0-a18b-1aa2-3aced6bb307c@gmx.com>
 <d760d854-b3d4-6118-9b8d-5b1e775333e7@gmx.com>
 <00ad978f-195a-9f47-043a-befb0bca0faa@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ad978f-195a-9f47-043a-befb0bca0faa@gmx.com>
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

On Thu, Feb 24, 2022 at 08:18:53PM +0800, Qu Wenruo wrote:
> > OK, during my rebasing, I found a bug in the rebased version of "btrfs:
> > reduce extent threshold for autodefrag".
> >
> > It doesn't really pass defrag->extent_thresh into btrfs_defrag_file(),
> > thus it's not working at all.

That would explain why I did not see any difference between two fio runs
in the amount of IO.

> This is the fixed version of that patch, based on your branch:
> 
> https://github.com/adam900710/linux/commit/5759b9f0006d205019d2ba9220b52c58054f3758

Thanks, I've added the missing line in __btrfs_run_defrag_inode and
updated the patches in misc-next and misc-5.17.
