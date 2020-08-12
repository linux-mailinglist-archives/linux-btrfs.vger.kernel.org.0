Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7524289B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 13:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHLL1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 07:27:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:32887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgHLL1J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 07:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597231623;
        bh=5T64ikLHnodNflXu9fsWWpeyODPUweZcBlBeBoqqoX8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NK47iTUnlzjWqSDVwrIag3wkrT+s+NvzgiESa47upaDBWMwrtoQ/iXc7cImjHYCYQ
         wmAY2sJSXWGYilU4RArmeJIq0TKqOwqpaQeUmXAmDvVNtAy+3bSRpJOVbASuvDd96y
         AdS9OBdSHxOv13PdE78hfaWg2rFLNrSu+IWXBrYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MV67y-1kF8b2451q-00S6sB; Wed, 12
 Aug 2020 13:27:03 +0200
Subject: Re: [PATCH v5] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <20200812064312.GW2026@twin.jikos.cz>
 <fcf7972e-6579-01ee-add1-6bab2903cdf0@gmx.com>
 <9fbab6c1-ca45-3a88-9853-749bc666b949@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <1d2aaa7f-bdab-ad0e-4421-07574d554ba0@gmx.com>
Date:   Wed, 12 Aug 2020 19:26:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9fbab6c1-ca45-3a88-9853-749bc666b949@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AFOY8YTXxStC7PTi6z5f3JO+izrUObJtiKMsKuxM148ar+2vinm
 q+vT6fASPprrTHM/Lbwtq1vVouPlIuDI9t9rT0yK4QmoRuTy4Cnk+pFlTh4lxcMJQfX44Xo
 mK11TlTie+KkdPEyH1dZ8oFlOUcJKyb6YFslvXsyPtkbO4nvt7+WlN0npCCd5bu+GE2OA1k
 PW1zV9fri2h2zhQTJuRwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5FWyVP+eDDo=:DzP7jHxWGp2dZpEIG/NasE
 xiiVrTg+3JKOqMuEakQqOd27jg4O7YqMF3jLl/8FmnU30UN071DD4H7NVoNrmxr0YknJjM6LN
 lP3+0fybLVp0Wv+6rP1nSvWt5Qua6mssFIKjFF5hGwoqy/PiyFmdxhL356eB3lKOeBhW22K8K
 Qx2ccSMn9tsXamf8rvKTQKUUY7sYvPJVGWmEuD+Zxk0fDzRMnZQlwSubqmhpUDlU2mFMxR9PR
 iw54xE82D7bZLCvnmO9BWXZkwWIAp64fIHy66NpFZGFo04ERikNV3HGj/H9Sttf5yokOs96TM
 SCAee7JVWRoxRHOG6dXiLzVHpQ+o2Uf0AjHcI5tHOFIswL3hAjtRzlkr3NUDk3UlxOle0uUoA
 NbZgUTV+s4O4oGmGbJbDBQgR3BRKv/5kavq/8WYEYvi7LGOqUsoHBjx5L2XUJ8NM5fmyc4E54
 1KEOevMi2bXjFJZ0VAjSkL4lX9nZnTvqH04ZNdWABc7IgIXfvbJdhB30rcWlmKOVV8a3sfPYg
 pKe02iFrNAsN2zL2e/9iEz5WUZNF5v9WSrH9R8T3cv37MfU/uSVLdK5KKLHmKqO2Jzxv6VSXQ
 42opDuDBwtuNDdPcAM8b8LBl0yXMvmXtSGcqWPybArti32YTMqbf+KTBc9Dv6aqayrsyS1n1P
 mmzJkxYn5HNLu/RnSi9Ks7lcHabnetFP3QFtdDsbudTdaIjVbr85vx3IueNLeohivkDrPq//O
 cY6ezO33hFPrGSESa+IRJzEDmnQX4L8jnMS2e9pdV3228DZ/AJEWh++atapTPrDE2X+U3KP0A
 HH774/3zkISjacynEF47uaumNz0zcDGGZNaS+b1W++DFSSKIZTuM7zwAgTh5OC8XXdw2sr4Re
 RBtBQgKBCf2cCXjVPX8NulppgiHtVTJ446TYrNdRXog4fUFZriuGWXG9PpAf1wX2vvt9raG32
 5ZRbVRFIP5BbL/7mrUBfdkGb3CRtZSh+NKRoZ+9kNoE83xBXnuBg7nKklLDloyvHAG3jNoDnt
 8nWCdONtALDUQRz1Zj0aFj5ZyLtPumA+KcQpFTzBlC9UKelv70CPDfjSYE9z8Gh4gxqY4mZcu
 T72GM/QluZNjbGmomkUGEtpEQuofpnOcQxxJbYMmvf0JQyThnO/TdnoSCbKomcm6+QSmwxfbq
 Dj1IH2PEljkdQ+0HFsj+XFNhlsiElm6xiXTO4lxH12URPxMjN2uZkRl+PqrEz+gMPUjaHMTAF
 GMQBtrtoZUhppjGyccTiwmjyW4VoOykdsJIbifw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/12 =E4=B8=8B=E5=8D=887:24, Nikolay Borisov wrote:
