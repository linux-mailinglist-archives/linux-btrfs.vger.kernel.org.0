Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E3C551275
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbiFTITm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 20 Jun 2022 04:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbiFTITl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 04:19:41 -0400
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4360BDEA9
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 01:19:39 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id 3CdEoYwXSuTE03CdGoHFji; Mon, 20 Jun 2022 09:19:38 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DfIEF9hW c=1 sm=1 tr=0 ts=62b02d9a
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=7YfXLusrAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=sAEC3pc14tC1HDygjDEA:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Qu Wenruo'" <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk> <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com> <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk> <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com> <000001d883c7$698edad0$3cac9070$@perdrix.co.uk> <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com> <000401d883cd$cc588fc0$6509af40$@perdrix.co.uk> <393cf34a-0ae9-d34c-b2bb-ea74d906dfa5@gmx.com> <000201d883db$a22686e0$e67394a0$@perdrix.co.uk> <000901d883e0$289d73b0$79d85b10$@perdrix.co.uk> <b8579f1c-a277-2a01-2126-77ffcc0ab2d5@gmx.com> <000c01d883e7$1757e570$4607b050$@perdrix.co.uk> <cbc6be27-fa40-f5e3-657b-742e274dceec@gmail.com> <003801d88418$15096b50$3f1c41f0$@perdrix.co.uk> <5d892115-c132-b2ea-7651-9cb94f76ee6b@gmx.com>
In-Reply-To: <5d892115-c132-b2ea-7651-9cb94f76ee6b@gmx.com>
Subject: RE: Problems with BTRFS formatted disk
Date:   Mon, 20 Jun 2022 09:19:36 +0100
Message-ID: <009701d8847e$7b98d930$72ca8b90$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQE6G7yNOJVUJ6Zum7z6uCsu/gieNwG3iWv+Afjb+GUCCjux4wI0aTcjAwQd14sByWWhmwIjQYotAgDDGGgCPmdhdAFAo2axApahge4DEToUbwISXrEHAfAo6oitpHVIwA==
X-CMAE-Envelope: MS4xfESQc3Oz4Q40veNmgtCbeFJYH3L0IMDBH/W0gPP/SzIQmOzqpsZp4IW/ANrOPwN1nDfUDzlJRAGo2na5G3hXD/RhfyfJ5xbnSC3Fc6lRNjSutRHXKl1E
 ITftEK4NM0YOqiGU66BZAyH2zCRNEZ9mY+rhyAPM1xaffBACepXBIHfvpg4P9k0QCFcysE8TESQM3FE469qUz3Bxtnlbz/7eM9k=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I don't know ... The Super-Caps only power the cache memory ...

-----Original Message-----
From: Qu Wenruo <quwenruo.btrfs@gmx.com> 
Sent: 20 June 2022 01:38
To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
Subject: Re: Problems with BTRFS formatted disk



On 2022/6/20 04:06, David C. Partridge wrote:
> Yes write caching was enabled - I suspect that the way it worked was that on power fail the super-caps held the data until power was restored.
>
> Sadly it wasn't restored for a few weeks by which time the super-caps had lost their charge.

A little off-topic here, since I'm not familiar with how those hardware
RAID controllers work.

Yep, those cards should have (super) caps to handle power loss, but for
  SCSI SYNC CACHE commands, they should "the device server ensure that
the specified logical blocks have their most recent data values recorded
in non-volatile cache and/or on the medium."

Considering in a power loss event, the juice in those caps is definitely
not enough to power those HDDs, it should at least have some
non-volatile cache, like NAND, as backups.

But from sites I can found, it only states the card has 1024MiB cache
memory.

Even with caps to keep the memory alive, it's still far from
"non-volatile cache" required by SCSI spec.

Or is this a common practice in hardware RAID controller world to use
volatile cache and break the SCSI spec requirement?

Thanks,
Qu
>
> I've reconfigured to use write through.
>
>
> -----Original Message-----
> From: Andrei Borzenkov <arvidjaar@gmail.com>
> Sent: 19 June 2022 20:06
> To: David C. Partridge <david.partridge@perdrix.co.uk>; 'Qu Wenruo' <quwenruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
> Subject: Re: Problems with BTRFS formatted disk
>
> On 19.06.2022 17:15, David C. Partridge wrote:
>> I can't "grab what I can" as I don't have enough TB to copy the data I want to save ☹
>>
>> Does it make any sense to try:
>>
>>   mount -o remount,rw /mnt
>>   btrfs subvolume delete /mnt/@
>>   btrfs subvolume delete /mnt/@_daily.20220525_00:11:01
>>   btrfs subvolume delete /mnt/@_daily.20220526_00:11:01
>>   btrfs subvolume delete /mnt/@_hourly.20220526_06:00:01
>>   btrfs subvolume delete /mnt/@_hourly.20220526_09:00:01
>>   btrfs subvolume delete /mnt/@_hourly.20220526_12:00:01
>>
>>   mv /mnt/@_daily.20220524_00:11:01 /mnt/@
>>
>> or is that doomed to total failure?
>>
>> The disks behind the raid card are all Western Digital WD4001FYYG SAS drives
>>
>
> Is write caching enabled for these disks? I know that it is default for
> some RAID cards (at least, for some profiles).
>
> For disks behind RAID controller write caching is normally managed by
> RAID controller itself.
>

