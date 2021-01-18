Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564252FADA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 00:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403895AbhARXEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 18:04:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:44312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403847AbhARXEU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 18:04:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78754AA6F;
        Mon, 18 Jan 2021 23:03:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 29398DA7CF; Tue, 19 Jan 2021 00:01:43 +0100 (CET)
Date:   Tue, 19 Jan 2021 00:01:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4 03/18] btrfs: introduce the skeleton of btrfs_subpage
 structure
Message-ID: <20210118230143.GM6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116071533.105780-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 03:15:18PM +0800, Qu Wenruo wrote:
> For btrfs subpage support, we need a structure to record extra info for
> the status of each sectors of a page.
> 
> This patch will introduce the skeleton structure for future btrfs
> subpage support.
> All subpage related code would go to subpage.[ch] to avoid populating
> the existing code base.

Ok, and after reading more of the patchset it makes even more sense,
handling all the special cases is suitable for a separate file.
