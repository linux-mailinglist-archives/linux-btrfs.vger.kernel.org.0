Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197834D27B1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 05:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiCIBUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 20:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiCIBTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 20:19:50 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CD12E14D
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 17:11:26 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw13so1593616ejc.9
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 17:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNfaP+SZOFCyuLgMZObGGd6aYI2/274IHvMC89c9wLY=;
        b=Es/5FPPRisN/c7/O4qmYuEnnSslJvpkPPyl5VvGJ+PABysasoXYvysgr+7Qe2Buuzn
         Kcx7iHvEjU/Zm4+x+2bT2iWIZ6zzaHJujK5Td3sQLfQ0fTZHpMKctJTcWAldC+F9BQs2
         bmFI9C7hUSrHCAXcZuLqoTVfkv0NfBXurmQcVKWklMP9nlhJvUiyUUl/0ELBK/4a8MLM
         e2Ivu+nBWufMr4MOMSTdh4M78wYzGe0wKFFqXDhikaQuYaeO5dh8F4e3q803bJDxElx/
         4h//hZ1qOQpYhToDpwCuhe4PATX2wDG3X2pvhqeQ2yArLqz6kcYG5AHl6NDKUVeToxZ9
         ig/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNfaP+SZOFCyuLgMZObGGd6aYI2/274IHvMC89c9wLY=;
        b=Ffk5O5dVajQZx8MCoWkNSlavkpioW9S8Vh1LIjZm2yKXO0z4dpg66Z8KX4WZdWLmlT
         sd/ixxYgCXR5ctzthOGV9DadpmcFlbpU0agqu0tLC8psQrxIxM3gQ5nz8ieaAlUP7G9y
         lMantKbAS9AlIMg5XAqoYz1v3DnCG8M9rQZ6/UEu6V/Zjf8mu1Z2XSJbHnEeyJM8pxhJ
         0t1GQRwV7nMMzDchjmgdEPR44ZTKNyJxP+/8CLpvyDPU0Cxv9+lEjbtxfksuevrEiBMx
         hc+VxahJVd74ZX7jyogOyulXCylQVD5F9yFsLXDNPOyBsNX4rbFUJTHryW6NgRow4TJB
         9DNw==
X-Gm-Message-State: AOAM532Ig2QUG+TbkieK8vE3xEfDkuA/feSigyl1akqDVEa8gT+weUkn
        ravUrtFJaL6KgB21/KoEcToButrJeOCWBbKmSmnSmmqAfQg=
X-Google-Smtp-Source: ABdhPJzfO7eqJjtXQVtlModPeqoaU2tw26gPX0DvPz3f1eVfJIK020MD4pYFLFEzXbpALUa3iUaz+W1r9DiNUND2qCQ=
X-Received: by 2002:a17:906:2ed1:b0:6b6:bb09:178c with SMTP id
 s17-20020a1709062ed100b006b6bb09178cmr15636953eji.382.1646788192041; Tue, 08
 Mar 2022 17:09:52 -0800 (PST)
MIME-Version: 1.0
References: <CALPV6DsfOQHyQ2=+3pKF3ZfavL21fgthQS+=HStEfMQbhZU50g@mail.gmail.com>
 <7a4962a0-b007-59a4-282e-8912b2425c5e@gmx.com>
In-Reply-To: <7a4962a0-b007-59a4-282e-8912b2425c5e@gmx.com>
From:   bill gates <framingnoone@gmail.com>
Date:   Tue, 8 Mar 2022 19:09:40 -0600
Message-ID: <CALPV6DtuY6KxFKF6WR2HDPzzVm8TbcGEXwTMiDAy6MdL+jC7jA@mail.gmail.com>
Subject: Re: Updated to new kernel, and btrfs suddenly refuses to mount home
 directory fs.
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This filesystem was most likely created in 2014 using the tools of
that time, at least that's the oldest file in my home directory. It
_might_ have been made in 2019, that's the date on the mount point.

There are 2 subvolumes on /dev/sda2, /home and /var.

My btrfs-progs version is 5.15.1.

