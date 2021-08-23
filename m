Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90733F4786
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 11:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhHWJ3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 05:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbhHWJ3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 05:29:01 -0400
Received: from forward102j.mail.yandex.net (forward102j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78073C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 02:28:17 -0700 (PDT)
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 7EFD34BE9C61
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:28:13 +0300 (MSK)
Received: from vla1-9ce8aaee4e81.qloud-c.yandex.net (vla1-9ce8aaee4e81.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:50a2:0:640:9ce8:aaee])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 7AC6861E0008
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:28:13 +0300 (MSK)
Received: from vla1-719694b86d9e.qloud-c.yandex.net (vla1-719694b86d9e.qloud-c.yandex.net [2a02:6b8:c0d:3495:0:640:7196:94b8])
        by vla1-9ce8aaee4e81.qloud-c.yandex.net (mxback/Yandex) with ESMTP id prMbrEBh7a-SDIuvVbP;
        Mon, 23 Aug 2021 12:28:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1629710893;
        bh=IkQiBPGLdtYUhRuEYM1jrlgTeDGrrKk0LgJMcDy+p34=;
        h=Subject:To:Message-ID:From:References:Date:In-Reply-To;
        b=tJ5DadYtQ0ydCSCq/sk602ZF/jOBWiUycq8MEqRkZsWOeapjTIpRCqiVJAflPifrT
         CI+J8PGl5QVRAsYRD+eb87H3SIe/5ufDN4WHO79qNoI069nCNefyXSRcLIG50rGhQv
         gbb560rpzmjn8CR5xs0v+qqtVNg74y6PNJmvjcQQ=
Authentication-Results: vla1-9ce8aaee4e81.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-719694b86d9e.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 8Rbw7uopqe-SCaecncQ;
        Mon, 23 Aug 2021 12:28:12 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Mon, 23 Aug 2021 12:27:56 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1061569876.20210823122756@yandex.ru>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Is there a way to repeair btrfs?
In-Reply-To: <746581394.20210817202332@yandex.ru>
References: <746581394.20210817202332@yandex.ru>
X-Bat-Referred-Message: msgid:746581394.20210817202332@yandex.ru?to=linux-btrfs@vger.kernel.org&from=Eugen%20Konkov%20<kes-kes@yandex.ru>&folder=\\kes-kes@yandex.ru\Inbox&subject=Is%20there%20a%20way%20to%20repeair%20btrfs?&date=20210817202332&size=0&uid=63643&baseindex=2443&action=reply
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

May someone to advice at least a direction where I should dig to resolve th=
is problem?

Tuesday, August 17, 2021, 8:23:32 PM, you wrote:

> Hi. I have electrecity problem, for short period of time it was lost and =
my computer rebooted.

> After that on ST4000DM0004 disk every thing was good except partitions at=
 raid:

>  $ sudo btrfs filesystem show
> warning, device 2 is missing
> warning, device 2 is missing
> Label: none  uuid: 28c9f20b-6745-4f0b-9502-858f09dce1e3
>         Total devices 1 FS bytes used 7.49GiB
>         devid    1 size 3.50TiB used 10.02GiB path /dev/sdc1

> Label: none  uuid: 162e1cf7-d4f7-4421-80e4-1b88123ace02
>         Total devices 2 FS bytes used 588.05GiB
>         devid    1 size 1.24TiB used 590.01GiB path /dev/sdc3
>         *** Some devices missing

> Label: none  uuid: 422200da-ad08-4e5f-9e4c-4d11b090026b
>         Total devices 1 FS bytes used 677.58GiB
>         devid    1 size 1.16TiB used 681.02GiB path /dev/sdc4


> mounting this file system does not work:
> https://unix.stackexchange.com/q/664950/129967

> $ sudo mount -o degraded /dev/sdc3 /mnt/btrfs/
> mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on
> /dev/sdc3, missing codepage or helper program, or other error.

> but I can mount it in ro mode:

