Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F471646AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBSORv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 09:17:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:35534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgBSORv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 09:17:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0CF03B9E7;
        Wed, 19 Feb 2020 14:17:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5F881DA70E; Wed, 19 Feb 2020 15:17:30 +0100 (CET)
Date:   Wed, 19 Feb 2020 15:17:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     yu kuai <yukuai3@huawei.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH 2/3] btrfs: remove set but not used variable 'parent'
Message-ID: <20200219141730.GX2902@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        yu kuai <yukuai3@huawei.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com
References: <20200219112203.17075-1-yukuai3@huawei.com>
 <f7bc478c-2fe9-2694-cd0c-92c188d178c5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7bc478c-2fe9-2694-cd0c-92c188d178c5@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 19, 2020 at 01:34:53PM +0200, Nikolay Borisov wrote:
> 
> 
> On 19.02.20 г. 13:22 ч., yu kuai wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > fs/btrfs/tree-log.c: In function ‘walk_down_log_tree’:
> > fs/btrfs/tree-log.c:2702:24: warning: variable ‘parent’
> > set but not used [-Wunused-but-set-variable]
> > fs/btrfs/tree-log.c: In function ‘walk_up_log_tree’:
> > fs/btrfs/tree-log.c:2803:26: warning: variable ‘parent’
> > set but not used [-Wunused-but-set-variable]
> > 
> > They are never used, and so can be removed.
> > 
> > Signed-off-by: yu kuai <yukuai3@huawei.com>
> 
> Ah yes, those two are a result of my :
> 
> e084c5ab48f9 ("btrfs: Call btrfs_pin_reserved_extent only during active
> transaction")  (in misc-next branch)
> 
> David perhaps you can squash the two var removals into the original patch?

Yes I'll do that.
