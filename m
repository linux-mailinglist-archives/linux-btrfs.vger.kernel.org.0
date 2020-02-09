Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3CA156847
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 02:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgBIBJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 20:09:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:52979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgBIBJN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Feb 2020 20:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581210546;
        bh=LkDaas3nI/T0uFWuuQ/ZP/xr7Ulgr7IZfjYS6EJq7Sk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RB9sOgGnlm9EOmvLYWsMMVq/3K3mFYVvOGRcEtAjIgNoTOALJmenavprqzS/jLNLc
         3/VQ6xm6OKSU5ZZhRh7xPYwCTasJrvPpEzKhONoEkz/3PvUDGNhguAaz36Pri8ERQ8
         xazYq4ukXERMujOKIei4thgWgvLZblm2S91mywdw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1jihHt3FeC-00zqok; Sun, 09
 Feb 2020 02:09:06 +0100
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com>
 <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
 <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com>
 <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
 <CA+M2ft9dcMKKQstZVcGQ=9MREbfhPF5GG=xoMoh5Aq8MK9P8wA@mail.gmail.com>
 <75f86be2-80fe-26c1-235f-1c6d3a618eeb@gmx.com>
 <CA+M2ft9PjH29SY+nBqfFEapr9g7BjjMFeE_p2P0oL1q8xHGUBw@mail.gmail.com>
 <CA+M2ft9AnivVhPapsn_=bEoU5Ujw9PFo9Lbcjr5nzStdq84awg@mail.gmail.com>
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
Message-ID: <711cfe11-be8e-566d-5fbe-55a9434fb5f5@gmx.com>
Date:   Sun, 9 Feb 2020 09:09:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CA+M2ft9AnivVhPapsn_=bEoU5Ujw9PFo9Lbcjr5nzStdq84awg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zRuUkfiWPqLGENoUqfwwfWxhYFwgNOS6D"
X-Provags-ID: V03:K1:BB4UKtBeKYKA+r9CyI9Oz26uuFdvhfe8Ia9/1DRaDxytblZ3fYk
 0r2EcQDKAk4Dh0WaGMYfZJt42RIoTfmsXH9fhNLvkBvD2tba9Y9z6LN934psPzQuDS3ILcR
 QLn4oCnlVW02ARAIxMwMBVADgnyebzLSVwx3+NM1mmJcTQFWuqH9RVJSHrC7jkBl+FsVP4V
 gLhhoiXhbFEgYRbln8CEQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lNe3ZNDpAak=:AhlvALgMmWAqNgp9C2tBry
 uAQeh66+uj+32Dr3JnJXGqMJUqqgtUh1SLFSvroyxVeVwj+ZuIBa7JzJvKY8sZaSmEPfHlzN+
 KUXqKq/AGsGRl45kSG5g3h3rk1a79hbZHz8y+gVKj8A/mi5EVSCUGu7vtObECKxhAEcr/zVYD
 RgJZGaV55r3IgcGJMJAl5nPE9EClEazfBEJinl3HE0US7K32InO7RsGdkSpx73x9z6C1OHvbZ
 W9om1XtOy8OZYyFOxXuwDyDx5x30CtEiXLrT3aTaUso1DyNnDXnheQPzWN2VaGsiipBYv5u53
 NP/Ka9EyZ3Jx1BC8he4kleb1ZpYHjvR9iwskdc4ecyWqLztP9iMiJtJMfod93RcCPa3U8R6BX
 a6BTdnCcZrAV7bBWAf6bM4pTteaq58l5O7mLbvUOt0ts+PcAv9h+3k1zNIgbq26dQKhvzbeR0
 7nBKkGP6gYJgy9/23qkfDF+6JRpocrhjxdI2XDd1w4MtZHPaRE5S3J03QFAMb5yvt53MSPUsw
 Aq0dG1vKv0XSZocwOgFn4M70RyGEkbEomPu1l52JeLAhoiVoAi8GQLkf+LR3kiBeJLBaCk7AU
 J2rJi413iFnJVpuz+9wS9ySWa5TFM6dA72vm3i5q3AUx7Z0zV9c1PhDDziFpuLrt9V8JouGcA
 uVsDPhWwXZNyIz1XwOd1d1fCXYVUVYrMyh22z3lAo9Qkgxf0BQgKqvhzUlW5hbRGzobiRPOJ9
 qAms47y/SUbhEEmWTe98taKJ4rNPkG3YiCvYKa0CuTxiMNz3du+3+3qw4+4I32ZmV3q6HGliV
 Av6ASDBDcOyhuQoNTmN9e4K9N1zSgXA4tRZYnhETfRMlq1M8V+an345LH/2qZn5qi20Lmhea0
 9GtdQ3uOM5oT5l3mdFgI5bWcVey/fWZWJEBPM4W4tuwC3YeXZwDOiMmQVLqvgpTzT61ipr/8X
 OmDulM1d3Vf1NHHwDKtouRzQrIEDxUm5LYXbgvfMxvguSSp7lMpJGk38kQdkad5a1+JB0uxlg
 9aFjxmqbE3hF2N1Y5HRfjMi8tkIcl703DgRs5u2w9ydi+axW2giuPKKyjVI6xaUsxqrqH4mTU
 mPbcLSrsQi7Jt19BOBn602oHsR5mcR7VGtOtTCV/zQwgIW+8IvwxiAbwoDQjnrNmneeHn5lf1
 thWn+Louf/ycCf32JmSSYNTEI+E85/2Ivp1xzMVbjekbULXBB86DMVD0WZK+nFQx4KDsNh31d
 19E/EMxt4L0qGZ1AkBwYDmIppPehFdnZBuku2Bio63KZk8SAaJ6nEGznWdM8wanPtveZGj7DA
 ynqUXuwFhPcV0NSULctcokuF0GHnG5Fr+LEqi1wxgKAn83kkFLb3VBghpxaptSf4JqbtIDAQ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zRuUkfiWPqLGENoUqfwwfWxhYFwgNOS6D
