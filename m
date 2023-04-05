Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD26D8AED
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 01:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDEXGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 19:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDEXGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 19:06:53 -0400
Received: from se6.syd.hostingplatform.net.au (se6.syd.hostingplatform.net.au [IPv6:2400:b800:5::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28006196
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 16:06:49 -0700 (PDT)
Received: from s02bd.syd2.hostingplatform.net.au ([103.27.32.42])
        by se6.syd.hostingplatform.net.au with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjurgens@edcint.co.nz>)
        id 1pkCDB-0003hB-9A
        for linux-btrfs@vger.kernel.org; Thu, 06 Apr 2023 09:06:45 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5e+tl2sVhAAbp1nbKsHqU6ArfPnTgj2cDari5BpsmLI=; b=KMWupgPgluLPOC7OkxyGaCd31L
        zkebcQVerFKgjitniC52m3RicH3Z5jRzVpv+80XuxM6ZMt1G8Gq/Ok0JW88BTi6ySn0RX7xGG2r1r
        M5e8CLByFkzLCQoRqjgezJJlxCkejINVRu403/uiAhXDUWVv5b7q4cKLSLVbEcUJ2MU0qgtEcrq+4
        ZCLSM5qu0Kwr+JqSE8iV5/3wLyVLlm/ptM5AUuFVqtol1XAv2fyZrVT58E0I9PXcieqlHiiJHhj9t
        CsPKTnyn2pvaW6mo/7hGsz0sb0ggkQaTmwfMKgZOJcruz0UGzAiUkpS63+VjN3O/7uYRE+nTgK3Fj
        6yalj2Tw==;
Received: from [159.196.20.165] (port=18952 helo=[192.168.2.80])
        by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <mjurgens@edcint.co.nz>)
        id 1pkCDA-002UcS-1Q;
        Thu, 06 Apr 2023 09:06:40 +1000
Message-ID: <5975b057-4f2e-0f52-c154-42877aaa2b34@edcint.co.nz>
Date:   Thu, 6 Apr 2023 09:06:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Readonly file system: __btrfs_unlink_inode:4325: errno=-2 No such
 entry
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <01bc2043-28ea-905e-44f2-de61cd86934e@edcint.co.nz>
 <02f70470-fd22-bfed-7f0b-2c0acf4259e2@gmx.com>
 <7ae06bd0-4165-8e0b-8035-f1e676fac270@edcint.co.nz>
 <16c0d29d-c986-0c9a-dd95-10d61eb6f29a@gmx.com>
Content-Language: en-US
From:   Matthew Jurgens <mjurgens@edcint.co.nz>
In-Reply-To: <16c0d29d-c986-0c9a-dd95-10d61eb6f29a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: mjurgens@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: mjurgens@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 103.27.32.42
X-SpamExperts-Domain: out-2.hostyourservices.net
X-SpamExperts-Username: 103.27.32.42
Authentication-Results: syd.hostingplatform.net.au; auth=pass smtp.auth=103.27.32.42@out-2.hostyourservices.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/xAgLNT+xzBDIcQroJ5HR7PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5ztW2DfCmdqRCMoho/8w6SaWy8Zi3U/W0AnUgWIBqewEKvp
 k7Vp2UXVHEQMIct0liJyuyxpeMCuX2YMVJyEajA4swKQDamPN66SYe4XX4xmgL3iG5C68UKF9X7G
 VVGoR1MIBNrlXkyAviQZ2hH0rZUABVisGv8MyVI5ms3guyJnGo2++92Yic2BiOe/WA1+fT0UOled
 bu+r9+W9cDXvzL3S9eBuLVuXvzBy4xpVxCQtB7A+BsIrAO5wNoMhbD4alvMUx7MG2wf4WvmVq0gI
 vEpMsXte0CH4ExjoF85tff90A1HUoVwaoyKiseY5we892IYad3lsxkDrjYxAaP1hGz0QyGcCgytU
 Mu2J9HJXA1Uo4JCwYajdPAJj3f1JZ/bfnvAIBNrlXkyAviQZ2hH0rZUArqq9GopDryQPg7s3heG/
 sptwIRuNuppYmJAhwWaToKKnOLgkNYSIm5/jKyA2MtlgChQY04MeqjwKoHYW/fKRT7A+BsIrAO5w
 NoMhbD4alvMNkBHrZLx9NP8Zp+qBec/LJLgeHyzXbJuPc5xhDsFtUcmk/n4Z5j5mfjlLleQTOnss
 uVaOsTohfZcZAm3ZkGbkX2L/SPp0qtVEVmnpmhCrVL++8fkk80oCQG5LGSfM/dp8z7rf4ElwQkEa
 PmxdQS3Pu6wGdYEAgg6PDAqGVCcW36lffjYzouTPGM2szH8GRAKPPZiKGTzb2X0CsNjV/ErlLaLf
 2WZSJ4n+Wce1EubzY+Shrx6tXrK936T5eZVbx/ag2oaZ2jfCcHaZtr2kZ3ewCvpmBrQPdpQd6gUx
 eQJj1TCDpmY+vMk0aWoAePM6tLY8CVsONrMJuGzuoGnKTKcy9rvORgLXJy4pykKsQR3+U9vmQ4Sa
 0pTURAjDbGqvvGe8zubOV4fOXZVj2+iGktPF1ZBPbNNSkVxi5XhVtuxnM+RCvTm+w+RZl4AOUQHP
 Or8s0ueeSQv3iRNCdtD1uwyAtmMt0SFL2AObukRB4+2V/q/7oV3RX5x5ctBOCS2YqLV49DjiWowO
 nKvI8aF4jzAuhxa14k/LVdu/Eh+2pFebsXyMlsYnPB892gq9fzZCwbk=
X-Report-Abuse-To: spam@se.syd.hostingplatform.net.au
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Yes, that particular problem should be able to be fixed by "btrfs 
> check --repair".
> At least "btrfs check --repair" should not make the case worse.
>
>
> But "--repair" is only recommended after you have verified your 
> hardware memory is fine.
>
> If the memory has bitflip, you always has the chance to screw up the 
> fs, no matter if it's "btrfs check --repair" or a, RW mount.
>
> Thanks,
> Qu

Just pasting the result of the --repair for completeness.

Thanks for the help. The file in question can now be deleted.


Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: 3adb6756-7cab-4a7a-a7d8-9ff119032ee5
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
super bytes used 3500542160896 mismatches actual used 3500542078976
No device size related problem found
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
Deleting bad dir index [168755802,96,5462] root 5
adding missing dir index/item pair for inode 146458293
Fixed the nlink of inode 146458293
         unresolved ref dir 168755802 index 5462 namelen 49 name 
dd02f3c3-e4fe--b908-bd11845475af@starship.eml filetype 1 errors 0
reset isize for dir 168755802 root 5
reset isize for dir 168755802 root 5
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 7001084256256 bytes used, no error found
total csum bytes: 6761403192
total tree bytes: 75800969216
total fs tree bytes: 66906259456
total extent tree bytes: 1147338752
btree space waste bytes: 11094646008
file data blocks allocated: 6925283287040
  referenced 7163405950976
