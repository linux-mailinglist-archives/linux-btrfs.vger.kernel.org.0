Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32C5F7B53
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 18:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJGQVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJGQVu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 12:21:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B059DD8B0
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 09:21:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECE4C21988;
        Fri,  7 Oct 2022 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665159705;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFcWCDKVPveeds1x+ajoJ1yKRR2LVY/WWXcyLkZWhz8=;
        b=z17PlMMGQmnMDOv3P4OVJTgyx1ISAYQdSWWLU3rfCiqrg7ZD+OLl+5YXImx7h4lNV6wuvj
        8Kdma9Eo6LsF5Gc5/WHeOqpXz/WgRs/Dj4WL4EptSvaITysi/0LiqIx1sTdtN1Ah2HHryL
        i8YIWavDoQcsWcvsyN6SMhNcxQNHF0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665159705;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFcWCDKVPveeds1x+ajoJ1yKRR2LVY/WWXcyLkZWhz8=;
        b=yi8rj4jD2Sft5Zk4ZHFHcQ4FmVSjHjklnqJAbhtYX04ScNkIv64kRDdsEa+lNpJASnMbDZ
        by2CKFbHDYFyWfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAC8513A3D;
        Fri,  7 Oct 2022 16:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IQRxLBlSQGNiQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 16:21:45 +0000
Date:   Fri, 7 Oct 2022 18:21:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/6] Deadlock fix and cleanups
Message-ID: <20221007162142.GR13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664570261.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664570261.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 30, 2022 at 04:45:07PM -0400, Josef Bacik wrote:
> Hello,
> 
> There's a problem with how we do our extent locking, namely that if we encounter
> any contention in the range we're trying to lock we'll leave any area we were
> able to lock locked.  This creates dependency issues when the contended area is
> blocked on some other thing that depends on an operation that would need the
> range lock for the area that was successfully locked.  The exact scenario we
> encountered is described in patch 1.  We need to change this behavior to simply
> wait on the contended area and then attempt to re-lock our entire range,
> clearing anything that was locked before we encountered contention.
> 
> The followup patches are optimizations and cleanups around caching the extent
> state in more places.  Additionally I've added caching of the extent state of
> the contended area to hopefully reduce the pain of needing to unlock and then
> wait on the contended area.
> 
> The first patch needs to be backported to stable because of the extent-io-tree.c
> move.  Once it lands in Linus I'll manually backport the patch and send it back
> to the stable branches.

I want to add the CC: stable tag to the patch so I did the backport to
see how far it applies.

https://github.com/kdave/btrfs-devel/commit/3405ac932abaa81ce2e1cf0f8cc9b311f7a8287d

This is for 5.15+ then the code looks different and maybe the fix is
still aplicable but needs closer look. I'll mark it for 5.15+ and any
ohter backports can be sent separately.

> I've run this through a sanity test on xfstests, and I ran it through 2 tests on
> fsperf that I felt would hammer on the extent locking code the most and be most
> likely to run into lock contention.  I used the new function profiling stuff to
> grab latency numbers for lock_extent(), but of course there's a lot of variance
> here.  The only thing that fell outside of the standard deviation were some of
> the maximum latency numbers, but generally everything was within the standard
> deviation.  Again these are mostly just for information, deadlock fixing comes
> before performance.  Thanks,

Yeah the deadlock fix will to to 6.1, the other patches are simple but
not really fixes so I'll probably leave them for 6.2 unless there's
another reason for 6.1.

