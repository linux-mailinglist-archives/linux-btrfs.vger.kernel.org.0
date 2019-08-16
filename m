Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD890456
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfHPPGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 11:06:05 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44590 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHPPGE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 11:06:04 -0400
Received: by mail-qt1-f181.google.com with SMTP id 44so6390516qtg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+qwIW0gm1TJY0bcgQeRuuzJSrSz+2++GNxoTeEp0ro=;
        b=ChXALQh6o8niXvqv3YNiItdcwu4bu/zKeUklfr/L1IV2OFKl2opnvHmLXYaAEQEvY2
         iFs8GWXexDJKmCTkMLg+gEQbHgfPQijv/b2XfPt/6DLo2U6PY+d7rvVdnZTmaCUwuKLb
         akD6Q3s4O1kfJ+UdpiWpr/ZT4BHHUJQshTSuWkBZe0IGYIFjBKvb1XzcsJKXuvARG3xm
         KBZiHKEMA3oSOfznf5n/sO6nGyEh1BZ2rxq0jJOptJbaMr3KGTelbD5hpqWV4sbUCH5W
         c61gjCJAfB65iaRaAn4rNEgrng8M8328wt7+dp/Xdvz+sZfOUz2lsqoA7YD5hXSrZzoW
         dqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+qwIW0gm1TJY0bcgQeRuuzJSrSz+2++GNxoTeEp0ro=;
        b=USPwjL41G/wMgBTs6IrULtfUXOK4U7iYrBbwWekhRp5g2f30ytuCAbCo7trnFHAJ1c
         lawsZfIcxNfamYkWyRfdSJbJs89pWMO69+kt40yuNxKz5EV77eJi6/i3eZbSnp2l9RGZ
         8h2jNklnkEc5O7ebQrecq7n/yGfK7pfF1L4JwPwVpqMIoFZpMn8cKnYRa9j/0erOMNpe
         xAa58nmHPNVAa/qXfvhWDuo0xlzEeqjePQmTt8AZjibDuKhjrXfivJuPtKH0YC7je2qt
         SCkG1NxGYWoJ5gtxdrI4Hwcpuy3dfTSJs0M2Qe7aQH5YX8DpZBSF3IWj3RDs1BJk1BMl
         mHBg==
X-Gm-Message-State: APjAAAWAXSJkEq5fV7nf+Coo3vADP774JggnqhsYJGTf4dAyDoPM282G
        8yZAJ+7xInP32JHsD18k887e1zAJ+MiS5A==
X-Google-Smtp-Source: APXvYqxSpxrYvR3ChTEH8/9zJyJstWuQV8EgCzGcPPSyiM1eiOOnYIhHR8F/LyaV1mLygoCrGKtF2w==
X-Received: by 2002:ac8:6109:: with SMTP id a9mr9102193qtm.151.1565967963513;
        Fri, 16 Aug 2019 08:06:03 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b1sm2843237qkk.8.2019.08.16.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:06:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Rework the worst case calculations for space reservation
Date:   Fri, 16 Aug 2019 11:05:57 -0400
Message-Id: <20190816150600.9188-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have two worst case calculations for space reservation, one that takes into
account splitting at every level when cow'ing down the btree, and another that
doesn't account for splitting at all.  The first is used everywhere, and the
second is used mostly for truncate.

However we also do not split when we're only changing an item, so for example
updating the inode item.  So the name for this helper is wrong, because it can
be used for in-place updates as well as for truncates.  Rename the helpers and
then use the smaller worst-case reservation for inode updates in a few places.

As a rule we still want to use the insert calculation when we can't be sure what
kind of operation is going to end up happening.  But for things like delayed
inode updates and file writes where we know there is going to be an existing
inode item we can use the smaller reservation.  Thanks,

Josef

