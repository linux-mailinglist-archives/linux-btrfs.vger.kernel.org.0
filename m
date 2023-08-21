Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C839782780
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjHULD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 07:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHULD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 07:03:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F19DF
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692615799; x=1693220599; i=quwenruo.btrfs@gmx.com;
 bh=/ACTp6Z7laCj8ITxbifczy20RQVyD126dkOCaYD/PzU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=t4OUgCJESRJVT1JTqXYIG8/0xUsKkgNHBC64yrt7cSO4n3ms0acKZKwXIGz6KH8hMcCOLb3
 WPxoi2KVuJxUM/ZFFnNEZ1E0EsxEPPOB1hkgcAftZ4TqnIQ2TtUk66/OpaLR9T7NuRQ1CiP38
 bjU1hwUAQrN/PWZ+3gaz/wAiBlDWYDS8oC3GXfbvNcH8K06KAh3cU6oeOm4DRwLhJr4fRtIcE
 9ldhs4cSoEbzHjnW8ziKur7Xmi0Qy7gIxTGxmxwo7Quu8eUqCmj25JRgdFsNJgOK2sCvt0v88
 0OgbEF05M9CBTe0/FtMGSRXKe+4I8hZnusr2AKP0zPqsSR/q3ijw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZkpR-1qCIfB3mid-00WmPB; Mon, 21
 Aug 2023 13:03:19 +0200
Message-ID: <27629b00-5e62-4ca6-aa71-fce39d18fa5a@gmx.com>
Date:   Mon, 21 Aug 2023 19:03:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs check Causes File Corruption
Content-Language: en-US
To:     "Longhao.Chen" <Longhao.Chen@outlook.com>,
        linux-btrfs@vger.kernel.org
References: <OSZP286MB1533FD75E8CD5AE3D1CBEF1C9E19A@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
 <b3fce2d5-c589-4356-80a5-4d973b63ae28@gmx.com>
 <OSZP286MB15336127387272CC9919EDDD9E1EA@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
 <d515a277-a22a-404b-9671-af646bc595d1@gmx.com>
 <OSZP286MB1533B83878664ABC1E1EAA499E1EA@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
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
In-Reply-To: <OSZP286MB1533B83878664ABC1E1EAA499E1EA@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pEdnaOSx9vqgLz/G9cFkxy7Qr1bLi9P8/6nUYYYTRJy4bcAh8jG
 2m8uJehNOS1G+gxfFMvXN99Lon5GN5jfZDdLoTnJrVXskReut6bwVWojkzMQcc52bN0CZO0
 apAgnfsex5RkAQnAfGR6Ky6KAHImgOwEMKV68eOFuPW6HJ5Nr+mf/t6IWa62ZEHM93TnFfI
 lB7erTxhz5uMtbb8SlMJg==
UI-OutboundReport: notjunk:1;M01:P0:3eNJE4+HlRs=;pCOxrnQVRp5m/9+NDPo8emkjckf
 Im6+Oit5PKLhQeHDkseeprxGfbAq/smlY/RhRBNYB4TiVtmd+BjMSWWy/mTJUtA3R1EYIk/2r
 SjvBqVHVB3mOCITnajuOrp4c0tVhZGoa2RbEa7wwmILK9t7rb6yWVeXCy7cctQd2G0ihPV1Gc
 Kj5QEkKIZTQ14wSpkFsFu3jV7wy0SdOrwb8diIfPjIyg2Wp9W8j4szVZCYOMwmjFEAFebIg+U
 mcMeguCHuSRegyP4tBI35X4KdV9TTlzr1pKUfElEOhoUKaUqHL1B/y9IMRJ9yTQODh+Jrr4tz
 tu8rpksXmBZK/3lbpvS2QuxTViOFH/LBq5R7hrHCZIFh7Y1OBF0Uap4QfODuhP0fm2V1XkYed
 NFsjBG3qgrp3LrsK4zGweOIrt4+wB50d3eqTogjeSkXjea9Ddvr9v/HIMB+A3TGa5bQWZiILX
 ZMt8VCyTzMh+cwIoEDmidx10fikodojPdLVcLpVPdj/CI6Bady5gRqzwlDDoVHndfRMaqgOcj
 reTcjN4jJX2v75eei3kkdlAqOl+fZn7KgtPOKA4BWYwpVMSae776hXWWqbf/xcuG0IRfqiXrG
 +J0camtCOOGZuLiAzfvb8n7yIRbRYFDIMptWJ9i//1/3UrvKAqASh6Wrh93l++OvY9WXZ91xI
 /QmnN1/G0wv0pPmgsuVaKXvV/XKVoEQOcfjeZEca5QY678vEHaPm1VYLLznjqYWoOZe1jQyhe
 l7Q1ZErR0lZDO1PSwg61vABqm4S3sEbZPMY7dBXykcgD+0YthJbYtMEXO6s0DGcss0nNbLRuy
 mRIzpkC9OBrnXxi9M1lonLwzjWv/yttIkS73t0Gf53DjHBXtMnb5Cs+xZJnor2XzkTyv2mmUX
 Q+mqYlruiEz2W9QCktvnxwQgKpg/AOmbpwvnltmcqgXGKBHZP/rXa+wmlYpDQGSp1yim4oO2I
 qjMt1FxDMxrthBPIh6TmMLhox34=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/21 18:28, Longhao.Chen wrote:
>> Please provide the full output of that failed --init-csum-tree run.
>>
>> I guess it's trying to do some unrelated fixes in subvolume trees, thus
>> it unlinked some files.
>
> I'm sorry I can't provide the output from when I ran --init-csum-tree, a=
s I didn't save it. I remember there were a lot of outputs starting with '=
Missing' and 'Delete' at that time.
> I can provide the output from running btrfs check now (see attached).

Thanks for the result.

 From a quick glance, it looks like some subvolume tree blocks are
corrupted/missing so that btrfs check is trying its best to rebuild.

I assume the error happens during the csum tree rebuilt progress.

 From our recent experiences learnt from csum type change, we should not
go the current way, but keep the old csum tree untouched, and build a
new csum tree.

Only when new csum tree is fully built without problem, we can drop the
old csum tree.
This method should be much safer, and rely on less tricky hacks in the
current csum tree extent pinning behavior.

I'll try to implement the new behavior for --init-csum-tree soon.

Unfortunately I don't have much better ideas to recover from the
situation, but only to try "mount -o rescue=3Dall,ro" and grab whatever
you still have.


>
>> I did a quick test using --init-csum-tree, and it properly rebuilt the
>> csum tree without corrupting the fs.
> I have also conducted many tests in the past few days, and I have not re=
produced the situation at that time.
>
>> Also please provide the history of the fs.
>> Like when it's created, and if certain features are enabled half-way
>> (like no-holes, v2 cache etc).
> The filesystem is created when the system is installed and may not have =
on-holes enabled. Later I added such mount parameters in fstab:
> compress=3Dzstd,discard=3Dasync,noatime,nodiratime,commit=3D120

No obvious problem, maybe the compression is hitting some hidden paths?

>
> Last month I used snapper to manage snapshots, creating a snapshot every=
 hour and a snapshot every day. Hourly snapshots are kept for 2 days, and =
daily snapshots are kept for 2 months.
>
> I've noticed that the missing files all seem to have been modified or cr=
eated after some point in time.

Maybe the repair corrupted a shared subvolume tree node/leaf, causing
all involved subvolumes to be corrupted.

Either way, I'll try to rework the whole csum tree rebuilt process to
avoid any future similar incident.

Thanks,
Qu
