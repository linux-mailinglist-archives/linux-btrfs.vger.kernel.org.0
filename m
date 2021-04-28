Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543E536DE81
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbhD1Rkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242684AbhD1Rjh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:39:37 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486FEC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id u20so32229794qku.10
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYLdHztH/9kJog5jjj/uRHWMj3GwPpeWVQ6oeN/1Rws=;
        b=xZ1P7wao9Wa+JRxZ6dtoxjB71jvW9bHqpnsfb5UrvljOoJfCaPw+HicuSpBome27fh
         gXP79fBNPnctM8UOk7zEcRwkPhXmvPFfjwa9L1BVbiET2Jxum/VZB4DnXSrzylTWKfVT
         KjOMR2v71B6cIm+IUcgdBS4xEI+eyV030yoosJrjbeMS6rVueX1kSzHPZZ6XqaGTUYv5
         IBya+Zas2gVolQAptsNwXXFOtn68NxFcJZ85vl29YTJx4LCgdHMRxEHb6FhR5LRNTsHm
         7s+undBpy8Q/0B3e9k3Ze4cb5CjF0D6WBHbwOauN+b9C7+yn0FjHGnCPecNaZMGU6qlO
         90yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYLdHztH/9kJog5jjj/uRHWMj3GwPpeWVQ6oeN/1Rws=;
        b=Vs50/euoE7bO3ulTXszqOlqurZCYrl2qzw1Q+kRG3na7JMA1Y7zKK6Wnu6tgLfvk9Y
         NDiq1getAv4pLBQfHtOikQi4CgdMoHNrB+RTRwHP7bJYDf2/tNpHdPuUm7LYYq1kZKk5
         qSad8NVCUkwCExJxQR8zlKbNy7xmTvvFmMbUpf9KpQEUAx5k+LE6JQy8UDDfOKG9bIW2
         Qs4MGfVOrMMxNTvtM5zcB0BgyrKiqfAc16Q856CB0AuLxOhkxLZlov+s3R3tOaAsq6rN
         5v0mHeD1+C0cNe+sG6WQ2QtZwLXhl+5RphmVYC4e67THReghK42GyChqhWSsI5Zsg6h/
         SDcA==
X-Gm-Message-State: AOAM532qrk0qnhHPnTx/VGMFWZaH9AmEOe6CTQJQ4RfDFXZDSf7mOxMa
        aFcX265XOg8KDFwGm3ydlF9yJFKeaRI0lA==
X-Google-Smtp-Source: ABdhPJx9h4yuSel2/2aCmv6+ZO5A5p/HnMhSz1b7fi4gYs1cJal0BggpewATLZNuDFM6vaqYXbdCXw==
X-Received: by 2002:a37:4185:: with SMTP id o127mr30381765qka.247.1619631529794;
        Wed, 28 Apr 2021 10:38:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t3sm278464qke.72.2021.04.28.10.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:38:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/7] Preemptive flushing improvements
Date:   Wed, 28 Apr 2021 13:38:41 -0400
Message-Id: <cover.1619631053.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following patch series is a set of improvements around our preemptive
flushing infrastructure.  A user reported[1] a problem where the preemptive
flushing was running non-stop on his full file system.  I was not able to
reproduce this behavior, but noticed a few fundamental issues with how we
decided to do preemptive flushing.  The main relevant thing is that we were not
taking into account the global reserve when deciding if we needed to
preemptively flush.  In cases such as the users file system where the majority
of the free metadata space is taken up by the global reserve we could
potentially always want to flush, which is annoying and not what we want.

Furthermore I noticed issues where we would clamp entirely too quickly, and
where we made some poor decisions around delalloc.  None of these are ground
breaking or huge improvements, but offer some better performance in some of the
fsperf test cases.  This is the results of my recent run with the whole
patchset.  You'll notice a "regression" in the 16g buffered write, this is
mostly because of the test, if you look at the results on the nightly
performance tests you'll see this test varies more than others.  Re-testing with
just that test didn't show the same regression after multiple runs, so it's just
noise.  I could have chosen to run all the tests multiple times to get an
average over several runs, but that takes a fair bit of time.  Individual runs
of the test showed no regression and often showed an improvement, so I feel
comfortable calling it noise.  The full results are as follows

dbench60 results
  metric     baseline   current         diff
==================================================
qpathinfo       11.53     13.25    14.90%
throughput     446.23    434.52    -2.62%
flush         2502.92   1682.43   -32.78%
qfileinfo        0.92      1.17    27.29%
ntcreatex     1359.76    519.42   -61.80%
qfsinfo          1.77      3.76   112.64%
close            1.90      1.64   -13.91%å
sfileinfo      209.76     76.43   -63.56%
rename        1110.08    518.40   -53.30%
find            13.84     13.13    -5.15%
unlink        1192.89    521.53   -56.28%
writex        1713.39   1321.39   -22.88%
deltree        280.34    296.33     5.70%
readx            3.16      2.91    -8.10%
mkdir            0.03      0.02   -46.67%
lockx            0.78      0.20   -73.89%
unlockx          0.16      0.12   -23.81%

