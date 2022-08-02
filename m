Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8399F5878B0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 10:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiHBIGB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 04:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiHBIFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 04:05:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E333A2C
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 01:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659427529;
        bh=d4+xflw2f2M06txRwGIjGQFI+A7RRSQhW0n3Yx+l5iI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ke/FoU/ag9Ih8fGidZSoYcBPjrt4UbMC6y0bXnXonHsqhmhBgfeR6QPFV0mNLjhuS
         cVeXBWQJ+BQEJ2BDx7QYkmVWbJHO/dg9koZ/JyuTn45JwzjmTn/4nM2FovCO1ePEQ1
         Hl0ewfQzc2c42apAFZF39C3Glj0lBV6HKnfyIHKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpJq-1nk03G3X0M-00Ztd8; Tue, 02
 Aug 2022 10:05:29 +0200
Message-ID: <de9629df-3203-23b0-86bc-4d6ecf017417@gmx.com>
Date:   Tue, 2 Aug 2022 16:05:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs-progs: avoid repeated data write for metadata
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cdfef9acd4b34751791cafc49612a35328847847.1659425462.git.wqu@suse.com>
 <20220802080231.kzrywmuduunmhsn4@shindev>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220802080231.kzrywmuduunmhsn4@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/1UG7ZlZV4VWZUoelvlSxpn+bQBEh6/HXaUaSP+KVY+lbjyp2yE
 B7sdTOZVnJ5LQFPAMAiKMAuQxLVJTrdFWINRi1oy8ajL1f9Vvndsc8oIoaWjJBbn72K1ORq
 UPCBFMuBUzmB0GbZ3LagSEdc/z7f0iEoSNA7MbKz23/oGF3DjupQ25F5UPwpW9VQQzsGuaj
 gE0vCoer8GTCLMSQz2X1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QWurLWDpngg=:M5GpbvDzNgMi05GF6A0qCS
 rGoo5GnshjgzeZnxhoqhPQhsHCQ0W0JRU0dvYt1a/tIipXQFT6b3AwJFUo+32wKth/h/VzlMt
 7v9mojQaMX/thdr1B+a36itL2hgqDmBtNnfJyUhrxDL7JkHhY6VYwmNrIXz5x8NHJHvUtyC+T
 yUOLGvCJDJLSCsPMlqHGN90rWTvR2BtscJq0ylOj5d4EVFCnOJpfuMtnfVZBVBqakyezLoh5Y
 1tNnI+fMCz5R0PaPVr3tmeIk0/eODo2T2ROC9kWh7hGvu28cjULyEq4GE41ehIHvepKXswolx
 BzTakBSUssdSwPOEaRfjKWOcUiOVyDOLahbdZl+y47zOBAyUfNah5ZLkljJT2ydcQsZqwTcXw
 BwXQPGt2R1O9i8jyzu2KY6tBf5vVx9vAxQPL6wbGfCI4GqqjQiOzcTgGczQ5V0pHhVVoVuq1f
 ROttyyAaWo1HpMfO6NKr2++N/owTokvTu0+ynnRcusD92NreLkuyNKn9r5fTuo9ip9yeKismJ
 65Rs3lJnANfug3bTIVE4hCqfruR0kBu2OE7wMDmGtRHmYp/nupDhkYU1AO5WwA8jZ1DUogada
 vstIqH3aR4pGN16kZrFxPJtHBiMoTIJKcosY0zSDlh5c2Yv2zlA77vsmDilKJZD9+QurTgEBq
 vhBh3NO8H7yH6TTQo9pdhW2GIv0VQmDXeu7WfYrGZY0xvhjApTpR7iRDBU7gttRcqm4d2kRje
 TB/FXIzK+2T+mvfQi7phUWJRLQL9ZzvUuTUJaskkDFGYF+L9aQbBjXMKNhD5FO9UUfOf7J3Nw
 BDHmAGGghu734Plp9ASq5WOBKJWyCb9Glmu+abS5jzBxSnDsp+Fh1IPKRkps0nkuRpXIUcuwg
 5utkCHTGmkgXK20XAIAAinksqmTsyEd1ffX98N3v62MpqDKD57Oit5LhYhbhpwb9AS7/Rf1ji
 YWHPox2eMgPQ/ZRQtoWzKJkkDF/PLNuYTlzvitCU5c8bbRybBXL9pAUdml2frKXdAW+tHaf2B
 CQ3GKdOIUzB5rzFPwQsHcKAb1/+bqshh8W59oPUOJ7wLd8GJkSFhKvSlDNF+VOb9A49bGHtKF
 V9fNYi9szRhFvoYaoJyxvSrFw1bF9uzqPKqPNGkmm37ydzOjI+O6DGGFA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/2 16:02, Shinichiro Kawasaki wrote:
> On Aug 02, 2022 / 15:31, Qu Wenruo wrote:
>> [BUG]
>> Shinichiro reported that "mkfs.btrfs -m DUP" is doing repeated write
>> into the device.
>> For non-zoned device this is not a big deal, but for zoned device this
>> is critical, as zoned device doesn't support overwrite at all.
>>
>> [CAUSE]
>> The problem is related to write_and_map_eb() call, since commit
>> 2a93728391a1 ("btrfs-progs: use write_data_to_disk() to replace
>> write_extent_to_disk()"), we call write_data_to_disk() for metadata
>> write back.
>>
>> But the problem is, write_data_to_disk() will call btrfs_map_block()
>> with rw =3D WRITE.
>>
>> By that btrfs_map_block() will always return all stripes, while in
>> write_data_to_disk() we also iterate through each mirror of the range.
>>
>> This results above repeated writeback.
>>
>> [FIX]
>> To avoid any further confusion, completely remove the @mirror arugument
>> of write_data_to_disk().
>>
>> Furthermore, since write_data_to_disk() will properly handle RAID56 all
>> by itself, no need to handle RAID56 differently in write_and_map_eb(),
>> just call write_data_to_disk() to handle everything.
>>
>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Fixes: 2a93728391a1 ("btrfs-progs: use write_data_to_disk() to replace =
write_extent_to_disk()")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Thanks for this swift fix. I confirmed it avoids the mkfs.btrfs failure =
with
> zoned block devices. Also I confirmed that the duplicated write is avoid=
ed on
> non-zoned image file [1]. Thanks!

Sorry, I have already updated to version 2, as this version will cause
problem for RAID56 mkfs (caused by an outdated BUG_ON() condition).

But the main idea and code should stay the same.

Thanks,
Qu
>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>
>
> [1]
>
> $ truncate -s 1G /tmp/btrfs.img
> $ git checkout v5.18.1
> $ make -j
> $ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup /tmp/=
btrfs.img |& grep btrfs.img > /tmp/prefix.log
> (apply the patch)
> $ make -j
> $ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup /tmp/=
btrfs.img |& grep btrfs.img > /tmp/postfix.log
> $ diff -u /tmp/prefix.log /tmp/postfix.log
> --- /tmp/prefix.log     2022-08-02 16:58:43.517472861 +0900
> +++ /tmp/postfix.log    2022-08-02 16:59:08.197196602 +0900
> @@ -32,66 +32,36 @@
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 5357568) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
> -pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
> -pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 4096, 65536) =3D 4096
>   pwrite64(5</tmp/btrfs.img>, ""..., 4096, 67108864) =3D 4096
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
> -pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
> -pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
> -pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
> -pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
> -pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
> -pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38846464) =3D 16384
>   pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92520448) =3D 16384
> ....
>
