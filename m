Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEA12E8333
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jan 2021 06:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbhAAFyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jan 2021 00:54:32 -0500
Received: from out20-13.mail.aliyun.com ([115.124.20.13]:51557 "EHLO
        out20-13.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbhAAFyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jan 2021 00:54:31 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05091283|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00753574-0.00274136-0.989723;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JE4-5Qg_1609480426;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JE4-5Qg_1609480426)
          by smtp.aliyun-inc.com(10.147.42.253);
          Fri, 01 Jan 2021 13:53:46 +0800
Date:   Fri, 01 Jan 2021 13:53:51 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Sheng Mao <shngmao@gmail.com>
Subject: Re: [PATCH 3/3] btrfs-progs: add TLS arguments to send/receive
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <CA733030-4654-4D1D-9A29-5199178B0C79@gmail.com>
References: <20201231191656.8816.409509F4@e16-tech.com> <CA733030-4654-4D1D-9A29-5199178B0C79@gmail.com>
Message-Id: <20210101135350.AD49.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Sheng

> Hi Yugui,
> 
> Thank you for the feedback!
> 
> 1. Yes, we can do that. The reason why I use ¡ªtls-addr on both sides is to introduce least vocabulary for users.
> 2. I don¡¯t have a 10Gpbs NIC to have a thorough benchmark on TLS vs raw sockets. The flame graph shows 
> decrypt_skb_update (related to TLS decoding) takes about 3.5% of CPU time for my 1Gbps setup. The transfer 
> saturates the bandwidth. Do you have any 10Gbps devices? Would you mind to help me benchmarking after 
> introducing ¡ªtls-mode none?

Yes. We can benchmark this for 10G Gbps or 40Gbs.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/01/01


> Thank you! Happy new year!
> 
> Regards,
> Sheng
> 
> > On Dec 31, 2020, at 04:16, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > 
> > Hi, Sheng Mao
> > 
> > some feedback.
> > 
> > 1, can we use 'listen-addr' for sever side, and 'conn-addr' for client
> > side?
> > 
> > 2, can we support '--tls-mode none' for tcp without TLS, 
> > and then change 'tls-port' to 'tcp-port'? 
> > 
> > Is there some boost performance for tcp without TLS too?
> > 
> > 
> >> +--tls-addr <url>::
> >> +Address to listen on. It can be an IP address or a domain name.
> >> +
> >> +--tls-port <port>::
> >> +The local port of the TLS connection.
> >> +
> >> +--tls-key <file>::
> >> +Use the key from file; otherwise read key from stdin. Key file is first parsed
> >> +as PEM format; if parsing fails, file content is treated as binary key.
> >> +
> >> +--tls-mode <mode>::
> >> +Use tls_12_128_gcm, tls_13_128_gcm, tls_12_256_gcm.
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2020/12/31
> > 
> > 


