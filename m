Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE7658E131
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 22:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiHIUgG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 16:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiHIUgE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 16:36:04 -0400
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC65CE1C
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1660077363;
        bh=oADVb5yDwyzuL7CMIpO0LGRZ7eOFbbtcvBQaqBwXbrI=;
        h=From:Content-Type:Mime-Version:Subject:Date:To:Message-Id;
        b=wiFo9S13gyHbZXm/agFcduGimG/2kRtD0h61jxVnqKOdnKpgQTEEhuUV6gCzcgH7L
         mVYwuGE0k2hyvzJ+a4W6HZ7ytFiNBk55gaob0NnUKCEkPpSoKytNfS4tfnzwrB0ygX
         3KxnqDyiSRsfOwjHreRuNkwypVaOGMfD8Z7gtaLUDXqFFWpzP6TKkcMQdG8QA34U3b
         mTRUhPyM3DXmAqgrw6wsrRkPPM/gMcEykCLHxzKNDzv90dWlPywd2of5Nca/4LMupD
         Q5rEq2hfc3ur5tXTz8UKsglmKGCuf7T8mlzxpKgrrFzpJ9KbMfPtPpIW+se0kVxmKp
         w9n31PPNGnLZA==
Received: from atlmbp.fritz.box (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 21A322794690
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 20:36:02 +0000 (UTC)
From:   Alex Lieflander <atlief@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: Help fixing filesystem after stupid lvresize
Date:   Tue, 9 Aug 2022 22:36:00 +0200
References: <98E508AD-82F0-4DCC-B9F6-73D03462A604@icloud.com>
 <YvK7DHBN39teoOne@hungrycats.org>
To:     linux-btrfs@vger.kernel.org
In-Reply-To: <YvK7DHBN39teoOne@hungrycats.org>
Message-Id: <7732A017-635E-49B3-A910-DB7061C93D3F@icloud.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Proofpoint-GUID: mYl-UKzfLbQnwyYvfmBbcqFN_3mAwviR
X-Proofpoint-ORIG-GUID: mYl-UKzfLbQnwyYvfmBbcqFN_3mAwviR
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

You absolute genius! That was exactly the problem. It mounts now=E2=80=94w=
hich it didn=E2=80=99t before=E2=80=94but I haven=E2=80=99t checked for =
any corruption yet. Thank you!

Sending this again for the mailing list (no HTML).

> On Aug 9, 2022, at 9:52 PM, Zygo Blaxell wrote:
>=20
> On Tue, Aug 09, 2022 at 01:18:37PM +0200, Alex Lieflander wrote:
>> Hello,
>>=20
>> Thank you for your continued work on this awesome filesystem. I just
>> made a really stupid mistake and now I can=E2=80=99t seem to `mount`, =
`btrfs
>> check`, or `btrfs rescue` my filesystem. I=E2=80=99m wondering =
(hoping)
>> that there=E2=80=99s an easy fix.
>>=20
>> The filesystem size was 4606G (3.78T used), the parent block device
>> was 5T, it was mounted read-write, and there was a `btrfs receive`
>> operation running. I accidentally `lvresize`-d the parent block
>> device to 4792 bytes (but probably 1M since that=E2=80=99s my PV =
extent
>> size) instead of 4792G. I didn=E2=80=99t realize the mistake yet and =
ran
>> `btrfs file resize max` which completed without printing any errors.
>>=20
>> Within a few minutes I `lvresized`-d the filesystem back to 5T and
>> tried to `btrfs file resize max` it, but by that point it was mounted
>> read-only. I `umount`-ed it and could no longer `mount` it. When I =
try
>> (with or without `-o usebackuproot`), I get "wrong fs type, bad =
option,
>> bad superblock on /dev/dm-2, missing codepage or helper program,
>> or other error.=E2=80=9D `btrfs rescue -b` prints "All supers are =
valid,
>> no need to recover=E2=80=9D. `btrfs version` prints "btrfs-progs =
v5.18.1=E2=80=9D
>> (I compiled it myself). Please see the attached files for the output =
of
>> `btrfs check` and `btrfs inspect-internal dump-super`.
>>=20
>> I don=E2=80=99t have any other disks large enough for `btrfs recover`
>> and I=E2=80=99d really like to avoid using `btrfs rescue =
chunk-recover`
>> if possible. Do you have any other suggestions?
>=20
> You might want to look in /etc/lvm/backup or /etc/lvm/archive for old
> versions of your LVM configuration.  The resized LV might not be in
> the same location on disk as it used to be, and if that's the case,
> it will break btrfs completely.
>=20
> If you're lucky, the missing btrfs blocks are still on the disk, and
> you can do a vgcfgrestore and get the old layout of the LV back;
> otherwise, it's mkfs+restore time.
>=20
>> Thanks,
>> Alex Lieflander
>>=20
>=20
>> Opening filesystem to check...
>> checksum verify failed on 6393548521472 wanted 0x18a23d5c found =
0xa56c5634
>> checksum verify failed on 6393548521472 wanted 0x69c424f0 found =
0x89318211
>> checksum verify failed on 6393548521472 wanted 0x18a23d5c found =
0xa56c5634
>> bad tree block 6393548521472, bytenr mismatch, want=3D6393548521472, =
have=3D16977026753978170276
>> ERROR: failed to read block groups: Input/output error
>> ERROR: cannot open file system
>=20
>> superblock: bytenr=3D65536, device=3Dbackup_crypt_3
>> ---------------------------------------------------------
>> csum_type		0 (crc32c)
>> csum_size		4
>> csum			0x3ce13204 [match]
>> bytenr			65536
>> flags			0x1
>> 			( WRITTEN )
>> magic			_BHRfS_M [match]
>> fsid			bae77875-a496-4758-9de1-28263b6a678f
>> metadata_uuid		bae77875-a496-4758-9de1-28263b6a678f
>> label			Postulate_Backup_3_Main
>> generation		139646
>> root			5959629045760
>> sys_array_size		129
>> chunk_root_generation	139300
>> root_level		1
>> chunk_root		23412736
>> chunk_root_level	1
>> log_root		0
>> log_root_transid	0
>> log_root_level		0
>> total_bytes		4945654841344
>> bytes_used		4159119925248
>> sectorsize		4096
>> nodesize		16384
>> leafsize (deprecated)	16384
>> stripesize		4096
>> root_dir		6
>> num_devices		1
>> compat_flags		0x0
>> compat_ro_flags		0x0
>> incompat_flags		0x179
>> 			( MIXED_BACKREF |
>> 			  COMPRESS_LZO |
>> 			  COMPRESS_ZSTD |
>> 			  BIG_METADATA |
>> 			  EXTENDED_IREF |
>> 			  SKINNY_METADATA )
>> cache_generation	139646
>> uuid_tree_generation	139646
>> block_group_root	0
>> block_group_root_generation	0
>> block_group_root_level	0
>> dev_item.uuid		b815cbe9-80b3-4439-a614-1a75bd4bb314
>> dev_item.fsid		bae77875-a496-4758-9de1-28263b6a678f =
[match]
>> dev_item.type		0
>> dev_item.total_bytes	4945654841344
>> dev_item.bytes_used	4247704829952
>> dev_item.io_align	4096
>> dev_item.io_width	4096
>> dev_item.sector_size	4096
>> dev_item.devid		1
>> dev_item.dev_group	0
>> dev_item.seek_speed	0
>> dev_item.bandwidth	0
>> dev_item.generation	0

