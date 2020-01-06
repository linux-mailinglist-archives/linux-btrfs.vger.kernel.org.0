Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9903A131353
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgAFOG0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 09:06:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:33472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgAFOG0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 09:06:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7DD59AC5C;
        Mon,  6 Jan 2020 14:06:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 302B7DA78B; Mon,  6 Jan 2020 15:06:15 +0100 (CET)
Date:   Mon, 6 Jan 2020 15:06:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Introduce per-profile available space array to
 avoid over-confident can_overcommit()
Message-ID: <20200106140615.GE3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200106061343.18772-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106061343.18772-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 02:13:40PM +0800, Qu Wenruo wrote:
> The execution time of this per-profile calculation is a little below
> 20 us per 5 iterations in my test VM.
> Although all such calculation will need to acquire chunk mutex, the
> impact should be small enough.

The problem is not only the execution time of statfs, but what happens
when them mutex is contended. This was the problem with the block group
mutex in the past that had to be converted to RCU.

If the chunk mutex gets locked because a new chunk is allocated, until
it finishes then statfs will block. The time can vary a lot depending on
the workload and delay in seconds can trigger system monitors alert.
