Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3C147232C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 09:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhLMIpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 03:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhLMIpW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 03:45:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF065C06173F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 00:45:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00FACCE0D07
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 08:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693B7C00446
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 08:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639385118;
        bh=jlDWUf7SgRfDrdtppxNLPTb79IxPfx/ESMnwkZ24O/s=;
        h=From:To:Subject:Date:From;
        b=aY4U0iZbCcX4n7TjinkvScspIOmDj6ZrQCQvjUPBGJe9ovpXjPCVMuEqkDaE3qhAK
         VPN9zjy3KRA5lehtnGxeNhaPehK/u5bmBZj+5u9E0HvOFTMcstsEc+5t865AkLT6h4
         uX9tDIDl/Nfo+yhgjWI31bmQoLxNzaVfTr/cfemNA7vnfBj7GzlVQcx66mlrbz7y6n
         WFxfOH7vXnbSJNo7AmhmOlZvY8AwWKYWBf3ZasyWno8zyMwSZ2jjXV+2porWwpNwfr
         KURSNMRUZ92Oq89JtDXDNuDTIOeZbKTxYMh646DNhxppyKTwpj1gDQfCvsegb1MJlw
         YcA09Y1pjcVLg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fixes for an error path when creating a subvolume
Date:   Mon, 13 Dec 2021 08:45:11 +0000
Message-Id: <cover.1639384875.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The following patches fix an error path when creating a subvolume, exposed
by generic/475.

Filipe Manana (3):
  btrfs: fix invalid delayed ref after subvolume creation failure
  btrfs: fix warning when freeing leaf after subvolume creation failure
  btrfs: skip transaction commit after failure to create subvolume

 fs/btrfs/ctree.c           | 17 +++++++++--------
 fs/btrfs/ctree.h           |  7 ++++++-
 fs/btrfs/extent-tree.c     | 13 +++++++------
 fs/btrfs/free-space-tree.c |  4 ++--
 fs/btrfs/ioctl.c           | 18 ++++++++++--------
 fs/btrfs/qgroup.c          |  3 ++-
 6 files changed, 36 insertions(+), 26 deletions(-)

-- 
2.33.0

