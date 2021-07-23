Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D303D407E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 21:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhGWSWR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 14:22:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ACEC061575
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jul 2021 12:02:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so4082759wmh.3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jul 2021 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesmariamoliner-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=oTO2SPf7Lds3IDzlBxAg6xNXTrrZ5v1vnVP+Pc3Znq0=;
        b=unjuJYS4ATfArG8MpXIcgFy2lorpcfZ2gikbTqgpuJdz+JwYbtQN7lHtaWWrRge4f5
         r3R+uMB6J6qCrmHi1yHjS4eXbaivSPIDRt96DDrbiIqlMXFn8GTcp7W0/6gFcN/Tx8hi
         vY4sMjTO+BT+wPrWJuatVTKLNjIsqArBLx0PKKzYi2BPkfuQp9pX6TA5yMo2nFaNTTrj
         FWIsy6ETi6NjSYzPTtEaxA7FA3M7Q0I6qiK4UAwAbfMKyWVUJn0f2ftnww+AQVZ+ph96
         K2pgkRLfoG6ULCVuJ16eMUu+QWOJdE58JqYUlqMh986s8v4JxDst8/lKPVWaGB6GAwh9
         S1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=oTO2SPf7Lds3IDzlBxAg6xNXTrrZ5v1vnVP+Pc3Znq0=;
        b=hXQbnJ4BxldsbIw/wJsNbdWv6F1Q3/fZyf3U/GhZfTsoHCk8SYLOGlaFeyprC2J1CY
         fYlE/WAOUbcDkZe5hr5d2aZSyqEVFfftQRDXInO8RYQKySJYeM1fvDIs6u4dUX0yQRlB
         ++VxGBTzs5twmuOzf1BTNpWi5NUtiwhw9YCimKv6BoVdP+VSteq5TdLK7pplmzr+Oe/L
         PCv0Bei5PiaOevxuyUhMEG5Npik8ktpSIdrjtg5qX9iCRdZTjfn3uIYkgqnV9EUsti+H
         cHZz2NJDrHfLsX15VBJTSgl+I7pJlR9woDl9Am13s4hrspC+eG2zL1vpm6g7JiNquiOo
         33dA==
X-Gm-Message-State: AOAM530+K5p6pbr3Ko9QK5FPoB9npkZUIelujfiiO3XA6Ok7R+fFoOvn
        6vFMtDU8o65s7iE4DFVtD426DjGNbs7uaA==
X-Google-Smtp-Source: ABdhPJwQ1uyYKvW8L/3lXonmm4CBpHD5b00at8MkfbpL6K1wdn2J4CVlk14DbMN1i9UElkW/1CbRdQ==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr16004342wmb.129.1627066951763;
        Fri, 23 Jul 2021 12:02:31 -0700 (PDT)
Received: from [192.168.2.3] (188.red-81-44-181.dynamicip.rima-tde.net. [81.44.181.188])
        by smtp.gmail.com with ESMTPSA id d18sm26727820wmp.46.2021.07.23.12.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 12:02:31 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Fernando Peral <fperal@iesmariamoliner.com>
Subject: Help Dealing with BTRFS errors on a root partition in NVMe M2 PCIe
Message-ID: <47feb886-8220-abb1-2245-06d6f37d4c0c@iesmariamoliner.com>
Date:   Fri, 23 Jul 2021 21:02:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.

I'm having an error on the root partition of a opensuse leap 15.3 system.

I have been asking for help in 
https://forums.opensuse.org/showthread.php/557380-Dealing-with-BTRFS-errors-on-a-root-partition-in-NVMe-M2-PCIe

The problem seems to have been caused by a faulty ram module wich has 
been already replaced, but the error of the fs is still there.

It has been suggested that it has been a bitflip and to ask here if  a 
btrfs check and repair should be done.



#btrfs
check --readonly --force /dev/nvme0n1p1
[1/7] checking root items
[2/7] checking extents
data backref 227831808 root 263 owner 7983 offset 0 num_refs 0 not found 
in extent tree
incorrect local backref count on 227831808 root 263 owner 7983 offset 0 
found 1 wanted 0 back 0x5559e0ab7020
incorrect local backref count on 227831808 root 263 owner 
140737488363311offset 0 found 0 wanted 1 back 0x5559dde718d0
backref disk bytenr does not match extent record, bytenr=227831808, ref 
bytenr=0
backpointer mismatch on [227831808 4096]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7]checking free space cache
[4/7]checking fs roots
[5/7]checking only csums items (without verifying data)
[6/7]checking root refs
[7/7]checking quota groups
Qgroup are marked as inconsistent.
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p1
UUID: 5b000355-3a1a-49f5-8005-f10668008aa7
Rescan hasn't been initialized, a difference in qgroup accounting is 
expected
found 51878920192 bytes used, error(s) found
total csum bytes: 48135312
total tree bytes: 991313920
total fs tree bytes: 885358592
total extent tree bytes: 48414720
btree space waste bytes: 151592274
file data blocks allocated: 239972728832
referenced 85539778560




pruebas:~# uname -a
Linux pruebas 5.3.18-59.13-default #1 SMP Tue Jul 6
07:33:56 UTC 2021 (23ab94f) x86_64 x86_64 x86_64 GNU/Linux


pruebas:~#btrfs --version
btrfs-progs v4.19.1  ç


pruebas:~# btrfs fi show
Label: none  uuid: 5b000355-3a1a-49f5-8005-f10668008aa7
        Totaldevices 1 FS bytes used 48.42GiB
        devid   1 size 931.51GiB used 51.05GiB path /dev/nvme0n1p1


pruebas:~#btrfs fi df /
Data, single: total=49.01GiB, used=47.48GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=2.01GiB, used=962.69MiB
GlobalReserve, single: total=101.06MiB, used=0.00B



