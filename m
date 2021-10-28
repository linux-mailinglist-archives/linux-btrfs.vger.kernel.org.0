Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4243DDEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1JnM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 05:43:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:35789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhJ1JnM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 05:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635414037;
        bh=W0Ls7Gofbom4D6torKuqAb4N8USGtltNXsi8r6NgeOM=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=AdVzDcW7kic9oBcwRK+fQ2fvPTeaFTjaq47UveiPuGQobk2+W/WPHCf/HSemExpmD
         ISgPK2EzmvA5dAw9ePCEB+sHjjfvaak7VDQmVhhGWCsuwwm2Mais/ayXsq+VVoRpay
         xv0xa3GcYAGyCm5d0H6ZmHrMBKrL7r7NWXfZxIik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNKhm-1mHCqk1Rve-00OqJh; Thu, 28
 Oct 2021 11:40:37 +0200
Message-ID: <efdf5787-35c1-7681-d496-1c9dc4a7c8b3@gmx.com>
Date:   Thu, 28 Oct 2021 17:40:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Michael Chang <mchang@suse.com>,
        The development of GNU GRUB <grub-devel@gnu.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211016014049.201556-1-wqu@suse.com>
 <3845c0be-6ed8-171e-67c2-92a6f80a60cd@suse.com> <20211028092718.GA32643@mazu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fs/btrfs: Make extent item iteration to handle gaps
In-Reply-To: <20211028092718.GA32643@mazu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a5Mv718xcC8YZUqHhuf08u8hrP/3wL5jbraTIIOLxMs3p+rM/p4
 OojGsu/2bWg7N/IJvtr4NmXMnouIZjkdzpD9QCCkviQVYgS22OnNRMfnEWT8teu0oIiEgbg
 bVh4jDh1MXkunhfBYrkkt0MXFcv04jgyq2cWjHy5MggmehViJDRUVEpyt8J4TCB+baPGoH2
 V8/zynIxQUg/2939NBjsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ofzkb3Irg14=:d3EgFwNVzOq1OM/fHO77NR
 ntziMCyvkLHxKOWEnlS+9ktQylcMWwsZpJmS66flCZM8ZA7dFBsSHK9arZS0MZfIQv6VArXFW
 QqDHrG0pOXRwL+mi3oJSsuGprXiivlmHZtsfcE7+tQJhEVUggs+o3kOoRH3P453871oUnwulw
 owKjHS+1sJGesnCcEKGIBhPJP+H33HyD/X1h31aVesDx0VkG4/atWjzdupDERS7HXzQpsCaWf
 dV5cipZvvd2TDSPZ/DZceVLkZR8DspxbUC7lo2OUaxiCsNoyiTbLedXNtTDy5fn3oWCR7K9Kk
 ME6U92j22oQr7G82pFQcpr/GJwaWIS7KrRszITNkZ47h8Rc5TmCxFIB+ViCDZAzs6jD0jalZU
 bwJ8DKlFLY7Dce05gbY301styMiHmQoNngSejLKbhRJwd5yn1ag1XARVvHwJSJ0ZnWmJaP3WY
 x9qw/y0wJON6qBU7GD6x6kazNEUXrtnWb4eje1F1NEWgddkZtseEYrNuSjiClEzuRJkBMDzpF
 ywJxMgI3H7+kOaseRnNmeNdHbf0rbRGC7p5vVMTkUl4nRgXhRqVxThHhX4i0xc+KhyqyVgBEZ
 2c75xY1BtcXE9AMHbNKamgi7YhBoO2JTgjoPQmaQgSn1WzxGhgxkSXGluBz5YxXbt3OY7o8+x
 pHRw0kCfLyJRGnbJDYYQM+YSZK3S9tCyGkxLkUvRF8BUJ83Vki9jNiifniQ/aCConyL3BpQEk
 tJ0uNlDxL0hEsl526XMhDXiyDA4RwKRSLo4AIGpnJ0uRDAvbQJd9tdMETeWthQ/y9QrcgrU5C
 AmysaBgsCAC0zdry41OsOEQ6NLc6ON/krgfD7Ui4uyPlBJCvMc/20AHc7t/7h20uvT0AsOCm6
 5KR6E5rosIW15GsG1RAkWnwYRHxYOvKWb29qrn+IEifqbsfP9K4lGSb2tUTtpq1XVfCBGdeAe
 mYuZx+TDJpXFSijpEBbB2puYgo1qRi80tQD64+REusNjVESACcjlRFwP1slXJoNzTJFQH5Fld
 OQ7SZAdZDhKt8uMLX2KGWMB6Xr1/KkE4Ik65uIpty12535kvM/jtGKcNZujR/BhqQU+emgXxJ
 mpuFKkQW5Rzcjg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/28 17:27, Michael Chang wrote:
