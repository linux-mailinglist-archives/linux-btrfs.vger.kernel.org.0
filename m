Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32037DA435
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Oct 2023 02:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjJ0X7J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 19:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0X7I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 19:59:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFFE1B1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698451143; x=1699055943; i=quwenruo.btrfs@gmx.com;
        bh=Vae0WTroQByWhLytmJMAVBjJIHDo7jssoXq2D8/eFIQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=V5qnr1vxyaKc3fhr06JR4USAJompWnTIvl+rZNs36raBJw3MmYKkIf6Xz0Tj24aF
         laludtl05qMpGFmWm3btDvpSsWdjzg9mjP1SM1ubptGqhNiDpFrsff7Lque8XLdFq
         M4GHdQVJQpdFOUWBkX8NZbkU3S7bkliYlEg1DBxp1B1MrjOKnnX0J18yVc6+vvtNK
         Wz4Ri0zVle4nS6SjC8oaWXQYR5xrxyjkNKP/Paf3o5mA1ocaivALoe51fmAcmefpv
         vvXuiS0pisUw+1ba4Y0OEK/Hn0a45fwqX0JGb7s2F9VLpvMMIWszWcvRs7eHQsMen
         3WbkYvZCkUMjJ1Y87Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1rSIqb1Wjr-00ebg7; Sat, 28
 Oct 2023 01:59:03 +0200
Message-ID: <57b56cb5-ea82-4bf3-ab11-a487ce46ddec@gmx.com>
Date:   Sat, 28 Oct 2023 10:28:58 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help with USB HD needed
Content-Language: en-US
To:     "Werner I." <theweio@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFYMhu0VRKCZOFE3AUKpY6zRftqFTQ6dpsa4sVpYyBhxNHLTYQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAFYMhu0VRKCZOFE3AUKpY6zRftqFTQ6dpsa4sVpYyBhxNHLTYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CWfG/UPxr0saALiKri97ewH5+As4FpLQSano7YEc6qbipelIlm8
 JxJR0FctsXFNb2+io0heFOzDiN2G9DRUhfufl55IMLABJ21rJjVb/lrcQeEiu9yAStj6WY2
 2Xb4EBjIFUxUmpziFzgpYDLURSof1vDgMINP9fXC5vI6Ev5v9m8yfuYaKyQru6bMn5AeR/q
 iD/mLAQmzLXJ3PENT7z6Q==
UI-OutboundReport: notjunk:1;M01:P0:FyYT9BmQ6IE=;2eEFUx7a1YBP55KHGx95cEpe6UD
 WsA8OD2CVK4YDlIx+q/c3jYIRv0jCb2BaSrF1uG+NHqevcydwhyNruKgdpaJnaG+WX9cnCBFu
 ClomkXdT3C15w5WaxrpX/jD1T6OAlakNpINu/Jzr7KQ2m7uVuqmPl60ct2mt6ylX07xiZ0KjG
 0vOZYTIKcAqgPuPqmVn27GrOo066llwUGs3Nk+ZKJu5dbn5neA9nB0RHZLhPDiAVOpglxX6+M
 NskRhL6L3pFJjc73sugHMSOWNnciTdSyParJBLJAyWgq9vUeICCsD5T908X0ktnlQEj5Q4zfP
 qZXGtKaK06O9hoeiUnO5yhJFgrW4rSqqbiVX7k0cB9SjWsn+RkdJlSXpnq+LGDdSyxt0lg0mX
 vtA2ZZ1NGsFrT4k6Y/tFHUEGUazWuR7d4bhlbP7swgyU3SK1gSm96rcXDqdPI7+Ovk5x5YBkY
 9fedfF9UENrxdHE7jmwI/kTtD6Io4OpfkSAQY7WLfVqnZ58pScx8/jeUsC50RV3bf0wAapfRU
 RxsgVJEbTmoS9BuecPxMxe0zr1dy4fLJWzRFem8q+V+tMIGoUQ+vriANIW32XXRNT5iSWi25l
 uBoeBF49aBHrLzrAaRIc6aJKAJQpO/E/B3QqBCEdd5HsoeVQokKPjx6O9NwuCWcok+XQXz2C+
 LV7SAhplxyK8CXA8L09oImrQD8bXCK5Xi/kjSllhv96lNbIwjl3riH/N1W+P1QnmtJ/cVNcU3
 PpInDehwtYsZpbmr5aktbpqIgX9Zw2o1yNzeNh/6/0K9RIbGmZGlHHMQS/QV52iE+MCrYLRXV
 IjlB4AML08bVjagBXCFsXkh9YIwekiq5UZRdqKyYDW+Lrk5yoaRqzusTmRmfS0e9DPlbJqfuM
 n8VxiMNSagYQlHfCJTGbmsZ26EEk2Qwo+QDpR1tI6bpLZvOxFB6ZlxEX1YeMpDhGNB+3iutBD
 0p+0pdzi0iiRMIpGZclVoRjOAOs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/28 01:34, Werner I. wrote:
