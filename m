Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA1789AE7
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Aug 2023 04:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjH0CHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Aug 2023 22:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH0CGm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Aug 2023 22:06:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A187114
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Aug 2023 19:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693101996; x=1693706796; i=quwenruo.btrfs@gmx.com;
 bh=ogIsPnq9olmx/lJDMVz20nd7UBYJcGRbh/A032mXyoo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dQsUdFP/asF8KzPp1sozLedDzphcDbqVnDsomwXaV0GXavYf4oRoyGXxvYetnE6bemkunq9
 faWffvt+7YX2A45LrwIsgpZMvwjDjCkR34mproaV4b0ihK5bln6e5pcDQ0+CfcETSx91qSJBU
 SIEd7mLv+36YemcO7OSZ/3wXm5d7+gkY5HtDviXm+kj8t0Z1cI0e6RQe0aBr+7qFpnwZ6dgIS
 qqzruDSztWGv1tjinTQrOHNOFS8wqSaN0SKpr+tcSFRXH6OaBEfh3QEZdcW7DpQZoA3rbuP0g
 /1RVNLGN0V7+UhfCD2C1pBBh5MSv4lmQGmd+6ZgDy3sJQz3eogpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1peWOu3VR5-014xzv; Sun, 27
 Aug 2023 04:06:36 +0200
Message-ID: <f7f9dc29-0178-4cf7-87d0-e7b137c01056@gmx.com>
Date:   Sun, 27 Aug 2023 10:06:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs check: root errors 400, nbytes wrong
To:     Cebtenzzre <cebtenzzre@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <4a18c53b36e312b3de3296145984ed74323494ff.camel@gmail.com>
 <04b21f25-a80e-4e1b-a70a-3401ca3c2af2@gmx.com>
 <7536ccd3d1c3ccc349aa5f0f5e587c21cb773a46.camel@gmail.com>
Content-Language: en-US
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
In-Reply-To: <7536ccd3d1c3ccc349aa5f0f5e587c21cb773a46.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P9JLfT+kt9Hsb2J26oO3ACXsUSHBlQZDoqlLkrCWadI9NEPwAPH
 1u5HPD35LUGS///wolmGAKFUjLevGxZp8q9yGVCX1JaK6iZ2kB6HTkoSLUION5cBpwFBXE4
 EGJ2tU7xnueniAUtb63NrpS5TLu/XGTDNYT+lRPnlEM+O9VLgjnoBK2sqI/5sJ0N/A2hzlt
 OlFI/2Po2xzaUPOixdM7A==
UI-OutboundReport: notjunk:1;M01:P0:RKrXZc+QxtE=;NKvgDRez0GB/T6Ymx8rnbApfKbF
 bjv3g4JXwj1PyydyntPwtBTfBJv4dzIEYpOvUxpOYrVwhedRbfZZMCJozUk9m0ITJ5gCsbAZt
 SOHrAL+GSBywtCVGElkRujM7fW0cg09kMaUVhnVG2zvH8DqHHMC3h6m37aJXt3M00w8DYCibt
 Cjse2eYS5AsMIxy3vM3TXz57SJgHi9xnFHVt/BNzYrhf+RK8039fczelq7gB/ko9bp4iokMv+
 +oE/c/s7Lt98rI1hEu5wO1yLybJzsc+Rsn4OkyZNA9sjqnCp5oHT7HRqwcZ5nMxu7yOrcC+NO
 eph5NDbOziV/fYOBT+cRNXLIPgtKjC2nYfMyXPgC9pyAKunqpSsrVsl3qnc228v71O9bt/MEA
 PohcoWii60d03y0vC10sbYCWwIpMG1ZyFVx5eTISgyVFH5bdbPVRjSETTN6rRUP8UzCCAr/Yq
 Smpeggc7ibKp0BjVkK0Da2sghTJt89pKwa1pBxiuy7gEgQTbKIVaPfg0p42rvNs94LeZnBL/p
 GVZc0njLUF+2LIRuHaJKmAX7/p/o/pFg7owC70liD89z0lMK8RLJ/wENde7LpA0PJNpU0lCNB
 rneKPmVB1IhPzs/Az1dHBB8YMLFle73MRiHg/G35sOHNOLetj3VxCrclxUzfZ+0USMm6G0DAN
 G91v4WPuzcYaOoxRjI6d4goOUEwtn/+u5x1cQwmuDCrKZ0qq08suMRWmUpXGg9kq+vaGNMCB1
 SA3cRSRdj8nSrLq0zahfI0defHHBYaf2G5HXIa2E4N+Bb9kbD0k5b5+n3QcbfK10Jy78DnWOQ
 XWKxfaFL8/Fk+hCPZ2BD+0GxQaq2HW57hQt3dgqM19EC0GyC6FkAWJh/9b010j3v2DqeBr2XN
 RoiJWt/ZoU7bxnkC7D56T+kYzSrtWQfLJ+Z0qQ6F1X9rHGRmIbVXlyMyZYyJWJLsDFCDIg73a
 aqxK/8nMJqvygNI0JKrlp4Qk0kk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/27 09:12, Cebtenzzre wrote:
> On Thu, 2023-08-24 at 13:40 +0800, Qu Wenruo wrote:
>> But it's mostly fine, a btrfs check --repair should be safe if and
>> only if those are the only errors.
>
> I ran btrfs check --repair, and it gave me a warning:
>
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 76721faa-8c32-4e70-8a9e-859dece0aec1
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> No device size related problem found
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated
> [4/7] checking fs roots
> reset nbytes for ino 123827824 root 258
> reset nbytes for ino 123827824 root 15685
> reset nbytes for ino 123827824 root 15760
> reset nbytes for ino 123827824 root 15786
> reset nbytes for ino 123827824 root 15814
> reset nbytes for ino 123827824 root 15822
> reset nbytes for ino 123827824 root 15826
> reset nbytes for ino 123827824 root 15830
> reset nbytes for ino 123827824 root 15834
> reset nbytes for ino 123827824 root 15838
> reset nbytes for ino 123827824 root 15842
> warning line 3916
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 2405445431302 bytes used, no error found

Despite the warning line, everything looks fine.

To be extra safe, you can run "btrfs check --readonly" to make sure the
repaired fs is completely fine.

> total csum bytes: 1891078208
> total tree bytes: 13012697088
> total fs tree bytes: 9898934272
> total extent tree bytes: 836861952
> btree space waste bytes: 2043135264
> file data blocks allocated: 25854472876032
>   referenced 2618226024448
>
> This is btrfs-progs v6.3.3. It looks like that would be line 3916 of
> check/main.c:
>
> if (!cache_tree_empty(&wc.shared))
> 	fprintf(stderr, "warning line %d\n", __LINE__);

I believe this is some corner cases we didn't take into consideration.

The original mode uses an internal cache to handle shared subvolume tree
blocks, I guess there is some thing related to the repair that confused
the old walk control cache.

But as long as the next "btrfs check --readonly" reports no error, you
should be fine to go.

Thanks,
Qu
>
> Is this anything I should be concerned about?
>
> Thanks,
> Cebtenzzre
>>
