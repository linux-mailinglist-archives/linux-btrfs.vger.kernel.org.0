Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93712CB15
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 23:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfL2WEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 17:04:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44632 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfL2WEU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 17:04:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so31203939wrm.11
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 14:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ih53gz87U67IrufngVlkI9Ph/vlTxGx9j9fFxPe/MUQ=;
        b=uSP4YVYL4rCfKcdVpPhW3TWC0lgfSenIgM5aEPek+Lt9nsKdN/v2HP8B33nLPJ6KiU
         GoKaoIEpi3hmNE+TpnuKkxI1KXVlrrB4+ZOkx3UCk9D2ij3jODLI/qbBOflaworoge0B
         +ohxln159FK4w0t5si2LRqZmOOYoHk8xXE+7xG8Anfs1ml1ZSqM6Xv1melRnhgx6lI1x
         6Rt0x4gNQT+/67Lg5L7EmRuuD2Uj4Iqg0ZK10jhYTNQylaPZnVenl8sVanVe0PtcZqF7
         GygddBTfuRp/05VnbzKvFl6Vs1eIt6mmYeuB6BWGmDJGBBdP3w/H30bo3rxfbwUuICmW
         H9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ih53gz87U67IrufngVlkI9Ph/vlTxGx9j9fFxPe/MUQ=;
        b=muzFJohaDkkM37qC73HZPFSafn+NJ6gTQVc7cHCAnLcs9hPPAxdNp6PKgXekiqTd1l
         MLXim2T0Qg7AjaaU4PobbXP70OO6e7H5AaTkMtf67RtQJEQYFR2k9fmYlpmnh0cCDg12
         LtzlC2XYACrmGL8WbT9KHa7d42PGaS0RWMUH9xt62KOZFxSxZuEZMxG33TLcob0j+ipl
         D/aBEA95Gbhopqx9TuEvAfjD80GCoByTUaMCsYmHg8AP3JjGlIdUue+1onXI3afYidy0
         yLsdq1doH3ETUW3aQ6dLTD/LotxIQTragnaiigXrjHoawGQKiJ/+hsxh5zXFry08RPv9
         6pSw==
X-Gm-Message-State: APjAAAWzgJ+RGfV4jpGQdZecYgrNVVxxW1cpL//H8jZOmwZgEwOAhUyq
        Re4ROQ8tEGf6hPg7aMANpDEpThXjedgDHncB9FwbOQ==
X-Google-Smtp-Source: APXvYqwDrazgm0wNZWQdmDeKwSecQHv+w79Pefnek8qswm2cC2pyi3lVG3/qWdStQQU8aDQabP6eZuiCGmDEru3qii8=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr64916881wrc.69.1577657057032;
 Sun, 29 Dec 2019 14:04:17 -0800 (PST)
MIME-Version: 1.0
References: <19acbd39-475f-bd72-e280-5f6c6496035c@web.de> <CAJCQCtQ-ApthkeKtSgsFN+JuTpPoX0OFubOGQdbz=OnNkphB_w@mail.gmail.com>
 <2cd36d11-8a71-513b-1991-076135bb2bcb@web.de>
