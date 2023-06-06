Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A977233E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 02:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjFFABp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 20:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFFABn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 20:01:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9CCF2
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 17:01:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25665d2a8bdso2524398a91.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686009700; x=1688601700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aNbyBN9mZFlqfnWJDAP+b4vh/5gNgBzAqd71PmognI=;
        b=PQPYUGuX2qy23ylwVLB/ZXVDhnMEoE+8v1CcDx28bAEuOPz/N/istvXR2gaO7wTz1P
         JjLkR6GJVUj15l5U/Ci9XzVVA3VYv4tDZpyZG7zu/ij/N5o3m452pwaogghHnW7+3GbF
         9FZEyPpiDWw0naHqabeY3apQaEe2ZLDIDhN3G4aDlZJEWM9fmCfBYVAE6Wvq5kpvgcTb
         AYbVkaoplh+VGRzpPU9Gn6kZe+3Z7mQ1NOKCW2YKhc/KbR4vjk9n9kZ6y40XkqznIJ7Z
         kbQeJieDDPjgBtR83R1CTZ5ISqvTi+7z8BD4/KaeVp5wUTMwO3TJBP+2z3tc03UEsblC
         NT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009700; x=1688601700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aNbyBN9mZFlqfnWJDAP+b4vh/5gNgBzAqd71PmognI=;
        b=gqxLb9gBnTld8aZAe1Q1dfUl+pNqLy7rQW52Bh7eLqIyPn6b9vPj01IkT0KHG86IVe
         g94/vatHa4uNGiSstxQI2DCNH5WfMmsIXgmpiWyvZLX5fQIzerRKnSzk/i0te44lgkgw
         2NiN6ltqmPQXJ2b2pNNqs5ux0mch+Lq3Hd7HD59LMRnJ5J3Jrifv/0jz0mF1UmB6tw7G
         Pq94BL3zypDyr7FJC9W128t3pcUV572wf4PdLujt9US9po9l0+YY5+ss1Chc84pCP6Xw
         KlNtADUVGAtr7jaQ0P6TLLSAFT9ZuBGqNLebStslDRsqGBx6RPciMrfT78ChKXtEr+3g
         z6vQ==
X-Gm-Message-State: AC+VfDyL/onZ8uc0ISfqR/vTl718IF+AfY8+rl/Pg0w559P8G4KH3R7v
        Xhl7llPPgaFxrx5P1FW3QVFaoqVD2+stznIpA2SoxV/C95ajjP4hpbI3xg==
X-Google-Smtp-Source: ACHHUZ4fulfaiiagIJDtzjed6IZSUJmEAO65RmgwX35E1nuhEVlOFE4AHo6DTUmZNz466q3ybJZ1Q5Hod7Sg55KAkyQ=
X-Received: by 2002:a17:90a:4ec5:b0:255:70e4:ad25 with SMTP id
 v5-20020a17090a4ec500b0025570e4ad25mr126088pjl.15.1686009699983; Mon, 05 Jun
 2023 17:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XNQ=ixcfB1_CXHf5azsB4gX87vvdmei+fxv5dj4K_4=H1=ag@mail.gmail.com>
 <CA+XNQ=i6Oq=nRStZ3P1gCB+NtCrR0u+E_gW1CraLFyz0OoeJrg@mail.gmail.com> <7d106d9e-9889-de54-e3b7-82858ce6be57@gmx.com>
In-Reply-To: <7d106d9e-9889-de54-e3b7-82858ce6be57@gmx.com>
From:   Gowtham <trgowtham123@gmail.com>
Date:   Tue, 6 Jun 2023 05:31:28 +0530
Message-ID: <CA+XNQ=j+r7LjSPch4Y7ptS3vBLsE6hU8yJvR0vi3-5_3puEVbQ@mail.gmail.com>
Subject: Re: Filesystem inconsistency on power cycle
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu,

Thanks for the response. It took some time to collect the data as the
server needed to reproduce the corruption. Below is the data collected
with btrfs-progs v6.3

Multiple files with the same inode number seen in the filesystem and
all of them are zero size. The file is supposed to contain valid data
and critical for the application

# ls -lt /var/nvOS/etc/Fabric/fa*
-rw-r--r-- 1 root root 0 Jun  2 12:38 /var/nvOS/etc/Fabric/fabric_config.xm=
l
-rw-r--r-- 1 root root 0 Jun  2 12:38 /var/nvOS/etc/Fabric/fabric_config.xm=
l
-rw-r--r-- 1 root root 0 Jun  2 12:38 /var/nvOS/etc/Fabric/fabric_config.xm=
l
-rw-r--r-- 1 root root 0 Jun  2 12:38 /var/nvOS/etc/Fabric/fabric_config.xm=
l
-rw-r--r-- 1 root root 0 Jun  2 12:38 /var/nvOS/etc/Fabric/fabric_config.xm=
l

