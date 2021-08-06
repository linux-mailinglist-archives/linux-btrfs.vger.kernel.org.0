Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233743E2327
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 08:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbhHFGLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 02:11:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:34901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhHFGLa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Aug 2021 02:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628230270;
        bh=Ivu+QkVwXFe2OLI75qF1mSCD2AgwJaS7rJb4HFVeRBY=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=TgoQ+GZB0T3a5yFkd2LHwaXrt1pbFr83zXFd/7gupwPlDr+7sz+nqWddrW5ryrV3/
         WT0Njig7oVJQVTDIw9owp2Y4U7sTcL3KSjScl26aL2pys2chcYroKgexWqO6lRKsF6
         9QBaEvf0L1T44qemvIsXnABmp3r7TNVbJoTBpoSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNt0C-1mVbm93U88-00OGbb; Fri, 06
 Aug 2021 08:11:10 +0200
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-4-mpdesouza@suse.com>
 <5f66b9cc-288b-3f26-ee36-9c2ce672c100@gmx.com>
 <20210806055236.hour3vgwgz7cphx2@naota-xeon>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 3/7] btrfs: zoned: Use btrfs_find_item in
 calculate_emulated_zone_size
Message-ID: <43f9f9bb-4aa6-84aa-41d2-847ce37caada@gmx.com>
Date:   Fri, 6 Aug 2021 14:11:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210806055236.hour3vgwgz7cphx2@naota-xeon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w3yn4Vi1TK6DTngc+pXuKqAOmSbUeIkVEz9WjoyFKZUIYzMiC27
 Ayha0bZp3f6ALJDIfyuF5nCinPL5Bb7sTjgiEO5KcYzOfbYMSwkhXB+bN3ThCq9pOvUbEpd
 yYLw1gV5jKTd5Nx/vZdFpX2oseeG+7UoMtcCqUs0MTW5Ovc6GMzN8bfrqvq8y5/SRMqtmaN
 rUONPLTD1o4P4S2MmDsaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eviODRvembs=:TnzWvAF4Jc9UZh4PdLlRb/
 aIU3ogpkHO5usrjK3r9JsUy1Wr6rHBQ2/U1WbvTMIfndjor/HtJSWEaYDiZ//iWtkz7TAlJ0z
 3+H2if4KgI1wLED4iZosO1PanjskefFjFBDuds1vIkl6iZ33TCHbMnhX6XPapMHZ3PUcn/8l+
 20BjNQi3ksWoVWUGr9zkVXtvII7gUjBGIpb9yWnY8wYzCreoUz7PSGtxkOlUoYt3+yodVbwhC
 nMXcUKYzYCUAC+7ZleiSODVxr89li4JoBEmf0ixgqXabmSsfQDjQRK5fHbW7oX/NupqYJYWII
 wQ6EAx4zMezHrhZ3nGFKjKYn48plfejEabClcJDdoHwO08XgRMoIlF8qi3jotnQbmjBgjh76i
 L756ZE9/MroI+Wun5QZ8l2bTdW7LzAyJPdLfAmyr9MaEQWeQ6ImPsdKOFwuOOUy0sxX2e7d8d
 TVZrEK8BsuoRoYefl3DWxp+5V/mdJ9MaJJVRLZWBnWiL9OFZoHDaBdO+KwpveqsKV35T4S0Tv
 QnJDWv7I/vSWt9kusYKbT7IkLC7vrJPasRKdt72yMm97JrgnEUqBBPxSnggEJKqKis41V/7hL
 qTrhoG/WLzKFGBJrxq9xnK8x7NEr4Bvesp75mPhVJCCSbNxgAAGhoUIhNnf8ytlCAlOkITnO9
 LBJ3VRLIs9XBa+f4z0iTYnXTdq0yjFZFf9X8XZ9gkqLNGuevoS08gr6PsqlpVfsrxLR3arIqz
 svqFZ8qJ43Ieg8lZbnopUIprxH8EVzkwA5Pw5StoL/HjOCqKPvc7xN1Qp2O43ma2giGjuXhcU
 fgD88hykpn8bedfjHOAenDCURyGLaWGfrJa0chZBKFpL3x3kr9kbdWq/+d4hSasva8Gos+dsB
 P7UAHfQ5gaP6N4js5Tmzct6qx+T+f3ZonrSqvVmFXFQprFblsEgNNcin5SXPlYEWDYrrvKAsk
 v0jk4rjrVICGMRD8RcUKouTCwiXovlm9yGO2XGGRSQObQxi5ph0T8a/Fg8qwoB58FXy+xFH/c
 ESg3Ok0ieliL3DgfEsWnowgadfdbIqW+hzyM48wWgEN6AVYsj6O+cJT9WnSKRbsIG5LdJLX5n
 pyTd9qQncLQyz9bAzY0JVzAjEYGnHEMo8IBBhZrvUdDnzEOaeljfEgzmA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/6 =E4=B8=8B=E5=8D=881:52, Naohiro Aota wrote:
