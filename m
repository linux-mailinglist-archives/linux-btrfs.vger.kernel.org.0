Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09BFE144279
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 17:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgAUQvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 11:51:49 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:45822 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAUQvt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 11:51:49 -0500
Received: by mail-qt1-f181.google.com with SMTP id w30so3126371qtd.12
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 08:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jni5aiaxFgcseRk1n3GHTym1ZOIsRtRx1LVxMaEWZLg=;
        b=FfHFH3Qqse+O9ZGdSqtdediGlvTdsCY1lTFEygwMqa6nVczbiPhSiiad8XstM41v6i
         BxLGJtJgJngmw6/hIcQo33BrihEdFd7Ya67MtEyerJJAtKoJnS4poRx2S6wsRTWLhuG0
         YhOxxAUvLWyzAJ4IXpZg0A6MxF4JTRofzRfuBSVw7lRPg84sRBWrfgQgdsjvBF5BAWk1
         4W5nMBK2Y9tfaF7Jql00a16NTE17eZ9Jq6tKA6BHbmfFBMN7JxNDvyIEE9jYW+pcymu1
         ngWaDrBWiTJjoenJknugncO3DTtnJ//6fYU2bXPlI3DFSGDXyFbIj4iEzgcCTLb/ml/D
         16uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jni5aiaxFgcseRk1n3GHTym1ZOIsRtRx1LVxMaEWZLg=;
        b=h8VCd6wVGJU8RyD+ol0R+sInymHCVAIc5DoVjI0/nC4aQSkK4YOcuX+1kX9FSpMH69
         0ewny1OtGWnbxx6HD/cQIS55ELXifKsJTtUg4cUfkb0rhiVpxRZF7IyhM+6PN+9CsSs6
         cYevTuvEfVVqNGWFiPHfQKT0S0WdoOmCgYtEmqCk4pdhYXwdwvC0erBkUM98w898R3w8
         fTSK4ax07htQJxWAHJqNrHRuvOOt/XigNwwfRWBOzV5OU6eQKHONt67WQ/chFNushMtE
         s4UgTeYr0SzxHtS3T80EyPdHQ6OUOAp1lAVRhxu6jI6ORIQJBQU26rCxM2bDaCAEJCl0
         dD7A==
X-Gm-Message-State: APjAAAX1Ucew8DIIuekCsbNL6wvMOa6L5APU2SbfrHova0NSWc/y89GA
        C2fpc30PJgUdfgIaNX/6rtTI+lP3/36v6Q==
X-Google-Smtp-Source: APXvYqxbbES+viRy6DuX5mEceu6vIoi3lFSJiW7Ztx1utamoe/BeckfS6vYLtZUYadNP85ku+vpv5A==
X-Received: by 2002:ac8:4b78:: with SMTP id g24mr1275930qts.220.1579625507824;
        Tue, 21 Jan 2020 08:51:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z1sm8107733qtq.69.2020.01.21.08.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:51:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] fixup work fixes
Date:   Tue, 21 Jan 2020 11:51:41 -0500
Message-Id: <20200121165144.2174309-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series is to address a few issues with the fixup worker we hit in
production.

The first of this is a resend of

  Btrfs: keep pages dirty when using

I've cleaned this up based on the feedback and added a bunch more comments to
make it clear what is happening and why we're doing it.

The next patch is a cleanup that is made possible by the previous patch, again
to clear up the fixup workers job.

  btrfs: drop the -EBUSY case in __extent_writepage_io

And finally the deadlock fix that I submitted earlier.  I noticed while trying
to backport this onto our kernel that we had changed the error case with the
above patch from Chris, and actually we really, really need Chris's fix as well.
There is also a change in the error handling from v1 where we now set the page
error properly but only once we've locked the page and verified we're still
responsible for COW'ing the page.  Thanks,

Josef

