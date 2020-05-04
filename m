Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC451C33F2
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 10:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEDIDT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 04:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDIDS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 04:03:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F925C061A0E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 01:03:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u127so7898605wmg.1
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tgt18uLO/948Q7JtIq7bSi5PRGoE1EqC4WqTvH8FTYE=;
        b=N5LIiHD4eeFbAoJKU5BYElSpOtIA01AJ8x7tKPJOjxpFCxK/sjeMyS8pabnie7QbOK
         IMRvrNOYec9+lK7Ph2NKE0lDv9t2coY5J/8sMVWL+ixtW3XhLIIUhZH9nVNhh0sBQoIA
         +BTEytgtm3Y2nIgl8GMuCFXneBbl5yM5dRbqIXev9KZkz1VRPVkL+T454gZX0/mPiDuD
         UQMWX7CTLcH/TCchithTTUs3NQ4Xk41DIH/sVAd+xF0y3tGUuMjV3kqPIeJ+VDicXl12
         jPQT2LyaV4JFL0R1FQ+Gyr5lLOeS8MpRfOchUZfkR+2KcBn5exCeDTjqlqIKGcAF95ku
         IXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tgt18uLO/948Q7JtIq7bSi5PRGoE1EqC4WqTvH8FTYE=;
        b=XvZB1rwYaQ5axWMtmxa9SxpkFPCVs2X7WuOzqclZ2LpDNt5Xa2HocC+1nW1E+FiovZ
         6ZrXlBW+FQ3+GRiOnmy15axWG8bZkXGoyCd09B28zSg8w77yJxh5/0tfLHj9Bw1lUsaF
         +1ssXf+F6Frbi/ayCwpeMMuTunA5Vid+/ha9h/sV+YBnKibHKH92pyEwRSqTdfwI608H
         a1pe62husR2M5TPvzRu+5HxJkOg6aTqCkf8yJG59jF7IbP0e6pIib6rz5vRM6pbfndXG
         K1juUoj+8nPOXBp5iHSjPqCq5Y7DSK75vWXDbqfCaQMfpWz12b4gn0DFTkVeYVaLrOfa
         2VJA==
X-Gm-Message-State: AGi0PuZ9mlcUDPGxS6wKsaOooin6Coa9gnegBfyjd8pDnHp9oMcM1UqN
        X3GnytSLfDDYlD7PlTleEoN1Cr5riofuW0Tr70+M7ldgEho=
X-Google-Smtp-Source: APiQypKU6AF0J/yr5wDvInANwnh60i/fBD+7YN530LFk1ETmZKQWdApmioHluB1j6BDQEx1vwH7IPA0zSxf7RqAEoZQ=
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr13546896wmc.11.1588579396780;
 Mon, 04 May 2020 01:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
In-Reply-To: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 02:03:00 -0600
Message-ID: <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

receive (rw,noatime,seclabel,compress-force=zstd:5,space_cache=v2,subvolid=5,subvol=/)
send    (rw,noatime,seclabel,compress=zstd:1,nossd,notreelog,space_cache=v2,subvolid=5,subvol=/)

Both are on dm-crypt.

perf top -g -U consumes about 85% CPU according to top, and every time
I run it, the btrfs send performance *increases*. When I cancel this
perf top command, it returns to the slower performance. Curious.

Samples
  Children      Self  Shared Object        Symbol
+   40.56%     0.09%  [kernel]             [k] entry_SYSCALL_64_after_hwframe
+   40.30%     0.07%  [kernel]             [k] do_syscall_64
+   27.88%     0.00%  [kernel]             [k] ret_from_fork
+   27.88%     0.00%  [kernel]             [k] kthread
+   27.20%     0.02%  [kernel]             [k] process_one_work
+   25.69%     0.01%  [kernel]             [k] worker_thread
+   22.05%     0.01%  [kernel]             [k] btrfs_work_helper
+   19.01%     0.01%  [kernel]             [k] __x64_sys_splice
+   18.98%     2.02%  [kernel]             [k] do_splice
+   14.70%     0.00%  [kernel]             [k] async_cow_start
+   14.70%     0.00%  [kernel]             [k] compress_file_range
+   14.40%     0.00%  [kernel]             [k] temp_notif.12+0x4
+   13.20%     0.00%  [kernel]             [k] ZSTD_compressContinue_internal
+   13.14%     0.00%  [kernel]             [k] garp_protos+0x35
+   12.99%     0.01%  [kernel]             [k] nft_request_module
+   12.95%     0.01%  [kernel]             [k] ZSTD_compressStream
+   11.95%     0.01%  [kernel]             [k] ksys_read
+   11.87%     0.02%  [kernel]             [k] vfs_read
+   11.76%    11.45%  [kernel]             [k] fuse_perform_write
+   11.26%     0.02%  [kernel]             [k] do_idle
+   10.80%     0.01%  [kernel]             [k] cpuidle_enter
+   10.79%     0.01%  [kernel]             [k] cpuidle_enter_state
+   10.54%    10.54%  [kernel]             [k] mwait_idle_with_hints.constprop.0
+   10.33%     0.00%  libc-2.31.so         [.] splice
+    7.93%     7.59%  [kernel]             [k] mutex_unlock
+    7.38%     0.01%  [kernel]             [k] new_sync_read
+    7.36%     0.10%  [kernel]             [k] pipe_read
+    6.46%     0.07%  [kernel]             [k] __mutex_lock.constprop.0
+    6.34%     6.23%  [kernel]             [k] mutex_spin_on_owner
+    6.20%     0.00%  [kernel]             [k] secondary_startup_64
+    6.20%     0.00%  [kernel]             [k] cpu_startup_entry
+    6.05%     3.89%  [kernel]             [k] mutex_lock
+    5.78%     0.00%  [kernel]             [k] intel_idle
+    5.53%     0.00%  [kernel]             [k] iwl_mvm_mac_conf_tx
+    5.43%     0.00%  [kernel]             [k] run_one_async_start
+    5.43%     0.00%  [kernel]             [k] btrfs_submit_bio_start
+    5.31%     0.06%  [kernel]             [k] blake2b_update
+    5.11%     1.39%  [kernel]             [k] pipe_double_lock
+    4.28%     0.01%  [kernel]             [k] proc_reg_read
+    4.27%     0.09%  [kernel]             [k] seq_read
For a higher level overview, try: perf top --sort comm,dso
