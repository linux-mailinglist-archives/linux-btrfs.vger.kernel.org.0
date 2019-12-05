Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D06113CCD
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 09:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfLEIIJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 03:08:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:36241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfLEIII (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 03:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575533287;
        bh=Znb+scr0vrlkQpywEUbQdV7FgJ+5jDzbcdNm7zE6KPg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=alKU+5xkBfbc0cs3y+yQfKuoKyRBJoQjfGK5DYT4SBm4MlE1hwwNqyILkdJBYA7X9
         snMCR2bcyqlFxBQ70eVRc4wTd8YJ2oq3YOTP4QH0Dm60cQ573/IqdEXSxoQcnFhw/+
         N6pg46g+9WCn3/dcktthpjl4diI2GnXsG1S8Dcvo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.169] ([34.92.246.95]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbivM-1i2srj35ZO-00dFpR; Thu, 05
 Dec 2019 09:08:06 +0100
Subject: Re: [PATCH 04/10] btrfs-progs: reform the function
 block_group_cache_tree_search()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-5-Damenly_Su@gmx.com>
 <d491f547-626d-c974-8e70-9e39815a7dab@gmx.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <f5017974-afcd-693a-1aa0-148292e7a283@gmx.com>
Date:   Thu, 5 Dec 2019 16:08:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <d491f547-626d-c974-8e70-9e39815a7dab@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wU3N3yZ7n9oBILu6wEIqWCZrKKy9ZuLR6Uk8pXVeUZ9Z5c2HbN+
 16eUxEQQfv7eReuJq6Tlj5dANvYdTziUvtqZCVOmdgZh47GYnycUPtcdzWAewhHp+/0UzeR
 rFF3rhsIsuc3JBlZ00XxNIoXwUkXZKLw3+sdvlhsN+BrszJ6qugbc/Py4ghKp+ayWTgq595
 DXeO1uOBKIC8M2W9CfGmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Hk48NkPJUM=:urCI+IfUWoPYeIo6ie9alp
 1mdpbtZ7RqM0PkZXImJpHRSq63nnJTYuWYvlh9kU3obFlBWTi5m7MEusr+v6BIJTFLYgFs385
 Q/lsMd6SGjaHv1GK95FJQeyFsVh882PNWUOClThRMNg69+L4UfNF2QuAoDvAu5bHtgqBBqE/S
 PFNpNAlMjyNg0qBmpeKwScnGMwftjjslRTHyWz0zayeNmeMXNd63+8R9LK5TkM8mmdEVf4Nd5
 HseA0b4ZctkvCcAWo4wzhcu9lNgxr311ddQTjyPc3GM0cQQjl+d6FCGggBJFOo7+SemcCQm7k
 SMKSMJ+Kx7Euxs6PYuH5eJJn/UJTWI6lchgm0JNXz3SRFyCWX4QkV6AlDKnAbDte41bK2J/4z
 ksA0gckZeW9sYKxm9T9r2nWdwkczMMqKBVeQRv7yeUxiobi3CGJB/dBR07gDJ2Y5+SHBpHEzG
 lYGq4t1uDMLVQSJ6cM3rU5ZU7oZp2eJK7uhUy7tJKUToPswUeNiZ7d0VlIzqnXggA20Fs/p9d
 8isbKF3iaa2bhS3C2PDN/Bx4VrvmaMsr6fzsbXlQf7BxE66wHGfajpvccVVQkeLv+Jyawqpuv
 ie3xKygcaKhO0aLVlo+qzu4ipW6QMkMTbFnXjb5jj4mw6oFYVmj6iedrKGdGU8aooxshGeRuI
 DalHjA3pFCUHFhVoJEz+tBvjB1tM9QlDkvCSmgJzx0rbaouyyXOvAP8Md4UZ3LBO2ICCocJZ4
 p1FFJHLo7ymugI0SaH/9mZ95DyBd3EGBcKRGRZqy3M8SdK8HuprEE3aJvLqI8lWGFkyG8kaG7
 jRL2UYn2jZiKYDJLgGdiubQh2IOY6oqaSKMZuf9QS+0yZwbAxGyRvMIADhhi6v0IUs5rhpDij
 QObu02dRUTt+9apOtXYphIIwCgYY82Jn45qcK70kImSwrLv/48vme7Kz+jr55vnGaOCAGlaAs
 CtZPXiP6KfI8AFbtxT93/S6o8ga1YKc9gvypjys64Gdg+U71q7wqngE/NZGUbzUwd48JFSI0n
 OEvS+AApj0JPN1L0x0uj9T/FT/zqECJs9XK0hKEZvFlotdxvBJY1Q5G6gfNAIdCg0eWBg0jCd
 BZfLWBTKF5y+jtfqskdicVIfdbI0OOQRVIdMkUNmtfoP/oJKh/BibPjuJAzRbxPCBd2H+HJNw
 Fuc4mMiQPhpSkb1YxQi4MwsLG4iih4rjZsHmQndEA8atP30B2XgYjxUwsBhiq4O0uspxWAHnb
 K/hzMdd2Z9MSKUv4drdHKgQDSEgQD1dQoyag2R80WeTzl7y68VoHnaEY/XfM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/5 3:38 PM, Qu Wenruo wrote:
>
>
> On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> Add the new value 2 of @contains in block_group_cache_tree_search().
>> The new values means the function will return the block group that
>> contains bytenr, otherwise return the next one that starts after
>> @bytenr. Will be used in later commit.
>>
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>> ---
>>   extent-tree.c | 20 +++++++++++++++-----
>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/extent-tree.c b/extent-tree.c
>> index ab576f8732a2..1d8535049eaf 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -196,13 +196,16 @@ static int btrfs_add_block_group_cache(struct btr=
fs_fs_info *info,
>>   }
>>
>>   /*
>> - * This will return the block group at or after bytenr if contains is =
0, else
>> - * it will return the block group that contains the bytenr
>> + * @contains:
>> + *   if 0, return the block group at or after bytenr if contains is 0.
>> + *   if 1, return the block group that contains the bytenr.
>> + *   if 2, return the block group that contains bytenr, otherwise retu=
rn the
>> + *     next one that starts after @bytenr.
>
> Thats a creative solution, good job on that.
>
> However since contains is no longer just simple 1 or 0, it's better to
> enum to define the behavior, other than using the immediate numbers.

Nice suggestion, will do.
>
>>    */
>>   static struct btrfs_block_group_cache *block_group_cache_tree_search(
>>   		struct btrfs_fs_info *info, u64 bytenr, int contains)
>>   {
>> -	struct btrfs_block_group_cache *cache, *ret =3D NULL;
>> +	struct btrfs_block_group_cache *cache, *ret =3D NULL, *tmp =3D NULL;
>>   	struct rb_node *n;
>>   	u64 end, start;
>>
>> @@ -215,8 +218,8 @@ static struct btrfs_block_group_cache *block_group_=
cache_tree_search(
>>   		start =3D cache->key.objectid;
>>
>>   		if (bytenr < start) {
>> -			if (!contains && (!ret || start < ret->key.objectid))
>> -				ret =3D cache;
>> +			if (!tmp || start < tmp->key.objectid)
>> +				tmp =3D cache;
>
> This doesn't look correct.
>
> I was expecting something based on last found node, other than doing
> something strange in the rb-tree iteration code.
>
> At least this breaks readability. It would be much better to handle this
> after the rb tree while loop.
> Spent much brain power on this trick, this line means we always keep the
next block block to @bytenr. The original code stores the block group
cache in the @ret, which here I do is to store it into @tmp.

This method doesn't change efficiency only little memory copies.
If put the logic after the whole loop, I'm afraid it will require more
code lines and lower the search efficiency.

Thanks
> Thanks,
> Qu
>>   			n =3D n->rb_left;
>>   		} else if (bytenr > start) {
>>   			if (contains && bytenr <=3D end) {
>> @@ -229,6 +232,13 @@ static struct btrfs_block_group_cache *block_group=
_cache_tree_search(
>>   			break;
>>   		}
>>   	}
>> +
>> +	/*
>> +	 * If ret is NULL, means not found any block group cotanins @bytenr.
>> +	 * So just except the case that cotanins equals 1.
>> +	 */
>> +	if (!ret && contains !=3D 1)
>> +		ret =3D tmp;
>>   	return ret;
>>   }
>>
>>
>
