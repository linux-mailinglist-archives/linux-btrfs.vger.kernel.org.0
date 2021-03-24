Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD313479D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Mar 2021 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhCXNol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Mar 2021 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbhCXNoZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Mar 2021 09:44:25 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7050C061763
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Mar 2021 06:44:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s2so17532089qtx.10
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Mar 2021 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ZjwwMOBrIHq5S4DkYKcB8i97cxKen44qLQ7L7XKZCQ=;
        b=r6ioVOEXSf0Jmp+uMQK1EhMcW4dccG1p6raDXMTFW6KBl+SVP8DubtK9jFdCObJMnQ
         5m+TaJE7KCXxr+ahmmVpVPJFRFmDQwJqRTb/AhPsVj3TBi7nMhPf90X0CRmtxkixgMfz
         Kjj7y7y9vJX7X9EwVIRsBk6te3YIDnGzBgDHbWVyTCDbYMp4/Z/7HvSDthH1LHzgKvpi
         x4BzNu7OVvLQ1aFhIqaVW7rw8PeUJedFFD+RUtB5HuTfq8XIPGx8B2piIEVXW1OPvAx6
         wwU/yN505ZlFUVB/8IBtoAQm4SIr6CQnrk9LVpkl1+CFngLff9sVAiOLk25QrYYKnYSH
         TIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ZjwwMOBrIHq5S4DkYKcB8i97cxKen44qLQ7L7XKZCQ=;
        b=iqqoB4y7LXqRgVNVV+4ubGDLx25oz6Ds+fIOS0BuuRxK3/7vIedaqSuMwt+y9KTnmV
         uYyB0S+evi4nyOlA8ZCGOneiTvoEpuXxEl+jnMEqDH/w2OLf+ahNNTQQoFp5amGuVzEB
         uE8UmYAARotbv+zY/LTQtsG8E9L5vxlS0WCVQpTASPImGGCoEZ78P8klItUrXykD3RTB
         UICZm9P6A5t/xqbLBjnEkI2wV38nvR/Y+Vdv0e+ypjLLjFtOP2MKF7vMm2WVnKJYOxhf
         Dt1je24eg2xS0bVwOMLxE6NQnkCUkZziHxB9KB2oAK8Bh0hkg5HMU3GwAZYhWXmU1gEW
         84Zw==
X-Gm-Message-State: AOAM532n7qvyheMgm2Dj602s0L0ionpe66hNTVsN34p/PhJ1VxNXzNFI
        dNM83thc3jQpTAn9/00qBSxpw0ulDPp1AW7/
X-Google-Smtp-Source: ABdhPJwmrsqnykAHVr28fgDczXnjbtmxl55L/Fb2IHusTRO0aMtaapRNman/4D4vKRcwteitoWDydA==
X-Received: by 2002:aed:2c22:: with SMTP id f31mr2894869qtd.219.1616593463356;
        Wed, 24 Mar 2021 06:44:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s6sm1714059qke.44.2021.03.24.06.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:44:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: use percpu_read_positive instead of sum_positive for need_preempt
Date:   Wed, 24 Mar 2021 09:44:21 -0400
Message-Id: <d500e1b1337e9b36e6dc7ade4e9fad36931c44f4.1616593448.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looking at perf data for a fio workload I noticed that we were spending
a pretty large chunk of time (around 5%) doing percpu_counter_sum() in
need_preemptive_reclaim.  This is silly, as we only want to know if we
have more ordered than delalloc to see if we should be counting the
delayed items in our threshold calculation.  Change this to
percpu_read_positive() to avoid the overhead.

I ran this through fsperf to validate the changes, obviously the latency
numbers in dbench and fio are quite jittery, so take them as you wish,
but overall the improvements on throughput, iops, and bw are all
positive.  Each test was run two times, the given value is the average
of both runs for their respective column.

btrfs ssd normal test results

bufferedrandwrite16g results
     metric         baseline   current          diff
