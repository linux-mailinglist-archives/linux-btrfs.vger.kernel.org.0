Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5323F2A3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 12:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhHTKmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 06:42:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38274 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhHTKmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 06:42:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6C264220F7;
        Fri, 20 Aug 2021 10:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629456099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wVJSMMNE604ED037Lwk/md81a5ew3C5dfvNEY2ca1/A=;
        b=2X1RnBF/Dp+B0avUP2Q+3VwqY4Gr6jaEU0Q5i1LWKdDw02w8ReKdWvRx2ZMi0cvquxqHvf
        ISN8egPOQyaVMMNjxu6I8h5R8Q8StaEjg/v1UZPwRiPkbTWtLxGDlQd1EhDIRR5TV+4Dye
        XzD+t7TPoUZR1P2hL3ONIXBq+4vdSao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629456099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wVJSMMNE604ED037Lwk/md81a5ew3C5dfvNEY2ca1/A=;
        b=3ztxliX7qAwaGW8Cb6IPT/UOOVcu9l8fJIyt4b29MDnh4Ibim3WF18xtyyN1bviG9HUJ2p
        FcXi73x9f44vNmCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 62F36A3B89;
        Fri, 20 Aug 2021 10:41:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AAC4BDA730; Fri, 20 Aug 2021 12:38:41 +0200 (CEST)
Date:   Fri, 20 Aug 2021 12:38:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH] btrfs: fix stale reference to __btrfs_alloc_chunk
Message-ID: <20210820103841.GK5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210818222837.GY5047@twin.jikos.cz>
 <de039f41ff596a5ccd7e65f5754af6dec1f57969.1629431777.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de039f41ff596a5ccd7e65f5754af6dec1f57969.1629431777.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 12:27:52PM +0800, Anand Jain wrote:
> __btrfs_alloc_chunk() is renamed to btrfs_alloc_chunk() and then to
> btrfs_create_chunk() in the commits 11c67b1a40b0 and ad6b24de1d50
> respectively. And left the stale reference to __btrfs_alloc_chunk().
> Fix them.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> 
> David/Nikolay,
> 
> I commented about this earlier [1]
> 
>  [1]
>  https://patchwork.kernel.org/project/linux-btrfs/patch/20210705091643.3404691-1-nborisov@suse.com/

I missed that sorry and also expected that when a patch gets resent all
the feedback is also incorporated.

> I am fine if you want to rollup this patch to the patch (btrfs: rename
> btrfs_alloc_chunk to btrfs_create_chunk) and add my RB, or add this patch
> as a new one.

I'll fold it into the patch plus RB, thanks.
