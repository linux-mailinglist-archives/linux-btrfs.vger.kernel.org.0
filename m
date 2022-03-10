Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53474D50FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 18:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbiCJR70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 12:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245194AbiCJR7Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 12:59:24 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA1DE7F5C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 09:58:23 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id u9so1710929qta.5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 09:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW6pUOWtHCIcqoQwn8ofBcH7rI3lv2kRRCYN26zc980=;
        b=Yoouu1mVywi3TkWoFUrs9CeYgvh+du9CtsW53zeEx/w5rtkLDXNd9LcWVnjbopZsWg
         LhcsCBbJpgbZY01rLswjSME4qdmHKZjkKR6838TF9WfYl3t62B7ikStfHwaJ8ucjjIHu
         ygAaXkPVlz/c7OisvkMYDVJX1UyC3ixbX4cBmfmboSuDxfwslhfeEVuFizu4q4YiLS3k
         yl0KxzyPbzIF4pcHwuFqFNImNHXgSYTEP8fD7sE0jxOGay6GWRPqeDqDzP6VQCONxaiq
         jdqPxQFD3CzUu3M3ep1jXbEUiy1UfFd00EzNbbzLl1FfqrVlJ1ayS/TrSQAcWLX02VnL
         4LDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW6pUOWtHCIcqoQwn8ofBcH7rI3lv2kRRCYN26zc980=;
        b=iUWi3KaSPFJvQLJigp4THPVJCZzdfFQNzRX4W+t5Y2IETaPBYuGqFWNwKls6MZZpe8
         iCBJYazdfySgUwDz25/riJ8Elh5wvuE95+Wl4bmu8RdTTLo5N5bO60ewZKVASayONFqE
         /tugLojLYCEhWHRErLeUyV0saZt2fg2tR4t21UkiufdHy2p8txHCRa6XAscyVlGJef5p
         mEl0qw2kiFLiYMPNQMwAEb+m79C6pfslOR0Nf22hE5CZtoJd2JyvJibRRPow/2JpgAc0
         TRpcUtpqjwYowYIovvrI3pJ6y+zkTmoYxbV5jRe/Tlv2wWfuvjerldxOZW1VgjzDoYe4
         Sa+A==
X-Gm-Message-State: AOAM531581U6avAlPou4w1Wzopuv2DQCAfmPZyH1Y381m2HQCP/bYNDc
        Kh53ua3xzxWfOo4U2snKNvp0fp5ZYWc5/7RE
X-Google-Smtp-Source: ABdhPJwIk58I9XVkZPTLKiJost8JwQwPZM0SGm0WUwxzV2No7ggovDAqrtH5QWn1QMnsBcibW+V4fw==
X-Received: by 2002:ac8:5fc5:0:b0:2e0:5326:fc85 with SMTP id k5-20020ac85fc5000000b002e05326fc85mr4882322qta.480.1646935101898;
        Thu, 10 Mar 2022 09:58:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d15-20020a05622a15cf00b002de711a190bsm3574690qty.71.2022.03.10.09.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:58:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] btrfs: rework background block group relocation
Date:   Thu, 10 Mar 2022 12:58:17 -0500
Message-Id: <cover.1646934721.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Currently the background block group relocation code only works for zoned
devices, as it prevents the file system from becoming unusable because of block
group fragmentation.

However inside Facebook our common workload is to download tens of gigabytes
worth of send files or package files, and it does this by fallocate()'ing the
entire package, writing into it, and then free'ing it up afterwards.
Unfortunately this leads to a similar problem as zoned, we get fragmented data
block groups, and this trends towards filling the entire disk up with partly
used data block groups, which then leads to ENOSPC because of the lack of
metadata space.

Because of this we have been running balance internally forever, but this was
triggered based on different size usage hueristics and stil gave us a high
enough failure rate that it was annoying (figure 10-20 machines needing to be
reprovisioned per week).

So I modified the existing bg_reclaim_threshold code to also apply in the !zoned
case, and I also made it only apply to DATA block groups.  This has completely
eliminated these random failure cases, and we're no longer reprovisioning
machines that get stuck with 0 metadata space.

However my internal patch is kind of janky as it hard codes the DATA check.
What I've done here is made the bg_reclaim_threshold per-space_info, this way
a user can target all block group types or just the ones they care about.  This
won't break any current users because this only applied in the zoned case
before.

Additionally I've added the code to allow this to work in the !zoned case, and
loosened the restriction on the threshold from 50-100 to 0-100.

I tested this on my vm by writing 500m files and then removing half of them and
validating that the block groups were automatically reclaimed.  Thanks,

Josef

Josef Bacik (3):
  btrfs: make the bg_reclaim_threshold per-space info
  btrfs: allow block group background reclaim for !zoned fs'es
  btrfs: change the bg_reclaim_threshold valid region from 0 to 100

 fs/btrfs/block-group.c      | 31 ++++++++++++++++
 fs/btrfs/ctree.h            |  1 -
 fs/btrfs/disk-io.c          |  1 -
 fs/btrfs/free-space-cache.c |  4 +--
 fs/btrfs/space-info.c       |  9 +++++
 fs/btrfs/space-info.h       |  6 ++++
 fs/btrfs/sysfs.c            | 71 +++++++++++++++++++------------------
 fs/btrfs/zoned.h            |  6 ----
 8 files changed, 84 insertions(+), 45 deletions(-)

-- 
2.26.3