==========================================================
write_io_kbytes     16777216   16777216     0.00%
read_clat_ns_p99           0          0     0.00%
write_bw_bytes      1.04e+08   1.05e+08     1.12%
read_iops                  0          0     0.00%
write_clat_ns_p50      13888      11840   -14.75%
read_io_kbytes             0          0     0.00%
read_io_bytes              0          0     0.00%
write_clat_ns_p99      35008      29312   -16.27%
read_bw_bytes              0          0     0.00%
elapsed                  170        167    -1.76%
write_lat_ns_min     4221.50    3762.50   -10.87%
sys_cpu                39.65      35.37   -10.79%
write_lat_ns_max    2.67e+10   2.50e+10    -6.63%
read_lat_ns_min            0          0     0.00%
write_iops          25270.10   25553.43     1.12%
read_lat_ns_max            0          0     0.00%
read_clat_ns_p50           0          0     0.00%

dbench60 results
  metric     baseline   current         diff
==================================================
qpathinfo       11.12     12.73    14.52%
throughput     416.09    445.66     7.11%
flush         3485.63   1887.55   -45.85%
qfileinfo        0.70      1.92   173.86%
ntcreatex      992.60    695.76   -29.91%
qfsinfo          2.43      3.71    52.48%
close            1.67      3.14    88.09%
sfileinfo       66.54    105.20    58.10%
rename         809.23    619.59   -23.43%
find            16.88     15.46    -8.41%
unlink         820.54    670.86   -18.24%
writex        3375.20   2637.91   -21.84%
deltree        386.33    449.98    16.48%
readx            3.43      3.41    -0.60%
mkdir            0.05      0.03   -38.46%
lockx            0.26      0.26    -0.76%
unlockx          0.81      0.32   -60.33%

dio4kbs16threads results
     metric          baseline       current           diff
================================================================
write_io_kbytes         5249676       3357150   -36.05%
read_clat_ns_p99              0             0     0.00%
write_bw_bytes      89583501.50   57291192.50   -36.05%
read_iops                     0             0     0.00%
write_clat_ns_p50        242688        263680     8.65%
read_io_kbytes                0             0     0.00%
read_io_bytes                 0             0     0.00%
write_clat_ns_p99      15826944      36732928   132.09%
read_bw_bytes                 0             0     0.00%
elapsed                      61            61     0.00%
write_lat_ns_min          42704         42095    -1.43%
sys_cpu                    5.27          3.45   -34.52%
write_lat_ns_max       7.43e+08      9.27e+08    24.71%
read_lat_ns_min               0             0     0.00%
write_iops             21870.97      13987.11   -36.05%
read_lat_ns_max               0             0     0.00%
read_clat_ns_p50              0             0     0.00%

randwrite2xram results
     metric          baseline       current           diff
================================================================
write_io_kbytes        24831972      28876262    16.29%
read_clat_ns_p99              0             0     0.00%
write_bw_bytes      83745273.50   92182192.50    10.07%
read_iops                     0             0     0.00%
write_clat_ns_p50         13952         11648   -16.51%
read_io_kbytes                0             0     0.00%
read_io_bytes                 0             0     0.00%
write_clat_ns_p99         50176         52992     5.61%
read_bw_bytes                 0             0     0.00%
elapsed                     314           332     5.73%
write_lat_ns_min        5920.50          5127   -13.40%
sys_cpu                    7.82          7.35    -6.07%
write_lat_ns_max       5.27e+10      3.88e+10   -26.44%
read_lat_ns_min               0             0     0.00%
write_iops             20445.62      22505.42    10.07%
read_lat_ns_max               0             0     0.00%
read_clat_ns_p50              0             0     0.00%

untarfirefox results
metric    baseline   current        diff
==============================================
elapsed      47.41     47.40   -0.03%

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2da6177f4b0b..2dc674b7c3b1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -861,8 +861,8 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	 * of heavy DIO or ordered reservations, preemptive flushing will just
 	 * waste time and cause us to slow down.
 	 */
-	ordered = percpu_counter_sum_positive(&fs_info->ordered_bytes);
-	delalloc = percpu_counter_sum_positive(&fs_info->delalloc_bytes);
+	ordered = percpu_counter_read_positive(&fs_info->ordered_bytes);
+	delalloc = percpu_counter_read_positive(&fs_info->delalloc_bytes);
 	if (ordered >= delalloc)
 		used += fs_info->delayed_refs_rsv.reserved +
 			fs_info->delayed_block_rsv.reserved;
-- 
2.26.2

