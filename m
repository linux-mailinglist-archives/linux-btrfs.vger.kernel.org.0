Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEADF3F0429
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhHRNEa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 09:04:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42878 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbhHRNE3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 09:04:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 179E52206E;
        Wed, 18 Aug 2021 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629291834;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vv/XldwWwxRsjl9STrb8PK86qyynI5l2/JaMX10QQ+M=;
        b=WXIxOZ77KbHhEDKaYqEO3LtHzxBb4CT8skHZk20lWxonQIurKEVJ8sJDJWmxMfl8HRVHAv
        8xmEhLxDRVtYEI/OQuqvfr9ZvUIk+s9Pi/Mj/yaKxdvfiSCeMITUaQbx86IkdmD8oFtuiJ
        zI27wiSX8rSqK7acjULTa3JbtmFl0CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629291834;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vv/XldwWwxRsjl9STrb8PK86qyynI5l2/JaMX10QQ+M=;
        b=j8Wx1iWN9AOGqT1wPEGilckipGpV9Xkkbb65oyjFnHlS4lwgPwkBvwe/aihcCvl7KITw8L
        kPvpMFEY6o0hbtCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 10AD5A3B91;
        Wed, 18 Aug 2021 13:03:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0B71DA72C; Wed, 18 Aug 2021 15:00:56 +0200 (CEST)
Date:   Wed, 18 Aug 2021 15:00:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: swapfile with BTRFS RAID 1
Message-ID: <20210818130054.GU5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <10958794.vSJxiKAMbr@ananda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10958794.vSJxiKAMbr@ananda>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 02:53:12PM +0200, Martin Steigerwald wrote:
> Hi!
> 
> Regarding swapfile support in BTRFS I found it does not work on RAID 1:
> 
> BTRFS warning (device somepartition): swapfile must have single data 
> profile
> 
> as is documented
> 
> https://btrfs.wiki.kernel.org/index.php/Manpage/
> btrfs(5)#SWAPFILE_SUPPORT
> 
> Now is there a way to tell BTRFS that the swapfile should be single 
> profile?
> 
> I see "btrfs filesystem usage" says "no" for "multiple profiles". But I 
> also got the following hint that it is not yet supported to specify a 
> different profile for a subvolume:
> 
> https://unix.stackexchange.com/questions/196490/what-can-i-do-with-btrfs-profiles
> 
> I also did not find anything in btrfs subvolume manpage about it.
> 
> So just not possible at the moment?

That's right, not possible at the moment.
