Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 513B5E2764
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 02:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392839AbfJXAkr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 20:40:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:39261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392817AbfJXAkr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 20:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571877366;
        bh=GoehOsarMWaNv04aeSnZyq7FykXjwScuaIg5Fu5ydjs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ckf6NIawxsKGK1Uf9OP4x4N4zo3//DmeGB8+CGIPfDspJv8CtlV0REHfAKtmcbsAj
         WtlcTjDjalHEAQstBHb/a4J9x+d64d7rTBMdqlf5YsiyK/2SI4aABo9JsbWAX+5n6R
         u9ksPHT2Lovo9mUxltgK383bpD5GTmOmzIGkdHHk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MD9XF-1iEsNw36XZ-009AbH; Thu, 24
 Oct 2019 02:36:06 +0200
Subject: Re: [PATCH v3 2/2] btrfs: extent-tree: Ensure we trim ranges across
 block group boundary
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191023135727.64358-1-wqu@suse.com>
 <20191023135727.64358-3-wqu@suse.com>
 <1322eb4c-5d7a-29c0-befc-952a012f1bcc@suse.com>
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
Message-ID: <8340fb01-1a0b-2831-ba6e-ce4a04e842bf@gmx.com>
Date:   Thu, 24 Oct 2019 08:35:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1322eb4c-5d7a-29c0-befc-952a012f1bcc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6aWL+RIm+KKRlfEvBwHQKg+SMIFEbkm4chWaA9eqESsiFjg6j7n
 wHQfys7mAwEiI1+5C5vnkvYiCgbUGELAHf+Wsd66wd6Uq6OOcRUWwv+hDn5dMxWkRY/PMq7
 ceL2jWtVSMrLo+75DYa1xdjQa6SpNWpi2jF9GL+vmv1rJ0s4wCuU2gozKCPwK2dVJH1sYmo
 1tXBV3eJRKKgtQraLO3/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q7D7ip5PEfQ=:rvS3PsAkoKEK6n3IHipinD
 xuWg7/uKVajRSpyDdLGStVAorLs4LdL/ndyqqXF+Ntsigbcv5/fwY7INmgcY0qxfgUJbV1wMs
 V000RieJkr05qZn0qV6dm1LhwwT5AtihfUOuH6UrvhjOUcJDy+6XlekDyjoD4ve+U9af17fu7
 2czmgFjSoHISWvtDTZrbokCFDMWkOl044FH0YPxJSUIzSBJAVAIw4uXs+IdA/0KO3y/OiGHXe
 yrrkxquwKZLcvf0IwjysCScSO+u9hP7SsB4/pX2+5zDetmk0WVRZpXjJpht0k5X5cxCIacPNz
 PTqfUP+Qvi/sXLUl5JqnvWlsc1o4R/k9Fvy3V7X1nleZtqam/ImahRiJds+NyLsnq15S9OPXY
 fotgmw8wTja+p8cXNzHf6BWmvj4rY0tfrowwRSj0Bae1ftzXTrVs6GfcukaoCsLZZY8m7pFHs
 3zAkIpfqWbm+ifb9j8Zm+VN8HcxBn73vO+N+eW4kpRMfzdfnqyWBby2wuFG6gwZnjj6mNH3vN
 WEqOrEuYicKwSUNDKTMYrNYVMo5pzI2ovO/nmGiV64hvV8i2vzgHDCtkkteqRUZggBYt4zIyd
 sB0HowtKPGyOpn12UaqKhaDF5UzUXWInCqcGmH2ZR/v+oJlyHmF7TenKwtiqj3YI5FCYNnyW2
 bHS1A2MgtjNW16UB7R3BfrJSg8ZpVopiLQwSeNYMk9V+6M3TNbvvUuenKX2Uim/0nW2TrYjw1
 uA6PIDpmLJsCu6dsgJpwqHjI1OO6VN/azI4E6GHWFwSAg+DvnbVDGjjq2eyzXFk1yvful/HuC
 EuJmAksrp55r1rcHDi/BNb1mYC5TPlpENoY5Nz5sIqrQjQegt2K7iSQsr8ZKmszWqoQeCQRg/
 NYqf6vmdxtBlVBXKCt4JJtZjE9d5x0OT1gGF7T7YbSUFFsDamBz+Ly76LE1BXxmRtvhPoyGQ6
 tMlSxHld7VWPDWmiIw0efnhh+qRgbYYWF17WyUBw0tsv6ffYem1hFRC2NQbyZJ4QX333IQ5XW
 lxNUajhZUikYwDpid51YSnhaseuCzmp3oXr5EzHJAi8E+L3iKdeumpkPgcRk9gWlfA9lW9Z24
 qYOLeEAoJGWq73edH5n8r2C0a2vZjHGdRLvaPvCjNG31iGrp6+4L7oN5mB4c4+hxudbW55F1g
 xvE/5EQr3A5yFX9jAE7nEllzpsUXqKnpEe1ACc0EnW/lDvhAHOppJk+5xAX5WwzZp2TWCVCn6
 l/vlFVeOFiHrBMyd52fhGk1W3BXT5kXxk8d6NBoMdspYlMYv2juTOaN68nCM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/23 =E4=B8=8B=E5=8D=8811:41, Nikolay Borisov wrote:
>
>
> On 23.10.19 =D0=B3. 16:57 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> When deleting large files (which cross block group boundary) with disca=
rd
>> mount option, we find some btrfs_discard_extent() calls only trimmed pa=
rt
>> of its space, not the whole range:
>>
>>   btrfs_discard_extent: type=3D0x1 start=3D19626196992 len=3D2144530432=
 trimmed=3D1073741824 ratio=3D50%
>>
>> type:		bbio->map_type, in above case, it's SINGLE DATA.
>> start:		Logical address of this trim
>> len:		Logical length of this trim
>> trimmed:	Physically trimmed bytes
>> ratio:		trimmed / len
>>
>> Thus leading some unused space not discarded.
>>
>> [CAUSE]
>> When discard mount option is specified, after a transaction is fully
>> committed (super block written to disk), we begin to cleanup pinned
>> extents in the following call chain:
>>
>> btrfs_commit_transaction()
>> |- write_all_supers()
>
> You can remove write_all_supers
>
>> |- btrfs_finish_extent_commit()
>>    |- find_first_extent_bit(unpin, 0, &start, &end, EXTENT_DIRTY);
>>    |- btrfs_discard_extent()
>>
>> However pinned extents are recorded in an extent_io_tree, which can
>> merge adjacent extent states.
>>
>> When a large file get deleted and it has adjacent file extents across
>> block group boundary, we will get a large merged range.
>
> This is wrong, it will only get merged if the extent spans contiguous bg=
 boundaries
> (this is very important!)

Yep, skipped some details as I thought it was too obvious, but indeed it
needs extra wording.

>
>>
>> Then when we pass the large range into btrfs_discard_extent(),
>> btrfs_discard_extent() will just trim the first part, without trimming
>> the remaining part.
>
> Here is what my testing shows:
>
> mkfs.btrfs -f /dev/vdc
>
> mount -onodatasum,nospace_cache /dev/vdc /media/scratch/

nospace_cache is important as v1 space cache exists as regular file,
which could take up data space and screw up extent layout.
(And in original report, v1 cache is the cause of randomness in
reproducibility)

> xfs_io -f -c "pwrite 0 800m" /media/scratch/file1 && sync
> xfs_io -f -c "pwrite 0 300m" /media/scratch/file2 && sync
> umount /media/scratch
>
> mount -odiscard /dev/vdc /media/scratch
> rm -f /media/scratch/file2 && sync
> trace-cmd show
>
> umount /media/scratch
>
> The output I get in trace-cmd is:
>
> sync-1014  [001] ....   534.272310: btrfs_finish_extent_commit: Discardi=
ng 1943011328-2077229055 (len: 134217728)
> sync-1014  [001] ....   534.272315: btrfs_discard_extent: Requested to d=
iscard: 134217728 but discarded: 134217728
>
> sync-1014  [001] ....   534.272325: btrfs_finish_extent_commit: Discardi=
ng 2177892352-2358247423 (len: 180355072)
> sync-1014  [001] ....   534.272330: btrfs_discard_extent: Requested to d=
iscard: 180355072 but discarded: 180355072
>
> The extents of this file look like this in the extent tree prior to the =
trim:
>
> item 18 key (1943011328 EXTENT_ITEM 134217728) itemoff 15523 itemsize 53
> 		refs 1 gen 7 flags DATA
> 		extent data backref root FS_TREE objectid 258 offset 0 count 1
> item 19 key (2177892352 EXTENT_ITEM 134217728) itemoff 15470 itemsize 53
> 		refs 1 gen 7 flags DATA
> 		extent data backref root FS_TREE objectid 258 offset 134217728 count 1
> item 20 key (2177892352 BLOCK_GROUP_ITEM 1073741824) itemoff 15446 items=
ize 24
> 		block group used 180355072 chunk_objectid 256 flags DATA
> item 21 key (2312110080 EXTENT_ITEM 46137344) itemoff 15393 itemsize 53
> 		refs 1 gen 7 flags DATA
> 		extent data backref root FS_TREE objectid 258 offset 268435456 count 1
>
> So we have 3 extents 1 of which is in bg 1 and the other 2 in bg2. The 2=
 extents in bg2 are merged but