> but can not reattach disk =3D(

> $ sudo mount -o degraded,ro /dev/sdc3 /mnt/btrfs/

> $ sudo btrfs replace start -f -B 2 /dev/sdd3 /mnt/btrfs
> ERROR: ioctl(DEV_REPLACE_START) failed on "/mnt/btrfs": Read-only file sy=
stem

> $ sudo btrfs device delete /dev/sdd3 /mnt/btrfs
> ERROR: error removing device '/dev/sdd3': Read-only file system

> $ sudo btrfs device delete missing /mnt/btrfs/
> ERROR: error removing device 'missing': Read-only file system






> this is:=20
> $ sudo smartctl -i /dev/sdc
> smartctl 6.6 2016-05-31 r4324 [x86_64-linux-5.4.0-71-generic] (local buil=
d)
> Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.o=
rg

> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> Device Model:     ST4000DM004-2CV104
> Serial Number:    ZFN29T12
> LU WWN Device Id: 5 000c50 0b62eff52
> Firmware Version: 0001
> User Capacity:    4=E2=80=AF000=E2=80=AF787=E2=80=AF030=E2=80=AF016 bytes=
 [4,00 TB]
> Sector Sizes:     512 bytes logical, 4096 bytes physical
> Rotation Rate:    5425 rpm
> Form Factor:      3.5 inches
> Device is:        Not in smartctl database [for details use: -P showall]
> ATA Version is:   ACS-3 T13/2161-D revision 5
> SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 3.0 Gb/s)
> Local Time is:    Tue Aug 17 19:56:07 2021 EEST
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled



> repair is not success:





