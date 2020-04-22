Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9631B396C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDVHwI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 03:52:08 -0400
Received: from lists.nic.cz ([217.31.204.67]:46104 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgDVHwI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 03:52:08 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 3D20613F7F8;
        Wed, 22 Apr 2020 09:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587541926; bh=O7BuoCFle2WiUETAFFYLyXYIkbkXV/0mKewlKtPKJtw=;
        h=Date:From:To;
        b=QStaCGZbcc8YI4CQ8hvIfQ/WYIAM6pY1wLZbDBWkw7AggzzbvXFE58z6s1V6GeFQh
         4Zw3SLjV0qIGy9sRl7IKRToy4DMf4WLHocDUxiap6E992Lp/x3jxS+dlxxLLmgNXvv
         +D4YJLSjjRGb4ThhYo4Ephlnm6uUPbXta3VVQPVc=
Date:   Wed, 22 Apr 2020 09:52:05 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Subject: Re: [PATCH U-BOOT 00/26] fs: btrfs: Re-implement btrfs support
 using the more widely used extent buffer base code
Message-ID: <20200422095205.112a9a79@nic.cz>
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am testing compilation from the github repository.

Another problem is that in the cleanup patch you have removed
btrfs_list_subvols functoin, which is used by cmd/btrfs.c to list
subvolumes. So Turris Mox and Turris Omnia with their default defconfig
do not compile now.

Marek
