Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5791D490CEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 18:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbiAQRAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 12:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiAQQ7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 11:59:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E6C06175D
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 08:59:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3500E611DA
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 16:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1819BC36AED;
        Mon, 17 Jan 2022 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642438776;
        bh=aJLCLqGeuxvWyijrjslNgzldnlYnaj8pdXLG2b0bW5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLEJaQaa+GieK9NDDxkfXAU/TuZpv2BylGH3Ks/HPA6ZwQ5wXUtqHaaryVo5muFMH
         TqZhUGaOt2smDjvhf/lJIkp8iUxdyEXRAJDpgoEWLgfIHTGB3wKk/y8IAJBBDfsOMF
         /zvgt5VJ3+n3imgAI/kkVWwVnLEdBJpIbU8ICrHZtbartvRDpty+ErYORkJxP1pHNu
         rXGBN1fYC4cV9SJAvq0llLbBO7j4QpvdYqtwMQ9wShmD7vApk2R3JmODaX4NzPBN5s
         7CUFrk11hOoHZD4yEdFwxPoLduUuwde/bqAfqObGHMAFTA7JKh91Jo1QCxmq6hxcIm
         t33/TZorZ4ubA==
Date:   Mon, 17 Jan 2022 16:59:33 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     =?iso-8859-1?Q?Fran=E7ois-Xavier?= Thomas <fx.thomas@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
Message-ID: <YeWgdQ2ZvceLTIej@debian9.Home>
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YeVawBBE3r6hVhgs@debian9.Home>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote:
> On Mon, Jan 17, 2022 at 11:06:42AM +0100, François-Xavier Thomas wrote:
> > Hello all,
> > 
> > Just in case someone is having the same issue: Btrfs (in the
> > btrfs-cleaner process) is taking a large amount of disk IO after
> > upgrading to 5.16 on one of my volumes, and multiple other people seem
> > to be having the same issue, see discussion in [0].
> > 
> > [1] is a close-up screenshot of disk I/O history (blue line is write
> > ops, going from a baseline of some 10 ops/s to around 1k ops/s). I
> > downgraded from 5.16 to 5.15 in the middle, which immediately restored
> > previous performance.
> > 
> > Common options between affected people are: ssd, autodefrag. No error
> > in the logs, and no other issue aside from performance (the volume
> > works just fine for accessing data).
> > 
> > One person reports that SMART stats show a massive amount of blocks
> > being written; unfortunately I do not have historical data for that so
> > I cannot confirm, but this sounds likely given what I see on what
> > should be a relatively new SSD.
> > 
> > Any idea of what it could be related to?
> 
> There was a big refactor of the defrag code that landed in 5.16.
> 
> On a quick glance, when using autodefrag it seems we now can end up in an
> infinite loop by marking the same range for degrag (IO) over and over.
> 
> Can you try the following patch? (also at https://pastebin.com/raw/QR27Jv6n)

Actually try this one instead:

https://pastebin.com/raw/EbEfk1tF

Also, there's a bug with defrag running into an (almost) infinite loop when
attempting to defrag a 1 byte file. Someone ran into this and I've just sent
a fix for it:

https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/

Maybe that is what you are running into when using autodefrag.
Firt try that fix for the 1 byte file case, and if after that you still run
into problems, then try with the other patch above as well (both patches
applied).

Thanks.



> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a5bd6926f7ff..0a9f6125a566 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>                 if (em->generation < newer_than)
>                         goto next;
>  
> +               /*
> +                * Skip extents already under IO, otherwise we can end up in an
> +                * infinite loop when using auto defrag.
> +                */
> +               if (em->generation == (u64)-1)
> +                       goto next;
> +
>                 /*
>                  * For do_compress case, we want to compress all valid file
>                  * extents, thus no @extent_thresh or mergeable check.
> 
> 
> > 
> > François-Xavier
> > 
> > [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_performance_degradation_after_upgrading/
> > [1] https://imgur.com/oYhYat1
