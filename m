Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4D452D1AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbiESLoT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiESLoR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:44:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A410B41D1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:44:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j25so6763879wrc.9
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=SfHoGJ1w+zmHSRBNxAJ5T9IdP18SGE4STZaqpIoRuZs=;
        b=LTxgYeDzHfJRaD/2IYb/hhHuNHAzL82OfPhxS+pKP6hHjt9/feNqFgQeb5A/ySL6Zu
         QyebmH+nRqmCdjSRtcP9F8Dz7ltQAfZbXw+0xeAJ3lLT9cqesk528Rv7a2I6A4ZodCQY
         41hZARJCGnVJne5WVT52h3759/3B/mCisU9d0gAyU/kdbW6rwqaWXQpHotscxuNgYOdp
         Pz21cXKu7FNfKhI+xgaJltwJ53CEL7HNXHGoKkEuIML0qGZ0c7M/ddzl9cJkejTuVW3h
         8NamBSspex7171ZOenGv7YpKl3EjHX8SBoCs4lZBGEpOEfL18H3YqMm3NzH+dqlVLmFo
         apNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SfHoGJ1w+zmHSRBNxAJ5T9IdP18SGE4STZaqpIoRuZs=;
        b=yg+KHg8zsHQ9WR2prH9IhcS8B+T7ISk9+dJMQg2LlNKFdv/4/WxlvZpu7vB0jsC06B
         YOoWh7MtbuYQe0ccUC6eagc2nV8FOzNGA7Z32g1P22NJ+9RsB1tMplFpI3jv0sW692MU
         4G5hdMakS+7vN07FjfiBlX8istcgKnPLQC/Q00APwtvP1zVm/qDZqK33KLIK0J1O6oFb
         5W64RsgI/DpJ1F7pyRZLgQnjhpIBCrOLBXpfjuv4AoE0Aw849gOLeelYCcgZ+bULPufO
         a9jRepQJkXuRxmm2e14j6sf9HbSMtya2P76Pa5GQN46b8NEcStrlXLtz2prNGwPI7paF
         qbog==
X-Gm-Message-State: AOAM5317TNBKm0bqsq0/ty/6W/QRHEnSevsoPB7PbgIz8bfUM3WX5cgn
        hMe4Pf2HjU3jbqb3uN9+a7SzePpHMSIXEA==
X-Google-Smtp-Source: ABdhPJw0c/q+st7sXAQtmHdJH4ARZqD2dnexd6S5XitCkTBF+dOmbSOsd+bxo+faFAmfjxQFzaV+yg==
X-Received: by 2002:a05:6000:104e:b0:20e:585a:f562 with SMTP id c14-20020a056000104e00b0020e585af562mr3648679wrx.456.1652960654480;
        Thu, 19 May 2022 04:44:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:22a:85e0:16da:e9ff:feb5:7a88? ([2a01:e0a:22a:85e0:16da:e9ff:feb5:7a88])
        by smtp.gmail.com with ESMTPSA id q16-20020adfbb90000000b0020d0c9c95d3sm4640311wrg.77.2022.05.19.04.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 04:44:13 -0700 (PDT)
Message-ID: <8da3130c-94a7-3af2-1ad4-1ffa9bae6518@gmail.com>
Date:   Thu, 19 May 2022 13:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Betterbird/91.9.0
Subject: Re: can't boot into filesystem
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
 <5679bb8d-d0af-187b-1bd0-fd8ccc85a867@gmx.com>
From:   arnaud gaboury <arnaud.gaboury@gmail.com>
In-Reply-To: <5679bb8d-d0af-187b-1bd0-fd8ccc85a867@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 5/19/22 13:36, Qu Wenruo wrote:
>
>
> On 2022/5/19 17:58, arnaud gaboury wrote:
>> My OS has been freshly installed on a btrfs filesystem. I am quite new
>> to btrfs, especially when mounting specific partitions. After a change
>> in my fstab, I couldn't boot into the filesystem. Booting from a
>> rescue CD, I changed the fstab back to its original. Unfortunately I
>> still can't boot.
>> Here is part of the error message I have:
>> devid 2 uuid XXYYY is missing
>> failed to read chunk tree: -2
>
> This is the reason, your fs is across multiple-device (like using RAID1
> profiles).
>
> And on boot, you initramfs doesn't call 'btrfs dev scan' to let btrfs
> scan all devices and assemble the full device list.
>
> Thus it can only detect one disk of your multi-device btrfs, and failed
> to mount.
>
> That's why your rescue CD can mount the fs.
>
> You may want to check the manual of distro to make sure the initramfs is
> doing proper preparation work for btrfs (mostly just scan the devices).
>
> For example of Archlinux:
>
> https://wiki.archlinux.org/title/mkinitcpio


I am effectively on arch linux and the btrfs hook is on my 
mkinitcpio.conf file.

Now is there any solution to mount and add to my filesystem the external 
device?

> You need "btrfs" hook, which is doing exactly I mentioned, run "btrfs
> dev scan".
>
> Thanks,
> Qu
>>
>> part of my fstab:
>> LABEL=magnolia   / btrfs  rw,noatime.....,subvol=@
>> LABEL=magnolia  /btrbk_pool  btrfs  noatime,....,subvolid=5
>> LABEL=magnolia   /home   btrfs .....,subvol=/@home
>> ......
>>
>>
>>
>> I am now back to rescue CD. I can mount my filesystem with no error:
>> # mount -t btrfs /dev/sdb2 /mnt
>> # ls -al /mnt/
>> @
>> btrbk_snapshots
>> @home
>> home
>>
>> I can see my filesystem when I ls the @ directory.
>> What can I do to boot my filesystem which is perfectly reproduced in
>> the @ subvolume? Shall I simply cp the whole filesystem stored in @ to
>> the root of /mnt  when my device sdb2 is mounted?
>> Sorry for the lack of formatting and info, but I can't use the browser
>> from the rescue CD so I am writing from another computer.
