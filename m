Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728611007F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 16:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKRPO2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 10:14:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:58422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbfKRPO2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 10:14:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE142B17E;
        Mon, 18 Nov 2019 15:14:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02388DA823; Mon, 18 Nov 2019 16:14:26 +0100 (CET)
Date:   Mon, 18 Nov 2019 16:14:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: scrub: Don't check free space before marking a
 block  group RO
Message-ID: <20191118151425.GF3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191115020900.23662-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115020900.23662-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 15, 2019 at 10:09:00AM +0800, Qu Wenruo wrote:
...
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> ---
> This version is based on v5.4-rc1, for a commonly known commit hash.
> It would cause conflicts due to
> btrfs_block_group_cache -> btrfs_block_group refactor.
> 
> The conflicts should be easy to solve.
> 
> Changelog:
> v2:
> - Fix a bug that previous verion never do chunk pre-allocation.
> - Avoid chunk pre-allocation from check_system_chunk()
> - Use extra parameter @do_chunk_alloc other than new function with
>   "_force" suffix.
> - Skip unnecessary update_block_group_flags() call completely for
>   do_chunk_alloc=false case.

Added to misc-next, thanks.