> Hi,
>
> after a power outage one of my btrfs formatted USB HDs can't be mounted =
anymore.
> A btrfs check gives me:
> btrfs check /dev/sdb
> Opening filesystem to check...
> checksum verify failed on 2896434544640 wanted 0x49cf072e found 0x383771=
7b
> checksum verify failed on 2896434544640 wanted 0x49cf072e found 0x383771=
7b
> Csum didn't match
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>
> I tried mounting it with rescue options to no avail.
> The data on it is not crucial but would be very nice to have back. I
> should have copies on an decommissioned server but that would be a
> pain to set up.
> Help would be very much appreciated. I did NOT use the repair command!
>
> Here is the output of the questionnaire from the wiki:
> Linux omvn100 6.2.16-11-bpo11-pve #1 SMP PREEMPT_DYNAMIC PVE
> 6.2.16-11~bpo11+2 (2023-09-04T14:49Z) x86_64 GNU/Linux
> btrfs-progs v5.16.2
>
> Label: none  uuid: 1397d17c-5789-47a8-958c-c603f7b47365
>          Total devices 1 FS bytes used 13.19TiB
>          devid    1 size 16.37TiB used 13.21TiB path /dev/sda
>
> Label: none  uuid: 6d5c6ae1-86df-4863-9ef4-19d4e5bc05e7
>          Total devices 1 FS bytes used 3.59TiB
>          devid    1 size 4.55TiB used 3.60TiB path /dev/sdc
>
> Label: none  uuid: 359cd817-936a-4451-9dc7-e8ee7910a448
>          Total devices 1 FS bytes used 3.95TiB
>          devid    1 size 4.55TiB used 3.95TiB path /dev/sdb
>
> [    4.729108] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
> devid 1 transid 444227 /dev/sdb scanned by systemd-udevd (306)
> [    4.866283] BTRFS info (device sdb): using crc32c (crc32c-intel)
> checksum algorithm
> [    4.866291] BTRFS info (device sdb): disk space caching is enabled
> [    4.921450] BTRFS warning (device sdb): checksum verify failed on
> logical 2896434544640 mirror 1 wanted 0x49cf072e found 0x3837717b
> level 0
> [    4.921461] BTRFS error (device sdb): failed to read block groups: -5
> [    4.922819] BTRFS error (device sdb): open_ctree failed
> [    5.307709] BTRFS: device fsid 6d5c6ae1-86df-4863-9ef4-19d4e5bc05e7
> devid 1 transid 7866 /dev/sdc scanned by systemd-udevd (307)
> [    5.391947] BTRFS info (device sdc): using crc32c (crc32c-intel)
> checksum algorithm
> [    5.391954] BTRFS info (device sdc): using free space tree
> [    7.983815] r8169 0000:01:00.0 enp1s0: Link is Up - 1Gbps/Full -
> flow control rx/tx
> [    7.983825] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
> [    8.432017] audit: type=3D1326 audit(1698404351.369:2):
> auid=3D4294967295 uid=3D65534 gid=3D65534 ses=3D4294967295 subj=3Dunconf=
ined
> pid=3D777 comm=3D"node" exe=3D"/usr/local/bin/node" sig=3D0 arch=3Dc0000=
03e
> syscall=3D324 compat=3D0 ip=3D0x7fa3b2807152 code=3D0x50000
> [    8.805952] audit: type=3D1326 audit(1698404351.741:3):
> auid=3D4294967295 uid=3D65534 gid=3D65534 ses=3D4294967295 subj=3Dunconf=
ined
> pid=3D840 comm=3D"node" exe=3D"/usr/local/bin/node" sig=3D0 arch=3Dc0000=
03e
> syscall=3D324 compat=3D0 ip=3D0x7f9d7d23f152 code=3D0x50000
> [   26.539848] audit: type=3D1326 audit(1698404369.477:4):
> auid=3D4294967295 uid=3D65534 gid=3D65534 ses=3D4294967295 subj=3Dunconf=
ined
> pid=3D873 comm=3D"node" exe=3D"/usr/local/bin/node" sig=3D0 arch=3Dc0000=
03e
> syscall=3D324 compat=3D0 ip=3D0x7fcfd93d5152 code=3D0x50000
> [   54.280616] BTRFS info (device sdc): auto enabling async discard
> [   54.581643] Initializing XFRM netlink socket
> [   54.963182] br-ad8d222d3210: port 1(vethd61e22d) entered blocking sta=
te
> [   54.963187] br-ad8d222d3210: port 1(vethd61e22d) entered disabled sta=
te
> [   54.963270] device vethd61e22d entered promiscuous mode
> [   54.963609] br-ad8d222d3210: port 1(vethd61e22d) entered blocking sta=
te
> [   54.963613] br-ad8d222d3210: port 1(vethd61e22d) entered forwarding s=
tate
> [   54.963951] IPv6: ADDRCONF(NETDEV_CHANGE): br-ad8d222d3210: link
> becomes ready
> [   54.964030] br-ad8d222d3210: port 1(vethd61e22d) entered disabled sta=
te
> [   56.496029] eth0: renamed from veth003002b
> [   56.527852] IPv6: ADDRCONF(NETDEV_CHANGE): vethd61e22d: link becomes =
ready
> [   56.527880] br-ad8d222d3210: port 1(vethd61e22d) entered blocking sta=
te
> [   56.527883] br-ad8d222d3210: port 1(vethd61e22d) entered forwarding s=
tate
> [   94.658751] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
> devid 1 transid 444227 /dev/sdb scanned by mount (5159)
> [   94.660625] BTRFS info (device sdb): using crc32c (crc32c-intel)
> checksum algorithm
> [   94.660632] BTRFS info (device sdb): disk space caching is enabled
> [   94.715833] BTRFS warning (device sdb): checksum verify failed on
> logical 2896434544640 mirror 1 wanted 0x49cf072e found 0x3837717b
> level 0
> [   94.715843] BTRFS error (device sdb): failed to read block groups: -5
> [   94.717287] BTRFS error (device sdb): open_ctree failed
> [  500.689477] audit: type=3D1326 audit(1698404843.392:5):
> auid=3D4294967295 uid=3D65534 gid=3D65534 ses=3D4294967295 subj=3Dunconf=
ined
> pid=3D14849 comm=3D"node" exe=3D"/usr/local/bin/node" sig=3D0 arch=3Dc00=
0003e
> syscall=3D324 compat=3D0 ip=3D0x7ff8e0fc0152 code=3D0x50000
> [  914.697510] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
> devid 1 transid 444227 /dev/sdb scanned by mount (15368)
> [  914.699197] BTRFS info (device sdb): using crc32c (crc32c-intel)
> checksum algorithm
> [  914.699205] BTRFS warning (device sdb): 'recovery' is deprecated,
> use 'rescue=3Dusebackuproot' instead
> [  914.699207] BTRFS info (device sdb): trying to use backup root at mou=
nt time
> [  914.699208] BTRFS info (device sdb): disk space caching is enabled
> [  914.754095] BTRFS warning (device sdb): checksum verify failed on
> logical 2896434544640 mirror 1 wanted 0x49cf072e found 0x3837717b
> level 0
> [  914.754106] BTRFS error (device sdb): failed to read block groups: -5
> [  914.755479] BTRFS error (device sdb): open_ctree failed
> [ 1339.551770] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
> devid 1 transid 444227 /dev/sdb scanned by mount (15754)
> [ 1339.553887] BTRFS info (device sdb): using crc32c (crc32c-intel)
> checksum algorithm
> [ 1339.553895] BTRFS warning (device sdb): 'recovery' is deprecated,
> use 'rescue=3Dusebackuproot' instead
> [ 1339.553897] BTRFS info (device sdb): trying to use backup root at mou=
nt time
> [ 1339.553898] BTRFS info (device sdb): disk space caching is enabled
> [ 1339.608755] BTRFS warning (device sdb): checksum verify failed on
> logical 2896434544640 mirror 1 wanted 0x49cf072e found 0x3837717b
> level 0
> [ 1339.608765] BTRFS error (device sdb): failed to read block groups: -5
> [ 1339.610229] BTRFS error (device sdb): open_ctree failed
> [ 2650.074709] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
> devid 1 transid 444227 /dev/sdb scanned by mount (16646)
> [ 2650.076404] BTRFS info (device sdb): using crc32c (crc32c-intel)
> checksum algorithm
> [ 2650.076413] BTRFS info (device sdb): enabling all of the rescue optio=
ns
> [ 2650.076414] BTRFS info (device sdb): ignoring data csums
> [ 2650.076414] BTRFS info (device sdb): ignoring bad roots
> [ 2650.076415] BTRFS info (device sdb): disabling log replay at mount ti=
me
> [ 2650.076416] BTRFS error (device sdb): nologreplay must be used with
> ro mount option

This shows exactly what you need to do, mount it with "-o ro,rescue=3Dall"=
.

The corruption is only at the extent tree (if that's the only
corruption), then above read-only rescue mount should work fine.

Thanks,
Qu

> [ 2650.076497] BTRFS error (device sdb): open_ctree failed
>
> If it's needed I can send a dull dmesg log later.
>
> Thank you,
> Werner
