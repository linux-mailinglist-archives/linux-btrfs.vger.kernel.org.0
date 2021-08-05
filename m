Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D584A3E1E8C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 00:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhHEWXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 18:23:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:37295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHEWXY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Aug 2021 18:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628202186;
        bh=dgFFihww+I3BhiqvNrZpspA4Q3lFwTJm5lOVs09tjHk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Kepvfco5s1SpvqztLCOxlYUbYBncCbgbgvaWXUwGneqAeAqzEmvDyg4sJJj2ww+DU
         3c5EjFjRGtn/JsV8G1yYDruE3s2C/DtwmmeVXJrOx6ISGLVi6PXVNPUWdYc1sQW5/r
         BvFgFnCys0LF/OcXrlnRLKGCDl+6eujCTiehnFFQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6UZv-1mEGsC1jA1-006vRl; Fri, 06
 Aug 2021 00:23:06 +0200
Subject: Re: [PATCH 1/7] btrfs: Reorder btrfs_find_item arguments
To:     Marcos Paulo de Souza <mpdesouza@suse.de>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-2-mpdesouza@suse.com>
 <f50cc30c-ea62-5581-2a52-d3a475d3044d@gmx.com>
 <edfd5fcf7b63b791425543c642dad2c04b5a71f8.camel@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d93d9570-f124-ab9e-669c-79c4b4cfbe79@gmx.com>
Date:   Fri, 6 Aug 2021 06:23:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <edfd5fcf7b63b791425543c642dad2c04b5a71f8.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/90nletTkNmJihaOIiNzlXNXfqppIhLhIj3vjWQWlgurTtVeXl7
 A7/fwKRDyqJ5u1VwFxR5GGhq3LLwfpGt+yYw9sl7MKetQ5O4G4CKAA6eiuIB29CJa1A476I
 bBR2gJoEhEWiB8gxyU7TgtjFeniik2kcL9i9O+z2/eoVbtppF3BHv5eG6LDwenJuMY31PV/
 FS8c62Gxc86qHJaOsY7Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Dc7sndjouU=:T0QKtWRVYzsWq+SU/Mc+oA
 X2hpl+CYVp2t6V25Af0nQk3W+wXMNzaBFe+0+ZyPRLh6Jh5PsADqwu7MuSbb+bUkm23VYsyth
 DqanmclI4aQqmlZVrbxjkiEYJmXylSdrijEszIsa2ZebPKKBUTbaQJRDQ+uxyEx8pCIgWN+VD
 bPgUqcvf+Swbyo8reIzmVCQi4jiFyo+nPvCCGkrZ3BltufcBIEBK8WZxCDpmE0WNFkp3ySyDX
 G1p4/HPfym8St2v5E6JPtR9tAelbeccHsiqvQXBwzH7zvn2uPz1gZ8J74NbI73eXHk8w3YGd8
 I61NxtLTRca1mH0WHxYYB6vK0FSfJ+krtzAjb3L7XLp3ne2FARlhMivS88bnFo7y7iEgHliix
 xzqBjJn1SgQG3ncOnZdF/MrikYVwm0KWehQUVry3tSw+gKMev/CvCee81QjQGVAJJJz4Jug/6
 XxmwVPUPXi1YeyDgsWSCMe1icv4z4T1z+71OuqTFOwbyvSy7pWHrEgue1b4PjsqGMTAJ82pLO
 OvbW9lffEUOUkpF2PX74FgW2ZuPcYDrRcofSEq3ygs/SFkkjy/hrZpD6a4oyDnCIxesnayKsC
 OQGpHB1WgaMo4Shom7S4teuVd6OajYryvO10FzV1KC0+09LSRuCzwr7LiXNw8uY1l3PPzFFYR
 F3toVZl09wRgv7fIY0NObzli1yphGJSBeMvrHTXuu7ci1O9qnIVbgoKYlk6sqnyo3BbGJfaGw
 2EL2x15rrhCiDJ6Ho35+w/NZ6I+9ouPe7UhvYoEiHB1UYD4BVzDt8RWra3rZrqI16Qwa5N481
 /3joyV2T9eMoOwU6u7DI5nuZkoIV8qlKF1T9Tp3kWII6sMkkUthiDluy+BS8b7vs2M/QQuHVD
 Oldrj9PRijuh1QLk6zGywqtyrHEVT4CGXv0ZPgFUGk1QJgu0jV3qohHVzryhu0fjgPxeQ02Nr
 Lwn5i01WVyDBxUPtImWBayv0f/VbxRE+MrkqvvuOAql6NtU1GUUGzH0dzwJzInN9r8QAoGAM5
 ytdIzzzd5lj2/DmLlgleGYdH+G/NnIYojjuOxy4qTKOIpTRdc/RnlMDVTtK2w3rwtA9aWsl3n
 wEtEGwf4nLSae4vauH9djaibL9ah/X5Wnpv4uRrPrjj2+qD2gTnalmbIA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/6 =E4=B8=8A=E5=8D=881:28, Marcos Paulo de Souza wrote:
