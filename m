Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4700E428432
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 01:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhJJX7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Oct 2021 19:59:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:36107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhJJX7u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Oct 2021 19:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633910261;
        bh=8fLIVIJM1t6xJ/8fZrSLYnWTNCJv2TePJcQnQ3rMOmE=;
        h=X-UI-Sender-Class:Date:To:References:Cc:From:Subject:In-Reply-To;
        b=VJNSfplxTXNYHr91n7o6g+gqgkW+WyA/inagv+84skTax3KNuZhjdq0drYmuYNmyX
         Y5o1banP8XAnJeiREJru2i/PWw820dNhma6+6VOx3mq1euCcNqopnJQK2o2pgIlIiW
         J1lEsc38sMy8nsyxzUWUUNhQyGkPRiw09ETatYRk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mv31W-1mrO2X09dg-00qy0F; Mon, 11
 Oct 2021 01:57:41 +0200
Message-ID: <c3b0c77a-f5e4-ccc2-f0b4-cf1a6491f29d@gmx.com>
Date:   Mon, 11 Oct 2021 07:57:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Ian Kelling <iank@fsf.org>, linux-btrfs@vger.kernel.org
References: <87ily8y9c8.fsf@fsf.org>
Cc:     Filipe Manana <fdmanana@kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: I got a write time tree block corruption detected
In-Reply-To: <87ily8y9c8.fsf@fsf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UDDgZfqsG7GWr6cD1p2PGDdQaHMahwGlFSKWdg2vPsbld0iveR6
 egLMeAkiMpPmn7BuFZ3HYNd7lXJ9kpfygPgJIZNU0g+8dutNb99tb8dOfyKncwV1DxFKNhl
 UKXc7zpzE0EHDy5maVs6m8tpmERV53nxIB+8I9sdsMBdAcykXP68ySHOnHpcpkKlRH6ThHe
 /JwMurJHVnYupnsbqw3QQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YcJTD9dmSH8=:vASSoBI2wHyvIkYdZJE7/X
 D4kWsi9BVOqfB7cf5lXXsXwNMk1DUAmdKqKYBQQMjmZlWlXMaD4obbvdWI3VEBStp7gRPncba
 d7v5JyCkeM4Tcf8k9RKyFvzM4Wl5f7YMq9e7MjlSnqNZOCpK60r/Hsh8Xv8e5vDy4VYQNFEeT
 YUjwH96VzKF/NNFogsVU8mXUwa817NwDL4GdwvbW0oKkMzkaw3b9BEaw23LuE+RzU5pMksIXE
 jY0Kmleg2EygjjlIzb+lXcXzwUt6u+yr6cbAO0ClC6J5YOabxJ6RctjQgudOPg/d87Lfwl3v/
 gen0dhdISHGxjXrG9Tux8iKHGdzAWqUH7SIWFXCEHyaAtryMSHUtUWHqJivfY3EC8s1A88jwv
 4m++VYS40MOvDktp98txnDeYoVjLF/V9FWoB4A+AXAVdlgvqYK5IgthQ95vWNd2k/CgmqIQth
 0VKqm9d4iKi+AXCySUEStrI/88/hZlU5Uzi+kZzC1MB9Ot9HoX77wl7CDC4gB6w8Fc1SnygMU
 de90r+qwELRNvA2K1no9z9x5svjp1INgV/6maEWpSXU1wK+cm7Rycl1wuKn+dj4tKv+WznAj6
 fPM7s3HzEXIH9XqO+L0fN3WBsgTKu9bHY05OVPv6YQXLh53vaIumw5dKIRxRJQr/57UrI39xh
 FPgQmwev06ug/QTQv2Ol6BlAWbz9yI6mA1otrcs45zYui0+YODhO0Z9dPJ3m4Tzd25jCc6mOh
 WCDESwL/7IM5EhCrtK4R3lCiSyGOXn1tyqjX+TA3i5ac0O538v7Mef7xV9yPhIvwVFwmytPLR
 nl4SDhK5RhyiwRymrgUWz0jLwvW5vv0/61jkSSYNH+kkoGUHDdwuKKA3yQhRxqPsYjb8RbUVl
 K8ljs0heCddy9881gGzFxNgjnvoMPG0ooLZUGC09ygKtQiOJWH3tWwVgvkzpABkHxFRbqnavR
 brzJM9gngNSmAG+ocO8C32uB4IVhPikELMExhfvu9n3CWm+2MgGXrS153l80nw5q8fEVpTqwv
 jZVzuFEzqQYtFR7p+nEKmcyGEHr+JScqwzMP8mzF2PBlifr422VLXANKTcVBGfBgiUrAQ9mSy
 RYMUjeLZLz0bXs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/8 02:32, Ian Kelling wrote:
