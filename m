Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD582B499D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 16:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgKPPkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 10:40:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:35834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbgKPPkT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 10:40:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99E3DAC0C;
        Mon, 16 Nov 2020 15:40:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E42CEDA6E3; Mon, 16 Nov 2020 16:38:33 +0100 (CET)
Date:   Mon, 16 Nov 2020 16:38:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Message-ID: <20201116153833.GO6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
References: <0e9eb675e0a199bf034f13c58fbe5678f4e94a3c.1605513154.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9eb675e0a199bf034f13c58fbe5678f4e94a3c.1605513154.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 16, 2020 at 04:52:54PM +0900, Johannes Thumshirn wrote:
> Syzbot reported a possible use-after-free when printing a duplicate device
> warning device_list_add().
> 
> At this point it can happen that a btrfs_device::fs_info is not correctly
> setup yet, so we're accessing stale data, when printing the warning
> message using the btrfs_printk() wrappers.
> 
> Instead of printing possibly uninitialized or already freed memory in
> btrfs_printk(), explicitly pass in a NULL fs_info so the printing of the
> device name will be skipped altogether.

This would be good to add some info about the evolution of the fix, also
a comment saying why we can't use fs_info.
