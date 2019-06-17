Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6423048276
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfFQMbP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 08:31:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:34136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfFQMbP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 08:31:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A2A2AF8E;
        Mon, 17 Jun 2019 12:31:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80A1DDA8D1; Mon, 17 Jun 2019 14:32:02 +0200 (CEST)
Date:   Mon, 17 Jun 2019 14:32:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <FdManana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: shut up bogus -Wmaybe-uninitialized warning
Message-ID: <20190617123202.GD19057@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <FdManana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190617110738.2085060-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617110738.2085060-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 17, 2019 at 01:07:28PM +0200, Arnd Bergmann wrote:
> gcc sometimes can't determine whether a variable has been initialized
> when both the initialization and the use are conditional:
> 
> fs/btrfs/props.c: In function 'inherit_props':
> fs/btrfs/props.c:389:4: error: 'num_bytes' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     btrfs_block_rsv_release(fs_info, trans->block_rsv,
> 
> This code is fine. Unfortunately, I cannot think of a good way to
> rephrase it in a way that makes gcc understand this, so I add
> a bogus initialization the way one should not.

Looks ok, patch added to devel queue, thanks.
> 
> Fixes: d7400ee1b476 ("btrfs: use the existing reserved items for our first prop for inheritance")

I'd rather not add the Fixes tag here as it's just a compilation warning
for some old unknown version of gcc. I've checked that 8.3.1 and 9.1.1
don't print the warning and I consider any other version to be up to the
user of such environment to apply fixups as needed, but not to let the
stable machinery pick it up.