> # uname -a
> Linux hostname.fsf.org 5.8.0-59-generic #66~20.04.1 SMP Sat Jul 10 19:20=
:41 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5.10.1
>
>
> I was running this command:
> btrfs balance start -dconvert=3Draid1c3 -mconvert=3Draid1c3 /srv/backup-=
online
>
> Note, the command was a bit of a mistake since the filesystem was
> already raid1c3 with 3 16tb disks. It failed after about a day, this was
> in dmesg:
>
> [Thu Oct  7 12:01:59 2021] BTRFS info (device dm-3): relocating block gr=
oup 17366831333376 flags data|raid1c3
> [Thu Oct  7 12:44:01 2021] ------------[ cut here ]------------
> [Thu Oct  7 12:44:01 2021] BTRFS: Transaction aborted (error -28)

This is the root cause, ENOSPC during balance.

This seems to be related to the metadata overcommiting bug that when
several different sized disks are involved, btrfs may have over-estimate
how much space its metadata can use.

Normally it won't cause long-lasting problem as long as you have enough
metadata space left.

For your RAID1C3 setup, you need at least 3 disks with enough
unallocated space.

[...]
>
> I unmounted the filesystem, then tried a remount like so:
> mount -o skip_balance /dev/mapper/btrfs0 /mnt/backup-tmp
> which failed, and the following was in dmesg:
>
> [Thu Oct  7 12:57:11 2021] BTRFS info (device dm-3): disk space caching =
is enabled
> [Thu Oct  7 12:57:11 2021] BTRFS info (device dm-3): has skinny extents
> [Thu Oct  7 12:58:08 2021] BTRFS info (device dm-3): start tree-log repl=
ay
> [Thu Oct  7 13:04:36 2021] BTRFS: error (device dm-3) in btrfs_replay_lo=
g:2362: errno=3D-22 unknown (Failed to recover log tree)
> 2021 Oct  7 13:04:36 monolith BTRFS: error (device dm-3) in btrfs_replay=
_log:2362: errno=3D-22 unknown (Failed to recover log tree)
> [Thu Oct  7 13:04:41 2021] BTRFS critical (device dm-3): corrupt leaf: r=
oot=3D5 block=3D5558935797760 slot=3D0 ino=3D161138910, invalid nlink: has=
 2 expect no more than 1 for dir
> [Thu Oct  7 13:04:41 2021] BTRFS info (device dm-3): leaf 5558935797760 =
gen 129446 total ptrs 88 free space 3 owner 5
> [Thu Oct  7 13:04:41 2021]      item 0 key (161138910 1 0) itemoff 16123=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40700
> [Thu Oct  7 13:04:41 2021]      item 1 key (161138911 1 0) itemoff 15963=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 2 key (161138913 1 0) itemoff 15803=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 3 key (161138914 1 0) itemoff 15643=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 4 key (161138916 1 0) itemoff 15483=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 5 key (161138918 1 0) itemoff 15323=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 6 key (161138919 1 0) itemoff 15163=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40700
> [Thu Oct  7 13:04:41 2021]      item 7 key (161138921 1 0) itemoff 15003=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 8 key (161138922 1 0) itemoff 14843=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 9 key (161138923 1 0) itemoff 14683=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 10 key (161138926 1 0) itemoff 1452=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 11 key (161138928 1 0) itemoff 1436=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 12 key (161138929 1 0) itemoff 1420=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 13 key (161138930 1 0) itemoff 1404=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 14 key (161138933 1 0) itemoff 1388=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 119=
03 mode 100640
> [Thu Oct  7 13:04:41 2021]      item 15 key (161138934 1 0) itemoff 1372=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 16 key (161138935 1 0) itemoff 1356=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 17 key (161138937 1 0) itemoff 1340=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 18 key (161138938 1 0) itemoff 1324=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 19 key (161138939 1 0) itemoff 1308=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 20 key (161138941 1 0) itemoff 1292=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 21 key (161138942 1 0) itemoff 1276=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 22 key (161138944 1 0) itemoff 1260=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 23 key (161138945 1 0) itemoff 1244=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 24 key (161138947 1 0) itemoff 1228=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 25 key (161138948 1 0) itemoff 1212=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 26 key (161138949 1 0) itemoff 1196=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 27 key (161138951 1 0) itemoff 1180=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 103=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 28 key (161138952 1 0) itemoff 1164=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 29 key (161138954 1 0) itemoff 1148=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 30 key (161138955 1 0) itemoff 1132=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 31 key (161138956 1 0) itemoff 1116=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 32 key (161138957 1 0) itemoff 1100=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 33 key (161138959 1 0) itemoff 1084=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 34 key (161138961 1 0) itemoff 1068=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 35 key (161138962 1 0) itemoff 1052=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 36 key (161138963 1 0) itemoff 1036=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 37 key (161138965 1 0) itemoff 1020=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 38 key (161138966 1 0) itemoff 1004=
3 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 39 key (161138968 1 0) itemoff 9883=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 40 key (161138969 1 0) itemoff 9723=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 41 key (161138971 1 0) itemoff 9563=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 42 key (161138972 1 0) itemoff 9403=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 43 key (161138974 1 0) itemoff 9243=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 44 key (161138975 1 0) itemoff 9083=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 45 key (161138976 1 0) itemoff 8923=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 46 key (161138978 1 0) itemoff 8763=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 47 key (161138979 1 0) itemoff 8603=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 48 key (161138980 1 0) itemoff 8443=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 298=
58047 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 49 key (161138982 1 0) itemoff 8283=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 50 key (161138983 1 0) itemoff 8123=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 51 key (161138984 1 0) itemoff 7963=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 52 key (161138985 1 0) itemoff 7803=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 53 key (161138987 1 0) itemoff 7643=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 54 key (161138988 1 0) itemoff 7483=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 55 key (161138990 1 0) itemoff 7323=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 56 key (161138991 1 0) itemoff 7163=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 57 key (161138993 1 0) itemoff 7003=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 58 key (161138994 1 0) itemoff 6843=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 59 key (161138996 1 0) itemoff 6683=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 60 key (161138997 1 0) itemoff 6523=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 61 key (161138999 1 0) itemoff 6363=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 62 key (161139000 1 0) itemoff 6203=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 63 key (161139002 1 0) itemoff 6043=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 64 key (161139003 1 0) itemoff 5883=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 65 key (161139005 1 0) itemoff 5723=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 66 key (161139006 1 0) itemoff 5563=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 67 key (161139007 1 0) itemoff 5403=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 68 key (161139008 1 0) itemoff 5243=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 69 key (161139010 1 0) itemoff 5083=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 70 key (161139011 1 0) itemoff 4923=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 71 key (161139012 1 0) itemoff 4763=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 72 key (161139014 1 0) itemoff 4603=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 73 key (161139015 1 0) itemoff 4443=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 74 key (161139016 1 0) itemoff 4283=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 75 key (161139017 1 0) itemoff 4123=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 76 key (161139019 1 0) itemoff 3963=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 77 key (161139020 1 0) itemoff 3803=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 78 key (161139021 1 0) itemoff 3643=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 79 key (161139023 1 0) itemoff 3483=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 80 key (161139024 1 0) itemoff 3323=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 81 key (161139025 1 0) itemoff 3163=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 82 key (161139027 1 0) itemoff 3003=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021]      item 83 key (161139028 1 0) itemoff 2843=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 40755
> [Thu Oct  7 13:04:41 2021]      item 84 key (161139029 1 0) itemoff 2683=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 85 key (161139031 1 0) itemoff 2523=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101=
 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 86 key (161139032 1 0) itemoff 2363=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100644
