Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE020257B97
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgHaPCg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 11:02:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:35146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaPCe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 11:02:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA1E6ADDB;
        Mon, 31 Aug 2020 15:02:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 22471DA840; Mon, 31 Aug 2020 17:01:21 +0200 (CEST)
Date:   Mon, 31 Aug 2020 17:01:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] btrfs-progs: convert: Make ASSERT not truncate
 cctx.total_bytes value
Message-ID: <20200831150120.GZ28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200826180820.31695-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826180820.31695-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 03:08:20PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Commit 670a19828ad ("btrfs-progs: convert: prevent 32bit overflow for
> cctx->total_bytes") added an assert to ensure that cctxx.total_bytes did
> not overflow, but this ASSERT calls assert_trace, which expects a long
> value.
> 
> By converting the u64 to long overflows in a 32bit machine, leading the
> assert_trace to be triggered since cctx.total_bytes turns to zero.
> 
> Fix this problem by comparing the cctx.total_bytes with zero when
> calling ASSERT.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to devel, thanks.
