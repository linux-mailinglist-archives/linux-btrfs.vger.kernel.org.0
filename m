Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821D82843E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 03:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgJFBrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 21:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgJFBrb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Oct 2020 21:47:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6ECC0613CE
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Oct 2020 18:47:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n15so5852171wrq.2
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Oct 2020 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0VeclrvGIGm0FdRNp2rwNYD/lk0SOVZQIy3aW6Hkkk4=;
        b=mY68/ANkNlb2g28EYpnbKJGpQdEiKaDTEkclKVBJlPZG+sax13LLUBofeR7YW/bmlE
         AxjgQiM6k0BVRiplPfnvf1dDeSl1mdFGpQBDdjQTG+rMVDyBEkQMGBuO85j2hiOWSiGn
         vRs81hk+NGdRbRcZFAz3hxMRKXawzlb9gYmJm5fycS7xHTE0zF+1zNnHgZOK2L7eFVxl
         j8aJF9mtS9ieNqQ8b6I8w1/PvdK8KGT1/oriWfQjiwyfPN079KFe0jebf1ltqziz+bX1
         3i1JWQIF027MA8mudW+o2gHf2gnGecNuIwnjw7qk6dfgjjsgX/GuriRs2cKDqRdZ8b5l
         b/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0VeclrvGIGm0FdRNp2rwNYD/lk0SOVZQIy3aW6Hkkk4=;
        b=FHxHyAIZ6E4/Z41r2qIsbWPB42M4w2Cm85DN5UPDuK/zryKmoL3dJeRW69NrU3etqG
         fr2zg4S76oXCZ6jd1P0PJ1dAlx8wM+UCzPywnbZqGwOgjU9D4qIFVd89hCfUK+TCNwR+
         /bptrPBcVeZ0LLcIhfYWFAz0cBN2R9sZFXpAuiHiaGrRWfFbN441I6Ng7CbT6SzbLOYE
         6agGVC9HZdigOnChBebJO+x+X0lRrvzakJjpHo3/7D8APzQroAIZB4MXgr4HgWmfnL51
         fP3Ej00gOYl/PAAf6tTjj8dgGXvIpJwMIGA51Zszp7eC3lCOQ58SeAr9TX9ftKInS+ek
         xY3A==
X-Gm-Message-State: AOAM531xGBeIYY3TB3o1hz90AgGdDHOwSteSw6E6A3zGBc52ZXiDlqSr
        o9A+WmAv39MNI9FgFHmU4L5JQ4SfpJH5bKk3fAUyibErxZA=
X-Google-Smtp-Source: ABdhPJwOQY9tArLW/bm/tRAEaWZxF+As9HI234YZTmkTnMTlPq8RqeFjrqLhd3HD/WxFRkaaUdi+Uvqy16kwUKHJUZQ=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr2060360wro.362.1601948849439;
 Mon, 05 Oct 2020 18:47:29 -0700 (PDT)
MIME-Version: 1.0
From:   Casey Matson-deKay <caseymdk@gmail.com>
Date:   Mon, 5 Oct 2020 18:46:53 -0700
Message-ID: <CAG8D92WMf8x8YX-tMd48ZS0aEABxc2keBukwh1VeS9nryExk0A@mail.gmail.com>
Subject: Best way to break RAID5/6?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I'm new to the community, but love the work being done here. I'm an
embedded C developer and PCB designer, and would like to get involved
in btrfs.

I, like many, am frustrated at the mystery of raid5/6 functionality.
More for the learning experience than anything, I was wondering about
the best known methods to break raid5/6 in a test setup, in order to
understand the patterns by which it breaks, and eventually, play
around with the kernel code to understand what's going on more in
depth.

My initial thought, taking 3 USB drives, configuring them in RAID5,
and pulling one out during a write, seems a bit simplistic. Are there
known raid failure modes that would be more apt for learning and
understanding where the raid bugs lie in btrfs, and how to trigger and
explore them?

Thank you!

Casey