root@DC354-NRU-SPINE2:~# btrfs fi show
Label: 'rpool'  uuid: 38c4b032-de12-4dcd-bf66-05e1d03143a8
Total devices 2 FS bytes used 12.99GiB
devid    1 size 206.47GiB used 20.06GiB path /dev/sda3
devid    2 size 206.47GiB used 19.03GiB path /dev/sdb9

ONIE:/var/tmp # ./btrfs.static check /dev/sda3
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: 38c4b032-de12-4dcd-bf66-05e1d03143a8
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
root 256 inode 68469 errors 1040, bad file extent, some csum missing
root 256 inode 68470 errors 1040, bad file extent, some csum missing
root 336 inode 28804435 errors 200, dir isize wrong
root 336 inode 28828813 errors 1, no inode item
unresolved ref dir 28804435 index 8160 namelen 17 name
fabric_config.xml filetype 1 errors 5, no dir item, no inode ref
root 336 inode 28828814 errors 1, no inode item
unresolved ref dir 28804435 index 8162 namelen 17 name
fabric_config.xml filetype 1 errors 5, no dir item, no inode ref
root 336 inode 28828815 errors 1, no inode item
unresolved ref dir 28804435 index 8164 namelen 17 name
fabric_config.xml filetype 1 errors 5, no dir item, no inode ref
root 336 inode 28828816 errors 1, no inode item
unresolved ref dir 28804435 index 8166 namelen 17 name
fabric_config.xml filetype 1 errors 5, no dir item, no inode ref
ERROR: errors found in fs roots
found 13947932672 bytes used, error(s) found
total csum bytes: 13147016
total tree bytes: 271015936
total fs tree bytes: 204591104
total extent tree bytes: 44810240
btree space waste bytes: 57774424
file data blocks allocated: 22864171008
 referenced 17184763904


ONIE:/var/tmp # ./btrfs.static check --mode=3Dlowmem /dev/sda3
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: 38c4b032-de12-4dcd-bf66-05e1d03143a8
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
ERROR: root 256 EXTENT_DATA[68469 0] compressed extent must have csum,
but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68469 0] is compressed, but inode flag
doesn't allow it
ERROR: root 256 EXTENT_DATA[68469 131072] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68469 131072] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68469 262144] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68469 262144] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68469 393216] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68469 393216] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68469 524288] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68469 524288] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68469 655360] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68469 655360] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68469 786432] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68469 786432] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68469 917504] compressed extent must have
csum, but only 0 bytes have, expect 24576
ERROR: root 256 EXTENT_DATA[68469 917504] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68470 0] compressed extent must have csum,
but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68470 0] is compressed, but inode flag
doesn't allow it
ERROR: root 256 EXTENT_DATA[68470 131072] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68470 131072] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68470 262144] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68470 262144] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68470 393216] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68470 393216] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68470 524288] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68470 524288] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68470 655360] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68470 655360] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68470 786432] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68470 786432] is compressed, but inode
flag doesn't allow it
ERROR: root 256 EXTENT_DATA[68470 917504] compressed extent must have
csum, but only 0 bytes have, expect 4096
ERROR: root 256 EXTENT_DATA[68470 917504] is compressed, but inode
flag doesn't allow it
ERROR: root 336 INODE_ITEM[28828813] index 8160 name fabric_config.xml
filetype 1 missing
ERROR: root 336 INODE_ITEM[28828814] index 8162 name fabric_config.xml
filetype 1 missing
ERROR: root 336 INODE_ITEM[28828815] index 8164 name fabric_config.xml
filetype 1 missing
ERROR: root 336 INODE_ITEM[28828816] index 8166 name fabric_config.xml
filetype 1 missing
ERROR: root 336 DIR INODE [28804435] size 1106 not equal to 1174
ERROR: errors found in fs roots
found 13947932672 bytes used, error(s) found
total csum bytes: 13147016
total tree bytes: 271015936
total fs tree bytes: 204591104
total extent tree bytes: 44810240
btree space waste bytes: 57774424
file data blocks allocated: 22864171008
 referenced 17184763904

