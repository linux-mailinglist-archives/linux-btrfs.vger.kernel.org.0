Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1451A118126
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 08:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfLJHOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 02:14:06 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:43283 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbfLJHOG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 02:14:06 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 47XBBK5cSYz8v9M;
        Tue, 10 Dec 2019 08:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1575962041; bh=7cszWZ7Q0ORNPHMGgwVGRFyQUy8WWpm/4EtJk9AzY38=;
        h=From:To:Cc:Subject:Date:From:To:CC:Subject;
        b=ffWpEabED3olKElp3CndHIPb85yxKiyo3X65XCo5vF+e6Ua2iLVEVchdcCMNA+bdg
         HC8C6fVzuO/niS/8xwiIhL1YGhCJEbnvuWJudx0o7Uho/R4esaNUXhjT8T4JH7GtUF
         I21VPQIbsJF7OIw7SM2x8XGGu+RRjvZzTwf7zC7BTAfYHovmKIxlFSt4XDG6oD8Leo
         FVtCOmEMW1C1oUyL9fHxBT4Ioi0MJUuyNR5ZgOvzKtAoZZ/aI5pqDMIcqvFR4dxt/2
         DExxQOXmrDIkWNEjvlpDDaSimZ3Vfl0kdNjkd9pwHPMULovKS47Xp4TIW2dIUcpyAW
         qxVoISTb3Mk4w==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.22.146
Received: from localhost.localdomain (firewall.henke.stw.uni-erlangen.de [131.188.22.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/TFdXsN4Ioj3Yztg/XNi6pl7w0ZglNjeE=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 47XBBH3Jy2z8v5Q;
        Tue, 10 Dec 2019 08:13:59 +0100 (CET)
From:   Sebastian <sebastian.scherbel@fau.de>
To:     dsterba@suse.com
Cc:     josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Sebastian Scherbel <sebastian.scherbel@fau.de>
Subject: [PATCH 0/5] btrfs: code cleanup
Date:   Tue, 10 Dec 2019 08:13:52 +0100
Message-Id: <20191210071357.5323-1-sebastian.scherbel@fau.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sebastian Scherbel <sebastian.scherbel@fau.de>

This patch series changes several instances in btrfs where the coding style
is not in line with the Linux kernel guidelines to improve readability.

Sebastian Scherbel (5):
  fs_btrfs_sysfs: code cleanup
  fs_btrfs_struct-funcs: code cleanup
  fs_btrfs_ref-verify: code cleanup
  fs_btrfs_qgroup: code cleanup
  fs_btrfs_block-group: code cleanup

 fs/btrfs/block-group.c  | 21 ++++++++++------
 fs/btrfs/block-group.h  |  8 +++---
 fs/btrfs/qgroup.c       | 54 +++++++++++++++++++++++------------------
 fs/btrfs/qgroup.h       | 12 ++++-----
 fs/btrfs/ref-verify.c   |  6 ++---
 fs/btrfs/struct-funcs.c |  5 ++--
 fs/btrfs/sysfs.c        | 33 +++++++++++++++++++------
 fs/btrfs/sysfs.h        |  5 ++--
 8 files changed, 89 insertions(+), 55 deletions(-)

-- 
2.20.1

