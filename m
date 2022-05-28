Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47685369CC
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 03:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353586AbiE1BfV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 21:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355538AbiE1BfL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 21:35:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A2713C367
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653701702;
        bh=7EL2hXUNDNTkQFzbUhxdqjACGIegMwaGpqbELF7RHAI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DZJzaTVLNmSa/+VN9WZ/v2LD0IfceqgKsM4lCw1vyo3LsTz/wE4gPHqpuWdIjoTEJ
         0kWU7hwqi0sWGQdScGKXw86S1HF1xJIRQelauxjzsMgAl0N6ubDqv5orkj+sGGORMZ
         iHKBqb+eFuVZOqzHRXNi2uf7p/rhKBHCMhJKGq7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXtY-1oL3eH1iym-00QTsD; Sat, 28
 May 2022 03:35:02 +0200
Message-ID: <90214e83-4450-8e0f-6a86-f30acaeda931@gmx.com>
Date:   Sat, 28 May 2022 09:34:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Btrfs progs release 5.18
Content-Language: en-US
To:     John Center <jlcenter15@gmail.com>, linux-btrfs@vger.kernel.org
References: <20220525140644.21979-1-dsterba@suse.com>
 <95422f7b-e0f9-c716-212e-ee1007176d7e@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <95422f7b-e0f9-c716-212e-ee1007176d7e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y5hs34tX29z6aiLABRTt8HWrtzbVTCPsIB+qDbExTp90OyfIOWq
 urXb9MpC158+X6aUJXh3tCZeNZFxdGpTc6GIDnfzrGr/IzQZZzVsD1rGoXgyCk2BB9jaznY
 jHfulTEDOpZGHD0BXpwfkCbE+C9+5zldeTmq655JKyKhrIR1cHNzr/nEbxeRBTYMacGOmCT
 aHK7mGrjqa0yiu3mm2gcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/kPI7LDwLUM=:WiEbM/zkgZ0DSvf2aTG9Zy
 Jk3bcgjBhfRnLfXSP9HYZnfanx1m6K5/ntQ5w0Oqrot4Xspj0rApch6YFWS0BkjFLIMQKsWVx
 bvbqMuWcCEZi6szjcDjUvGOOURcY5C5M9B1+ONnFCjxRgzS1LgGuHggayKmwQOM+4wHLG5Auf
 +JgsmjISJJaVhK76prHRQVf+4SleNyrqNKEGhqabjp5OUNztHur06eOVciaAonemM913S/PCY
 vhQtwojNxt3S7xg763HTkmF21QoSSJwmn09wLT2s/QRTfL8AkhxPNJ+gx9rulsCxh6csdHfJy
 mPdTNJQG6Hu2cvwvFSHFQWT/56T0yaNaAU2BXSWBgDeZfE/6vZTTEiebk5y8Xs6p4YpE5Q/6N
 g06xQ/y+m4TibVJ+RFYI4n47f3AM0Agi6lWxSA2VMaHBjO9x4LjNN702YevdIYwzCrp1GP9L3
 GfUtKGuydLhGWt+QeVvPK6TUbCTOfKJAN5gch7/g2o2InrMf0xKvY6jhmC6G6SCLmq5oi6kwq
 gbpsJT/ww+NGZvDOwqtzeEFrvQP2f1trz9fKcZCqhWRACkp3CHHEY+1KS77SzV9i4oezqCIc1
 diU9mYF2t2u0fj2t5N8OoeexSpw2zhSfzVGE3FFkkeY5xBkuOoNMoY1k2QgghzldigWSeDtNF
 LF2fDkHHrr/btuFEAZnc8p3YSNRixDuQXbeAwRovUGvHqL1y4x9NfxUhtC39Ux7Ler+BlCMxw
 o3SQjP9jPPMUHO8JOkZ9S2lYRHpdqIDO/RhYUXGHj2xHA+PURW/iABxTsX6ZCNWvanvUmmc94
 8e6ryEF6OrXJLff4+ybS4f5dSg6Ylfa3awE9KFMkD/IJFXdgD695Qx6UX8lagkuIYyrctVZjF
 UnsVzata3hZV0x6t/ur37kBMQIrdZSbNJxhlG69yh4eoi7r6oDlovWeJ8/7ghV+FyIxPsULAP
 yURQfDR6wIEeIgsk/ddz5CxMzru66pR2hfNYntfNYKha7y4sgeJjACpx0xDn2UbXcMFxpN5Qq
 PQowwMgCzTJcHfHy7ElA0yCr8kjq5YmX7XDINjBPzIsj8iaXuwxu8OxE6Do1iNNXAOg6okqkv
 FQACznA7BplqNZK+rqerjKr1neeSGdWZeibRt2Zez80SHZdY8S3AmtB7Q==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/28 08:20, John Center wrote:
