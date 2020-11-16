Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0122B41CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 12:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgKPK5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 05:57:24 -0500
Received: from smtp.radex.nl ([178.250.146.7]:59361 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbgKPK5Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 05:57:24 -0500
Received: from [192.168.1.158] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id B3B3E2406A;
        Mon, 16 Nov 2020 11:57:20 +0100 (CET)
Subject: Re: Fwd: Read time tree block corruption detected
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Tyler Richmond <t.d.richmond@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
 <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
 <0d6a0602-897a-b170-f1a2-007cff1f23fb@gmx.com>
 <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
 <5b757c2b-6dbf-cbec-6c66-e4b14897f53c@gmx.com>
 <838490cf-fc40-0008-88bb-eeede1e8d873@gmail.com>
 <50e0ef4d-061e-d02d-9dbf-61f83dfa7b3e@suse.com>
 <117797ff-c28b-c755-da17-fb7ce3169f0f@gmail.com>
 <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com>
 <ca811ad9-5ae4-602e-98a4-5d4d6c860a1c@gmail.com>
 <0acac733-233c-0c71-b9bc-c4bee1c724ba@suse.com>
 <4dd24fde-6d7f-202f-5d2f-b4478d797a93@gmail.com>
 <fcd272a5-a437-e918-8102-3813a608574c@gmx.com>
 <a26dc3fa-f68a-31fd-dbf8-692892df6019@gmail.com>
 <d57d7430-c0c5-315e-9d74-08d4b38696aa@suse.com>
 <1afa30fd-518e-f93e-24ae-e0cd87ce6885@gmail.com>
 <CAA91j0XLWcHsj4K4QfMOfQ01a43OJxPO-P246Y-wZ9c=uFP=Ow@mail.gmail.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <b0a07c20-974d-0cbd-7884-bee3b43bda91@gmail.com>
Date:   Mon, 16 Nov 2020 11:57:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAA91j0XLWcHsj4K4QfMOfQ01a43OJxPO-P246Y-wZ9c=uFP=Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Op 16-11-2020 om 11:52 schreef Andrei Borzenkov:
> On Mon, Nov 16, 2020 at 1:44 PM Ferry Toth <fntoth@gmail.com> wrote:
>> - Built btrfs-progs v5.9 from
>> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git and
>> booting Kubuntu 20.10 from USB stick then running btrfs-progs v5.9 fixes
>> it with below log.
>>
> What do you mean "fixes"? "btrfs check" is read-only by default so
> your invocation could not fix anything. Was it the only command you
> invoked?
Yeah, immediately after that command I ran

sudo ./btrfs check --repair /dev/sda2

to really repair, and then I could clean up:

rm -rf /usr/share/dog

>> - Thanks Qu for the help!
>>
>> Ferry
>>
>> log
>>
>> ---
>>
>> kubuntu@kubuntu:~$ sudo ./btrfs check /dev/sda2
>> Opening filesystem to check...
>> Checking filesystem on /dev/sda2
>> UUID: 27155120-9ef8-47fb-b248-eaac2b7c8375
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> [4/7] checking fs roots
>> root 294 inode 915975 errors 100000, invalid inode generation or transid
>> root 294 inode 915976 errors 100000, invalid inode generation or transid
>> root 294 inode 915977 errors 100000, invalid inode generation or transid
>> root 294 inode 915978 errors 100000, invalid inode generation or transid
>> root 294 inode 915979 errors 100000, invalid inode generation or transid
>> root 294 inode 915980 errors 100000, invalid inode generation or transid
>> root 294 inode 915982 errors 100000, invalid inode generation or transid
>> root 294 inode 915984 errors 100000, invalid inode generation or transid
>> root 294 inode 915985 errors 100000, invalid inode generation or transid
>> root 294 inode 915987 errors 100000, invalid inode generation or transid
>> root 294 inode 1962496 errors 100000, invalid inode generation or transid
>> root 294 inode 1962499 errors 100000, invalid inode generation or transid
>> root 294 inode 1962500 errors 100000, invalid inode generation or transid
>> root 294 inode 1962501 errors 100000, invalid inode generation or transid
>> root 294 inode 1962502 errors 100000, invalid inode generation or transid
>> root 294 inode 1962503 errors 100000, invalid inode generation or transid
>> root 294 inode 1962504 errors 100000, invalid inode generation or transid
>> root 294 inode 1962505 errors 100000, invalid inode generation or transid
>> root 294 inode 1962506 errors 100000, invalid inode generation or transid
>> root 294 inode 1962507 errors 100000, invalid inode generation or transid
>> root 294 inode 1962508 errors 100000, invalid inode generation or transid
>> root 294 inode 1962509 errors 100000, invalid inode generation or transid
>> root 294 inode 1962510 errors 100000, invalid inode generation or transid
>> root 294 inode 1962511 errors 100000, invalid inode generation or transid
>> root 294 inode 1962512 errors 100000, invalid inode generation or transid
>> root 294 inode 1962513 errors 100000, invalid inode generation or transid
>> root 294 inode 1962514 errors 100000, invalid inode generation or transid
>> root 294 inode 1962515 errors 100000, invalid inode generation or transid
>> root 294 inode 1962516 errors 100000, invalid inode generation or transid
>> root 294 inode 1962517 errors 100000, invalid inode generation or transid
>> root 294 inode 1962518 errors 100000, invalid inode generation or transid
>> root 294 inode 1962519 errors 100000, invalid inode generation or transid
>> root 294 inode 1962520 errors 100000, invalid inode generation or transid
>> root 294 inode 1962521 errors 100000, invalid inode generation or transid
>> root 294 inode 1962522 errors 100000, invalid inode generation or transid
>> root 294 inode 1962523 errors 100000, invalid inode generation or transid
>> root 294 inode 1962524 errors 100000, invalid inode generation or transid
>> root 294 inode 1962525 errors 100000, invalid inode generation or transid
>> root 294 inode 1962526 errors 100000, invalid inode generation or transid
>> root 294 inode 1962527 errors 100000, invalid inode generation or transid
>> root 294 inode 1962528 errors 100000, invalid inode generation or transid
>> root 294 inode 1962529 errors 100000, invalid inode generation or transid
>> root 294 inode 1962530 errors 100000, invalid inode generation or transid
>> root 294 inode 1962531 errors 100000, invalid inode generation or transid
>> root 294 inode 1962532 errors 100000, invalid inode generation or transid
>> root 294 inode 1962533 errors 100000, invalid inode generation or transid
>> root 294 inode 1962534 errors 100000, invalid inode generation or transid
>> root 294 inode 1962535 errors 100000, invalid inode generation or transid
>> root 294 inode 1962536 errors 100000, invalid inode generation or transid
>> root 294 inode 1962537 errors 100000, invalid inode generation or transid
>> root 294 inode 1962538 errors 100000, invalid inode generation or transid
>> root 294 inode 1962539 errors 100000, invalid inode generation or transid
>> root 294 inode 1962540 errors 100000, invalid inode generation or transid
>> root 294 inode 1962541 errors 100000, invalid inode generation or transid
>> root 294 inode 1962542 errors 100000, invalid inode generation or transid
>> root 294 inode 1962543 errors 100000, invalid inode generation or transid
>> root 294 inode 1962544 errors 100000, invalid inode generation or transid
>> root 294 inode 1962545 errors 100000, invalid inode generation or transid
>> root 294 inode 1962546 errors 100000, invalid inode generation or transid
>> root 294 inode 1962547 errors 100000, invalid inode generation or transid
>> root 294 inode 1962548 errors 100000, invalid inode generation or transid
>> root 294 inode 1962549 errors 100000, invalid inode generation or transid
>> root 294 inode 1962550 errors 100000, invalid inode generation or transid
>> root 294 inode 1962551 errors 100000, invalid inode generation or transid
>> root 294 inode 1962552 errors 100000, invalid inode generation or transid
>> root 294 inode 1962553 errors 100000, invalid inode generation or transid
>> root 294 inode 1962554 errors 100000, invalid inode generation or transid
>> root 294 inode 1962555 errors 100000, invalid inode generation or transid
>> root 294 inode 1962556 errors 100000, invalid inode generation or transid
>> root 294 inode 1962557 errors 100000, invalid inode generation or transid
>> root 294 inode 1962558 errors 100000, invalid inode generation or transid
>> root 294 inode 1962559 errors 100000, invalid inode generation or transid
>> root 294 inode 1962560 errors 100000, invalid inode generation or transid
>> root 294 inode 1962561 errors 100000, invalid inode generation or transid
>> root 294 inode 1962562 errors 100000, invalid inode generation or transid
>> root 294 inode 1962563 errors 100000, invalid inode generation or transid
>> root 294 inode 1962564 errors 100000, invalid inode generation or transid
>> root 294 inode 1962565 errors 100000, invalid inode generation or transid
>> root 294 inode 1962566 errors 100000, invalid inode generation or transid
>> root 294 inode 1962567 errors 100000, invalid inode generation or transid
>> root 294 inode 1962568 errors 100000, invalid inode generation or transid
>> root 294 inode 1962569 errors 100000, invalid inode generation or transid
>> root 294 inode 1962570 errors 100000, invalid inode generation or transid
>> root 294 inode 1962571 errors 100000, invalid inode generation or transid
>> root 294 inode 1962572 errors 100000, invalid inode generation or transid
>> root 294 inode 1962573 errors 100000, invalid inode generation or transid
>> root 294 inode 1962574 errors 100000, invalid inode generation or transid
>> root 294 inode 1962575 errors 100000, invalid inode generation or transid
>> root 294 inode 1962576 errors 100000, invalid inode generation or transid
>> root 294 inode 1962577 errors 100000, invalid inode generation or transid
>> root 294 inode 1962578 errors 100000, invalid inode generation or transid
>> root 294 inode 1962579 errors 100000, invalid inode generation or transid
>> root 294 inode 1962580 errors 100000, invalid inode generation or transid
>> root 294 inode 1962581 errors 100000, invalid inode generation or transid
>> root 294 inode 1962582 errors 100000, invalid inode generation or transid
>> root 294 inode 1962583 errors 100000, invalid inode generation or transid
>> root 294 inode 1962584 errors 100000, invalid inode generation or transid
>> root 294 inode 1962585 errors 100000, invalid inode generation or transid
>> root 294 inode 1962586 errors 100000, invalid inode generation or transid
>> ERROR: errors found in fs roots
>> found 444725678080 bytes used, error(s) found
>> total csum bytes: 272354940
>> total tree bytes: 1862316032
>> total fs tree bytes: 1250484224
>> total extent tree bytes: 277397504
>> btree space waste bytes: 401028956
>> file data blocks allocated: 16021691621376
>>    referenced 394733535232
>>
>>
