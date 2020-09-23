Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980F42754AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 11:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIWJoZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 05:44:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIWJoZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 05:44:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35707AFCF;
        Wed, 23 Sep 2020 09:45:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34442DA6E3; Wed, 23 Sep 2020 11:43:08 +0200 (CEST)
Date:   Wed, 23 Sep 2020 11:43:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
Message-ID: <20200923094308.GK6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Martin Steigerwald <martin@lichtvoll.de>
References: <20200922023701.32654-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922023701.32654-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 22, 2020 at 10:37:01AM +0800, Qu Wenruo wrote:
> Commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
> introduced btrfs root item size check, however btrfs root item has two
> format, the legacy one which just ends before generation_v2 member, is
> smaller than current btrfs root item size.
> 
> This caused btrfs kernel to reject valid but old tree root leaves.
> 
> Fix this problem by also allowing legacy root item, since kernel can
> already handle them pretty well and upgrade to newer root item format
> when needed.
> 
> Reported-by: Martin Steigerwald <martin@lichtvoll.de>
> Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
