Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E0821EABB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgGNH6X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 03:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNH6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 03:58:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCE8C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jul 2020 00:58:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o8so3553374wmh.4
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jul 2020 00:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3L7AGv8jL6TDJ1749rzKVGMbnja/c804rn6HLwQU0BM=;
        b=dkEkwqD/VIKD6sLfVMTqLF/Liv5968dybEhlPZ3GlwPOmE1W+Y6VAKakceinLhj9c3
         aBqEJUSImlkQlNDv9btRgHeRt/VOv/gndwEglBv7XdOIrcHpeapzJAYWZFn7awD54VNZ
         +TFh75r812F62A4u8ta5vPtRTrDt3F1OSlMLuSRYYE0ztIirE0AqE5Dgt+FjbF4WUXAE
         9/VBtdgVR7QgiAEdNx/rLR+qlNTrmSVa1I7HAih7RvUB6wphL/yJG2asq7+hXQ4jgwBc
         /VNxykv5/9T5ZoLv02mSzpusmvZ++2D9m8iSEp204zj+itspVJ34bXQmVE80GUxNxEqP
         pfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3L7AGv8jL6TDJ1749rzKVGMbnja/c804rn6HLwQU0BM=;
        b=Jd6YYFt81AXeScr4BI3llUrRYxEMdgyiJ5ULmX97N2G8Q8MyYAeRyAa71yw3PvsbiW
         ykrqfcJ3BhPdZEy0Dk0t7l4SOqaOor2pXaVCWnDSV8mGvDfb77XXzPis4H5FxUrPSw/q
         7OUkC5ywo6LQgvICnBgxpf8TpRXVAR3BrdSlgHyvRn1lgU6cDCvlTYPdMVzjJgTvCXW7
         zjuS786NacB1gqeje/d+f55nVVpSQEaUpx5AM6vAhZBblapblx22aEFHfuofFzuQ+Apt
         7bCRsewhYRqOxxhX3jQnVysSjdAs27vhPRg6G64Qd1c2Oeortef8e0XXA9OABmTggn9y
         5Q8w==
X-Gm-Message-State: AOAM533V+7/7nygC3h0dDUOvkGRJ1N+FKdtsIG01AUQbfAyF18GdShQr
        pIKQFlsNfrs7c31IDBl7sGE0ocd8
X-Google-Smtp-Source: ABdhPJxtIBOTRLN9HS/jsuEfgIM8JMds8s+EONsm+LnRxHHK/RVXYRcMV3k9GMV6qaX+GMUF3bv0rQ==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr2970581wmi.75.1594713501662;
        Tue, 14 Jul 2020 00:58:21 -0700 (PDT)
Received: from [192.168.1.145] ([213.147.166.141])
        by smtp.googlemail.com with ESMTPSA id w13sm27857797wrr.67.2020.07.14.00.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 00:58:21 -0700 (PDT)
Subject: Re: "missing data block" when converting ext4 to btrfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <90fff9c0-36c5-d45c-d19b-01294fc93b1e@gmail.com>
 <763ee221-92fa-a84c-db8e-9d05e88bab0c@gmx.com>
From:   Christian Zangl <coralllama@gmail.com>
Message-ID: <09c51964-9762-a7a7-02c3-ac398790ff0d@gmail.com>
Date:   Tue, 14 Jul 2020 09:58:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <763ee221-92fa-a84c-db8e-9d05e88bab0c@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-07-14 08:10, Qu Wenruo wrote:
> 
> 
> On 2020/7/14 上午3:46, Christian Zangl wrote:
>> I am on a test VM where I am trying to convert a second disk to btrfs.
>>
>> The conversion fails with the error missing data block for bytenr
>> 1048576 (see below).
>>
>> I couldn't find any information about the error. What can I do to fix this?
>>
>> $ fsck -f /dev/sdb1
>> fsck from util-linux 2.35.2
>> e2fsck 1.45.6 (20-Mar-2020)
>> Pass 1: Checking inodes, blocks, and sizes
>> Pass 2: Checking directory structure
>> Pass 3: Checking directory connectivity
>> Pass 4: Checking reference counts
>> Pass 5: Checking group summary information
>> /dev/sdb1: 150510/4194304 files (0.5% non-contiguous), 2726652/16777216
>> blocks
>>
>> $ btrfs-convert /dev/sdb1
>> create btrfs filesystem:
>>          blocksize: 4096
>>          nodesize:  16384
>>          features:  extref, skinny-metadata (default)
>>          checksum:  crc32c
>> creating ext2 image file
>> ERROR: missing data block for bytenr 1048576
>> ERROR: failed to create ext2_saved/image: -2
>> WARNING: an error occurred during conversion, filesystem is partially
>> created but not finalized and not mountable
> 
> Can btrfs-convert -r rollback the fs?

No:

$ sudo btrfs-convert -r /dev/sdb1
No valid Btrfs found on /dev/sdb1
ERROR: unable to open ctree
ERROR: rollback failed

If I do `fsck -f /dev/sdb1` I get lots of errors:

t-arch:~$ sudo fsck -f /dev/sdb1
fsck from util-linux 2.35.2
e2fsck 1.45.6 (20-Mar-2020)
Resize inode not valid.  Recreate<y>? yes
Pass 1: Checking inodes, blocks, and sizes
Deleted inode 3681 has zero dtime.  Fix<y>? yes
Inodes that were part of a corrupted orphan linked list found.  Fix<y>? yes
Inode 3744 was part of the orphaned inode list.  FIXED.
Deleted inode 3745 has zero dtime.  Fix<y>? yes
Inode 3747 has INLINE_DATA_FL flag on filesystem without inline data 
support.
Clear<y>? yes
Inode 3748 was part of the orphaned inode list.  FIXED.
Inode 3748 has a extra size (6144) which is invalid
Fix<y>? yes
Inode 3751 is in use, but has dtime set.  Fix<y>? yes
Inode 3751 has imagic flag set.  Clear<y>? yes
Inode 3752 was part of the orphaned inode list.  FIXED.
Inode 3753 was part of the orphaned inode list.  FIXED.
Inode 3754 is in use, but has dtime set.  Fix<y>? yes
Inode 3755 was part of the orphaned inode list.  FIXED.
Inode 3755 has imagic flag set.  Clear ('a' enables 'yes' to all) <y>? yes
Deleted inode 3801 has zero dtime.  Fix ('a' enables 'yes' to all) <y>?
...

> If you can rollback, would you provide the ext4 fs image?

You mean the vmdk from VMware? I do have a backup.

Thanks!

Christian

> 
> Thanks,
> Qu
> 
>>
>> $ uname -a
>> Linux t-arch 5.7.7-arch1-1 #1 SMP PREEMPT Wed, 01 Jul 2020 14:53:16
>> +0000 x86_64 GNU/Linux
>>
>> $ btrfs --version
>> btrfs-progs v5.7
> 

