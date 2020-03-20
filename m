Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A4118C5C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 04:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCTD3e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 23:29:34 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.113]:48369 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726103AbgCTD3e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 23:29:34 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 1CAF5400C9C4E
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 22:29:33 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id F8LljHkIDEfyqF8LljHjTr; Thu, 19 Mar 2020 22:29:33 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bW2qkHp+x1DgJOib89JQcZzD7Ru9zdz+9LqfpstO11A=; b=b6iabjKGk2IbnWSKsFSQJIF70f
        PXksSjggzrTtzcK+yvGMbg5S+lb35m6J55vl5PDdh6tPtw5fdySI20VygYIMlcuWtHZW6fN2DCSdt
        VPL75Qt74I3QI5b75H0cAdOZ1vfYos+Svt9vEUVZSCctf7van98Yrk0J+slrGcJRFiUHxnGumtz6c
        IGbghdSKOJ4/Sahsh6F+4OpYbGAZA4c/JQI2Ot9sMdMkqs2rmPSFN/zT6dFgJTZXarz5ma5Mbn7+j
        6OTqPn76OWWSvGKByIyLQp2qCRuQqTlUASb1fa3gQ8GUj3Pofd/NQxT7hBFX+uDS5K4RpTE4lVKEp
        vE6b16RQ==;
Received: from [191.249.66.103] (port=39060 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jF8Lk-0023Ig-FK; Fri, 20 Mar 2020 00:29:32 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2 0/2] btrfs-progs: Auto resize fs after device replace
Date:   Fri, 20 Mar 2020 00:32:25 -0300
Message-Id: <20200320033227.3721-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.66.103
X-Source-L: No
X-Exim-ID: 1jF8Lk-0023Ig-FK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:39060
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Changes from v1:
* Reworded the help message and the docs telling the user that the fs will be
  resized to it's max size (suggested by Wenruo)
* Added a warning message saying that the resize failed, asking the user to
  resize manually. (suggested by Wenruo)

Both changes were done only in patch 0002.

Anand suggested this job to be done in kernel side, atomically, but as I
received a good review from Wenruo I decided to send a v2 of this patchset.

Please review, thanks!

Original cover-letter[1]:
These two patches make possible to resize the fs after a successful replace
finishes. The flag -a is responsible for doing it (-r is already use, so -a in
this context means "automatically").

The first patch just moves the resize rationale to utils.c and the second patch
adds the flag an calls resize if -a is informed replace finishes successfully.

Please review!

[1]: https://lore.kernel.org/linux-btrfs/20200307224516.16315-1-marcos@mpdesouza.com/T/#t

Marcos Paulo de Souza (2):
  btrfs-progs: Move resize into functionaly into utils.c
  btrfs-progs: replace: New argument to resize the fs after replace

 Documentation/btrfs-replace.asciidoc |  5 ++-
 cmds/filesystem.c                    | 58 +--------------------------
 cmds/replace.c                       | 21 +++++++++-
 common/utils.c                       | 60 ++++++++++++++++++++++++++++
 common/utils.h                       |  1 +
 5 files changed, 86 insertions(+), 59 deletions(-)

-- 
2.25.0

