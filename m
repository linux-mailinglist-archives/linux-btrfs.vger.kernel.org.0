Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8EB434BF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTNWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 09:22:35 -0400
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:51940 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTNWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 09:22:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.265949|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.146138-0.00236127-0.851501;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Lf-zQZ._1634736018;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Lf-zQZ._1634736018)
          by smtp.aliyun-inc.com(10.147.41.121);
          Wed, 20 Oct 2021 21:20:18 +0800
Date:   Wed, 20 Oct 2021 21:20:22 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: xfstest/generic/650 trigger btrfs deadlock
In-Reply-To: <20211007182319.AF0A.409509F4@e16-tech.com>
References: <20211007112032.A50B.409509F4@e16-tech.com> <20211007182319.AF0A.409509F4@e16-tech.com>
Message-Id: <20211020212022.E90E.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> > xfstest/generic/650 trigger btrfs deadlock.
> > 
> > Linux kernel: 5.15.0-rc4
> > 	https://kojipkgs.fedoraproject.org/packages/kernel/5.15.0/0.rc4.33.eln112/
> > 
> > Reproduce frequency: about 50%
> > 
> > This is the first time that we tested xfstest/generic/650, and it is the
> > first time that we tested kernel 5.15.x too. so it maybe a known problem
> > of btrfs.
> > 
> > When the deadlock happen, /mnt/test is fully used.
> > /dev/sdb1               btrfs   14G   14G     0 100% /mnt/test
> 
> When /mnt/test is NOT fully used (although nearly full ),
> this deadlock seems to NOT happen.
> 
> #df -h
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sdb1               btrfs   14G   14G   72K 100% /mnt/test

This dead happened when Avail >40% too. (linux 5.15 rc6)

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/20


