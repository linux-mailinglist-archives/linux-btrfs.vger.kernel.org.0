Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4173F156332
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2020 07:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgBHG2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 01:28:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:39013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgBHG2h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Feb 2020 01:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581143309;
        bh=FpyrA5jVaEneSOxq4tS80SmjGCT5Xp2Azv3OmHQeAXI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=K2XmQZRec2hapvgmoXS9UWklmsHOhyha4V3ZgWAdsfTlZRnhAVILWMzYZqyXliyp7
         YjO+ofEmaaDSloeun1g2szxYreWtPztgTO1wJ0NbaZbF7of9dTBtA7SSFylOk63jIh
         RpSJqTH8k2J4eUkodWO9IcvCi9qfRL4dnVqAg+LI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEV3C-1ikOVa2Tec-00G0Ds; Sat, 08
 Feb 2020 07:28:29 +0100
Subject: Re: [PATCH v3] btrfs: Don't submit any btree write bio after
 transaction is aborted
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200205071015.19621-1-wqu@suse.com>
 <3dce6f8a-c577-66b7-d104-b8409255b49b@toxicpanda.com>
 <443a3b4a-c751-741c-1f27-f39f16ad1ded@gmx.com>
 <547fd1f1-ded8-2953-d958-5741a631aaef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <a41437de-5251-3024-7912-7ad762650f47@gmx.com>
Date:   Sat, 8 Feb 2020 14:28:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <547fd1f1-ded8-2953-d958-5741a631aaef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Su95Lgu8jMNWp5REjlwHk8qAop4uXCmmZ"
X-Provags-ID: V03:K1:UJzBN61o8ZGn8VAgPVLKfZOYT1f/z+ZFlLWoNbkQQFJujh7yW8e
 l2EF2cOaEHhk/IX9tyY9Cdo0tkn0mgBYo3iYihJ6NQfkpvsdvS5TisVoAq4uo6bdHehAi0X
 PzmG1y1M5D7De6E4j5r7myn1TTtZZnWaZgatkaaFlbsNg9Gec/kI7iUCRofzn3QCzsKem9A
 NdntCwc6oxF+HBli/VgCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HXYUBN38RfI=:d4iWl7ANpcvxhxIr0EzKNj
 1BkWzNXbabSmECrpGWsQx2/y+QSH7zyx0x9UWqWwrCeWNdzRepLc9mp6xslHo/PN6YtpE/tZi
 mFb3nylXd7gNb2KLUnJLPqnaDj1D5DpoqwXutq3oMi6QWdE7CUaYPlzsa2GP5CDX3rKiUihs0
 80jmuCR9xpsd6jKYCettEU0XjQGJ2ThT53qGnHdRbpHrioFVxEJNINQLDWIX6P3bD5z15Pa9c
 0fzXL5z+BZ8CVc5mI9aAvFU8n9g7/T6pbxUGbc9107GiYsdMSw9roB1ra4qWw7BBSO3h2EEUc
 6wWKp/A0dXlenFwrN5XmoT0nI1tM0sTLpsUHgCgSGDFVWKlN1dsB336+NpW2ydJ6LX4pQJ4Gy
 PQYMKV5XB3BTDkk5J6X0fpb1USr+De5ccm17nsFeO8lLEPfhjEexxnbkRrBYZRgTy3WvLn4jq
 oXpmbUdYwcNFeb6617mPwcgJBWD4ZZAaNeU6oxMF5kkxf35pGTyEkTDOVF1GDgzOxSevfyZf6
 xinBJo6ONFNnIhTSQbBTr+JpzT4HkzU9+UNFwX72ODBDXA29iI8xjL3vAyYP6MmwLNVvJeNMi
 Z1ppwP8JSjvbWRz6VP3XN//k2FECc4PEfxW0Ema1oQCKj85IEZmuzh8LhzoUd1Gh/+d7zWG8X
 szlut3sqK5WssKs+Tx/PTJpCXroRu3XmHCdXl/QLki5uc7zKNB1ydRUzsWePX/ckms5F+CPN+
 JXNRFLzInMS5yaL+gKP4xuy3nORjnlvgA6XtIs2Zflhdndd2WPG/3IUlzLP665O7YW9vmLH3o
 MwY9UtPKlRe+Fr3IQWPVV8Hp65PyfH5OnTpz+MVmhoA1FkK70DZHjvA0VJI1w99LNHJB9ZZ7A
 WFWOdxkH8ylcqyOjLoDgBToq4v858kIQ+NkyEPrEvjF6rh9WdXAMX4KOFo0IBm+vosOl6ZEiX
 DWDxRwCsCz/T4PLgIZfw4V7x94ewNXAdvP/MlDIciG0BoTIzQ8EhZK28uQMq2sSFUm3CbO/Pe
 QUecxcN+YJVtlFsCWZmGq70Y+ChLVHcPE9WGhGPHywWUqZBfLwqk+ktYyE8eG3mWQ95CZ71at
 aVKgzhdEeJbchmAtOmQ1wbbn72BoieA0x4hzRHkWDnw8q8ug8q4o2Nob7jq/aRvnAJr+zNAav
 M4drkQGP+mCJnFdk3ReRL1HZY3fdwjHKB3gjmw/57+B5fEDaQc4oYM3NSrVbXUOhYsuIf06bU
 3lLJ6s1tA8u5S77lJ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Su95Lgu8jMNWp5REjlwHk8qAop4uXCmmZ
