Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1286820E4EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 00:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbgF2Va1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jun 2020 17:30:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:55678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgF2Va0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 17:30:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2ABBFAAC5;
        Mon, 29 Jun 2020 21:30:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 59718DA791; Mon, 29 Jun 2020 23:30:08 +0200 (CEST)
Date:   Mon, 29 Jun 2020 23:30:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200629213008.GO27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200628050715.60961-1-wqu@suse.com>
 <20200628050715.60961-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628050715.60961-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 28, 2020 at 01:07:15PM +0800, Qu Wenruo wrote:
> +QGROUP_ATTR(rfer, reference);

Note that this is 'referenced'.

> +QGROUP_ATTR(excl, exclusive);
> +QGROUP_ATTR(max_rfer, max_reference);

And here max_referenced.

> +QGROUP_ATTR(max_excl, max_exclusive);
> +QGROUP_ATTR(lim_flags, limit_flags);
> +QGROUP_RSV_ATTR(data, BTRFS_QGROUP_RSV_DATA);
> +QGROUP_RSV_ATTR(meta_pertrans, BTRFS_QGROUP_RSV_META_PERTRANS);
> +QGROUP_RSV_ATTR(meta_prealloc, BTRFS_QGROUP_RSV_META_PREALLOC);

The two above fixed but otherwise it's good, thanks.

The qgroup membership and relations could be added to the sysfs export
too, but we're limited by the PAGE_SIZE output buffer so the information
could be incomplete.
