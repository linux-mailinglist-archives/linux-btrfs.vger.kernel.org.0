Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08701850AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCMVMZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:12:25 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]:36828 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCMVMY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:12:24 -0400
Received: by mail-qv1-f53.google.com with SMTP id r15so5432093qve.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/XvooP7u4qYX26el2SXJGkajhh0j4ig1BaPQCSzZaPw=;
        b=Vbo7gPmvji7RJi0hdOFyz+XCVrqNAhyafwBXbWrVSjcHIniijHTqQ81yr12/TUngsf
         dw+35JdPOQMk2qk0Ng7M/PMijJ8j71Utf072sRlxX9id0W9LSAZRYtRRHFItOhQ3R5IG
         P2gSzU/pomK/Lnl6WzicLCG5oeyq2xpDF+lsxa9cTD2GwRaNVvGd/5ArR2krve5OYy7H
         v3fIiKeDVSk/w7wPRAkUXHVjJOrXJCgzQBZ7bWOr+tABLxPyiJfvcwYvNz7Ka34NN8NO
         DCdzDxWC1WvctHxjkS7ottvA1bpVVBbDS26o3rpLpKCLUNSgQv95NwGD/eEb7x1nq877
         vXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/XvooP7u4qYX26el2SXJGkajhh0j4ig1BaPQCSzZaPw=;
        b=WXFdG8ZmYEv4ZjNKMyzrKC+meXgmxN4r/sVUV+msu59IidxtD5MfTOLItbjyVsiOz1
         xDW1rLCai8k4Mx45psR9KruuqrK1TQX/j7amMc20zlLRpHXKPOQGfv6k5imHl1ls46+0
         oyLZ+7tYg6ksUIhiMZbChpPHHh0MZTtv0st1cGupS9qfABecrE5q0Pn9fd6sYxoHFCY+
         UlQrjeDt2mpCu2LTdlIVuVEHQYLVyxO7tSS0ruheQLKy102Gp56OYx0eGfPThVDOCC37
         NvSYz5K3LTkFXOoA/Npz8DYfFeTZs1Rl3bxmjXjZ50505Vq8cWVo0TgFSScSPCo11uAo
         9MSQ==
X-Gm-Message-State: ANhLgQ384eL/VbCi8n1/OkJGvjt738VwzRrWIDsaIUmtVzdlO42EeOHm
        oHVYmQdl0p1sXvWOklv2/Bn69K0gF/tOsA==
X-Google-Smtp-Source: ADFU+vu9hZRx3gNaqoER2xKEQYLfzbilQgu1SnJsy+wLzD8aHga4KiqB8cMQyuVb6jp94YvvoJ3Irg==
X-Received: by 2002:a05:6214:9cd:: with SMTP id dp13mr2229858qvb.110.1584133943228;
        Fri, 13 Mar 2020 14:12:23 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m19sm3792977qkk.1.2020.03.13.14.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:12:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5] Fix up some stupid delayed ref flushing behaviors
Date:   Fri, 13 Mar 2020 17:12:15 -0400
Message-Id: <20200313211220.148772-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While debugging Zygo's delayed ref problems it was clear there were a bunch of
cases that we're running delayed refs when we don't need to be, and they result
in a lot of weird latencies.

Each patch has their individual explanations.  But the gist of it is we run
delayed refs in a lot of arbitrary ways that have just accumulated throughout
the years, so clean up all of these so we can have more consistent performance.
Thanks,

Josef