emptyfiles500k results
     metric         baseline   current         diff
=========================================================
write_io_kbytes       125000     125000    0.00%
read_clat_ns_p99           0          0    0.00%
write_bw_bytes      1.79e+08   1.85e+08    3.04%
read_iops                  0          0    0.00%
write_clat_ns_p50      17728      17280   -2.53%
read_io_kbytes             0          0    0.00%
read_io_bytes              0          0    0.00%
write_clat_ns_p99      72704      68096   -6.34%
read_bw_bytes              0          0    0.00%
elapsed                    1          1    0.00%
write_lat_ns_min           0          0    0.00%
sys_cpu                91.23      89.16   -2.27%
write_lat_ns_max           0          0    0.00%
read_lat_ns_min            0          0    0.00%
write_iops          43763.97   45093.80    3.04%
read_lat_ns_max            0          0    0.00%
read_clat_ns_p50           0          0    0.00%

smallfiles100k results
     metric         baseline   current         diff
=========================================================
write_io_kbytes     2.04e+08   2.04e+08    0.00%
read_clat_ns_p99           0          0    0.00%
write_bw_bytes      1.40e+08   1.40e+08    0.50%
read_iops                  0          0    0.00%
write_clat_ns_p50       6712       6944    3.46%
read_io_kbytes             0          0    0.00%
read_io_bytes              0          0    0.00%
write_clat_ns_p99      16000      16512    3.20%
read_bw_bytes              0          0    0.00%
elapsed              1498.88       1491   -0.53%
write_lat_ns_min     2858.38       2919    2.12%
sys_cpu                 6.22       6.51    4.61%
write_lat_ns_max    1.31e+08   1.27e+08   -2.77%
read_lat_ns_min            0          0    0.00%
write_iops          34081.44   34253.51    0.50%
read_lat_ns_max            0          0    0.00%
read_clat_ns_p50           0          0    0.00%

dio4kbs16threads results
     metric          baseline     current          diff
=============================================================
write_io_kbytes         4360879    5312908    21.83%
read_clat_ns_p99              0          0     0.00%
write_bw_bytes      74302497.38   90667585    22.02%
read_iops                     0          0     0.00%
write_clat_ns_p50        243968     238592    -2.20%
read_io_kbytes                0          0     0.00%
read_io_bytes                 0          0     0.00%
write_clat_ns_p99      21094400   15007744   -28.85%
read_bw_bytes                 0          0     0.00%
elapsed                      61         61     0.00%
write_lat_ns_min       38183.25      37949    -0.61%
sys_cpu                    4.03       4.72    17.11%
write_lat_ns_max       1.68e+09   8.46e+08   -49.55%
read_lat_ns_min               0          0     0.00%
write_iops             18140.26   22135.64    22.02%
read_lat_ns_max               0          0     0.00%
read_clat_ns_p50              0          0     0.00%

randwrite2xram results
     metric          baseline     current          diff
=============================================================
write_io_kbytes        27720434   36563300    31.90%
read_clat_ns_p99              0          0     0.00%
write_bw_bytes      93268100.75   1.16e+08    24.83%
read_iops                     0          0     0.00%
write_clat_ns_p50         13168      16512    25.39%
read_io_kbytes                0          0     0.00%
read_io_bytes                 0          0     0.00%
write_clat_ns_p99         39360     125440   218.70%
read_bw_bytes                 0          0     0.00%
elapsed                  334.25        333    -0.37%
write_lat_ns_min        5436.75       5682     4.51%
sys_cpu                    8.22      12.57    52.96%
write_lat_ns_max       4.05e+10   2.73e+10   -32.65%
read_lat_ns_min               0          0     0.00%
write_iops             22770.53   28425.17    24.83%
read_lat_ns_max               0          0     0.00%
read_clat_ns_p50              0          0     0.00%

untarfirefox results
metric    baseline   current        diff
==============================================
elapsed      47.23     46.82   -0.87%

I'm still waiting on feedback from the user to make sure the patches fix the
reported problem, but they're worthy on their own if they do not resolve the
original reported issue.  Thanks,

Josef

[1] https://bugzilla.kernel.org/show_bug.cgi?id=212185

Josef Bacik (7):
  btrfs: check worker before need_preemptive_reclaim
  btrfs: only clamp the first time we have to start flushing
  btrfs: take into account global rsv in need_preemptive_reclaim
  btrfs: use the global rsv size in the preemptive thresh calculation
  btrfs: don't include the global rsv size in the preemptive used amount
  btrfs: only ignore delalloc if delalloc is much smaller than ordered
  btrfs: handle preemptive delalloc flushing slightly differently

 fs/btrfs/space-info.c | 56 +++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 18 deletions(-)

-- 
2.26.3

