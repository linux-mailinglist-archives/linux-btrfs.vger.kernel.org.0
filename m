Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202133262F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 03:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfFCBgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jun 2019 21:36:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:53599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfFCBgH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Jun 2019 21:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559525764;
        bh=5wA63SjPeQlo+yaMFeAj+4MN8pZ8jHhLueIzt59Au2c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=g7SKwy1+MDAyvt+JP9OGH35SLJ3Qq9Ri1u1dNvOTD+W1DzRWAD0K/0wqU3wiYPDkl
         AqGPa/uVG5+6PaYxOEyztJ2Pk2LoPLL/I7bRXGCaUiJ0SlJL8+1JLVeTfu05iz0O9q
         7Jd5zCcCTp1ksGhzWnefhJlShglBmr+2bPSSRIe0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.113] ([34.92.239.241]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGeB-1h7w2a1EDD-00RG52; Mon, 03
 Jun 2019 03:36:04 +0200
Subject: Re: 'watch btrfs fi show' crash while 'btrfs device delete'
To:     Peter Hjalmarsson <kanelxake@gmail.com>, lists@colorremedies.com
Cc:     linux-btrfs@vger.kernel.org
References: <CALpSwpiYWtje4dDKeOuXVFFguYLKN62+A-3XipV0iaZBz6sG+g@mail.gmail.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <14176e70-91cf-8d4b-7d71-0b17fe777f8a@gmx.com>
Date:   Mon, 3 Jun 2019 09:35:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALpSwpiYWtje4dDKeOuXVFFguYLKN62+A-3XipV0iaZBz6sG+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q7g3adyMadr30zcE23iE4oMbwtRXCMGTfa4rCNsqqQZ09dWW078
 66jEP/YtYyS5GmSsuYet04jOx0Aqv+KAo+NaqUIQWopNkBOEuPIpuPGoKLH8uKLq20fDwPf
 bpyu2m0WNDlmJv2gsZawW8c2k0YsU+fjmn8imi3FsiPbIK6okvBEPjGSR+T5Pju/6oR1HtS
 55oQaE1SfZIEMu80ryzfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UXKq4eXfDHE=:78PmeWmdJP67YVfJV5cZWf
 gnA0AA45A+mSboT1jM6Xsv6A3c6blMpN3LEeovBfrZliaqGywVITVMXFPuxF0yTw6eQZZJY2B
 OMkXpUqCdM6IftjOVn/ZSFUATh5svo73zMMYEBTn7keEA3es3BBK3HABrtYp3Qk33zVD+sunK
 d7fxMJvNzmkZ4XviJCN91jvxKfnBkseBB0o3RUXjcszxuOkr3Dpwl6JEZXm+7HkqEryqjjTw2
 eDKuSPHCU6ttmG91em0Ohz/Tdfx7qWvf4L2wHXJaGZblA5dzXnNDzWaGX2gKeM2tWhh5lG1J7
 8RfkONQeFKKX/oaFsQgqgSm30ZsnUdJERbVwFHpl34iFE8qPft42IjHxzeBJGLd9PvHNr3WTW
 T64BRFjv+elG7i7mCAcOOP91Ux9NNbv28l95yfHkW3mzjat1Q1PRXGhga9hFlpADxG1eNXtOb
 EVQBE9RkVSMMB6MwB8YpG66PdVEpv+xQyFUSlt+ZWU9IPNCo/CFcyppgFEtrhvz5MDevKlQUw
 RaHQ0heiRYko+ixxy9cqxai/rowpJ/BvtIiUN6U683S+TXLBDk+spzoDpdUO8L2ChVtSyT/ug
 Zv5mFZhHJ2lkM0So5HPomNdzC3Qi4SWUvx6v7Ik5aIxP/XuPfvurB7qjjBaMQoSAfFx1c8kGI
 me8nN9X/65ttttJJv6Wd9XkuOnkSkUJCKblnM1j5aPGHxWQ2X0WUL1YskDPjjZcixoXXz7p/+
 yj9SRU4ltxBZUFJzRURhi6ZJ2s4e7s8hrFpyoyZCAj5miDGz2ArreCf08Gz4NI5aXIoqjeXwk
 +RQAsro5lbwV7KMoECRAFy3TpQ+BLbR0s6wS5F8K/6cG0HQ4c7DEO8pNEK+UfujUWkjZIO58R
 W5DY6L2WFIQzA8ZtFUoPKKyjoQWfAPAbhAtqHuKAt6/0awwIP1h5Mn3p/Vtgm48lBfM/m22UA
 p8xnKe4lUn3MyWP9OpMXctlq3P21kJrCRpxfxYoEknyYTpFMp7NuH
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/6/1 8:35 PM, Peter Hjalmarsson wrote:
> Hi,
>
> I was the one reporting the issue to the Red Hat Bugzilla, and was
> able to reproduce it as well
>

Thanks for the report,  reproduced the bug following your steps.
I just sent a patch named "btrfs-progs: fix invalid memory write in
get_fs_info()". It should fix the bug (at least in my test machine).

Could you try it? It won't spend much time since the fix is just
for btrfs-progs.


=2D--
Su
> The problem is related to resizing a btrfs filesystem (at least with
> the helpf of "btrfs dev del") and being able to hit "btrfs fi sh" at
> the same time as the size is changed..
> Something in the logic for "btrfs filesystem show" will run some tests
> against the size of the filesystem, and if there are mismatches in
> their results (like in a before and after removing a device) then the
> btrfs tool will SIGABRT
> I think that the btrfs tool could handle this more pretty, like giving
> a message "device resize in progress" istead of SIGABRT.
>
> The oiginal system is a x86_64 based machine with a couple of HDDs in
> a btrfs raid setup.
>
> I was able to reproduce this on the following testsystem:
> A Raspberry pi 3 running Fedora 30 aarch64 from SD-card
> The two HDDs partitioned in two equal sized partitions for a total of
> four partitions
> The testsystem was used since when using SSD or a RAM-based storage it
> seems it is harder t hit this (possibly due to access-speeds
> involved).
>
> After this I ran:
> # mkfs.btrfs -d raid1 -m raid1 /dev/sd[a-b][1-2]
> <..>
> # mkdir /mnt/test && mount /dev/sda1 /mnt/test
> # btrfs fi df /mnt/test/
> Data, RAID1: total=3D1.00GiB, used=3D0.00B
> System, RAID1: total=3D8.00MiB, used=3D16.00KiB
> Metadata, RAID1: total=3D1.00GiB, used=3D112.00KiB
> GlobalReserve, single: total=3D16.00MiB, used=3D0.00B
> # btrfs fi sh
> Label: none  uuid: c34e4190-674b-4111-ba37-8128c1f120f4
>          Total devices 4 FS bytes used 128.00KiB
>          devid    1 size 149.04GiB used 1.00GiB path /dev/sda1
>          devid    2 size 149.04GiB used 1.00GiB path /dev/sda2
>          devid    3 size 149.04GiB used 1.01GiB path /dev/sdb1
>          devid    4 size 149.04GiB used 1.01GiB path /dev/sdb2
> # btrfs dev del /dev/sda2 /mnt/test
> # btrfs dev del /dev/sdb2 /mnt/test
> # btrfs dev add /dev/sda2 /mnt/test
> # btrfs dev add /dev/sdb2 /mnt/test
> # btrfs fi sh
> Label: none  uuid: c34e4190-674b-4111-ba37-8128c1f120f4
>          Total devices 4 FS bytes used 640.00KiB
>          devid    1 size 149.04GiB used 2.03GiB path /dev/sda1
>          devid    3 size 149.04GiB used 2.03GiB path /dev/sdb1
>          devid    4 size 149.04GiB used 0.00B path /dev/sda2
>          devid    5 size 149.04GiB used 0.00B path /dev/sdb2
>
>
> This makes it possible to maximize the amount of device add/remove
> from a volume, as removeing any of sda2 or sdb2 does not require
> moving any big amount of data, and the add/remove seems to be what
> triggered the behaviour from "btrfs fi sh".
> Then I ditch "watch" and run a sime "while true"-loop for "btrfs fi
> sh" to prevent that the device add/remove happends while watch does it
> 2 s sleep.
>
> So after this I start the following in one shell:
> ---
> i=3D"0"
> while true
> do echo $((i++))
> btrfs dev del /dev/sda2 /mnt/test/
> btrfs dev add /dev/sda2 /mnt/test/
> btrfs dev del /dev/sdb2 /mnt/test/
> btrfs dev add /dev/sdb2 /mnt/test/
> done
> ---
>
> And in the other shell:
> ---
> while btrfs fi sh ; do true ; done
> ---
>
>
> Often the last commando does not need to go for more then 3 to 4 times
> before a message like the following:
>
> corrupted size vs. prev_size
> Aborted (core dumped)
>
> This one leave the following in the journal:
> May 24 13:57:14 localhost systemd-coredump[3198]: Process 3193 (btrfs)
> of user 0 dumped core.
>
>                                                        Stack trace of
> thread 3193:
>                                                        #0
> 0x0000ffffb669fca0 raise (libc.so.6)
>                                                        #1
> 0x0000ffffb668daa8 abort (libc.so.6)
>                                                        #2
> 0x0000ffffb66d9a0c __libc_message (libc.so.6)
>                                                        #3
> 0x0000ffffb66dffd4 malloc_printerr (libc.so.6)
>                                                        #4
> 0x0000ffffb66e0730 unlink_chunk.isra.0 (libc.so.6)
>                                                        #5
> 0x0000ffffb66e193c _int_free (libc.so.6)
>                                                        #6
> 0x0000ffffb6709c40 closedir (libc.so.6)
>                                                        #7
> 0x0000aaaab1debf48 close_file_or_dir (btrfs)
>                                                        #8
> 0x0000aaaab1dece00 get_fs_info (btrfs)
>                                                        #9
> 0x0000aaaab1e027cc btrfs_scan_kernel (btrfs)
>                                                        #10
> 0x0000aaaab1dcc8dc main (btrfs)
>                                                        #11
> 0x0000ffffb668deec __libc_start_main (libc.so.6)
>                                                        #12
> 0x0000aaaab1dccad8 .annobin_stubs.c_end.startup (btrfs)
>                                                        #13
> 0x0000aaaab1dccad8 .annobin_stubs.c_end.startup (btrfs)
> May 24 13:57:14 localhost kernel: BTRFS info (device sda1): device
> deleted: /dev/sdb2
>
>
> I also get this from time to time:
>
> free(): invalid next size (normal)
> Aborted (core dumped)
>
> May 24 14:02:32 localhost systemd-coredump[5153]: Process 5148 (btrfs)
> of user 0 dumped core.
>
>                                                        Stack trace of
> thread 5148:
>                                                        #0
> 0x0000ffffa1491ca0 raise (libc.so.6)
>                                                        #1
> 0x0000ffffa147faa8 abort (libc.so.6)
>                                                        #2
> 0x0000ffffa14cba0c __libc_message (libc.so.6)
>                                                        #3
> 0x0000ffffa14d1fd4 malloc_printerr (libc.so.6)
>                                                        #4
> 0x0000ffffa14d3920 _int_free (libc.so.6)
>                                                        #5
> 0x0000aaaac0ed18c8 btrfs_scan_kernel (btrfs)
>                                                        #6
> 0x0000aaaac0e9b8dc main (btrfs)
>                                                        #7
> 0x0000ffffa147feec __libc_start_main (libc.so.6)
>                                                        #8
> 0x0000aaaac0e9bad8 .annobin_stubs.c_end.startup (btrfs)
>                                                        #9
> 0x0000aaaac0e9bad8 .annobin_stubs.c_end.startup (btrfs)
> May 24 14:02:32 localhost kernel: BTRFS info (device sda1): device
> deleted: /dev/sda2
>
> Please ask if you need more info.
>
> Best Regard,
> Peter
>


