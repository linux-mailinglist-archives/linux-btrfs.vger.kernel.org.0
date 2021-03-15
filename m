Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5341733C039
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 16:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCOPoe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 11:44:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:35356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhCOPoH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 11:44:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DC0DAC17;
        Mon, 15 Mar 2021 15:44:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4B20CDA6E2; Mon, 15 Mar 2021 16:42:05 +0100 (CET)
Date:   Mon, 15 Mar 2021 16:42:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fixes for subpage which also affect read-only
 mount
Message-ID: <20210315154205.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210315053915.62420-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315053915.62420-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 15, 2021 at 01:39:13PM +0800, Qu Wenruo wrote:
> During the fstests run for btrfs subpage read-write support, generic/475
> crashes the system with a very high chance.
> 
> It turns out the cause is also affecting btrfs subpage read-only mount
> so it's worthy a quick fix.
> 
> Also the crash call site shows a new rabbit hole of hard coded
> PAGE_SHIFT in readahead.

There's still a lot of PAGE_SHIFT use, not all of them are wrong but I
think we'll need to do an audit and categorize the valid uses, otherwise
it'll be a whack-a-mole.
