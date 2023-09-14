Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF4879F9EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 07:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjINFMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 01:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjINFMN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 01:12:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBC5AF
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 22:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694668326; x=1695273126; i=quwenruo.btrfs@gmx.com;
 bh=Had1lxUvfRCGu0xeUtcDNYIiicAOA3pV8QCiL1KGO8o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=DE/enzX6u5pKXDqolWD9COILcndvMFSgel6m97q3fderHfMwGYW6rL9QjCQs+cXMiANigSsPMfu
 Eww67iXZZpg+TIdOVMSeRuzcqEBbVXxZVpd4DOVpZrsb3/jjSzi0/j4xoaRm74LptgB3IoPcukhGK
 8114ObEZ/c8JNbUghlQpRKEH8/IJocCuSqm8KQMg3Omr/HMXd2J6AjAmslv4Fb+wS3jff7Xq2+Bmr
 ojJ8gFseHygPRZAP1dS7p+ipnUg2K6Kqa1Ofgnv0yxqrJq12CzgihZr+lPXllCEt9BNsXazm4Wu/y
 7h+9Y+uIsdQj28zc20Mw9DsEchkBCjU4NFJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.12.112.64] ([154.6.151.111]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTRR0-1rASb32qi4-00TkFU; Thu, 14
 Sep 2023 07:12:06 +0200
Message-ID: <bb668050-7d43-467f-8648-8bc5f2c314f1@gmx.com>
Date:   Thu, 14 Sep 2023 14:42:02 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
Content-Language: en-US
To:     fdavidl073rnovn@tutanota.com, Qu Wenruo <wqu@suse.com>
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>
References: <NeBMdyL--3-9@tutanota.com>
 <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com> <NeGkwyI--3-9@tutanota.com>
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
In-Reply-To: <NeGkwyI--3-9@tutanota.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27lIUlgigMWn75R34zeUosx2KFKKx1T2RGdWjvrrg2YKnGFHioD
 ygmCZ4vR6FNKflBUgQAo8vIZz6D3WcpxFm05P9opYc6V6dEli7aU1trcWayXejoZlmyGNMm
 SG33cEIcCzuO1daA3TsjPWD6MegUP8EZhohAjEyEG2XOQ5B0kQFbsYRSOk7zIJvjzqM41Yn
 lVefQ+9puOVuFouUDbpIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+ttpHvk1E5o=;ZsLOtArMggxlZLlZjaS942mx6yb
 WneU+kRC9dHkwk9anHTtObH9NScUvNquRn+iY1MtQs3aXjzd12VUeYKVES1d82hANXPIUG9Xv
 m0bMiCR08CA11Pct6qIldJdftQEN0/Xd7p5k8FNyL5p94T9l7ObDhfXsn+el4j2ShJyR/SfpZ
 psX7wtq9lk9Gq057h8OgW+0EEo2KonXubedR4E+C2bUSnfrD5fdMi3S8DRhelSOnzC3arw0pe
 dJ1Yw37Y5vC/cVVcOrOgHfTxixMnVDwXK5Ua1gIqgetX1l5Lj9u9xblbsopAWGHRh7l+4zOaY
 tNIrDF1o6w/w9cKoW53TkqeVDsiZgDvhsu2wiKBSTErN9O5ZU5F+KJPFbmtLeTGbaTbnJVDld
 K5phvC6dsC35K40jHZOlr8EHy8HLbXQ0zXLzlPH2RtvesGhyraCV592PobBsZ8VoMoN9R9jea
 n+EHEEwy2eMyqERPhB3zuEC5THI5hhPXGiTVHRnQL/WXzINFxeXHyqMY+xJlRuQsRqxwYWmPh
 BmM135KR6iSfwevjFtzNHwwLCKj6hpkyd/PRX5bffqTYHr3vI4OrhT2DS5VWarbugMPkuCNjC
 nDfTxOXIOisV6o+UXXxEUroLw+ZPEBHKeU6tCRtXkzmDgUXYSxnjH6/WlrIoH0w4UCd+PQW7T
 8fX7/qe8RhW1DBKXi/vpvQ3YVxzT7phzQKYpc/OWRDa9ExEdMsT83OdjgV4Rx7tj3vx2UhCT2
 UwL+SX9znt9hbIxxRaCDjUF004Lwx5ai3/gjcUc8NBq3qDiyQkR/FJSF4xwErfDhellExJOKw
 PBxin4iYJjnP/7DS2fWQdB5y7G4qwIMHt2cAIoPIdyVRGbsMSCNTV6glZpuR3UYfz70gsBuj3
 FFXs8ZWz0T3cNj2EPvIAx+zT/8PgkpCXxuOsefFkEPLNaXdNTLPAQjH0DBGI4W71vsIolhENi
 yQhmduEaJpZd43o5Ffns/I6RkeU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/14 13:08, fdavidl073rnovn@tutanota.com wrote:
> Sep 13, 2023, 05:55 by wqu@suse.com:
>
>>
>>
>> On 2023/9/13 11:58, fdavidl073rnovn@tutanota.com wrote:
>>
>>> Dear Btrfs Mailing List,
>>>
>>> Full disclosure I reported this on kernel.org but am hoping to get mor=
e exposure on the mailing list.
>>>
>>> When I delete several terabytes of data memory usage increases until t=
he system becomes entirely unresponsive. This has been an issue for severa=
l kernel version since at least 5.19 and continues to be an issue up to 6.=
5.2-artix1-1. This is on an older computer with several hard drives, eight=
 gigabytes of memory, and a four core x86_64 cpu. Slabtop output right bef=
ore the system becomes unresponsive shows about four gigabytes used by khu=
gepaged_mm_slot and three used by btrfs_extent_map. This happens in over t=
he span of a couple minutes and during this time btrfs-transaction is usin=
g a moderate amount of cpu time.
>>>
>>
>> This looks exactly like something caused by btrfs qgroup.
>>
>> Could you try to disable qgroup to see if it helps?
>> The amount of CPU time and IO of qgroup overhead is directly related to=
 the amount of extent being updated.
>>
>> For normal writes the IO itself would take most of the CPU/memory thus =
qgroup is not a big deal.
>> But for massive snapshots drop or file deletion qgroup can be too large=
 to be handled in just one transaction.
>>
>> For now you can disable the qgroup as a workaround.
>>
>> Thanks,
>> Qu
>>
> I've never enabled quotas and my most recent attempt using the single pr=
ofile for data was on kernel 6.4 so they would have been disabled by defau=
lt. Running "btrfs qgroup show [path]" returns "ERROR: can't list qgroups:=
 quotas not enabled".

OK, at least we can rule out qgroup.

Mind to provide more info? Including:

- How many files are involved?
   A large file vs a ton of small files have very different workloads.
   Any values on the average file size would also help.

- Is the fs using v1 or v2 space cache?
- Do the deleted files have any snapshot/reflink?
- Is there any other processes reading the to-be-deleted files?

One of my concern is the btrfs_extent_map usage, that's mostly used by
regular files as an in-memory cache so that they don't need to lookup
the tree on-disk.

I just checked the code, evicting an inode won't trigger
btrfs_extent_map usage, it's mostly read/write triggering such
btrfs_extent_map usage.

Thus there must be something else causing the unexpected
btrfs_extent_map usage.

Thanks,
Qu
>
> Sincerely,
> David
