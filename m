Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1801E1C71DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgEFNmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 09:42:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:53192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgEFNmY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 09:42:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A05A1AD26;
        Wed,  6 May 2020 13:42:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83DEFDA83A; Wed,  6 May 2020 15:41:34 +0200 (CEST)
Date:   Wed, 6 May 2020 15:41:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: Remove unused inline function
 heads_to_leaves
Message-ID: <20200506134134.GG18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, YueHaibing <yuehaibing@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200506132239.3252-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506132239.3252-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 06, 2020 at 09:22:39PM +0800, YueHaibing wrote:
> There's no callers in-tree anymore since commit 64403612b73a ("btrfs:
> rework btrfs_check_space_for_delayed_refs")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Added to misc-next, thanks.
