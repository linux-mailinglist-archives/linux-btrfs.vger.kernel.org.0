Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593C51164DB
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 02:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfLIBxI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 20:53:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:55443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfLIBxH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 20:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575856381;
        bh=TStZ6D84sXWY2vyG/SgQLWYHOpSEllborMNKUUX5Q4o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ihT8Lp5Sm1H1hTlTadLH5nWq4iB2XdA+aI02D0tIr+9LlmXOz24wr6n+/1Dp1CQtC
         85irjHA2Tmpx0EOQXBH2nUiZdDHeX3K+UywXYMKLQ/CFxHQHjUJ3y84tOmVvlH6hM6
         eSbVy1ESmPPE0uCRB0CgU7KpOpkSJ+GK6/e2/jCM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MysRu-1hsEbW0pjW-00w18U; Mon, 09
 Dec 2019 02:53:01 +0100
Subject: Re: Unable to remove directory entry
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Mike Gilbert <floppymaster@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <20191209001721.GF22121@hungrycats.org>
 <20191209013322.GG22121@hungrycats.org>
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
Message-ID: <0a0ae513-0993-e732-57e4-af0fa93bb2c3@gmx.com>
Date:   Mon, 9 Dec 2019 09:52:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209013322.GG22121@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qI2jSAbMQRMnjUJbPB0684Ab4qXvHPwNE"
X-Provags-ID: V03:K1:q5Eo+5/1hIS2Uc7Cli6JMW+GqV+zQRAcVWcs0oKpsADEPU5S8rm
 q25Cytb5RNpigxxmxSaS9f82ubnh735X5QPkatj/nodsgPIVeH8nT/gLamPVa4P6Wx5uBb0
 4nigihf4YhWt5ftlOceWB4hcS8roChOAV3GGoMF+E0xQSEm0vcfkemax7i9zJym+sZj6VWs
 QPIRPrnfgEjort4mzgU5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iv9xvKIiNrE=:IJoJGniClSaJT/DQ0VI3bu
 ItgaBFDNQ/A71l8pTgZLwgNQ4kdDu8CF582Ghr40PFMY0deT+UEyoFglX8D9MyDGAZtj+I0NU
 liErH9YB2EbKz2mTnodB14JaAJipTMNOrk+EabFaevwo7KzHNh8Li6U12bUdfo2xzJC8PEn+g
 AnosohRdp44BrbddvyIWkNq1UWzl5uisiL3g+1iz8fcSuxTDsWV/zKe5KhvJ8yncWLCXPacxI
 x3v/pAEG6jlcHKzzAX5Rq7bGquOS0YJeyPuQF9NXSqAfpm/Yw3TS44W0uKbc3a3ZnE8BxMNPo
 lFDnJVC/vY4KlWWzIe/hF8LyonM0WPI8guFue0uVJz3ofZleifmukvjNqOsjqcb0BvoQc1kax
 Sv/BT3otc0nwqPaorOJ9GLxR4ZDjaSjPeg/DDLdTvo1kG/4HooVZtKdgV2xQvcjDK/wKVoB/R
 Ja08LkptGq+/vjOp/HLq7qVUi8v5xQ56rm2hLc26N4VRMxFQjqH/q9TPrKxeLUYQuPQ2vTChP
 jQL29RVReT6PznRa3s8qdjJHntAJ5vp+gJanw9BJB3atDmcVznQJSeS0COMpVFBaFFgdqjmA1
 0Ck3+PxlyS2Tw7vyhOQGkIab9dUHnKMhySAeV2gqxy7ZRlhuJfNoukYtwycykS03+/Bv7vXiS
 D1vVYYJqFoKNr17RedRPMJars5PBvM4uhCI5bt9/gWYQ+1NMGPbP5r082vTC8MjU0bRmJOKa9
 gMZPGC3cWJoWitcwszQbnG7fDhXpHil2dNjXJ6FKG7oJXOxeTm3LIA3PQxcyzLpP2j3e32g8E
 9okXqbaUFyMSGboawD1kvwW1nvPYGOoIPEbB9HIYruy/iGY1G+mswFsJmiaoJCSwenDhtq//M
 b7/h8wRykqDKra3wYEgu6S92fy8JFQyV9S9r90qVPSTear8PItPnkirOIQ1/4PF7sQzndxF0Q
 m6ZTuybg9x5hodqfrrj4c/kjfXfIq2VMoNtU4xpRh2Ol/UL7ol3knr5ykoiaHf3uuiiSIMJxg
 Dw8VagGspcbgRYkbfsV3cNdAB5BFLqOq0Rje245pvxQ6K2POLvLLX/xNK8Udv60igy9aODD+V
 CpzS1onNuFCkgy+rTqFvpVb59SYJYKlENYal9BH0in6pEl3n5hIuu4LF6GeJmfHFkaoizm6ga
 v/NoLsx9tv0kOV0FHoYhnuoimz+FZHypgcvvcwvNXKGJ5F/DmndJg5Ur/YyyhB/UR4gYsQg9x
 JIe4g+ZVPJjRrewl5BYso5WRDwmXMuhok41tgNzYPAGZ2uSlogPQSGYwiC2w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qI2jSAbMQRMnjUJbPB0684Ab4qXvHPwNE
