Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED69B28CFF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388482AbgJMONS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 10:13:18 -0400
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:39934 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388308AbgJMONS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 10:13:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1250707|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.050181-0.00194984-0.947869;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.IihX.eo_1602598395;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.IihX.eo_1602598395)
          by smtp.aliyun-inc.com(10.147.42.253);
          Tue, 13 Oct 2020 22:13:15 +0800
Date:   Tue, 13 Oct 2020 22:13:18 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: dbench throughput on xfs over hardware limit(6Gb/s)
In-Reply-To: <20201013220950.F09C.409509F4@e16-tech.com>
References: <20201013220950.F09C.409509F4@e16-tech.com>
Message-Id: <20201013221318.F0A4.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.01 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Sorrry.  This should be send to linux-xfs@vger.kernel.org.

> Hi,
> 
> dbench throughput on xfs over hardware limit(6Gb/s=750MB/s).
> 
> Is this a bug or some feature of performance optimization?
> 
> Disk: TOSHIBA  PX05SMQ040
> This is a 12Gb/s SAS SSD disk, but connect to 6Gb/s SAS HBA,
> so it works with 6Gb/s.
> 
> dbench -s -t 60 -D /xfs 32
> #Throughput 884.406 MB/sec (sync open)
> 
> dbench -s -t 60 -D /xfs 1
> #Throughput 149.172 MB/sec (sync open)
> 
> we test the same disk with ext4 filesystem, 
> the throughput is very close to, but less than the hardware limit.
> 
> dbench -s -t 60 -D /ext4 32
> #Throughput 740.95 MB/sec (sync open)
> 
> dbench -s -t 60 -D /ext4 1
> #Throughput 124.67 MB/sec (sync open)
> 
> linux kernel: 5.4.70, 5.9.0
> 
> Best Regards
> 王玉贵
> 2020/10/13
> 
> --------------------------------------
> 北京京垓科技有限公司
> 王玉贵	wangyugui@e16-tech.com
> 电话：+86-136-71123776

--------------------------------------
北京京垓科技有限公司
王玉贵	wangyugui@e16-tech.com
电话：+86-136-71123776

