Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6FF36FE0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhD3Pue (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 11:50:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:52738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230451AbhD3Puc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 11:50:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1AB1EB237;
        Fri, 30 Apr 2021 15:49:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 58385DA818; Fri, 30 Apr 2021 17:47:19 +0200 (CEST)
Date:   Fri, 30 Apr 2021 17:47:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/7] Preemptive flushing improvements
Message-ID: <20210430154719.GF7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1619631053.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1619631053.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 01:38:41PM -0400, Josef Bacik wrote:
> The following patch series is a set of improvements around our preemptive
> flushing infrastructure.  A user reported[1] a problem where the preemptive
> flushing was running non-stop on his full file system.  I was not able to
> reproduce this behavior, but noticed a few fundamental issues with how we
> decided to do preemptive flushing.  The main relevant thing is that we were not
> taking into account the global reserve when deciding if we needed to
> preemptively flush.  In cases such as the users file system where the majority
> of the free metadata space is taken up by the global reserve we could
> potentially always want to flush, which is annoying and not what we want.
> 
> Furthermore I noticed issues where we would clamp entirely too quickly, and
> where we made some poor decisions around delalloc.  None of these are ground
> breaking or huge improvements, but offer some better performance in some of the
> fsperf test cases.  This is the results of my recent run with the whole
> patchset.  You'll notice a "regression" in the 16g buffered write, this is
> mostly because of the test, if you look at the results on the nightly
> performance tests you'll see this test varies more than others.  Re-testing with
> just that test didn't show the same regression after multiple runs, so it's just
> noise.  I could have chosen to run all the tests multiple times to get an
> average over several runs, but that takes a fair bit of time.  Individual runs
> of the test showed no regression and often showed an improvement, so I feel
> comfortable calling it noise.  The full results are as follows
> 
> dbench60 results
>   metric     baseline   current         diff
> ==================================================
> qpathinfo       11.53     13.25    14.90%
> throughput     446.23    434.52    -2.62%
> flush         2502.92   1682.43   -32.78%
> qfileinfo        0.92      1.17    27.29%
> ntcreatex     1359.76    519.42   -61.80%
> qfsinfo          1.77      3.76   112.64%
> close            1.90      1.64   -13.91%å
> sfileinfo      209.76     76.43   -63.56%
> rename        1110.08    518.40   -53.30%
> find            13.84     13.13    -5.15%
> unlink        1192.89    521.53   -56.28%
> writex        1713.39   1321.39   -22.88%
> deltree        280.34    296.33     5.70%
> readx            3.16      2.91    -8.10%
> mkdir            0.03      0.02   -46.67%
> lockx            0.78      0.20   -73.89%
> unlockx          0.16      0.12   -23.81%
> 
> emptyfiles500k results
>      metric         baseline   current         diff
> =========================================================
> write_io_kbytes       125000     125000    0.00%
> read_clat_ns_p99           0          0    0.00%
> write_bw_bytes      1.79e+08   1.85e+08    3.04%
> read_iops                  0          0    0.00%
> write_clat_ns_p50      17728      17280   -2.53%
> read_io_kbytes             0          0    0.00%
> read_io_bytes              0          0    0.00%
> write_clat_ns_p99      72704      68096   -6.34%
> read_bw_bytes              0          0    0.00%
> elapsed                    1          1    0.00%
> write_lat_ns_min           0          0    0.00%
> sys_cpu                91.23      89.16   -2.27%
> write_lat_ns_max           0          0    0.00%
> read_lat_ns_min            0          0    0.00%
> write_iops          43763.97   45093.80    3.04%
> read_lat_ns_max            0          0    0.00%
> read_clat_ns_p50           0          0    0.00%
> 
> smallfiles100k results
>      metric         baseline   current         diff
> =========================================================
> write_io_kbytes     2.04e+08   2.04e+08    0.00%
> read_clat_ns_p99           0          0    0.00%
> write_bw_bytes      1.40e+08   1.40e+08    0.50%
> read_iops                  0          0    0.00%
> write_clat_ns_p50       6712       6944    3.46%
> read_io_kbytes             0          0    0.00%
> read_io_bytes              0          0    0.00%
> write_clat_ns_p99      16000      16512    3.20%
> read_bw_bytes              0          0    0.00%
> elapsed              1498.88       1491   -0.53%
> write_lat_ns_min     2858.38       2919    2.12%
> sys_cpu                 6.22       6.51    4.61%
> write_lat_ns_max    1.31e+08   1.27e+08   -2.77%
> read_lat_ns_min            0          0    0.00%
> write_iops          34081.44   34253.51    0.50%
> read_lat_ns_max            0          0    0.00%
> read_clat_ns_p50           0          0    0.00%
> 
> dio4kbs16threads results
>      metric          baseline     current          diff
> =============================================================
> write_io_kbytes         4360879    5312908    21.83%
> read_clat_ns_p99              0          0     0.00%
> write_bw_bytes      74302497.38   90667585    22.02%
> read_iops                     0          0     0.00%
> write_clat_ns_p50        243968     238592    -2.20%
> read_io_kbytes                0          0     0.00%
> read_io_bytes                 0          0     0.00%
> write_clat_ns_p99      21094400   15007744   -28.85%
> read_bw_bytes                 0          0     0.00%
> elapsed                      61         61     0.00%
> write_lat_ns_min       38183.25      37949    -0.61%
> sys_cpu                    4.03       4.72    17.11%
> write_lat_ns_max       1.68e+09   8.46e+08   -49.55%
> read_lat_ns_min               0          0     0.00%
> write_iops             18140.26   22135.64    22.02%
> read_lat_ns_max               0          0     0.00%
> read_clat_ns_p50              0          0     0.00%
> 
> randwrite2xram results
>      metric          baseline     current          diff
> =============================================================
> write_io_kbytes        27720434   36563300    31.90%
> read_clat_ns_p99              0          0     0.00%
> write_bw_bytes      93268100.75   1.16e+08    24.83%
> read_iops                     0          0     0.00%
> write_clat_ns_p50         13168      16512    25.39%
> read_io_kbytes                0          0     0.00%
> read_io_bytes                 0          0     0.00%
> write_clat_ns_p99         39360     125440   218.70%
> read_bw_bytes                 0          0     0.00%
> elapsed                  334.25        333    -0.37%
> write_lat_ns_min        5436.75       5682     4.51%
> sys_cpu                    8.22      12.57    52.96%
> write_lat_ns_max       4.05e+10   2.73e+10   -32.65%
> read_lat_ns_min               0          0     0.00%
> write_iops             22770.53   28425.17    24.83%
> read_lat_ns_max               0          0     0.00%
> read_clat_ns_p50              0          0     0.00%
> 
> untarfirefox results
> metric    baseline   current        diff
> ==============================================
> elapsed      47.23     46.82   -0.87%
> 
> I'm still waiting on feedback from the user to make sure the patches fix the
> reported problem, but they're worthy on their own if they do not resolve the
> original reported issue.  Thanks,
> 
> Josef
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=212185
> 
> Josef Bacik (7):
>   btrfs: check worker before need_preemptive_reclaim
>   btrfs: only clamp the first time we have to start flushing
>   btrfs: take into account global rsv in need_preemptive_reclaim
>   btrfs: use the global rsv size in the preemptive thresh calculation
>   btrfs: don't include the global rsv size in the preemptive used amount
>   btrfs: only ignore delalloc if delalloc is much smaller than ordered
>   btrfs: handle preemptive delalloc flushing slightly differently

It would be good to summarize the noticeable improvements over all the
tests and put it at least into the last patch assuming that's where it
was produced.

The tests passed for me here so I'll add the patches to misc-next for
more coverage.