Content-Type: multipart/mixed; boundary="0FjhuYwoH8KPMDCd8dBYbaGBFjtooFijQ"

--0FjhuYwoH8KPMDCd8dBYbaGBFjtooFijQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/9 =E4=B8=8A=E5=8D=889:33, Zygo Blaxell wrote:
> On Sun, Dec 08, 2019 at 07:17:21PM -0500, Zygo Blaxell wrote:
>> On Sun, Dec 08, 2019 at 02:19:10PM -0500, Mike Gilbert wrote:
>>> Hello,
>>>
>>> I have a directory entry that cannot be stat-ed or unlinked. This
>>> issue persists across reboots, so it seems there is something wrong o=
n
>>> disk.
>>>
>>> % ls -l /var/cache/ccache.bad/2/c
>>> ls: cannot access
>>> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manife=
st':
>>> No such
>>> file or directory
>>> total 0
>>> -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.m=
anifest
>>
>> I have seen a bug similar to this some years ago.  It was present as
>> far back as 4.5, and seems to still be present in 5.0.21.  I don't hav=
e
>> detailed tracking information on it due to the low severity: not a cra=
sh
>> or data corruption bug, and workarounds exist both to prevent the bug
>> and to clean up its aftermath.
>>
>> The reproducer is something like:
>>
>> 	while (true) { // pseudocode
>> 		int fd =3D create(tmp_name);
>> 		write(fd, ...);
>> 		fsync(fd);	// required, bug does not appear without this fsync
>> 		close(fd);
>> 		rename(tmp_name, regular_name);
>> 	}
>>
>> and a crash, maybe with some heavy write load.  This is typical of
>> applications like git and ccache, and in the wild, broken directory
>> entries are often found in these applications' directories.
>>
>> Somewhere between 4.5 and 4.12 (a big range, I know), there was a chan=
ge
>> in behavior:  before, the broken directory entry could not be removed,=

>> renamed, or used for a new file, the only way to get rid of the broken=

