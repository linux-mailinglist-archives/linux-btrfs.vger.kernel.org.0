Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5362970DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750088AbgJWNtg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:49:36 -0400
Received: from out20-75.mail.aliyun.com ([115.124.20.75]:46767 "EHLO
        out20-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750027AbgJWNtg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:49:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04534968|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0421483-0.000651275-0.9572;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.InSvMvf_1603460972;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.InSvMvf_1603460972)
          by smtp.aliyun-inc.com(10.147.43.95);
          Fri, 23 Oct 2020 21:49:33 +0800
Date:   Fri, 23 Oct 2020 21:49:38 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Steven Davies <btrfs-list@steev.me.uk>
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <689bac5dadacdbec2c3b70399a5e0e50@steev.me.uk>
References: <20201023203742.B13F.409509F4@e16-tech.com> <689bac5dadacdbec2c3b70399a5e0e50@steev.me.uk>
Message-Id: <20201023214935.E22B.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.01 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

We define 'int tier' for different device, such as
* dax=1
* NVMe
* SSD
* rotational=1

but in most case, just two tier of them are used at the same time,
so we use them just as two tier(faster tier, slower tier).

for phase1, we support
1) use faster tier firstly for metadata
3) use faster tier firstly for mirror selection of RAID1/RAID10

and in phase2(TODO), we support
2) let some subvol save data to the faster tier disk

for metadata, the policy is
1) faster-tier-firstly (default)
2) faster-tier-only

for data, the policy is
4) slower-tier-firstly(default)
3) slower-tier-only
1) faster-tier-firstly(phase2 TODO)
2) faster-tier-only(phase2 TODO)

Now we are using metadata profile(RAID type) and data profile(RAID type),
in phase2, we change the name of them  to 'faster tier profile' and 
'lower tier profile'.

The key is 'in most case, just two tier are used at the same time'.
so we can support the flowing case in phase1 without user config.
1) use faster tier firstly for metadata
3) use faster tier firstly for mirror selection of RAID1/RAID10

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2020/10/23


> On 2020-10-23 13:37, Wang Yugui wrote:
> > Hi,
> >
> > Can we add the feature of 'Storage Tiering' to btrfs for these use
> > cases?
> >
> > 1) use faster tier firstly for metadata
> >
> > 2) only the subvol with higher tier can save data to
> >     the higher tier disk?
> >
> > 3) use faster tier firstly for mirror selection of RAID1/RAID10
> 
> I'd support user-configurable tiering by specifying which device IDs are allowed to be used for
> 
> a) storing metadata
> b) reading data from RAID1/RAID10
> 
> that would fit into both this patch and Anand's read policy patchset. It could be a mount option, sysfs tunable and/or btrfs-device command.
> 
> e.g. for sysfs
> /sys/fs/btrfs/6e2797f3-d0ab-4aa1-b262-c2395fd0626e/devices/sdb2/prio_metadata_store [0..15]
> /sys/fs/btrfs/6e2797f3-d0ab-4aa1-b262-c2395fd0626e/devices/sdb2/prio_metadata_read [0..15]
> /sys/fs/btrfs/6e2797f3-d0ab-4aa1-b262-c2395fd0626e/devices/sdb2/prio_data_read [0..15]
> 
> Getting the user to specify the devices' priorities would be more reliable than looking at the rotational attribute.



