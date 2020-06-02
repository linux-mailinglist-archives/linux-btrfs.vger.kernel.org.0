Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216C51EBB3B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 14:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBMI3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 08:08:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgFBMI3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jun 2020 08:08:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA71AACA3;
        Tue,  2 Jun 2020 12:08:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 93F8FDA79B; Tue,  2 Jun 2020 14:08:25 +0200 (CEST)
Date:   Tue, 2 Jun 2020 14:08:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] small cleanups for find_first_block_group
Message-ID: <20200602120825.GF18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200602100557.6938-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602100557.6938-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 02, 2020 at 07:05:55PM +0900, Johannes Thumshirn wrote:
> While trying to learn the Block Group code I've found some cleanup
> possibilities for find_first_block_group().
> 
> Here's a proposal to make $ffbg a bit more easier to read by untangling the
> gotos and if statements.
> 
> The patch set is based on misc-next from May 26 morning with 
> HEAD 3f4a266717ed ("btrfs: split btrfs_direct_IO to read and write part")
> and xfstests showed no regressions to the base misc-next in my test setup.
> 
> Changes to v2:
> - Dropped label removal patch (David)
> - Don't return early inside the loop (David)

Thanks, added to misc-next.