Content-Type: multipart/mixed; boundary="5TSba8Ke0OVvHPZV8CF9UbQs19Ez0oqSC"

--5TSba8Ke0OVvHPZV8CF9UbQs19Ez0oqSC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/9 =E4=B8=8A=E5=8D=888:59, John Hendy wrote:
> Also, if it's of interest, the zero-log trick was new to me. For my
> original m2.sata nvme drive, I'd already run all of --init-csum-tree,
> --init-extent-tree, and --repair (unsure on the order of the first
> two, but --repair was definitely last) but could then not mount it. I
> just ran `btrfs rescue zero-log` on it and here is the very brief
> output from a btrfs check:
>=20
> $ sudo btrfs check /dev/mapper/nvme
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/nvme
> UUID: 488f733d-1dfd-4a0f-ab2f-ba690e095fe4
> [1/7] checking root items
> [2/7] checking extents
> data backref 40762777600 root 256 owner 525787 offset 0 num_refs 0 not
> found in extent tree
> incorrect local backref count on 40762777600 root 256 owner 525787
> offset 0 found 1 wanted 0 back 0x5635831f9a20
> incorrect local backref count on 40762777600 root 4352 owner 525787
> offset 0 found 0 wanted 1 back 0x56357e5a3c70
> backref disk bytenr does not match extent record, bytenr=3D40762777600,=

> ref bytenr=3D0
> backpointer mismatch on [40762777600 4096]

At this stage, btrfs check --repair should be able to fix it.

Or does it still segfault?

Thanks,
Qu
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 87799443456 bytes used, error(s) found
> total csum bytes: 84696784
> total tree bytes: 954220544
> total fs tree bytes: 806535168
> total extent tree bytes: 47710208
> btree space waste bytes: 150766636
> file data blocks allocated: 87780622336
>  referenced 94255783936
>=20
> If that looks promising... I'm hoping that the ssd we're currently
> working on will follow suit! I'll await your recommendation for what
> to do on the previous inquiries for the SSD, and if you have any
> suggestions for the backref errors on the nvme drive above.
>=20
> Many thanks,
> John
>=20
> On Sat, Feb 8, 2020 at 6:51 PM John Hendy <jw.hendy@gmail.com> wrote:
>>
>> On Sat, Feb 8, 2020 at 5:56 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>
>>>
>>>
>>> On 2020/2/9 =E4=B8=8A=E5=8D=885:57, John Hendy wrote:
>>>> On phone due to no OS, so apologies if this is in html mode. Indeed,=
 I