>> directory entry was to delete the entire subvol.  After the behavior
>> change, the broken directory entry could be removed by creating a new
>> file and renaming it to the broken directory entry name.
>=20
> I found a filesystem that currently has one of these broken dirents:
>=20
> 	root@tester24:/media/testfs/beeshome# ls -l
> 	ls: cannot access 'beesstats.txt.tmp': No such file or directory
> 	total 3446032
> 	-rw-r--r-- 1 root root      10313 Nov 22  2018 all-df-today.png
> 	-rw-r--r-- 1 root root    3297813 Nov 22  2018 all-df-today.txt
> 	-rw------- 1 root root    1048488 Dec  7 17:35 beescrawl.dat
> 	-rwx------ 1 root root 1073741824 Dec  8 20:19 beeshash.dat
> 	-????????? ? ?    ?             ?            ? beesstats.txt.tmp
> 	-rw-r--r-- 1 root root   16064406 Dec  3 00:13 df-2019-11-28.txt
> 	-rw-r--r-- 1 root root    4269887 Dec  5 00:52 df-2019-12-03.txt
> 	-rw-r--r-- 1 root root    6358158 Dec  7 16:44 df-2019-12-05.txt
> 	-rw-r--r-- 1 root root    3221101 Dec  8 20:18 df-2019-12-07.txt
> 	-rw-r--r-- 1 root root 2208475574 Dec  3 00:13 log-2019-11-28.txt
> 	-rw-r--r-- 1 root root   72372394 Dec  5 00:52 log-2019-12-03.txt
> 	-rw-r--r-- 1 root root   97472346 Dec  7 16:44 log-2019-12-05.txt
> 	-rw-r--r-- 1 root root   42378425 Dec  8 20:19 log-2019-12-07.txt
> 	lrwxrwxrwx 1 root root         18 Dec  7 17:35 log-today.txt -> log-20=
19-12-07.txt
>=20
> It seems I can create a file with the same name, and then I get two:
>=20
> 	root@tester24:/media/testfs/beeshome# date > beesstats.txt.tmp
> 	root@tester24:/media/testfs/beeshome# ls -l
> 	total 3446044
> 	-rw-r--r-- 1 root root      10313 Nov 22  2018 all-df-today.png
> 	-rw-r--r-- 1 root root    3297813 Nov 22  2018 all-df-today.txt
> 	-rw------- 1 root root    1048488 Dec  7 17:35 beescrawl.dat
> 	-rwx------ 1 root root 1073741824 Dec  8 20:19 beeshash.dat
> 	-rw-r--r-- 1 root root         29 Dec  8 20:19 beesstats.txt.tmp
> 	-rw-r--r-- 1 root root         29 Dec  8 20:19 beesstats.txt.tmp
> 	-rw-r--r-- 1 root root   16064406 Dec  3 00:13 df-2019-11-28.txt
> 	-rw-r--r-- 1 root root    4269887 Dec  5 00:52 df-2019-12-03.txt
> 	-rw-r--r-- 1 root root    6358158 Dec  7 16:44 df-2019-12-05.txt
> 	-rw-r--r-- 1 root root    3221363 Dec  8 20:19 df-2019-12-07.txt
> 	-rw-r--r-- 1 root root 2208475574 Dec  3 00:13 log-2019-11-28.txt
> 	-rw-r--r-- 1 root root   72372394 Dec  5 00:52 log-2019-12-03.txt
> 	-rw-r--r-- 1 root root   97472346 Dec  7 16:44 log-2019-12-05.txt
> 	-rw-r--r-- 1 root root   42384027 Dec  8 20:19 log-2019-12-07.txt
> 	lrwxrwxrwx 1 root root         18 Dec  7 17:35 log-today.txt -> log-20=
19-12-07.txt
> 	root@tester24:/media/testfs/beeshome# cat beesstats.txt.tmp=20
> 	Sun Dec  8 20:19:38 EST 2019
>=20
> dump-tree sees both DIR_INDEX but only one DIR_ITEM:
>=20
>         item 9 key (256 DIR_ITEM 2721875446) itemoff 15740 itemsize 47
>                 location key (133693 INODE_ITEM 0) type FILE
>                 transid 5002644 data_len 0 name_len 17
>                 name: beesstats.txt.tmp
>         item 18 key (256 DIR_INDEX 22037) itemoff 15332 itemsize 47
>                 location key (11481 INODE_ITEM 0) type FILE
>                 transid 1876891 data_len 0 name_len 17
>                 name: beesstats.txt.tmp
>         item 32 key (256 DIR_INDEX 264858) itemoff 14684 itemsize 47
>                 location key (133693 INODE_ITEM 0) type FILE
>                 transid 5002644 data_len 0 name_len 17
>                 name: beesstats.txt.tmp
>=20
> but I can only delete DIR_ITEMs:
>=20
> 	root@tester24:/media/testfs/beeshome# rm beesstats.txt.tmp=20
> 	root@tester24:/media/testfs/beeshome# rm beesstats.txt.tmp=20
> 	rm: cannot remove 'beesstats.txt.tmp': No such file or directory
> 	root@tester24:/media/testfs/beeshome# ls -l
> 	ls: cannot access 'beesstats.txt.tmp': No such file or directory
> 	total 3446048
> 	-rw-r--r-- 1 root root      10313 Nov 22  2018 all-df-today.png
> 	-rw-r--r-- 1 root root    3297813 Nov 22  2018 all-df-today.txt
> 	-rw------- 1 root root    1048488 Dec  7 17:35 beescrawl.dat
> 	-rwx------ 1 root root 1073741824 Dec  8 20:20 beeshash.dat
> 	-????????? ? ?    ?             ?            ? beesstats.txt.tmp
> 	-rw-r--r-- 1 root root   16064406 Dec  3 00:13 df-2019-11-28.txt
> 	-rw-r--r-- 1 root root    4269887 Dec  5 00:52 df-2019-12-03.txt
> 	-rw-r--r-- 1 root root    6358158 Dec  7 16:44 df-2019-12-05.txt
> 	-rw-r--r-- 1 root root    3221494 Dec  8 20:19 df-2019-12-07.txt
> 	-rw-r--r-- 1 root root 2208475574 Dec  3 00:13 log-2019-11-28.txt
> 	-rw-r--r-- 1 root root   72372394 Dec  5 00:52 log-2019-12-03.txt
> 	-rw-r--r-- 1 root root   97472346 Dec  7 16:44 log-2019-12-05.txt
> 	-rw-r--r-- 1 root root   42396102 Dec  8 20:20 log-2019-12-07.txt
> 	lrwxrwxrwx 1 root root         18 Dec  7 17:35 log-today.txt -> log-20=
19-12-07.txt
>=20
> leaving the first DIR_INDEX behind:
>=20
>         item 17 key (256 DIR_INDEX 22037) itemoff 15379 itemsize 47
>                 location key (11481 INODE_ITEM 0) type FILE
>                 transid 1876891 data_len 0 name_len 17
>                 name: beesstats.txt.tmp

