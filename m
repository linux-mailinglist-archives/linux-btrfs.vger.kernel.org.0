Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A024C3613
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 20:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiBXTqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 14:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiBXTqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 14:46:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB271227581
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 11:45:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 77BDB21124;
        Thu, 24 Feb 2022 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645731931;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhAoIXFRtVnw7tnJ1+lgI3rgLZCc/QMAoxODfsEGNYQ=;
        b=dCS4C3rTgb1j1gyRTPj8rGoLOrdNB2/CjpMXUVy38jHUQpj4QAs8YDdbUcDEUB3GcK/KDD
        YL3fm7D/BGlWIZOzwY8iANXowh8pPrpXbLap5o6YRhvV2dweObr4BKExwaotpLUZydlnuH
        T73ShnDD6Res/aqt3M1qZtdFHm7NQhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645731931;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhAoIXFRtVnw7tnJ1+lgI3rgLZCc/QMAoxODfsEGNYQ=;
        b=0ZQOBbACc+/eeSbN9os2yyivzW0IuZ4IJLyyqEKYCm+jIUI0e0hTafAqLOVBO5+xPWRYIN
        eD4TsUNTB5i1u+DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 701F4A3B83;
        Thu, 24 Feb 2022 19:45:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57234DA818; Thu, 24 Feb 2022 20:41:42 +0100 (CET)
Date:   Thu, 24 Feb 2022 20:41:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: autodefrag: only scan one inode once
Message-ID: <20220224194142.GC12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1644737297.git.wqu@suse.com>
 <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
 <20220222173202.GL12643@twin.jikos.cz>
 <64987622-6786-6a67-ffac-65dc92ea90d0@gmx.com>
 <20220223155301.GP12643@twin.jikos.cz>
 <64e0cb5e-c5f0-a18b-1aa2-3aced6bb307c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e0cb5e-c5f0-a18b-1aa2-3aced6bb307c@gmx.com>
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

On Thu, Feb 24, 2022 at 02:59:24PM +0800, Qu Wenruo wrote:
> Checked the code, it looks fine to me, just one small question related
> to the ret < 0 case.
> 
> Unlike the refactored version, which can return < 0 even if we defragged
> some sectors. (Since we have different members to record those info)
> 
> If we have defragged any sector in btrfs_defrag_file(), but some other
> problems happened later, we will get a return value > 0 in this version.
> 
> It's a not a big deal, as we will skip to the last scanned position
> anyway, and we even have the safenet to increase @cur even if
> range.start doesn't get increased.
> 
> For backport it's completely fine.
> 
> Just want to make sure for the proper version, what's is the expected
> behavior.
> Exit as soon as any error hit, or continue defrag as much as possible?

I'd say continue. Some errors may be transient, some may stick until the
defrag ioctl runs, but that should lead to quickly enumerating the
extents at worst.

> And I'll rebase my btrfs_defrag_ctrl patchset upon your fixes.

I may postpone any defrag cleanups until 5.19 so we don't have different
code bases for the branch that may still require fixes and the
development one. It's too close to code freeze and pull request time,
we need to properly sync the fixes and development branches, so they
don't diverge, like it was with the kmap/lzo reverts that led to the
fixups.
