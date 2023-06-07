Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD527251F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 04:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbjFGCIS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 22:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjFGCIR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 22:08:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC90D1732
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 19:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686103693; x=1686708493; i=quwenruo.btrfs@gmx.com;
 bh=+IMenlq7rwxZjIGPkPCd3fVho1IvJ7SfVXpYN+FG5hI=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Xtudo6aIvijMC1jkvhBgntTkX+j9cdktGEmPQPqaZDpef61Wl5Jmn7UnLKY81Oh4nMEoa2K
 MhvsM9PATawjTFRFPuaXAwQ2V3VfoP+VgtIVrXVNoo1grCxeK+oxUIDIajaR+lrm9WIIeyReF
 nSxhQ6DCN34+iu86Mf4PNpeKnDKeTROJ1GPS/p9WRqP9RVzAUbBDJY1lbjQ7cZbMnNhWiNVkS
 7GMfsGbE6OD7aABX+CT88tQazeKYCYt6shH5j8wVIKeu41fwjzsUZZnvf9/No8nhmLX6Drty3
 pPPanKLtFRCmD0BdbfGZzXs5zTzNwDlZR42WjyTMRHlpjGcq5wGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsj7-1plTub2l2b-00LGEh; Wed, 07
 Jun 2023 04:08:13 +0200
Message-ID: <cf225ad6-69f4-a339-2e7b-42f094a7b5fb@gmx.com>
Date:   Wed, 7 Jun 2023 10:08:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: parent transid verify failed + Couldn't setup device tree
Content-Language: en-US
To:     Massimiliano Alberti <xanatos78@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CALgeF5=8Www=aG8=6XXTYsiD-A=dBdGUN8Drj=h4d92yoZNXHw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CALgeF5=8Www=aG8=6XXTYsiD-A=dBdGUN8Drj=h4d92yoZNXHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6gGLssMvy9wfj6JZPZzK52jtIh12gi1Y6sDcQYdu7vvaFmEHnpc
 qqGXhlu6x+2JMq6oUCw9VdnYfHAuE27RcHd3rI7IZ2dEqax3ukgRtZChDo+9NhgOrl3oA8T
 Axmsus7Kc++Pk7nFlfGnoGYNZDdyVrlA53b47+S+KIojYEy9yOPrN/NKYLuVREjjtg2MOq6
 v3Q3pgkFG0prSH4YUS8Cw==
UI-OutboundReport: notjunk:1;M01:P0:QXG6/w3qGso=;ciWDNxTUWTP0bTTVIa/y7or9lx5
 yroHTqxdGa9plL46qM5Wv1RALFAf1dlH5EWoIJXXf39mjrrtxR/pl627lXU5nmyTTa5v7sZsw
 zLGt4Tj2bt+NCoMxZeYwzsO22A16E5PDwJzQlpNblbej0Ug0q5lcifqSK3az+I6tKRkEYzkB9
 C5lbEtrcAkQwG31b4BVCq+9GEIA8lWfFWya4u8nDIZCtOBfb3rOUDAdFImLe4JClP34rflyia
 1wm3URyZL/o0J3NJNHepzNs1mLSSt6fqxiNjQif9JUJm7WLFEuVYvTQThEW3W154E0piPKqBG
 3hWwn9g/c0ADNtIhzT7KIFQrOiqquI4CMFZGhiAad4Zb+Ayvrb46vTY0cZUzWP1xyTndAHorg
 TOcll+neytJid4M+rTHC5C9d27lLyQqdYxfvRCGqEVZ/F097EBLnSXv8ptrOsHT2V+Rk4Jt2t
 TbW+kgBDTg2JVIdlXJmvoqsWEycGZnoH+o9nB8HzR4xVnr8wVCIiwX+gCP2CYGa/YDwU3Oxd0
 OirovedReIxPQ2To/ZF/2jOgPyTwelO52Y0YwUovjRVUQRETSk9Gi3LNLgL0SLdmpdRQaVG0G
 B+Hl4yF7KLKwpgQAOutip2eWlMx4WrIfNtg3C23cv4fWJqsYte+rVqdv1WOROHQ1OOKcW2qb/
 UUdi5yXNthtkyZJAzUT+m5UNADQbtrwWD46cFcIFERMoc5b9uAmnI6jmF6J0g5Ub72ORpsoTP
 nywbL5N1WCTWQ2FBkGnk5ZdYbkwcaNzZ8Rn1EAm8VGB8cz5qEaL9k0TFraM14F6OOftEzyfTQ
 +udnaByn5IoPThSShhwhzapjX0+s8OoV72k0IF/TcTCPb5J3tZXcmn43DwzVo7vi3MuWMuATI
 fDWMVkCgU6WqHVe3J6FxKGNSGywsyPbr0Kcz+Dlx84fVz8Cz9MFI/AQM1Sy/ph0G+TqTRIxqw
 4SSwh8+45E4ISsn66Jr9cG4jFu0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/6 22:34, Massimiliano Alberti wrote:
