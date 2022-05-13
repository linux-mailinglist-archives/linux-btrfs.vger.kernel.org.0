Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AD0525F1E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 12:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356616AbiEMJWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiEMJWU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 05:22:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824FF3DDF2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652433729;
        bh=G12ZKy9yfRN8lzfmOdrRRBlqn4GzAtj4DhGO1mOtT5g=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fkRnLKbpySJfGPMLFQz0Qk2l2cKT0eWJ35czV2/oPa1S3WOCkEmuMWzCVaE/QwDIG
         oSwPAlH308Ftrw6lDvkR5YSGQGpnUdwuTUASXrPKT0e2rYyjChfAQ1CSg7tWA5BQDh
         4APUbjuK3cIsXtasVxTmQSwEW6Tkr9TpsbLfsDT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJhU-1oEqhQ172K-00jIEb; Fri, 13
 May 2022 11:22:09 +0200
Message-ID: <ace856f6-b1c0-6746-797e-af85ce6a0f0b@gmx.com>
Date:   Fri, 13 May 2022 17:22:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/4] btrfs: use btrfs_raid_array[].ncopies in
 btrfs_num_copies()
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652428644.git.wqu@suse.com>
 <a51939d1e568f36135c8f0383a4f34da5bda0f4b.1652428644.git.wqu@suse.com>
 <PH0PR04MB7416E0CEDDA84965B0FDD2919BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416E0CEDDA84965B0FDD2919BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DsHdKq1jPslOMYEjUzWYD1rzCJ9/da8LKxgxj0pfaRyJy8yjEdB
 J7SDqanodgjjo5bvwWBvcsNgfAlSYcJsRGdqBDxMV72HX4QbdNBQDk4njnabbvwPctj/Tgq
 RDXUG1wSFUuXCHhc0+q+/zmFTor+piTJVqpNVGGwKW0Xu6yaPDtZbspLkfEDwtnbnaWLUEB
 /pVQysA9EBgklTVntSH6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GNTROSCuNks=:Lr8zU9WEokuj/+cRqsRRcv
 2V1nJr3zfPMvD24BkDExdod5WDtDX570hMwXr+ri9aKAeUU6nRujYr2evGtKZZ2bq0XjvXdHX
 BZvaWSCmQ65ldam3YVxQ6hqtNlC5Mv+t0s0Hh5CDewy/UHGLsI2Zh+mdZybpPWJ88EYvbR/dp
 57dOr98LvIaCyN+G7X0S/ixyKQk5Du6UnZJPbRje5SMIoSEqRbNw63SLoWnlOYnAjfQblmjqt
 pLW7QeuRGBBSvFB4XyWsu1VCPoUdf5cesSbDhOv8AWjp8JWoSH+iknXpZL1oG8scRh2BpYqdO
 bsCQF9ifzvrTzTG3GBuxrIP53UsWA7DOefZos4YjsVj/K7HwmwFeLef3OlqGca5/iSSvx6vUg
 7RE4Qny3CGP0XLiRD6Wkc1X6uN9YEEzueBJqZ7KIUW9W4Ye2GQ4xX/vKc7od8sHVLX/cI9y/Q
 H4UgPQKK18zGv+5EvFROkN7H1ElDgO1K3rLNwoEmbC9l1H9GMA8cqHn9LYHvbSco1ZbCjgsyX
 kp5ls3IZYCozzsUnDihhd5rrd7RczkCpbU8qgnKHhLnV6Oe0gEVAPImW6EXGr8rDAOx0nAoLW
 bvPxashIqcRlCTZID/V42Pdzvr5DGBRvDWqrDBB1LUOz0QUZzIMqaCnN12jPc/rDuHUKB+vPI
 baFa5b2joHbA2YLkAaCRqffprJGZQaNFvu7q8t5FeInUZfns1kLS/+ybAQl6xF3YxSwAtgIxJ
 Q9hKz9IeNj7B69PD4dB/oySi/o9hTZmwbnHkmewAE/rw6zWX3KBCr90UYvpOkL4E1bjED0Hw7
 vIwmXuWYOSBSSLyOgChRhHeVChMwGhiTUm39PXfckykqOSzI+I3kpJDImQ593MTtLFqjWMi9m
 Ah4NDb1L1zQHnwQrlPx2LcDy61wivuUnHV/5Jy1WRs4jY1XnSVCwY425SZ3VvgZMISvS/SRfd
 SR9da1qVVUQraCAHn7JUPwpTbkIFImSMV23H45lccpWdhpE3u89bWGkCN/yZ3aOzamOG2/0dS
 G1YLYBkp0+TUXHAneDuPlXil13S8aXpF3xdqVSGj+R3EHdwZ0IxmJGy4JaNQsKd8uLoVULJeV
 lwmjFznmlKN7/lnOrhrvuq8A0/ZYTqudwr/I9Bq/3jZh+kg0+K+7O0afw==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/13 17:15, Johannes Thumshirn wrote:
> On 13/05/2022 10:34, Qu Wenruo wrote:
>>   	map =3D em->map_lookup;
>> -	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1_MASK=
))
>> -		ret =3D map->num_stripes;
>> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)
>> -		ret =3D map->sub_stripes;
>> +	index =3D btrfs_bg_flags_to_raid_index(map->type);
>> +
>> +	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
>> +		/* Non-raid56, use their ncopies from btrfs_raid_array[]. */
>> +		ret =3D btrfs_raid_array[index].ncopies;
>>   	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
>>   		ret =3D 2;
>>   	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
>
> Here I'm not 100% sure. RAID10 used sub_stripes and now it's using ncopi=
es.
> The code still produces the same result, as for RAID10 ncopies =3D=3D su=
b_stripes,
> but semantically it's different (I think).

Since the objective of the code is the get the number of mirrors for the
chunk, sub_stripes is definitely not correct here.

Just imagine if we have RAID1C30 (sounds ugly I know), which is RAID1C3
first, then RAID0.

We should still have sub_stripes =3D=3D 2, but ncopies =3D=3D 3.

And the number of mirrors is definitely 3, not 2.

So it's the old code not correctly semantically.

Thanks,
Qu