#  ./btrfs.static ins dump-tree -t 256 /dev/sda3 | grep -A5 "(68469 "
key (68469 EXTENT_DATA 655360) block 61564944384 gen 1736288
key (68472 EXTENT_DATA 36864) block 60511285248 gen 1736279
key (68472 EXTENT_DATA 356352) block 60514881536 gen 1736279
key (68472 EXTENT_DATA 720896) block 60515426304 gen 1736279
key (68472 EXTENT_DATA 909312) block 60515491840 gen 1736279
key (68472 EXTENT_DATA 1363968) block 60516802560 gen 1736279
--
location key (68469 INODE_ITEM 0) type FILE
transid 85 data_len 0 name_len 49
name: system@0005ab8d9aa0a9fe-be4e94ec668e3a83.journal~
item 16 key (67417 DIR_ITEM 4104047264) itemoff 2351 itemsize 44
location key (68472 INODE_ITEM 0) type FILE
transid 85 data_len 0 name_len 14
--
location key (68469 INODE_ITEM 0) type FILE
transid 85 data_len 0 name_len 49
name: system@0005ab8d9aa0a9fe-be4e94ec668e3a83.journal~
item 19 key (67417 DIR_INDEX 13) itemoff 2181 itemsize 44
location key (68472 INODE_ITEM 0) type FILE
transid 85 data_len 0 name_len 14
--
item 25 key (68469 INODE_ITEM 0) itemoff 1372 itemsize 160
generation 78 transid 85 size 8388608 nbytes 8388608
block group 0 mode 100640 links 1 uid 0 gid 126 rdev 0
sequence 10 flags 0x13(NODATASUM|NODATACOW|PREALLOC)
atime 1595999111.194685019 (2020-07-29 05:05:11)
ctime 1595999556.507486909 (2020-07-29 05:12:36)
--
item 26 key (68469 INODE_REF 67417) itemoff 1313 itemsize 59
index 12 namelen 49 name: system@0005ab8d9aa0a9fe-be4e94ec668e3a83.journal~
item 27 key (68469 XATTR_ITEM 843765919) itemoff 1259 itemsize 54
location key (0 UNKNOWN.0 0) type XATTR
transid 78 data_len 8 name_len 16
name: user.crtime_usec
data =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
item 28 key (68469 XATTR_ITEM 2038346239) itemoff 1162 itemsize 97
location key (0 UNKNOWN.0 0) type XATTR
transid 78 data_len 44 name_len 23
name: system.posix_acl_access
data
item 29 key (68469 EXTENT_DATA 0) itemoff 1109 itemsize 53
generation 85 type 1 (regular)
extent data disk byte 59567894528 nr 4096
extent data offset 0 nr 131072 ram 131072
extent compression 2 (lzo)
item 30 key (68469 EXTENT_DATA 131072) itemoff 1056 itemsize 53
generation 85 type 1 (regular)
extent data disk byte 59568496640 nr 4096
extent data offset 0 nr 131072 ram 131072
extent compression 2 (lzo)
item 31 key (68469 EXTENT_DATA 262144) itemoff 1003 itemsize 53
generation 85 type 1 (regular)
extent data disk byte 59568992256 nr 4096
extent data offset 0 nr 131072 ram 131072
extent compression 2 (lzo)
item 32 key (68469 EXTENT_DATA 393216) itemoff 950 itemsize 53
generation 85 type 1 (regular)
extent data disk byte 59569881088 nr 4096
extent data offset 0 nr 131072 ram 131072
extent compression 2 (lzo)
item 33 key (68469 EXTENT_DATA 524288) itemoff 897 itemsize 53
generation 85 type 1 (regular)
extent data disk byte 59570008064 nr 4096
extent data offset 0 nr 131072 ram 131072
extent compression 2 (lzo)
leaf 61564944384 items 28 free space 1519 generation 1736288 owner 256
--
item 0 key (68469 EXTENT_DATA 655360) itemoff 3942 itemsize 53
generation 85 type 1 (regular)
extent data disk byte 59570061312 nr 4096
extent data offset 0 nr 131072 ram 131072
extent compression 2 (lzo)
item 1 key (68469 EXTENT_DATA 786432) itemoff 3889 itemsize 53
generation 85 type 1 (regular)
extent data disk byte 59570167808 nr 4096
extent data offset 0 nr 131072 ram 131072
extent compression 2 (lzo)
item 2 key (68469 EXTENT_DATA 917504) itemoff 3836 itemsize 53
generation 85 type 1 (regular)
extent data disk byte 62197817344 nr 24576
extent data offset 0 nr 53248 ram 53248
extent compression 2 (lzo)
item 3 key (68469 EXTENT_DATA 970752) itemoff 3783 itemsize 53
generation 82 type 2 (prealloc)
prealloc data disk byte 61383217152 nr 8384512
prealloc data offset 966656 nr 7417856
item 4 key (68470 INODE_ITEM 0) itemoff 3623 itemsize 160
generation 79 transid 92 size 8388608 nbytes 8388608