> Josef
> 
> bufferedrandwrite16g results
>       metric           baseline       current        stdev            diff
> ================================================================================
> avg_commit_ms            10090.03       8453.23       3505.07   -16.22%
> bg_count                    20.80         20.80          0.45     0.00%
> commits                      6.20             6          1.10    -3.23%
> elapsed                    140.60        139.60         18.06    -0.71%
> end_state_mount_ns    42066858.80   45104291.80    6317588.83     7.22%
> end_state_umount_ns      6.26e+09      6.23e+09      1.76e+08    -0.39%
> lock_extent_calls     10795318.60   10713477.60     233933.51    -0.76%
> lock_extent_ns_max     3945976.80       7027641    1676910.27    78.10%
> lock_extent_ns_mean       2258.36       2187.89        212.76    -3.12%
> lock_extent_ns_min         503.60        500.80          7.44    -0.56%
> lock_extent_ns_p50        1964.80       1953.60        190.31    -0.57%
> lock_extent_ns_p95        4257.40       4153.20        409.06    -2.45%
> lock_extent_ns_p99        6967.20       6429.20       1166.93    -7.72%
> max_commit_ms            24686.20         25927       5930.26     5.03%
> sys_cpu                     46.68         45.52          6.83    -2.48%
> write_bw_bytes           1.25e+08      1.24e+08   15352552.51    -0.61%
> write_clat_ns_mean       23568.91      21840.81       4061.83    -7.33%
> write_clat_ns_p50        13734.40      13683.20       1268.43    -0.37%
> write_clat_ns_p99           33152      30873.60       4236.59    -6.87%
> write_io_kbytes          16777216      16777216             0     0.00%
> write_iops               30413.83      30228.55       3748.18    -0.61%
> write_lat_ns_max         1.72e+10      1.77e+10      9.25e+09     2.64%
> write_lat_ns_mean        23645.69      21934.65       4057.93    -7.24%
> write_lat_ns_min          6049.40       5877.60         80.29    -2.84%
> 
> randwrite2xram results
>       metric           baseline       current        stdev            diff
> ================================================================================
> avg_commit_ms            21196.15      32607.37       2286.20    53.84%
> bg_count                    43.80         39.80          6.46    -9.13%
> commits                     11.20          9.80          1.10   -12.50%
> elapsed                    329.20           350          4.97     6.32%
> end_state_mount_ns    61846504.40   57392390.60    7914609.45    -7.20%
> end_state_umount_ns      1.74e+10      1.80e+10      2.35e+09     3.44%
> lock_extent_calls     26193512.60      24046630    4169768.34    -8.20%
> lock_extent_ns_max    23699711.60   17524496.80   13253697.58   -26.06%
> lock_extent_ns_mean       1871.04       1866.95         26.60    -0.22%
> lock_extent_ns_min         495.60           501          5.41     1.09%
> lock_extent_ns_p50        1681.80       1675.40         22.13    -0.38%
> lock_extent_ns_p95        3487.60          3492         45.35     0.13%
> lock_extent_ns_p99        4416.60       4431.80         44.77     0.34%
> max_commit_ms               53482     116910.40       8707.34   118.60%
> sys_cpu                      9.88          8.32          1.75   -15.85%
> write_bw_bytes           1.05e+08   89841897.40   20713472.34   -14.84%
> write_clat_ns_mean      158731.16     234418.93      30030.49    47.68%
> write_clat_ns_p50        14732.80      14873.60        448.91     0.96%
> write_clat_ns_p99        75622.40      82892.80      12865.88     9.61%
> write_io_kbytes       31930975.20   28774377.60    5985362.29    -9.89%
> write_iops               25756.55      21934.06       5057.00   -14.84%
> write_lat_ns_max         3.49e+10      5.87e+10      6.68e+09    68.41%
> write_lat_ns_mean       158828.62     234533.46      30028.84    47.66%
> write_lat_ns_min             7809       7923.40        371.87     1.46%
> 
> Josef Bacik (6):
>   btrfs: unlock locked extent area if we have contention
>   btrfs: add a cached_state to try_lock_extent
>   btrfs: use cached_state for btrfs_check_nocow_lock
>   btrfs: use a cached_state everywhere in relocation
>   btrfs: cache the failed state when locking extents
>   btrfs: add cached_state to read_extent_buffer_subpage

Added to misc-next, thanks.