Per your request:
# btrfs ins dump-tree -b 10442806968320 /dev/sda2
btrfs-progs v5.15.1
leaf 10442806968320 items 34 free space 6225 generation 6834902 owner CSUM_TREE
leaf 10442806968320 flags 0x1(WRITTEN) backref revision 1
fs uuid 83c6c9ca-b8fe-4d4c-aaa8-1729f90b0824
chunk uuid 9b77400b-f370-4f49-be82-9cb38c7f78a0
       item 0 key (EXTENT_CSUM EXTENT_CSUM 9848629587968) itemoff
16075 itemsize 208
               range start 9848629587968 end 9848629800960 length 212992
       item 1 key (EXTENT_CSUM EXTENT_CSUM 9848630026240) itemoff
15823 itemsize 252
               range start 9848630026240 end 9848630284288 length 258048
       item 2 key (EXTENT_CSUM EXTENT_CSUM 9848630714368) itemoff
15815 itemsize 8
               range start 9848630714368 end 9848630722560 length 8192
       item 3 key (EXTENT_CSUM EXTENT_CSUM 9848630984704) itemoff
14723 itemsize 1092
               range start 9848630984704 end 9848632102912 length 1118208
       item 4 key (EXTENT_CSUM EXTENT_CSUM 9848632160256) itemoff
14703 itemsize 20
               range start 9848632160256 end 9848632180736 length 20480
       item 5 key (EXTENT_CSUM EXTENT_CSUM 9848632180736) itemoff
14279 itemsize 424
               range start 9848632180736 end 9848632614912 length 434176
       item 6 key (EXTENT_CSUM EXTENT_CSUM 9848632942592) itemoff
14067 itemsize 212
               range start 9848632942592 end 9848633159680 length 217088
       item 7 key (EXTENT_CSUM EXTENT_CSUM 9848633286656) itemoff
13815 itemsize 252
               range start 9848633286656 end 9848633544704 length 258048
       item 8 key (EXTENT_CSUM EXTENT_CSUM 9848633548800) itemoff
13579 itemsize 236
               range start 9848633548800 end 9848633790464 length 241664
       item 9 key (EXTENT_CSUM EXTENT_CSUM 9848633810944) itemoff
13527 itemsize 52
               range start 9848633810944 end 9848633864192 length 53248
       item 10 key (EXTENT_CSUM EXTENT_CSUM 9848633950208) itemoff
12671 itemsize 856
               range start 9848633950208 end 9848634826752 length 876544
       item 11 key (EXTENT_CSUM EXTENT_CSUM 9848634826752) itemoff
12659 itemsize 12
               range start 9848634826752 end 9848634839040 length 12288
       item 12 key (EXTENT_CSUM EXTENT_CSUM 9848634970112) itemoff
12643 itemsize 16
               range start 9848634970112 end 9848634986496 length 16384
       item 13 key (EXTENT_CSUM EXTENT_CSUM 9848635056128) itemoff
12583 itemsize 60
               range start 9848635056128 end 9848635117568 length 61440
       item 14 key (EXTENT_CSUM EXTENT_CSUM 9848635117568) itemoff
12151 itemsize 432
               range start 9848635117568 end 9848635559936 length 442368
       item 15 key (EXTENT_CSUM EXTENT_CSUM 9848635592704) itemoff
12135 itemsize 16
               range start 9848635592704 end 9848635609088 length 16384
       item 16 key (EXTENT_CSUM EXTENT_CSUM 9848635703296) itemoff
11791 itemsize 344
               range start 9848635703296 end 9848636055552 length 352256
       item 17 key (EXTENT_CSUM EXTENT_CSUM 9848636108800) itemoff
11719 itemsize 72
               range start 9848636108800 end 9848636182528 length 73728
       item 18 key (EXTENT_CSUM EXTENT_CSUM 9848636669952) itemoff
11691 itemsize 28
               range start 9848636669952 end 9848636698624 length 28672
       item 19 key (EXTENT_CSUM EXTENT_CSUM 9848636698624) itemoff
11371 itemsize 320
               range start 9848636698624 end 9848637026304 length 327680
       item 20 key (EXTENT_CSUM EXTENT_CSUM 9848637026304) itemoff
