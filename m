Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B83782422
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 09:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjHUHFY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 03:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjHUHFY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 03:05:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD79AC
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 00:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692601516; x=1693206316; i=quwenruo.btrfs@gmx.com;
 bh=q2X2H373LEGPefI7VY2NBR39diuxnYmTfnT+M+lkgeI=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=E3A1m8HPEsxEXfoRzNxq+6xAY3vRvR9LacUOKuRtrsc0ocNc33/GS0TrtS8vHFmTcEhAgxq
 6uO1URZ5nFNtJNoO5rjcWI6x3xK2A0SxJeOJvsooJBJZOgzWkQg6FgwUD/5erT9tLajvfs9lO
 bOsahYqrlu8vOkNSpvoNKpvKdt5VBnaR//cDtq7Aea7OHCh/C0EQxTCalaAUpuvXuWzYINg6/
 aRxG14v0XOvkm3p/7NUKnQiNbB0uu+dBRghzXTEnyljA0i4SNuFpKJYBpGPWrGM6wCN5I0hqQ
 vdXohCBmtcRtbWUHztkCZC6W+zE9I5kjiWIGHatZtm5iUPI8G2Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQe5u-1qLPwI0TzS-00NiTK; Mon, 21
 Aug 2023 09:05:16 +0200
Message-ID: <d515a277-a22a-404b-9671-af646bc595d1@gmx.com>
Date:   Mon, 21 Aug 2023 15:05:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs check Causes File Corruption
To:     "Longhao.Chen" <Longhao.Chen@outlook.com>,
        linux-btrfs@vger.kernel.org
References: <OSZP286MB1533FD75E8CD5AE3D1CBEF1C9E19A@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
 <b3fce2d5-c589-4356-80a5-4d973b63ae28@gmx.com>
 <OSZP286MB15336127387272CC9919EDDD9E1EA@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
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
In-Reply-To: <OSZP286MB15336127387272CC9919EDDD9E1EA@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3KtrkkTC3Y3rugDA5Fx4E8Jx64vmiG+CUPXZOAwTjX2aq+ggGNc
 NYN4Jcf/0rpE7s60mgd8KguVkZpyhaErav1Wv9QPgwCayFrW6bjKpNhpPbu72lACuII5AOL
 YMjWZbPuxvN9tQB28R6bPmkTZlYcAaKaPvd73DoOrA3xXXvPvXA6Z2In4FrJye9uBAdp3aR
 3aw/+oJBxRrPe4rYtGBqA==
UI-OutboundReport: notjunk:1;M01:P0:OWoRhzqp9jk=;ukGR43+2QE4wxCRirWPiILe6jI9
 /kN7A2ErX0wYR1kCl946zX7v3N+YkipmeDil8V9aA6s+iNpUJPa2LtjyOHadNZHJtIjxDYqoD
 6wyiG87CF8nNOmPlJbaUtJGORukiZYpKqSSBPI1PbF/YhLPwz2OzqsZ9mAgoRywMecV/GlNKp
 220DFtKZ2d1ENly7k8yiXUA3kTtdK0vpaTv7vOSJwgCZaMS49ukTJpR6Ov6DGVrp+KWfMelBB
 ZfjEKVxnDqjzibWny4tZznC2VLUW6dQ9icBqrWUqo+jVFPhTOlc4oxTwztmSUKY1anJIPQnW3
 o2z/MsGWPQzhuWK3mJ2wd6MwFYvmH2KsMgTf9qB+CZiqCPac8ZlRw90VZ1xBOpd1tpBTR23Cu
 syvtXeyduoocWvO8tm9iFWH3hb3QwM6cuoL1hXP5r03UyCgeqA9zfhdiLctYsYaqf0UkCQdZ+
 1kqn/TsGqC4rQEkypxjfbXVhppBe5H3AQhBqNc1aNMW95jr88r7ww6/cJZgipzntOGSX9XCC/
 crXmkp1rRxquD4OIkufoFpBSy/JslX5724TE5TI2oD0kOMPqoGSm4I/FuaQ+ZOuFAZ+qgkylB
 yNIK2GhNX1wr5ox9Xqb4nI5Y2JbA3/QLsM+j2BfmPeNoTP2jn4YeB/XTEoO7fCt0XrbsISFXN
 TlPpxFQY6JCkgKh4+nwatQJGP6M00ozW4zM0fxdJDelu879j4/B1/phbi5Y5v0pYBkUCMYiG5
 fMLGAOj2RVVT/+p5jDVVEGsS5jMyGqmvo+QorQdYqXQz+0R3GChKZ0qfF0h4XQBfM2fB0lSHN
 3vWkU2At0ePwetQl1ZKPYErnxKrQHtMdK3/BTCq5Z+aq+j3i9VRJGWpE1bOOr/Pf/FvFxoKKI
 UONnbmk8sQ6RXLjFc+ey2MElBswFPpJ5yG/A0qyFBNJ2bTqb2sqhCpz1pC4BIpe7oylzUOP1R
 7MP/pfhszLIIkr8JJyCOvxl/e/Q=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/21 10:07, Longhao.Chen wrote:
> Thank you for your reply.
>
>> Without your initial btrfs check --readonly result, it's really hard to
>> tell what's going wrong.
> Before the repair, I ran the commands
> btrfs check --readonly
> and
> btrfs check --check-data-csum
>
> The former did not return any errors, and the latter reported an error s=
imilar to this:
> mirror 1 bytenr 13688832 csum 40 expected csum 198
> ERROR: errors found in csum tree

Please provide the full output of that failed --init-csum-tree run.

I guess it's trying to do some unrelated fixes in subvolume trees, thus
it unlinked some files.

But btrfs check should only remove a file if it only has one of the
following items:

- Inode item
- Dir item
- Dir index

3 matching items means the normal situation.
Missing one of them, btrfs check would rebuild using the remaining two.
Only if there is only one of them, btrfs check would remove the file.

I did a quick test using --init-csum-tree, and it properly rebuilt the
csum tree without corrupting the fs.

Also please provide the history of the fs.
Like when it's created, and if certain features are enabled half-way
(like no-holes, v2 cache etc).

>
>> Csum error itself can be caused by incorrectly utilized direct IO.
>> E.g. modifying the direct io buffer while it's still under writeback, i=
n
>> that case btrfs just properly detects such situation.
> After running scrub, I found out from dmesg that the file with the error=
 was a virtual machine's disk image, but that virtual machine was not runn=
ing at the time.

VM doesn't need to be running at that time.

This can happen when the applications inside the VM is modifying the
direct IO buffer while writing it back.
If the VM is using btrfs and csum is enabled, it should also detect such
problem.

Thanks,
Qu
