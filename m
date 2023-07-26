Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136D67640A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGZUkt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGZUkr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:40:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D40211C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:40:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ECD7B5C0178;
        Wed, 26 Jul 2023 16:40:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Jul 2023 16:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1690404042; x=1690490442; bh=45Aa+bRkXl
        izMLvr4wEHyHAF6Evf2Q8FeV7Ev4dCbYo=; b=sDgh9jKx+XIoDZZ8Z+agiKu9Js
        Kf6hHVZCEAvWDqW/6iS4UUAV3dzjrRMtKgd6dlykoZHezFOa9bjszxGpz8n0W/bw
        BHuu61DlKLzSPkH8kqOFf2feJv/Bz3bV8GV/5AROFhWXlQ5A0rIrvIVhBqZDdjnX
        rA2NWqb+bGM//cdA0sjaiHFFU2WUvPlZDcLfjkz3JSTQnbECp14sa2ggy5LDgbQV
        eFGbHwfbm5nQa1nflpjJU8xPAcwJhnPb2YwHHr+gL3NBlrQtVRw7x7WZNyND32Vv
        ZqqRXI3hJ+O2yrLJ04FExdZtb0Z2frbsvvko1FLfuIpjCxOBbIjWmA840Z2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1690404042; x=1690490442; bh=45Aa+bRkXlizMLvr4wEHyHAF6Evf
        2Q8FeV7Ev4dCbYo=; b=LasWI0drintH7b0QWIruOeBIT5irW5X5pTq8uG26zh2l
        nfUZ0DWtEZeQFWpO/8jxwmOaH/G5q2eylYtM2q3rJOIHIZUo55bFXV2DhKArsOMp
        pa1EukvwneD3SVHceKd+FMP+FTndvUbTZJxP8HOKSTdz1Yk8GJjv8OjUPPsiDDlQ
        IcnprJBice3hqKo5YVuCZDrXjZ0Gh7driDJtebJX8t0iqEMdwl661LNORJLnr1hZ
        D/B/VMEpRPJ/a+aQ+0ugnVHOXHKq8WZbJL2B/BsHBqCOtp3SnF3RhO2EbgBWr/IJ
        BRWMNFdMiigeHVhgZVMTZA93Y2gh457L9AVWuyDQcA==
X-ME-Sender: <xms:yoTBZBh7YRNo665BNDshHLPq2kVhzy51m4MJ6ksIAp3yRSSm89-FMw>
    <xme:yoTBZGAVL2dAtA0POkyLELJQZJql-miOHwXFcQj9gly084uryJXZGci3Cn83drFJr
    w35UrapekWkrJTnZlA>
X-ME-Received: <xmr:yoTBZBGyIChKA2PbcMvNxZShC7pbNwQKXNjj2moA-hNpbCaYUvbOgJVq9ZgS-BDmLBfX7uPlyUXocTL7kQzDi5f4eSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehteeljeeikeehfffghfehteegjeevjeeggeevtdefhe
    etjeehfeeutdefhedvkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:yoTBZGSDdqB3muGPZvzcDcaAa_cYO34BL9KOCyCUKmdm53RAIrzB4Q>
    <xmx:yoTBZOyN9eBKPJw4eCbXw4Chi5JBQso6j2WVUxpi_7reLDECLCxs2A>
    <xmx:yoTBZM4RhmSNAVz8vQlt5v5Fw7VP6fR-rVJdo8cQJBTvYKd--aUvog>
    <xmx:yoTBZEagke6IWCgZqV2Nb7FzwVYOxuCvvwA_6e_jE7EagZE5E14fLw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:40:42 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 00/18] btrfs: simple quotas
Date:   Wed, 26 Jul 2023 13:38:27 -0700
Message-ID: <cover.1690403768.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs quota groups (qgroups) are a compelling feature of btrfs that
allow flexible control for limiting subvolume data and metadata usage.
However, due to btrfs's high level decision to tradeoff snapshot
performance against ref-counting performance, qgroups suffer from
non-trivial performance issues that make them unattractive in certain
workloads. Particularly, frequent backref walking during writes and
during commits can make operations increasingly expensive as the number
of snapshots scales up. For that reason, we have never been able to
commit to using qgroups in production at Meta, despite significant
interest from people running container workloads, where we would benefit
from protecting the rest of the host from a buggy application in a
container running away with disk usage. This patch series introduces a
simplified version of qgroups called
simple quotas (squotas) which never computes global reference counts
for extents, and thus has similar performance characteristics to normal,
quotas disabled, btrfs. The "trick" is that in simple quotas mode, we
account all extents permanently to the subvolume in which they were
originally created. That allows us to make all accounting 1:1 with
extent item lifetime, removing the need to walk backrefs. However,
this sacrifices the ability to compute shared vs. exclusive usage. It
also results in counter-intuitive, though still predictable and simple
accounting in the cases where an original extent is removed while a
shared copy still exists. Qgroups is able to detect that case and count
the remaining copy as an exclusive owner, while squotas is not. As a
result, squotas works best when the original extent is immutable and
outlives any clones.

