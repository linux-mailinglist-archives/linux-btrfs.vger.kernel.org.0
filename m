Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6710A550A14
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 13:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiFSLO4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 19 Jun 2022 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiFSLOz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 07:14:55 -0400
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B154F00
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 04:14:54 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id 2stHoeVFpGjO82stIooyYl; Sun, 19 Jun 2022 12:14:52 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HttlpmfS c=1 sm=1 tr=0 ts=62af052c
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=7YfXLusrAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=fxJcL_dCAAAA:8 a=1PL3JLmW-KtTYkwuCQgA:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Qu Wenruo'" <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk> <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com> <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk> <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com> <000001d883c7$698edad0$3cac9070$@perdrix.co.uk> <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com>
In-Reply-To: <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com>
Subject: RE: Problems with BTRFS formatted disk
Date:   Sun, 19 Jun 2022 12:14:51 +0100
Message-ID: <000401d883cd$cc588fc0$6509af40$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQE6G7yNOJVUJ6Zum7z6uCsu/gieNwG3iWv+Afjb+GUCCjux4wI0aTcjAwQd14uuO8qEwA==
X-CMAE-Envelope: MS4xfFZHzI+j3cNXeUUODo6l29YURTFXHFEhtzC3fX7lntaA2VbBuZUePUxpWgo+3xpIJZ7bmydV3rPolrrkW9TaL28oRoyq2SDOZWWVYAjFGB5kTKNkmLp/
 FtQTG7y1XVLu6yFhjpubLKNkFTooFigjvqFyqzW1XwLEGhobUYrJC1NQ6TLBHcnwj8jtnHoI74yhkg0jLEPBhXvLPe+v+9Sj6HU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LUbuntu 22.04 was definitely 5.15 kernel, what alternative distro do you propose I use? 

-----Original Message-----
From: Qu Wenruo <quwenruo.btrfs@gmx.com> 
Sent: 19 June 2022 11:41
To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
Subject: Re: Problems with BTRFS formatted disk



On 2022/6/19 18:29, David C. Partridge wrote:
> Booted from live USB 22.04 LUbuntu.

Ubuntu kernel version doesn't seem to be that consistent even for its
LTS releases:

https://ubuntu.com/about/release-cycle#ubuntu-kernel-release-cycle

Please use something rolling released distro/branch instead.

Thanks,
Qu
>
> root@lubuntu:/home/lubuntu# mount -t btrfs -o rescue=all /dev/sdc1 /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc1, missing codepage or helper program, or other error.
> root@lubuntu:/home/lubuntu#
>
> Content of system journal
>
> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): flagging fs with big metadata feature
> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): disk space caching is enabled
> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): has skinny extents
> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent transid verify failed on 12554992156672 wanted 130582 found 127355
> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent transid verify failed on 12554992156672 wanted 130582 found 127355
> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): failed to read block groups: -5
> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): open_ctree failed
>
> David
>
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Sent: 19 June 2022 03:02
> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
> Subject: Re: Problems with BTRFS formatted disk
>
>>> You can try rescue=all mount option, which has the extra handling on
>>> corrupted extent tree.
>>
>>> Although you have to use kernels newer than v5.15 (including v5.15) to
>>> benefit from the change.
>>
>> Unfortunately:
>> amonra@charon:~$ uname -a
>> Linux charon 5.4.0-113-generic #127-Ubuntu SMP Wed May 18 14:30:56 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
>
> Any special reason that you can not even use a liveUSB to boot a newer
> kernel to do the salvage?
>
>
> Thanks,
> Qu
>

