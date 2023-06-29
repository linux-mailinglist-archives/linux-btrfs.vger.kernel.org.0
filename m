Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2577422ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 11:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjF2JJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 05:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjF2JJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 05:09:01 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 02:09:00 PDT
Received: from mail131.mailersend.net (mail131.mailersend.net [212.11.79.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A18E2122
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; t=1688029740; c=relaxed/simple;
 s=mlsend; bh=yCBQcJL2sMlwllGVcEueuIvJJUlBWtuWm7BE97g5a+M=; d=archworks.co;
 h=Content-Transfer-Encoding:Content-Type:Date:MIME-Version:
 X-MailerSend-MessageID:Feedback-ID:X-MailerSend-RecipientID:Message-ID:
 Subject:Reply-To:To:From;
 b=GVSOGFcqjhK5mLlWb3MaAd7CLGIU4Bs7Wo9No930reaLYvwigGx5Fpd8CFVfs/URQzdObOPR
 HYlePBqt2Z3yNULAoz3aM+1VzKSuNoyZGzuR2xri9gtBjD5WxfEw61MBC8ALXtWgwDMYrxXm/l
 UJH15SIe9wrsFUg6kGD5gO+Xs=
From:   Norbert Morawski <norbert.morawski@archworks.co>
To:     linux-btrfs@vger.kernel.org
Reply-To: norbert.morawski@archworks.co
Subject: RAID6 Profile Conversion "error (device sda: state A) in
 __btrfs_free_extent"
recipients: linux-btrfs@vger.kernel.org
Message-ID: <649d48f8ba63b8a5430893ba@mailersend.net>
X-MailerSend-RecipientID: 649d48f8ba63b8a5430893ba;649d48f88a146a66320b9cae;3vz9dle3do6gkj50
Feedback-ID: 649d48f8ba63b8a5430893ba:649d48f88a146a66320b9cae:3vz9dle3do6gkj50:MailerSend
X-MailerSend-MessageID: 649d48f88a146a66320b9caf
MIME-Version: 1.0
Date:   Thu, 29 Jun 2023 09:03:52 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello People,
this is my first mail to a mailing list, so please give me =
constructive feedback.
I am also not a native English speaker, so please =
excuse my mistakes.

I have started a BTRFS profile conversion from arr=
ay to "RAID6 for Data and RAID1C3 for Metadata".

Steps I did:

1. =
Created an BTRFS Array 6 x 8TB "This happened sequentially since I had to m=
ove the Data from a LVM"
2. Filled the Storage to 24TB out of 44TB
3. P=
roceeded with the RAID6 conversion -> "btrfs balance start -dconvert=3Draid=
6 -mconvert=3Draid1c3 /mnt/Data --background"
4. About 40% into the balan=
ce, the METADATA is full and does not extend.
5. BTRFS goes into forced R=
ead-only mode.
6. Mounted with "skip_balance"
7. Added disk "/dev/nvme1=
n1" into the Array.
8. Started "btrfs scrub"
9. Resumed BTFS Balance ->=
 Metadata extended once from 16GB to 17GB at 99.7% usage. -> Second Extend =
does not happen.
10. BTRFS goes into forced Read-only mode.

This is =
the Kernel-log:
'''
[114905.372197] BTRFS: error (device sda: state A) =
in find_free_extent_update_loop:4129: errno=3D-22 unknown
[114905.372205]=
 BTRFS info (device sda: state EA): forced readonly
[114905.372211] BTRFS=
: error (device sda: state EA) in reset_balance_state:3595: errno=3D-22 unk=
nown
[114905.372221] BTRFS info (device sda: state EA): balance: canceled=

'''

After some troubleshooting, I mounted the FS with the option "s=
kip_balance".
This pauses the balance process and allowed me to remove th=
e least important files and also start the "btrfs scrub" process.

Afte=
r that and another balance attempt, I managed to get more Kernel Info, and =
it appears that the Metadata does not want to extend.
'''
[133728.87651=
7] BTRFS info (device sda: state A): dumping space info:
[133728.876520] =
BTRFS info (device sda: state A): space_info DATA has 5050423623680 free, i=
s not full
[133728.876522] BTRFS info (device sda: state A): space_info t=
otal=3D30382508408832, used=3D25064527589376, pinned=3D0, reserved=3D0, may=
_use=3D0, readonly=3D267557195776 zone_unusable=3D0
[133728.876526] BTRFS=
 info (device sda: state A): space_info METADATA has 3459383296 free, is fu=
ll
[133728.876528] BTRFS info (device sda: state A): space_info total=3D3=
2212254720, used=3D28193619968, pinned=3D21725184, reserved=3D32768, may_us=
e=3D537165824, readonly=3D327680 zone_unusable=3D0
[133728.876532] BTRFS =
info (device sda: state A): space_info SYSTEM has 39206912 free, is not ful=
l
[133728.876534] BTRFS info (device sda: state A): space_info total=3D41=
943040, used=3D2736128, pinned=3D0, reserved=3D0, may_use=3D0, readonly=3D0=
 zone_unusable=3D0
[133728.876537] BTRFS info (device sda: state A): glob=
al_block_rsv: size 536870912 reserved 536854528
[133728.876539] BTRFS inf=
o (device sda: state A): trans_block_rsv: size 0 reserved 0
[133728.87654=
0] BTRFS info (device sda: state A): chunk_block_rsv: size 0 reserved 0
[=
133728.876541] BTRFS info (device sda: state A): delayed_block_rsv: size 0 =
reserved 0
[133728.876542] BTRFS info (device sda: state A): delayed_refs=
_rsv: size 16777216 reserved 16384
[133728.876544] BTRFS: error (device s=
da: state A) in __btrfs_free_extent:3077: errno=3D-28 No space left
[1337=
28.876550] BTRFS info (device sda: state EA): forced readonly
[133728.876=
552] BTRFS error (device sda: state EA): failed to run delayed ref for logi=
cal 54198081880064 num_bytes 16384 type 176 action 2 ref_mod 1: -28
[1337=
28.876555] BTRFS: error (device sda: state EA) in btrfs_run_delayed_refs:21=
51: errno=3D-28 No space left
[133728.876560] BTRFS warning (device sda: =
state EA): Skipping commit of aborted transaction.
[133728.876561] BTRFS:=
 error (device sda: state EA) in cleanup_transaction:1984: errno=3D-28 No s=
pace left
[133728.879119] BTRFS info (device sda: state EA): balance: end=
ed with status: -30
'''
*Canceling the balance is not possible, FS goes=
 into forced read-only mode.*

## Information
OS: Proxmox 8.0
Kerne=
l: 6.2.16-3-pve
Btrfs: btrfs-progs v6.2

btrfs fi show:
'''
Label=
: 'Backup'=C2=A0 uuid: 450ead52-9143-45d7-9326-4cba501700ed
=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 313.18GiB=

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 siz=
e 465.76GiB used 341.03GiB path /dev/sdh

Label: 'Data'=C2=A0 uuid: c2c=
74dd4-a471-4ac5-9321-597fb39ba992
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Total devices 7 FS bytes used 22.82TiB
=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 7.28TiB used 5.16TiB path=
 /dev/sda
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=
=C2=A0 2 size 7.28TiB used 5.47TiB path /dev/sdb
=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 size 7.28TiB used 6.48TiB p=
ath /dev/sde
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=
=A0=C2=A0 4 size 7.28TiB used 6.49TiB path /dev/sdd
=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 size 7.28TiB used 6.49Ti=
B path /dev/sdc
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=
=C2=A0=C2=A0 6 size 7.28TiB used 6.49TiB path /dev/sdf
=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 7 size 953.87GiB used 1=
10.00GiB path /dev/nvme1n1
'''
btrfs fi df /mnt/Data

'''

Data=
, single: total=3D8.65TiB, used=3D8.40TiB
Data, RAID6: total=3D15.02TiB, =
used=3D14.39TiB
System, DUP: total=3D8.00MiB, used=3D896.00KiB
System, =
RAID1C3: total=3D32.00MiB, used=3D1.48MiB
Metadata, DUP: total=3D13.00GiB=
, used=3D9.28GiB
Metadata, RAID1C3: total=3D17.00GiB, used=3D16.98GiB
G=
lobalReserve, single: total=3D512.00MiB, used=3D0.00B
WARNING: Multiple b=
lock group profiles detected, see 'man btrfs(5)'
WARNING:=C2=A0=C2=A0=
=C2=A0 Data: single, raid6
WARNING:=C2=A0=C2=A0=C2=A0 Metadata: dup, raid=
1c3
WARNING:=C2=A0=C2=A0=C2=A0 System: dup, raid1c3

'''

I hope =
this helps further improving BTRFS, and maybe we even find a solution for m=
e.

Best Regards
Norbert Morawski
