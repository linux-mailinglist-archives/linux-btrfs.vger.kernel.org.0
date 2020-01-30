Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29814DA7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgA3MPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 07:15:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:41144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgA3MPu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 07:15:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3FCAABF4;
        Thu, 30 Jan 2020 12:15:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66ADCDA84C; Thu, 30 Jan 2020 13:15:30 +0100 (CET)
Date:   Thu, 30 Jan 2020 13:15:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Message-ID: <20200130121530.GO3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
 <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 11:23:24AM +0000, Johannes Thumshirn wrote:
> On 29/01/2020 15:25, David Sterba wrote:
> >> Johannes Thumshirn (5):
> >>    btrfs: remove buffer heads from super block reading
> >>    btrfs: remove use of buffer_heads from superblock writeout
> > 
> > For next iteration, please change the subjects of the two patches to say
> > "replace buffer heads with bio for superblock reading". Thanks.
> 
> 
> Sure but with hch's proposed change to using read_cache_page_gfp() this 
> doesn't make too much sense anymore at least for the read path.
> 
> Maybe "use page cache for superblock reading"?

That works too. We might need a new iteration that summarizes up all the
feedback so far, so we have same code to refer to.
