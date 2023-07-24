Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727E075EE7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjGXI4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjGXI42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 04:56:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F0131
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690188958; x=1690793758; i=quwenruo.btrfs@gmx.com;
 bh=b8DpYRtRno9Bao2B2Ii1eoK1p+s5W2jRBSKgDXYir0M=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=DOaCvIufntrfKUevNtcdKmvfofCu0zrtcMV6HnuC9OKWpCjUDvVo/cUhRmg6ixJRbF3pxmA
 NW83PmgFxSqL/6klpHW5BHzw+t1qZ9SuptHVl2orGGFkhOv+2E8L78IjPuk5GVar0sS2lR0o0
 pV5h+svNWQdLMm2L2L1c4epp6n/8CwPpfUQWreGeEQvaT7hmrrCLXm/7gZ40xCWANinAFB9xo
 sRRH87jkGQYRs5XQ1MlBOJR+dEWPKT3B4dWWHC29Un8nESTkt/yJH5agM2SlPwzMj/zD0H6S+
 zldVecLTuT8a6SZY8ihnAE060CrLxlaIpAqJzz7C0pwrzz1ogSnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1pdD0e0FpK-00kx1P; Mon, 24
 Jul 2023 10:55:58 +0200
Message-ID: <c2411057-179c-4041-9a0b-92f487adc7df@gmx.com>
Date:   Mon, 24 Jul 2023 16:55:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: warn on tree blocks which are not nodesize aligned
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <fee2c7df3d0a2e91e9b5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com>
 <ec3b4494-2a76-9519-39b8-edb36477e677@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ec3b4494-2a76-9519-39b8-edb36477e677@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Al1Su2J0Oq/20aqW3Fx87++plFpvhl+QnEDsZxFUr3QPxWZG1s
 spyiUxiSno6lrLbury5fAvpuL6YFgFnq15eOgpTn48fS4F375UVjIYmEu/85sSeFDXblxYr
 puUGErsh7ZxkebOZ00QKOAdDJVqQ0+YOYFWdtTrzkBQ+JixwCBnfdSmyl18vgiMzTUjnHCE
 TBdnPnBMgoJFaWH5c1Qog==
UI-OutboundReport: notjunk:1;M01:P0:Q/PN0Go4dQ4=;4VzDX9mvPN9P1HWLm9XqlOySHy2
 SRMjqErNiadYsCKGahu/wKlR/DifNqChpHEnIcqGeMwSTU21JJRoyNUMGUP14JqX6OUua7/Ez
 SFkmJU+86OoZmHPkMVvecFEHNL8u9MarfHFMxGhZGunAIpjkgG2GgJGirvf1E0RGXZwrpVpTm
 c+r+J3CUjGftDfVegT7o2NgeYAMqh9iKOumosCwEF6jcFOqlS8Iq0Pa9Iahwpd5WptGQxEm/e
 2/f1kfCeqUvqODfxJC8GZ+UCcZQsOn4NXStpOqxP9xkBsEU9cj4hH1QXPcaXeQbrtEYOemWKb
 9HVeP3vU5RCy71dt9DKvEGYM0PkpeFXytuYEhjJyO5B+XhQbP6AMqb/8gdw2yNrCLxZR9EHHa
 Cg0JzbMKoQPvOHUDI5PvkXUjjOuYuaJbc9tK/v9WzsTGDj/CY+EMFAzewuWDMJ0YhUrcF2WMK
 3EEVjgLy1boWkwGanQ7Qz0yRscAg8odiCENH08Sv7spMsnriSjioHBeVT3/dyplwaBfCgi/GR
 soZ9Bkp0zvIpqth9FMo8gS78R9RKYJ0HjjjWzs1EsQcMTBefnMfATd2JsIdMorKfkTEprH8eU
 qkg8FwXIB8B5aqW+R3BxXxRbRxu/+TKvFn7Qz01nde9Lajg0Lt8S3uiUUCxYB/tKCl3sg0x56
 Ro8ULKoh2/x3vjq1Q+0T8c+vy3q/hm+x+L9Iy6PdUUaTEbJmwL/Kx0bzm4EI2HSpq2QDiGNM0
 +IADRHt7lHF2hK0dI+JP7CXlA+vLw8Am9lM1wu1iBeFepMRwJ3jEa0KiC19QR8XjADUkI2C16
 yf0szv4ztCtedIDxyx3D+ijMDi/olbAYe6OAMsZG1lYHYln6Bq4fhQL9J7hhIMxMDZujV6eQn
 1xFEiN53eLVgbX+swki3lZAqQv0w1mh9x20fJZXxp4Hqw2QlcP01NjqaiJl34LLOiFLKglgfB
 hcvXnczw32rUmnJL9MiGKqkHOo8=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/24 15:43, Anand Jain wrote:
> On 24/7/23 14:09, Qu Wenruo wrote:
>> A long time ago, we have some metadata chunks which starts at sector
>> boundary but not aligned at nodesize boundary.
>>
>> This led to some older fs which can have tree blocks only aligned to
>> sectorsize, but not nodesize.
>>
>> Later btrfs check gained the ability to detect and warn about such tree
>> blocks, and kernel fixed the chunk allocation behavior, nowadays those
>> tree blocks should be pretty rare.
>>
>> But in the future, if we want to migrate metadata to folio, we can not
>> have such tree blocks, as filemap_add_folio() requires the page index t=
o
>> be aligned with the folio number of pages.
>> (AKA, such unaligned tree blocks can lead to VM_BUG_ON().)
>>
>> So this patch adds extra warning for those unaligned tree blocks, as a
>> preparation for the future folio migration.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/extent_io.c | 8 ++++++++
>> =C2=A0 fs/btrfs/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7 ++++=
+++
>> =C2=A0 2 files changed, 15 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 65b01ec5bab1..0aa27a212d1e 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3518,6 +3518,14 @@ static int check_eb_alignment(struct
>> btrfs_fs_info *fs_info, u64 start)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 start, fs_info->nodesize);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (!IS_ALIGNED(start, fs_info->nodesize) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !test_and_set_bit(BTRFS_FS_=
UNALIGNED_TREE_BLOCK,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &fs_info->flags)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_warn(fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tree block not nodesize al=
igned, start %llu nodesize %u",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start, fs_info->nodesize);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_warn(fs_info, "this c=
an be solved by a full metadata
>> balance");
>> +=C2=A0=C2=A0=C2=A0 }
>
> A btrfs_warn_rl() will be a safer option IMO.

Not really, as this warning will only be output once, as we are doing
test_and_set_bit().

Thus I really want to all messages to be shown, including the solution
to fix it.

Thanks,
Qu
>
> Thanks.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index 203d2a267828..2de3961aee44 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -141,6 +141,13 @@ enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_FS_FEATURE_CHANGED,
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Indicate if we have tree block which is onl=
y aligned to
>> sectorsize,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * but not to nodesize.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This should be rare nowadays.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 BTRFS_FS_UNALIGNED_TREE_BLOCK,
>> +
>> =C2=A0 #if BITS_PER_LONG =3D=3D 32
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Indicate if we have error/warn messag=
e printed on 32bit
>> systems */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_FS_32BIT_ERROR,
>
