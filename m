Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60A33FF025
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbhIBP1k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 11:27:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40148 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345698AbhIBP1k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 11:27:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 50FB81FFB9;
        Thu,  2 Sep 2021 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630596400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wl2cw3h4WwhXXiT5vsBYJYaYhGV35VXD7xW0oMOfr4=;
        b=PL8m5cnnA1CCQjZscy8+yHYUqTKHK/07/FuT9rlTrvlleuGftXiSs6FcxqTyM/GonwuEUL
        RWP9B+SP7AVawgxV9imcglfN8IM3FkUwgN1dDH+SUHg5e+SbSNEJrx8//brULM8d4cbjUC
        2F8j9dT8g0O0dbZveg7SN4uUU0DhzJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630596400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wl2cw3h4WwhXXiT5vsBYJYaYhGV35VXD7xW0oMOfr4=;
        b=+97kWHsSTnB8Nx6DJZX54mmmvnkwC9V/7J19MHtv0RIDdsnmP/Ip75CAVZG3SPZrQOeEkV
        fXwnCh16XXfwowDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 47C28A3BA3;
        Thu,  2 Sep 2021 15:26:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DCCC7DA72B; Thu,  2 Sep 2021 17:26:38 +0200 (CEST)
Date:   Thu, 2 Sep 2021 17:26:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
Subject: Re: [PATCH V5 0/4] btrf_show_devname related fixes
Message-ID: <20210902152638.GW3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
References: <cover.1629780501.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629780501.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 24, 2021 at 01:05:18PM +0800, Anand Jain wrote:
> Su Yue reported [1] warn() as a result of a race between the following two
> threads,
>   Thread-A: function stack leading to btrfs_prepare_sprout()
> and
>   Thread-B: function stack leading to btrfs_show_devname()
> 
> [1]  https://patchwork.kernel.org/project/linux-btrfs/patch/20210818041944.5793-1-l@damenly.su/
> 
> Anand Jain (4):
>   btrfs: convert latest_bdev type to struct btrfs_device and rename
>   btrfs: use latest_dev in btrfs_show_devname
>   btrfs: update latest_dev when we sprout
>   btrfs: fix comment about the btrfs_show_devname

Added to misc-next, with some minor fixups, thanks.