> $sudo btrfsck --repair /dev/sdc3
> [sudo] password for kes:        =20
> enabling repair mode
> warning, device 2 is missing
> warning, device 2 is missing
> Checking filesystem on /dev/sdc3
> UUID: 162e1cf7-d4f7-4421-80e4-1b88123ace02
> Fixed 0 roots.
> checking extents
> parent transid verify failed on 130793472 wanted 670 found 662
> parent transid verify failed on 130793472 wanted 670 found 662
> Csum didn't match
> parent transid verify failed on 130809856 wanted 670 found 664
> parent transid verify failed on 130809856 wanted 670 found 664
> Ignoring transid failure
> leaf parent key incorrect 130809856
> bad block 130809856
> ERROR: errors found in extent allocation tree or chunk allocation
> checking free space cache
> failed to load free space cache for block group 30408704
> failed to load free space cache for block group 189008969728
> failed to load free space cache for block group 190082711552
> failed to load free space cache for block group 191156453376
> failed to load free space cache for block group 192230195200
> failed to load free space cache for block group 195451420672
> failed to load free space cache for block group 196525162496
> failed to load free space cache for block group 200820129792
> failed to load free space cache for block group 201893871616
> failed to load free space cache for block group 208336322560
> failed to load free space cache for block group 210483806208
> failed to load free space cache for block group 212631289856
> failed to load free space cache for block group 215852515328
> failed to load free space cache for block group 216926257152
> failed to load free space cache for block group 223368708096
> failed to load free space cache for block group 225516191744
> failed to load free space cache for block group 227663675392
> failed to load free space cache for block group 229811159040
> failed to load free space cache for block group 231958642688
> failed to load free space cache for block group 235179868160
> failed to load free space cache for block group 236253609984
> failed to load free space cache for block group 237327351808
> failed to load free space cache for block group 239474835456
> failed to load free space cache for block group 249138511872
> failed to load free space cache for block group 251285995520
> failed to load free space cache for block group 254507220992
> failed to load free space cache for block group 259875930112
> failed to load free space cache for block group 260949671936
> failed to load free space cache for block group 262023413760
> failed to load free space cache for block group 263097155584
> failed to load free space cache for block group 265244639232
> failed to load free space cache for block group 267392122880
> failed to load free space cache for block group 272760832000
> failed to load free space cache for block group 273834573824
> failed to load free space cache for block group 277055799296
> failed to load free space cache for block group 278129541120
> failed to load free space cache for block group 280277024768
> failed to load free space cache for block group 281350766592
> failed to load free space cache for block group 292088184832
> failed to load free space cache for block group 293161926656
> failed to load free space cache for block group 294235668480
> failed to load free space cache for block group 295309410304
> failed to load free space cache for block group 302825603072
> failed to load free space cache for block group 306046828544
> failed to load free space cache for block group 309268054016
> failed to load free space cache for block group 310341795840
> failed to load free space cache for block group 311415537664
> failed to load free space cache for block group 312489279488
> failed to load free space cache for block group 314636763136
> failed to load free space cache for block group 315710504960
> failed to load free space cache for block group 316784246784
> failed to load free space cache for block group 317857988608
> failed to load free space cache for block group 318931730432
> failed to load free space cache for block group 320005472256
> failed to load free space cache for block group 323226697728
> failed to load free space cache for block group 326447923200
> failed to load free space cache for block group 328595406848
> failed to load free space cache for block group 329669148672
> failed to load free space cache for block group 330742890496
> failed to load free space cache for block group 331816632320
> failed to load free space cache for block group 332890374144
> failed to load free space cache for block group 333964115968
> failed to load free space cache for block group 336111599616
> failed to load free space cache for block group 339332825088
> failed to load free space cache for block group 340406566912
> failed to load free space cache for block group 341480308736
> failed to load free space cache for block group 342554050560
> failed to load free space cache for block group 343627792384
> failed to load free space cache for block group 344701534208
> failed to load free space cache for block group 348996501504
> failed to load free space cache for block group 350070243328
> failed to load free space cache for block group 351143985152
> failed to load free space cache for block group 352217726976
> failed to load free space cache for block group 354365210624
> failed to load free space cache for block group 357586436096
> failed to load free space cache for block group 359733919744
> failed to load free space cache for block group 360807661568
> failed to load free space cache for block group 366176370688
> failed to load free space cache for block group 368323854336
> failed to load free space cache for block group 371545079808
> failed to load free space cache for block group 372618821632
> failed to load free space cache for block group 373692563456
> failed to load free space cache for block group 374766305280
> failed to load free space cache for block group 375840047104
> failed to load free space cache for block group 377987530752
> failed to load free space cache for block group 380135014400
> failed to load free space cache for block group 381208756224
> failed to load free space cache for block group 382282498048
> failed to load free space cache for block group 385503723520
> failed to load free space cache for block group 386577465344
> failed to load free space cache for block group 387651207168
> failed to load free space cache for block group 388724948992
> failed to load free space cache for block group 394093658112
> failed to load free space cache for block group 401609850880
> failed to load free space cache for block group 402683592704
> failed to load free space cache for block group 405904818176
> failed to load free space cache for block group 409126043648
> failed to load free space cache for block group 411273527296
> failed to load free space cache for block group 412347269120
> failed to load free space cache for block group 413421010944
> failed to load free space cache for block group 414494752768
> failed to load free space cache for block group 415568494592
> failed to load free space cache for block group 416642236416
> failed to load free space cache for block group 418789720064
> failed to load free space cache for block group 419863461888
> failed to load free space cache for block group 420937203712
> failed to load free space cache for block group 424158429184
> failed to load free space cache for block group 427379654656
> failed to load free space cache for block group 429527138304
> failed to load free space cache for block group 430600880128
> failed to load free space cache for block group 431674621952
> failed to load free space cache for block group 433822105600
> failed to load free space cache for block group 434895847424
> failed to load free space cache for block group 443485782016
> failed to load free space cache for block group 444559523840
> failed to load free space cache for block group 446707007488
> failed to load free space cache for block group 447780749312
> failed to load free space cache for block group 448854491136
> failed to load free space cache for block group 449928232960
> failed to load free space cache for block group 452075716608
> failed to load free space cache for block group 453149458432
> failed to load free space cache for block group 454223200256
> failed to load free space cache for block group 460665651200
> failed to load free space cache for block group 461739393024
> failed to load free space cache for block group 463886876672
> failed to load free space cache for block group 466034360320
> failed to load free space cache for block group 467108102144
> failed to load free space cache for block group 468181843968
> failed to load free space cache for block group 470329327616
> failed to load free space cache for block group 471403069440
> failed to load free space cache for block group 475698036736
> failed to load free space cache for block group 481066745856
> failed to load free space cache for block group 484287971328
> failed to load free space cache for block group 485361713152
> failed to load free space cache for block group 487509196800
> failed to load free space cache for block group 488582938624
> failed to load free space cache for block group 489656680448
> failed to load free space cache for block group 492877905920
> failed to load free space cache for block group 495025389568
> failed to load free space cache for block group 496099131392
> failed to load free space cache for block group 502541582336
> failed to load free space cache for block group 503615324160
> failed to load free space cache for block group 508984033280
> failed to load free space cache for block group 510057775104
> failed to load free space cache for block group 519721451520
> failed to load free space cache for block group 527237644288
> failed to load free space cache for block group 529385127936
> failed to load free space cache for block group 532606353408
> failed to load free space cache for block group 534753837056
> failed to load free space cache for block group 535827578880
> failed to load free space cache for block group 537975062528
> failed to load free space cache for block group 539048804352
> failed to load free space cache for block group 540122546176
> failed to load free space cache for block group 541196288000
> failed to load free space cache for block group 546564997120
> failed to load free space cache for block group 547638738944
> failed to load free space cache for block group 551933706240
> failed to load free space cache for block group 553007448064
> failed to load free space cache for block group 557302415360
> failed to load free space cache for block group 558376157184
> failed to load free space cache for block group 560523640832
> failed to load free space cache for block group 564818608128
> failed to load free space cache for block group 568039833600
> failed to load free space cache for block group 571261059072
> failed to load free space cache for block group 576629768192
> failed to load free space cache for block group 577703510016
> failed to load free space cache for block group 578777251840
> failed to load free space cache for block group 580924735488
> failed to load free space cache for block group 581998477312
> failed to load free space cache for block group 583072219136
> failed to load free space cache for block group 584145960960
> failed to load free space cache for block group 586293444608
> failed to load free space cache for block group 589514670080
> failed to load free space cache for block group 591662153728
> failed to load free space cache for block group 592735895552
> failed to load free space cache for block group 593809637376
> failed to load free space cache for block group 594883379200
> failed to load free space cache for block group 595957121024
> failed to load free space cache for block group 597030862848
> failed to load free space cache for block group 598104604672
> failed to load free space cache for block group 601325830144
> failed to load free space cache for block group 602399571968
> failed to load free space cache for block group 603473313792
> failed to load free space cache for block group 604547055616
> failed to load free space cache for block group 606728093696
> failed to load free space cache for block group 608875577344
> failed to load free space cache for block group 609949319168
> failed to load free space cache for block group 611023060992
> failed to load free space cache for block group 616391770112
> failed to load free space cache for block group 617465511936
> failed to load free space cache for block group 622834221056
> failed to load free space cache for block group 623907962880
> failed to load free space cache for block group 624981704704
> failed to load free space cache for block group 626055446528
> failed to load free space cache for block group 628202930176
> failed to load free space cache for block group 632497897472
> failed to load free space cache for block group 634645381120
> failed to load free space cache for block group 635719122944
> failed to load free space cache for block group 638940348416
> failed to load free space cache for block group 642161573888
> failed to load free space cache for block group 643235315712
> failed to load free space cache for block group 644309057536
> checking fs roots
> parent transid verify failed on 377192448 wanted 651 found 648
> parent transid verify failed on 377192448 wanted 651 found 648
> Csum didn't match
> parent transid verify failed on 377225216 wanted 651 found 648
> parent transid verify failed on 377225216 wanted 651 found 648
> Ignoring transid failure
> parent transid verify failed on 377290752 wanted 651 found 648
> parent transid verify failed on 377290752 wanted 651 found 648
> Csum didn't match
> parent transid verify failed on 379928576 wanted 651 found 646
> parent transid verify failed on 379928576 wanted 651 found 646
> Csum didn't match
> parent transid verify failed on 381419520 wanted 651 found 648
> parent transid verify failed on 381419520 wanted 651 found 648
> Ignoring transid failure
> leaf parent key incorrect 381419520
> parent transid verify failed on 269647872 wanted 670 found 668
> parent transid verify failed on 269647872 wanted 670 found 668
> Ignoring transid failure
> parent transid verify failed on 270155776 wanted 670 found 668
> parent transid verify failed on 270155776 wanted 670 found 668
> Ignoring transid failure
> parent transid verify failed on 133382144 wanted 670 found 426
> parent transid verify failed on 133382144 wanted 670 found 426
> Csum didn't match
> parent transid verify failed on 133136384 wanted 670 found 660
> parent transid verify failed on 133136384 wanted 670 found 660
> Csum didn't match
> parent transid verify failed on 382828544 wanted 670 found 668
> parent transid verify failed on 382828544 wanted 670 found 668
> Csum didn't match
> parent transid verify failed on 270434304 wanted 670 found 668
> parent transid verify failed on 270434304 wanted 670 found 668
> Ignoring transid failure
> parent transid verify failed on 133152768 wanted 670 found 660
> parent transid verify failed on 133152768 wanted 670 found 660
> Csum didn't match
> root 807 inode 330 errors 1000, some csum missing
> checking csums
> parent transid verify failed on 377192448 wanted 651 found 648
> parent transid verify failed on 377192448 wanted 651 found 648
> Csum didn't match
> Error going to next leaf -5
> checking root refs
> Recowing metadata block 130809856
> Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0
> extent-tree.c:2764: alloc_tree_block: BUG_ON `ret` triggered, value -28
> btrfs check(+0x1f1e5)[0x55ea2f9171e5]
> btrfs check(+0x1f255)[0x55ea2f917255]
> btrfs check(+0x1f268)[0x55ea2f917268]
> btrfs check(btrfs_alloc_free_block+0x83)[0x55ea2f91b604]
> btrfs check(__btrfs_cow_block+0xfe)[0x55ea2f90fc3c]
> btrfs check(btrfs_cow_block+0xc5)[0x55ea2f9101e1]
> btrfs check(btrfs_search_slot+0xfa)[0x55ea2f912095]
> btrfs check(cmd_check+0x247d)[0x55ea2f94ca64]
> btrfs check(main+0x143)[0x55ea2f90ec87]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f03ad9f8bf7]
> btrfs check(_start+0x2a)[0x55ea2f90ecca]
> Aborted