Content-Type: multipart/mixed; boundary="iWZhhk68KQUNHhasHKj0PftqP7u1hUtgY"

--iWZhhk68KQUNHhasHKj0PftqP7u1hUtgY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/7 =E4=B8=8A=E5=8D=888:37, Josef Bacik wrote:
> On 2/6/20 7:24 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/2/7 =E4=B8=8A=E5=8D=8812:00, Josef Bacik wrote:
>>> On 2/5/20 2:10 AM, Qu Wenruo wrote:
>>>> [BUG]
>>>> There is a fuzzed image which could cause KASAN report at unmount ti=
me.
>>>>
>>>> =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> =C2=A0=C2=A0=C2=A0 BUG: KASAN: use-after-free in btrfs_queue_work+0x=
2c1/0x390
>>>> =C2=A0=C2=A0=C2=A0 Read of size 8 at addr ffff888067cf6848 by task u=
mount/1922
>>>>
>>>> =C2=A0=C2=A0=C2=A0 CPU: 0 PID: 1922 Comm: umount Tainted: G=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 5.0.21 #1
>>>> =C2=A0=C2=A0=C2=A0 Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS
>>>> 1.10.2-1ubuntu1 04/01/2014
>>>> =C2=A0=C2=A0=C2=A0 Call Trace:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 dump_stack+0x5b/0x8b
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 print_address_description+0x70/0x280
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 kasan_report+0x13a/0x19b
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_queue_work+0x2c1/0x390
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_wq_submit_bio+0x1cd/0x240
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btree_submit_bio_hook+0x18c/0x2a0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 submit_one_bio+0x1be/0x320
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 flush_write_bio.isra.41+0x2c/0x70
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btree_write_cache_pages+0x3bb/0x7f0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 do_writepages+0x5c/0x130
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 __writeback_single_inode+0xa3/0x9a0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 writeback_single_inode+0x23d/0x390
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 write_inode_now+0x1b5/0x280
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 iput+0x2ef/0x600
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 close_ctree+0x341/0x750
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 generic_shutdown_super+0x126/0x370
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 kill_anon_super+0x31/0x50
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_kill_super+0x36/0x2b0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 deactivate_locked_super+0x80/0xc0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 deactivate_super+0x13c/0x150
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 cleanup_mnt+0x9a/0x130
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 task_work_run+0x11a/0x1b0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 exit_to_usermode_loop+0x107/0x130
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 do_syscall_64+0x1e5/0x280
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>
>>>> [CAUSE]
>>>> The fuzzed image has a completely screwd up extent tree:
>>>> =C2=A0=C2=A0=C2=A0 leaf 29421568 gen 8 total ptrs 6 free space 3587 =
owner EXTENT_TREE
>>>> =C2=A0=C2=A0=C2=A0 refs 2 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_ow=
ner 0 current 5938
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
tem 0 key (12587008 168 4096) itemoff 3942 itemsize 53
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 1=

>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: extent data backref =
root 5 objectid 259
>>>> offset 0 count 1
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
tem 1 key (12591104 168 8192) itemoff 3889 itemsize 53
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 1=

>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: extent data backref =
root 5 objectid 271
>>>> offset 0 count 1
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
tem 2 key (12599296 168 4096) itemoff 3836 itemsize 53
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 1=

>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: extent data backref =
root 5 objectid 259
>>>> offset 4096 count 1
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
tem 3 key (29360128 169 0) itemoff 3803 itemsize 33
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 2=

>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: tree block backref r=
oot 5
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
tem 4 key (29368320 169 1) itemoff 3770 itemsize 33
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 2=

>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: tree block backref r=
oot 5
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
tem 5 key (29372416 169 0) itemoff 3737 itemsize 33
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 2=