>>>> can't mount or boot any longer. I get the error:
>>>>
>>>> Error (device dm-0) in btrfs_replay_log:2228: errno=3D-22 unknown (F=
ailed
>>>> to recover log tree)
>>>> BTRFS error (device dm-0): open_ctree failed
>>>
>>> That can be easily fixed by `btrfs rescue zero-log`.
>>>
>>
>> Whew. This was most helpful and it is wonderful to be booting at
>> least. I think the outstanding issues are:
>> - what should I do about `btrfs check --repair seg` faulting?
>> - how can I deal with this (probably related to seg fault) ghost file
>> that cannot be deleted?
>> - I'm not sure if you looked at the post --repair log, but there a ton=

>> of these errors that didn't used to be there:
>>
>> backpointer mismatch on [13037375488 20480]
>> ref mismatch on [13037395968 892928] extent item 0, found 1
>> data backref 13037395968 root 263 owner 4257169 offset 0 num_refs 0
>> not found in extent tree
>> incorrect local backref count on 13037395968 root 263 owner 4257169
>> offset 0 found 1 wanted 0 back 0x5627f59cadc0
>>
>> Here is the latest btrfs check output after the zero-log operation.
>> - https://pastebin.com/KWeUnk0y
>>
>> I'm hoping once that file is deleted, it's a matter of
>> --init-csum-tree and perhaps I'm set? Or --init-extent-tree?
>>
>> Thanks,
>> John
>>
>>> At least, btrfs check --repair didn't make things worse.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> John
>>>>
>>>> On Sat, Feb 8, 2020, 1:56 PM John Hendy <jw.hendy@gmail.com
>>>> <mailto:jw.hendy@gmail.com>> wrote:
>>>>
>>>>     This is not going so hot. Updates:
>>>>
>>>>     booted from arch install, pre repair btrfs check:
>>>>     - https://pastebin.com/6vNaSdf2
>>>>
>>>>     btrfs check --mode=3Dlowmem as requested by Chris:
>>>>     - https://pastebin.com/uSwSTVVY
>>>>
>>>>     Then I did btrfs check --repair, which seg faulted at the end. I=
've
>>>>     typed them off of pictures I took:
>>>>
>>>>     Starting repair.
>>>>     Opening filesystem to check...
>>>>     Checking filesystem on /dev/mapper/ssd
>>>>     [1/7] checking root items
>>>>     Fixed 0 roots.
>>>>     [2/7] checking extents
>>>>     parent transid verify failed on 20271138064 wanted 68719924810 f=
ound
>>>>     448074
>>>>     parent transid verify failed on 20271138064 wanted 68719924810 f=
ound
>>>>     448074
>>>>     Ignoring transid failure
>>>>     # ... repeated the previous two lines maybe hundreds of times
>>>>     # ended with this:
>>>>     ref mismatch on [12797435904 268505088] extent item 1, found 412=

