Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17682E7F9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 12:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgLaLRg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 06:17:36 -0500
Received: from out20-109.mail.aliyun.com ([115.124.20.109]:38231 "EHLO
        out20-109.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaLRg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 06:17:36 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1393194|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0155216-0.00462158-0.979857;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JDpFSky_1609413413;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JDpFSky_1609413413)
          by smtp.aliyun-inc.com(10.147.41.137);
          Thu, 31 Dec 2020 19:16:53 +0800
Date:   Thu, 31 Dec 2020 19:16:57 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     shngmao@gmail.com
Subject: Re: [PATCH 3/3] btrfs-progs: add TLS arguments to send/receive
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20201225045037.185537-3-shngmao@gmail.com>
References: <20201225045037.185537-1-shngmao@gmail.com> <20201225045037.185537-3-shngmao@gmail.com>
Message-Id: <20201231191656.8816.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Sheng Mao

some feedback.

1, can we use 'listen-addr' for sever side, and 'conn-addr' for client
side?

2, can we support '--tls-mode none' for tcp without TLS, 
and then change 'tls-port' to 'tcp-port'? 

Is there some boost performance for tcp without TLS too?


> +--tls-addr <url>::
> +Address to listen on. It can be an IP address or a domain name.
> +
> +--tls-port <port>::
> +The local port of the TLS connection.
> +
> +--tls-key <file>::
> +Use the key from file; otherwise read key from stdin. Key file is first parsed
> +as PEM format; if parsing fails, file content is treated as binary key.
> +
> +--tls-mode <mode>::
> +Use tls_12_128_gcm, tls_13_128_gcm, tls_12_256_gcm.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2020/12/31