==Format Change==
In order to track the original creating subvolume of a data extent in
the face of reflinks, it is necessary to add additional accounting to
the extent item. To save space, this is done with a new inline ref item.
However, the downside of this approach is that it makes enabling squota
an incompat change, denoted by the new incompat bit SIMPLE_QUOTA. When
this bit is set and quotas are enabled, new extent items get the extra
accounting, and freed extent items check for the accounting to find
their creating subvolume. In addition, 1:1 with this incompat bit,
the quota status item now tracks a "quota enablement generation" needed
for properly handling deleting extents with predate enablement.

==API==
Squotas reuses the api of qgroups. The only difference is that when you
enable quotas via `btrfs quota enable`, you pass the `--simple` flag.
Squotas will always report exclusive == shared for each qgroup. Squotas
deal with extent_item/metadata_item sizes and thus do not do anything
special with compression. Squotas also introduce auto inheritance for
nested subvols. The API is documented more fully in the documentation
patches in btrfs-progs.

==Testing methodology==
Using updated btrfs-progs and fstests (relevant matching patch sets to
be sent ASAP)
btrfs-progs: https://github.com/boryas/btrfs-progs/tree/squota-progs
fstests: https://github.com/boryas/fstests/tree/squota-test

I ran '-g auto' on fstests on the following configurations:
1a) baseline kernel/progs/fstests.
1b) squota kernel baseline progs/fstests.
2a) baseline kernel/progs/fstests. fstests configured to mkfs with quota
2b) squota kernel/progs/fstests. fstests configured to mkfs with squota

I compared 1a against 1b and 2a against 2b and detected no regressions.
2a/2b both exhibit regressions against 1a/1b which are largely issues
with quota reservations in various complicated cases. I intend to run
those down in the future, but they are not simple quota specific, as
they are already broken with plain qgroups.

==Performance Testing==
I measured the performance of the change using fsperf. I ran with 3
configurations using the squota kernel:
- plain mkfs
- qgroup mkfs
- squota mkfs
And added a new performance test which creates 1000 files in a subvol,
creates 100 snapshots of that subvol, then unshares extents in files in
the snapshots. I measured write performance with fio and btrfs commit
critical section performance side effects with bpftrace on
'wait_current_trans'.

The results for the test which measures unshare perf (unshare.py) with
qgroup and squota compared to the baseline:

group test results
unshare results
          metric              baseline       current        stdev            diff
========================================================================================
avg_commit_ms                     162.13        285.75          3.14     76.24%
bg_count                              16            16             0      0.00%
commits                           378.20           379          1.92      0.21%
elapsed                           201.40        270.40          1.34     34.26%
end_state_mount_ns           26036211.60   26004593.60    2281065.40     -0.12%
end_state_umount_ns             2.45e+09      2.55e+09   20740154.41      3.93%
max_commit_ms                     425.80           594         53.34     39.50%
sys_cpu                             0.10          0.06          0.06    -42.15%
wait_current_trans_calls         2945.60       3405.20         47.08     15.60%
wait_current_trans_ns_max       1.56e+08      3.43e+08   32659393.25    120.07%
wait_current_trans_ns_mean    1974875.35   28588482.55    1557588.84   1347.61%
wait_current_trans_ns_min            232           232         25.88      0.00%
wait_current_trans_ns_p50            718           740         22.80      3.06%
wait_current_trans_ns_p95     7711770.20      2.21e+08   17241032.09   2761.19%
wait_current_trans_ns_p99    67744932.29      2.68e+08   41275815.87    295.16%
write_bw_bytes                 653008.80     486344.40       4209.91    -25.52%
write_clat_ns_mean            6251404.78    8406837.89      39779.15     34.48%
write_clat_ns_p50             1656422.40    1643315.20      27415.68     -0.79%
write_clat_ns_p99               1.90e+08      3.20e+08       2097152     68.62%
write_io_kbytes                   128000        128000             0      0.00%
write_iops                        159.43        118.74          1.03    -25.52%
write_lat_ns_max                7.06e+08      9.80e+08   47324816.61     38.88%
write_lat_ns_mean             6251503.06    8406936.06      39780.83     34.48%
write_lat_ns_min                    3354          4648        616.06     38.58%

