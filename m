Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7118955099F
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiFSK3O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 19 Jun 2022 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFSK3O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 06:29:14 -0400
Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6E7BF71
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 03:29:11 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id 2sB2o1rsXCVxY2sB3oWF1w; Sun, 19 Jun 2022 11:29:10 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ENUVbnVC c=1 sm=1 tr=0 ts=62aefa76
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=7YfXLusrAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=wp_yqVsb84LCB88LVukA:9 a=QEXdDO2ut3YA:10 a=SLz71HocmBbuEhFRYD3r:22
 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Qu Wenruo'" <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk> <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com> <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk> <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com>
In-Reply-To: <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com>
Subject: RE: Problems with BTRFS formatted disk
Date:   Sun, 19 Jun 2022 11:29:08 +0100
Message-ID: <000001d883c7$698edad0$3cac9070$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE6G7yNOJVUJ6Zum7z6uCsu/gieNwG3iWv+Afjb+GUCCjux465lgVSw
Content-Language: en-gb
X-CMAE-Envelope: MS4xfIM2XinYpohlE0j6Kj5hRy6VvH6MhhN7uWeD0Z+TamBN/xFIGbiYf65fnyOUoKMw6Pmf+Ni922S+Nu6Gbh36hO81UrroqbG8G7cb+XZU4z5D0Bqwx21c
 /GIftdUVay00EeqfZRd2AJqchR7OuiUQGyzReMDeKi5Xb7GhslVYUzrm2SkpK31pcqjkQoB7lXaPqxJNhpAmBWWoH5prZ6Kk184=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Booted from live USB 22.04 LUbuntu.

root@lubuntu:/home/lubuntu# mount -t btrfs -o rescue=all /dev/sdc1 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc1, missing codepage or helper program, or other error.
root@lubuntu:/home/lubuntu# 

Content of system journal

Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): flagging fs with big metadata feature
Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): disk space caching is enabled
Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): has skinny extents
Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent transid verify failed on 12554992156672 wanted 130582 found 127355
Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent transid verify failed on 12554992156672 wanted 130582 found 127355
Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): failed to read block groups: -5
Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): open_ctree failed

David

-----Original Message-----
From: Qu Wenruo <quwenruo.btrfs@gmx.com> 
Sent: 19 June 2022 03:02
To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
Subject: Re: Problems with BTRFS formatted disk

>> You can try rescue=all mount option, which has the extra handling on
>> corrupted extent tree.
>
>> Although you have to use kernels newer than v5.15 (including v5.15) to
>> benefit from the change.
>
> Unfortunately:
> amonra@charon:~$ uname -a
> Linux charon 5.4.0-113-generic #127-Ubuntu SMP Wed May 18 14:30:56 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

Any special reason that you can not even use a liveUSB to boot a newer
kernel to do the salvage?


Thanks,
Qu

