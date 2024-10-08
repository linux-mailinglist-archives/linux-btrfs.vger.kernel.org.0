Return-Path: <linux-btrfs+bounces-8660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDABC9958C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 22:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9451F247DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120DE2139C7;
	Tue,  8 Oct 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bjUVKQoW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40443137C2A;
	Tue,  8 Oct 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728420647; cv=none; b=vET2UDk6YJDinF9RkR5LfOXHyD+0sA4l4vOWCXuZuOqSafaoKKgy5oHLdnUTCsQl1wAflOOnTCVPbuevbCK1ibEPazMi6JJXmNWgYFnfgRgU1p8XsWOvic7+QPM8+Dtn5WEgUYDyryM6un1LqGKla+s5d/eT4siq/BQbQMgxlsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728420647; c=relaxed/simple;
	bh=pfet137Megyf88mIb3sFxJpg7I04z71aKPBpBTqHDhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auVCR3+/Pvg/lVryXMbWywiZyn9IjjSMHBB0E+0NjbEYEY3eH5BWx7qZuuI/jNwNTZRLXY0V3LzOWpqVtlyWDhrD4HZQo1GhdLdLf/XSoRDrh0eg2szDwJGAsD3UHCqiY1RIvX9l4JspJrgBilo0lU/GD6lRqG+5WrJQSDkJUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bjUVKQoW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728420628; x=1729025428; i=quwenruo.btrfs@gmx.com;
	bh=OrJTxoD7qxrhevwECMmn58eMMaEytlEPD0r3z162wBo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bjUVKQoWxCspaGooIKtt66jZA3JHCMlSLp+/am3dOo+ZE9ZeY4Y8WOyRBDZY0MiX
	 3XRW9VaOLHnaEkrx5Q2KDUKNnPdbOVUedcczHtHkqyECScOKm8T6MBfXJRct2vKS4
	 mq1xomHcPnlcLaGg4aHmlzTfED+SjVOU8LbtO7HTpu5Ze+Pal+g+UQXJd5bkG5EIw
	 MhK37cnfrkPNWLJOb3uawaym1eJdL0RzqWKuzQs5CSp03CrSLOJo73/cc0qsLAJTb
	 m1+2+3sznJiZ+nIWhbTdSirheDVdqXKPI9cFYpq9goh9xLhwQLoxJ1F0xD5U3HqK7
	 DIT3Fviy9Jl7jjOADA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQic-1t6Ytx3C4M-00DaPG; Tue, 08
 Oct 2024 22:50:28 +0200
Message-ID: <ea99632a-e873-4f53-9d47-97b1a714586b@gmx.com>
Date: Wed, 9 Oct 2024 07:20:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix the length of reserved qgroup to free
To: hs wang <iamhswang@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, wqu@suse.com, boris@bur.io, linux-kernel@vger.kernel.org,
 Haisu Wang <haisuwang@tencent.com>