ONIE:/var/tmp # ./btrfs.static ins dump-tree -t 336 /dev/sda3 | grep
-A5 "(28804435 " > 28804435.ins.sda3 | head -50

key (28804435 DIR_INDEX 7415) block 59427983360 gen 1911927
key (28804463 DIR_ITEM 2160938527) block 60599836672 gen 1911927
key (28804474 INODE_REF 28804473) block 58354487296 gen 1911925
key (28804477 DIR_ITEM 3425289705) block 70241230848 gen 1823843
key (28804477 DIR_INDEX 17) block 72880934912 gen 1823843
key (28804480 INODE_REF 28804478) block 70239948800 gen 1823843
--
location key (28804435 INODE_ITEM 0) type DIR
transid 1823843 data_len 0 name_len 6
name: Fabric
item 20 key (28804406 DIR_ITEM 3195268898) itemoff 1557 itemsize 37
location key (28804463 INODE_ITEM 0) type DIR
transid 1823843 data_len 0 name_len 7
--
location key (28804435 INODE_ITEM 0) type DIR
transid 1823843 data_len 0 name_len 6
name: Fabric
item 1 key (28804406 DIR_INDEX 5) itemoff 3922 itemsize 37
location key (28804463 INODE_ITEM 0) type DIR
transid 1823843 data_len 0 name_len 7
--
item 9 key (28804435 INODE_ITEM 0) itemoff 2903 itemsize 160
generation 1823843 transid 1911927 size 1106 nbytes 0
block group 0 mode 40700 links 1 uid 0 gid 0 rdev 0
sequence 24961 flags 0x0(none)
atime 1683000705.830348007 (2023-05-02 04:11:45)
ctime 1685702562.466279548 (2023-06-02 10:42:42)
--
item 10 key (28804435 INODE_REF 28804406) itemoff 2887 itemsize 16
index 4 namelen 6 name: Fabric
item 11 key (28804435 DIR_ITEM 97813801) itemoff 2830 itemsize 57
location key (28825999 INODE_ITEM 0) type FILE
transid 1903257 data_len 0 name_len 27
name: sys_flow_setting_config.xml
item 12 key (28804435 DIR_ITEM 320957542) itemoff 2785 itemsize 45
location key (28828931 INODE_ITEM 0) type FILE
transid 1911927 data_len 0 name_len 15
name: vlan_config.xml
item 13 key (28804435 DIR_ITEM 432850103) itemoff 2740 itemsize 45
location key (28826013 INODE_ITEM 0) type FILE
transid 1903257 data_len 0 name_len 15
name: vtep_config.xml
item 14 key (28804435 DIR_ITEM 453034874) itemoff 2695 itemsize 45
location key (28826000 INODE_ITEM 0) type FILE
transid 1903257 data_len 0 name_len 15
name: xact_config.log
item 15 key (28804435 DIR_ITEM 533509466) itemoff 2646 itemsize 49
location key (28826007 INODE_ITEM 0) type FILE
transid 1903257 data_len 0 name_len 19
name: vnet_mgr_config.xml

# ./btrfs.static ins dump-tree -t 336 /dev/sda3 | grep -A5 "(28828813 "
location key (28828813 INODE_ITEM 0) type FILE
transid 1911922 data_len 0 name_len 17
name: fabric_config.xml
item 27 key (28804435 DIR_INDEX 8162) itemoff 2630 itemsize 47
location key (28828814 INODE_ITEM 0) type FILE
transid 1911922 data_len 0 name_len 17

Thanks in advance. Please let me know .

Regards,
Gowtham

