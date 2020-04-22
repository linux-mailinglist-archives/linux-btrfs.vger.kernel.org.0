Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B11B5089
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 00:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDVWvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 18:51:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:35348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVWvj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 18:51:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51A07ABC7;
        Wed, 22 Apr 2020 22:51:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87993DA704; Thu, 23 Apr 2020 00:50:54 +0200 (CEST)
Date:   Thu, 23 Apr 2020 00:50:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v2] btrfs: Fix block group leak when remove it fails
Message-ID: <20200422225054.GU18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
References: <1587437651-87784-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587437651-87784-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 21, 2020 at 10:54:11AM +0800, Xiyu Yang wrote:
> btrfs_remove_block_group() invokes btrfs_lookup_block_group(), which
> returns a local reference of the blcok group that contains the given
> bytenr to "block_group" with increased refcount.
> 
> When btrfs_remove_block_group() returns, "block_group" becomes invalid,
> so the refcount should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in several exception handling paths
> of btrfs_remove_block_group(). When those error scenarios occur such as
> btrfs_alloc_path() returns NULL, the function forgets to decrease its
> refcnt increased by btrfs_lookup_block_group() and will cause a refcnt
> leak.
> 
> Fix this issue by jumping to "out_put_group" label and calling
> btrfs_put_block_group() when those error scenarios occur.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Added to misc-next, thanks.
