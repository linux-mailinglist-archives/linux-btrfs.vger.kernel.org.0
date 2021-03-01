Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0509327AB3
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 10:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhCAJ11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 04:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233851AbhCAJ10 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 04:27:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59C3F64E07
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Mar 2021 09:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614590805;
        bh=dYgRNnTTHSst2SOLy2zxHo8s7neqXWdUDvTwbm16MSU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dfZeM4cbIJ3uB1YUrq9rkJAHZo8BB0cPGwOwgq8wu8fHFvmqIB+NBLHP9wIAGAu68
         oP9Sd7ySY4nEIi6DXpXYX8LW+dHod+RxLdAE2kfzINkDNioN4aqql56WebYOhbavjB
         ZOcGLxn1eZ/6Hw5tYeNxUN1KB9s5d0pu/pLDnXSXQwYPy4gZuitg1La26ftZW9Xhwk
         ur5efDIbSqLqRT5pYdZz91vHFOKxB7lSZEIK5Vj5pgURaNIlJzvKeGuMrVw7v+5oVl
         ClHBuie7nPY/K/3eAWa4ByK/WvPnq0X4RBoNqyYVzlzC9fM41eO001aGeNoMcEmgZf
         ny9SQReCrwDGA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: add btree read ahead for send operations
Date:   Mon,  1 Mar 2021 09:26:41 +0000
Message-Id: <cover.1614590582.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1614351671.git.fdmanana@suse.com>
References: <cover.1614351671.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset adds btree read ahead for full and incremental send operations,
which results in some nice speedups. Test and results are mentioned in the
change log of each patch.

V2: Updated second patch, for incremental sends, to limit readahead to avoid
    too many reads in parallel and disturbing other workloads running in
    parallel, and without causing a drop in the gains. Updated change logs.

Filipe Manana (2):
  btrfs: add btree read ahead for full send operations
  btrfs: add btree read ahead for incremental send operations

 fs/btrfs/send.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

-- 
2.28.0

