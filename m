Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEEA4250EF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Oct 2021 12:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbhJGKZO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Oct 2021 06:25:14 -0400
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:47538 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhJGKZN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Oct 2021 06:25:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2218193|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0732081-0.00105519-0.925737;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.LVM8uEa_1633602198;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LVM8uEa_1633602198)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 07 Oct 2021 18:23:19 +0800
Date:   Thu, 07 Oct 2021 18:23:19 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: xfstest/generic/650 trigger btrfs deadlock
In-Reply-To: <20211007112032.A50B.409509F4@e16-tech.com>
References: <20211007112032.A50B.409509F4@e16-tech.com>
Message-Id: <20211007182319.AF0A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> xfstest/generic/650 trigger btrfs deadlock.
> 
> Linux kernel: 5.15.0-rc4
> 	https://kojipkgs.fedoraproject.org/packages/kernel/5.15.0/0.rc4.33.eln112/
> 
> Reproduce frequency: about 50%
> 
> This is the first time that we tested xfstest/generic/650, and it is the
> first time that we tested kernel 5.15.x too. so it maybe a known problem
> of btrfs.
> 
> When the deadlock happen, /mnt/test is fully used.
> /dev/sdb1               btrfs   14G   14G     0 100% /mnt/test

When /mnt/test is NOT fully used (although nearly full ),
this deadlock seems to NOT happen.

#df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb1               btrfs   14G   14G   72K 100% /mnt/test

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/07


