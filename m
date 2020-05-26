Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26A21E2758
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 18:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgEZQoe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 12:44:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388061AbgEZQoe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 12:44:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E41B5AC12;
        Tue, 26 May 2020 16:44:35 +0000 (UTC)
Date:   Tue, 26 May 2020 11:44:28 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH 4/7] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200526164428.sirhx6yjsghxpnqt@fiona>
References: <20200522123837.1196-1-rgoldwyn@suse.de>
 <20200522123837.1196-5-rgoldwyn@suse.de>
 <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15:03 26/05, Johannes Thumshirn wrote:
> Just as a heads up, this one gives me lot's of Page cache invalidation
> failure prints from dio_warn_stale_pagecache() on btrfs/004 with 
> current misc-next:
> 
<snip>

> [   23.696400] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   23.698115] File: /mnt/scratch/bgnoise/p0/f0 PID: 6562 Comm: fsstress
> 
> I have no idea yet why but I'm investigating.

This is caused because we are trying to release a page when the extent
has locked the page and release page returns false. To minimize the
effect, I had proposed a patch [1] in v6. However, this created
more extent locking issues and so was dropped.

[1] https://patchwork.kernel.org/patch/11275063/

-- 
Goldwyn