In-Reply-To: <2cd36d11-8a71-513b-1991-076135bb2bcb@web.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 29 Dec 2019 15:04:01 -0700
Message-ID: <CAJCQCtRSq5mexYyJQaxRFSY3ieuFAednoCZ_dHaJuJn5h495+w@mail.gmail.com>
Subject: Re: invalid root item size
To:     Matthias Neuer <mneuer@web.de>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 1:10 PM Matthias Neuer <mneuer@web.de> wrote:
>
> > What do you get for:
> >
> > btrfs insp dump-t -b 78397440 /dev/
>
> # btrfs insp dump-t -b 78397440 /dev/sda8
> btrfs-progs v5.4
> leaf 78397440 items 26 free space 1525 generation 295254 owner FS_TREE
> leaf 78397440 flags 0x1(WRITTEN) backref revision 1
> fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
> chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
>          item 0 key (1332998 DIR_ITEM 3130087984) itemoff 3925 itemsize 70
>                  location key (3507605 INODE_ITEM 0) type FILE
>                  transid 294390 data_len 0 name_len 40
>                  name: 8BB587804509CED5F513154BC0A363B28181CA32
>          item 1 key (1332998 DIR_ITEM 3130144874) itemoff 3855 itemsize 70
>                  location key (3512356 INODE_ITEM 0) type FILE
>                  transid 294697 data_len 0 name_len 40
>                  name: C2CC7DE8F9C94004389D79E12B48337A0BF131F2
>          item 2 key (1332998 DIR_ITEM 3130492080) itemoff 3785 itemsize 70
>                  location key (3512915 INODE_ITEM 0) type FILE
>                  transid 294745 data_len 0 name_len 40
>                  name: 5EBCE6B1C5DEC3FBD7F54B204ABB7B27869F46C5
>          item 3 key (1332998 DIR_ITEM 3131798930) itemoff 3715 itemsize 70
>                  location key (3498678 INODE_ITEM 0) type FILE
>                  transid 293709 data_len 0 name_len 40
>                  name: 79CA97CB52BB10347B366E29B14032B50CB32FEB
>          item 4 key (1332998 DIR_ITEM 3132247620) itemoff 3645 itemsize 70
>                  location key (3516250 INODE_ITEM 0) type FILE
>                  transid 294988 data_len 0 name_len 40
>                  name: C2ED3E58BA3DF162034E5DF958A36B3730CE2D22
>          item 5 key (1332998 DIR_ITEM 3132872963) itemoff 3575 itemsize 70
>                  location key (3510772 INODE_ITEM 0) type FILE
>                  transid 294612 data_len 0 name_len 40
>                  name: 2B1D8D0EABE3270CD3861650E33AA152211269A5
>          item 6 key (1332998 DIR_ITEM 3133521864) itemoff 3505 itemsize 70
>                  location key (3513293 INODE_ITEM 0) type FILE
>                  transid 294757 data_len 0 name_len 40
>                  name: 1C31C9DFD79A176FC74E841C1B3E1EEAAFAD6DB8
>          item 7 key (1332998 DIR_ITEM 3135778465) itemoff 3435 itemsize 70
>                  location key (3499818 INODE_ITEM 0) type FILE
>                  transid 293763 data_len 0 name_len 40
>                  name: 6B3F3BF6770F6D765B985D9DEA817D232F516B42
>          item 8 key (1332998 DIR_ITEM 3136033001) itemoff 3365 itemsize 70
>                  location key (3514224 INODE_ITEM 0) type FILE
>                  transid 294859 data_len 0 name_len 40
>                  name: C2F67FEC928AD09C70D6E5E34306151606C5E766
>          item 9 key (1332998 DIR_ITEM 3136068331) itemoff 3295 itemsize 70
>                  location key (3499950 INODE_ITEM 0) type FILE
>                  transid 293785 data_len 0 name_len 40
>                  name: 2076D0DCF0B92263B870A342D6335750D53E3979
>          item 10 key (1332998 DIR_ITEM 3136862813) itemoff 3225 itemsize 70
>                  location key (3516141 INODE_ITEM 0) type FILE
>                  transid 294979 data_len 0 name_len 40
>                  name: B351730279BAEA46FFA75C81BB4845A3279588CE
>          item 11 key (1332998 DIR_ITEM 3136903919) itemoff 3155 itemsize 70
>                  location key (3514752 INODE_ITEM 0) type FILE
>                  transid 294925 data_len 0 name_len 40
>                  name: 6DB8F41C0DC906C3B6B67236366F02B27AF754F6
>          item 12 key (1332998 DIR_ITEM 3137030161) itemoff 3085 itemsize 70
>                  location key (3514647 INODE_ITEM 0) type FILE
>                  transid 294918 data_len 0 name_len 40
>                  name: 4FDECAE1E8623BE30F252BB797773339DF0347E6
>          item 13 key (1332998 DIR_ITEM 3137466626) itemoff 3015 itemsize 70
>                  location key (3511789 INODE_ITEM 0) type FILE
>                  transid 294677 data_len 0 name_len 40
>                  name: 2B39C52481A95C302F6883978494B14FA0414D6C
>          item 14 key (1332998 DIR_ITEM 3138020936) itemoff 2945 itemsize 70
>                  location key (3510913 INODE_ITEM 0) type FILE
>                  transid 294628 data_len 0 name_len 40
>                  name: 7E3F74EFB7086FB86BC15485C76E171C5A5C6CDE
>          item 15 key (1332998 DIR_ITEM 3138122317) itemoff 2875 itemsize 70
>                  location key (3510027 INODE_ITEM 0) type FILE
>                  transid 294561 data_len 0 name_len 40
>                  name: 02C3D9DB2E70F46B5608C69CB45896B575603517
>          item 16 key (1332998 DIR_ITEM 3138185936) itemoff 2805 itemsize 70
>                  location key (3507136 INODE_ITEM 0) type FILE
>                  transid 294347 data_len 0 name_len 40
>                  name: B9D99E4DB2E137511AE8D8279D5858D823EF9C13
>          item 17 key (1332998 DIR_ITEM 3139327597) itemoff 2735 itemsize 70
>                  location key (3510124 INODE_ITEM 0) type FILE
>                  transid 294562 data_len 0 name_len 40
>                  name: 4C27C41B0A8845515F1B9B25003B0B45BB4DD942
>          item 18 key (1332998 DIR_ITEM 3140643033) itemoff 2665 itemsize 70
>                  location key (3511959 INODE_ITEM 0) type FILE
>                  transid 294685 data_len 0 name_len 40
>                  name: 95094F9E4F311506768734893846734F27AD2E20
>          item 19 key (1332998 DIR_ITEM 3140704695) itemoff 2595 itemsize 70
>                  location key (3498378 INODE_ITEM 0) type FILE
>                  transid 293709 data_len 0 name_len 40
>                  name: 5B7D840DD5967F3EC451425E546D2C03500A1CB3
>          item 20 key (1332998 DIR_ITEM 3141274869) itemoff 2525 itemsize 70
>                  location key (3502212 INODE_ITEM 0) type FILE
>                  transid 294041 data_len 0 name_len 40
>                  name: BED3483239921D9909FA486DA35757873112DD86
>          item 21 key (1332998 DIR_ITEM 3142456641) itemoff 2455 itemsize 70
>                  location key (3511305 INODE_ITEM 0) type FILE
>                  transid 294647 data_len 0 name_len 40
>                  name: 9B1EFDA864E04F6D149EE97494DD7D3D9DAAB971
>          item 22 key (1332998 DIR_ITEM 3142477919) itemoff 2385 itemsize 70
>                  location key (3509650 INODE_ITEM 0) type FILE
>                  transid 294548 data_len 0 name_len 40
>                  name: 775E4D8DE2F4BA8F68D90F3CD6E89B5192D9D9C4
>          item 23 key (1332998 DIR_ITEM 3143784176) itemoff 2315 itemsize 70
>                  location key (3504110 INODE_ITEM 0) type FILE
>                  transid 294149 data_len 0 name_len 40
>                  name: 5E503D5DF967A3BF5A857CA69C661F4F7DE481E3
>          item 24 key (1332998 DIR_ITEM 3144212607) itemoff 2245 itemsize 70
>                  location key (3498707 INODE_ITEM 0) type FILE
>                  transid 293710 data_len 0 name_len 40
>                  name: E11D377B142C50C7895AEB8961960471155F1ECE
>          item 25 key (1332998 DIR_ITEM 3145170596) itemoff 2175 itemsize 70
>                  location key (3507702 INODE_ITEM 0) type FILE
>                  transid 294396 data_len 0 name_len 40
>                  name: DC6939EC397EB57C8812D34FDE5F3E1483BFA999

