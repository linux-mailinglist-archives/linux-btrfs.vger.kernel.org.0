Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39426AAB06
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfIESbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 14:31:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35159 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbfIESbO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Sep 2019 14:31:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so4256455wmj.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2019 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kKfx8Qn+R53UEKQsUsEkzEb20MEjAK3o1P0ios9M9TM=;
        b=OdWsvrei0BuxyFYz5hR/9t6bKYqGMM0GjXkr/pdPy1ngRavYtd7XfI3F9n4w0h6Sb/
         yzbygD78FIs4mOKLVXvP6tvKNR7ihl//1YxRn+O951kifCTJInIU1WYT/UXxWkVJgbsq
         YbdTuyhb8AMwFnQu/7XFkQTYRcI0FirKbrQUmuisT1KkxEBEMscnpFSVzeUPFOUfnVaH
         RRblJv/NrFhlsE+KAMQ8YIcWlzae4L5Vxw7bTXPoT2Nm+t15cvK44tIO1WcqdaEtWuwC
         M4zh3WfGYz274zVmR7mngAfGwWvrNv2AUChKVWrj48apmpBNR5xmUseLNlZIdbS2cfJY
         vqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kKfx8Qn+R53UEKQsUsEkzEb20MEjAK3o1P0ios9M9TM=;
        b=pvCiLztoZl3ybiKv+Gu6wEl4bvrkTawTvZXaI5CXt4kLslLOQA5bB6VII5DLWA5R6V
         POTVWQqq8/SDipfoFw6D7Y8+9oRAvi46j+PiLdoBbi869CNe9u8eN1A1smK5M9qWg2mx
         BG5iwboYjOWWLRteYvL8tO8AhGqfmluYZD+MS+JNpdQhthhL1LjGH53U43ho1VafRBnK
         0ZN1bxOXMS0BQxOqISg+fiS4MQMwrDzx3B8XSDkbSNo86nCUtIXMIkd8aF9ormVCUW4J
         rPYZIHIXP1qV1AfyQ5Xch2PwlhyjUYV153dOUOOVAQfnH/j0dzW6HvJHdwZPOTBoY+H7
         WGfw==
X-Gm-Message-State: APjAAAXNVBfzn7i4P94KcowQISgx7EXSFIQ17jq3d068Z8qUIJ5zCG/o
        W3ndtzIIxMbHVIAv88lEILpIRlq27yc=
X-Google-Smtp-Source: APXvYqwG99rgVCInrr3gwXNnwVvP5TflDxYHIMEC263VGU9li3/VX/m0fkoFRDjqj7D54fFHI34dfg==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr4348503wmc.31.1567708270287;
        Thu, 05 Sep 2019 11:31:10 -0700 (PDT)
Received: from ?IPv6:2a01:5c0:e097:52b0:8a:95c4:7163:dc35? ([2a01:5c0:e097:52b0:8a:95c4:7163:dc35])
        by smtp.googlemail.com with ESMTPSA id o3sm3626009wrv.90.2019.09.05.11.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 11:31:09 -0700 (PDT)
Subject: Re: No files in snapshot
To:     Thomas Schneider <74cmonty@gmail.com>,
        Chris Murphy <lists@colorremedies.com>,
        Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
 <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com>
 <f22229eb-ab68-fecb-f10a-6e40c0b0e1ef@gmail.com>
 <CAJCQCtRPUi3BLeSVqELopjC7ZvihOBi321_nxqcUG1jpgwq9Ag@mail.gmail.com>
 <423454bc-aa78-daba-d217-343e266c15ee@georgianit.com>
 <CAJCQCtSG9W93dWwH7++dBGh94s6UGGbugrW8y17OmycC5wP8kw@mail.gmail.com>
 <a6b8e96a-6b66-be0e-e44d-2b65ab7cb2b9@googlemail.com>
 <dd2b4a48-662f-67dd-594c-482f25899d65@gmail.com>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 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
 KB7t2CoZv5xo0STm