> On Thu, Oct 28, 2021 at 03:36:10PM +0800, The development of GNU GRUB wr=
ote:
>> Gentle ping?
>>
>> Without this patch, the new mkfs.btrfs NO_HOLES feature would break any
>> kernel/initramfs with hole in it.
>>
>> And considering the modification is already small, I believe this patch=
 is
>> definitely worthy as a bug fix.
>
> +1
>
> This does worth more attention as booting would have been blocked.
>
>>
>> Thanks,
>> Qu
>>
>> On 2021/10/16 09:40, Qu Wenruo wrote:
>>> [BUG]
>>> Grub btrfs implementation can't handle two very basic btrfs file
>>> layouts:
>>>
>>> 1. Mixed inline/regualr extents
>>>      # mkfs.btrfs -f test.img
>>>      # mount test.img /mnt/btrfs
>>>      # xfs_io -f -c "pwrite 0 1k" -c "sync" -c "falloc 0 4k" \
>>> 	       -c "pwrite 4k 4k" /mnt/btrfs/file
>>>      # umount /mnt/btrfs
>>>      # ./grub-fstest ./grub-fstest --debug=3Dbtrfs ~/test.img hex "/fi=
le"
>>>
>>>      Such mixed inline/regular extents case is not recommended layout,
>>>      but all existing tools and kernel can handle it without problem
>>>
>>> 2. NO_HOLES feature
>>>      # mkfs.btrfs -f test.img -O no_holes
>>>      # mount test.img /mnt/btrfs
>>>      # xfs_io -f -c "pwrite 0 4k" -c "pwrite 8k 4k" /mnt/btrfs/file
>>>      # umount /mnt/btrfs
>>>      # ./grub-fstest ./grub-fstest --debug=3Dbtrfs ~/test.img hex "/fi=
le"
>>>
>>>      NO_HOLES feature is going to be the default mkfs feature in the i=
ncoming
>>>      v5.15 release, and kernel has support for it since v4.0.
>>>
>>> [CAUSE]
>>> The way GRUB btrfs code iterates through file extents relies on no gap
>>> between extents.
>>>
>>> If any gap is hit, then grub btrfs will error out, without any proper
>>> reason to help debug the bug.
>>>
>>> This is a bad assumption, since a long long time ago btrfs has a new
>>> feature called NO_HOLES to allow btrfs to skip the padding hole extent
>>> to reduce metadata usage.
>>>
>>> The NO_HOLES feature is already stable since kernel v4.0 and is going =
to
>>> be the default mkfs feature in the incoming v5.15 btrfs-progs release.
>>>
>>> [FIX]
>>> When there is a extent gap, instead of error out, just try next item.
>>>
>>> This is still not ideal, as kernel/progs/U-boot all do the iteration
>>> item by item, not relying on the file offset continuity.
>>>
>>> But it will be way more time consuming to correct the whole behavior
>>> than starting from scratch to build a proper designed btrfs module for=
 GRUB.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>    grub-core/fs/btrfs.c | 33 ++++++++++++++++++++++++++++++---
