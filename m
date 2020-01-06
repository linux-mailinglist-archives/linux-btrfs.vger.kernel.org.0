Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B713160E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 17:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFQaN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 11:30:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:51022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFQaN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 11:30:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7BC73ABE9;
        Mon,  6 Jan 2020 16:30:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE0C5DA78B; Mon,  6 Jan 2020 17:30:01 +0100 (CET)
Date:   Mon, 6 Jan 2020 17:30:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: async discard follow up
Message-ID: <20200106163001.GM3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1577999991.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is it expected to leave the counters in a state where are discardable
extents but not process after a long period of time? I found

discard_bitmap_bytes:316833792
discard_bytes_saved:59390722048
discard_extent_bytes:26122764288
discardable_bytes:44863488
discardable_extents:883
iops_limit:10
kbps_limit:0
max_discard_size:67108864

there was activity when the number of extents wen from about 2000 to
that value (833), so this could bea nother instance of the -1 accounting
bug.
