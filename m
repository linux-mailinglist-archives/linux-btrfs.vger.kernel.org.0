Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667892261BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 16:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgGTOQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 10:16:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:38402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgGTOQP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 10:16:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C9F9B6D1;
        Mon, 20 Jul 2020 14:16:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1BFA0DA7CF; Mon, 20 Jul 2020 16:15:49 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:15:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reduce contention on log trees when logging
 checksums
Message-ID: <20200720141548.GE3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200715113043.3192206-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715113043.3192206-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 15, 2020 at 12:30:43PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>     **** 16 jobs, file size 1G, fsync frequency 1 ****
> (+40.1% throughput, -28.5% runtime)

>     **** 32 jobs, file size 1G, fsync frequency 1 ****
> (+29.4% throughput, -22.7% runtime)

>     **** 64 jobs, file size 512M, fsync frequency 1 ****
> (+29.3% throughput, -22.7% runtime)

>     **** 128 jobs, file size 256M, fsync frequency 1 ****
> (+121.2% throughput, -54.6% runtime)

>     **** 256 jobs, file size 256M, fsync frequency 1 ****
> (+74.9% throughput, -42.8% runtime)

>     **** 512 jobs, file size 128M, fsync frequency 1 ****
> (+65.1% throughput, -39.3% runtime)

>     **** 1024 jobs, file size 128M, fsync frequency 1 ****
> (+48.7% throughput, -33.1% runtime)
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Some nice numbers to mention in the merge log, thanks.
