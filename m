Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E93800BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 01:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhEMXPK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 19:15:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:54696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhEMXPK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 19:15:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6307FAEAA;
        Thu, 13 May 2021 23:13:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D5350DA8EB; Fri, 14 May 2021 01:11:28 +0200 (CEST)
Date:   Fri, 14 May 2021 01:11:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 09/42] btrfs: refactor how we finish ordered extent io
 for endio functions
Message-ID: <20210513231128.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-10-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230349.369603-10-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 07:03:16AM +0800, Qu Wenruo wrote:
> +		if (entry->bytes_left == 0) {
> +			set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
> +			/* set_bit implies a barrier */
> +			cond_wake_up_nomb(&entry->wait);

Well, no, set_bit does not imply a barrier. In general, RMW operations
do, and set_bit lacks the 'R' part. It's also in the memory-barriers.txt
document, look up set_bit. I inserted a patch that does
cond_wake_up that does the barrier, calling smp_mb_after_atomic +
cond_wake_up_nomb would also work.
