Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6187E180D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 00:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjKEXpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Nov 2023 18:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKEXpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Nov 2023 18:45:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0BD8
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Nov 2023 15:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1699227932; x=1699832732; i=quwenruo.btrfs@gmx.com;
        bh=3rBSVTPzhpLyAjBlo0URkpH+hy0nagnPBOO3tleY7W4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ULR5CrU4wwETo6K2KcqGJIEtSKdqpjcLYg05sQ5P1J5uwWaK4mXUDDt8ACKvDJWK
         G9ErvO6ivb7vMecAYL/nFmoqvkdlPUdAW4DMC8gLFbuRvlaF89uz9z+yhyBfUPfYw
         MRb+C5pEXC6Gm/nB48OFTJUnG8FgsO7MoNxsZHWVRHYzHgOslRRC46t51iIao930l
         0jAjIxWa5AbpYOIK9DKSWXNc68454XumNZ6ES4wOSkM4CTwOy2mzC2gT2E928CKMS
         G6uUfOzBfryZnseUZ6j5AQFkGgB5J6fXyNeNWYWwmJLXlNKtjsAOeZ9sHuKI/ZF3R
         oO4ccFJqVZVt840J1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqs4f-1rmZtS3WDZ-00mpqq; Mon, 06
 Nov 2023 00:45:32 +0100
Message-ID: <bbda4275-a07e-4921-a9c0-5a3d34801ef5@gmx.com>
Date:   Mon, 6 Nov 2023 10:15:28 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can btrfs repair this ?
Content-Language: en-US
To:     Joe Salmeri <jmscdba@gmail.com>,
        BTRFS Mailing-List <linux-btrfs@vger.kernel.org>
References: <9de00454-0cd9-4d2d-aed4-23490f7dde83@gmail.com>
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
In-Reply-To: <9de00454-0cd9-4d2d-aed4-23490f7dde83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qsMkWPmU1Htgtk7XA5aOc+VDnfzpabFuEMldhTFJ3FlhRKp1Cqw
 XRsfsXY0voFrvCpO2xQvNSXP0KEoFvro+8aBPDfAEygdbxtGRsL7NxDRTuESq1FKY9DaIMa
 IskL+B8sZDNv11ogMRwBa1zag54n79Zg+3DOQ6nTPRJqaaaNc6/T4Sr3I5CEa8iarrkSMoq
 sxBc9I1KXJuEbb9KAlYIw==
UI-OutboundReport: notjunk:1;M01:P0:FkHrTtEccZo=;cSQpsS5EbQR6SJhpNLm0vh35Y33
 WEzqX3ai9C2d5NecIpZT/1gImSCAKjy1t2mT7RQAIq8G3svqSVeCmFKJtICQwmGDzg97Zzeli
 wZ6LeLWBzivQ00XO1bQHZb76R3s8saCFIqWUj8/mhXjojN4vkR5fwQWKzaxESln2tY+P9Sp2I
 HT1gSZ2AlkuPopApPBNEfjp4b8HoQxwW3BqDJI8rPXPzjcdUyDjKIioFirdgGRxj76V1vuv3Q
 1T/2jjwApOgrh3w9yN50pEtMYS86pIPH9BeJIWVRfr9VijkBDmi3pmPwEj8rhj5ycvuBREmiF
 cbM6AnXPdlARoIk28UT9N9JWyFhg74P9kR4ZxGnpWFzZuj4FdsWG/Yi1XmLiKq1/8oFxZr8WY
 9/Tmg1e8VpyrLw46BxpXhA2BLeoZgFVEeMaYQCj5hgLQeIpgTyxOiJDt1F4vl5IPKy6G/fSZ3
 AyNnt2AxBQStdKi6E4KcqfDZWoF8Nopey6nIQrh9/OoyS2ZvmUcr8/fO9LInWlqaHkUeGjRhw
 s1vwte4epJyh55gndqz7xkqiC4AxlGTbZqngrAyDKGmIzzr4A0qbUZEFJS+yP4wcqXUxaviAl
 Svg3CcI/z7RKrt0Adj5sXldt8WGHdCZIvrV0V29NmVEY+O2/gca6IGNB4/j8xNDA7vFKbdIth
 KEOtvWPNWZdR+m2VBQVyHcqhmQcnoZcGXsT2RfZRw1pleXsdGx56n7PN3FdM5X8B/n7k6Is2Q
 zoUuz+PyQTOgVSEgGSrclAaZoohA2lnPUV7yUycS8Q9aSVcMmgfnn0kbueZqzLMHJ1WlMU6q5
 frnGPPaY5zPp353/HS6Fjjsu8u0bQx/fIkh+lXGWRmx/6noacSCCxA3dTPsvwQlQM5Ss/mZTR
 ER2TzmMcKHfA6kxPr2/QxdW6JX/sfKOgLNwaNvEVzeMQUFgHEFJ89qNKSBEl4YWDPNdmjMzCh
 MEXmAi5csr88bWNgDaXXPnmfuPY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/6 07:08, Joe Salmeri wrote:
