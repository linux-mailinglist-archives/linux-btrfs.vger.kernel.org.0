Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2AD330531
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 00:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhCGX0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 18:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhCGX0e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 18:26:34 -0500
X-Greylist: delayed 2227 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 Mar 2021 15:26:31 PST
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED966C06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KsV2IRLZ6IiMSMV61CAybk2QRGWvgN0d6wpm3fCF0xY=; b=Zki8sH9p++OIsVzEh8XOzOUu5h
        hB2Z0FNHQy3CQJoTC7okbK54wOHA2Y8U+HlC50J1Sf0At9g/busbnAsMNWGcMx23UUmIjXHzguzJX
        L+eoyby1Je5DMxHsVb9Bn+eyIbJRh52nTqY+eLE4OrKL45T+1H+4FOMXEeyfvQFmj8pqx+X3iSC+W
        gFdwjW15uO12Rxnu+pEYC+XDNVJJDUdnbftvrRsfFFEqpEjMYd+LlMH4yJY6cP2yJ8Bf5BPabzN1A
        vHydRyRWwzkLLTchVX9spVSwjxevzQOTAPZorNTGkm65IRttkABTvJBoLkl+6itloeYJVeSm9wb2j
        qVG+LxKA==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1lJ2DA-0007Ms-SM
        for linux-btrfs@vger.kernel.org; Sun, 07 Mar 2021 22:49:21 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 1CDFA14920177; Mon,  8 Mar 2021 07:49:16 +0900 (JST)
Date:   Mon, 8 Mar 2021 07:49:16 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: btrfs fails to mount on kernel 5.11.4 but works on 5.10.19
Message-ID: <YEVYbMdXdPzklSVc@bulldog.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear all

(please cc)

not sure this is the right mailing list, but I cannot boot into 5.11.4 
it gives me
	devid 9 uui .....
	failed to read the system array: -2
	open_ctree failed
(only partial, typed in from photo)

OTOH, 5.10.19 boots without a hinch
$ btrfs fi show /
Label: none  uuid: 911600cb-bd76-4299-9445-666382e8ad20
        Total devices 8 FS bytes used 3.28TiB
        devid    1 size 899.01GiB used 670.00GiB path /dev/sdb3
        devid    2 size 489.05GiB used 271.00GiB path /dev/sdd
        devid    3 size 1.82TiB used 1.58TiB path /dev/sde1
        devid    4 size 931.51GiB used 708.00GiB path /dev/sdf1
        devid    5 size 1.82TiB used 1.58TiB path /dev/sdc1
        devid    7 size 931.51GiB used 675.00GiB path /dev/nvme2n1p1
        devid    8 size 931.51GiB used 680.03GiB path /dev/nvme1n1p1
        devid    9 size 931.51GiB used 678.03GiB path /dev/nvme0n1p1

That is a multi disk array with all data duplicated data/sys:

$ btrfs fi us -T /
Overall:
    Device size:                   8.63TiB
    Device allocated:              6.76TiB
    Device unallocated:            1.87TiB
    Device missing:                  0.00B
    Used:                          6.57TiB
    Free (estimated):              1.03TiB      (min: 1.03TiB)
    Free (statfs, df):             1.01TiB
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

                  Data      Metadata System               
Id Path           RAID1     RAID1    RAID1     Unallocated
-- -------------- --------- -------- --------- -----------
 1 /dev/sdb3      662.00GiB  8.00GiB         -   229.01GiB
 2 /dev/sdd       271.00GiB        -         -     1.55TiB
 3 /dev/sde1        1.58TiB  7.00GiB         -   241.02GiB
 4 /dev/sdf1      701.00GiB  7.00GiB         -   223.51GiB
 5 /dev/sdc1        1.57TiB 10.00GiB         -   241.02GiB
 7 /dev/nvme2n1p1 675.00GiB        -         -   256.51GiB
 8 /dev/nvme1n1p1 673.00GiB  7.00GiB  32.00MiB   251.48GiB
 9 /dev/nvme0n1p1 671.00GiB  7.00GiB  32.00MiB   253.48GiB
-- -------------- --------- -------- --------- -----------
   Total            3.36TiB 23.00GiB  32.00MiB     3.21TiB
   Used             3.27TiB 15.70GiB 528.00KiB            
$

Is there something wrong with the filesystem? Or the kernel?
Any hint how to debug this?

(Please cc)

Thanks

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research Labs  +  IFMGA Guide + TU Wien + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
