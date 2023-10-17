Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878427CCDAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 22:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjJQUOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 16:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjJQUOB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 16:14:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360EF6FAB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1697573634; x=1698178434; i=quwenruo.btrfs@gmx.com;
 bh=+IFipttMY48UYlLzZJ/Jtn1mmCZQNQN1B4BujT4qCys=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hTnaJHzRazoEYU3acPB/kPtn7VUvEnfvZ+yFZfKpraAxzMTYlosUXHZ2ww/v1rLDbO/R5cunfXf
 w8a61Gw2V1g7sJOaAjCJr4OeRz/xA0xJkw+nlacB1KUzsa7eovgQg4V/7B3w36Q4IPvL37ffH9xiR
 MhZTDbdhqzgdD/evlx4SQPvgmfmtNeI5M3aKRPpIqmI6GbHrOzuxe2OugtbOuj2kN1Klx6pzDnOyp
 yeW87I37x+ney7fBtjcCe/U1Gd8w10mN+QvXFTHL1g4xlw/WGZFqsMsPbucGXI6PPZwox6SEkwcJi
 cWFAkHK/zaIIm6SMPbsQcF8BLpvmui8EVAkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1ri3vS0rax-00srz8; Tue, 17
 Oct 2023 22:13:53 +0200
Message-ID: <93d801d7-2e39-4854-b2bd-8b604aad42a0@gmx.com>
Date:   Wed, 18 Oct 2023 06:43:47 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] btrfs-progs: mkfs: introduce experimental --subvol
 option
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1697430866.git.wqu@suse.com>
 <bcb175042cb8b4036f532269235af02e10a69de5.1697430866.git.wqu@suse.com>
 <20231017135430.GB2350212@perftesting>
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
In-Reply-To: <20231017135430.GB2350212@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:McpbvEl0njm1NvBqH6E555Hp41T7YT14LCWdK/v5+YahCU2x20v
 TJ5tiZesxjzsEuLVrnU6bnWoFrXCxo3mkotLsK1D4Gx4OZqQwUds5rRcZ7tP5qI5ml8SfSo
 otEwqvgHdF2p+J3tB+/S4vWi0PCxyVqzX65RiLx1TwBniTxdofV+V532eEBDSJyxNtiLdMG
 /kWKXX/s9Xb3UyJfR0eQg==
UI-OutboundReport: notjunk:1;M01:P0:3e/8KXfOrZI=;bpJd3KBZ0uSDHeZAJJ6GhScFOdM
 ASVN33QvJoqY1Osd8Zt8EiMAC2H/xNaWquJGYWaUMh3zBMtdkJ2xgdLK5Due4Wib5LexNUPcm
 IlC9JZezQwV/+LkwsA1t6H6wU+TZKHL1Ab5bYOkS+lHga7GXssQuG1+Ehho+ixzWXqAJEvNxh
 c6R84XTdng9W8w64OtUeLG2wGxdwWnSC71+QDLnYIdT7iyULGo5YjId45DEREaildwdIKPinH
 Sqb3VZt51lulPj98xt+mMY5T+KtmyR/RzKZz7NTO9qdjLikMrhzpfr+zuyjzMS0RXeE5jXeX/
 FIXHfGlYQlDuBvrmYqsd16oNEXIFgynKxCVWgMtcpHEnszw4N54xZBKxMuCEM3OayJeF55L0b
 3uyA6UzNOIW3QUdgSJ8lj9ceOlBevw4uzweULJPGyXyx3fg3h+mtd4XUhn2fvx+6ht6qbWziL
 T9P+9XelyuUp+qunEXwUtDgQBzqzSKU799CsboZvOaOqHAYkeyjTu9LcE+5N5fpD2bPZuP1kI
 NhB0RsxO3GuAeoMARBdpckR6HjmUFULzMTIQVgU2jQa3oHlSdaW1uDwTrLLj0jnVt0HXzyDiR
 7RL2d6qcjcQfgJNx0LSuLf7B90JVN/mdXKcznASEOTcIp78mBmK4ez0tJHywPknK60hYLd0Im
 +8dUossZw+4r+B0NUwfjODGRKFJF5BcxHtj251vN6FYDQ+L96IuVrTWDzYY90OjL0Ib/JkWOl
 3hyLvDPKdqu43xPR5Y5UYTAA6j2SdwiausQwjbgsktYxlHbcRi1a83GMtLrqafS2/m0yBHrAG
 ev0p3leg5NXd0F2v0M0uiO+eicr38QHT40j38Iiwmg6c7aSFuLxI9/F6DMBeT1ksmPP/KA+fl
 RJ8yL0BeDQ+hB5+sukO0ujqoHM0xWIRS9djiJElsNk27ddueWUCP+9V1Q6c811O3cQRVd62af
 IKJc0yYvEc1BdQcDskXyWqx6mf4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/18 00:24, Josef Bacik wrote:
> On Mon, Oct 16, 2023 at 03:08:51PM +1030, Qu Wenruo wrote:
>> Although mkfs.btrfs supports --rootdir to fill the target filesystem, i=
t
>> doesn't have the ability to create any subvolume.
>>
>> This patch introduce a very basic version of --subvol for mkfs.btrfs,
>> the limits are:
>>
>> - No co-operation with --rootdir
>>    This requires --rootdir to have extra handling for any existing
>>    inodes.
>>    (Currently --rootdir assumes the fs tree is completely empty)
>>
>> - No multiple --subvol options supports
>>    This requires us to collect and sort all the paths and start creatin=
g
>>    subvolumes from the shortest path.
>>    Furthermore this requires us to create subvolume under another
>>    subvolume.
>>
>> For now, this patch focus on the basic checks on the provided subvolume
>> path, to wipe out any invalid things like ".." or something like "/////=
/".
>>
>> We support something like "//dir1/dir2///subvol///" just like VFS path
>> (duplicated '/' would just be ignored).
>>
>> Issue: #42
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   mkfs/main.c    |  23 ++++++++
>>   mkfs/rootdir.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++=
+
>>   mkfs/rootdir.h |   1 +
>>   3 files changed, 181 insertions(+)
>>
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 42aa68b7ecf4..6bf30b758572 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -434,6 +434,9 @@ static const char * const mkfs_usage[] =3D {
>>   	"Creation:",
>>   	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (fi=
lesystem size is sum of all device sizes)"),
>>   	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root d=
irectory"),
>> +#if EXPERIMENTAL
>
> I assume you're doing EXPERIMENTAL because you want to un-gate it once y=
ou
> remove all the restrictions?  Thanks,

Exactly.

Thanks,
Qu
>
> Josef
