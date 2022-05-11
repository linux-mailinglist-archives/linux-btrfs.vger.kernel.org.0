Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486D7522CD2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbiEKHGi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 03:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiEKHGg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 03:06:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A339BB5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652252784;
        bh=fDW0sDx3HMQK3LLZt6wcXWs34L2j8t6dRi7O3Bu2LBc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EUI8cM8X1/+nsUQffxLmBtfJ6pj5chpyANY3A4CLt3soxGM6k068Df9F19hJTJxOG
         aordAhodeBeUReNngh6WtF/AJRcTUgMr4+acQPklOvzDWZfhJ49m/QB10IQFxfVSXh
         dCV3QYsxaVyoNcqOxv6MLZJBYFliDu2XnRqWLSM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzyJ-1oM6u70RwN-00dSWc; Wed, 11
 May 2022 09:06:24 +0200
Message-ID: <10c9170d-41e0-2a20-ecee-e37e96d0fa61@gmx.com>
Date:   Wed, 11 May 2022 15:06:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/1] btrfs: simplify lookup_data_extent()
Content-Language: en-US
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Marek Behun <marek.behun@nic.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
References: <20220510194338.24881-1-heinrich.schuchardt@canonical.com>
 <ebc77987-0212-1623-245d-8c79cba5fa80@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ebc77987-0212-1623-245d-8c79cba5fa80@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FVFpjeWIj02rfte3AwPpxQVMEr++2MXGe/Cz9KAPSxBxbRWvwZv
 i/fOJ1vjk5IyvrDT5ayK9nqgK82QtlU4nGznI5bEm7+jqth/U4ZxJfN0nlwH7SfpWQ4vxN4
 RaUoMew/2rA4HAerEo5NKQAXx8X9Dhs8CkK7bIJQ9v5UczQijlR7BH1KDy8be2AybslskhD
 vdeip8zot/z48eaBfn9Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oe8CWxbpKuw=:mRmANlVAaKqzAgWc5g4ngy
 839+BjxA9vBfX4ORYYzHj6EhucRB9W3xT1Hdpfo7X0r04xQKspHfQX76LOOK9iKuWOxTjEk0m
 GAPWc72jxaC9dfFbOXFdxaZkFlMnsZBjPW6pjfEbJRcgteCJYCjyT0is2MmrB6pPlmv2M7f11
 a7pYRnrBS2naY0BEBPKtUDv8Tjpfi5np5bZ1ODrDOgvM7FzgsyWJ2I8s+9JH0r8afF6ciAVl1
 47PwzXNPhCY3QTUrT9h3RVnPmbZNJgZx6GP3Ww0uk6w0egG7n/9ITABXliDvaEAv8nyEzAx6n
 JeZk8VIUzxsX6gh1d3Yqti1rSmAIjx67xryVReobFlfw+DtrmD3McXDQ8W40UOkq4nr+TyDjb
 SJ4AD9BYnCvZWkp0fGzB673UpM9coaBEkAZ/dROT/LEIhBssNRHOhIL6ib37DNBcnEVB0knlK
 aNsNB5vThKlfMQjB6l0wNhz/ooZTo26Mjk+tkNguQn+0HW3CCZ+eByO/HYN3C89jrmzlxM1ot
 oK3K8U1RbZOAmkHVUCLS5b75VLM/9bP7boLo/5bLU26w0AXOHEmeuR+g3lv979THzsmsaP9Dr
 UGB06AXoY30jITn6T3lWnFgR2YjaE2pPdr9QJJ3Xv1hyl/Hdf0Dsm3KNRy44o/t2R+w1hiZEB
 IHGbxnRwzcg0ONe1CXGwfVoe7J+1fWcgJpOtU3B+OKzSFjjh8/ZZNP+m5S0TNBZPKwXqkMUGk
 EATlgoUDtt6tuocqWEKkYWaBjuC81uaHpN2nLd/RYTdXgP3wuSteU4ildgNAHayDVv9KtOEe5
 jvQ283lXPBDsKB8ko2RlHrGmfLT1DCg9EmMmon+ZYVLZtCtidKBoxF8mSdC95VF+TPuKc6z/c
 L1f5Q0Bs/ABXcKPA3m64zZ9ONHgUMM3vSp6UO1VyncGLUcMtjnALHIAams53jdsrwmmpRFwTR
 NknKBjnqbGd2vaNbgqPzsnuFS/3LTP+l855Pa/FGMXHQSVOV0h7exQJ+hwMmoXfWJ8PQSALah
 vcaKWVUdSqgxtK6Gc/jL8nvU0Qhp5mrQG1Mwt38bqoR9kO30eeqnX5EfNt8IHrJ0Mo4ymOffy
 j1GpisqcttMmc6oR81eiDxGJd/9nw7yCHxI2k3AoDNFuPzzG9PcYx5+dA==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/11 06:48, Qu Wenruo wrote:
>
>
> On 2022/5/11 03:43, Heinrich Schuchardt wrote:
>> After returning if ret <=3D 0 we know that ret > 0. No need to check it=
.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Just to mention for other guys in the btrfs list, this patch is for
U-boot btrfs implementation.

And I also checked btrfs-fuse project, which has a similar function,
lookup_file_extent(), it already does the check properly and even do
extra quick exit for (ret > 0 && path->slots[0] =3D=3D 0) case.

So you may want to also check btrfs-fuse project to find some possible
optimization and cross-port to U-boot.
(So far btrfs-fuse has better test coverage using fsstress, and
cross-checked against kernel).

Thanks,
Qu
>
> Thanks,
> Qu
>> ---
>> =C2=A0 fs/btrfs/inode.c | 15 ++++++---------
>> =C2=A0 1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index d00b515333..0173d30cd8 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -546,15 +546,12 @@ static int lookup_data_extent(struct btrfs_root
>> *root, struct btrfs_path *path,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Error or we're already at the file ex=
tent */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret <=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> -=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check previous file exte=
nt */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_previous_item=
(root, path, ino,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_EXTENT_DAT=
A_KEY);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn ret;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o check_next;
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* Check previous file extent */
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_previous_item(root, path, ino, BTRFS_=
EXTENT_DATA_KEY);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 if (ret > 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto check_next;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Now the key.offset must be smaller th=
an @file_offset */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(path->nodes[0], &k=
ey, path->slots[0]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.objectid !=3D ino ||
