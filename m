Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B893339E07
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Mar 2021 13:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhCMMVQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Mar 2021 07:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMMVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Mar 2021 07:21:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8BCC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Mar 2021 04:21:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o16so3216397wrn.0
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Mar 2021 04:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pCt3uaW+9DlLZncJz9lVw62jWxB+vXGPnDGh4ZD6gEE=;
        b=COVBLN3B63CFm+ZSJDj8Ae9aWwlob4AQ0V29wq7gv4gyteUvcVuiWerWoiML7VvNuq
         4AUWVw5HYDYNsit3/VWgAWUXqyDcwbRwSUJQ9BjuQdSAdo4hzr0GPpnh9SewG14c8aUR
         2/kjuVyeZDlVHd/6BTOr9dh5jnRa1Pt1LO8bPsivRHqsgCUQQrmNlRpxQhAC+i/+St0v
         OS8zJ0FZ/ewUCnZ1aG5E63bRhgD4lWRKpSOO2Tu6z32MqGQcauSRhha1Z9r4SQm6MpkY
         WYBXtC1/vIADds6hUZVCwUpuos1VUcnYqWWwRzvRPaPwTi4NdvPFLKUqCxQJFcwU6ydv
         OYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pCt3uaW+9DlLZncJz9lVw62jWxB+vXGPnDGh4ZD6gEE=;
        b=TdFpCA+CJEr20lwN0zfHuzTYBD7VL6RP3a1mdj6zFJKBXLGjHTGGm7QkrNy59TeHUE
         OHT1LpfksSLjWq74aVi7mT5mIfbT12sjqdckuSQhGvOcNU/Pd6wn07KgoZUiLOqpdi0z
         r2bFgsIuVGfbq7FF2MqsLheaxlC3lnzI14l9wX2P9rcXw+nNKyy7YErrtsZOctWFNbjb
         jqlCLDB37kideIBM3W2Qc5tc2U1dGP4HvAGApo5E3ZYchRnClQ7jRBwr4dUgGG7lgchq
         GRshe2CuNtupbuItTZOhldH3pxeTRiWz++kY+76wdu84mi+1E9Lao2sq320RD1QN3W0J
         MMfQ==
X-Gm-Message-State: AOAM5322CYlTbU7s3sIHAqxrXRFdEbEOzdPRRLigg6RAdYrVzsK3YHp/
        SAC+VntDGJUL++3E4phlUQfEmqWgNJw=
X-Google-Smtp-Source: ABdhPJyZ3Jf+RP2KpRqN26ssGhiZR6m69HiVvN3QY15dTh3JAiIv3szdsskctqwlHAWe6OexrjFZ8w==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr18544661wru.220.1615638068277;
        Sat, 13 Mar 2021 04:21:08 -0800 (PST)
Received: from [192.168.1.11] (b2b-94-79-184-225.unitymedia.biz. [94.79.184.225])
        by smtp.gmail.com with ESMTPSA id b15sm7204026wmd.41.2021.03.13.04.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 04:21:07 -0800 (PST)
Subject: Re: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd
 2719033, flush 0, corrupt 6, gen 0
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
 <20210313152146.1D7D.409509F4@e16-tech.com>
From:   Thomas <74cmonty@gmail.com>
Message-ID: <cefa397a-c39a-78c3-5e85-f6a9951de7d8@gmail.com>
Date:   Sat, 13 Mar 2021 13:21:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210313152146.1D7D.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The partitions on both SSD are equal in size:
homas@pc1-desktop:~
$ sudo fdisk -l /dev/sda
Festplatte /dev/sda: 238,47 GiB, 256060514304 Bytes, 500118192 Sektoren
Festplattenmodell: SanDisk SD8SBAT2
Einheiten: Sektoren von 1 * 512 = 512 Bytes
Sektorgröße (logisch/physikalisch): 512 Bytes / 512 Bytes
E/A-Größe (minimal/optimal): 512 Bytes / 512 Bytes
Festplattenbezeichnungstyp: dos
Festplattenbezeichner: 0x0914a19b

Gerät      Boot    Anfang      Ende  Sektoren  Größe Kn Typ
/dev/sda1  *         2048 496093750 496091703 236,6G 83 Linux
/dev/sda2       496095232 500118191   4022960   1,9G 82 Linux Swap / Solaris