I don't see any root item in this leaf at all, I'm confused.


>
> > If there are filenames in the output you can remove/sanitize them.
> These strange filenames are cache files from firefox and so I just deleted them. But if I put in other block numbers which appear in dmesg for dump-t I am not so lucky:
>
> # btrfs insp dump-t -b 285405184 /dev/sda8
> btrfs-progs v5.4
> node 285405184 level 1 items 61 free 60 generation 295475 owner FS_TREE
> fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
> chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
>          key (3516683 DIR_INDEX 3) block 300871680 gen 295475
>          key (3516699 INODE_ITEM 0) block 300953600 gen 295475
>          key (3516703 INODE_ITEM 0) block 300957696 gen 295475
>          key (3516708 INODE_ITEM 0) block 301015040 gen 295475
>          key (3516713 INODE_ITEM 0) block 301092864 gen 295475
>          key (3516716 INODE_REF 3516669) block 301326336 gen 295475
>          key (3516734 INODE_ITEM 0) block 299872256 gen 295475
>          key (3516760 INODE_ITEM 0) block 232648704 gen 295425
>          key (3516869 INODE_ITEM 0) block 236732416 gen 295426
>          key (3516983 INODE_ITEM 0) block 61214720 gen 295147
>          key (3516989 INODE_REF 1332998) block 285138944 gen 295474
>          key (3516994 INODE_REF 1332998) block 42741760 gen 295123
>          key (3517014 EXTENT_DATA 0) block 133730304 gen 295316
>          key (3517028 EXTENT_DATA 0) block 42749952 gen 295123
>          key (3517051 INODE_ITEM 0) block 301330432 gen 295475
>          key (3517278 INODE_ITEM 0) block 39383040 gen 295123
>          key (3517279 EXTENT_DATA 0) block 42758144 gen 295123
>          key (3517282 EXTENT_DATA 0) block 44212224 gen 295127
>          key (3517326 INODE_ITEM 0) block 31232000 gen 295168
>          key (3517380 INODE_ITEM 0) block 29921280 gen 295168
>          key (3517404 INODE_ITEM 0) block 34881536 gen 295169
>          key (3517693 INODE_ITEM 0) block 31338496 gen 295168
>          key (3517694 INODE_REF 1332998) block 76279808 gen 295154
>          key (3517697 INODE_ITEM 0) block 279601152 gen 295466
>          key (3517714 INODE_ITEM 0) block 133726208 gen 295316
>          key (3517724 INODE_REF 1332998) block 35565568 gen 295172
>          key (3517745 INODE_REF 1332998) block 31219712 gen 295168
>          key (3517799 INODE_ITEM 0) block 32735232 gen 295168
>          key (3517895 INODE_ITEM 0) block 50614272 gen 295133
>          key (3517902 EXTENT_DATA 0) block 50130944 gen 295133
>          key (3517909 EXTENT_DATA 0) block 52219904 gen 295135
>          key (3517914 INODE_REF 1332998) block 52719616 gen 295135
>          key (3517928 INODE_REF 1332998) block 135065600 gen 295316
>          key (3517944 INODE_REF 1332998) block 135098368 gen 295316
>          key (3517970 EXTENT_DATA 0) block 76419072 gen 295150
>          key (3517988 INODE_REF 1332998) block 134750208 gen 295316
>          key (3518000 INODE_ITEM 0) block 134791168 gen 295316
>          key (3518014 INODE_ITEM 0) block 62775296 gen 295149
>          key (3518018 EXTENT_DATA 8192) block 79409152 gen 295163
>          key (3518028 EXTENT_DATA 12288) block 283504640 gen 295474
>          key (3518032 EXTENT_DATA 0) block 283484160 gen 295474
>          key (3518037 INODE_ITEM 0) block 283791360 gen 295474
>          key (3518082 INODE_ITEM 0) block 32157696 gen 295168
>          key (3518107 INODE_ITEM 0) block 285437952 gen 295475
>          key (3518161 INODE_ITEM 0) block 35807232 gen 295172
>          key (3518161 INODE_REF 3504139) block 51822592 gen 295224
>          key (3518193 INODE_ITEM 0) block 285536256 gen 295471
>          key (3518205 EXTENT_DATA 126976) block 281796608 gen 295471
>          key (3518208 INODE_ITEM 0) block 130437120 gen 295269
>          key (3518219 EXTENT_DATA 0) block 283009024 gen 295473
>          key (3518247 INODE_ITEM 0) block 282075136 gen 295473
>          key (3518250 INODE_REF 528) block 283881472 gen 295473
>          key (3518465 INODE_ITEM 0) block 228093952 gen 295422
>          key (3518918 INODE_ITEM 0) block 228143104 gen 295422
>          key (3518947 EXTENT_DATA 0) block 124354560 gen 295289
>          key (3519052 INODE_ITEM 0) block 124669952 gen 295289
>          key (3519062 EXTENT_DATA 0) block 282337280 gen 295473
>          key (3519069 EXTENT_DATA 0) block 126033920 gen 295263
>          key (3519086 INODE_ITEM 0) block 113582080 gen 295276
>          key (3519090 INODE_ITEM 0) block 261554176 gen 295445
>          key (3519132 INODE_ITEM 0) block 126877696 gen 295269
>
> Here I can't spot a filename.

This is a node. It points to leafs. So what we're looking for depends
on the exact kernel error that you got the block number from.


>
> > btrfs check /dev/
>
> After deleting these cache files btrfs check still gives no error.

So btrfs check has no errors but you're still seeing corruption
messages from the kernel? What about using check with the
--mode=lowmem option? It's a lot slower.


> >
> > This should give a good idea whether --repair can fix it, but we'll
> > need to hear from a developer about it first. In the meantime you can
> > make sure the backup is current.
> >
>
> I backup up all my data.
> I wonder if these errors would be gone if I reinstalled my system and copied back my data.
> Would cost me a few hours but maybe not more than trying to fix this.

If it's not causing grief yet, I'd give it a few days for a developer
to reply about what might be going on. And whether it can be fixed.

But yes, this is metadata corruption. So a new file system won't have
the problem.


-- 
Chris Murphy