> Hi,
>
> I usually build the btrfs-progs when it comes out.=C2=A0 I've upgraded f=
rom
> Ubuntu 20.04 to 22.04 & I'm having a problem with configure looking for
> ext2fs.=C2=A0 I have e2fsprogs & libext2fs2 installed, but it fails with=
 "No
> package 'ext2fs' found".=C2=A0 What am I missing?

Is the -devel package installed?

Thanks,
Qu

>
> Thanks!
>
>  =C2=A0=C2=A0=C2=A0 -John
>
>
> On 5/25/22 10:06 AM, David Sterba wrote:
>> Hi,
>>
>> btrfs-progs version 5.18 have been released.
>>
>> Changelog:
>> * fixes:
>> =C2=A0=C2=A0 * dump-tree: don't print traling zeros in checksums
>> =C2=A0=C2=A0 * recognize paused balance as exclusive operation state, a=
llow to
>> start
>> =C2=A0=C2=A0=C2=A0=C2=A0 device add
>> =C2=A0=C2=A0 * convert: properly initialize target filesystem label
>> =C2=A0=C2=A0 * mkfs: don't create free space bitmaps for empty filesyst=
em
>> * restore: make lzo support build-time configurable, print supported
>> =C2=A0=C2=A0 compression in help text
>> * update kernel-lib sources
>> * other:
>> =C2=A0=C2=A0 * documentation updates, finish conversion to RST, CHANGES=
 and INSTALL
>> =C2=A0=C2=A0=C2=A0=C2=A0 could be included into RST
>> =C2=A0=C2=A0 * fix build detection of experimental mode
>> =C2=A0=C2=A0 * new tests
>>
>> Tarballs:
>> https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
>> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.gi=
t
>>
>> Shortlog:
>>
>> David Sterba (34):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: reformat CHANGES for =
RST
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: unify CHANGES indenta=
tion
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: make device add and p=
aused balance work together
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: btrfstune: fix build-=
time detection of
>> experimental features
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: move glossary t=
o overview sections
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: kernel-lib: add rbtre=
e_types.h from linux
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: kernel-lib: add simpl=
ified READ_ONCE and WRITE_ONCE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: kernel-lib: add rb_ro=
ot_cached helpers
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: kernel-lib: sync lib/=
rbtree.c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: kernel-lib: sync incl=
ude/overflow.h
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: kernel-lib: sync incl=
ude/list.h
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: kernel-lib: sync incl=
ude/rtree.h
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: INSTALL: update depen=
dencies for docs build
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: link INSTALL to=
 docs
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: INSTALL: drop referen=
ce to libattr
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: add note about =
ifdef EXPERIMENTAL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: delete commented expo=
rts from libbtrfs.sym
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: separate bootlo=
aders chapter
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: document paused=
 balance
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: separate filesy=
stem limits chapter
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: move flexibilit=
y to Administration
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: separate chapte=
r for hardware considerations
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: merge storage m=
odel to hardware chapter
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: copy more conte=
nts from wiki
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: add subpage fea=
ture page
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: convert Experim=
ental.md to RST
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: convert btrfs-i=
octl.asciidoc to RST
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: convert convent=
ions to RST
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: fix superscript=
 formatting
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: update header f=
ormatting
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: restore: list the sup=
ported compression
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: tests: remove ext3 te=
sts
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: update CHANGES for 5.=
18
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Btrfs progs v5.18
>>
>> Forza (1):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: clarification o=
n mixed profile
>>
>> Qu Wenruo (9):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: remove the unused btr=
fs_fs_info::seeding member
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: print-tree: print the=
 checksum of header without
>> tailing zeros
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: check: lowmem, fix pa=
th leak when dev extents are
>> invalid
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: convert: initialize t=
he target fs label
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: remove unused header =
check/btrfsck.h
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: docs: add more explan=
ation on subapge limits
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: do not use btrfs_comm=
it_transaction() just to
>> update super blocks
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: properly initialize b=
lock group thresholds
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: tests: make sure we d=
on't create bitmaps for empty fs
>>
>> Ross Burton (1):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs-progs: build: add option to =
disable LZO support for restore
>>
