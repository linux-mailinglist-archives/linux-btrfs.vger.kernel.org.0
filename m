Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42317229A0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgGVO0e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 10:26:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:43842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgGVO0e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 10:26:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E761AD20;
        Wed, 22 Jul 2020 14:26:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC962DA70B; Wed, 22 Jul 2020 16:26:07 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:26:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Convert seed devices to proper list API
Message-ID: <20200722142607.GX3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715104850.19071-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 15, 2020 at 01:48:45PM +0300, Nikolay Borisov wrote:
> This series converts the existing seed devices pointer in btrfs_fs_devices to
> proper list api. First 4 patches are cleanups preparing the code for the switch.

> Patch 5 has more information about the required transformations, it might seem
> lengthy but he logic everywhere is pretty much the same so shouldn't be that
> cumbersome to review.

The first 3 patches are clear, I start to have doubts in 4 and 5 was a
stop for me, but I'm not saying it's wrong. Just that I always thought
the seed devices + the sprout are close to a tree structure but you're
switching that to a linear list.

I'll add the first three patches now, but would appreciate some help
with 4 and 5.
