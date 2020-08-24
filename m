Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07E2503F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgHXQyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 12:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:35418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbgHXQyh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 12:54:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36D91AD6B;
        Mon, 24 Aug 2020 16:55:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 535B9DA730; Mon, 24 Aug 2020 18:53:28 +0200 (CEST)
Date:   Mon, 24 Aug 2020 18:53:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Document some invariants of seed code
Message-ID: <20200824165328.GO2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200812140436.11749-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812140436.11749-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 12, 2020 at 05:04:36PM +0300, Nikolay Borisov wrote:
> Without good understanding of how seed devices works it's hard to grok
> some of what the code in open_seed_devices or btrfs_prepare_sprout does.
> 
> Add comments hopefully reducing some of the cognitive load.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

I'll add this patch to the seed list api patchset.