> Hi,
>
> I was running openSUSE Tumbleweed build 20231001 when I first found this
> issue but updated to TW build 20231031 the other day and it still
> reports the same issue.
>
> Kernel 6.5.9-1 btrfsprogs 6.5.1-1.2 Device Samsung 860 EVO 500 GB
> Partion #5 root btrfs filesystem, no RAID or other drives
>
> I run "btrfs device stats /" about once a week and no problems are
> reported.
>
> I run "btrfs scrub start /"=C2=A0=C2=A0 regularly too and no problem are=
 reported
>
> I ran "btrfs check --readonly --force /dev/sda5" the other day and got
> the following errors:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opening filesystem to check.=
..
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARNING: filesystem mounted,=
 continuing because of --force
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Checking filesystem on /dev/=
sda5
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UUID: 7591d83f-f78e-402b-afe=
5-fab23dad0ffe
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [1/7] checking root items
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [2/7] checking extents
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [3/7] checking free space ca=
che
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [4/7] checking fs roots
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root 262 inode 31996735 erro=
rs 1, no inode item
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 132030 index 769 namelen 36 name
> 02179466-b671-4313-8fa5-0eb87d716f92 filetype 2 errors 5, no dir item,
> no inode ref
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 132030 index 769 namelen 36 name
> 77ef9cd4-0efe-46af-bf7f-47f582851e16 filetype 2 errors 2, no dir index
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR: errors found in fs ro=
ots
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found 33034690560 bytes used=
, error(s) found
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total csum bytes: 28819244
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total tree bytes: 986251264
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total fs tree bytes: 8761344=
00
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total extent tree bytes: 625=
21344
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btree space waste bytes: 277=
302161
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file data blocks allocated: =
141608800256
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 referenced 39054090240
>
> Running "find -inum 31996735" identifies the item is is complaining
> about as
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/bin/find: File system l=
oop detected;
> =E2=80=98./.snapshots/1/snapshot=E2=80=99 is part of the same file syste=
m loop as =E2=80=98.=E2=80=99.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/bin/find:
> =E2=80=98./home/denise/.config/skypeforlinux/blob_storage/02179466-b671-=
4313-8fa5-0eb87d716f92=E2=80=99: No such file or directory
>
> Running "ls -al /home/denise/.config/skypeforlinux/blob_storage/" also
> shows that this is correct item
>
>  =C2=A0=C2=A0=C2=A0 drwx------ 1 denise joe-denise =C2=A0=C2=A072 Nov =
=C2=A01 22:49 .
>  =C2=A0=C2=A0=C2=A0 drwxr-xr-x 1 denise joe-denise 3.7K Nov =C2=A01 20:0=
7 ..
>  =C2=A0=C2=A0=C2=A0 d????????? ? ? =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0? =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0? =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0?
> 02179466-b671-4313-8fa5-0eb87d716f92
>
> When I originally ran btrfs check there were actually a bunch of other
> items listed, however, I have timeline snapshots turned on for the
> /@home subvolume and all the other items were because of that item in
> each of the other snapshots.
>
> I removed all the other "home" snapshots and now btrfs check only
> reports that one item as shown above.
>
> I have heard that btrfs check --repair is generally not recommended but
> I have been unable to find a way to have btrfs remove the item it is
> complaining about.

=2D-repair can fix the problem.

But for your particular problem, please also do a memtest just in case.

This problem looks like a bad hash, which may be caused by memory bitflip.

Thanks,
Qu
>
> I have tried rmdir, rm -rf, as well as find -inum 31996735 -delete and
> all report the same issue with not found.
>
> If I understand correctly, the parent directory entry ( so
> /home/denise/.config/skypeforlinux/blob_storage/ ) has the entry for
> /home/denise/.config/skypeforlinux/blob_storage/02179466-b671-4313-8fa5-=
0eb87d716f92 with inode of 31996735 but it doesn't really exist.
>
> I do not consider this a HW issue because btrfs stats, scrub, and smart
> do not report any errors and I also track all the smart info ( health,
> reallocated sector, wear leveling, etc ) for SSDs and there are no
> errors reported and I am not having any other issues.
>
> I suspect that this occurred the other day when Skype crashed. The item
> is not needed, I just cannot figure out how to remove it.
>
> So, is it possible for me to remove this item and if so how do I do it ?
>
