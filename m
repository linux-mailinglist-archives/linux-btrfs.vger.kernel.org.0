Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA65049DC11
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 08:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiA0H7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 02:59:16 -0500
Received: from out20-27.mail.aliyun.com ([115.124.20.27]:41451 "EHLO
        out20-27.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiA0H7Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 02:59:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1982423|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.772561-0.00209992-0.22534;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Mj.NOBI_1643270354;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Mj.NOBI_1643270354)
          by smtp.aliyun-inc.com(10.147.42.22);
          Thu, 27 Jan 2022 15:59:14 +0800
Date:   Thu, 27 Jan 2022 15:59:19 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "Apostolos B." <barz621@gmail.com>
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org
In-Reply-To: <75011941-2b38-f148-be37-a0ce8f1490fc@gmail.com>
References: <YfHXFfHMeqx4MowJ@zen> <75011941-2b38-f148-be37-a0ce8f1490fc@gmail.com>
Message-Id: <20220127155918.A4FD.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Why 'resize image size 128.0G ¡ú 1.8G'?

This 'No space left errors ' happen when 'resize image size 128.0G ¡ú 1.8G'.
and it will not happen when ''resize image size 128.0G ¡ú 2.0G'?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/01/27

> I don't have a bpftrace setup and sadly i cant do much debugging on this machine.
> 
> However i am sure its systemd that is involved in it. The few lines before the crash read:
> 
> ¦©¦Á¦Í 26 22:45:06 mainland systemd[1]: Stopped WPA supplicant.
> ¦©¦Á¦Í 26 22:45:06 mainland systemd-homework[14696]: Discovered used LUKS device /dev/mapper/home-toliz, and validated password.
> ¦©¦Á¦Í 26 22:45:07 mainland systemd-homework[14696]: Successfully re-activated LUKS device.
> ¦©¦Á¦Í 26 22:45:07 mainland systemd-homework[14696]: Discovered used loopback device /dev/loop0.
> ¦©¦Á¦Í 26 22:45:07 mainland systemd-homework[14696]: offset = 1048576, size = 137436856320, image = 137438953472
> ¦©¦Á¦Í 26 22:45:07 mainland systemd-homework[14696]: Ready to resize image size 128.0G ¡ú 1.8G, partition size 127.9G ¡ú 1.8G, file system size 127.9G ¡ú 1.7G.
> ¦©¦Á¦Í 26 22:45:07 mainland systemd-homework[14696]: Allocated additional 124.8G.
> ¦©¦Á¦Í 26 22:45:07 mainland kernel: BTRFS info (device dm-0): relocating block group 2177892352 flags data
> ¦©¦Á¦Í 26 22:45:07 mainland kernel: BTRFS info (device dm-0): relocating block group 1104150528 flags data
> ¦©¦Á¦Í 26 22:45:08 mainland systemd-homework[14696]: Failed to resize file system: Read-only file system
> ¦©¦Á¦Í 26 22:45:08 mainland kernel: BTRFS info (device dm-0): relocating block group 30408704 flags metadata|dup
> 
> On 27/1/22 01:19, Boris Burkov wrote:
> > On Thu, Jan 27, 2022 at 12:07:53AM +0200, Apostolos B. wrote:
> >>  ?This is what homectl inspect user reports:
> >>
> >>  ? Disk Size: 128.0G
> >>  ? Disk Usage: 3.8G (= 3.1%)
> >>  ? Disk Free: 124.0G (= 96.9%)


