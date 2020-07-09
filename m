Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1421A4FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGIQio (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 12:38:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgGIQio (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 12:38:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32976AE0A;
        Thu,  9 Jul 2020 16:38:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0CD4DAB7F; Thu,  9 Jul 2020 18:38:23 +0200 (CEST)
Date:   Thu, 9 Jul 2020 18:38:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 3/3] btrfs: qgroup: remove the ASYNC_COMMIT mechanism
 in favor of qgroup  reserve retry-after-EDQUOT
Message-ID: <20200709163823.GC15161@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200708062447.81341-1-wqu@suse.com>
 <20200708062447.81341-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708062447.81341-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 08, 2020 at 02:24:47PM +0800, Qu Wenruo wrote:
> commit a514d63882c3 ("btrfs: qgroup: Commit transaction in advance to
> reduce early EDQUOT") tries to reduce the early EDQUOT problems by
> checking the qgroup free against threshold and try to wake up commit
> kthread to free some space.
> 
> The problem of that mechanism is, it can only free qgroup per-trans
> metadata space, can't do anything to data, nor prealloc qgroup space.
> 
> Now since we have the ability to flush qgroup space, and implements
> retry-after-EDQUOT behavior, such mechanism is completely replaced.
> 
> So this patch will cleanup such mechanism in favor of
> retry-after-EDQUOT.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

That one looks good to me.
