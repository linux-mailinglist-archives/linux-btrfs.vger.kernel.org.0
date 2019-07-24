Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17E373253
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfGXO4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 10:56:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:46450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387502AbfGXO4u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 10:56:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14E18ACCA;
        Wed, 24 Jul 2019 14:56:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3261DDA808; Wed, 24 Jul 2019 16:57:26 +0200 (CEST)
Date:   Wed, 24 Jul 2019 16:57:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Qu Wenruo <wqu@suse.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: reduce stack usage for
 btrfsic_process_written_block
Message-ID: <20190724145726.GP2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>, Qu Wenruo <wqu@suse.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190708124019.3374246-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708124019.3374246-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 08, 2019 at 02:40:09PM +0200, Arnd Bergmann wrote:
> btrfsic_process_written_block() cals btrfsic_process_metablock(),
> which has a fairly large stack usage due to the btrfsic_stack_frame
> variable. It also calls btrfsic_test_for_metadata(), which now
> needs several hundreds of bytes for its SHASH_DESC_ON_STACK().
> 
> In some configurations, we end up with both functions on the
> same stack, and gcc warns about the excessive stack usage that
> might cause the available stack space to run out:
> 
> fs/btrfs/check-integrity.c:1743:13: error: stack frame size of 1152 bytes in function 'btrfsic_process_written_block' [-Werror,-Wframe-larger-than=]
> 
> Marking both child functions as noinline_for_stack helps because
> this guarantees that the large variables are not on the same
> stack frame.
> 
> Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to misc-next, thanks.
