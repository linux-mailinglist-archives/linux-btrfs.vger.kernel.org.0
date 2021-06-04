Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1634B39BAD9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFDOZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 10:25:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFDOZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 10:25:34 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 82AE021A33;
        Fri,  4 Jun 2021 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622816627;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PMeeHkyFEwRQWe80sabWlyGQquxBE0UNdBruLw4iQ18=;
        b=ZYHninJa11SDSapBdYmnkqsAIipfW+byNl3zRJ6eowKbqMUxigj2Oyv3ghK7lMaeV3YRAj
        hQk9jCFyxOKDpoXL5iY+1BUGUelNw5WIZuETxl7aSaTIMRCHq5bulhzRFYAlEhfCOl2/ba
        gHiuj9GmlNi4fcg9iQrk8+61v94CgrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622816627;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PMeeHkyFEwRQWe80sabWlyGQquxBE0UNdBruLw4iQ18=;
        b=SdxokqfDgz5Fp+CNGpDd9xwf7OKeKCZvBEGVt0Cpp7v5zG3Sli+u0HJyLQJGea0UFYrvTJ
        1ISELoSm8gzw2oDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7BE4CA3B85;
        Fri,  4 Jun 2021 14:23:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1A57DB228; Fri,  4 Jun 2021 16:21:05 +0200 (CEST)
Date:   Fri, 4 Jun 2021 16:21:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <20210604142105.GD31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210604132058.11334-1-dsterba@suse.com>
 <5aeca0cd-c6b2-939a-6f83-7ea5722076dc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aeca0cd-c6b2-939a-6f83-7ea5722076dc@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 04, 2021 at 09:41:09PM +0800, Anand Jain wrote:
> On 4/6/21 9:20 pm, David Sterba wrote:
> > The device stats can be read by ioctl, wrapped by command 'btrfs device
> > stats'. Provide another source where to read the information in
> > /sys/fs/btrfs/FSID/devinfo/DEVID/stats .
> 
>   The planned stat here is errors stat.
>   So why not rename this to error_stats?

I think it's commonly called device stats, dev stats, so when it's in
'devinfo' it's like it's the 'stats' for the device. We don't have other
stats, like regarding io but in that case it would make sense to
distnguish the names.
