Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C774296D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 20:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhJKS1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJKS1f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 14:27:35 -0400
X-Greylist: delayed 111 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Oct 2021 11:25:34 PDT
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD80FC061570
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1633975263; h=To:In-Reply-To:Cc:References:Subject:From:From:Reply-To;
        bh=h6NFunAGJA0uXojsGbpyDFsJqGomDZeSo5tAVXPhhX8=; b=MTRX0+giQqDyei5QCCXA5LMWFM
        WMIP3zvbT7Uj0pnoziCycMpK1L3YqpfbQ7M3ZLdZW4ONMJ8GbLSnuumezB7GZ+zZ44bdxKhta5x6p
        iymHQssiE7ZOGLJvcqD7JT57+pDFGrxsHG6B2EDpYhSZ6D8yVilI9WCvSsUfblrc9y9y/p4Gh5GYC
        qbg1OVbjyfNjoYq0boNUTLioJRLY3zLkUX0Xlokh3AmIfM6eBKiGE4D6glEZSp7X7foFMWqhcagLi
        0ajED6lfBU1VHr+q9cCXPCCKoNEBsIZxQCq+SHcV9xMscvL0Oc/acBVhrSg4dge+mSSrXBBuUAIK+
        KV4WIJ4A==;
Received: by mail.as397444.net with esmtpsa TLS1.3 id 1mZzxZ-0001KV-Hb
        (envelope-from <blnxfsl@bluematt.me>) ; Mon, 11 Oct 2021 18:23:37 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Matt Corallo <blnxfsl@bluematt.me>
Mime-Version: 1.0 (1.0)
Subject: Re: All Three Superblocks Damaged After Kernel Panic
Date:   Mon, 11 Oct 2021 11:23:34 -0700
Message-Id: <4B3507F4-5BD7-431A-85C6-6F6BA437F9EE@bluematt.me>
References: <fa22-61644680-fb-24052640@191566126>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <fa22-61644680-fb-24052640@191566126>
To:     Kyle James Chapman <kyle.chapman@stud.uni-heidelberg.de>
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

List subscribers,

Kyle=E2=80=99s email, below, may not have made it to your inbox. VGER=E2=80=99=
s SMTP RFC violation here should have resulted in your mail server refusing t=
o accept this.

Kyle,

Please note that your email client, your upstream mail server, and vger.kern=
el.org are all miscofigured, resulting in your email violating the SMTP RFCs=
 upon delivery. Because individual lines are not broken and longer than 1000=
 characters, many folks likely didn=E2=80=99t receive your email (eg default=
 exim configurations will refuse your mail). You should reach out to the adm=
inistrators for sogo01.urz.uni-heidelberg.de and relay.uni-heidelberg.de and=
 have them fix their configuration, as well as fix your local MUA.

Matt

> On Oct 11, 2021, at 11:09, Kyle James Chapman <kyle.chapman@stud.uni-heide=
lberg.de> wrote:
>=20
> =EF=BB=BFHello,
>=20
> I lost access to my home BTRFS filesystem on a 4TB SATA drive without part=
itioning today.
>=20
> I am a graduate student of translation studies at a foreign university. Pr=
ogramming is not my specialty but have ran Linux for over a decade because I=
 support open source endeavors. I say this for background on my technical ca=
pabilities, I am also a radio amateur extra-class in the United States. I ha=
ve some technical competence and run Arch Linux for general duty.
>=20
> The system boots and reads the kernel into memory from an optical ROM driv=
e, reads keyfiles from a USB stick, decrypts the home and swap partitions on=
 different devices, asks for a password for the root partition, and finishes=
 booting. I was rebooting my system from userspace and observed a kernel pan=
ic after finishing some work repartitioning a small USB stick using gparted.=
 After rebooting, my home BTRFS system was not mountable. Some information s=
eems present in some of the superblocks, but I do not understand everything.=
 I was careful in my use of the disk tool, and it was clear that only the US=
B stick was being accessed, because of the simple work I was doing, resizing=
 a partition on the obvious drive. I would like to recover the data. I finis=
hed writing my master's thesis and have already submitted it, so no real wor=
k was lost, but I would like to understand why this is happening and how the=
 data can be recovered. A memory fault seems plausible, but the fact that I w=
as accessing the partitions (through gparted) seems to indicate other possib=
ilities. Please do not get sidetracked into thinking I wrote data on the dri=
ve through carelessness. I have made many many uses of disk tools throughout=
 my life and the simple nature of the operations which did not involve the f=
