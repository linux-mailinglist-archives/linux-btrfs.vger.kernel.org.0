Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34129F15C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgJ2Q0m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 12:26:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgJ2Q0m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 12:26:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40792ACB6;
        Thu, 29 Oct 2020 16:26:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE4ECDA7CE; Thu, 29 Oct 2020 17:25:05 +0100 (CET)
Date:   Thu, 29 Oct 2020 17:25:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/10] Sectorsize, csum_size lifted to fs_info
Message-ID: <20201029162505.GM6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1603981452.git.dsterba@suse.com>
 <SN4PR0401MB359889F68E7BF45740CE02CC9B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359889F68E7BF45740CE02CC9B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 29, 2020 at 02:50:07PM +0000, Johannes Thumshirn wrote:
> On 29/10/2020 15:29, David Sterba wrote:
> > Clean up usage of multiplication or division by sectorsize by shifts,
> > checksums per leaf are calculated once and csum_size has a copy in
> > fs_info so we don't have to read it from raw superblocks.
> 
> Currently all checksum sizes are power of 2 as well. Did you check if there
> was any benefit if we'd cache csum_size_bits and shift instead of the 
> multiplications and divisions?

I had not before, quick grep shows way more csum_size operations that
for sectorsize, so that would be a lot of code churn.