This looks like a older kernel bug (hopes so).

So there is an orphan DIR_INDEX left, but never cleaned up properly.

In that case, btrfs-progs should be able to repair it.
But strangely, why original mode check didn't report it?

BTW, does that 11481 inode still exist?

Thanks,
Qu
>=20
> So the btrfs read side is fine, it's the writing side that is putting b=
ad
> metadata on the disk.
>=20
>> Another workaround is to remove the fsync by running the application
>> under eatmydata.  btrfs performs a flush in the rename() operation whe=
n
>> an existing file is replaced, so the fsync that triggers the bug was
>> not necessary in the first place.  Note this only works when replacing=

>> an existing file, so the flushoncommit mount option is required to mak=
e
>> this work in other cases.
>>
>>> % uname -a
>>> Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
>>> Phenom(tm) II X6 1055T Processor
>>> AuthenticAMD GNU/Linux
>>>
>>> % btrfs --version
>>> btrfs-progs v5.4
>>>
>>> I have tried running btrfs check, and I get differing results based o=
n
>>> the --mode switch:
>>>
>>> # btrfs check --readonly /dev/sda3
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>> [5/7] checking only csums items (without verifying data)
>>> [6/7] checking root refs
>>> [7/7] checking quota groups
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/sda3
>>> UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
>>> found 284337733632 bytes used, no error found
>>> total csum bytes: 267182280
>>> total tree bytes: 4498915328
>>> total fs tree bytes: 3972464640
>>> total extent tree bytes: 199819264
>>> btree space waste bytes: 776711635
>>> file data blocks allocated: 313928671232
>>>  referenced 279141621760
>>>
>>> # btrfs check --readonly --mode=3Dlowmem /dev/sda3
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>> ERROR: root 5 INODE_ITEM[4065004] index 18446744073709551615 name
>>> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 missing
>>> ERROR: root 5 DIR ITEM[486836 13905] name
>>> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 mismath
>>> ERROR: root 5 DIR ITEM[486836 2543451757] mismatch name
>>> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1
>>> ERROR: errors found in fs roots
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/sda3
>>> UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
>>> found 284337733632 bytes used, error(s) found
>>> total csum bytes: 267182280
>>> total tree bytes: 4498915328
>>> total fs tree bytes: 3972464640
>>> total extent tree bytes: 199819264
>>> btree space waste bytes: 776711635
>>> file data blocks allocated: 313928671232
>>>  referenced 279141621760
>>>
>>> Please advise on possible next steps to diagnose and fix this.
>=20
>=20


--0FjhuYwoH8KPMDCd8dBYbaGBFjtooFijQ--

--qI2jSAbMQRMnjUJbPB0684Ab4qXvHPwNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3tqPYACgkQwj2R86El
/qj6oQf8DEtkCgSXY28k7E6zXCzIemH7xH8j2aZetyCFDRj+KvHDj+v7a94hdtoa
40zhG6zkDHVsCyCpUKO07RLxt8L2GtQyoTZ8la+pdDvc1JhLYVdjsEy9ZVr/b3/o
+pEyc9kSmUC8OwOZiGfSDYkmMsS0tNiC0bWVlGWodTkONHHVJVo7b1suasLimkgP
MI5PAKz/m2jSXJerYvOAoloZQL8GQiyAN7cjIyhBbXOFizJRGk+GxrL+J6wYkpPp
BcEmiJcjDys3yf1bV63EXfQWeR5nSdORdUK8nvSRUN2z4hq3rMhqKBIaRUgdbdQC
WySor+NFZEUj48ihOC7QOMrFOL25jA==
=CLQm
-----END PGP SIGNATURE-----

--qI2jSAbMQRMnjUJbPB0684Ab4qXvHPwNE--
