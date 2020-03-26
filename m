Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7A194589
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgCZRhM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 13:37:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgCZRhM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 13:37:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 275FAAEE6;
        Thu, 26 Mar 2020 17:37:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5A92DA730; Thu, 26 Mar 2020 18:36:39 +0100 (CET)
Date:   Thu, 26 Mar 2020 18:36:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-progs: RAID1C3/C4 missing some info in btrfs_raid_array
Message-ID: <20200326173638.GL5920@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <2f5db5cd-001f-449d-d370-697f3494ed34@libero.it>
 <cf046899-7a7b-a93b-2340-c996cbfbc6ac@gmx.com>
 <b8b874d0-a60e-2a4c-f3eb-e54539bddc8d@inwind.it>
 <eaab47b8-4026-f5f2-5e4a-723c990cfbca@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaab47b8-4026-f5f2-5e4a-723c990cfbca@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 09:09:41AM +0800, Qu Wenruo wrote:
> On 2020/3/26 上午2:57, Goffredo Baroncelli wrote:
> >     [BTRFS_RAID_RAID1C4] = {
> >         .sub_stripes    = 1,
> >         .dev_stripes    = 1,
> >         .devs_max    = 4,
> >         .devs_min    = 4,
> >         .tolerated_failures = 3,
> >         .devs_increment    = 4,
> >         .ncopies    = 4,
> >     },
> >     [BTRFS_RAID_DUP] = {
> > [...]
> > 
> > As you can see the items BTRFS_RAID_RAID1C3 and BTRFS_RAID_RAID1C4,
> > missed of the fields '.raid_name' and '.bg_flag';
> > if you look at BTRFS_RAID_RAID1 item, it has both the fields filled with
> > "raid1" and "BTRFS_BLOCK_GROUP_RAID1".
> 
> Oh, you're right.
> 
> AFAIK there is no special reason not to add these members.

Right, I forgot to add them back then.