> I was using my btrfs partition through a usb-sata box when there was a
> power failure. Now I cannot mount it anymore. I'm using Ubuntu 22.04.
>
> If I try to do a btrfs check:
>
> root@ubuntu:/home/ubuntu# btrfs check /dev/sdc1
>
> parent transid verify failed on 4390576160768 wanted 9196 found 3295
> parent transid verify failed on 4390576160768 wanted 9196 found 3295
> parent transid verify failed on 4390576160768 wanted 9196 found 3295

It's common a usb-sata box doesn't handle the FLUSH/FUA correctly.

In that case, there is not much you can do, other than salvaging the
data (either through btrfs-restore, or go "-o rescue=3Dall" mount option
using newer kernels).

As btrfs has much stronger dependency on correct FLUSH/FUA
implementation to handle metadata COW correctly.
If the hardware is not doing it correctly, it is going to cause a total
loss.

In that case, it's recommended to disable write-cache for usb-sata
enclosure.

Thanks,
Qu
> Ignoring transid failure
> Couldn't setup device tree
> ERROR: cannot open file system
>
> The supers seems to be valid
>
> root@ubuntu:~# btrfs rescue super-recover -v /dev/sdc1
> All Devices:
> Device: id =3D 1, name =3D /dev/sdc1
>
> Before Recovering:
> [All good supers]:
> device name =3D /dev/sdc1
> superblock bytenr =3D 65536
>
> device name =3D /dev/sdc1
> superblock bytenr =3D 67108864
>
> device name =3D /dev/sdc1
> superblock bytenr =3D 274877906944
>
> [All bad supers]:
>
> All supers are valid, no need to recover
>
>
> The result of insp dump-s
>
> btrfs insp dump-s /dev/sdc1
>
> superblock: bytenr=3D65536, device=3D/dev/sdc1
> ---------------------------------------------------------
> csum_type 0 (crc32c)
> csum_size 4
> csum 0xc93391cc [match]
> bytenr 65536
> flags 0x1
> ( WRITTEN )
> magic _BHRfS_M [match]
> fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
> metadata_uuid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
> label
> generation 9196
> root 4390576160768
> sys_array_size 129
> chunk_root_generation 9146
> root_level 0
> chunk_root 25559040
> chunk_root_level 1
> log_root 0
> log_root_transid 0
> log_root_level 0
> total_bytes 17965846102016
> bytes_used 15526065344512
> sectorsize 4096
> nodesize 16384
> leafsize (deprecated) 16384
> stripesize 4096
> root_dir 6
> num_devices 1
> compat_flags 0x0
> compat_ro_flags 0x3
> ( FREE_SPACE_TREE |
>    FREE_SPACE_TREE_VALID )
> incompat_flags 0x161
> ( MIXED_BACKREF |
>    BIG_METADATA |
>    EXTENDED_IREF |
>    SKINNY_METADATA )
> cache_generation 0
> uuid_tree_generation 9196
> dev_item.uuid 632b9c90-95bf-44f3-9374-dddc6c571136
> dev_item.fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f [match]
> dev_item.type 0
> dev_item.total_bytes 17965846102016
> dev_item.bytes_used 15723900436480
> dev_item.io_align 4096
> dev_item.io_width 4096
> dev_item.sector_size 4096
> dev_item.devid 1
> dev_item.dev_group 0
> dev_item.seek_speed 0
> dev_item.bandwidth 0
> dev_item.generation 0
>
>
> and of dump-super
>
> root@ubuntu:/home/ubuntu# btrfs inspect-internal dump-super --full /dev/=
sdc1
>
> superblock: bytenr=3D65536, device=3D/dev/sdc1
> ---------------------------------------------------------
> csum_type 0 (crc32c)
> csum_size 4
> csum 0xc93391cc [match]
> bytenr 65536
> flags 0x1
> ( WRITTEN )
> magic _BHRfS_M [match]
> fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
> metadata_uuid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
> label
> generation 9196
> root 4390576160768
> sys_array_size 129
> chunk_root_generation 9146
> root_level 0
> chunk_root 25559040
> chunk_root_level 1
> log_root 0
> log_root_transid 0
> log_root_level 0
> total_bytes 17965846102016
> bytes_used 15526065344512
> sectorsize 4096
> nodesize 16384
> leafsize (deprecated) 16384
> stripesize 4096
> root_dir 6
> num_devices 1
> compat_flags 0x0
> compat_ro_flags 0x3
> ( FREE_SPACE_TREE |
>    FREE_SPACE_TREE_VALID )
> incompat_flags 0x161
> ( MIXED_BACKREF |
>    BIG_METADATA |
>    EXTENDED_IREF |
>    SKINNY_METADATA )
> cache_generation 0
> uuid_tree_generation 9196
> dev_item.uuid 632b9c90-95bf-44f3-9374-dddc6c571136
> dev_item.fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f [match]
> dev_item.type 0
> dev_item.total_bytes 17965846102016
> dev_item.bytes_used 15723900436480
> dev_item.io_align 4096
> dev_item.io_width 4096
> dev_item.sector_size 4096
> dev_item.devid 1
> dev_item.dev_group 0
> dev_item.seek_speed 0
> dev_item.bandwidth 0
> dev_item.generation 0
> sys_chunk_array[2048]:
> item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
> length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 2 sub_stripes 1
> stripe 0 devid 1 offset 22020096
> dev_uuid 632b9c90-95bf-44f3-9374-dddc6c571136
> stripe 1 devid 1 offset 30408704
> dev_uuid 632b9c90-95bf-44f3-9374-dddc6c571136
> backup_roots[4]:
> backup 0:
> backup_tree_root: 2633533751296 gen: 9193 level: 0
> backup_chunk_root: 25559040 gen: 9146 level: 1
> backup_extent_root: 2633547710464 gen: 9193 level: 2
> backup_fs_root: 2633526263808 gen: 9193 level: 2
> backup_dev_root: 39927808 gen: 9181 level: 1
> backup_csum_root: 15490589523968 gen: 9179 level: 3
> backup_total_bytes: 17965846102016
> backup_bytes_used: 15526065311744
> backup_num_devices: 1
>
> backup 1:
> backup_tree_root: 3518234607616 gen: 9194 level: 0
> backup_chunk_root: 25559040 gen: 9146 level: 1
> backup_extent_root: 3518158962688 gen: 9194 level: 2
> backup_fs_root: 3518155571200 gen: 9194 level: 2
> backup_dev_root: 39927808 gen: 9181 level: 1
> backup_csum_root: 15490589523968 gen: 9179 level: 3
> backup_total_bytes: 17965846102016
> backup_bytes_used: 15526065328128
> backup_num_devices: 1
>
> backup 2:
> backup_tree_root: 4390562365440 gen: 9195 level: 0
> backup_chunk_root: 25559040 gen: 9146 level: 1
> backup_extent_root: 3518246305792 gen: 9195 level: 2
> backup_fs_root: 3518155571200 gen: 9194 level: 2
> backup_dev_root: 39927808 gen: 9181 level: 1
> backup_csum_root: 15490589523968 gen: 9179 level: 3
> backup_total_bytes: 17965846102016
> backup_bytes_used: 15526065344512
> backup_num_devices: 1
>
> backup 3:
> backup_tree_root: 4390576160768 gen: 9196 level: 0
> backup_chunk_root: 25559040 gen: 9146 level: 1
> backup_extent_root: 4390576488448 gen: 9196 level: 2
> backup_fs_root: 3518155571200 gen: 9194 level: 2
> backup_dev_root: 39927808 gen: 9181 level: 1
> backup_csum_root: 15490589523968 gen: 9179 level: 3
> backup_total_bytes: 17965846102016
> backup_bytes_used: 15526065344512
> backup_num_devices: 1
>
> I've already tried checking starting from the various root trees:
>
> root@ubuntu:/home/ubuntu# btrfs check -r 2633533751296 /dev/sdc1
> Opening filesystem to check...
> parent transid verify failed on 2633533751296 wanted 9196 found 3310
> parent transid verify failed on 2633533751296 wanted 9196 found 3310
> parent transid verify failed on 2633533751296 wanted 9196 found 3310
> Ignoring transid failure
> Couldn't setup device tree
> ERROR: cannot open file system
>
> root@ubuntu:/home/ubuntu# btrfs check -r 3518234607616 /dev/sdc1
> Opening filesystem to check...
> parent transid verify failed on 3518234607616 wanted 9196 found 9122
> parent transid verify failed on 3518234607616 wanted 9196 found 9122
> parent transid verify failed on 3518234607616 wanted 9196 found 9122
> Ignoring transid failure
> ERROR: root [1 0] level 1 does not match 0
>
> Couldn't read tree root
> ERROR: cannot open file system
>
> root@ubuntu:/home/ubuntu# btrfs check -r 4390562365440 /dev/sdc1
> Opening filesystem to check...
> parent transid verify failed on 4390562365440 wanted 9196 found 3295
> parent transid verify failed on 4390562365440 wanted 9196 found 3295
> parent transid verify failed on 4390562365440 wanted 9196 found 3295
> Ignoring transid failure
> Couldn't setup device tree
> ERROR: cannot open file system
>
> root@ubuntu:/home/ubuntu# btrfs check -r 4390562365440 /dev/sdc1
> Opening filesystem to check...
> parent transid verify failed on 4390562365440 wanted 9196 found 3295
> parent transid verify failed on 4390562365440 wanted 9196 found 3295
> parent transid verify failed on 4390562365440 wanted 9196 found 3295
> Ignoring transid failure
> Couldn't setup device tree
> ERROR: cannot open file system
>
> Someone has some idea/suggestion? Thanks!
