Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184B26A2B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIOKGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 06:06:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:40743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOKGW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 06:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600164379;
        bh=XKFsOhU3zGjcJrBOjjUEc/jWofk3BEKHJQi2dicJ1x4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KFyu9Zmmj9rodqPqmpojfzS3WBDuWOR0oLvcYJ7KfdeMXIuVcFf9vuAC31OOh+7Yv
         hQ/7Lh8UElawj33uSQcC2sUrrp3jba0jT/6XeXdQ2lUS6ArL66lgu/lWKgVJaIQQjA
         83ujY9nllCMO+89ilAikWdPtch8FsSlNRtwVj0Mw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1k2FQb0bqQ-00JMeH; Tue, 15
 Sep 2020 12:06:19 +0200
Subject: Re: [PATCH v2 06/19] btrfs: don't allow tree block to cross page
 boundary for subpage support
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-7-wqu@suse.com>
 <d24a14cd-b708-195e-68d2-94934b024625@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <52001ac7-61cf-81d5-25d1-9c9e98f97720@gmx.com>
Date:   Tue, 15 Sep 2020 18:06:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d24a14cd-b708-195e-68d2-94934b024625@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:syoiEvmUcI+0W85qFjyILscA13JGNRN+Go5wqgf7JR8QlRQJzfK
 XvKloCGLjrSjXUWL8v61gbWWpEkcT7P7pin4KCDbntttcy+HDWtsUoVCCKgnLA15dj74yTr
 QsHiOn9lxP0S+A9Gc2KpleCMEIop08/rrXefVaeKjTjK5pAPytv4nDznCc46TOEmR5AEkMN
 KGQr2ZkdOpQtoxb2SAvwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:luwOdna1t8I=:9U4itNBYN2UMiJHSL4sb9R
 DTtUjhkNjBej0R/VDLV5KlTgn3KNWTyC91T/mFfzhEjXL0xZUQ8FBd8Eo404b3JXInEmPVTRS
 jJCAAViiuAi+FHe/7gaj1JB4ISRn8Qe7Xt5vssIje/OR2J3wXe9Lyif5wiW2qVaE8Rfg0RJGn
 xpMQ1/vQHQBcOOLOZdDijL6TbxIXpIva9lSJLl205RZiSIvSPlGOQy6uTWCbQbSs0eYf5broy
 kLzCQo9U+mPRviX3en4qJvv+pcUySzImRhGyk1IshYMfwxiZX7nA6W9jz2jnkafFi1XDJ+PMv
 W9+zl/N5hyl6zVu6wMv8uhbiENUYqhHfDzES2y4Vk7cKuhVqDwxzcwZLxHzBHXyxTKFfYs+wB
 OTOigvs3zIcZYpevIGro2Ae4ZA8cTwtCFKKylYpjecZ+2xBKeiWtXx5xOwSiHhSdxgS8kQSxS
 9hFvYnkCcsn/cv5IieUn7t22W5qlqI4GGsETmdKmSahBTCnUFscSQny+rh8WfwTGIyCb8Qd+7
 nm6Fq2CJQaE9Yn/tlsOhOkRJ2/fWc/3xvbyVEwCdRzWBhruPH58TmwKl+rMBqAWi95mJ/vTgT
 EJhJ9kLhbty0csGSA/jKlHdWkE+ebQd0LMjWN7oOeNvJcTYYCLi3pb4IvgvzGZZgwlxzwnf7u
 EuGxkepucmGtQduAgR3HrSYSSfd7nucHmyar+TT4MNPVGeQUGtAY3M1bgDNHY+GmoXTRNel3h
 gmxWxqGGt9sNH02gDXv1MqwKcdsNUamPcTFjUbrbKVA62cWnxxoc5H25lEsrTrwf1FpSa/EpH
 TkvQMkRTFzUfvVgQk5qUhKeDrzbIq83sBtm48JpfrAQlCWQqFQ6405Q6cjMrkfQtxuG2JZVhm
 Ihi0DAI1hgWLgx0g2KwPG8i8wnv+rRB/otaNf14tMdDeAdyJ5Y5T9lpIECvhlr2wtoipWDbBm
 ZmE+qXLJ4yl0OA0ORnv54UdXAsLqoVQgMDTIZZ6wrQVEgBilxREpKfWmd+B7Rd5i7mApwAjx4
 R+Fd8UChRoGu/mIqCgDnyQoTh41Suw74jR8nLMSaGJ5mnlaUMEggmjh6BMrRUo92y7uk7jyda
 M3sY/FogzVTdU8LADI22M/LBbq7duj19UPspR8S+/8yfcx5LJ5BK7eONOhXxHNLkzBI2LOEmk
 FPWtOCBz2/evLfGjZxFfH3/jn0UONg8D+WwGc3eqtVOeBiLtSFAXp7uySVGxsTVHN+cZErmoY
 0tNoy1wfyt6LUaAO4B8RO3Npx7E65lcY9jf+YDg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/15 =E4=B8=8B=E5=8D=884:37, Nikolay Borisov wrote:
>
>
> On 15.09.20 =D0=B3. 8:35 =D1=87., Qu Wenruo wrote:
>> As a preparation for subpage sector size support (allowing filesystem
>> with sector size smaller than page size to be mounted) if the sector
>> size is smaller than page size, we don't allow tree block to be read if
>> it cross 64K(*) boundary.
>>
>> The 64K is selected because:
>> - We are only going to support 64K page size for subpage
>
> What does "only support 64k page size for subpage" ?

That means, we only support 64K page size system to mount sector size
smaller than page size.

Or to be more specific, we only support 64K page size system to mount 4K
sector size fs.

Thanks,
Qu
>
>> - 64K is also the max node size btrfs supports
>>
>> This ensures that, tree blocks are always contained in one page for a
>> system with 64K page size, which can greatly simplify the handling.
>>
>> Or we need to do complex multi-page handling for tree blocks.
>>
>> Currently the only way to create such tree blocks crossing 64K boundary
>> is by btrfs-convert, which will get fixed soon and doesn't get
>> wide-spread usage.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index e56aa68cd9fe..9af972999a09 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5232,6 +5232,13 @@ struct extent_buffer *alloc_extent_buffer(struct=
 btrfs_fs_info *fs_info,
>>  		btrfs_err(fs_info, "bad tree block start %llu", start);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>> +	if (fs_info->sectorsize < PAGE_SIZE && round_down(start, PAGE_SIZE) !=
=3D
>> +	    round_down(start + len - 1, PAGE_SIZE)) {
>> +		btrfs_err(fs_info,
>> +		"tree block crosses page boundary, start %llu nodesize %lu",
>> +			  start, len);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>>
>>  	eb =3D find_extent_buffer(fs_info, start);
>>  	if (eb)
>>