Message-ID: <fc799347-31bb-348d-e762-8fd7d50de976@googlemail.com>
Date:   Thu, 5 Sep 2019 20:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <dd2b4a48-662f-67dd-594c-482f25899d65@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Thomas,

Am 05.09.19 um 10:50 schrieb Thomas Schneider:
> Hi,
> 
> I would agree with Oliver's conclusion:
> the relevant directories are all tmpfs mounts.

this of course easily explains it and btrfs can't do anything about these when snapshotting. 

In case you want to debug the issue in more detail (e.g. how to extract this information stored in tmpfs from LVM for example), we can of course take this to the ceph-users list (or contact me directly). 

Cheers,
	Oliver

> 
> root@ld5505:~# mount | grep /var
> /dev/sdbq3 on /var/cache type btrfs (rw,noatime,compress=lzo,ssd,space_cache=v2,subvolid=260,subvol=/@cache)
> /dev/sdbq3 on /var/lib/vz/images type btrfs (rw,noatime,compress=lzo,ssd,space_cache=v2,subvolid=262,subvol=/@images)
> lxcfs on /var/lib/lxcfs type fuse.lxcfs (rw,nosuid,nodev,relatime,user_id=0,group_id=0,allow_other)
> tmpfs on /var/lib/ceph/osd/ceph-122 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-123 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-105 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-92 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-112 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-77 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-76 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-87 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-119 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-79 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-115 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-98 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-100 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-89 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-108 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-120 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-82 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-118 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-104 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-95 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-1 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-96 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-117 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-116 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-99 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-106 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-110 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-97 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-81 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-121 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-88 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-0 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-94 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-113 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-107 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-101 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-78 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-93 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-85 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-103 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-102 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-109 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-114 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-80 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-111 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-83 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-86 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-91 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-84 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-90 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-8 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-9 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-10 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-11 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-12 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-13 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-14 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-15 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-16 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-17 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-18 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-19 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-20 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-21 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-22 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-23 type tmpfs (rw,relatime)
> tmpfs on /var/lib/ceph/osd/ceph-24 type tmpfs (rw,relatime)
> 
> 
> Am 04.09.2019 um 22:52 schrieb Oliver Freyermuth:
>> Am 04.09.19 um 21:07 schrieb Chris Murphy:
>>> On Wed, Sep 4, 2019 at 12:24 PM Remi Gauvin <remi@georgianit.com> wrote:
>>>> On 2019-09-04 1:36 p.m., Chris Murphy wrote:
>>>>
>>>>> I don't really know how snapper works.
>>>>>
>>>>> The way 'btrfs subvolume snapshot' works,  you must point it to a
>>>>> subvolume. It won't snapshot a regular directory and from what you
>>>>> posted above, there are no subvolumes in /var or /var/lib which means
>>>>> trying to snapshot /var/lib/ceph/osd/ceph-....  would fail. So maybe
>>>>> it's failing but snapper doesn't show the error. I'm not really sure.
>>>>>
>>>> In this case, his snapshots are all of the root.
>>>>
>>>> I don't know how Ceph works, but since we already confirmed that there
>>>> are no subvolumes under /var, the only other explanation is that
>>>> /var/lib/ceph/osd/ceph-<n> is a submount
>>>>
>>>> What is the the result of running:
>>>> mount | grep /var
>>>>
>>> Yep.
>>>
>>>
>> Looking at Thomas' mail on the Ceph-users list:
>> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2019-August/036679.html
>> I deduce he is using Ceph with the Bluestore backend, which indeed means that /var/lib/ceph/osd/ceph.<n>
>> are tmpfs mounts which are completeley ephemeral and are created from LVM metadata of the actual Ceph OSD disks.
>>
>> That would of course also explain why they are not part of any btrfs snapshot of / (and that also means there is no need to backup anything).
> 