>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: tree block backref r=
oot 5
>>>>
>>>> Note that, leaf 29421568 doesn't has its backref in extent tree.
>>>> Thus extent allocator can re-allocate leaf 29421568 for other trees.=

>>>>
>>>> Short version for the corruption:
>>>> - Extent tree corruption
>>>> =C2=A0=C2=A0=C2=A0 Existing tree block X can be allocated as new tre=
e block.
>>>>
>>>> - Tree block X allocated to log tree
>>>> =C2=A0=C2=A0=C2=A0 The tree block X generation get bumped, and is tr=
aced by
>>>> =C2=A0=C2=A0=C2=A0 log_root->dirty_log_pages now.
>>>>
>>>> - Log tree writes tree blocks
>>>> =C2=A0=C2=A0=C2=A0 log_root->dirty_log_pages is cleaned.
>>>>
>>>> - The original owner of tree block X wants to modify its content
>>>> =C2=A0=C2=A0=C2=A0 Instead of COW tree block X to a new eb, due to t=
he bumped
>>>> =C2=A0=C2=A0=C2=A0 generation, tree block X is reused as is.
>>>>
>>>> =C2=A0=C2=A0=C2=A0 Btrfs believes tree block X is already dirtied du=
e to its transid,
>>>> =C2=A0=C2=A0=C2=A0 but it is not tranced by transaction->dirty_pages=
=2E
>>>>
>>>
>>> But at the write part we should have gotten BTRFS_HEADER_FLAG_WRITTEN=
,
>>> so we should have cow'ed this block.=C2=A0 So this isn't what's happe=
ning,
>>> right?
>>
>> =C2=A0From my debugging, it's not the case. By somehow, after log tree=
 writes
>> back, the tree block just got reused.
>>
>>> =C2=A0=C2=A0 Or is something else clearing the BTRFS_HEADER_FLAG_WRIT=
TEN in
>>> between the writeout and this part?=C2=A0 Thanks,
>>
>> It didn't occur to me at the time of writing, is it possible that log
>> tree get freed, thus that tree block X is considered free, and get
>> re-allocated to extent tree again?
>>
>=20
> Yeah, but then they'd go onto the dirty pages radix tree properly,
> because it would be the correct root, and we wouldn't have this problem=
=2E
>=20
>> The problem is really killing me to digging.
>> Can't we use this last-resort method anyway? The corrupted extent tree=

>> is really causing all kinds of issues we didn't expect...
>=20
> Which is why I want the real root cause and a real fix, not something
> that's papering over the problem.=C2=A0 Thanks,

OK, this fuzzed image doesn't go sane now.

During my debugging, the most weird thing happened.

With the following diff applied, the problem just disappear.

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 968faaec0e39..0d37768003a5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1447,6 +1447,7 @@ static inline int should_cow_block(struct
btrfs_trans_handle *trans,
                                   struct btrfs_root *root,
                                   struct extent_buffer *buf)
 {
+       int ret;
        if (btrfs_is_testing(root->fs_info))
                return 0;

@@ -1469,8 +1470,9 @@ static inline int should_cow_block(struct
btrfs_trans_handle *trans,
            !(root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID &&
              btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
            !test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
-               return 0;
-       return 1;
+               ret =3D 0;
+       ret =3D 1;
+       return ret;
 }

 /*

How could this happen?!?!?

Thanks,
Qu
>=20
> Josef


--iWZhhk68KQUNHhasHKj0PftqP7u1hUtgY--

--Su95Lgu8jMNWp5REjlwHk8qAop4uXCmmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4+VQkACgkQwj2R86El
/qiVpwf/RAh6xtQLJrFdqjt0AyOnDU6x/ScM/G8ry+I0pCGVZJgbcez1yX/dSCd1
D4p6ClPdqA7dqseHrLhGge+dV1lhWPPh8AsCplIEwdlsJbM8eukqsk75beTTQxi5
o5syIo5lBrVnnox9B1+IM/SdZZeWWhXGvBTdOt2bwuZbNPMxwJrPOZoF0tvcZ8AE
Ad7uk8xEceYli0flF+BaTu/EouW79XWw4DXAm9XVaIdfJ+MMdelVjhs6DC/Uoxwy
83Xf159GJcGuASI+6nd2KKI0PjBWQP49AIt9WwHdFCKE43wgCBSxRATBzeonDUT+
lCUACWj57WUS/97ppb2l1NqJe6MGFg==
=OjBn
-----END PGP SIGNATURE-----

--Su95Lgu8jMNWp5REjlwHk8qAop4uXCmmZ--