>
>
> On 12.08.20 =D0=B3. 14:14 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/8/12 =E4=B8=8B=E5=8D=882:43, David Sterba wrote:
>>> The v5 changes were discussed but were not all trivial to be just
>>> committed. I need to add the patch to pull request branch soon so am
>>> not waiting for your v5
>>>
>>> v5:
>>>
>>> - add mask for chunk state bits and use that to clear the range a afte=
r
>>>   device shrink; on a second thought doing all ones did not look clean
>>>   to me
>>
>> Extra idea inspired by this patch.
>>
>> We can do extra extent_io_tree bits sanity check for DEBUG build.
>>
>> In the past, extent_io_tree got its owner member, which each
>> extent_io_tree should have one. (Unfortunately, when alloc_state is
>> added, we didn't add a new entry for it)
>>
>> With that, we can easily verify the set/clear bits against its owner to
>> ensure we don't set wrong bits for wrong extent_io_tree.
>> E.g. CHUNK_* bits are only for alloc_state, while
>> DELALLOC/QGROUP_RESERVED are only for inode io tree.
>
> Will this work given the CHUNK_* bits are defined to 2 existing flags,
> chosen such that to not clash with the special logic in bit management
> functions? (check comment above CHUNK_* bits defines).

No problem.

We're setting a allowed mask for each owner, although we're reusing
bits, it doesn't really matter that much.

Thanks,
Qu
>
>
>>
>> Of course, this would be in a new patch.
>>
>> Thanks,
>> Qu
>>>
>>> - removed assert after clear_extent_bits - make it consistent with all
>>>   other calls where we don't check the return value for now
>>>
>>> - reworded comments
>>>
>>> ---
>>>
>>> From: Qu Wenruo <wqu@suse.com>
>>> Subject: [PATCH] btrfs: trim: fix underflow in trim length to prevent =
access
>>>  beyond device boundary
>>>
>>> [BUG]
>>> The following script can lead to tons of beyond device boundary access=
:
>>>
>>>   mkfs.btrfs -f $dev -b 10G
>>>   mount $dev $mnt
>>>   trimfs $mnt
>>>   btrfs filesystem resize 1:-1G $mnt
>>>   trimfs $mnt
>>>
>>> [CAUSE]
>>> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
>>> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
>>> already trimmed.
>>>
>>> So we check device->alloc_state by finding the first range which doesn=
't
>>> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
>>>
>>> But if we shrunk the device, that bits are not cleared, thus we could
>>> easily got a range starts beyond the shrunk device size.
>>>
>>> This results the returned @start and @end are all beyond device size,
>>> then we call "end =3D min(end, device->total_bytes -1);" making @end
>>> smaller than device size.
>>>
>>> Then finally we goes "len =3D end - start + 1", totally underflow the
>>> result, and lead to the beyond-device-boundary access.
>>>
>>> [FIX]
>>> This patch will fix the problem in two ways:
>>>
>>> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>>>   This is the root fix
>>>
>>> - Add extra safety check when trimming free device extents
>>>   We check and warn if the returned range is already beyond current
>>>   device.
>>>
>>> Link: https://github.com/kdave/btrfs-progs/issues/282
>>> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_fi=
rst_clear_extent_bit")
>>> CC: stable@vger.kernel.org # 5.4+
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>>  fs/btrfs/extent-io-tree.h |  2 ++
>>>  fs/btrfs/extent-tree.c    | 14 ++++++++++++++
>>>  fs/btrfs/volumes.c        |  4 ++++
>>>  3 files changed, 20 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
>>> index f39d47a2d01a..219a09a2b734 100644
>>> --- a/fs/btrfs/extent-io-tree.h
>>> +++ b/fs/btrfs/extent-io-tree.h
>>> @@ -34,6 +34,8 @@ struct io_failure_record;
>>>   */
>>>  #define CHUNK_ALLOCATED				EXTENT_DIRTY
>>>  #define CHUNK_TRIMMED				EXTENT_DEFRAG
>>> +#define CHUNK_STATE_MASK			(CHUNK_ALLOCATED |		\
>>> +						 CHUNK_TRIMMED)
>>>
>>>  enum {
>>>  	IO_TREE_FS_PINNED_EXTENTS,
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>> index fa7d83051587..597505df90b4 100644
>>> --- a/fs/btrfs/extent-tree.c
>>> +++ b/fs/btrfs/extent-tree.c
>>> @@ -33,6 +33,7 @@
>>>  #include "delalloc-space.h"
>>>  #include "block-group.h"
>>>  #include "discard.h"
>>> +#include "rcu-string.h"
>>>
>>>  #undef SCRAMBLE_DELAYED_REFS
>>>
>>> @@ -5669,6 +5670,19 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device, u64 *trimmed)
>>>  					    &start, &end,
>>>  					    CHUNK_TRIMMED | CHUNK_ALLOCATED);
>>>
>>> +		/* Check if there are any CHUNK_* bits left */
>>> +		if (start > device->total_bytes) {
>>> +			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>>> +			btrfs_warn_in_rcu(fs_info,
>>> +"ignoring attempt to trim beyond device size: offset %llu length %llu=
 device %s device size %llu",
>>> +					  start, end - start + 1,
>>> +					  rcu_str_deref(device->name),
>>> +					  device->total_bytes);
>>> +			mutex_unlock(&fs_info->chunk_mutex);
>>> +			ret =3D 0;
>>> +			break;
>>> +		}
>>> +
>>>  		/* Ensure we skip the reserved area in the first 1M */
>>>  		start =3D max_t(u64, start, SZ_1M);
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index d7670e2a9f39..ee96c5869f57 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -4720,6 +4720,10 @@ int btrfs_shrink_device(struct btrfs_device *de=
vice, u64 new_size)
>>>  	}
>>>
>>>  	mutex_lock(&fs_info->chunk_mutex);
>>> +	/* Clear all state bits beyond the shrunk device size */
>>> +	clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
>>> +			  CHUNK_STATE_MASK);
>>> +
>>>  	btrfs_device_set_disk_total_bytes(device, new_size);
>>>  	if (list_empty(&device->post_commit_list))
>>>  		list_add_tail(&device->post_commit_list,
>>>
>>