References: <20241008064849.1814829-1-haisuwang@tencent.com>
 <b677188b-b41b-4a3d-8598-61e8ccdef075@gmx.com>
 <CALv5hoQwjE=4mqEst1ay5YF3eAj2TNdjtLmHbBNCwxsfDXJQTA@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CALv5hoQwjE=4mqEst1ay5YF3eAj2TNdjtLmHbBNCwxsfDXJQTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7yas0XO7P6EF77H84XQhqknfj5nzCu+p8sun9zH5FAgv7B3gNBo
 ZhQwZ43JwQE1egA8siITwJj1JwpfYP3vcfli9f8rnkS/R7aa7FSPlTp+nxOGmA+CR03WKgw
 Ud4aPl6Oc+M1/HJwX9s6zH8nLrci2j+JMnnaCn9zFhEjMtA2TMJhfxp1KVTs1NC3EoSWggs
 TVDOQkJ6u45+4XFnb8aYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IKriuLKEfzI=;JB5d7Leii/HIGJMubjAWX/27phy
 sopSwYxQBeq3YnpDyEDxunKnSDcrVO0SSO3Qevex9+vlIy/YUQK9lkZptZo5NIVH6WmkCjw+3
 TSVP30igs5k/RCC3YTfZ2iP1YAEfuzpOt5WpwDI++7/DuGPNEMTBUZwdLAeoxAOkUesciCKwP
 ziWvo0+ieBak1HQ5jgz/2HBQ+EUH6ut8p1lZKfqQJ8wljM3YQqFxovE9M6K99sR394IUzzRv+
 uc2X80V+I9ACqHICHnFRJf+PrbDkOlY2FLJJNxqcbqNIg5v51pvjYhHcQGl9I4BQ+kNPjXmiy
 cpQofRlxOLvbhagKZXgFRv66iZiSsBaLPE0tlxaVN/oY4dpWOwzv3HsHKWVE0HfZq1C26gvho
 Aui3VYHcw1+3RvqvXvPtEssaMu8pHkbBJu2E8cQ+k22ALMdYDGrPAvtI3zF660d3LJvAy3G50
 UDsKS705H4T3E/9hLB9yieCIv7A+B7GqwSzSiWEpyiSdu5eyd8L2krYbdxMBIAXC74r3isIae
 Kcm3NhqQAPsHGx2lNS90UuT/Xnsrb+uZD1WFrrNLBvGN5BZ1mvq92ykuqI1MPC2uDnV/Bd8J9
 vu+dq4HK0xp0VQlyS/3H+fvPo191E10XxZteGs5YdWgvGX7VTud54Tet8tzn/rtHHeXIL+BzL
 YwzQNXtF/tCujXjzX5JalRM9LJcBMOapgdVo2D4EIPijgw61YeJP+CorbdC5ktqxnvOeiPKH4
 mUscYSg5o+In4ikGhjBxnKxF8uYwrLujr00/TMdNgwnW46MOqeyIlphtPpeI6ElgzGFRUX4Sc
 6n4mvxvqXJ5NvEEi1kLtpZVg==



