Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9334B21D84C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 16:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgGMOWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 10:22:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbgGMOWf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 10:22:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14971AD04;
        Mon, 13 Jul 2020 14:22:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 962B8DA809; Mon, 13 Jul 2020 16:22:12 +0200 (CEST)
Date:   Mon, 13 Jul 2020 16:22:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] btrfs: qgroup: Fix the long existing regression
 of btrfs/153
Message-ID: <20200713142212.GI3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200713105049.90663-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713105049.90663-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 06:50:46PM +0800, Qu Wenruo wrote:
> v4:
> - Use rbtree_iterate_from_safe() wrapper to replace the while() loop
> - Use proper variable names to replace single letter variable names
> - Use proper btrfs_root bit with wait_queue_head to replace mutex

Thanks, as there were only syntactic changes and I've tested the bit +
wait before, I'm adding the branch to misc-next.