squota test results
unshare results
          metric              baseline       current        stdev            diff
========================================================================================
avg_commit_ms                     162.13        164.16          3.14      1.25%
bg_count                              16             0             0   -100.00%
commits                           378.20        380.80          1.92      0.69%
elapsed                           201.40        208.20          1.34      3.38%
end_state_mount_ns           26036211.60   25840729.60    2281065.40     -0.75%
end_state_umount_ns             2.45e+09      3.01e+09   20740154.41     22.80%
max_commit_ms                     425.80        415.80         53.34     -2.35%
sys_cpu                             0.10          0.08          0.06    -23.36%
wait_current_trans_calls         2945.60       2981.60         47.08      1.22%
wait_current_trans_ns_max       1.56e+08      1.12e+08   32659393.25    -27.86%
wait_current_trans_ns_mean    1974875.35    1064734.76    1557588.84    -46.09%
wait_current_trans_ns_min            232           238         25.88      2.59%
wait_current_trans_ns_p50            718           746         22.80      3.90%
wait_current_trans_ns_p95     7711770.20       1567.60   17241032.09    -99.98%
wait_current_trans_ns_p99    67744932.29   49880514.27   41275815.87    -26.37%
write_bw_bytes                 653008.80        631256       4209.91     -3.33%
write_clat_ns_mean            6251404.78    6476816.06      39779.15      3.61%
write_clat_ns_p50             1656422.40       1581056      27415.68     -4.55%
write_clat_ns_p99               1.90e+08      1.94e+08       2097152      2.21%
write_io_kbytes                   128000        128000             0      0.00%
write_iops                        159.43        154.12          1.03     -3.33%
write_lat_ns_max                7.06e+08      7.65e+08   47324816.61      8.38%
write_lat_ns_mean             6251503.06    6476912.76      39780.83      3.61%
write_lat_ns_min                    3354          4062        616.06     21.11%

And the same, but only showing results where the deviation was outside
of a 95% confidence interval for the mean (default significance
highlighting in fsperf):
qgroup test results
unshare results
          metric              baseline       current        stdev            diff
========================================================================================
avg_commit_ms                     162.13        285.75          3.14     76.24%
elapsed                           201.40        270.40          1.34     34.26%
end_state_umount_ns             2.45e+09      2.55e+09   20740154.41      3.93%
max_commit_ms                     425.80           594         53.34     39.50%
wait_current_trans_calls         2945.60       3405.20         47.08     15.60%
wait_current_trans_ns_max       1.56e+08      3.43e+08   32659393.25    120.07%
wait_current_trans_ns_mean    1974875.35   28588482.55    1557588.84   1347.61%
wait_current_trans_ns_p95     7711770.20      2.21e+08   17241032.09   2761.19%
wait_current_trans_ns_p99    67744932.29      2.68e+08   41275815.87    295.16%
write_bw_bytes                 653008.80     486344.40       4209.91    -25.52%
write_clat_ns_mean            6251404.78    8406837.89      39779.15     34.48%
write_clat_ns_p99               1.90e+08      3.20e+08       2097152     68.62%
write_iops                        159.43        118.74          1.03    -25.52%
write_lat_ns_max                7.06e+08      9.80e+08   47324816.61     38.88%
write_lat_ns_mean             6251503.06    8406936.06      39780.83     34.48%
write_lat_ns_min                    3354          4648        616.06     38.58%

squota test results
unshare results
          metric              baseline       current        stdev            diff
========================================================================================
elapsed                           201.40        208.20          1.34      3.38%
end_state_umount_ns             2.45e+09      3.01e+09   20740154.41     22.80%
write_bw_bytes                 653008.80        631256       4209.91     -3.33%
write_clat_ns_mean            6251404.78    6476816.06      39779.15      3.61%
write_clat_ns_p50             1656422.40       1581056      27415.68     -4.55%
write_clat_ns_p99               1.90e+08      1.94e+08       2097152      2.21%
write_iops                        159.43        154.12          1.03     -3.33%
write_lat_ns_mean             6251503.06    6476912.76      39780.83      3.61%

