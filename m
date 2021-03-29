Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B3934D702
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhC2SZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 14:25:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhC2SZy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 14:25:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64F3DAFEB;
        Mon, 29 Mar 2021 18:25:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7B99EDA842; Mon, 29 Mar 2021 20:23:45 +0200 (CEST)
Date:   Mon, 29 Mar 2021 20:23:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: use percpu_read_positive instead of sum_positive
 for need_preempt
Message-ID: <20210329182345.GQ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <d500e1b1337e9b36e6dc7ade4e9fad36931c44f4.1616593448.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d500e1b1337e9b36e6dc7ade4e9fad36931c44f4.1616593448.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 24, 2021 at 09:44:21AM -0400, Josef Bacik wrote:
> Looking at perf data for a fio workload I noticed that we were spending
> a pretty large chunk of time (around 5%) doing percpu_counter_sum() in
> need_preemptive_reclaim.  This is silly, as we only want to know if we
> have more ordered than delalloc to see if we should be counting the
> delayed items in our threshold calculation.  Change this to
> percpu_read_positive() to avoid the overhead.
> 
> I ran this through fsperf to validate the changes, obviously the latency
> numbers in dbench and fio are quite jittery, so take them as you wish,
> but overall the improvements on throughput, iops, and bw are all
> positive.  Each test was run two times, the given value is the average
> of both runs for their respective column.
> 
> btrfs ssd normal test results
> 
> bufferedrandwrite16g results
>      metric         baseline   current          diff
> ==========================================================
> write_io_kbytes     16777216   16777216     0.00%
> read_clat_ns_p99           0          0     0.00%
> write_bw_bytes      1.04e+08   1.05e+08     1.12%
> read_iops                  0          0     0.00%
> write_clat_ns_p50      13888      11840   -14.75%
> read_io_kbytes             0          0     0.00%
> read_io_bytes              0          0     0.00%
> write_clat_ns_p99      35008      29312   -16.27%
> read_bw_bytes              0          0     0.00%
> elapsed                  170        167    -1.76%
> write_lat_ns_min     4221.50    3762.50   -10.87%
> sys_cpu                39.65      35.37   -10.79%
> write_lat_ns_max    2.67e+10   2.50e+10    -6.63%
> read_lat_ns_min            0          0     0.00%
> write_iops          25270.10   25553.43     1.12%
> read_lat_ns_max            0          0     0.00%
> read_clat_ns_p50           0          0     0.00%
> 
> dbench60 results
>   metric     baseline   current         diff
> ==================================================
> qpathinfo       11.12     12.73    14.52%
> throughput     416.09    445.66     7.11%
> flush         3485.63   1887.55   -45.85%
> qfileinfo        0.70      1.92   173.86%
> ntcreatex      992.60    695.76   -29.91%
> qfsinfo          2.43      3.71    52.48%
> close            1.67      3.14    88.09%
> sfileinfo       66.54    105.20    58.10%
> rename         809.23    619.59   -23.43%
> find            16.88     15.46    -8.41%
> unlink         820.54    670.86   -18.24%
> writex        3375.20   2637.91   -21.84%
> deltree        386.33    449.98    16.48%
> readx            3.43      3.41    -0.60%
> mkdir            0.05      0.03   -38.46%
> lockx            0.26      0.26    -0.76%
> unlockx          0.81      0.32   -60.33%
> 
> dio4kbs16threads results
>      metric          baseline       current           diff
> ================================================================
> write_io_kbytes         5249676       3357150   -36.05%
> read_clat_ns_p99              0             0     0.00%
> write_bw_bytes      89583501.50   57291192.50   -36.05%
> read_iops                     0             0     0.00%
> write_clat_ns_p50        242688        263680     8.65%
> read_io_kbytes                0             0     0.00%
> read_io_bytes                 0             0     0.00%
> write_clat_ns_p99      15826944      36732928   132.09%
> read_bw_bytes                 0             0     0.00%
> elapsed                      61            61     0.00%
> write_lat_ns_min          42704         42095    -1.43%
> sys_cpu                    5.27          3.45   -34.52%
> write_lat_ns_max       7.43e+08      9.27e+08    24.71%
> read_lat_ns_min               0             0     0.00%
> write_iops             21870.97      13987.11   -36.05%
> read_lat_ns_max               0             0     0.00%
> read_clat_ns_p50              0             0     0.00%
> 
> randwrite2xram results
>      metric          baseline       current           diff
> ================================================================
> write_io_kbytes        24831972      28876262    16.29%
> read_clat_ns_p99              0             0     0.00%
> write_bw_bytes      83745273.50   92182192.50    10.07%
> read_iops                     0             0     0.00%
> write_clat_ns_p50         13952         11648   -16.51%
> read_io_kbytes                0             0     0.00%
> read_io_bytes                 0             0     0.00%
> write_clat_ns_p99         50176         52992     5.61%
> read_bw_bytes                 0             0     0.00%
> elapsed                     314           332     5.73%
> write_lat_ns_min        5920.50          5127   -13.40%
> sys_cpu                    7.82          7.35    -6.07%
> write_lat_ns_max       5.27e+10      3.88e+10   -26.44%
> read_lat_ns_min               0             0     0.00%
> write_iops             20445.62      22505.42    10.07%
> read_lat_ns_max               0             0     0.00%
> read_clat_ns_p50              0             0     0.00%
> 
> untarfirefox results
> metric    baseline   current        diff
> ==============================================
> elapsed      47.41     47.40   -0.03%
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
