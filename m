Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187D72D5B03
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 13:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgLJMzf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 07:55:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:32893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387752AbgLJMzW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 07:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607604823;
        bh=UwcNqCMAvPQOYt8vb47at5tPZ57mHrOfPNHyHZS5/4A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MIgM82b8c326cNMB1FHbOypJnuw1n5YdG1Q4kMtYNFo88p3Od1npADwu2KrKA6SEf
         n2KX6K2axHb+wgyohUSYlRk1FYw1n9zbXSIpVEmUSyuDL+uJmlyRxqSQ/ygRf7r39b
         3AvjnrtyUWoZHGMMbzpMk9uVankQLZibMh9VdMaE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2Dx8-1k8Kev0WA2-013hI4; Thu, 10
 Dec 2020 13:53:43 +0100
Subject: Re: [PATCH v2 02/18] btrfs: extent_io: refactor
 __extent_writepage_io() to improve readability
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-3-wqu@suse.com>
 <bfc95ea9-ea16-6530-5025-babfcf67fe9f@suse.com>
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
Message-ID: <aaa02751-9648-4d10-7bbe-11fcea0f608a@gmx.com>
Date:   Thu, 10 Dec 2020 20:53:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bfc95ea9-ea16-6530-5025-babfcf67fe9f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VjaQ5nhzInVuiJd8IV5UpNK5cffBEAg3hXRUXbqDKyoQfM1GXAK
 ndncpMCqDQRWb/xF7x4xB44TUgjtIt5dBUUsHYf4Mc5PhAmsfxKhFupoZN0maE+GBga4EqA
 uYBp8ZY8+XlgX/R4OVmkBR0bWnEU6ftkKPlf1y08ITuTg2e/8MryMUuTdsC9VJoM04ySeXG
 SBZEux78fQU/T7UaoEZoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F60qz2lFacE=:21EHF7AGOh4uJPzvFuZrBy
 8a4VZYi6Pui9mz4zoHd3TurhjJG73E73JBvU/SWzeGD/idOVQbuqgQf0AXp9i0kLsGHKRfD3/
 KpyNWagmnjCMRJ2FlLG9YgmH3UAC4sW6BJrJ1Ff56bqOxb1dUL4xw7oHjiDnNkKSVaxh7Eh0s
 jX3/RuDFq1v+Px050d01B60qHIg7EyFWe4wq3olySzaMvT/TskePpP5OrDxkKs9XCrTE2V6ew
 H/x7ZYCm7DVNgmU+c/eRptYkWugS67EhQE19ufRlKEB7YG+/1fPuE/NfVxxY67pgXUiHBRfz4
 0tJG8RIAFcIwJ+L1+VB10DWPw+DV2QXyNygOeaRKob9U0ud0+d6W1ZQJxjj0ibXF3qupjlHH+
 kqsjehQPSllD75Eq6ZtcrTX+5ZEQqihMuKeoCr0PCtVbKAx53t3T6hJRWCZelZ7WVsvg0cYPm
 r9HF5fxwzszQr0wFtq8q8MjMaYYml7wxMTQ0+e+D5dJ21RXKIlwK06ygY91Z7qAsNVkhfJOo8
 j59Hg6IKWn1Yg9gzng7Q6a302ksgsa4mmGhvS2u2H/OXPkcWypIkdQ8qI9aD7OV0QP/8SDg+f
 cdj0GtzTgYJppz/7BEQByHXIFOYlD0MC0tzAnkZJyfh7GXWglZU3Khy6a62AHVU5eEPlirCFh
 TUn1uaFNBqy3ewRw+nMS/tO4Opx0vv9Ptek/eXZxg7uABCkgUL/3ib20Bjn5AapihUfkTQWSh
 rFZb6xR9edKi3CwCwHF165BN58rrFnLBrT8djmeoPXyqIpGw332Rla9Te7qCE1YBY5LRZAQRO
 AMryFegoaM3hPvhaTPZiYxt0k5pdm0vcOeetP6Qny95hQoU8N+L0+P0omR76xBKPYvy2pF49i
 RPdGXF6GPwPwic3ActcQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/10 =E4=B8=8B=E5=8D=888:12, Nikolay Borisov wrote:
>
>
> On 10.12.20 =D0=B3. 8:38 =D1=87., Qu Wenruo wrote:
>> The refactor involves the following modifications:
>> - iosize alignment
>>   In fact we don't really need to manually do alignment at all.
>>   All extent maps should already be aligned, thus basic ASSERT() check
>>   would be enough.
>>
>> - redundant variables
>>   We have extra variable like blocksize/pg_offset/end.
>>   They are all unnecessary.
>>
>>   @blocksize can be replaced by sectorsize size directly, and it's only
>>   used to verify the em start/size is aligned.
>>
>>   @pg_offset can be easily calculated using @cur and page_offset(page).
>>
>>   @end is just assigned to @page_end and never modified, use @page_end
>>   to replace it.
>>
>> - remove some BUG_ON()s
>>   The BUG_ON()s are for extent map, which we have tree-checker to check
>>   on-disk extent data item and runtime check.
>>   ASSERT() should be enough.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 37 +++++++++++++++++--------------------
>>  1 file changed, 17 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 2650e8720394..612fe60b367e 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3515,17 +3515,14 @@ static noinline_for_stack int __extent_writepag=
e_io(struct btrfs_inode *inode,
>>  				 unsigned long nr_written,
>>  				 int *nr_ret)
>>  {
>> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>  	struct extent_io_tree *tree =3D &inode->io_tree;
>>  	u64 start =3D page_offset(page);
>>  	u64 page_end =3D start + PAGE_SIZE - 1;
>
> nit: page_end should be renamed to end because start now points to the
> logical logical byte offset, i.e having "page" in the name is misleading=
.

But page_offset() along page_end is still logical bytenr, thus I didn't
see much confusion here...

Thanks,
Qu
>
> <snip>
>