> On Thu, Aug 05, 2021 at 02:39:09PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/8/5 =E4=B8=8A=E5=8D=882:48, Marcos Paulo de Souza wrote:
>>> calculate_emulated_zone_size can be simplified by using btrfs_find_ite=
m, which
>>> executes btrfs_search_slot and calls btrfs_next_leaf if needed.
>>>
>>> No functional changes.
>>>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> But since we're here, some unrelated comment inlined below.
>>> ---
>>>    fs/btrfs/zoned.c | 21 ++++++---------------
>>>    1 file changed, 6 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>> index 47af1ab3bf12..d344baa26de0 100644
>>> --- a/fs/btrfs/zoned.c
>>> +++ b/fs/btrfs/zoned.c
>>> @@ -230,29 +230,20 @@ static int calculate_emulated_zone_size(struct b=
trfs_fs_info *fs_info)
>>>    	struct btrfs_key key;
>>>    	struct extent_buffer *leaf;
>>>    	struct btrfs_dev_extent *dext;
>>> -	int ret =3D 0;
>>> -
>>> -	key.objectid =3D 1;
>>
>> Not related to this patch itself, but this immediate number is not that
>> straightforward.
>>
>> In fact for DEV_EXTENT_KEY, the objectid means device number.
>>
>> For current zoned device support IIRC we only support single device,
>> thus it's fixed to 1.
>
> To be precise, we can have multiple devices, but only support single
> profile.

So it means we could have cases where we only have devid 2 (device add,
then remove the original device).

The original code is fine, it's just searching the for the first device
extent.

But the new code is no longer doing the same thing.

My reviewed-by tag is wrong now....

>
>> It would be better to have some extra comment/ASSERT() for it.
>>
>>
>>> -	key.type =3D BTRFS_DEV_EXTENT_KEY;
>>> -	key.offset =3D 0;
>>
>> Normally for DEV_EXTENT_KEY, the offset is the dev physical offset,
>> which normally is not 0 (as we reserve 0~1M for each device)
>>
>> So this is a special zoned on-disk format?
>
> We also reserve the first two zones on a disk for superblock log
> zones, so on typical SMR drive, 0-512M is reserved.
>
> We can use any DEV_EXTENT item here to determine the emulated zone
> size. So, it's trying to find the first one.

Then the patch is changing the behavior.

Now it can't handle cases where we don't have devid 1.

And since we're search for the first DEV_EXTENT_KEY, I don't believe
btrfs_find_item() is the proper function here to call.

Please drop my reviewed-by tag.

Thanks,
Qu

>
>> Thanks,
>> Qu
>>
>>> +	int ret;
>>>
>>>    	path =3D btrfs_alloc_path();
>>>    	if (!path)
>>>    		return -ENOMEM;
>>>
>>> -	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>>> +	ret =3D btrfs_find_item(root, path, 1, BTRFS_DEV_EXTENT_KEY, 0, &key=
);
>>>    	if (ret < 0)
>>>    		goto out;
>>>
>>> -	if (path->slots[0] >=3D btrfs_header_nritems(path->nodes[0])) {
>>> -		ret =3D btrfs_next_leaf(root, path);
>>> -		if (ret < 0)
>>> -			goto out;
>>> -		/* No dev extents at all? Not good */
>>> -		if (ret > 0) {
>>> -			ret =3D -EUCLEAN;
>>> -			goto out;
>>> -		}
>>> +	/* No dev extents at all? Not good */
>>> +	else if (ret > 0) {
>>> +		ret =3D -EUCLEAN;
>>> +		goto out;
>>>    	}
>>>
>>>    	leaf =3D path->nodes[0];