>>>>     [1] 1814 segmentation fault (core dumped) btrfs check --repair
>>>>     /dev/mapper/ssd
>>>>
>>>>     This was with btrfs-progs 5.4 (the install USB is maybe a month =
old).
>>>>
>>>>     Here is the output of btrfs check after the --repair attempt:
>>>>     - https://pastebin.com/6MYRNdga
>>>>
>>>>     I rebooted to write this email given the seg fault, as I wanted =
to
>>>>     make sure that I should still follow-up --repair with
>>>>     --init-csum-tree. I had pictures of the --repair output, but Fir=
efox
>>>>     just wouldn't load imgur.com <http://imgur.com> for me to post t=
he
>>>>     pics and was acting
>>>>     really weird. In suspiciously checking dmesg, things have gone r=
o on
>>>>     me :(  Here is the dmesg from this session:
>>>>     - https://pastebin.com/a2z7xczy
>>>>
>>>>     The gist is:
>>>>
>>>>     [   40.997935] BTRFS critical (device dm-0): corrupt leaf: root=3D=
7
>>>>     block=3D172703744 slot=3D0, csum end range (12980568064) goes be=
yond the
>>>>     start range (12980297728) of the next csum item
>>>>     [   40.997941] BTRFS info (device dm-0): leaf 172703744 gen 4509=
83
>>>>     total ptrs 34 free space 29 owner 7
>>>>     [   40.997942]     item 0 key (18446744073709551606 128 12979060=
736)
>>>>     itemoff 14811 itemsize 1472
>>>>     [   40.997944]     item 1 key (18446744073709551606 128 12980297=
728)
>>>>     itemoff 13895 itemsize 916
>>>>     [   40.997945]     item 2 key (18446744073709551606 128 12981235=
712)
>>>>     itemoff 13811 itemsize 84
>>>>     # ... there's maybe 30 of these item n key lines in total
>>>>     [   40.997984] BTRFS error (device dm-0): block=3D172703744 writ=
e time
>>>>     tree block corruption detected
>>>>     [   41.016793] BTRFS: error (device dm-0) in
>>>>     btrfs_commit_transaction:2332: errno=3D-5 IO failure (Error whil=
e
>>>>     writing out transaction)
>>>>     [   41.016799] BTRFS info (device dm-0): forced readonly
>>>>     [   41.016802] BTRFS warning (device dm-0): Skipping commit of a=
borted
>>>>     transaction.
>>>>     [   41.016804] BTRFS: error (device dm-0) in cleanup_transaction=
:1890:
>>>>     errno=3D-5 IO failure
>>>>     [   41.016807] BTRFS info (device dm-0): delayed_refs has NO ent=
ry
>>>>     [   41.023473] BTRFS warning (device dm-0): Skipping commit of a=
borted
>>>>     transaction.
>>>>     [   41.024297] BTRFS info (device dm-0): delayed_refs has NO ent=
ry
>>>>     [   44.509418] systemd-journald[416]:
>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journal=
:
>>>>     Journal file corrupted, rotating.
>>>>     [   44.509440] systemd-journald[416]: Failed to rotate
>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journal=
:
>>>>     Read-only file system
>>>>     [   44.509450] systemd-journald[416]: Failed to rotate
>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/user-1000.jour=
nal:
>>>>     Read-only file system
>>>>     [   44.509540] systemd-journald[416]: Failed to write entry (23 =
items,
>>>>     705 bytes) despite vacuuming, ignoring: Bad message
>>>>     # ... then a bunch of these failed journal attempts (of note:
>>>>     /var/log/journal was one of the bad inodes from btrfs check
>>>>     previously)
>>>>
>>>>     Kindly let me know what you would recommend. I'm sadly back to a=
n
>>>>     unusable system vs. a complaining/worrisome one. This is similar=
 to
>>>>     the behavior I had with the m2.sata nvme drive in my original
>>>>     experience. After trying all of --repair, --init-csum-tree, and
>>>>     --init-extent-tree, I couldn't boot anymore. After my dm-crypt
>>>>     password at boot, I just saw a bunch of [FAILED] in the text spl=
ash
>>>>     output. Hoping to not repeat that with this drive.
>>>>
>>>>     Thanks,
>>>>     John
>>>>
>>>>
>>>>     On Sat, Feb 8, 2020 at 1:29 AM Qu Wenruo <quwenruo.btrfs@gmx.com=

>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>     >
>>>>     >
>>>>     >
>>>>     > On 2020/2/8 =E4=B8=8B=E5=8D=8812:48, John Hendy wrote:
>>>>     > > On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom
>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>     > >>
>>>>     > >>
>>>>     > >>
>>>>     > >> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
>>>>     > >>> Greetings,
>>>>     > >>>
>>>>     > >>> I'm resending, as this isn't showing in the archives. Perh=
aps
>>>>     it was
>>>>     > >>> the attachments, which I've converted to pastebin links.
>>>>     > >>>
>>>>     > >>> As an update, I'm now running off of a different drive (ss=
d,
>>>>     not the
>>>>     > >>> nvme) and I got the error again! I'm now inclined to think=

