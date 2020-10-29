Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6629EEE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgJ2Ozv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:55:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:45118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgJ2Ozv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:55:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33244AEEB;
        Thu, 29 Oct 2020 14:55:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67CA5DA7CE; Thu, 29 Oct 2020 15:54:12 +0100 (CET)
Date:   Thu, 29 Oct 2020 15:54:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/10] btrfs: scrub: remove local copy of csum_size from
 context
Message-ID: <20201029145412.GL6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1603981452.git.dsterba@suse.com>
 <7a311427bcb433f5ae9f84f4e07d3653e1518b1f.1603981453.git.dsterba@suse.com>
 <SN4PR0401MB359801870FB4E1381BE436DB9B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359801870FB4E1381BE436DB9B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 29, 2020 at 02:45:50PM +0000, Johannes Thumshirn wrote:
> On 29/10/2020 15:29, David Sterba wrote:
> > The context structure unnecessarily stores copy of the checksum size,
> > that can be now easily obtained from fs_info.
> 
> Same question here, I think this can go into 8/10

One logical thing per patch: first is removing function local variables, second
is removing a member from integrity checker state and it's use, and the third
is removing member for scrub context.  They're split for ease of review.
