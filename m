Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5AF3E8AEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 09:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhHKHSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 03:18:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:50389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235109AbhHKHSO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 03:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628666269;
        bh=FwlambmX4QXbERhLWuODgRpGnNhI/DHYlHRXP71n0QY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Rdvtxw3tO8H/DDHZjBwyaEfoY8TeqDl9pZHuKI8xgAkRWdmBlCe7IM5HOPM+qyxfx
         SyQm3milu4z5qJPacqpalRJ81HE8+35gl48mu+/fWZt45MlkDK1h1qZ53jX5Yn5Qus
         cN2zC9m25YAbRyrgKlyhzrUxEe02fsAgLAKXFk4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0G1n-1n0Rf135OB-00xJyj; Wed, 11
 Aug 2021 09:17:49 +0200
Subject: Re: [PATCH] btrfs-progs: map-logical: handle corrupted fs better
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210810235445.44567-1-wqu@suse.com>
 <a9c908a2-ada5-24ab-dc01-ebd686294000@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <40072166-1fa6-33f0-ebad-b47e4c08b633@gmx.com>
Date:   Wed, 11 Aug 2021 15:17:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a9c908a2-ada5-24ab-dc01-ebd686294000@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HM1Iti7cPrNji4WkXcxGSCrC+F14efBW2XQtcLpCkYc3jsrZ6u9
 PKbNimObOfxiVyv18sNheodJuNcZz8AkAS7ZqjHWO4ZE558qkjgcGXSm3XixBBMsI6RJY9m
 7cpfTam+4uAjYDLxMqB9ivjUwoVrtp6u8b4mQjb8oTXlTbbhM1unTpozWMvHEb4ncv9mh3F
 WcjDNil2M/npTGUiYyoFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y9qsIDiGwnQ=:FzThZiSl3WxiDR38z//4SH
 KwykiYSAC2Tkg8/bvKgzW8itSJGWAq4kWqnyxw/sOvppQpwVs+ZZYu9v5Q7JF43hMjg8PBk21
 kGuK8fFYt82dbea3BXX93rgkx6civhqPQTP1f0sDOX7/sco9uxXv1b/t8KVabLirhGIddjheO
 9qQJR9aGYptlKiGlz37hQnP3O+62j8yc06oZ6s4MJMSo+mCfn9kkXb9stpw9l9Qsjm7GB+Mqf
 z+511ZusJEbnm7/BJ2h4vD00XTrwVcUV+LyNMjm+QL8BK8bghzLKMLcJ+aXbe49tmHfsd5MqP
 FfgN//wKFV/NJlwsYBu7B6jqit0PEZgupiiQ9JRo6g2cyvBpippqeqEFFHQlyxJczb4lU/+Hx
 i3ea3EDY5qbR53PUsq1pNsyiCSWfbG6Ajh8jDJIs4TwYoe524HdSr+uYNsxoCO2WsZk+T6/Gz
 J2s3/MFdwq0LSjATMtCRyfCjPCKyI7kUm0f1bkYrk2Y/6mIb6XNVb2hVQo0YaK2evIVy74moQ
 hiNDu5ETRnu8WaeSabvggaMFAUNuPzlUbFeGvb1ehJQipTtfqMwK26lbK+dN+/CFuh4TSccIx
 AcEoGrZV4rJc8IUb88jmwd5tUU/K8G6BTLc4R/McRHKm3JwZXw2PtXM95MRfIEXYzM7fXNHQJ
 NC0RY4FwgnlbWQDKlHsvQvxYpTppHT4RSKrT3UWO5EbGnRjP1eQczRrYAUmOgGw+GDOpe9+bn
 KXTjFzWFWdodKxnUuIDU2vW9M1RZXbb+dt2ii4d8U6iSLg3KpaquIoK1y7kyo3r1SwA+5tnfv
 15K+9Epf4eHXsOnUEyYHzBRnAFxsKPOpHpRFtVKqS1YnPbt88W4d4Cvz72mv4LOM6OapMRPei
 OqEJtnXPCOeNHOCrx1CczMCXPxAZksamGH6c3CB52py1eijtxgsyFdTRg8kKr+Eb7wx/5FeX0
 20BlLGmsdp2l4AMB4gmuFS6Xln57XFbiWE/oER2iFdyFVwMgG6Pn/WAWmWYOLopS/bVcL+OCb
 CLXynLJhOmKLP4tDSkHKD4f0ukCsC6Px04inLtmwv5Cd4vQyyPpTnXKOpjSVJ+Tfh/a5fuhb/
 z2OqU30/Zrl45oZ4pyVKuTNiaYfRzicir+a7QGMcAlRs930I7snCQowCA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/11 =E4=B8=8B=E5=8D=883:03, Nikolay Borisov wrote:
