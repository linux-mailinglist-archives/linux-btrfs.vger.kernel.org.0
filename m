Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537254A74D6
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 16:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbiBBPmq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 10:42:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48276 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiBBPmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 10:42:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BBFB51F397;
        Wed,  2 Feb 2022 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643816564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDuwD0BEd9DbRlsE0HpE8l/M5E+o6xPfWdxLvfj3lEI=;
        b=g735szYdqGTjRsrl9hn0iddHxNhVH/eOGULoqsS0wAOcgujwWkil9iYvLQ7ozfwoks+CjT
        VjPlWKsOEVfyfT/OTLChFeCGISyCv9gbo9x5N6GXWnGMY1clep2xuZRk4yz8uiJc8kSzbs
        Loe6P4Yg7kgGopRWhxMR+t18NPsiKdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643816564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDuwD0BEd9DbRlsE0HpE8l/M5E+o6xPfWdxLvfj3lEI=;
        b=wlIOs4EJst3vcs7e4sl1m+0IPUDuz1yaGcVur9T5DBLMG9EqMAKlhyS6AarN4wPnBfrsq9
        15A6SZtDl+pVCtCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B3495A3B8C;
        Wed,  2 Feb 2022 15:42:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 357B7DA781; Wed,  2 Feb 2022 16:42:00 +0100 (CET)
Date:   Wed, 2 Feb 2022 16:42:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     piorunz <piorunz@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't hold CPU for too long when defragging a file
Message-ID: <20220202154200.GA14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, piorunz <piorunz@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c572e24e1556b87cadb20761edbc7e33bb93ad20.1643547144.git.wqu@suse.com>
 <20220201145304.GP14046@twin.jikos.cz>
 <970e0c2d-b36c-45bc-3b1f-cb1b9dbdc861@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970e0c2d-b36c-45bc-3b1f-cb1b9dbdc861@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 01, 2022 at 03:13:33PM +0000, piorunz wrote:
> On 01/02/2022 14:53, David Sterba wrote:
> > On Sun, Jan 30, 2022 at 08:53:15PM +0800, Qu Wenruo wrote:
> >> There is a user report about "btrfs filesystem defrag" causing 120s
> >> timeout problem.
> >
> > Do you have link of the report please?
> 
> That would be most likely my topic here on this group. I had
> conversation with Qu while discussing the topic and he commented 120s
> kernel timeouts while defragging.
> 
> Topic is here on this group: "fstab autodegrag with 5.10 & 5.15 kernels,
> Debian?" (typo is hilarious haha)
> 
> Link:
> https://lore.kernel.org/linux-btrfs/94244e1a-7ccd-6f68-9052-5c01876b3939@gmx.com/T/#t
> 
> This is filesystem in question:
> $ sudo btrfs filesystem usage /home
> Overall:
>      Device size:                   7.03TiB
>      Device allocated:              3.93TiB
>      Device unallocated:            3.10TiB
>      Device missing:                  0.00B
>      Used:                          3.90TiB
>      Free (estimated):              1.56TiB      (min: 1.56TiB)
>      Free (statfs, df):             1.56TiB
>      Data ratio:                       2.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
> 
> Data,RAID10: Size:1.96TiB, Used:1.94TiB (99.46%)
>     /dev/sdd3    1001.00GiB
>     /dev/sde3    1001.00GiB
>     /dev/sda4    1001.00GiB
>     /dev/sdf4    1001.00GiB
> 
> Metadata,RAID10: Size:9.00GiB, Used:3.73GiB (41.50%)
>     /dev/sdd3       4.50GiB
>     /dev/sde3       4.50GiB
>     /dev/sda4       4.50GiB
>     /dev/sdf4       4.50GiB
> 
> System,RAID10: Size:64.00MiB, Used:240.00KiB (0.37%)
>     /dev/sdd3      32.00MiB
>     /dev/sde3      32.00MiB
>     /dev/sda4      32.00MiB
>     /dev/sdf4      32.00MiB
> 
> Unallocated:
>     /dev/sdd3     793.48GiB
>     /dev/sde3     793.48GiB
>     /dev/sda4     793.48GiB
>     /dev/sdf4     793.48GiB
> 
> 
> Btrfs RAID10, consists of 4x 2TB spinners.
> Mount options are:
> /home           btrfs   noatime,space_cache=v2,compress-force=zstd:3 0 2
> 
> I never had any timeouts for last 2 years on this server, performance is
> very good for amount of load I have on them. I only experienced timeouts
> once I decided to defrag.
> 
> Snippet from sudo journalctl --utc -k -b -1 has been attached.
> Please notice how different tasks and pids are being timeouted while
> defrag took entire filesystem for itself, depriving everything else from
> accessing. Errors continued after that but I just cut this for you so
> you have the idea. Ideally, defrag should not take entire I/O for
> itself, but filesystem should continue to work as usual. Like SMART Long
> background test. It does not prevent use of the drive. That's how I feel
> defrag should work.
> 
> I will be happy to provide more details if required.

Thanks, not necessary. I missed the original discussion and there were
several defrag bugs floating around so this is for my reference and to
save it in the patch too.