>>>>     this might
>>>>     > >>> not be hardware after all, but something related to my set=
up
>>>>     or a bug
>>>>     > >>> with chromium.
>>>>     > >>>
>>>>     > >>> After a reboot, chromium wouldn't start for me and demsg s=
howed
>>>>     > >>> similar parent transid/csum errors to my original post bel=
ow.
>>>>     I used
>>>>     > >>> btrfs-inspect-internal to find the inode traced to
>>>>     > >>> ~/.config/chromium/History. I deleted that, and got a new =
set of
>>>>     > >>> errors tracing to ~/.config/chromium/Cookies. After I dele=
ted
>>>>     that and
>>>>     > >>> tried starting chromium, I found that my btrfs /home/jwhen=
dy
>>>>     pool was
>>>>     > >>> mounted ro just like the original problem below.
>>>>     > >>>
>>>>     > >>> dmesg after trying to start chromium:
>>>>     > >>> - https://pastebin.com/CsCEQMJa
>>>>     > >>
>>>>     > >> So far, it's only transid bug in your csum tree.
>>>>     > >>
>>>>     > >> And two backref mismatch in data backref.
>>>>     > >>
>>>>     > >> In theory, you can fix your problem by `btrfs check --repai=
r
>>>>     > >> --init-csum-tree`.
>>>>     > >>
>>>>     > >
>>>>     > > Now that I might be narrowing in on offending files, I'll wa=
it
>>>>     to see
>>>>     > > what you think from my last response to Chris. I did try the=
 above
>>>>     > > when I first ran into this:
>>>>     > > -
>>>>     https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQazhy=
B95aha_D4WU_n15M59QrimrRg@mail.gmail.com/
>>>>     >
>>>>     > That RO is caused by the missing data backref.
>>>>     >
>>>>     > Which can be fixed by btrfs check --repair.
>>>>     >
>>>>     > Then you should be able to delete offending files them. (Or th=
e whole
>>>>     > chromium cache, and switch to firefox if you wish :P )
>>>>     >
>>>>     > But also please keep in mind that, the transid mismatch looks
>>>>     happen in
>>>>     > your csum tree, which means your csum tree is no longer reliab=
le, and
>>>>     > may cause -EIO reading unrelated files.
>>>>     >
>>>>     > Thus it's recommended to re-fill the csum tree by --init-csum-=
tree.
>>>>     >
>>>>     > It can be done altogether by --repair --init-csum-tree, but to=
 be
>>>>     safe,
>>>>     > please run --repair only first, then make sure btrfs check rep=
orts no
>>>>     > error after that. Then go --init-csum-tree.
>>>>     >
>>>>     > >
>>>>     > >> But I'm more interesting in how this happened.
>>>>     > >
>>>>     > > Me too :)
>>>>     > >
>>>>     > >> Have your every experienced any power loss for your NVME dr=
ive?
>>>>     > >> I'm not say btrfs is unsafe against power loss, all fs shou=
ld
>>>>     be safe
>>>>     > >> against power loss, I'm just curious about if mount time lo=
g
>>>>     replay is
>>>>     > >> involved, or just regular internal log replay.
>>>>     > >>
>>>>     > >> From your smartctl, the drive experienced 61 unsafe shutdow=
n
>>>>     with 2144
>>>>     > >> power cycles.
>>>>     > >
>>>>     > > Uhhh, hell yes, sadly. I'm a dummy running i3 and every time=
 I get