>
>
> On 11.08.21 =D0=B3. 2:54, Qu Wenruo wrote:
>> Currently if running btrfs-map-logical on a filesystem with corrupted
>> extent tree, it will fail due to open_ctree() error.
>>
>> But the truth is, btrfs-map-logical only requires chunk tree to do
>> logical bytenr mapping.
>>
>> Make btrfs-map-logical more robust by:
>>
>> - Loosen the open_ctree() requirement
>>    Now it doesn't require an extent tree to work.
>>
>> - Don't return error for map_one_extent()
>>    Function map_one_extent() is too lookup extent tree to ensure there =
is
>>    at least one extent for the range we're looking for.
>>
>>    But since now we don't require extent tree at all, there is no hard
>>    requirement for that function.
>>    Thus here we change it to return void, and only do the check when
>>    possible.
>>
>> Now btrfs-map-logical can work on a filesystem with corrupted extent
>> tree.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   btrfs-map-logical.c | 50 +++++++++++---------------------------------=
-
>>   1 file changed, 12 insertions(+), 38 deletions(-)
>>
>> diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
>> index b35677730374..f06a612f6c14 100644
>> --- a/btrfs-map-logical.c
>> +++ b/btrfs-map-logical.c
>> @@ -38,8 +38,8 @@
>>    * */
>>   static FILE *info_file;
>>
>> -static int map_one_extent(struct btrfs_fs_info *fs_info,
>> -			  u64 *logical_ret, u64 *len_ret, int search_forward)
>> +static void map_one_extent(struct btrfs_fs_info *fs_info,
>> +			   u64 *logical_ret, u64 *len_ret, int search_forward)
>>   {
>>   	struct btrfs_path *path;
>>   	struct btrfs_key key;
>> @@ -52,7 +52,7 @@ static int map_one_extent(struct btrfs_fs_info *fs_in=
fo,
>>
>>   	path =3D btrfs_alloc_path();
>>   	if (!path)
>> -		return -ENOMEM;
>> +		return;
>>
>>   	key.objectid =3D logical;
>>   	key.type =3D 0;
>> @@ -94,7 +94,11 @@ out:
>>   		if (len_ret)
>>   			*len_ret =3D len;
>>   	}
>> -	return ret;
>> +	/*
>> +	 * Ignore any error for extent item lookup, it can be corrupted
>> +	 * extent tree or whatever. In that case, just ignore the
>> +	 * extent item lookup and reset @ret to 0.
>> +	 */
>>   }
>>
>>   static int __print_mapping_info(struct btrfs_fs_info *fs_info, u64 lo=
gical,
>> @@ -261,7 +265,8 @@ int main(int argc, char **argv)
>>   	radix_tree_init();
>>   	cache_tree_init(&root_cache);
>>
>> -	root =3D open_ctree(dev, 0, 0);
>> +	root =3D open_ctree(dev, 0, OPEN_CTREE_PARTIAL |
>> +				  OPEN_CTREE_NO_BLOCK_GROUPS);
>>   	if (!root) {
>>   		fprintf(stderr, "Open ctree failed\n");
>>   		free(output_file);
>> @@ -293,34 +298,7 @@ int main(int argc, char **argv)
>>   	cur_len =3D bytes;
>>
>>   	/* First find the nearest extent */
>> -	ret =3D map_one_extent(root->fs_info, &cur_logical, &cur_len, 0);
>> -	if (ret < 0) {
>> -		errno =3D -ret;
>> -		fprintf(stderr, "Failed to find extent at [%llu,%llu): %m\n",
>> -			cur_logical, cur_logical + cur_len);
>> -		goto out_close_fd;
>> -	}
>> -	/*
>> -	 * Normally, search backward should be OK, but for special case like
>> -	 * given logical is quite small where no extents are before it,
>> -	 * we need to search forward.
>> -	 */
>> -	if (ret > 0) {
>> -		ret =3D map_one_extent(root->fs_info, &cur_logical, &cur_len, 1);
>> -		if (ret < 0) {
>> -			errno =3D -ret;
>> -			fprintf(stderr,
>> -				"Failed to find extent at [%llu,%llu): %m\n",
>> -				cur_logical, cur_logical + cur_len);
>> -			goto out_close_fd;
>> -		}
>> -		if (ret > 0) {
>> -			fprintf(stderr,
>> -				"Failed to find any extent at [%llu,%llu)\n",
>> -				cur_logical, cur_logical + cur_len);
>> -			goto out_close_fd;
>> -		}
>> -	}
>> +	map_one_extent(root->fs_info, &cur_logical, &cur_len, 0);
>
>
> You essentially make map_one_extent fail silently in this case how can
> the call to it be reliable at all? Shouldn't it be removed altogether?
> alternatively, the function can be made to return an error, yet it
> should be up to the caller to choose to ignore it. Also if the tree is
> corrupted what pervents for the btrfs_search_slot in map_one_extent to
> return 0 which will trigger a BUG_ON ?

For corrupted extent tree root, open_ctree() in btrfs-progs will
populate the root node with an empty leaf.

That's why the BUG_ON() will never trigger, as in such case,
btrfs_search_slot() will return 1 other than -EIO.

>
>
> Furthermore with map_one_extent present the semantics of the program is
> that it prints the logical mapping of the real extent rather then the
> passed in bytes. Because the user is allowed to pass an offset for which
> there isn't a real extent. So if we want to retain this your change is a
> no-go.

The change just makes the extent item lookup an optional operation.

If by somehow we failed to lookup the extent item, we just continue with
the values passed-in, no longer to verify whether there is an extent.

This is especially important for fs with corrupted extent tree.

> OTOH if we want to have btrfs_map_logical to serve as a simple
> calculation aid i.e you pass in some logical byte, irrespective whether
> it contains a real extent or not, and have the program return what the
> physical mapping is then map_one_extent becomes redundant altogether.

Yeah, I was also thinking about that, but not sure if we should
completely remove map_one_extent().

Thus I took the middle land by rendering it optional.

But if that's the way to go, I can't be more happier as that greatly
simplify the workflow of btrfs-map-logical.

Thanks,
Qu

>
> <snip>
>
