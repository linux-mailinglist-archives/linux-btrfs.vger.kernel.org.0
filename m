Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0261CE2FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgEKSr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 14:47:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbgEKSr5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 14:47:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F4114ACC5;
        Mon, 11 May 2020 18:47:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69C11DA82A; Mon, 11 May 2020 20:47:02 +0200 (CEST)
Date:   Mon, 11 May 2020 20:46:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: Don't do early exit if
 maybe_repair_root_item() can't find needed root extent
Message-ID: <20200511184658.GU18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200429101015.78658-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429101015.78658-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 29, 2020 at 06:10:15PM +0800, Qu Wenruo wrote:
> The whole maybe_repair_root_item() and repair_root_items() functions are
> introduced to handle an ancient bug in v3.17.
> 
> However in certain extent tree corruption case, such early exit would
> only exit the whole check process early on, preventing user to know
> what's really wrong about the fs.
> 
> So this patch will allow the check to continue, since the ancient bug is
> no long that common.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