thomas@pc1-desktop:~
$ sudo fdisk -l /dev/sdb
Festplatte /dev/sdb: 238,47 GiB, 256060514304 Bytes, 500118192 Sektoren
Festplattenmodell: SanDisk SD9TB8W2
Einheiten: Sektoren von 1 * 512 = 512 Bytes
Sektorgröße (logisch/physikalisch): 512 Bytes / 512 Bytes
E/A-Größe (minimal/optimal): 512 Bytes / 512 Bytes
Festplattenbezeichnungstyp: dos
Festplattenbezeichner: 0xf23fc590

Gerät      Boot Anfang      Ende  Sektoren  Größe Kn Typ
/dev/sdb1         2048 496093750 496091703 236,6G 83 Linux


However the output of btrfs insp dump-s <device> is different:
thomas@pc1-desktop:~
$ sudo btrfs insp dump-s /dev/sdb1 | grep dev_item.total_bytes
dev_item.total_bytes    256059465728

thomas@pc1-desktop:~
$ sudo btrfs insp dump-s /dev/sda1 | grep dev_item.total_bytes
dev_item.total_bytes    253998948352



Am 13.03.21 um 08:21 schrieb Wang Yugui:
> Hi,
>
> If there is some partition size change after filesystem created,
> 'btrfs filesystem resize max' will help.
>
> See also
> https://lore.kernel.org/linux-btrfs/42d37a6393db7ad5d83bc167459c8a5c@steev.me.uk/T/#t
>
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/03/12
>
>> Hello,
>>
>> I have observed this error messages in systemd journal:
>> BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719033,
>> flush 0, corrupt 6, gen 0
>>
>> Here are the bottom lines of journalctl -xb:
>> ?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=524288, want=497859712,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=524288, want=497859840,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=256, want=497859704,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
>> /dev/sdb1 errs: wr 2702175, rd 2719033, flush 0, corrupt 6, gen 0
>> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=256, want=497859720,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=524288, want=497859968,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
>> /dev/sdb1 errs: wr 2702175, rd 2719034, flush 0, corrupt 6, gen 0
>> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=256, want=497859728,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=256, want=497859712,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
>> /dev/sdb1 errs: wr 2702175, rd 2719035, flush 0, corrupt 6, gen 0
>> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=524288, want=497860096,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
>> /dev/sdb1 errs: wr 2702175, rd 2719036, flush 0, corrupt 6, gen 0
>> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=256, want=497859736,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
>> ???????????????????????????????????? sdb1: rw=256, want=497859848,
>> limit=496091703
>> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
>> /dev/sdb1 errs: wr 2702175, rd 2719037, flush 0, corrupt 6, gen 0
>> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
>> /dev/sdb1 errs: wr 2702175, rd 2719038, flush 0, corrupt 6, gen 0
>> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
>> /dev/sdb1 errs: wr 2702175, rd 2719039, flush 0, corrupt 6, gen 0
>> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
>> /dev/sdb1 errs: wr 2702175, rd 2719040, flush 0, corrupt 6, gen 0
>> M?r 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
>> /dev/sdb1 errs: wr 2702175, rd 2719041, flush 0, corrupt 6, gen 0
>>
>>
>> I have configured a multidrive setup with 2 identical SSDs.
>>
>> [root@pc1-desktop ~]# uname -a
>> Linux pc1-desktop 5.10.22-2-lts #1 SMP Wed, 10 Mar 2021 10:30:57 +0000
>> x86_64 GNU/Linux
>> [root@pc1-desktop ~]# btrfs --version
>> btrfs-progs v5.11
>> [root@pc1-desktop ~]# btrfs fi show
>> Label: 'archlinux'? uuid: 78462a70-55ad-4444-9d91-e71e42cce51c
>> ??? Total devices 2 FS bytes used 178.93GiB
>> ??? devid??? 1 size 236.55GiB used 233.50GiB path /dev/sda1
>> ??? devid??? 2 size 238.47GiB used 233.50GiB path /dev/sdb1
>>
>> Label: 'backup'? uuid: de094dc0-58b7-4931-b948-4b920495bf94
>> ??? Total devices 1 FS bytes used 210.97GiB
>> ??? devid??? 1 size 232.89GiB used 228.87GiB path /dev/sdd
>>
>> [root@pc1-desktop ~]# btrfs fi df /
>> Data, RAID1: total=229.47GiB, used=175.82GiB
>> System, RAID1: total=32.00MiB, used=64.00KiB
>> Metadata, RAID1: total=4.00GiB, used=3.11GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>
>>
>> Can you please advise how to fix these errors?
>>
>>
>> Regards
>> Thomas
>