10979 itemsize 392
               range start 9848637026304 end 9848637427712 length 401408
       item 21 key (EXTENT_CSUM EXTENT_CSUM 9848637468672) itemoff
10131 itemsize 848
               range start 9848637468672 end 9848638337024 length 868352
       item 22 key (EXTENT_CSUM EXTENT_CSUM 9848638631936) itemoff
10079 itemsize 52
               range start 9848638631936 end 9848638685184 length 53248
       item 23 key (EXTENT_CSUM EXTENT_CSUM 9848638685184) itemoff
9791 itemsize 288
               range start 9848638685184 end 9848638980096 length 294912
       item 24 key (EXTENT_CSUM EXTENT_CSUM 9848638980096) itemoff
9787 itemsize 4
               range start 9848638980096 end 9848638984192 length 4096
       item 25 key (EXTENT_CSUM EXTENT_CSUM 9848638984192) itemoff
9735 itemsize 52
               range start 9848638984192 end 9848639037440 length 53248
       item 26 key (EXTENT_CSUM EXTENT_CSUM 9848639045632) itemoff
9111 itemsize 624
               range start 9848639045632 end 9848639684608 length 638976
       item 27 key (EXTENT_CSUM EXTENT_CSUM 9848639684608) itemoff
9091 itemsize 20
               range start 9848639684608 end 9848639705088 length 20480
       item 28 key (EXTENT_CSUM EXTENT_CSUM 9848639967232) itemoff
8003 itemsize 1088
               range start 9848639967232 end 9848641081344 length 1114112
       item 29 key (EXTENT_CSUM EXTENT_CSUM 9848641150976) itemoff
7947 itemsize 56
               range start 9848641150976 end 9848641208320 length 57344
       item 30 key (EXTENT_CSUM EXTENT_CSUM 9848641409024) itemoff
7887 itemsize 60
               range start 9848641409024 end 9848641470464 length 61440
       item 31 key (EXTENT_CSUM EXTENT_CSUM 9848641695744) itemoff
7643 itemsize 244
               range start 9848641695744 end 9848641945600 length 249856
       item 32 key (EXTENT_CSUM EXTENT_CSUM 9848642043904) itemoff
7615 itemsize 28
               range start 9848642043904 end 9848642072576 length 28672
       item 33 key (EXTENT_CSUM EXTENT_CSUM 9848642162688) itemoff
7075 itemsize 540
               range start 9848642162688 end 9848642715648 length 552960


On Tue, Mar 8, 2022 at 5:48 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/3/9 03:05, bill gates wrote:
> > So, I recently attempted to upgrade from Linux kernel 4.19.82 to
> > 5.15.23, and I'm getting a critical error in dmesg about a corrupt
> > leaf (and no mounting of /home allowed with the options I'm aware of)
> >
> > [ 396.218964] BTRFS critical (device sda2): corrupt leaf: root=1
> > block=10442806968320 sl
> > ot=8 ino=6, invalid location key objectid: has 1 expect 6 or [256,
> > 18446744073709551360]
> > or 18446744073709551604
>
> Please provide the following output:
>
> # btrfs ins dump-tree -b 10442806968320 /dev/sda2
>
>
> The error message means, we got a DIR_ITEM in root tree.
>
> Normally that is used to indicate what default subvolume is.
> Thus it's normally 6 or 5, or any valid subvolume id.
>
> But in your case, it's 1, thus tree-checker is rejecting your root tree.
>
> I didn't thought we could have 1 as default subvolume (as 1 is the root
> tree, which is not a subvolume).
>
> But it looks like we should update btrfs check to fix this case.
>
> Is the fs created using older btrfs-progs? I guess that may be the cause...
>
> Thanks,
> Qu
>
>
> > [ 396.218967] BTRFS error (device sda2): block=10442806968320 read
> > time tree block corru
> > ption detected
> >
> >
> > Interestingly. that 18446... number is a power of 2, looks like maybe
> > a bit flip? dmesg, uname, etc included in pastebin below. "btrfs
> > check" found no problems with fs on either kernel version. Would like
> > to figure out how to fix this, if possible.
> >
> > https://pastebin.com/0ESPU9Z6
> >
> > Thank you for any assistance,
> > -- Laurence Michaels.