=E5=9C=A8 2024/10/8 21:48, hs wang =E5=86=99=E9=81=93:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:56=E5=86=99=E9=81=93=EF=BC=9A
>>
>>
>>
>> =E5=9C=A8 2024/10/8 17:18, iamhswang@gmail.com =E5=86=99=E9=81=93:
>>> From: Haisu Wang <haisuwang@tencent.com>
>>>
>>> The dealloc flag may be cleared and the extent won't reach the disk
>>> in cow_file_range when errors path. The reserved qgroup space is
>>> freed in commit 30479f31d44d ("btrfs: fix qgroup reserve leaks in
>>> cow_file_range"). However, the length of untouched region to free
>>> need to be adjusted with the region size.
>>>
>>> Fixes: 30479f31d44d ("btrfs: fix qgroup reserve leaks in cow_file_rang=
e")
>>> Signed-off-by: Haisu Wang <haisuwang@tencent.com>
>>
>> Right, just several lines before that, we increased @start by
>> @cur_alloc_size if @extent_reserved is true.
>>
>> So we can not directly use the old range size.
>
> Thanks for the review.
>
>>
>> You can improve that one step further by not modifying @start just for
>> the error handling path, although that should be another patch.
>
> Indeed, modify the start value based on @extent_reserved in
> error path only is tricky and ambiguous.
>
> I agree to keep the fix as simple as possible (like the previous patch),
> since commit 30479f31d44d ("btrfs: fix qgroupreserve leaks in
> cow_file_range") assigned to CVE-2024-46733 already.
> A simple fix is easier to port to stable branch of different versions.
> Also the possible change to keep @start is more like an
> enhancement instead of a fix.
>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>
> To make sure we are on the same page of keeping the @start
> unchanged. I write a POC below for your opinion.
> (Anyway, i will think/test again before convert POC to a PATCH.)
>
> The @start will advanced in every succeed reservation, the
> @cur_alloc_size can represent the @extent_reserved state
> instead of using a standalone @extent_reserved flag.
> In this case, the @start region no longer need to be modified
> based on @extent_reserved state in the error path.

This snippet looks good to me.

Thanks,
Qu
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5eefa2318fa8..0c35292550bd 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1341,7 +1341,6 @@ static noinline int cow_file_range(struct
> btrfs_inode *inode,
>          struct extent_map *em;
>          unsigned clear_bits;
>          unsigned long page_ops;
> -       bool extent_reserved =3D false;
>          int ret =3D 0;
>
>          if (btrfs_is_free_space_inode(inode)) {
> @@ -1395,8 +1394,7 @@ static noinline int cow_file_range(struct
> btrfs_inode *inode,
>                  struct btrfs_ordered_extent *ordered;
>                  struct btrfs_file_extent file_extent;
>
> -               cur_alloc_size =3D num_bytes;
> -               ret =3D btrfs_reserve_extent(root, cur_alloc_size, cur_a=
lloc_size,
> +               ret =3D btrfs_reserve_extent(root, num_bytes, num_bytes,
>                                             min_alloc_size, 0, alloc_hin=
t,
>                                             &ins, 1, 1);
>                  if (ret =3D=3D -EAGAIN) {
> @@ -1427,7 +1425,6 @@ static noinline int cow_file_range(struct
> btrfs_inode *inode,
>                  if (ret < 0)
>                          goto out_unlock;
>                  cur_alloc_size =3D ins.offset;
> -               extent_reserved =3D true;
>
>                  ram_size =3D ins.offset;
>                  file_extent.disk_bytenr =3D ins.objectid;
> @@ -1503,7 +1500,7 @@ static noinline int cow_file_range(struct
> btrfs_inode *inode,
>                          num_bytes -=3D cur_alloc_size;
>                  alloc_hint =3D ins.objectid + ins.offset;
>                  start +=3D cur_alloc_size;
> -               extent_reserved =3D false;
> +               cur_alloc_size =3D 0;
>
>                  /*
>                   * btrfs_reloc_clone_csums() error, since start is incr=
eased
> @@ -1573,13 +1570,12 @@ static noinline int cow_file_range(struct
> btrfs_inode *inode,
>           * to decrement again the data space_info's bytes_may_use count=
er,
>           * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
>           */
> -       if (extent_reserved) {
> +       if (cur_alloc_size) {
>                  extent_clear_unlock_delalloc(inode, start,
>                                               start + cur_alloc_size - 1=
,
>                                               locked_folio, &cached, cle=
ar_bits,
>                                               page_ops);
>                  btrfs_qgroup_free_data(inode, NULL, start,
> cur_alloc_size, NULL);
> -               start +=3D cur_alloc_size;
>          }
>
>          /*
> @@ -1588,11 +1584,13 @@ static noinline int cow_file_range(struct
> btrfs_inode *inode,
>           * space_info's bytes_may_use counter, reserved in
>           * btrfs_check_data_free_space().
>           */
> -       if (start < end) {
> +       if (start + cur_alloc_size < end) {
>                  clear_bits |=3D EXTENT_CLEAR_DATA_RESV;
> -               extent_clear_unlock_delalloc(inode, start, end, locked_f=
olio,
> +               extent_clear_unlock_delalloc(inode, start + cur_alloc_si=
ze,
> +                                            end, locked_folio,
>                                               &cached, clear_bits, page_=
ops);
> -               btrfs_qgroup_free_data(inode, NULL, start, end - start
> + 1, NULL);
> +               btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_si=
ze,
> +                               end - start - cur_alloc_size + 1, NULL);
>          }
>          return ret;
>   }
>
>
> Thanks,
> Haisu Wang
>
>>
>>> ---
>>>    fs/btrfs/inode.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index b0ad46b734c3..5eefa2318fa8 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -1592,7 +1592,7 @@ static noinline int cow_file_range(struct btrfs_=
inode *inode,
>>>                clear_bits |=3D EXTENT_CLEAR_DATA_RESV;
>>>                extent_clear_unlock_delalloc(inode, start, end, locked_=
folio,
>>>                                             &cached, clear_bits, page_=
ops);
>>> -             btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_siz=
e, NULL);
>>> +             btrfs_qgroup_free_data(inode, NULL, start, end - start +=
 1, NULL);
>>>        }
>>>        return ret;
>>>    }
>>


