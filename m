Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8B442FF7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 15:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhKBOPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 10:15:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45334 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhKBOPr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 10:15:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E9EC81FD4C;
        Tue,  2 Nov 2021 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635862391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igjBU/WUsf9jko6sN3aVj8EUOyPh5nUg6c380aTZpT4=;
        b=uZkf2csTfmh7qVBADDYMMdBDJrIk1IOntkcDKN/HnBalD8gYFXVmf0ib29vJ6D6Q4BHzxt
        uaNq+7J7XgN75IqNwNi+RJc3EQl8XH8AKX2X7AU5JTFcE+Mt/+xuxYvozhyQXoW2GO/b94
        Lme8bDXlcDL+NLwAswQeEujIDqXR5GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635862391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igjBU/WUsf9jko6sN3aVj8EUOyPh5nUg6c380aTZpT4=;
        b=MbxSGHnM8xi6wtW8EniBHGIxWKSs0V9KuZvH+KdCUszijH/cMwXOeEYjloa7A8mdP4PWPB
        6QA7ETY3bGHlkiDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E2946A3B83;
        Tue,  2 Nov 2021 14:13:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97D7ADA7A9; Tue,  2 Nov 2021 15:12:36 +0100 (CET)
Date:   Tue, 2 Nov 2021 15:12:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: Make "btrfs filesystem df" command to
 show upper case profile
Message-ID: <20211102141236.GI20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211102120637.44447-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102120637.44447-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 08:06:37PM +0800, Qu Wenruo wrote:
> [BUG]
> Since commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str
> to use raid table"), fstests/btrfs/023 and btrfs/151 will always fail.
> 
> The failure of btrfs/151 explains the reason pretty well:
> 
> btrfs/151 1s ... - output mismatch
>     --- tests/btrfs/151.out	2019-10-22 15:18:14.068965341 +0800
>     +++ ~/xfstests-dev/results//btrfs/151.out.bad	2021-11-02 17:13:43.879999994 +0800
>     @@ -1,2 +1,2 @@
>      QA output created by 151
>     -Data, RAID1
>     +Data, raid1
>     ...
>     (Run 'diff -u ~/xfstests-dev/tests/btrfs/151.out ~/xfstests-dev/results//btrfs/151.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use
> raid table") will use btrfs_raid_array[index].raid_name, which is all
> lower case.
> 
> [FIX]
> There is no need to bring such output format change.

Well, indeed, I thought it won't be such a problem. If we want to have
the upper case version, it could be better to add another string to the
raid table. It is a bit of duplication but it would be easier to avoid
the temporary buffers whenever it's printed. For kernel we don't need
that but progs print the profiles a lot.
