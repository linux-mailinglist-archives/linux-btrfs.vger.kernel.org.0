Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C2E7997DE
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbjIIMTC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Sep 2023 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjIIMTB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Sep 2023 08:19:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81CCCA
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 05:18:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB83C433C7;
        Sat,  9 Sep 2023 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694261937;
        bh=gKeiGZ3eOHObUaLTBW/+gbbLcv6ASA/tyxdtoaiWrhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/Kcvz1yYzcKHAFeDqNYtQ0ZBd0rptkNxcsXGfNjp0XbJNm5wlx+tROx3/oBVSB4K
         3btS0+Tmc5v33705s95oDbMMHvUOgfXPIT05PvxgW9Gpaw+dCN2N0Y7k8UpCMmlysj
         uTfgiFrFSEoA64LeDrEcL8P5ZdAKBd+yqQAvhqyYhCCrqL8YcyMIM9DgDdMgFWH6Co
         TvecxRojViGshYtSL5x18Ub2lhxM4WWKopw80TIPgN5haeu+vJpdtQv/h8mYeO9M7J
         QQqGWDgYk1ZyHYcGS8LIlQ/+XIcB+TQOucRwSxUsyMRrLHW0hjviAqLoS1fRYXHNvR
         XlToQHpW04pFw==
Date:   Sat, 9 Sep 2023 13:18:49 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Evangelos Foutras <evangelos@foutras.com>
Cc:     Ian Johnson <ian@ianjohnson.dev>, linux-btrfs@vger.kernel.org
Subject: Re: Possible readdir regression with BTRFS
Message-ID: <ZPxiqYCeMb6vOjw9@debian0.Home>
References: <YR1P0S.NGASEG570GJ8@ianjohnson.dev>
 <ZPweR/773V2lmf0I@debian0.Home>
 <00ed09b9-d60c-4605-b3b6-f4e79bf92fca@foutras.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ed09b9-d60c-4605-b3b6-f4e79bf92fca@foutras.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 09, 2023 at 02:52:19PM +0300, Evangelos Foutras wrote:
> Hi Filipe,
> 
> Please be aware that this bug might not be as harmless as it seems. I'm not
> sure if the fix you're preparing would also fix an issue we saw at Arch
> Linux but I thought I'd mention it here.
> 
> We have a package repository server with 4x10 TB drives in RAID10 (btrfs
> only, no mdadm). On multiple mirrors syncing from it we have seen rsync
> occasionally delete ~4 small (<10 MB) files that get frequently updated by
> renaming temporary files into them. This only happened with 6.4.12 and went
> away after going back to 6.4.10 (the former had the commit Ian mentioned).
> 
> Unfortunately I don't have a reproducer for this. I can only describe what
> our repo-add script does and how rsync behaves during problematic syncs.
> 
> Our repo-add script frequently adds packages to the extra repo by doing:
> 
>   ln -f extra.db.tar.gz extra.db.tar.gz.old
>   mv .tmp.extra.db.tar.gz extra.db.tar.gz
> 
> And the same for extra.files.tar.gz:
> 
>   ln -f extra.files.tar.gz extra.files.tar.gz.old
>   mv .tmp.extra.files.tar.gz extra.files.tar.gz
> 
> While the server was running Linux 6.4.12, rsync on some mirrors would
> occasionally (3-4 times in the day) delete these files:
> 
>   deleting extra/os/x86_64/extra.files.tar.gz.old
>   deleting extra/os/x86_64/extra.files.tar.gz
>   deleting extra/os/x86_64/extra.db.tar.gz.old
>   deleting extra/os/x86_64/extra.db.tar.gz
> 
> Since renames are atomic, I would expect this scenario to never happen.
> 
> Again, sorry for not being able to provide a proper reproducer like Ian;
> there is probably some timing interaction with how rsync does directory
> scanning and repo-add updating the directory entry during this time.

No worries, I've just sent a patchset with 2 patches:

https://lore.kernel.org/linux-btrfs/cover.1694260751.git.fdmanana@suse.com/

I've only seen your message after sending it, but I think the first patch
should fix what you are seeing.

Thanks.

> 
> [1] https://gitlab.archlinux.org/pacman/pacman/-/blob/v6.0.2/scripts/repo-add.sh.in#L473
