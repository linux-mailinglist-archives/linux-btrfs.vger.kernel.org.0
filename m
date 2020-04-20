Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E671B1A14
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 01:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDTXVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 19:21:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgDTXVA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 19:21:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5A755AE44;
        Mon, 20 Apr 2020 23:20:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C995EDA70B; Tue, 21 Apr 2020 01:20:16 +0200 (CEST)
Date:   Tue, 21 Apr 2020 01:20:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: fix setting last_trans for reloc roots
Message-ID: <20200420232016.GL18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <20200410154248.2646406-1-josef@toxicpanda.com>
 <SN4PR0401MB35985AA68F3ECB8C8AAE9D3F9BD80@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB3598C2A93849EB046D06AAC59BD80@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598C2A93849EB046D06AAC59BD80@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 03:34:30PM +0000, Johannes Thumshirn wrote:
> On 16/04/2020 14:38, Johannes Thumshirn wrote:
> > This fixes a kmemleak complaint from btrfs/074, complete re-run of
> > xfstests is pending, but one down again.
> > 
> > Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> 
> I'll take that back, I still see a leak of 'cur_trans' allocated in 
> join_transaction() for btrfs/074 on a full xfstests run. The same leak 
> is reported for btrfs/072 and generic/127.

I'm not sure, but the patch "btrfs: drop logs when we've aborted a
transaction" is fixing transaction handle leaks. I've added it to
misc-next, the effects have been observed in test generic/475 so it's
only a weak link, tests btrfs/074 do not stress the transaction cleanup
that much.