>>>>     > > caught off gaurd by low battery and instant power-off, I kic=
k myself
>>>>     > > and mean to set up a script to force poweroff before that
>>>>     happens. So,
>>>>     > > indeed, I've lost power a ton. Surprised it was 61 times, bu=
t maybe
>>>>     > > not over ~2 years. And actually, I mis-stated the age. I hav=
en't
>>>>     > > *booted* from this drive in almost 2yrs. It's a corporate la=
ptop,
>>>>     > > issued every 3, so the ssd drive is more like 5 years old.
>>>>     > >
>>>>     > >> Not sure if it's related.
>>>>     > >>
>>>>     > >> Another interesting point is, did you remember what's the
>>>>     oldest kernel
>>>>     > >> running on this fs? v5.4 or v5.5?
>>>>     > >
>>>>     > > Hard to say, but arch linux maintains a package archive. The=
 nvme
>>>>     > > drive is from ~May 2018. The archives only go back to Jan 20=
19
>>>>     and the
>>>>     > > kernel/btrfs-progs was at 4.20 then:
>>>>     > > - https://archive.archlinux.org/packages/l/linux/
>>>>     >
>>>>     > There is a known bug in v5.2.0~v5.2.14 (fixed in v5.2.15), whi=
ch could
>>>>     > cause metadata corruption. And the symptom is transid error, w=
hich
>>>>     also
>>>>     > matches your problem.
>>>>     >
>>>>     > Thanks,
>>>>     > Qu
>>>>     >
>>>>     > >
>>>>     > > Searching my Amazon orders, the SSD was in the 2015 time fra=
me,
>>>>     so the
>>>>     > > kernel version would have been even older.
>>>>     > >
>>>>     > > Thanks for your input,
>>>>     > > John
>>>>     > >
>>>>     > >>
>>>>     > >> Thanks,
>>>>     > >> Qu
>>>>     > >>>
>>>>     > >>> Thanks for any pointers, as it would now seem that my purc=
hase
>>>>     of a
>>>>     > >>> new m2.sata may not buy my way out of this problem! While =
I didn't
>>>>     > >>> want to reinstall, at least new hardware is a simple fix. =
Now I'm
>>>>     > >>> worried there is a deeper issue bound to recur :(
>>>>     > >>>
>>>>     > >>> Best regards,
>>>>     > >>> John
>>>>     > >>>
>>>>     > >>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail=
=2Ecom
>>>>     <mailto:jw.hendy@gmail.com>> wrote:
>>>>     > >>>>
>>>>     > >>>> Greetings,
>>>>     > >>>>
>>>>     > >>>> I've had this issue occur twice, once ~1mo ago and once a=

>>>>     couple of
>>>>     > >>>> weeks ago. Chromium suddenly quit on me, and when trying =
to
>>>>     start it
>>>>     > >>>> again, it complained about a lock file in ~. I tried to d=
elete it
>>>>     > >>>> manually and was informed I was on a read-only fs! I ende=
d up
>>>>     biting
>>>>     > >>>> the bullet and re-installing linux due to the number of d=
ead end
>>>>     > >>>> threads and slow response rates on diagnosing these issue=
s,
>>>>     and the
>>>>     > >>>> issue occurred again shortly after.
>>>>     > >>>>
>>>>     > >>>> $ uname -a
>>>>     > >>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 202=
0
>>>>     16:38:40
>>>>     > >>>> +0000 x86_64 GNU/Linux
>>>>     > >>>>
>>>>     > >>>> $ btrfs --version
>>>>     > >>>> btrfs-progs v5.4
>>>>     > >>>>
>>>>     > >>>> $ btrfs fi df /mnt/misc/ # full device; normally would be=

>>>>     mounting a subvol on /
>>>>     > >>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
>>>>     > >>>> System, single: total=3D32.00MiB, used=3D16.00KiB
>>>>     > >>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
>>>>     > >>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>>>>     > >>>>
>>>>     > >>>> This is a single device, no RAID, not on a VM. HP Zbook 1=
5.
>>>>     > >>>> nvme0n1                                       259:5    0
>>>>     232.9G  0 disk
>>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p1                              =
     259:6    0
>>>>      512M  0
>>>>     > >>>> part  (/boot/efi)
>>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p2                              =
     259:7    0
>>>>      1G  0 part  (/boot)
>>>>     > >>>> =E2=94=94=E2=94=80nvme0n1p3                              =
     259:8    0
>>>>     231.4G  0 part (btrfs)
>>>>     > >>>>
>>>>     > >>>> I have the following subvols:
>>>>     > >>>> arch: used for / when booting arch
>>>>     > >>>> jwhendy: used for /home/jwhendy on arch
>>>>     > >>>> vault: shared data between distros on /mnt/vault
>>>>     > >>>> bionic: root when booting ubuntu bionic
>>>>     > >>>>
>>>>     > >>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>>>>     > >>>>
>>>>     > >>>> dmesg, smartctl, btrfs check, and btrfs dev stats attache=
d.
>>>>     > >>>
>>>>     > >>> Edit: links now:
>>>>     > >>> - btrfs check: https://pastebin.com/nz6Bc145
>>>>     > >>> - dmesg: https://pastebin.com/1GGpNiqk
>>>>     > >>> - smartctl: https://pastebin.com/ADtYqfrd
>>>>     > >>>
>>>>     > >>> btrfs dev stats (not worth a link):
>>>>     > >>>
>>>>     > >>> [/dev/mapper/old].write_io_errs    0
>>>>     > >>> [/dev/mapper/old].read_io_errs     0
>>>>     > >>> [/dev/mapper/old].flush_io_errs    0
>>>>     > >>> [/dev/mapper/old].corruption_errs  0
>>>>     > >>> [/dev/mapper/old].generation_errs  0
>>>>     > >>>
>>>>     > >>>
>>>>     > >>>> If these are of interested, here are reddit threads where=
 I
>>>>     posted the
>>>>     > >>>> issue and was referred here.
>>>>     > >>>> 1)
>>>>     https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recov=
ering_from_various_errors_root/
>>>>     > >>>> 2)
>>>>     https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs=
_root_started_remounting_as_ro/
>>>>     > >>>>
>>>>     > >>>> It has been suggested this is a hardware issue. I've alre=
ady
>>>>     ordered a
>>>>     > >>>> replacement m2.sata, but for sanity it would be great to =
know
>>>>     > >>>> definitively this was the case. If anything stands out ab=
ove that
>>>>     > >>>> could indicate I'm not setup properly re. btrfs, that wou=
ld
>>>>     also be
>>>>     > >>>> fantastic so I don't repeat the issue!
>>>>     > >>>>
>>>>     > >>>> The only thing I've stumbled on is that I have been mount=
ing with
>>>>     > >>>> rd.luks.options=3Ddiscard and that manually running fstri=
m is
>>>>     preferred.
>>>>     > >>>>
>>>>     > >>>>
>>>>     > >>>> Many thanks for any input/suggestions,
>>>>     > >>>> John
>>>>     > >>
>>>>     >
>>>>
>>>


--5TSba8Ke0OVvHPZV8CF9UbQs19Ez0oqSC--

--zRuUkfiWPqLGENoUqfwwfWxhYFwgNOS6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4/W68ACgkQwj2R86El
/qhclggAinCWM1wRM416nEf5Oz1PNuc/lmeBWUXFxWj6EfJ6omFVhWIMGY5DvcyO
WUJG8vdVJVnQ0PJGCyN4TXJxtyLcQ4OuahZAAG+04UYZJOE0GzbpAzFzGMRQQvbA
mNHVXposb3OQMF4p04va77gl0uTdJs4KQh8bejB72zZuzSUgi2Z/FCaLjWSI6t4N
9wiAy+mjmlVhOxooFutrJ6hRIM9MvYOPaBnP8eOjxB3lWfrpqQjrv5S0mL59FGM1
G9Wsc0MxaPeJPO8/exvB1y/4VZJjbysZAxpQMF6EbO7fjKiQBQJqRBnPYh90Qq0M
nRFfkppXXhFoJPmIheDp7P9h6hAdWA==
=waj+
-----END PGP SIGNATURE-----

--zRuUkfiWPqLGENoUqfwwfWxhYFwgNOS6D--