> On Thu, 2021-08-05 at 10:16 +0800, Qu Wenruo wrote:
>>
>> On 2021/8/5 =E4=B8=8A=E5=8D=882:48, Marcos Paulo de Souza wrote:
>>> It's more natural do use objectid, type and offset, in this order,
>>> when
>>> dealing with btrfs keys.
>>
>> I'm completely fine with this part.
>>
>>> No functional changes.
>>>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>> ---
>>>    fs/btrfs/backref.c | 9 ++++-----
>>>    fs/btrfs/ctree.c   | 2 +-
>>>    fs/btrfs/ctree.h   | 2 +-
>>>    3 files changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>>> index f735b8798ba1..9e92faaafa02 100644
>>> --- a/fs/btrfs/backref.c
>>> +++ b/fs/btrfs/backref.c
>>> @@ -1691,8 +1691,8 @@ char *btrfs_ref_to_path(struct btrfs_root
>>> *fs_root, struct btrfs_path *path,
>>>    				btrfs_tree_read_unlock(eb);
>>>    			free_extent_buffer(eb);
>>>    		}
>>> -		ret =3D btrfs_find_item(fs_root, path, parent, 0,
>>> -				BTRFS_INODE_REF_KEY, &found_key);
>>> +		ret =3D btrfs_find_item(fs_root, path, parent,
>>> BTRFS_INODE_REF_KEY,
>>> +					0, &found_key);
>>>    		if (ret > 0)
>>>    			ret =3D -ENOENT;
>>>    		if (ret)
>>> @@ -2063,9 +2063,8 @@ static int iterate_inode_refs(u64 inum,
>>> struct btrfs_root *fs_root,
>>>    	struct btrfs_key found_key;
>>>
>>>    	while (!ret) {
>>> -		ret =3D btrfs_find_item(fs_root, path, inum,
>>> -				parent ? parent + 1 : 0,
>>> BTRFS_INODE_REF_KEY,
>>> -				&found_key);
>>> +		ret =3D btrfs_find_item(fs_root, path, inum,
>>> BTRFS_INODE_REF_KEY,
>>> +				parent ? parent + 1 : 0, &found_key);
>>>
>>>    		if (ret < 0)
>>>    			break;
>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>> index 84627cbd5b5b..c0002ec9c025 100644
>>> --- a/fs/btrfs/ctree.c
>>> +++ b/fs/btrfs/ctree.c
>>> @@ -1528,7 +1528,7 @@ setup_nodes_for_search(struct
>>> btrfs_trans_handle *trans,
>>>    }
>>>
>>>    int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path
>>> *path,
>>> -		u64 iobjectid, u64 ioff, u8 key_type,
>>> +		u64 iobjectid, u8 key_type, u64 ioff,
>>>    		struct btrfs_key *found_key)
>>
>> But the @found_key part makes me wonder.
>>
>> Is it really needed?
>>
>> The caller has @path and return value. If we return 0, we know it's
>> an
>> exact match, no need to grab the key.
>> If we return 1, caller can easily grab the key using @path (if they
>> really need).
>>
>> So can we also remove @found_key parameter, and add some comment on
>> the
>> function?
>
> I believe that the function name is misleading. Maybe we can adjust it
> to something like btrfs_find_item_offset, since it validates if the
> found item has the same objectid and type of the searched key.

Then the parameter @offset makes no sense.

Since we have exact key, it's really intuitional to think we're
searching for a specific key, and under most cases we are.

>
> This is very common for a lot of the callers, which expect to receive
> the same objectid and type, and each caller validate the offset as
> required. Maybe we can add a comment and change the function name to
> reflect all aspects of how it works. What do you think?

For such case, the caller doesn't have the full key, but are looking for
a key to meet certain key *range* requirement.

I believe that needs a new interface.

IMHO, we need a generic way to search for a key range (or doing
iteration for a key range), and a subset of above interface to just
search for a specific key (thus with much simpler interface).

Thanks,
Qu

>
> Thanks,
>    Marcos
>
>>
>> Thanks,
>> Qu
>>
>>>    {
>>>    	int ret;
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index a898257ad2b5..0a971e98f5f9 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -2858,7 +2858,7 @@ int btrfs_duplicate_item(struct
>>> btrfs_trans_handle *trans,
>>>    			 struct btrfs_path *path,
>>>    			 const struct btrfs_key *new_key);
>>>    int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path
>>> *path,
>>> -		u64 inum, u64 ioff, u8 key_type, struct btrfs_key
>>> *found_key);
>>> +		u64 inum, u8 key_type, u64 ioff, struct btrfs_key
>>> *found_key);
>>>    int btrfs_search_slot(struct btrfs_trans_handle *trans, struct
>>> btrfs_root *root,
>>>    		      const struct btrfs_key *key, struct btrfs_path
>>> *p,
>>>    		      int ins_len, int cow);
>>>
>
