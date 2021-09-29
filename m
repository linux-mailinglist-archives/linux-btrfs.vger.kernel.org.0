Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F1941CA75
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346187AbhI2Qlc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 29 Sep 2021 12:41:32 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:58514 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbhI2Ql1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 12:41:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 84E083F439;
        Wed, 29 Sep 2021 18:39:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d2rqtarOBGFa; Wed, 29 Sep 2021 18:39:43 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 800B93F435;
        Wed, 29 Sep 2021 18:39:42 +0200 (CEST)
Received: from [192.168.0.126] (port=38112)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mVccP-000H4y-U4; Wed, 29 Sep 2021 18:39:41 +0200
Date:   Wed, 29 Sep 2021 18:39:40 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Andrea Gelmini <andrea.gelmini@gmail.com>, brandonh@wolfram.com
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <7df424c.4dc05cb1.17c326d0fd3@tnonline.net>
In-Reply-To: <CAK-xaQYo1vRi10ZY09q2=7oCTPy1s_i8-rZV_vyc0AMX1JOQLQ@mail.gmail.com>
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com> <CAK-xaQYo1vRi10ZY09q2=7oCTPy1s_i8-rZV_vyc0AMX1JOQLQ@mail.gmail.com>
Subject: Re: btrfs metadata has reserved 1T of extra space and balances
 don't reclaim it
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Andrea Gelmini <andrea.gelmini@gmail.com> -- Sent: 2021-09-29 - 17:18 ----

> Il giorno mer 29 set 2021 alle ore 04:41 Brandon Heisner
> <brandonh@wolfram.com> ha scritto:
>>
>> I have a server running CentOS 7 on 4.9.5-1.el7.elrepo.x86_64 #1 SMP Fri Jan 20 11:34:13 EST 2017 x86_64 x86_64 x86_64 GNU/Linux.  It is version locked to that kernel.  The metadata has reserved a full 1T of disk space, while only using ~38G.  I've tried to balance the metadata to reclaim that so it can be used for data, but it doesn't work and gives no errors.  It just says it balanced the chunks but the size doesn't change.  The metadata total is still growing as well, as it used to be 1.04 and now it is 1.08 with only about 10G more of metadata used.  I've tried doing balances up to 70 or 80 musage I think, and
> 
> Similar situation here.
> A 18TB single disk with one big snapraid parity file, and a lot of
> metadata allocated.
> I solved with:
> btrfs filesystem defrag -v -r -clzo  . (useless the compression, in my case)
> 
> So, just after a little bit from start  I saw already space reclaming.
> 
> In the end I fallback to exfat to avoid to keep re-reading/re-writing
> all data just to avoid "metadata waste".
> 
> Ciao,
> Gelma

Maybe autodefrag mount option might be helpful?

Your problem sounds like partially filled extents and not metadata related. Typical scenarios where that happens is with some databases and vm images. A file could allocate much more space than actuall data due to this. Use 'compsize' to determine this. 

