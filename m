Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC6254581
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgH0MnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 08:43:02 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43024 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbgH0MmM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 08:42:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 35DDF1F66E;
        Thu, 27 Aug 2020 12:41:47 +0000 (UTC)
Date:   Thu, 27 Aug 2020 12:41:47 +0000
From:   Eric Wong <e@80x24.org>
To:     linux-btrfs@vger.kernel.org
Subject: adding new devices to degraded raid1
Message-ID: <20200827124147.GA16923@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I don't need to do it right away, but is it possible to add new
devices to a degraded raid1?

One thing I might do in the future is replace a broken big drive
with two small drives.  It may even be used to migrate to SSDs.

Since btrfs-replace only seems to do 1:1 replacements, and I
needed to physically remove an existing broken device to make
room for the replacements, could I do something like:

	mount -o degraded /mnt/foo
	btrfs device add small1 small2 /mnt/foo
	btrfs device remove broken /mnt/foo

?

Anyways, so far raid1 has been working great for me, but I have
some devices nearing 70K Power_On_Hours according to SMART

Thanks.
