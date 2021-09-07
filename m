Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9F402B85
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbhIGPRA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 11:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345005AbhIGPQ7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 11:16:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C737B61107
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631027753;
        bh=xTQ47EC5/1IwwhZiki25FVJvLHtto0M1uXXIYhWPu8A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pH0XiuA01htC/xBdpnfT6EyXHs1bVeasTbrzSPKvINV0RsoCtypmwbF5Of6UDhmrY
         tL6zSABJnRMJv+Wq4eiRkbezLLI9Cr0A234U+pe2n3AWnjK1swcLcFp3Z7daOKrRIi
         1jsl/7ED3l2yAadzyHbkZ6XaSAUULAwonG3ziRS5QPgkkRL4ZTpmwAv6Bdo3gPswIP
         loYP7DURD1Sks27rHQPdLt88T/4PzyAYxGEPNFuNQfY+CnSjTybg+awD8p0LwsGeF7
         MxKva8I2zSPWcgJWLkJVgZatwcRI705VzR/KuNFoGAV1QD7oxaWLllbHMiQgcaPMjL
         otnnS7cIOdT8A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix mount/remount failure due to past device flush errors
Date:   Tue,  7 Sep 2021 16:15:48 +0100
Message-Id: <cover.1631026981.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f9dfa4183e5c84f71c3f50d504e3d6cdc43b0ae9.1630919202.git.fdmanana@suse.com>
References: <f9dfa4183e5c84f71c3f50d504e3d6cdc43b0ae9.1630919202.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We currently fail mounting and remounting a fs from RO to RW if we had a
device flush error from a past mount. This causes mount/remount when
such errors were transient and don't happen anymore. One example is during
tests that explicitly trigger IO failure, such as the new generic/648 or,
much less frequently, generic/019 and generic/475. The first patch has
more details in its changelog.

V2: Rework to use instead an additional argument to btrfs_check_rw_degradable()
    and solve the same problem for remounts from RO to RW mode. Also added the
    second patch.

Filipe Manana (2):
  btrfs: fix mount failure due to past and transient device flush error
  btrfs: remove the failing device argument from btrfs_check_rw_degradable()

 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/super.c   |  2 +-
 fs/btrfs/volumes.c | 32 +++++++++++++++++++++-----------
 fs/btrfs/volumes.h |  2 +-
 4 files changed, 25 insertions(+), 15 deletions(-)

-- 
2.33.0

