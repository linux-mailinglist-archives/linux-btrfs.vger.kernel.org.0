Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6131E6000
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbgE1MGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 08:06:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388840AbgE1MGN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 08:06:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5BC56AD4B;
        Thu, 28 May 2020 12:06:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6CF9DA72D; Thu, 28 May 2020 14:05:09 +0200 (CEST)
Date:   Thu, 28 May 2020 14:05:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: select FS_IOMAP
Message-ID: <20200528120509.GM18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200528091649.2874627-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528091649.2874627-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 28, 2020 at 11:16:42AM +0200, Arnd Bergmann wrote:
> As btrfs now calls iomap_dio_rw, the helper code actually has
> to be enabled to avoid a link error:
> 
> ERROR: modpost: "iomap_dio_rw" [fs/btrfs/btrfs.ko] undefined!
> 
> Fixes: f31e5f70919f ("btrfs: switch to iomap_dio_rw() for dio")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I've folded the patch in so we don't get build breakage in the
patches between the two.
