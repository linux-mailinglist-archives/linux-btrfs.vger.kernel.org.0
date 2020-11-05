Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C172E2A7D8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 12:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgKELxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 06:53:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:52830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKELxG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 06:53:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5DC87AB95;
        Thu,  5 Nov 2020 11:53:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CBF71DA6E3; Thu,  5 Nov 2020 12:51:24 +0100 (CET)
Date:   Thu, 5 Nov 2020 12:51:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: ref-verify: Fix memleak in btrfs_ref_tree_mod
Message-ID: <20201105115124.GH6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201021053655.28624-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021053655.28624-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 01:36:55PM +0800, Dinghao Liu wrote:
> There is one error handling path does not free ref,
> which may cause a memory leak.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Added to misc-next, thanks.
