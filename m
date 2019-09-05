Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BE2A9D83
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 10:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfIEIuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 04:50:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38488 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731215AbfIEIuL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Sep 2019 04:50:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so1720047wrx.5
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2019 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3MDY27FOEg4bWkuA96DSCxnn0Fyrdt7HT14mK5VOesE=;
        b=Xu2pUhIV7ChgmLBel9FSxQr8TSYz8W+kubUguLNkrTnBuqNQcW57qOOXw/lG0iLSOh
         qkSsK5CtOHpzwLjRp4IVsDhp1+ilKrXnJnF/mCFLXTGwksJ1YISBrJN3M4opaLWC45K5
         Zk8g7tOa5zZkZV9/+SJutdYC5q/iIhsgG2/Mhq/W7NydKgtqtagmyYWaijZzJkoEjRmx
         IonYcQrGiw/+QkzhvGka2yEfh7Mkn3i/YSWu7O5HpUpjNnRSR7GXKZLINzUSpJaJCyam
         Ajw+zzndK+00wkB1VA/8PbrmxVbtJhAQi3QpBtshchi7GsS7XeMg5Fij/d/huat98VCV
         tRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3MDY27FOEg4bWkuA96DSCxnn0Fyrdt7HT14mK5VOesE=;
        b=kv8XFhDryGdeGsrn3hdcMmDvmnQdHqRI78O2IUjSN9Ezio401f5/cXx8azyZnhlS61
         cNaVBUi1sH/g6TlKdy28TXzkkDrr37QcX6noMahT2RNYVX7bR5LtntFqhFj/HItvKeIv
         Nes2jKw+qdfB8eI+TQ71j0IPaykmjDZEuzgCFtjoCKFMv2qmT62te1gLkBejXmenb5iQ
         bh/dLafTUl2OMcE/dO3n+areQ+KQepy98yzQgQFdSN9auMHKMBtbo97ZrFAwUuzQmPO6
         +OMR79zPwFBDyuMQZILYR3u3DVSHKqWxWprKTrZiIoblB1Xj4rwc8wU0JnXVbzw6mt1s
         FF5Q==
X-Gm-Message-State: APjAAAXsh2V+eP/basECZcLqj+BRwrG4OPSIuHQU6xpk3I8vg3Ei+AIN
        DlXaHskJ7mph4kfDq43UKLu5GAYx
X-Google-Smtp-Source: APXvYqyLXJaLXozgvv9tD60/Y7hhBuOFmWjlJhYt9Od/WI+gyjqTY8NTiMSxc6Qp0vhuv6rVXDaYGQ==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr1730364wrr.75.1567673408091;
        Thu, 05 Sep 2019 01:50:08 -0700 (PDT)
Received: from [10.19.90.60] ([193.16.224.12])
        by smtp.gmail.com with ESMTPSA id q19sm1414043wra.89.2019.09.05.01.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 01:50:07 -0700 (PDT)
Subject: Re: No files in snapshot
To:     Oliver Freyermuth <o.freyermuth@googlemail.com>,
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
From:   Thomas Schneider <74cmonty@gmail.com>
Message-ID: <dd2b4a48-662f-67dd-594c-482f25899d65@gmail.com>
Date:   Thu, 5 Sep 2019 10:50:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a6b8e96a-6b66-be0e-e44d-2b65ab7cb2b9@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I would agree with Oliver's conclusion:
the relevant directories are all tmpfs mounts.

root@ld5505:~# mount | grep /var
/dev/sdbq3 on /var/cache type btrfs 
(rw,noatime,compress=lzo,ssd,space_cache=v2,subvolid=260,subvol=/@cache)
/dev/sdbq3 on /var/lib/vz/images type btrfs 
(rw,noatime,compress=lzo,ssd,space_cache=v2,subvolid=262,subvol=/@images)
lxcfs on /var/lib/lxcfs type fuse.lxcfs 
(rw,nosuid,nodev,relatime,user_id=0,group_id=0,allow_other)
tmpfs on /var/lib/ceph/osd/ceph-122 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-123 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-105 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-92 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-112 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-77 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-76 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-87 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-119 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-79 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-115 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-98 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-100 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-89 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-108 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-120 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-82 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-118 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-104 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-95 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-1 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-96 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-117 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-116 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-99 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-106 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-110 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-97 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-81 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-121 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-88 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-0 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-94 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-113 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-107 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-101 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-78 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-93 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-85 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-103 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-102 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-109 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-114 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-80 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-111 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-83 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-86 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-91 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-84 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-90 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-8 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-9 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-10 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-11 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-12 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-13 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-14 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-15 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-16 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-17 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-18 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-19 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-20 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-21 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-22 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-23 type tmpfs (rw,relatime)
tmpfs on /var/lib/ceph/osd/ceph-24 type tmpfs (rw,relatime)


Am 04.09.2019 um 22:52 schrieb Oliver Freyermuth:
> Am 04.09.19 um 21:07 schrieb Chris Murphy:
>> On Wed, Sep 4, 2019 at 12:24 PM Remi Gauvin <remi@georgianit.com> wrote:
>>> On 2019-09-04 1:36 p.m., Chris Murphy wrote:
>>>
>>>> I don't really know how snapper works.
>>>>
>>>> The way 'btrfs subvolume snapshot' works,  you must point it to a
>>>> subvolume. It won't snapshot a regular directory and from what you
>>>> posted above, there are no subvolumes in /var or /var/lib which means
>>>> trying to snapshot /var/lib/ceph/osd/ceph-....  would fail. So maybe
>>>> it's failing but snapper doesn't show the error. I'm not really sure.
>>>>
>>> In this case, his snapshots are all of the root.
>>>
>>> I don't know how Ceph works, but since we already confirmed that there
>>> are no subvolumes under /var, the only other explanation is that
>>> /var/lib/ceph/osd/ceph-<n> is a submount
>>>
>>> What is the the result of running:
>>> mount | grep /var
>>>
>> Yep.
>>
>>
> Looking at Thomas' mail on the Ceph-users list:
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2019-August/036679.html
> I deduce he is using Ceph with the Bluestore backend, which indeed means that /var/lib/ceph/osd/ceph.<n>
> are tmpfs mounts which are completeley ephemeral and are created from LVM metadata of the actual Ceph OSD disks.
>
> That would of course also explain why they are not part of any btrfs snapshot of / (and that also means there is no need to backup anything).

