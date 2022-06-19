Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8593550CDE
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiFSUGm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 19 Jun 2022 16:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiFSUGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 16:06:41 -0400
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851BBA19B
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 13:06:39 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id 31BsoVncXuTE031BtoH7vm; Sun, 19 Jun 2022 21:06:37 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DfIEF9hW c=1 sm=1 tr=0 ts=62af81cd
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=P1kZ4gAsAAAA:8 a=7YfXLusrAAAA:8
 a=VwQbUJbxAAAA:8 a=q5LqLRgPK19_t2V6OpIA:9 a=QEXdDO2ut3YA:10
 a=fn9vMg-Z9CMH7MoVPInU:22 a=SLz71HocmBbuEhFRYD3r:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Qu Wenruo'" <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk> <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com> <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk> <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com> <000001d883c7$698edad0$3cac9070$@perdrix.co.uk> <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com> <000401d883cd$cc588fc0$6509af40$@perdrix.co.uk> <393cf34a-0ae9-d34c-b2bb-ea74d906dfa5@gmx.com> <000201d883db$a22686e0$e67394a0$@perdrix.co.uk> <000901d883e0$289d73b0$79d85b10$@perdrix.co.uk> <b8579f1c-a277-2a01-2126-77ffcc0ab2d5@gmx.com> <000c01d883e7$1757e570$4607b050$@perdrix.co.uk> <cbc6be27-fa40-f5e3-657b-742e274dceec@gmail.com>
In-Reply-To: <cbc6be27-fa40-f5e3-657b-742e274dceec@gmail.com>
Subject: RE: Problems with BTRFS formatted disk
Date:   Sun, 19 Jun 2022 21:06:36 +0100
Message-ID: <003801d88418$15096b50$3f1c41f0$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE6G7yNOJVUJ6Zum7z6uCsu/gieNwG3iWv+Afjb+GUCCjux4wI0aTcjAwQd14sByWWhmwIjQYotAgDDGGgCPmdhdAFAo2axApahge4DEToUb63DvNnw
Content-Language: en-gb
X-CMAE-Envelope: MS4xfBgD1HfOkLbmzy9wLnShpIH8I9lULi99P2jC81Vxxo13hg4PjSJcaj19c7AuFu+4v/lgFWxJoWT7Yk41pC/AruSMBl+PReg8z/IHajOHJJQUEpuMxh+o
 72uMfU42C7hXI+LtFO2WIz/K44S0Y4NjYNgAKBGQHW+s/cMPpFIe/c87T0lwp7mMFDyjgZeHw3CKu+Oo4R0nnpEHNMXJfPsWcfM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yes write caching was enabled - I suspect that the way it worked was that on power fail the super-caps held the data until power was restored.

Sadly it wasn't restored for a few weeks by which time the super-caps had lost their charge.

I've reconfigured to use write through.


-----Original Message-----
From: Andrei Borzenkov <arvidjaar@gmail.com> 
Sent: 19 June 2022 20:06
To: David C. Partridge <david.partridge@perdrix.co.uk>; 'Qu Wenruo' <quwenruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
Subject: Re: Problems with BTRFS formatted disk

On 19.06.2022 17:15, David C. Partridge wrote:
> I can't "grab what I can" as I don't have enough TB to copy the data I want to save ☹
> 
> Does it make any sense to try:
> 
>  mount -o remount,rw /mnt
>  btrfs subvolume delete /mnt/@
>  btrfs subvolume delete /mnt/@_daily.20220525_00:11:01
>  btrfs subvolume delete /mnt/@_daily.20220526_00:11:01
>  btrfs subvolume delete /mnt/@_hourly.20220526_06:00:01
>  btrfs subvolume delete /mnt/@_hourly.20220526_09:00:01
>  btrfs subvolume delete /mnt/@_hourly.20220526_12:00:01
> 
>  mv /mnt/@_daily.20220524_00:11:01 /mnt/@
> 
> or is that doomed to total failure?
> 
> The disks behind the raid card are all Western Digital WD4001FYYG SAS drives
> 

Is write caching enabled for these disks? I know that it is default for
some RAID cards (at least, for some profiles).

For disks behind RAID controller write caching is normally managed by
RAID controller itself.

