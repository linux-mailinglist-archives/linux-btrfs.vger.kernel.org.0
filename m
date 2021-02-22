Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19072322173
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 22:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBVVce (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 16:32:34 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:56619 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231961AbhBVVca (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 16:32:30 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-34.iol.local with ESMTPA
        id EInxl5gOr5WrZEInxlGr7f; Mon, 22 Feb 2021 22:31:45 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614029505; bh=71TRW0vSbHklsBVZ3u+lVrWRWAKiktqHdGEvOhvFRHY=;
        h=From;
        b=Inv/13vsJXsCbNe5cx6qYSTEOxMXYki7XMXtGC6uTYvQrF50ObYFi+uTgqrJMsZcM
         zomF5xNDBJ5/op/U01I/QN9FfDnE22pioq+ozCZLMWHMA3s1EGM8lz1ucN39myZ3U5
         /FTzrqM9D5YRaJCOCn2er2FHHaplRYCIoXzh/2yiQlYHLR2KL0GCi2ZYSgRGlotqIN
         BCTef0NpmaTHpSW6ldJRkuOHBYDdzY4js9cd9hzUGVjZuEDXNdldw6mO04U8w79D5m
         PlS77a0eu0aOGIFdVTrBAZxusqpPR9L3llLZKLWOJWeJeOOXMao2ZIQBkosDICvwTT
         wur2KFekQVwKQ==
X-CNFS-Analysis: v=2.4 cv=W4/96Tak c=1 sm=1 tr=0 ts=603422c1 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=BWv4TUB0bzycV4xkKIQA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 0/2] btrfs-progs: allocation_hint disk property
Date:   Mon, 22 Feb 2021 22:31:43 +0100
Message-Id: <cover.1614029416.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDehX7XwPEJ3EbDtz9KDmwB/KFflojmAjkSDYtRM0kESZMtaYqXAvKSwKGDd17WURcK+aYnvtjWvYvX/IZLUbh7y1nEBvL4BwL8NYCRNOtgUPG2hY/J0
 Vo7KNH/4d9xLLsImIbAnM9FXK/h+dj3asQovw6GxF/litU7l0NwP+JBQHCgR00P4rg0ZkfQX3oofbSs2SBEsXcK4y1H5dHmOynrhDmXEdXr171HAu5PI7Mzf
 Kn286SFAbenWmgcS4FwPO77MHO31YuTbYPorqpohe34wwvmCi14YqK2cA5ZEngbY
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>


This patches set is the userspace portion of the serie
"[PATCH V7] btrfs: allocation_hint mode".

Look this patches set for further information.

G.Baroncelli


--
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5






Goffredo Baroncelli (2):
  btrfs-progs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
  btrfs-progs: new "allocation_hint" property.

 ioctl.h               |  39 ++++++++++
 kernel-shared/ctree.h |  15 ++++
 props.c               | 171 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

-- 
2.30.0

