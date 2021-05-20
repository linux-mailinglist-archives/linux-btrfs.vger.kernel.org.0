Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F75738AE0F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhETMXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 08:23:51 -0400
Received: from out20-49.mail.aliyun.com ([115.124.20.49]:38877 "EHLO
        out20-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhETMXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 08:23:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06503063|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0421899-0.0011781-0.956632;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KGF50wa_1621513338;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KGF50wa_1621513338)
          by smtp.aliyun-inc.com(10.147.41.138);
          Thu, 20 May 2021 20:22:18 +0800
Date:   Thu, 20 May 2021 20:22:23 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Octavia Togami <octavia.togami@gmail.com>
Subject: Re: btrfs check: free space cache has more free space than block group item
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <CAHPNGST+ZuZOg+TXab-DXLKdAiDtN5e=pdarYA7rb0P0NYzA2Q@mail.gmail.com>
References: <CAHPNGSTFw1rPFpnWF9OHzqKnxUSijYYUYtsenhj5YuNaSTGBgA@mail.gmail.com> <CAHPNGST+ZuZOg+TXab-DXLKdAiDtN5e=pdarYA7rb0P0NYzA2Q@mail.gmail.com>
Message-Id: <20210520202222.40B0.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> Apologies, I missed the required commands, output from them is as
> follows & attached.
> 
> $ uname -a
> Linux data-acorn-token 5.12.5-arch1-1 #1 SMP PREEMPT Wed, 19 May 2021
> 10:32:40 +0000 x86_64 GNU/Linux
> $ btrfs --version
> btrfs-progs v5.12.1
> $ sudo btrfs fi show
> Label: 'Parallel eXceed'  uuid: 2d80eaf7-6588-41b3-add3-1d4a3a2996eb
>         Total devices 2 FS bytes used 281.77GiB
>         devid    1 size 317.71GiB used 317.71GiB path /dev/nvme0n1p6
>         *** Some devices missing

Firstly, we need to know why '*** Some devices missing' happened? 
the output of 'blkid' maybe helpful.

Then, 'btrfs check' does not support the filesystem with multiple device?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/05/20