On Thu, May 4, 2023 at 6:43=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> On 2023/5/4 08:24, Gowtham wrote:
> > Hi All,
> >
> > Can anyone suggest a fix or a workaround for the issue in 5.4 kernel?
> >
> > Regards,
> > Gowtham
> >
> > On Sun, Apr 30, 2023 at 3:50=E2=80=AFPM Gowtham <trgowtham123@gmail.com=
> wrote:
> >>
> >> Hi
> >>
> >> We have been running our application on BTRFS rootfs for quite a few
> >> Linux kernel versions (from 4.x to 5.x) and occasionally do a power
> >> cycle for firmware upgrade. Are there any known issues with BTRFS on
> >> Ubuntu 20.04 running kernel 5.4.0-137?
>
> I don't believe there are some known bugs that can lead to the same
> problem you described.
>
> >>
> >> On power cycles/outages, we have not seen the BTRFS being corrupted
> >> earlier on 4.15 kernel. But we are seeing this consistently on a 5.4
> >> kernel(with BTRFS RAID1 configuration). Are there any known issues on
> >> Ubuntu 20.04? We see some config files like /etc/shadow and other
> >> application config becoming zero size after the power-cycle. Also, the
> >> btrfs check reports errors like below
> >>
> >> # btrfs check /dev/sda3
> >> Checking filesystem on /dev/sda3
> >> UUID: 38c4b032-de12-4dcd-bf66-05e1d03143a8
> >> checking extents
> >> checking free space cache
> >> checking fs roots
> >> root 297 inode 28796828 errors 200, dir isize wrong
> >> root 297 inode 28796829 errors 200, dir isize wrong
> >> root 297 inode 28800233 errors 1, no inode item
> >>     unresolved ref dir 28796828 index 506 namelen 14 name
> >> ip6tables.conf filetype 1 errors 5, no dir item, no inode ref
>
> Those corruptions are mismatch in inodes backref mismatch, some can even
> be bad key ordered.
>
> I want to look deeper into these offending inodes, as in the past we
> have seen some memory bitflip causing the same problem.
>
> Mind to dump the following info?
>
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28796828 "
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28796829 "
>
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800233 "
>
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800269 "
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800270 "
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800271 "
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800272 "
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800273 "
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800274 "
> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800275 "
>
> Furthermore, the output of the original mode sometimes is missing needed
> info.
>
> Please use a newer btrfs-progs (the easiest way is to grab a rolling
> distro liveCD), and paste the output of:
>
> # btrfs check --mode=3Dlowmem /dev/sda3
>
> Thanks,
> Qu
>
> >> root 297 inode 28800269 errors 1, no inode item
> >>     unresolved ref dir 28796829 index 452 namelen 30 name
> >> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> >> inode ref
> >> root 297 inode 28800270 errors 1, no inode item
> >>     unresolved ref dir 28796829 index 454 namelen 30 name
> >> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> >> inode ref
> >> root 297 inode 28800271 errors 1, no inode item
> >>     unresolved ref dir 28796829 index 456 namelen 30 name
> >> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> >> inode ref
> >> root 297 inode 28800272 errors 1, no inode item
> >>     unresolved ref dir 28796829 index 458 namelen 30 name
> >> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> >> inode ref
> >> root 297 inode 28800273 errors 1, no inode item
> >>     unresolved ref dir 28796829 index 460 namelen 30 name
> >> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> >> inode ref
> >> root 297 inode 28800274 errors 1, no inode item
> >>     unresolved ref dir 28796829 index 462 namelen 30 name
> >> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> >> inode ref
> >> root 297 inode 28800275 errors 1, no inode item
> >>     unresolved ref dir 28796829 index 464 namelen 30 name
> >> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
> >> inode ref
> >> found 13651775501 bytes used err is 1
> >> total csum bytes: 12890096
> >> total tree bytes: 267644928
> >> total fs tree bytes: 202223616
> >> total extent tree bytes: 45633536
> >> btree space waste bytes: 59752814
> >> file data blocks allocated: 16155500544
> >> referenced 16745402368
> >>
> >>
> >> We run the rootfs on BTRFS and mount it using below options
> >>
> >> # mount -t btrfs
> >> /dev/sda3 on / type btrfs
> >> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subv=
olid=3D292,subvol=3D/@/netvisor-5)
> >> /dev/sda3 on /.rootbe type btrfs
> >> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subv=
olid=3D256,subvol=3D/@)
> >> /dev/sda3 on /home type btrfs
> >> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subv=
olid=3D257,subvol=3D/@home)
> >> /dev/sda3 on /var/nvOS/log type btrfs
> >> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subv=
olid=3D258,subvol=3D/@var_nvOS_log)
> >> /dev/sda3 on /sftp/nvOS type btrfs
> >> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subv=
olid=3D292,subvol=3D/@/netvisor-5)
> >>
> >> # btrfs fi df /.rootbe
> >> System, RAID1: total=3D32.00MiB, used=3D12.00KiB
> >> Data+Metadata, RAID1: total=3D36.00GiB, used=3D34.19GiB
> >> GlobalReserve, single: total=3D132.65MiB, used=3D0.00B
> >>
> >> # btrfs --version
> >> btrfs-progs v5.4.1
> >>
> >> Regards,
> >> Gowtham
