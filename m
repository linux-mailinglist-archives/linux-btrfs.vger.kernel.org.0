Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5FD44FD5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 04:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhKODLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 22:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhKODLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 22:11:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2632C061746
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Nov 2021 19:08:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso11680379wms.3
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Nov 2021 19:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/v4+kL0ukpKtB6PCdntz6v7i7VD5fl62cACslVzVBzA=;
        b=XCHqPZh8hErf8N+7TupFFkRzfOMYcfyrWAubI3HxUt2Lp/SCfHrMCqPp3slM5F/D7k
         /TmcUvv8KjgTfJhLT9RbpPQzfj8NsbvjoepFjpvGxTGuQQu0os+CvQ9ZSiBry96bmN5t
         pXaNBWBbkRBW9DlFIKN0j/j3JCxVtcpT+ZIC5u6o8PSFthEZXPKKBAoxUxDcxqVVulND
         G8Hn4y/OumiF5tx6JM/w5DGe2c6/GriTHyP/may5TAq5+lvO+Eg2s8IP0jIkxnim8YBi
         nlJcRowE8VbIQlFYWmISTGcU6skumZaRRR9+btle23wyBO+c1PM204CzpXDWzMR+aTa9
         1Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/v4+kL0ukpKtB6PCdntz6v7i7VD5fl62cACslVzVBzA=;
        b=kPCxYkK5ebS/u0siC4i+MoG6VvCWR0jFaBWyWm4BtMtU1HW5r/J3eB1eNmUwArqhBi
         o57Ja6+Qm8FhrQ2vkFW6l1LoGcvka3df1SClMixYW1PMK42+V1230PQtLyYmS5xTRyoA
         WihOOJw5F32qu6KENyfZn9Ratiq69VCzO0sHUD2jgaNOjyrMOOL11Rsilpd3CMJHlFl4
         4lfOYQG6ndgDyOspezlzsJvHjRor5vd40QYQmuSHjcwCJM4FVcljk10VkodVfGHAz3zr
         7b/tNGkozOVNBaSPn+xyjiAYspeABeX7a+u2muYAJQQaPj49TI3X8IlQbuS7ujSs9Mb0
         h7FQ==
X-Gm-Message-State: AOAM531wNYOj67Kc4KeJHFs/XB4vAWq/BGd+fCYvnty3QQkO7cy0R2iq
        F/VwN9XJwe1WXwZ4S6tgSps=
X-Google-Smtp-Source: ABdhPJxqCSA/NLG9MGJwGU3a9YF70uuR3+pM1coJ3oUFvxatOR4/0GBODUMGfgBZ5g57x66CEJVZtw==
X-Received: by 2002:a7b:c257:: with SMTP id b23mr38465339wmj.67.1636945707021;
        Sun, 14 Nov 2021 19:08:27 -0800 (PST)
Received: from [127.0.0.1] (tmo-108-120.customers.d1-online.com. [80.187.108.120])
        by smtp.gmail.com with ESMTPSA id z8sm13486982wrh.54.2021.11.14.19.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 19:08:26 -0800 (PST)
Date:   Mon, 15 Nov 2021 03:08:24 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     Pascal <comfreak89@googlemail.com>, linux-btrfs@vger.kernel.org
Message-ID: <59e6afec-09c7-4d21-b31e-6ea759ff34d1@gmail.com>
In-Reply-To: <123daa93-9354-4df2-8c6b-be403e6ce8bc@dirtcellar.net>
References: <CADSoW+KdEuw7qd=dfvL-nCWF_AECVfY3oY5UGzdhm1=uvjA6JA@mail.gmail.com> <123daa93-9354-4df2-8c6b-be403e6ce8bc@dirtcellar.net>
Subject: Re: Failed drive in RAID-6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <59e6afec-09c7-4d21-b31e-6ea759ff34d1@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It actually says that device 13 is missing:

root@proxmox:~# btrfs fi show
warning, device 13 is missing

Afaik there is a patch in the works that improves the message including the last known device path (/dev/sdh e.g.)

Nov 14, 2021 22:53:59 waxhead <waxhead@dirtcellar.net>:

> Pascal wrote:
>> Hi,
>> I have a failed drive in my RAID-6 with Metadata C3.
>> I am able to mount the filesytem via mount -o degraded /dev/sda /mnt/data/.
>> How can I remove the disk from the filesystem? The failed disk is a 8TB drive.
>> Do I have to replace it with a new one (only smaller size available)?
>> I would like just to remove the drive - I should have plenty of free
>> space available, even when the drive is missing afterwards.
>> 
> No you do not have to replace the drive. And if you do, you can use a smaller drive. Note that BTRFS "RAID" is close, but not really RAID in the traditional sense. You might as well call it BTRFS-RAID, Fred or Barney because it is NOT your off the shelve RAID implementation.
> 
> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices
> 
> By the way , I am just a regular BTRFS user, so be warned. Do not blindly follow my advice - i have not toyed around with raid5/6 in years. (I suggest waiting for a follow up response if you can). However, you remove missing devices with:
> btrfs device delete missing /mnt/data
> (I think you have to physically remove the device for that to work as you expect.)
> 
> It is very annoying that btrfs does not show WHICH devices are missing, but if you know that only one drives is faulty it should be straight forward.
> 
> After that I would have have run a scrub to ensure that all is good.