> [Thu Oct  7 13:04:41 2021]      item 87 key (161139034 1 0) itemoff 2203=
 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 m=
ode 100600
> [Thu Oct  7 13:04:41 2021] BTRFS error (device dm-3): block=3D5558935797=
760 write time tree block corruption detected

CC Filipe to see if the bug is already fixed.

This is only for write-time tree checker, so it doesn't write the
corrupted data onto disk, and again no long lasting effect.

The cause is the log replay code, which I guess Filipe has already fixed
in newer kernels.

Anyway, you can discard the log by "btrfs rescue zero-log" and
everything will be OK again (as long as you have enough metadata space).

Thanks,
Qu

> [Thu Oct  7 13:04:42 2021] BTRFS: error (device dm-3) in btrfs_commit_tr=
ansaction:2366: errno=3D-30 Readonly filesystem (Error while writing out t=
ransaction)
> [Thu Oct  7 13:04:42 2021] BTRFS warning (device dm-3): Skipping commit =
of aborted transaction.
> [Thu Oct  7 13:04:42 2021] BTRFS: error (device dm-3) in cleanup_transac=
tion:1939: errno=3D-30 Readonly filesystem
> 2021 Oct  7 13:04:41 monolith BTRFS critical (device dm-3): corrupt leaf=
: root=3D5 block=3D5558935797760 slot=3D0 ino=3D161138910, invalid nlink: =
has 2 expect no more than 1 for dir
> 2021 Oct  7 13:04:42 monolith BTRFS: error (device dm-3) in btrfs_commit=
_transaction:2366: errno=3D-30 Readonly filesystem (Error while writing ou=
t transaction)
> 2021 Oct  7 13:04:42 monolith BTRFS: error (device dm-3) in cleanup_tran=
saction:1939: errno=3D-30 Readonly filesystem
> [Thu Oct  7 13:04:46 2021] BTRFS error (device dm-3): open_ctree failed
>
> I searched for the error and came upon
> https://btrfs.wiki.kernel.org/index.php/Tree-checker , which said to
> email here. Any help is appreciated, I'd like to get this filesystem
> working again as soon as possible.
>
> I'm currently running btrfs check /dev/dm-3
>
