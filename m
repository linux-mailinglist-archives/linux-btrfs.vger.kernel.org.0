Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9ED914CC61
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 15:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgA2OZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 09:25:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:55302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgA2OZs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 09:25:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C7EAACC2;
        Wed, 29 Jan 2020 14:25:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74A5CDA730; Wed, 29 Jan 2020 15:25:26 +0100 (CET)
Date:   Wed, 29 Jan 2020 15:25:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Message-ID: <20200129142526.GE3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 28, 2020 at 12:59:26AM +0900, Johannes Thumshirn wrote:
> This patch series removes the use of buffer_heads from btrfs' super block read
> and write paths. It also converts the integrity-checking code to only work
> with pages and BIOs.
> 
> Compared to buffer heads, this gives us a leaner call path, as the
> buffer_head code wraps around getting pages from the page-cache and adding
> them to BIOs to submit.
> 
> The first patch removes buffer_heads from superblock reading.  The second
> removes it from super_block writing and the subsequent patches remove the
> buffer_heads from the integrity check code.
> 
> It's based on misc-next from Wednesday January 22, and doesn't show any
> regressions in xfstests to the baseline.
> 
> Changes to v2:
> - Removed patch #1 again
> - Added Reviews from Josef
> - Re-visited page locking, but not changes, it retains the same locking scheme
>   the buffer_heads had
> - Incroptorated comments from David regarding open-coding functions
> - For more details see the idividual patches.
> 
> 
> Changes to v1:
> - Added patch #1
> - Converted sb reading and integrity checking to use the page cache
> - Added rationale behind the conversion to the commit messages.
> - For more details see the idividual patches.
> 
> 
> Johannes Thumshirn (5):
>   btrfs: remove buffer heads from super block reading
>   btrfs: remove use of buffer_heads from superblock writeout

For next iteration, please change the subjects of the two patches to say
"replace buffer heads with bio for superblock reading". Thanks.