ilesystem in question are completely understandable and I remember them clea=
rly.
>=20
> Please advise.
>=20
> Relevant /dev/fstab entry which has worked for several months until I comm=
ented it out today:
>=20
> #/dev/mapper/home    /home        btrfs        rw,compress,autodefrag,inod=
e_cache    0   1
>=20
> cat /proc/version:
>=20
> Linux version 5.15.0-rc3-1-git-00319-g7b66f4393ad4 (linux-git@archlinux) (=
gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Sun, 03 Oct 2=
021 17:24:26 +0000
>=20
>=20
> sudo  smartctl -a /dev/sdd excerpt:=20
>=20
> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> Model Family:     Seagate Barracuda 2.5 5400
> Device Model:     ST4000LM024-2AN17V
> Serial Number:    WCK03H8Y
> LU WWN Device Id: 5 000c50 09e55827b
> Firmware Version: 0001
> User Capacity:    4,000,787,030,016 bytes [4.00 TB]
> Sector Sizes:     512 bytes logical, 4096 bytes physical
> Rotation Rate:    5526 rpm
> Form Factor:      2.5 inches
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   ACS-3 T13/2161-D revision 5
> SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
> Local Time is:    Mon Oct 11 16:07:49 2021 CEST
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
>=20
> =3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
> SMART overall-health self-assessment test result: PASSED
>=20
> btrfs --version:
>=20
> btrfs-progs v5.14.1=20
>=20
>=20
> sudo btrfs inspect-internal dump-super -s 0 /dev/mapper/home :=20
>=20
> superblock: bytenr=3D65536, device=3D/dev/mapper/home
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0xc59083ff [DON'T MATCH]
> bytenr            65536
> flags            0x1
>            ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            bd5872ad-8fee-4d90-b048-b81120ce3254
> metadata_uuid        bd5872ad-8fee-4d90-b048-b81120ce3254
> label           =20
> generation        161054
> root            4028020703232
> sys_array_size        129
> chunk_root_generation    154912
> root_level        1
> chunk_root        22020096
> chunk_root_level    1
> log_root        0
> log_root_transid    0
> log_root_level        0
> total_bytes        4000787030016
> bytes_used        3969357348864
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x0
> incompat_flags        0x161
>            ( MIXED_BACKREF |
>              BIG_METADATA |
>              EXTENDED_IREF |
>              SKINNY_METADATA )
> cache_generation    161054
> uuid_tree_generation    161054
> dev_item.uuid        47593c4d-689d-4e1e-a310-dc7b8ab26c51
> dev_item.fsid        bd5872ad-8fee-4d90-b048-b81120ce3254 [match]
> dev_item.type        0
> dev_item.total_bytes    4000787030016
> dev_item.bytes_used    3997564731392
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
>=20
> sudo btrfs inspect-internal dump-super -s 1 /dev/mapper/home :
>=20
> superblock: bytenr=3D67108864, device=3D/dev/mapper/home
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0x65f1ab31 [DON'T MATCH]
> bytenr            14039944498490823899
> flags            0xcdc898509422934d
>            ( WRITTEN |
>              unknown flag: 0xcdc898509422934c )
> magic            _BHRfS_M [match]
> fsid            4468b2e4-d249-639c-dc54-792caf170cc9
> metadata_uuid        4468b2e4-d249-639c-dc54-792caf170cc9
> label           =20
> generation        161054
> root            4028020703232
> sys_array_size        129
> chunk_root_generation    154912
> root_level        1
> chunk_root        22020096
> chunk_root_level    1
> log_root        11922660382425005768
> log_root_transid    14582268926853107316
> log_root_level        0
> total_bytes        10532150587539085458
> bytes_used        8124524553913841719
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x0
> incompat_flags        0x161
>            ( MIXED_BACKREF |
>              BIG_METADATA |
>              EXTENDED_IREF |
>              SKINNY_METADATA )
> cache_generation    161054
> uuid_tree_generation    161054
> dev_item.uuid        47593c4d-689d-4e1e-a310-dc7b8ab26c51
> dev_item.fsid        bd5872ad-8fee-4d90-b048-b81120ce3254 [DON'T MATCH]
> dev_item.type        0
> dev_item.total_bytes    4000787030016
> dev_item.bytes_used    3997564731392
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
>=20
> sudo btrfs inspect-internal dump-super -s 2 /dev/mapper/home:
>=20
> superblock: bytenr=3D274877906944, device=3D/dev/mapper/home
> ---------------------------------------------------------
> csum_type        62267 (INVALID)
> csum_size        32
> csum            0x9876fd00000000000000000000000000000000000000000000000000=
00000000 [UNKNOWN CSUM TYPE OR SIZE]
> bytenr            274877906944
> flags            0x1
>            ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            bd5872ad-8fee-4d90-b048-b81120ce3254
> metadata_uuid        07eb556b-df56-afbd-12c1-32f496c9ae5e
> label            ...^k...cA..[....ws.......!...&+..@...U.^..Fi.....^s....%=
.....G.....\..z.0..8N......l
> generation        161054
> root            4028020703232
> sys_array_size        1346087890
> chunk_root_generation    14973196025592430218
> root_level        113
> chunk_root        22020096
> chunk_root_level    54
> log_root        0
> log_root_transid    0
> log_root_level        77
> total_bytes        4000787030016
> bytes_used        3969357348864
> sectorsize        544999736
> nodesize        1626255393
> leafsize (deprecated)    365786189
> stripesize        1625894637
> root_dir        4621774357935484814
> num_devices        6281988177397337675
> compat_flags        0x9c8dbbf37bf3e638
> compat_ro_flags        0xe392e94b904707de
>            ( FREE_SPACE_TREE_VALID |
>              unknown flag: 0xe392e94b904707dc )
> incompat_flags        0xe7c3113fe08815af
>            ( MIXED_BACKREF |
>              DEFAULT_SUBVOL |
>              MIXED_GROUPS |
>              COMPRESS_LZO |
>              BIG_METADATA |
>              RAID56 |
>              SKINNY_METADATA |
>              METADATA_UUID |
>              ZONED |
>              unknown flag: 0xe7c3113fe0880000 )
> cache_generation    2740636164699663627
> uuid_tree_generation    143387309824099247
> dev_item.uuid        8ca1383a-3aaf-986e-30f3-1081cc4423b9
> dev_item.fsid        d3b80203-160e-b664-1fa0-0121596e5fbf [DON'T MATCH]
> dev_item.type        2243501307224589742
> dev_item.total_bytes    17886909296177165879
> dev_item.bytes_used    843442598421986990
> dev_item.io_align    3037217492
> dev_item.io_width    3952451380
> dev_item.sector_size    2707671125
> dev_item.devid        4105250638360812501
> dev_item.dev_group    3766056873
> dev_item.seek_speed    182
> dev_item.bandwidth    229
> dev_item.generation    9452573969509059034
>=20
>=20
