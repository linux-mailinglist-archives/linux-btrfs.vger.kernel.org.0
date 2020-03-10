Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672C417F0A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 07:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCJGiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 02:38:11 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44003 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJGiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 02:38:11 -0400
X-Originating-IP: 82.67.131.7
Received: from [192.168.1.167] (unknown [82.67.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D9DBD20004;
        Tue, 10 Mar 2020 06:38:06 +0000 (UTC)
Subject: Re: (One more) BTRFS damaged FS... Any hope ?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <55a1612f-e9af-dabd-5b91-f09cb1528486@petaramesh.org>
 <CAJCQCtT+_ioV6XAUgPyD++9o_0+6-kUgGOF7mpfVHEyb7runsA@mail.gmail.com>
 <3234bc4b-6e93-c1f7-9ed4-a45173e22dd5@petaramesh.org>
 <CAJCQCtR-SUsiE5L8ba=pKHbJyQ9X3sTSBJ6vV0-X0-58nV-fxw@mail.gmail.com>
 <b99b8106-2aa9-e288-e637-d79a200da278@petaramesh.org>
 <CAJCQCtR6DnpkmgOnDY8GmO3T86Bk7ASmpGXTUmbdi9DVwdtMoQ@mail.gmail.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Autocrypt: addr=swami@petaramesh.org; prefer-encrypt=mutual; keydata=
 mQGiBEP8C/QRBADPiYmcQstlx+HdyR2FGH+bDgRZ0ZJBAx6F0OPW+CmIa6tlwdhSFtCTJGcw
 eqCgSKqzLS+WBd6qknpGP3D2GOmASt+Juqnl+qmX8F/XrkxSNOVGGD0vkKGX4H5uDwufWkuV
 7kD/0VFJg2areJXx5tIK4+IR0E0O4Yv6DmBPwPgNUwCg0OdUy9lbCxMmshwJDGUX2Y/hiDsD
 /3YTjHYH2OMTg/5xXlkQgR4aWn8SaVTG1vJPcm2j2BMq1LUNklgsKw7qJToRjFndHCYjSeqF
 /Yk2Cbeez9qIk3lX2M59CTwbHPZAk7fCEVg1Wf7RvR2i4zEDBWKd3nChALaXLE3mTWOE1pf8
 mUNPLALisxKDUkgyrwM4rZ28kKxyA/960xC5VVMkHWYYiisQQy2OQk+ElxSfPz5AWB5ijdJy
 SJXOT/xvgswhurPRcJc+l8Ld1GWKyey0o+EBlbkAcaZJ8RCGX77IJGG3NKDBoBN7fGXv3xQZ
 mFLbDyZWjQHl33wSUcskw2IP0D/vjRk/J7rHajIk+OxgbuTkeXF1qwX2ybQoU3fDom1pIFBl
 dGFyYW1lc2ggPHN3YW1pQHBldGFyYW1lc2gub3JnPoh+BBMRAgA+AhsDAh4BAheABQsJCAcC
 BhUKCQgLAgQWAgMBFiEEzB/joG05+rK5HJguL8JcHZB24y4FAl0Cdr0FCSJsbEkACgkQL8Jc
 HZB24y7PrwCeIj82AsMnwgOebV274cWEyR/yaDsAn25VN/Hw+yzkeXWAn5uIWJ+ZsoZkuQQN
 BEP8DFwQEAC77CwwyVuzngvfFTx2UzFwFOZ25osxSYE1Hpw249kbeK09EYbvMYzcWR34vbS0
 DhxqwJYH9uSuMZf/Jp4Qa/oYN4x4ZMeOGc5+BdigcetQQnZkIpMaCdFm6HK/A4aqCjqbPpvF
 3Mtd4CXcl1v94pIWq/n9JrLNclUA7rWnVKkPDqJ8WaxzDWm2YH9l1H+K+JbU/ow+Rk+y5xqp
 jL3XpOsVqf34RQhFUyCoysvvxH8RdHAeKfWTf5x6P8jOvxB6XwOnKkX91kC2N7PzoDxY7llY
 Uvy+ehrVVpaKLJ1a1R2eaVIHTFGO//2ARn6g4vVPMB93FLNR0BOGzEXCnnJKO5suw9Njv/aL
 bdnVdDPt9nc1yn3o8Bx/nZq1asX3zo/PnMz4Up24l6GrakJFMBZybX/KxA0CXDK6Rq4HSphI
 y/+v0I27FiQm7oT4ykiKnfFuh16NWM8rPV0UQgBLxSBoz327bUpsRuSrYh/oYBbE6p5KYHlB
 Acpix7wQ61OdUihBX73/AAx0Gd53fc0d4AYeKy4JXMl2uP2aiIvBeBaOKY5tzIq9gnL5K6rr
 xt4PSeONoLdVo8m8OyYeao1zvpgeNZ6FJ+VCYGBtsZEYIi80Ez5V0PpgAh7kSY1xbimDqKQx
 A/Jq2Q7sXBCdUeHN5cDgOZLKoJRvat/rhNaCSgUNfhUc2wADBRAAskb9Eolxs20NCfs424b3
 /NRI7SVn9W2hXvI61UYfs19lfScnn9YfmiN7IdB2cLCE6OiAbSsK3Aw8HDnEc0AdylVNOiIK
 su7C4+CW6HKMyIUm1q2qv8RwW3K8eE8+S4+4/5k+38T39BlC3HcLSxS9vfgqmF6mF6VeD5Mn
 DDbrm7G06UFm1Eh5PKFSzYKZ4i9rD9R4ivDCxRBT9Cibw36iigdp14z87/Qq/NoFe8j9zrbs
 3/3XZ22NxS0G8aNi0ejgDeYVRUUudBXK7zjV/pJDS4luB9iOiblysJmdKI3EegHlAcapTASn
 qsJ42O/Uv9jdSPPruZrMbeRKILqOl/YtI0orHGW/UzMYf/vbYWZ82azkPQqKDZF3Tb3h6ZHt
 csifD/J9IN7xh71aPf8ayIAus1AtPFtPUTjIJXqXIvAlNcDpaEpxn8xxcbVdcRBU/odASwsX
 IPdz8/HV5esod/QhR6/16kkKyOJNF5M/qC3PLur8Zu4iRu8EPiPr6vTAjhLrfXbQycuVc4CV
 c+hGlyYSW0xFaT+XF/4d+KZirsu07P5w/OCu+oRhH4StCOz58KrtuaX1dK5nLk6XkM4nKZhC
 7kmpnPqS6BkdJngkozuKQZMJahIvFglag90xgLrOl5MtO55yr/0j4S4a8GxTkVs70GttcMKN
 TYaSBqmVw+0A3IKIZgQYEQIAJgIbDBYhBMwf46BtOfqyuRyYLi/CXB2QduMuBQJdAnbyBQki
 bGwWAAoJEC/CXB2QduMur1wAn1X3FcsmMdhMfiYwXw7LVw4FAIeWAJ9kLGer22WFWR2z2iU7
 BtUAN08OPA==
Message-ID: <56e26938-3c85-f879-2f30-44283a6df5d1@petaramesh.org>
Date:   Tue, 10 Mar 2020 07:38:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR6DnpkmgOnDY8GmO3T86Bk7ASmpGXTUmbdi9DVwdtMoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi again Chris, and many thanks again,

Le 10/03/2020 à 04:46, Chris Murphy a écrit :
> 
> Yep, this suggests a crash or power fail during fsync.

This wouldn't susrprise me much, the laptop belonging to a kid who I
know for sure doesn't pay much attention to battery level and
experiments running out of battery quite often...

> Maybe the first 50 lines of the btrfs check are useful to get an idea
> what's going on, but without it, it's hard to say what's wrong or what
> to do.

Here it comes...:

[root@zafu ~]# btrfs check /dev/sdb1 |& head -64
parent transid verify failed on 8176123904 wanted 183574 found 183573
parent transid verify failed on 8176123904 wanted 183574 found 183573
Ignoring transid failure
[1/7] checking root items
[2/7] checking extents
ref mismatch on [5685248 16384] extent item 1, found 0
backref 5685248 root 258 not referenced back 0x564b1f957480
incorrect global backref count on 5685248 found 1 wanted 0
backpointer mismatch on [5685248 16384]
owner ref check failed [5685248 16384]
ref mismatch on [10420224 16384] extent item 1, found 0
backref 10420224 root 258 not referenced back 0x564b248ea1c0
incorrect global backref count on 10420224 found 1 wanted 0
backpointer mismatch on [10420224 16384]
owner ref check failed [10420224 16384]
ref mismatch on [10436608 16384] extent item 1, found 0
backref 10436608 root 258 not referenced back 0x564b248ea2c0
incorrect global backref count on 10436608 found 1 wanted 0
backpointer mismatch on [10436608 16384]
owner ref check failed [10436608 16384]
ref mismatch on [10534912 16384] extent item 1, found 0
backref 10534912 root 7 not referenced back 0x564b248ea3c0
incorrect global backref count on 10534912 found 1 wanted 0
backpointer mismatch on [10534912 16384]
owner ref check failed [10534912 16384]
ref mismatch on [11567104 16384] extent item 1, found 0
backref 11567104 root 7 not referenced back 0x564b1f9bce50
incorrect global backref count on 11567104 found 1 wanted 0
backpointer mismatch on [11567104 16384]
owner ref check failed [11567104 16384]
ref mismatch on [11862016 16384] extent item 1, found 0
backref 11862016 root 7 not referenced back 0x564b1f9bcfd0
incorrect global backref count on 11862016 found 1 wanted 0
backpointer mismatch on [11862016 16384]
owner ref check failed [11862016 16384]
ref mismatch on [13639680 4096] extent item 1, found 0
incorrect local backref count on 13639680 root 258 owner 949178 offset 0
found 0 wanted 1 back 0x564b248eb0c0
backref disk bytenr does not match extent record, bytenr=13639680, ref
bytenr=0
backpointer mismatch on [13639680 4096]
owner ref check failed [13639680 4096]
ref mismatch on [13758464 4096] extent item 1, found 0
incorrect local backref count on 13758464 root 258 owner 769574 offset 0
found 0 wanted 1 back 0x564b248ec030
backref disk bytenr does not match extent record, bytenr=13758464, ref
bytenr=0
backpointer mismatch on [13758464 4096]
owner ref check failed [13758464 4096]
ref mismatch on [13963264 4096] extent item 1, found 0
incorrect local backref count on 13963264 root 258 owner 1041188 offset
0 found 0 wanted 1 back 0x564b248eda50
backref disk bytenr does not match extent record, bytenr=13963264, ref
bytenr=0
backpointer mismatch on [13963264 4096]
owner ref check failed [13963264 4096]
ref mismatch on [13971456 8192] extent item 1, found 0
incorrect local backref count on 13971456 root 258 owner 306160 offset 0
found 0 wanted 1 back 0x564b248edcb0
backref disk bytenr does not match extent record, bytenr=13971456, ref
bytenr=0
backpointer mismatch on [13971456 8192]
owner ref check failed [13971456 8192]
ref mismatch on [13979648 4096] extent item 1, found 0
incorrect local backref count on 13979648 root 258 owner 306185 offset 0
found 0 wanted 1 back 0x564b248edde0
backref disk bytenr does not match extent record, bytenr=13979648, ref
bytenr=0
backpointer mismatch on [13979648 4096]
owner ref check failed [13979648 4096]
ref mismatch on [13996032 4096] extent item 1, found 0
incorrect local backref count on 13996032 root 258 owner 739868 offset 0
found 0 wanted 1 back 0x564b248ee2a0
backref disk bytenr does not match extent record, bytenr=13996032, ref
bytenr=0
backpointer mismatch on [13996032 4096]



[root@zafu ~]# btrfs check -b /dev/sdb1 |& head -64
[1/7] checking root items
[2/7] checking extents
ref mismatch on [3819245568 4096] extent item 1, found 0
incorrect local backref count on 3819245568 root 257 owner 736217 offset
0 found 0 wanted 1 back 0x55f5e4931c00
backref disk bytenr does not match extent record, bytenr=3819245568, ref
bytenr=0
backpointer mismatch on [3819245568 4096]
owner ref check failed [3819245568 4096]
ref mismatch on [3819421696 4096] extent item 1, found 0
incorrect local backref count on 3819421696 root 257 owner 736218 offset
0 found 0 wanted 1 back 0x55f5e49327e0
backref disk bytenr does not match extent record, bytenr=3819421696, ref
bytenr=0
backpointer mismatch on [3819421696 4096]
owner ref check failed [3819421696 4096]
ref mismatch on [3821916160 4096] extent item 1, found 0
incorrect local backref count on 3821916160 root 257 owner 736219 offset
0 found 0 wanted 1 back 0x55f5e1ee28e0
backref disk bytenr does not match extent record, bytenr=3821916160, ref
bytenr=0
backpointer mismatch on [3821916160 4096]
owner ref check failed [3821916160 4096]
ref mismatch on [3822043136 4096] extent item 1, found 0
incorrect local backref count on 3822043136 root 257 owner 736220 offset
0 found 0 wanted 1 back 0x55f5e1ee3130
backref disk bytenr does not match extent record, bytenr=3822043136, ref
bytenr=0
backpointer mismatch on [3822043136 4096]
owner ref check failed [3822043136 4096]
ref mismatch on [3822174208 4096] extent item 1, found 0
incorrect local backref count on 3822174208 root 257 owner 736222 offset
0 found 0 wanted 1 back 0x55f5e1ee3f70
backref disk bytenr does not match extent record, bytenr=3822174208, ref
bytenr=0
backpointer mismatch on [3822174208 4096]
owner ref check failed [3822174208 4096]
ref mismatch on [3822448640 4096] extent item 1, found 0
incorrect local backref count on 3822448640 root 257 owner 736223 offset
0 found 0 wanted 1 back 0x55f5e1ee4c80
backref disk bytenr does not match extent record, bytenr=3822448640, ref
bytenr=0
backpointer mismatch on [3822448640 4096]
owner ref check failed [3822448640 4096]
ref mismatch on [3822665728 4096] extent item 1, found 0
incorrect local backref count on 3822665728 root 257 owner 736224 offset
0 found 0 wanted 1 back 0x55f5e1ee5bf0
backref disk bytenr does not match extent record, bytenr=3822665728, ref
bytenr=0
backpointer mismatch on [3822665728 4096]
owner ref check failed [3822665728 4096]
ref mismatch on [3823845376 4096] extent item 1, found 0
incorrect local backref count on 3823845376 root 257 owner 736225 offset
0 found 0 wanted 1 back 0x55f5e1754b30
backref disk bytenr does not match extent record, bytenr=3823845376, ref
bytenr=0
backpointer mismatch on [3823845376 4096]
owner ref check failed [3823845376 4096]
ref mismatch on [3824963584 4096] extent item 1, found 0
incorrect local backref count on 3824963584 root 257 owner 736227 offset
0 found 0 wanted 1 back 0x55f5e175adc0
backref disk bytenr does not match extent record, bytenr=3824963584, ref
bytenr=0
backpointer mismatch on [3824963584 4096]
owner ref check failed [3824963584 4096]
ref mismatch on [3825586176 4096] extent item 1, found 0
incorrect local backref count on 3825586176 root 257 owner 736228 offset
0 found 0 wanted 1 back 0x55f5e3999990
backref disk bytenr does not match extent record, bytenr=3825586176, ref
bytenr=0
backpointer mismatch on [3825586176 4096]
owner ref check failed [3825586176 4096]
ref mismatch on [3825590272 4096] extent item 1, found 0
incorrect local backref count on 3825590272 root 257 owner 736229 offset
0 found 0 wanted 1 back 0x55f5e3999ac0
backref disk bytenr does not match extent record, bytenr=3825590272, ref
bytenr=0
backpointer mismatch on [3825590272 4096]
owner ref check failed [3825590272 4096]
ref mismatch on [3825844224 4096] extent item 1, found 0
incorrect local backref count on 3825844224 root 257 owner 736230 offset
0 found 0 wanted 1 back 0x55f5e399b3b0
backref disk bytenr does not match extent record, bytenr=3825844224, ref
bytenr=0
backpointer mismatch on [3825844224 4096]
owner ref check failed [3825844224 4096]
ref mismatch on [3825905664 4096] extent item 1, found 0
incorrect local backref count on 3825905664 root 257 owner 736231 offset
0 found 0 wanted 1 back 0x55f5e399b870


Unhappy as it can be...


> Another option is to zero the log tree, which will mean anything that
> was being fsync'd at the time is probably lost. It could fix the file
> system problem, but then result in user space data loss, depending on
> what was happening at the time of the power loss or crash.
> 
> # btrfs rescue zero-log /dev/

There was no important user data that couldn't be lost, so if it allows
rescueing the FS, then...

[root@zafu ~]# btrfs rescue zero-log /dev/sdb1
parent transid verify failed on 8176123904 wanted 183574 found 183573
parent transid verify failed on 8176123904 wanted 183574 found 183573
Ignoring transid failure
Clearing log on /dev/sdb1, previous log_root 8179646464, level 0

[root@zafu ~]# LC_MESSAGES=C mount -t btrfs /dev/sdb1 /mnt/hd
mount: /mnt/hd: wrong fs type, bad option, bad superblock on /dev/sdb1,
missing codepage or helper program, or other error.

[root@zafu ~]# LC_MESSAGES=C mount -t btrfs -o usebackuproot /dev/sdb1
/mnt/hd

[root@zafu ~]# mount
[...]
/dev/sdb1 on /mnt/hd type btrfs
(rw,relatime,space_cache,clear_cache,subvolid=5,subvol=/)

There it mounts !

[root@zafu ~]# ll /mnt/hd
total 0
drwxr-xr-x 1 root root 234 17 janv. 20:18 @
drwxr-xr-x 1 root root  12 14 oct.   2018 @data
drwxr-xr-x 1 root root  82 27 juil.  2018 @home
drwxr-xr-x 1 root root 210 12 févr. 12:00 timeshift-btrfs

[root@zafu ~]# ll /mnt/hd/@
total 16
drwxr-xr-x 1 root root 2534  5 janv. 13:30 bin
drwxr-xr-x 1 root root  516 17 janv. 20:19 boot
drwxr-xr-x 1 root root    0 22 juil.  2018 cdrom
drwxr-xr-x 1 root root    0 14 oct.   2018 data
drwxr-xr-x 1 root root  894 22 juil.  2018 dev
drwxr-xr-x 1 root root 4476 23 janv. 09:51 etc
drwxr-xr-x 1 root root    0 22 juil.  2018 home
lrwxrwxrwx 1 root root   32 17 janv. 20:18 initrd.img ->
boot/initrd.img-5.3.0-26-generic
lrwxrwxrwx 1 root root   32  5 janv. 17:37 initrd.img.old ->
boot/initrd.img-5.3.0-24-generic
drwxr-xr-x 1 root root  580  6 sept.  2019 lib
drwxr-xr-x 1 root root   40 26 juin   2018 lib64
drwxr-xr-x 1 root root   54 10 déc.   2018 media
drwxr-xr-x 1 root root   18 22 juil.  2018 mnt
drwxr-xr-x 1 root root   60  6 sept.  2019 opt
drwxr-xr-x 1 root root    0 24 avril  2018 proc
drwx------ 1 root root  190 28 juil.  2018 root
drwxr-xr-x 1 root root  156 14 oct.   2018 run
drwxr-xr-x 1 root root 4810  5 janv. 13:34 sbin
drwxr-xr-x 1 root root    0 26 juin   2018 srv
drwxr-xr-x 1 root root    0 24 avril  2018 sys
drwxrwxrwt 1 root root 1188 12 févr. 15:30 tmp
drwxr-xr-x 1 root root   84 27 avril  2019 usr
drwxr-xr-x 1 root root  110  9 déc.  10:08 var
lrwxrwxrwx 1 root root   29 17 janv. 20:18 vmlinuz ->
boot/vmlinuz-5.3.0-26-generic
lrwxrwxrwx 1 root root   29  5 janv. 17:37 vmlinuz.old ->
boot/vmlinuz-5.3.0-24-generic

[root@zafu ~]# umount /mnt/hd


[root@zafu ~]# LC_MESSAGES=C mount -t btrfs /dev/sdb1 /mnt/hd

[root@zafu ~]# ll /mnt/hd/@
total 16
drwxr-xr-x 1 root root 2534  5 janv. 13:30 bin
drwxr-xr-x 1 root root  516 17 janv. 20:19 boot
drwxr-xr-x 1 root root    0 22 juil.  2018 cdrom
drwxr-xr-x 1 root root    0 14 oct.   2018 data
drwxr-xr-x 1 root root  894 22 juil.  2018 dev
drwxr-xr-x 1 root root 4476 23 janv. 09:51 etc
drwxr-xr-x 1 root root    0 22 juil.  2018 home
lrwxrwxrwx 1 root root   32 17 janv. 20:18 initrd.img ->
boot/initrd.img-5.3.0-26-generic
lrwxrwxrwx 1 root root   32  5 janv. 17:37 initrd.img.old ->
boot/initrd.img-5.3.0-24-generic
drwxr-xr-x 1 root root  580  6 sept.  2019 lib
drwxr-xr-x 1 root root   40 26 juin   2018 lib64
drwxr-xr-x 1 root root   54 10 déc.   2018 media
drwxr-xr-x 1 root root   18 22 juil.  2018 mnt
drwxr-xr-x 1 root root   60  6 sept.  2019 opt
drwxr-xr-x 1 root root    0 24 avril  2018 proc
drwx------ 1 root root  190 28 juil.  2018 root
drwxr-xr-x 1 root root  156 14 oct.   2018 run
drwxr-xr-x 1 root root 4810  5 janv. 13:34 sbin
drwxr-xr-x 1 root root    0 26 juin   2018 srv
drwxr-xr-x 1 root root    0 24 avril  2018 sys
drwxrwxrwt 1 root root 1188 12 févr. 15:30 tmp
drwxr-xr-x 1 root root   84 27 avril  2019 usr
drwxr-xr-x 1 root root  110  9 déc.  10:08 var
lrwxrwxrwx 1 root root   29 17 janv. 20:18 vmlinuz ->
boot/vmlinuz-5.3.0-26-generic
lrwxrwxrwx 1 root root   29  5 janv. 17:37 vmlinuz.old ->
boot/vmlinuz-5.3.0-24-generic
[root@zafu ~]# umount /mnt/hd

Looks much happier now !

However :

[root@zafu ~]# !523
btrfs check /dev/sdb1 |& head -64
[1/7] checking root items
[2/7] checking extents
ref mismatch on [3819245568 4096] extent item 1, found 0
incorrect local backref count on 3819245568 root 257 owner 736217 offset
0 found 0 wanted 1 back 0x5559746ca680
backref disk bytenr does not match extent record, bytenr=3819245568, ref
bytenr=0
backpointer mismatch on [3819245568 4096]
owner ref check failed [3819245568 4096]
ref mismatch on [3819421696 4096] extent item 1, found 0
incorrect local backref count on 3819421696 root 257 owner 736218 offset
0 found 0 wanted 1 back 0x5559746cb260
backref disk bytenr does not match extent record, bytenr=3819421696, ref
bytenr=0
backpointer mismatch on [3819421696 4096]
owner ref check failed [3819421696 4096]
ref mismatch on [3821916160 4096] extent item 1, found 0
incorrect local backref count on 3821916160 root 257 owner 736219 offset
0 found 0 wanted 1 back 0x5559755abd60
backref disk bytenr does not match extent record, bytenr=3821916160, ref
bytenr=0
backpointer mismatch on [3821916160 4096]
owner ref check failed [3821916160 4096]
ref mismatch on [3822043136 4096] extent item 1, found 0
incorrect local backref count on 3822043136 root 257 owner 736220 offset
0 found 0 wanted 1 back 0x5559755ac5b0
backref disk bytenr does not match extent record, bytenr=3822043136, ref
bytenr=0
backpointer mismatch on [3822043136 4096]
owner ref check failed [3822043136 4096]
ref mismatch on [3822174208 4096] extent item 1, found 0
incorrect local backref count on 3822174208 root 257 owner 736222 offset
0 found 0 wanted 1 back 0x5559755ad3f0
backref disk bytenr does not match extent record, bytenr=3822174208, ref
bytenr=0
backpointer mismatch on [3822174208 4096]
owner ref check failed [3822174208 4096]
ref mismatch on [3822448640 4096] extent item 1, found 0
incorrect local backref count on 3822448640 root 257 owner 736223 offset
0 found 0 wanted 1 back 0x5559755ae100
backref disk bytenr does not match extent record, bytenr=3822448640, ref
bytenr=0
backpointer mismatch on [3822448640 4096]
owner ref check failed [3822448640 4096]
ref mismatch on [3822665728 4096] extent item 1, found 0
incorrect local backref count on 3822665728 root 257 owner 736224 offset
0 found 0 wanted 1 back 0x5559755af070
backref disk bytenr does not match extent record, bytenr=3822665728, ref
bytenr=0
backpointer mismatch on [3822665728 4096]
owner ref check failed [3822665728 4096]
ref mismatch on [3823845376 4096] extent item 1, found 0
incorrect local backref count on 3823845376 root 257 owner 736225 offset
0 found 0 wanted 1 back 0x555974e2d300
backref disk bytenr does not match extent record, bytenr=3823845376, ref
bytenr=0
backpointer mismatch on [3823845376 4096]
owner ref check failed [3823845376 4096]
ref mismatch on [3824963584 4096] extent item 1, found 0
incorrect local backref count on 3824963584 root 257 owner 736227 offset
0 found 0 wanted 1 back 0x555974e334d0
backref disk bytenr does not match extent record, bytenr=3824963584, ref
bytenr=0
backpointer mismatch on [3824963584 4096]
owner ref check failed [3824963584 4096]
ref mismatch on [3825586176 4096] extent item 1, found 0
incorrect local backref count on 3825586176 root 257 owner 736228 offset
0 found 0 wanted 1 back 0x555977015850
backref disk bytenr does not match extent record, bytenr=3825586176, ref
bytenr=0
backpointer mismatch on [3825586176 4096]
owner ref check failed [3825586176 4096]
ref mismatch on [3825590272 4096] extent item 1, found 0
incorrect local backref count on 3825590272 root 257 owner 736229 offset
0 found 0 wanted 1 back 0x555977015980
backref disk bytenr does not match extent record, bytenr=3825590272, ref
bytenr=0
backpointer mismatch on [3825590272 4096]
owner ref check failed [3825590272 4096]
ref mismatch on [3825844224 4096] extent item 1, found 0
incorrect local backref count on 3825844224 root 257 owner 736230 offset
0 found 0 wanted 1 back 0x555977017150
backref disk bytenr does not match extent record, bytenr=3825844224, ref
bytenr=0
backpointer mismatch on [3825844224 4096]
owner ref check failed [3825844224 4096]
ref mismatch on [3825905664 4096] extent item 1, found 0
incorrect local backref count on 3825905664 root 257 owner 736231 offset
0 found 0 wanted 1 back 0x555977017610

So still not absolutely happy :\

Many thanks however, at least the FS mounts after zeroeing the log...

Kind regards.

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
