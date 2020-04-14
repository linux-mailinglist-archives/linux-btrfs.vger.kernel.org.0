Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181761A81A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440258AbgDNPLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 11:11:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440256AbgDNPIV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 11:08:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BDC9CACD0;
        Tue, 14 Apr 2020 15:08:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D736DA823; Tue, 14 Apr 2020 17:07:41 +0200 (CEST)
Date:   Tue, 14 Apr 2020 17:07:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Do proper error handling in
 add_cache_extent()
Message-ID: <20200414150740.GT5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200414020231.50670-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414020231.50670-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 14, 2020 at 10:02:31AM +0800, Qu Wenruo wrote:
> If we have memory allocation failure in add_cache_extent(), it will
> simply exit with one error message.
> 
> That's definitely not proper, especially when all but one call sites
> have handled the error.
> 
> This patch will return -ENOMEM for add_cache_extent(), and fix the only
> call site which doesn't handle error from it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
