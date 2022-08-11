Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0858F7F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 08:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbiHKGwf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 02:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiHKGwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 02:52:33 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC494333C
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 23:52:31 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4M3HYL5QXnz9sQH;
        Thu, 11 Aug 2022 08:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=balkonien.org;
        s=MBO0001; t=1660200742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qo9S2eZqmZBH0DNUsoW7u5ld0FWAdFNlFTQr5RTGm7I=;
        b=a0+79+qq2n+QLqPZUqAkLBp5fpjLLiKvnEZya4ae9Mz+9GywHdnQxI8jJIILFdC7NJDy/G
        OJzG6F+m3SawIUb9klL4tP/ShqyBnpTvueZWGxrkTUSOH0sDo3zBzXoZgeiV6OGvt4KCmc
        6AT3wduPn03cAAueLnEcLx0B0qEY8RfQNI4EvnqhFhf2X1KxFTBNK92pysi1zYcC5DYhFl
        Pus6bhQ/I5ebVD2J4t2XVF4pbbFWifertg+rgr4y3PO64bB7iVQHq7Sw+CbbwfhGG7K5Me
        I7C2csAUKvMSLtyWmFdN8QMuIqEWKSBGMlU6jhKhu4WzX4zQOR4iDpFvMLhJAw==
Message-ID: <1e206ba1-1859-4a79-45cd-208519ca848d@balkonien.org>
Date:   Thu, 11 Aug 2022 08:52:16 +0200
MIME-Version: 1.0
From:   Samuel Greiner <samuel@balkonien.org>
Subject: Re: btrfs replace interrupted + corruptes fs
Content-Language: de-DE
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <b4f62b10-b295-26ea-71f9-9a5c9299d42c@balkonien.org>
 <d294e143-1715-4cdc-4687-92c3f8f4f2ef@oracle.com>
In-Reply-To: <d294e143-1715-4cdc-4687-92c3f8f4f2ef@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4M3HYL5QXnz9sQH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 11.08.22 um 04:31 schrieb Anand Jain:
> On 11/08/2022 05:48, Samuel Greiner wrote:
>> Dear folks,
>>
>> I have the feeling of being in trouble.
>>
>> I have a btrfs fs upon 4 HDs. 1 HD should be replaced.
>>
>> 1. I issued the btrfs replace command, but got the message, that the 
>> target HD is mounted (it was not, it did not appear in the mount output).
>>
>> 2. I did a system reboot in hope to do a successfull replace. The 
>> system did not start but said, that it could not mount the btrfs fs 
>> because of a missing device.
>>
>> 3. I booted GParted Live to investigate further.
>>
>> 3.1 A mount -o degraded,rescue=usebackuproot,ro failed.
>> In dmesg I get the following errors
>>
>> flagging fs with big metadata feature
>> allowing degraded mounts
>> trying to use backup root at mount time
>> disk space caching is enabled
>> has skinny extents
>> bdev /dev/sda errs: wr 755, rd 0, flush 0, corrupt 0, gen 0
>> bdev /dev/sdd1 errs: wr 7601141, rd  3801840, flush 12, corrupt 3755, 
>> gen 245
> 
>> replace devid present without n active replace item
> 
> It appears that replace-device already got the superblock but failed to
> update metadata which is good. Could you try physically removing the
> replace-target device and reboot and mount -o degraded.
> 
> And most importantly, before reusing this replace-target device again,
> please run a wipefs -a. If there is a matching fsid and devid=0, it gets
> scanned into the kernel, which makes it appear to have mounted.
> 
> HTH
> 
> Thanks, Anand
> 

Hi all and hi Anand,

thank you very much for your advice. I did as you described:

1. wipefs -a on the target device if the replace.
2. Reboot without the target device plugged in (into the live System)
3. mount -o degraded /dev/sdx /mnt/
4. btrfs replace cancel /mnt/
     btrfs said that there is no replace runnning
5. unmount and check if the file system is mountable without the 
degraded option: mount /dev/sdx/ /mnt/
     works
6. boot in the production system
     works
7. start btrfs scrub
     up and running the next 10 hours

Right now everything seems to be allright - thank you very much!

To replace the device I will power off the machine connect the target 
device and boot up, start the btrfs replace and hope that it will run 
through seamlessly.

Thanks again and best regards
Samuel


> 
>> failed to init dev_replace -117
>> open_ctree failed
>>
>> 4. btrfs check runs through without error
>>
>> -> I guess even if i was prompted the message, that the target device 
>> of the btrfs replace was mounted the replace was started. Due to the 
>> reboot now there seems to be errors in the filesystem additional to an 
>> replace which i cannot stop, because i can't mount the filesystem.
>>
>> Right now I have a btrfs check --check-data-csum running in hope to 
>> get the errors fixed.
>>
>> But actionally I really don't know how to deal with that situation.
>>
>> Do you have any recommondations?
>>
>>
>> Thank you very much!
>> Samuel
>>
>>
>> Additional info:
>>
>> I'm on an recent debian bullseye. But I can't run uname -r because 
>> right now I'm on the GParted (1.4.0-5) Live-System.
>>
>> btrfs fi show /dev/sdd1
>> Label: 'Data' uuid:
>>      Total devices 4 FS bytes used 6.59 TiB
>>      devid 1 size 3.65 TiB used 3.39 TiB path /dev/sdd1
>>      devid 2 size 2.73 TiB used 2.49 TiB path /dev/sdb1
>>      devid 3 size 5.46 TiB used 2.11 TiB path /dev/sdc1
>>      devid 1 size 5.46 TiB used 5.21 TiB path /dev/sdd1
> 
