Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27FB1CDA41
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgEKMlW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 08:41:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:55018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbgEKMlW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 08:41:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75F54AC22;
        Mon, 11 May 2020 12:41:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1993EDA823; Mon, 11 May 2020 14:40:30 +0200 (CEST)
Date:   Mon, 11 May 2020 14:40:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: Remove unused inline function
 btrfs_dev_extent_chunk_tree_uuid
Message-ID: <20200511124029.GO18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, YueHaibing <yuehaibing@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200509112243.54176-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509112243.54176-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 09, 2020 at 07:22:43PM +0800, YueHaibing wrote:
> There's no callers in-tree anymore since
> commit d24ee97b96db ("btrfs: use new helpers to set uuids in eb")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Added to misc-next, thanks.
