Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77FEF7AA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 19:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKSVo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 13:21:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:41316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbfKKSVo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 13:21:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C84EDAF79;
        Mon, 11 Nov 2019 18:21:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0964ADA7AF; Mon, 11 Nov 2019 19:21:46 +0100 (CET)
Date:   Mon, 11 Nov 2019 19:21:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Subject: Re: [next-20191108] Assertion failure in
 space-info.c:btrfs_update_space_info()
Message-ID: <20191111182146.GS3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        "linux-realtek-soc@lists.infradead.org" <linux-realtek-soc@lists.infradead.org>
References: <ebde863f-51f2-d761-4bae-1722ea256e08@suse.de>
 <3579f352-038a-08a7-30b8-f4935cf55f2c@gmx.com>
 <4392ccbc-85a1-10fa-bc7c-db19a4e9f86a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4392ccbc-85a1-10fa-bc7c-db19a4e9f86a@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 09, 2019 at 07:00:20AM +0100, Andreas Färber wrote:
> Am 09.11.19 um 05:01 schrieb Qu Wenruo:
> > On 2019/11/9 上午11:45, Andreas Färber wrote:
> >> On arm64 I'm seeing a regression between next-20191031 and next-20191105
> >> that breaks boot from my btrfs rootfs: next-20191105 and later oopses on
> >> found->lock, or with CONFIG_BTRFS_ASSERT asserts on a NULL "found"
> >> variable in btrfs_update_space_info().
> >>
> >> According to git-blame that code hasn't changed in months, and I didn't
> >> spot an obvious cause among the fs/btrfs/ commis between those two tags.
> > It looks like caused by "btrfs: block-group: Refactor
> > btrfs_read_block_groups()".
> 
> Thanks for the quick pointer - I've reverted all fs/btrfs/ commits down
> to that one and it was indeed the culprit.
> 
> > Due to another refactor, there are conflicts in that patch and is not
> > resolved properly.
> > 
> > Please try David's latest misc-next branch, which includes the proper
> > rebased refactor.
> 
> Unfortunately that won't work as I'm developing some 100+ patches for my
> linux-realtek.git, so I'll have to carry the reverts until the fix makes
> it into linux-next.git.

Fixed branch for linux-next will be pushed today, sorry for the
inconvenience.
