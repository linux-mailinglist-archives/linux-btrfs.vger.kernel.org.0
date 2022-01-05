Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0F6484F5B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 09:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiAEIaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 03:30:20 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:35523 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbiAEIaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 03:30:19 -0500
X-Sender-Id: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3242A861B6C
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 08:30:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D4E05861E10
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 08:30:16 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.65.167 (trex/6.4.3);
        Wed, 05 Jan 2022 08:30:17 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
X-MailChannels-Auth-Id: dreamhost
X-Bitter-Arch: 7985effa6e5118b1_1641371417075_2437413074
X-MC-Loop-Signature: 1641371417075:3729910140
X-MC-Ingress-Time: 1641371417075
Received: from meinmachine.hsd1.ca.comcast.net (c-73-92-232-183.hsd1.ca.comcast.net [73.92.232.183])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sahil.kang@asilaycomputing.com)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4JTN2w49zLz25
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=asilaycomputing.com;
        s=asilaycomputing.com; t=1641371416;
        bh=u7yJAXRdLnM+WUUSfqjD/M9b2iQ=;
        h=From:To:Subject:Date:Content-Transfer-Encoding;
        b=psnWxmpIJ7tHVXSR5WpCan6B1q2JpFYbe1kEd2OvFqRjjVAdM6QLj2p3yeoIjr3G7
         1gUc3+U4PtSDEqkp/Bn5XEBeVHCY+FWxPxcyqfUJp3nio2tyPXE1B2jJnSkTjdgOJs
         CKOXras71846shdrjNJ6MgMn9RooioUxJzutlaJI=
From:   Sahil Kang <sahil.kang@asilaycomputing.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/1] btrfs: reuse existing pointers from btrfs_ioctl
Date:   Wed,  5 Jan 2022 00:30:05 -0800
Message-Id: <20220105083006.2793559-1-sahil.kang@asilaycomputing.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a small cleanup that reuses some of the existing pointers and
removes the duplicated dereferencing.

There are other subfunctions that have similar/identical dereferencing
as the enclosing btrfs_ioctl, but I'm not sure if changing those is
welcomed since it would require changing their arg count. Right now,
all of the sub ioctl functions have essentially the same signature.

For example, reusing the pointers for btrfs_ioctl_set_fslabel would
require passing in *fs_info and *root, in addition to its current
args.

Sahil Kang (1):
  btrfs: reuse existing pointers from btrfs_ioctl

 fs/btrfs/ioctl.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

-- 
Sahil