Particularly noteworthy are the massive regressions to
wait_current_trans in qgroup mode as well as the solid regressions to
bandwidth, iops and write latency. The regressions/improvements in
squotas are modest in comparison in line with the expectation. I am
still investigating the squota umount regression, particularly whether
it is in the umount's final commit and represents a real performance
problem with squotas.

Link: https://github.com/boryas/btrfs-progs/tree/squota-progs
Link: https://github.com/boryas/fstests/tree/squota-test
Link: https://github.com/boryas/fsperf/tree/unshare-victim

---
Changelog:
v4:
* drop unrelated patches folded into misc-next
* fix crash where check_committed_extent was reading the inline ref type
  on an extent item with no inline extents. (btrfs/192 *without* squotas
  enabled)
v3:
* u64 -> __le64 in new owner_ref_item (as caught by kernel test bot)
v2:
* fix dumb formatting errors, unexpected/unrelated edits
* use command instead of status in ioctl
* fix the illegal GFP_KERNEL in delta fn (punted on pulling allocations
  out from the spin lock and using GFP_ATOMIC like other qgroups use
  cases for now. Plan to fix that in either v3 or a follow up series, as
  there are other places this is an issue for qgroups/squotas)
* improve boolean logic in head_ref init
* use list_count helper function instead of rolling my own bad one
* fixed the adjacent extents reloc cluster bug Josef noticed
* fixed a qgroups bug I introduced: it needs to be able to account
  extents while shutting down to not hit a warning in commit_transaction
* added a qgroup_status flag for simple quotas to not rely on the
  incompat bit directly. This allows disabling simple quotas and
  enabling qgroups.

Boris Burkov (18):
  btrfs: introduce quota mode
  btrfs: add new quota mode for simple quotas
  btrfs: expose quota mode via sysfs
  btrfs: add simple_quota incompat feature to sysfs
  btrfs: flush reservations during quota disable
  btrfs: create qgroup earlier in snapshot creation
  btrfs: function for recording simple quota deltas
  btrfs: rename tree_ref and data_ref owning_root
  btrfs: track owning root in btrfs_ref
  btrfs: track original extent owner in head_ref
  btrfs: new inline ref storing owning subvol of data extents
  btrfs: inline owner ref lookup helper
  btrfs: record simple quota deltas
  btrfs: simple quota auto hierarchy for nested subvols
  btrfs: check generation when recording simple quota delta
  btrfs: track metadata relocation cow with simple quota
  btrfs: track data relocation with simple quota
  btrfs: only set QUOTA_ENABLED when done reading qgroups

 fs/btrfs/accessors.h            |   6 +
 fs/btrfs/backref.c              |   3 +
 fs/btrfs/ctree.c                |  22 ++-
 fs/btrfs/ctree.h                |   1 +
 fs/btrfs/delayed-ref.c          |  32 ++--
 fs/btrfs/delayed-ref.h          |  38 ++++-
 fs/btrfs/disk-io.c              |   5 +-
 fs/btrfs/extent-tree.c          | 235 +++++++++++++++++++++-----
 fs/btrfs/extent-tree.h          |   6 +-
 fs/btrfs/file.c                 |  10 +-
 fs/btrfs/fs.h                   |   7 +-
 fs/btrfs/inode-item.c           |   2 +-
 fs/btrfs/ioctl.c                |   7 +-
 fs/btrfs/print-tree.c           |  12 ++
 fs/btrfs/qgroup.c               | 286 +++++++++++++++++++++++++++-----
 fs/btrfs/qgroup.h               |  28 +++-
 fs/btrfs/ref-verify.c           |   7 +-
 fs/btrfs/relocation.c           |  65 +++++++-
 fs/btrfs/root-tree.c            |   2 +-
 fs/btrfs/sysfs.c                |  28 ++++
 fs/btrfs/transaction.c          |  19 ++-
 fs/btrfs/tree-checker.c         |   3 +
 fs/btrfs/tree-log.c             |   3 +-
 include/uapi/linux/btrfs.h      |   2 +
 include/uapi/linux/btrfs_tree.h |  27 ++-
 25 files changed, 712 insertions(+), 144 deletions(-)

-- 
2.41.0

