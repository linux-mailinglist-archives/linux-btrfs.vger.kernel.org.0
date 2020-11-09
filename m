Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E243F2AC3CB
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 19:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKIS1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 13:27:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:34766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgKIS1X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 13:27:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FBC4AC24;
        Mon,  9 Nov 2020 18:27:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9B8BDA7D7; Mon,  9 Nov 2020 19:25:41 +0100 (CET)
Date:   Mon, 9 Nov 2020 19:25:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 29/32] btrfs: scrub: introduce scrub_page::page_len for
 subpage support
Message-ID: <20201109182541.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-30-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103133108.148112-30-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 09:31:05PM +0800, Qu Wenruo wrote:
> Currently scrub_page only has one csum for each page, this is fine if
> page size == sector size, then each page has one csum for it.
> 
> But for subpage support, we could have cases where only part of the page
> is utilized. E.g one 4K sector is read into a 64K page.
> In that case, we need a way to determine which range is really utilized.
> 
> This patch will introduce scrub_page::page_len so that we can know
> where the utilized range ends.

Actually, this should be sectorsize or nodesize? Ie. is it necessary to
track the length inside scrub_page at all? It might make sense for
convenience though.
