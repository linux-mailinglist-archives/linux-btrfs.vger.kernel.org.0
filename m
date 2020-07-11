Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8306421C5F5
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 21:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgGKTjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 15:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgGKTjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 15:39:15 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3D0C08C5DD
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 12:39:15 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 145so8612800qke.9
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=TfjL72+RBxp62DutfgHBH60BboQpJBSMlmtkLQ16p/M=;
        b=SQO4tZKxMss0UHhQVMgHHT0CcU7tsELOiebbqpHT523I+Ou1Wh2mEoaOq0HP5yH9k2
         BHbDSwfAkRuoEFEgw3aFeKvuyPNIXiVk9RYEFTiiD6rq6VUep1Svcj3cj0gp+Hfd1TDV
         CaCTToeTSo7DHbAFl09oeXWs9t41a/7gAqmuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=TfjL72+RBxp62DutfgHBH60BboQpJBSMlmtkLQ16p/M=;
        b=Qd0gVjLHLLpuh9SRuJxnZ6Slp4Pu0vMxSAkr69CaADO5CrMEPkB6SkVvnMBGOQnC/Q
         9bRgR6m1bJkHfRI7e2b9MY0h8bfgebfAOUbsMl1ptHzNQRI7uPLfdf6zN9/9V8S85U2v
         250yemzfekUCkMvFkDlXIE73KiSOpUnrCyT0nUoTvC3Hiasi7/u6bBqpRMQw1YQ0jJFp
         0ihcF3QE6nLDM6Q9g4wUzfTXBFWa9N+8LBiRUoTXSllwoiaFm+Wy5HPpbGL4c6np+Wro
         tPWzHOhw6VVYPASptWVw47ULrJYu36b20QNAefcJ1Wp5OdnI+3NOMsoTslHtRe0diVv9
         Gw7w==
X-Gm-Message-State: AOAM533FjhxArGKMAbUkngmprLF+8HW8fUANto4iMgOVKRhsJ0KEb/iM
        o8n2ngRj9Uqh1Fm54aIO6lqF97x1EhPezg==
X-Google-Smtp-Source: ABdhPJzdlXdg4rf20bdXQ+x4lTZ/IG37SpPoBxvH4EE2nOEhQt918Z8dr3z3Y2yYF+9z+kxTcHv8+g==
X-Received: by 2002:a37:27d6:: with SMTP id n205mr75576557qkn.379.1594496353410;
        Sat, 11 Jul 2020 12:39:13 -0700 (PDT)
Received: from [192.168.1.9] (pool-72-83-172-153.washdc.east.verizon.net. [72.83.172.153])
        by smtp.gmail.com with ESMTPSA id z60sm12145138qtc.30.2020.07.11.12.39.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 12:39:12 -0700 (PDT)
From:   Peter Foley <pefoley2@pefoley.com>
Subject: balance failing with ENOENT
To:     linux-btrfs@vger.kernel.org
Message-ID: <5bc91ff8-1764-203d-53e1-a691b1b5abf9@pefoley.com>
Date:   Sat, 11 Jul 2020 15:39:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
I've got a btrfs filesystem that started out using the single profile.
I'm trying to convert it to raid1, but got a strange error when doing so.
Note that this only started happening after the initial balance got canceled part-way through.

btrfs balance start -dconvert=raid1,profiles=single /
ERROR: error during balancing '/': No such file or directory
There may be more info in syslog - try dmesg | tail

dmesg says:
[10431.408369] BTRFS info (device sda3): balance: start -dconvert=raid1,profiles=single                                                                                                                                               [10431.409123] BTRFS info (device sda3): relocating block group 968545533952 flags data
 [10451.745239] BTRFS info (device sda3): found 11 extents, stage: move data extents
 [10451.902138] BTRFS info (device sda3): balance: ended with status: -2         

uname -a
Linux bronx 5.8.0-rc4-x86_64 #1 SMP Sat Jul 11 07:11:35 EDT 2020 x86_64 Intel(R) Xeon(R) E-2246G CPU @ 3.60GHz GenuineIntel GNU/Linux
btrfs --version
btrfs-progs v5.7

btrfs fi sh
Label: 'Root'  uuid: 156efd3b-cefd-42af-a4af-1cd218c5a22a
Total devices 4 FS bytes used 608.02GiB
devid    1 size 930.51GiB used 296.00GiB path /dev/sda3
 devid    2 size 931.51GiB used 281.00GiB path /dev/sdb1
devid    3 size 1.82TiB used 874.03GiB path /dev/sdd1
devid    4 size 931.51GiB used 431.03GiB path /dev/sdc1
Label: 'Archive'  uuid: 171f2e70-6771-4942-9f4a-5261d73e9722
Total devices 4 FS bytes used 1.29TiB
devid    3 size 931.51GiB used 711.03GiB path /dev/sde1
devid    4 size 931.51GiB used 701.03GiB path /dev/sdh1
devid    5 size 931.51GiB used 701.00GiB path /dev/sdf1
devid    6 size 931.51GiB used 649.00GiB path /dev/sdg1

bronx ~ # btrfs fi df /
Data, RAID1: total=870.00GiB, used=469.18GiB
Data, single: total=138.00GiB, used=137.79GiB
System, RAID1: total=32.00MiB, used=176.00KiB
Metadata, RAID1: total=2.00GiB, used=1.05GiB
 GlobalReserve, single: total=512.00MiB, used=0.00B
WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
WARNING:   Data: single, raid1

Even trying a "normal" balance fails with the same error:
time btrfs balance start -dprofiles=single /
ERROR: error during balancing '/': No such file or directory

[11076.509514] BTRFS info (device sda3): balance: start -dprofiles=single
[11076.510181] BTRFS info (device sda3): relocating block group 968545533952 flags data
[11096.983827] BTRFS info (device sda3): found 11 extents, stage: move data extents
[11097.176551] BTRFS info (device sda3): balance: ended with status: -2                

Any ideas about what's going on here?

Thanks,

Peter                   
