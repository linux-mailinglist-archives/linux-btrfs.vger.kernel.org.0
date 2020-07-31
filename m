Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7852233C7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 02:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgGaAQw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 20:16:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53642 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgGaAQw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 20:16:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6B7931F5AE;
        Fri, 31 Jul 2020 00:16:52 +0000 (UTC)
Date:   Fri, 31 Jul 2020 00:16:52 +0000
From:   Eric Wong <e@80x24.org>
To:     linux-btrfs@vger.kernel.org
Subject: raid1 with several old drives and a big new one
Message-ID: <20200731001652.GA28434@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Say I have three ancient 2TB HDDs and one new 6TB HDD, is there
a way I can ensure one raid1 copy of the data stays on the new
6TB HDD?

I expect the 2TB HDDs to fail sooner than the 6TB HDD given
their age (>5 years).

The devid balance filter only affects data which already exists
on the device, so that isn't suitable for this, right?

Thanks in advance.
