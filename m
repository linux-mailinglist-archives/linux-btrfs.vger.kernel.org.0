Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7C22D54F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 08:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgGYGCc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 02:02:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37880 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgGYGCb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 02:02:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A947B1F5AE;
        Sat, 25 Jul 2020 06:02:31 +0000 (UTC)
Date:   Sat, 25 Jul 2020 06:02:31 +0000
From:   Eric Wong <e@80x24.org>
To:     linux-btrfs@vger.kernel.org
Subject: mixing raid1 and raid0?
Message-ID: <20200725055728.GA6238@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all, I've started using btrfs recently with old HDDs of
various sizes in a btrfs raid1 pool.  It seems pretty good from
a flexibility and redundancy standpoint.

However, things like temporary files, caches, etc. don't need to
be raid1, and raid0 might allow me to reduce wear on HDDs; so
I'd like to make part of it raid0 while keeping most of it raid1.

If my btrfs is mounted as /mnt/btrfs, would the following do
what I want?

  btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt/btrfs/precious
  btrfs balance start -dconvert=raid0 -mconvert=raid0 /mnt/btrfs/junk

Or should I make a separate FS for temporary and disposable
raid0 data?

Thanks
