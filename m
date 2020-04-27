Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E6F1BAFB8
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgD0Urs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 16:47:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:49432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgD0Urs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 16:47:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8457EAC90;
        Mon, 27 Apr 2020 20:47:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2E09EDA781; Mon, 27 Apr 2020 22:47:01 +0200 (CEST)
Date:   Mon, 27 Apr 2020 22:47:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH] btrfs-progs: Remove the duplicated @level parameter for
 btrfs_bin_search()
Message-ID: <20200427204701.GI18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Marek Behun <marek.behun@nic.cz>
References: <20200417071029.66979-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417071029.66979-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 03:10:29PM +0800, Qu Wenruo wrote:
> We can easily get the level from @eb parameter, thus the level is not
> needed.
> 
> This is inspired by the work of Marek in U-boot.
> 
> Cc: Marek Behun <marek.behun@nic.cz>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
