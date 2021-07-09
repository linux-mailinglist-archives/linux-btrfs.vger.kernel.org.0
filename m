Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9D3C1EBD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 07:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGIFG0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 01:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhGIFGZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 01:06:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A76C061574
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jul 2021 22:03:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p16so20861677lfc.5
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jul 2021 22:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=usvHdcFau3FDbd9UQbM0PiXzlAVwgs1VqIaObzDy+Tc=;
        b=kwnn+kTzaJ3cikN1+Cp9HcfAAmhMyfTb5bb4fQXRcN+M9PGQU473xpUT79Gy0au3hi
         rYHZPr3X+QsM+KHq2gXE5nOYgK17/Nn7gu0j2DcjuGWv+uVyM1pl7P6m1R+6+uJ5fqPc
         5aeEFgirycC/kqu1bzkKkK4BwcyHu3h7h5voC86n/h+Njk7dEb/gdUQXlM0y6AYw2WwT
         +wrUh6fRZOv4wyMQhJRFcs71OnIwM2kv8IwGyvZ9tNN3fDR1SbMZkWGBhSoKs1bWmIr0
         q8YdSUSghu0y+7Na6k9Vdhh8s3m8Q83fKtDld63kaEV3ApjWYiCtiaTleckyheqayqk8
         WrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=usvHdcFau3FDbd9UQbM0PiXzlAVwgs1VqIaObzDy+Tc=;
        b=b6ciAb/4YDIFe9EJzQFPHDXkL45+I/DgfZRzkIZGO9W4Fpg0XLD89EpjDDeX+dwxlW
         vTWkdsnEjAHY3B1T5QqhnA6bqDxxNVU4ZzYzdZpw3M0l2Jq8xRbm9LM3Aas0EdZ4ZDzM
         9D9Ts3GeYNgX/QehIPsv32C5XLzIY9aZkbET0VC/fIiWmZK8uTIneAdt05sNzxvso9rX
         QuQDsFnr/ceWyWIQ3E9tJq8Xq1lWY2hqQecZDwhdK1eVLBeG8oVwpPejs5R66dEX4MNy
         pZcmBz1SvBdOvMNthMx4w2rGS41smNuUljHKaX+WRH5B2hWlY+vDB21ENp8+EEc1eAJP
         VGoA==
X-Gm-Message-State: AOAM53262kjZ3siQM/O5nhH1crA51bqlFc01iOs7mDzFakuL49Mfdi7n
        7b7DfWqbc11BEFWsvTZONOeQqPvBSylqBA==
X-Google-Smtp-Source: ABdhPJwMlra2TxlUdHyoK5+mQFwrHvFggt9riHrtEWzFhkTSs0dSSiH+UOdn4Y+N2Lyjog2frNJD9A==
X-Received: by 2002:ac2:555b:: with SMTP id l27mr19204010lfk.445.1625807019657;
        Thu, 08 Jul 2021 22:03:39 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:9ca5:4d44:9b2e:67b5:791? ([2a00:1370:812d:9ca5:4d44:9b2e:67b5:791])
        by smtp.gmail.com with ESMTPSA id x11sm364079lfd.53.2021.07.08.22.03.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 22:03:38 -0700 (PDT)
Subject: Re: where is the parent of a snapshot?
To:     linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
Date:   Fri, 9 Jul 2021 08:03:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708213806.GA8249@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.07.2021 00:38, Ulli Horlacher wrote:
> 
> 
> This is btrfs v5.4.1 on Ubuntu 20.04:
> 
> I have created several snapshots of the btrfs root filesystem /mnt/spool:
> 
> root@unifex:~# df -HT /mnt/spool
> Filesystem     Type   Size  Used Avail Use% Mounted on
> /dev/loop0     btrfs   32T  258G   32T   1% /mnt/spool
> 
> root@unifex:~# btrfs filesys show /mnt/spool
> Label: none  uuid: 217ccc65-6ab9-44f0-b691-ec9bbcdd9496
>         Total devices 2 FS bytes used 238.70GiB
>         devid    1 size 14.55TiB used 161.02GiB path /dev/loop0
>         devid    2 size 14.55TiB used 101.00GiB path /dev/loop1
> 
> root@unifex:~# btrfs subvolume list -q /mnt/spool
> ID 30401 gen 193524 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_0000.daily
> ID 30424 gen 194441 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2100.hourly
> ID 30425 gen 194472 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2200.hourly
> ID 30426 gen 194497 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2300.hourly
> 

Is it really full list?

> 
> I have expected to see the parent_uuid as the uuid of the root subvolume.
> Where is parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2?
> 
> 


subvolume uuid is not shown by this command.
