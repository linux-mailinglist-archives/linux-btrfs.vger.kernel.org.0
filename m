Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36E1BECB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 01:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgD2XtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 19:49:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgD2XtQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 19:49:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F873AC6D;
        Wed, 29 Apr 2020 23:49:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C5DEDA728; Thu, 30 Apr 2020 01:48:26 +0200 (CEST)
Date:   Thu, 30 Apr 2020 01:48:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        ethanwu <ethanwu@synology.com>, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix gcc-4.8 build warning
Message-ID: <20200429234826.GK18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        ethanwu <ethanwu@synology.com>, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200429132743.1295615-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429132743.1295615-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 29, 2020 at 03:27:32PM +0200, Arnd Bergmann wrote:
> Some older compilers like gcc-4.8 warn about mismatched curly
> braces in a initializer:
> 
> fs/btrfs/backref.c: In function 'is_shared_data_backref':
> fs/btrfs/backref.c:394:9: error: missing braces around
> initializer [-Werror=missing-braces]
>   struct prelim_ref target = {0};
>          ^
> fs/btrfs/backref.c:394:9: error: (near initialization for
> 'target.rbnode') [-Werror=missing-braces]
> 
> Use the GNU empty initializer extension to avoid this.
> 
> Fixes: ed58f2e66e84 ("btrfs: backref, don't add refs from shared block when resolving normal backref")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to devel queue, thanks.