> $ sudo btrfs check --repair --init-extent-tree /dev/sdc3
> enabling repair mode
> warning, device 2 is missing
> warning, device 2 is missing
> Checking filesystem on /dev/sdc3
> UUID: 162e1cf7-d4f7-4421-80e4-1b88123ace02
> Creating a new extent tree
> Failed to find [30588928, 168, 16384]
> btrfs unable to find ref byte nr 800522240 parent 0 root 1  owner 1 offse=
t 0
> Failed to find [30670848, 168, 16384]
> btrfs unable to find ref byte nr 138117120 parent 0 root 1  owner 0 offse=
t 1
> parent transid verify failed on 30490624 wanted 4 found 1103
> Ignoring transid failure
> Failed to find [43761664, 168, 16384]
> btrfs unable to find ref byte nr 802373632 parent 0 root 1  owner 0 offse=
t 1
> disk-io.c:438: write_and_map_eb: BUG_ON `ret` triggered, value -1
> btrfs(+0x1c175)[0x560846990175]
> btrfs(+0x1c197)[0x560846990197]
> btrfs(write_and_map_eb+0x127)[0x5608469909ab]
> btrfs(__commit_transaction+0xa7)[0x5608469b10f1]
> btrfs(btrfs_commit_transaction+0xdf)[0x5608469b122c]
> btrfs(cmd_check+0x121a)[0x5608469c7801]
> btrfs(main+0x143)[0x56084698ac87]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f2e10da7bf7]
> btrfs(_start+0x2a)[0x56084698acca]
> Aborted



> is there a way to restore data from this partition?
> thank you.




--=20
Best regards,
Eugen Konkov

