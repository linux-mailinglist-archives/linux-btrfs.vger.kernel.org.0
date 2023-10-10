Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3082D7C4134
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjJJU2c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjJJU2c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:28:32 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257CA91
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:31 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9a3d4b9456so2034874276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969710; x=1697574510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PqwCs/b1Hsgp1Ma3VQ+7VTt8mxOnnVCxTaIq0g2mA4E=;
        b=Q/3axBs0U/lxF7+wlzatZgwJXEdeg+R6o4Csp878tYeEniUiKwcmffEs9YKK5LCALW
         4WNFRjgCPZq+HvY4SOmMENT5Ek+eZjBhOVtVFTPKPFYudQeDxR/l104jl5xBJ7ySl2UX
         Pb64uFJs9Pep1WMw5YADmMis0zZ1M8YuWl4GGO39AN1nd6iS5sw1+4gnRnuz8qQfcw/S
         ew6Yj0rvW+ffVObD81WzMgt6j6PNxZl2Q9jyNg9sL/oSCgtD0H4fVnItBBGHL/L8aEbx
         hsrqnltn1bYCHzax2aKYcVa/hTbaym1uGqmdDEfPCSu/ZzyzNvwuAhpPjd1osyYxpvNZ
         FjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969710; x=1697574510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqwCs/b1Hsgp1Ma3VQ+7VTt8mxOnnVCxTaIq0g2mA4E=;
        b=uWHnTca3qnBoe3BUNAlca7s0cmgrOcaM7iUJoprMlp49IP9ZVRyK9t6ittTPDQhFAO
         92zC5ox172YeZdCin0bCmrZdWnjqFD/eOfarlGUv/eqzo9sB9274cdmGxMKZUrJ89NMF
         1EIg92ZlVhk5m1dgm3gJl6oOuSIOFGZCREjENcDQBO+ukuPwlvrVgjssB+mGReCL0PRg
         Owj34PxRYa0FATZH8OGomh34/dnscT/8g84ValOGkFpZZ7VFUWa8ry45s81nRTt0fBfo
         M1p2+VUbHu872i+6YFL9Q7oji8T8G2Rnnc70I3kx6UU8q2FlJZuDG9AF6FsNZD+j33qF
         P/ZA==
X-Gm-Message-State: AOJu0YwtakwDTPFAwuyRTySXjxMvcOdekw9EkvhhA28e7w0mNlUbxnX+
        xkvh+uSNnliuGn+9cPItF0LuwDJ/1Gj3uyVPP/sMJg==
X-Google-Smtp-Source: AGHT+IE4asq2ZLei7OwkYG1LL19duDJU8U2vgaXwcyPBupMGV9o2PnB9exj5Z8cyoZljd1HT0fOYOQ==
X-Received: by 2002:a05:6902:46:b0:d84:e73a:6ac9 with SMTP id m6-20020a056902004600b00d84e73a6ac9mr18329753ybh.24.1696969710191;
        Tue, 10 Oct 2023 13:28:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z4-20020a254c04000000b00d9a36ded1besm1055489yba.6.2023.10.10.13.28.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:28:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs-progs: add fscrypt support
Date:   Tue, 10 Oct 2023 16:28:17 -0400
Message-ID: <cover.1696969632.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

These patches have been updated to reflect the new on-disk format that comes
along with the updated fscrypt support patches.  The only new change that I've
added is a fix around the maximum inline extent size, which is more of a general
thing that needed to be updated, but was exposed by the fscrypt support.
Thanks,

Josef

Josef Bacik (1):
  btrfs-progs: check: fix max inline extent size

Sweet Tea Dorminy (7):
  btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
  btrfs-progs: start tracking extent encryption context info
  btrfs-progs: add inode encryption contexts
  btrfs-progs: interpret encrypted file extents.
  btrfs-progs: handle fscrypt context items
  btrfs-progs: escape unprintable characters in names
  btrfs-progs: check: update inline extent length checking

 check/main.c                    | 38 +++++++++++--------
 kernel-shared/accessors.h       | 48 ++++++++++++++++++++++++
 kernel-shared/ctree.h           |  3 +-
 kernel-shared/print-tree.c      | 62 +++++++++++++++++++++++++++++--
 kernel-shared/tree-checker.c    | 66 ++++++++++++++++++++++++++++-----
 kernel-shared/uapi/btrfs.h      |  1 +
 kernel-shared/uapi/btrfs_tree.h | 27 +++++++++++++-
 7 files changed, 215 insertions(+), 30 deletions(-)

-- 
2.41.0

