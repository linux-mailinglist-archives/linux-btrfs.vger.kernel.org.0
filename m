Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0996D32B2A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbhCCB6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:44 -0500
Received: from mail.knebb.de ([188.68.42.176]:41146 "EHLO mail.knebb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383859AbhCBV2j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Mar 2021 16:28:39 -0500
Received: by mail.knebb.de (Postfix, from userid 121)
        id 737E2E38FE; Tue,  2 Mar 2021 22:27:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on netcup.knebb.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=1.7 tests=ALL_TRUSTED,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from [192.168.9.194] (p5de00be0.dip0.t-ipconnect.de [93.224.11.224])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cvoelker)
        by mail.knebb.de (Postfix) with ESMTPSA id D93ABE0C22;
        Tue,  2 Mar 2021 22:27:48 +0100 (CET)
Subject: Re: Adding Device Fails - Why?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
 <4744a69e-0adb-7cad-577e-7f17741519be@knebb.de>
 <6e37dc95-cca7-a7fc-774a-87068f03c16b@gmx.com>
 <4890dd37-3ef1-e589-9fd1-543a993436c4@knebb.de>
 <f2237d9e-bd3a-f694-b64e-f229b67a1064@gmx.com>
From:   =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>
Message-ID: <6779a8c3-6a77-b1dd-a90e-49e03ee61619@knebb.de>
Date:   Tue, 2 Mar 2021 22:24:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f2237d9e-bd3a-f694-b64e-f229b67a1064@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

thanks to Qu Wenruo it worked for me as he suggested.
So I created my additional drbd device and put the encryption on top of 
it. To workaround the issue with adding a device with /dev/mapper/ as 
prefix I created in my /root a node with the same major and minor 
numbers as the dm-* device. Once the device got added I removed the 
created node and everything went fine. Trying to use a created symlink 
did not work, neither adding the dm-* device directly.

Steps in detail:
 >root@backuppc41:/dev/mapper# ll
 >insgesamt 0
 >crw------- 1 root root 10, 236  2. Mär 13:27 control
 >lrwxrwxrwx 1 root root       7  2. Mär 13:48 crypt_drbd1 -> ../dm-3
 >lrwxrwxrwx 1 root root       7  2. Mär 13:48 crypt_drbd2 -> ../dm-4
 >lrwxrwxrwx 1 root root       7  2. Mär 13:48 crypt_drbd3 -> ../dm-5

The device to be added is crypt_drbd3 so I need to find the major/minor 
number of the dm-5 device:

 >root@backuppc41:/dev# ll /dev| grep dm-5
 >brw-rw---- 1 root disk    253,   5  2. Mär 13:48 dm-5

Ok, got all I need. Now going to create the (temp) device node:
 >root@backuppc41:~# mknod ~/temp_node b 253 2

Now I was finally able to add the device by the created node:
 >root@backuppc41:~# btrfs de add /root/temp_node /mnt

Now remove the temp_node and I rebooted the box. After reboot the device 
was still added to my btrfs-filesystem. Perfect!

Thanks again to all!

/KNEBB

