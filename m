Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0390D20779C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404186AbgFXPgT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 11:36:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:41142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403931AbgFXPgS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 11:36:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D7F8B052;
        Wed, 24 Jun 2020 15:36:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67F30DA79B; Wed, 24 Jun 2020 17:36:04 +0200 (CEST)
Date:   Wed, 24 Jun 2020 17:36:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Hans van Kranenburg <hans@knorrie.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Message-ID: <20200624153604.GR27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Hans van Kranenburg <hans@knorrie.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
 <8add89b8-c581-26c3-31df-e5e056449dc2@gmx.com>
 <SN4PR0401MB3598F71C1984D84EA673B42D9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <18267791-0fb1-52be-9538-ad32940bc451@gmx.com>
 <ff3e46ef-b6c7-7dc9-0e95-9daf07ed9760@knorrie.org>
 <SN4PR0401MB3598B67E6E8DDC2AF970A2E69B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <b13f5a8c-cd0c-afd0-dc2c-25ef09907ce8@suse.com>
 <SN4PR0401MB35983CAFFB7912C03A45818B9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35983CAFFB7912C03A45818B9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 24, 2020 at 01:01:08PM +0000, Johannes Thumshirn wrote:
> On 24/06/2020 14:21, Nikolay Borisov wrote:
> > So the answer could go both ways, but this doesn't mean we shouldn't
> > strive to build better/more robust interfaces.
> 
> By changing the reserved16 field to a version, we could have both. I
> just don't think there's much value add here.
>  
> After Hans spoke up, I favor the flags field, as it's more flexible and
> puts less assumptions on user-space. If the flag is set, field X is valid.

Yes that's the idea and version does not make sense to me as it's too
coarse. The whole problem here is that the default zeroing of the unused
members does not help like for other members where zero usually does not
make sense at all (like sectorsize, or the latest addition
clone_alignment). So we need the bit to say 'this value is actually
correct'.
