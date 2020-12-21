Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C182DFAD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 11:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgLUKJb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 05:09:31 -0500
Received: from cloud.avgustinov.eu ([62.73.84.164]:60468 "EHLO
        cloud.avgustinov.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgLUKJb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 05:09:31 -0500
Received: from [192.168.178.177] (ip5f58a7ac.dynamic.kabel-deutschland.de [95.88.167.172])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by cloud.avgustinov.eu (Postfix) with ESMTPSA id 9B4A41064A34F
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Dec 2020 12:08:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=avgustinov.eu;
        s=default; t=1608545329;
        bh=kkZzDN7WEDR5XRK4tjyew/lMl95sLH9VCQqD/Cg3rGo=;
        h=Subject:References:From:To:Date:In-Reply-To:From;
        b=ux6cbRn4nsugPMzAaL2SPYw7DgG5Vpat/NK/bxDQn81iYFdE+oBsQI0RFeYxz+9CA
         jLyi0ucAqfNlRaF0oW82ZS2CyNYN9Zj8dBQaXQ/ZUHlFPvSR8x7ZY4HmDjEr/55yat
         fi0kMLGX848nkPNU+9bdCMEksLetIVRYx83Y/czFLyhun74hueNeEV+zHl+MnV6kOL
         zNhXNPrYlzDPGpEACplCX9YNIG0AbZKkdgJwiGMz0TAfYmKK2ImuV1gwQbeUa4W4vl
         hNC18/XrlZfEthKC738Up01N2vni1CbNj8BMgf3Oz7VhYisK2ohIZE3Bfte0LdBZLO
         PcadrX2r+/N6Q==
Subject: Fwd: "BTRFS critical: ... corrupt leaf" due to defective RAM
References: <6f36a628-21f9-ca21-bae3-2a4150245ec2@avgustinov.eu>
From:   "Nik." <btrfs@avgustinov.eu>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
X-Forwarded-Message-Id: <6f36a628-21f9-ca21-bae3-2a4150245ec2@avgustinov.eu>
Message-ID: <0e4cb41f-c1bf-539a-dc19-8df234e0d0e7@avgustinov.eu>
Date:   Mon, 21 Dec 2020 11:08:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6f36a628-21f9-ca21-bae3-2a4150245ec2@avgustinov.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear all,

the forwarded mail below came back yesterday with the error 
"Diagnostic-Code: X-Postfix; TLS is required, but was not offered by 
host vger.kernel.org[23.128.96.18]".

Is it really intended that your mail server does not offer TLS?

Kind regards,

Nik.

--

15.12.2020 18:40, Nik.:
> Dear all,
>
> after almost a year without problems I need again your advice about 
> the same computer, but this time it is (hopefully only) the root FS 
> that failed. I have backups of everything except a couple of files in 
> /etc, so nothing critical, but probably it would be interesting for 
> somebody to see how behaved btrfs in such a situation.
>
> The story in short:
>
> - the FS switched to ro mode. Initially I thought that it is due to 
> insufficient free space (have already had similar situations) and 
> deleted some old snapshots. Within half a day it happened 3 more 
> times, though.
>
> - so I booted in memtest86 and it gave me a lot of errors! This NAS is 
> 9 years old and I was already looking for replacement, but it is not 
> easy to find 8-bay NAS for 2,5" drives...
>
> - took the drive out from the failed system and tried to mount it on 
> another (healthy?) PC. I am getting:
>
> root@ubrun:~# mount -t btrfs -o subvol=@ /dev/sdb1 /mnt/sd
> mount: /mnt/sd: wrong fs type, bad option, bad superblock on 
> /dev/sdb1, missing codepage or helper program, or other error.
> root@ubrun:~# dmesg |tail
> [   50.672561] Policy zone: Normal
> [  185.190764] BTRFS info (device sdb1): disk space caching is enabled
> [  185.190767] BTRFS info (device sdb1): has skinny extents
> [  185.199331] BTRFS info (device sdb1): bdev /dev/sdb1 errs: wr 0, rd 
> 0, flush 0, corrupt 65, gen 0
> [  185.246051] BTRFS critical (device sdb1): corrupt leaf: 
> block=50850988032 slot=79 extent bytenr=50496929792 len=16384 unknown 
> inline ref type: 54
> [  185.246055] BTRFS error (device sdb1): block=50850988032 read time 
> tree block corruption detected
> [  185.247070] BTRFS critical (device sdb1): corrupt leaf: 
> block=50850988032 slot=79 extent bytenr=50496929792 len=16384 unknown 
> inline ref type: 54
> [  185.247073] BTRFS error (device sdb1): block=50850988032 read time 
> tree block corruption detected
> [  185.247093] BTRFS error (device sdb1): failed to read block groups: -5
> [  185.281382] BTRFS error (device sdb1): open_ctree failed
> root@ubrun:~#
>
> How should one proceed?
>
> Kind regards
>
> Nik.
>
