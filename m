Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE1DC6BEC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfGQPDu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 11:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:33720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfGQPDu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 11:03:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C5C8AF95;
        Wed, 17 Jul 2019 15:03:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 60BA5DA8E1; Wed, 17 Jul 2019 17:04:26 +0200 (CEST)
Date:   Wed, 17 Jul 2019 17:04:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: remove set but not used variable 'offset'
Message-ID: <20190717150426.GI20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, YueHaibing <yuehaibing@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190702141521.48932-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702141521.48932-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 02, 2019 at 10:15:21PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/btrfs/volumes.c: In function __btrfs_map_block:
> fs/btrfs/volumes.c:6023:6: warning:
>  variable offset set but not used [-Wunused-but-set-variable]
> 
> It is not used any more since commit 343abd1c0ca9 ("btrfs: Use
> btrfs_get_io_geometry appropriately")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Added to misc-next, thanks.
