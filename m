Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0F13829A
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 18:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgAKRXx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jan 2020 12:23:53 -0500
Received: from ms11p00im-hyfv17281201.me.com ([17.58.38.39]:32800 "EHLO
        ms11p00im-hyfv17281201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730519AbgAKRXw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jan 2020 12:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578763429;
        bh=ETyDC74oxokl0d18NNTxhDas0XEDOmBBT3WbWqLiL0g=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=Luao1gpXJEYrdiQlbSPfSv6P6yutG+scF0a37fcT/xziHoEf9rDyALDzBrBSYik6S
         ipXH0s5EVP4HZjLMQaKi72K0UGia18pwWuKwchQiGntHo5KgFAX7fwhn8Tp4w49edb
         6McCr6bRqdwKDqI9UzcAHeBs2Y5aTBKcFreNlKC9WbzJelRyoIqV2jGtMe0Wa0Rf4W
         VAm7QRKpg7FkhPo4D3Jyhzm79QylIoYCknkalNIaZk/fXdkKqK+RebV5vh/nJSaVG9
         hR0yggQ2qUmvzeXBZ21PqswXXXeezczjTY2nzDFB00+vQjLa4/FNGaUv1AWlfB3FmU
         KYTJw9iWW7Apg==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-hyfv17281201.me.com (Postfix) with ESMTPSA id 5A6CDC00CC8;
        Sat, 11 Jan 2020 17:23:48 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: 12 TB btrfs file system on virtual machine broke again (third time)
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
Date:   Sat, 11 Jan 2020 14:23:45 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86147601-37F0-49C0-B6F8-0F5245750450@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com>
 <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com>
 <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
 <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com>
 <CAJCQCtROKcVBNuWkyF5kRgJMuQ4g4YSxh5GL6QmuAJL=A-JROw@mail.gmail.com>
 <25D1F99C-F34A-48D6-BF62-42225765FBC1@icloud.com>
 <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=696 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001110151
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys,

here the last lines before the suspend and after it:


66939.439945] Buffer I/O error on dev loop1, logical block 0, async page =
read
[66939.621686] print_req_error: I/O error, dev loop1, sector 83885952
[66939.621738] print_req_error: I/O error, dev loop1, sector 83885952
[66939.621740] Buffer I/O error on dev loop1, logical block 10485744, =
async page read
[509652.385601] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_SENSE
[509652.385623] sd 6:0:0:0: [sdb] tag#0 Sense Key : Illegal Request =
[current]=20
[509652.385628] sd 6:0:0:0: [sdb] tag#0 Add. Sense: Invalid command =
operation code
[509652.385631] sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 =
00 16 b2 c0 00 00 00 20 00 00
[509652.385634] print_req_error: critical target error, dev sdb, sector =
1487552
[509652.385642] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 0, rd =
1, flush 0, corrupt 0, gen 0
[509652.386117] xhci_hcd 0000:00:1d.6: Mismatch between completed Set TR =
Deq Ptr command & xHCI internal state.
[509652.386120] xhci_hcd 0000:00:1d.6: ep deq seg =3D ffff880bd3fbab40, =
deq ptr =3D ffff880bd3b65150
[509652.386132] sd 6:0:0:0: [sdb] tag#1 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_SENSE
[509652.386135] sd 6:0:0:0: [sdb] tag#1 Sense Key : Illegal Request =
[current]=20
[509652.386137] sd 6:0:0:0: [sdb] tag#1 Add. Sense: Invalid command =
operation code
[509652.386139] sd 6:0:0:0: [sdb] tag#1 CDB: Write(16) 8a 00 00 00 00 00 =
01 1d 9a 18 00 00 02 00 00 00
[509652.386141] print_req_error: critical target error, dev sdb, sector =
18717208
[509652.386158] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 1, rd =
1, flush 0, corrupt 0, gen 0
[509682.560535] xhci_hcd 0000:00:1d.6: Mismatch between completed Set TR =
Deq Ptr command & xHCI internal state.
[509682.560537] xhci_hcd 0000:00:1d.6: ep deq seg =3D ffff880bd3fbab40, =
deq ptr =3D ffff880bd3b65190
[509682.560566] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_SENSE
[509682.560567] sd 6:0:0:0: [sdb] tag#0 Sense Key : Illegal Request =
[current]=20
[509682.560569] sd 6:0:0:0: [sdb] tag#0 Add. Sense: Invalid command =
operation code
[509682.560571] sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 =
00 36 b2 c0 00 00 00 20 00 00
[509682.560572] print_req_error: critical target error, dev sdb, sector =
3584704
[509682.560579] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 1, rd =
2, flush 0, corrupt 0, gen 0
[509682.560667] BTRFS: error (device sdb1) in =
btrfs_start_dirty_block_groups:3716: errno=3D-5 IO failure
[509682.560669] BTRFS info (device sdb1): forced readonly
[509712.672325] xhci_hcd 0000:00:1d.6: Mismatch between completed Set TR =
Deq Ptr command & xHCI internal state.
[509712.672330] xhci_hcd 0000:00:1d.6: ep deq seg =3D ffff880bd3fbab40, =
deq ptr =3D ffff880bd3b651d0
[509712.672373] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_SENSE
[509712.672377] sd 6:0:0:0: [sdb] tag#0 Sense Key : Illegal Request =
[current]=20
[509712.672379] sd 6:0:0:0: [sdb] tag#0 Add. Sense: Invalid command =
operation code
[509712.672382] sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 =
00 16 b2 c0 00 00 00 20 00 00
[509712.672384] print_req_error: critical target error, dev sdb, sector =
1487552
[509712.672388] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 1, rd =
3, flush 0, corrupt 0, gen 0
[509742.783978] xhci_hcd 0000:00:1d.6: Mismatch between completed Set TR =
Deq Ptr command & xHCI internal state.
[509742.783982] xhci_hcd 0000:00:1d.6: ep deq seg =3D ffff880bd3fbab40, =
deq ptr =3D ffff880bd3b65210
[509742.784016] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_SENSE
[509742.784019] sd 6:0:0:0: [sdb] tag#0 Sense Key : Illegal Request =
[current]=20
[509742.784021] sd 6:0:0:0: [sdb] tag#0 Add. Sense: Invalid command =
operation code
[509742.784024] sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 =
00 36 b2 c0 00 00 00 20 00 00
[509742.784026] print_req_error: critical target error, dev sdb, sector =
3584704
[509742.784031] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 1, rd =
4, flush 0, corrupt 0, gen 0
[509742.784079] BTRFS: error (device sdb1) in =
btrfs_start_dirty_block_groups:3716: errno=3D-5 IO failure
[509742.784082] BTRFS warning (device sdb1): Skipping commit of aborted =
transaction.
[509742.784084] BTRFS: error (device sdb1) in cleanup_transaction:1881: =
errno=3D-5 IO failure
[509742.784084] BTRFS info (device sdb1): delayed_refs has NO entry
[512066.481724] usb 4-1: USB disconnect, device number 2
[512066.484604] sd 6:0:0:0: [sdb] Synchronizing SCSI cache
[512066.661516] usb 2-1: USB disconnect, device number 2
[512066.661725] usblp0: removed
[512066.716156] usb 1-1: USB disconnect, device number 2
[512066.751428] sd 6:0:0:0: [sdb] Synchronize Cache(10) failed: Result: =
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[512066.811207] usb 2-2: USB disconnect, device number 3
[512066.811350] usblp1: removed
[512066.963131] usb 2-3: USB disconnect, device number 4
[512066.963296] usblp2: removed
[512067.091114] usb 4-1: new SuperSpeed USB device number 3 using =
xhci_hcd
[512067.107446] usb 1-1: new full-speed USB device number 3 using =
uhci_hcd
[512067.113881] usb 2-4: USB disconnect, device number 5
[512067.114143] usblp3: removed
[512067.126193] usb 4-1: New USB device found, idVendor=3D2109, =
idProduct=3D0711
[512067.126195] usb 4-1: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
[512067.126196] usb 4-1: Product: 20231
[512067.126196] usb 4-1: Manufacturer: Ugreen
[512067.126197] usb 4-1: SerialNumber: 000000128DA4
[512067.140176] scsi host9: uas
[512067.141472] scsi 9:0:0:0: Direct-Access     ST6000DM 004-2EH11C      =
 DN02 PQ: 0 ANSI: 6
[512067.142615] sd 9:0:0:0:=20


Thanks,


Chris

