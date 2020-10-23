Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7F4297098
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460310AbgJWNeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:34:09 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:41281 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374889AbgJWNeJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:34:09 -0400
X-Greylist: delayed 1416 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 09:34:08 EDT
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.93.0.4)
        id 1kVwpo-005AEY-5g; Fri, 23 Oct 2020 14:10:20 +0100
MIME-Version: 1.0
Date:   Fri, 23 Oct 2020 14:10:18 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
In-Reply-To: <20201023203742.B13F.409509F4@e16-tech.com>
References: <20201023101145.GB19860@angband.pl>
 <d7ee1c25-ceea-0471-9702-0622a5ef4453@gmx.com>
 <20201023203742.B13F.409509F4@e16-tech.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <689bac5dadacdbec2c3b70399a5e0e50@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-10-23 13:37, Wang Yugui wrote:
> Hi,
> 
> Can we add the feature of 'Storage Tiering' to btrfs for these use 
> cases?
> 
> 1) use faster tier firstly for metadata
> 
> 2) only the subvol with higher tier can save data to
>     the higher tier disk?
> 
> 3) use faster tier firstly for mirror selection of RAID1/RAID10

I'd support user-configurable tiering by specifying which device IDs are 
allowed to be used for

a) storing metadata
b) reading data from RAID1/RAID10

that would fit into both this patch and Anand's read policy patchset. It 
could be a mount option, sysfs tunable and/or btrfs-device command.

e.g. for sysfs
/sys/fs/btrfs/6e2797f3-d0ab-4aa1-b262-c2395fd0626e/devices/sdb2/prio_metadata_store 
[0..15]
/sys/fs/btrfs/6e2797f3-d0ab-4aa1-b262-c2395fd0626e/devices/sdb2/prio_metadata_read 
[0..15]
/sys/fs/btrfs/6e2797f3-d0ab-4aa1-b262-c2395fd0626e/devices/sdb2/prio_data_read 
[0..15]

Getting the user to specify the devices' priorities would be more 
reliable than looking at the rotational attribute.

-- 
Steven Davies