> since the 2nd bg is not contiguous to the first hence no merging.
>
> Here comes the requirement why the bg must be contiguous.
>
> If I modify my test case with slightly different write offsets such that=
 bg1
> is indeed filled and the next extent gets allocated to in bg2, which is =
adjacent then
> the bug is reproduced:
>
> mkfs.btrfs -f /dev/vdc
>
> mount -onodatasum,nospace_cache /dev/vdc /media/scratch/
> xfs_io -f -c "pwrite 0 800m" /media/scratch/file1 && sync
> xfs_io -f -c "pwrite 0 224m" /media/scratch/file2 && sync
> xfs_io -f -c "pwrite 224m 76m" /media/scratch/file2 && sync
> umount /media/scratch
>
> mount -odiscard /dev/vdc /media/scratch
> rm -f /media/scratch/file2 && sync
> trace-cmd show
>
> umount /media/scratch
>
> The 3 extents being created and subsequently deleted are:
>
> sync-799   [000] ....   313.938048: btrfs_update_block_group: Pinning 19=
43011328-2077229055
> sync-799   [000] ....   313.938073: btrfs_update_block_group: Pinning 20=
77229056-2177892351 <- BG1 ends
> sync-799   [000] ....   313.938116: btrfs_update_block_group: Pinning 21=
77892352-2257584127 <- BG2 begins
>
> But we only get 1 discard request:
>
> sync-798   [003] ....   154.077897: btrfs_finish_extent_commit: Discardi=
ng 1943011328-2257584127 (len: 314572800) <- this is the request passed to=
 btrfs_discard_extent
> sync-798   [003] ....   154.077901: btrfs_discard_extent: Discarding 234=
881024 length for bytenr: 1943011328 <- this is the actual range being dis=
carded inside the for loop.
>
> So the bug is genuine I will test whether your patch fixes it and report=
 back.
>
>> Furthermore, this bug is not that reliably observed, as if the whole
>> block group is empty, there will be another trim for that block group.
>
> Not only because of this, mainly because of the contiguousness requireme=
nt.

Contiguousness requirement is in fact pretty easy to hit.

Just do a 20G write, you will find most bg and file extents are Contiguous=
.

The problem is to craft a reliable way extent and bg layout in a
reproducible way, and a good way to detect the missing trim.


In my environment, I'm using 20G write so even space cache is screwing
me up, I still have 20 chances to have contiguous bg and file extents.
And for trim result, loopback device can be used to account how many
bytes are really used.

I just need to polish them into a good fstests case.

Thanks,
Qu

>
>>
>> So the most obvious way to find this missing trim needs to delete large
>> extents at block group boundary without empting involved block groups.
>>
>> [FIX]
>> - Allow __btrfs_map_block_for_discard() to modify @length parameter
>>   btrfs_map_block() uses its @length paramter to notify the caller how
>>   many bytes are mapped in current call.
>>   With __btrfs_map_block_for_discard() also modifing the @length,
>>   btrfs_discard_extent() now understands when to do extra trim.
>>
>> - Call btrfs_map_block() in a loop until we hit the range end
>>   Since we now know how many bytes are mapped each time, we can iterate
>>   through each block group boundary and issue correct trim for each
>>   range.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> <snip>
>
