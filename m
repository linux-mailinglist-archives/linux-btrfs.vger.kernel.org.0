Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0B1BA72
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 17:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfEMPzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 11:55:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729416AbfEMPzI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 11:55:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90E7AAE62;
        Mon, 13 May 2019 15:55:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AD76CDA851; Mon, 13 May 2019 17:56:07 +0200 (CEST)
Date:   Mon, 13 May 2019 17:56:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] Btrfs: fix race between send and deduplication that
 lead to failures and crashes
Message-ID: <20190513155607.GD3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190415083018.2224-1-fdmanana@kernel.org>
 <20190422154342.11873-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422154342.11873-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 22, 2019 at 04:43:42PM +0100, fdmanana@kernel.org wrote:
> +		btrfs_warn_rl(root_dst->fs_info,
> +"Can not deduplicate to root %llu while send operations are using it (%d in progress)",
> +			      root_dst->root_key.objectid,
> +			      root_dst->send_in_progress);

The test btrfs/187 stresses this code and the logs are flooded by the
messages, even ratelimited.

[ 7276.358431] btrfs_extent_same: 152 callbacks suppressed
[ 7276.358434] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7276.473264] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7276.476145] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7276.481035] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7276.509456] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7276.531005] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7276.654349] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7276.659043] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7276.664147] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7276.667872] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7281.386168] btrfs_extent_same: 151 callbacks suppressed
[ 7281.386171] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7281.391417] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7281.402340] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7281.424163] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7281.443574] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7281.559380] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7281.565187] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7281.569269] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7281.572955] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7281.603316] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7286.479641] btrfs_extent_same: 155 callbacks suppressed
[ 7286.479644] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7286.493800] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7286.497717] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7286.508728] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7286.541218] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7286.655025] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7286.659737] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7286.673313] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7286.678633] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7286.699049] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7291.485963] btrfs_extent_same: 155 callbacks suppressed
[ 7291.485966] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7291.504093] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7291.508731] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7291.524168] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7291.539922] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7291.656334] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7291.661194] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7291.663548] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7291.677950] BTRFS warning (device vdb): cannot deduplicate to root 263 while send operations are using it (1 in progress)
[ 7291.690344] BTRFS warning (device vdb): cannot deduplicate to root 260 while send operations are using it (2 in progress)
[ 7296.555685] btrfs_extent_same: 160 callbacks suppressed

I wonder if the test is rather artificail (and that's fine for the testing
purposes) or if the number of messages would repeat under normal conditions.

We don't need to print the message each time the dedup tries to acces a
snapshot under send, so keeping track if the message has been sent already
would be less intrusive and still provide the information.
