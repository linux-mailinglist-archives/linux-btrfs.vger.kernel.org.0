Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BF2466AE0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348803AbhLBU1N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 15:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348738AbhLBU1N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 15:27:13 -0500
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Dec 2021 12:23:50 PST
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8BAC06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 12:23:50 -0800 (PST)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 1666024D;
        Thu,  2 Dec 2021 20:15:45 +0000 (UTC)
Date:   Fri, 3 Dec 2021 01:15:45 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Charlie Lin <CLIN@Rollins.edu>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Message-ID: <20211203011545.10173ba7@nvm>
In-Reply-To: <DM8P220MB03421444D486BBC29023BE74C1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
References: <DM8P220MB03421444D486BBC29023BE74C1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2 Dec 2021 19:33:34 +0000
Charlie Lin <CLIN@Rollins.edu> wrote:

> I have a partition, /dev/nvme0n1p8, that I can't mount on either Funtoo or
> Windows (using winbtrfs) (normally the partition is mounted on /home/shared)

Did you not try to mount and use it simultaneously in two running OSes (host
and VM guest)? That's not supported and will result in the filesystem getting
corrupted.

But in dmesg there are also issues with the FS on /dev/nvme0n1p6.

If Windows indeed runs in your Funtoo as a VM, then describe how exactly do
you launch the VM and what devices are passed to it (and how). Apart from not
mounting one FS at the same time, could it be that the guest OS had access to
other partitions as well?

-- 
With respect,
Roman
