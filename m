Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3021E32B1A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbhCCByV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:54:21 -0500
Received: from mail.knebb.de ([188.68.42.176]:35976 "EHLO mail.knebb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381429AbhCBHbh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Mar 2021 02:31:37 -0500
Received: by mail.knebb.de (Postfix, from userid 121)
        id 5DF37E38FE; Tue,  2 Mar 2021 08:30:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on netcup.knebb.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=1.7 tests=ALL_TRUSTED,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from [192.168.9.194] (p5de00be0.dip0.t-ipconnect.de [93.224.11.224])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cvoelker)
        by mail.knebb.de (Postfix) with ESMTPSA id 59150E358F;
        Tue,  2 Mar 2021 08:30:28 +0100 (CET)
Subject: Re: Adding Device Fails - Why?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
References: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
 <4744a69e-0adb-7cad-577e-7f17741519be@knebb.de>
 <6e37dc95-cca7-a7fc-774a-87068f03c16b@gmx.com>
From:   =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>
Message-ID: <cddf1f62-7c74-fa00-159a-6cae9f43f08b@knebb.de>
Date:   Tue, 2 Mar 2021 08:26:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6e37dc95-cca7-a7fc-774a-87068f03c16b@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok,

tried to do with a symlink. No working, getting segfault:

 >root@backuppc41:/dev# ln -s  mapper/crypt_test  crypt_temp
 >root@backuppc41:/dev# btrfs de ad /dev/crypt_temp /var/lib/backuppc/
 >Speicherzugriffsfehler

Greetings

/KNEBB


Am 02.03.2021 um 02:18 schrieb Qu Wenruo:
>
>
> On 2021/3/2 上午1:24, Christian Völker wrote:
>> Hi,
>>
>> just a little update on the issue.
>>
>> As soon as I omit the encryption part I can easily add the device to the
>> btrfs filesystem. It does not matter if the crypted device is on top of
>> DRBD or directly on the /dev/sdc. In both cases btrs refuses to add the
>> device when a luks-encrypted device is on top.
>>
>> In case I am swapping my setup (drbd on top of encryption) and add the
>> drbd device to btrfs it works without any issues.
>>
>> However, I prefer the other way round- and as the other two btrfs
>> devices are both encryption on top of drbd it should work...
>>
>> It appears it does not like to add a third device-mapper device...
>>
>> Let me know how I can help in debugging. If i have some time I will
>> setup a machine trying to reproduce this.
>
> Got the problem reproduced here.
>
> And surprisingly, it's something related to btrfs-progs, not the kernel.
>
> I just added one debug info in btrfs-progs, it shows:
>
> $ sudo ./btrfs dev add /dev/test/scratch2  /mnt/btrfs
> cmd_device_add: path=dm-5
> ERROR: error adding device 'dm-5': No such file or directory
>
> See the problem?
>
> The path which should be passed to kernel lacks the "/dev/test/" prefix,
> thus it's not pointing to correct path and cause the ENOENT error, since
> there is no "dm-5" in current path.
>
> Thankfully it's already fixed in devel branch with commit 2347b34af4d8
> ("btrfs-progs: fix device mapper path canonicalization").
>
> The offending patch is 922eaa7b5472 ("btrfs-progs: build: fix linking
> with static libmount"), which is in v5.10.1.
>
> You can revert back to v5.10 to workaroud it.
>
>
> TO David,
>
> Would you consider to add a new v5.10.2 to fix the problem? As it seems
> to affect the end user quite badly.
>
> Thanks,
> Qu
>>
>> any ideas otherwise? Let me know!
>>
>> Thanks!
>>
>> /KNEBB
>>

