Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E246D273390
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 22:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgIUU0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 16:26:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgIUU0T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 16:26:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40938ACD8;
        Mon, 21 Sep 2020 20:26:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1D3CDA6E0; Mon, 21 Sep 2020 22:25:02 +0200 (CEST)
Date:   Mon, 21 Sep 2020 22:25:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anandsuveer@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: init device stats for seed devices
Message-ID: <20200921202502.GT6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anandsuveer@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600461724.git.josef@toxicpanda.com>
 <b0c2be2e6722f091821521301f251628afcd8313.1600461724.git.josef@toxicpanda.com>
 <8217721c-0bd9-67af-1900-9594689c127b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8217721c-0bd9-67af-1900-9594689c127b@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 19, 2020 at 05:47:18AM +0800, Anand Jain wrote:
> 
> Seed read errors should remain persistent.

How? The seed device is read-only, we can't record the stats and
recording them on the sprout device has unclear meaning.

> A similar update to btrfs_run_dev_stats() is required?
