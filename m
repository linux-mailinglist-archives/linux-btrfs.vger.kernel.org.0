Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41FC364906
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbhDSR3Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 13:29:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:48338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236655AbhDSR3Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 13:29:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62CBFAFAB;
        Mon, 19 Apr 2021 17:28:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ECBAEDA732; Mon, 19 Apr 2021 19:26:34 +0200 (CEST)
Date:   Mon, 19 Apr 2021 19:26:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v5 3/3] btrfs: zoned: automatically reclaim zones
Message-ID: <20210419172634.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
References: <cover.1618817864.git.johannes.thumshirn@wdc.com>
 <f4548d6db76cb1168266d1a216563441308b615b.1618817864.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4548d6db76cb1168266d1a216563441308b615b.1618817864.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 19, 2021 at 04:41:02PM +0900, Johannes Thumshirn wrote:
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -9,6 +9,8 @@
>  #include "disk-io.h"
>  #include "block-group.h"
>  
> +#define DEFAULT_RECLAIM_THRESH 75

This is not a .c local define so it needs a prefix and a comment what
the value means so something like

/*
 * Block groups filled more than this value (percents) will be scheduled
 * for background reclaim.
 */
#define BTRFS_DEFAULT_RECLAIM_THRESH		75