>>>    1 file changed, 30 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/grub-core/fs/btrfs.c b/grub-core/fs/btrfs.c
>>> index 63203034dfc6..4fbcbec7524a 100644
>>> --- a/grub-core/fs/btrfs.c
>>> +++ b/grub-core/fs/btrfs.c
>>> @@ -1443,6 +1443,7 @@ grub_btrfs_extent_read (struct grub_btrfs_data *=
data,
>>>          grub_size_t csize;
>>>          grub_err_t err;
>>>          grub_off_t extoff;
>>> +      struct grub_btrfs_leaf_descriptor desc;
>>>          if (!data->extent || data->extstart > pos || data->extino !=
=3D ino
>>>    	  || data->exttree !=3D tree || data->extend <=3D pos)
>>>    	{
>>> @@ -1455,7 +1456,7 @@ grub_btrfs_extent_read (struct grub_btrfs_data *=
data,
>>>    	  key_in.type =3D GRUB_BTRFS_ITEM_TYPE_EXTENT_ITEM;
>>>    	  key_in.offset =3D grub_cpu_to_le64 (pos);
>>>    	  err =3D lower_bound (data, &key_in, &key_out, tree,
>>> -			     &elemaddr, &elemsize, NULL, 0);
>>> +			     &elemaddr, &elemsize, &desc, 0);
>>>    	  if (err)
>>>    	    return -1;
>>>    	  if (key_out.object_id !=3D ino
>>> @@ -1494,10 +1495,36 @@ grub_btrfs_extent_read (struct grub_btrfs_data=
 *data,
>>>    			PRIxGRUB_UINT64_T "\n",
>>>    			grub_le_to_cpu64 (key_out.offset),
>>>    			grub_le_to_cpu64 (data->extent->size));
>>> +	  /*
>>> +	   * The way of extent item iteration is pretty bad, it completely
>>> +	   * requires all extents are contiguous, which is not ensured.
>>> +	   *
>>> +	   * Features like NO_HOLE and mixed inline/regular extents can caus=
e
>>> +	   * gaps between file extent items.
>>> +	   *
>>> +	   * The correct way is to follow kernel/U-boot to iterate item by
>>> +	   * item, without any assumption on the file offset continuity.
>>> +	   *
>>> +	   * Here we just manually skip to next item and re-do the verificat=
ion.
>>> +	   *
>>> +	   * TODO: Rework the whole extent item iteration code, if not the
>>> +	   * whole btrfs implementation.
>>> +	   */
>>>    	  if (data->extend <=3D pos)
>>>    	    {
>>> -	      grub_error (GRUB_ERR_BAD_FS, "extent not found");
>>> -	      return -1;
>>> +	      err =3D next(data, &desc, &elemaddr, &elemsize, &key_out);
>>> +	      if (err < 0)
>>> +		return -1;
>>> +	      /* No next item for the inode, we hit the end */
>>> +	      if (err =3D=3D 0 || key_out.object_id !=3D ino ||
>>> +		  key_out.type !=3D GRUB_BTRFS_ITEM_TYPE_EXTENT_ITEM)
>>> +		      return pos - pos0;
>>> +
>>> +	      csize =3D grub_le_to_cpu64(key_out.offset) - pos;
>>> +	      buf +=3D csize;
>>> +	      pos +=3D csize;
>>> +	      len -=3D csize;
>
> Does it make sense to add some sort of range check here to safegard len
> from being underflow ?

Yes, thanks for catching this.

> My justfication is that csize value is read out
> from disk so can be anything wild presumably.

It can be even more easier to trigger the underflow.

If the read range ends inside a hole, and NO_HOLES feature is enabled,
then csize will be larger than len, and underflow.

Thankfully for GRUB it always read the whole file, not part of it.
So it's fine for GRUB, but definitely not for a generic fs implementation.

So I'll update the patch to do a clamp on the size.

Thanks,
Qu

>
> Thanks,
> Michael
>
>
>>> +	      continue;
>>>    	    }
>>>    	}
>>>          csize =3D data->extend - pos;
>>>
>>
>>
>> _______________________________________________
>> Grub-devel mailing list
>> Grub-devel@gnu.org
>> https://lists.gnu.org/mailman/listinfo/grub-devel
>
