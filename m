Return-Path: <linux-btrfs+bounces-12669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E459A7541C
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 04:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7077A6DDF
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 03:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0F30100;
	Sat, 29 Mar 2025 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nqNPK5TT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBA29A5
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743218333; cv=none; b=FqTw6Zd97kfBOib3xVCFOf0hukZnGqnRrNGILfZEv5Z2lWhBV684qWr/yrj0eTqDHh6075Ixoqc3ieISd+1BUCQWlWSSgZnDbMznBYSCaKV9DgunyXiwOHeGYuutXWJzvwmMSnbQqM2Lqi6EH1Z5bbZzXbetvCwFKQQbGCaz1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743218333; c=relaxed/simple;
	bh=ZWU9/0iEV41JXy79D1BB1Q8zT8HRyUraTfN45hsuEoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iG3+IjP0ZeX+ai3GeNTz6A3m6n4Zeodh9GfYIrvXX7LoJQaLTiXISVMg02HBWHCGyjjhGmg9EHDFcS2vGIFhNlyVsp53pL94BB0lciZh+mwYeeYSjNL8wateKP/I84EN5S372X+CB3ByEDaG6XAB8GtjlXXrOjRyKYW9ltgqRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nqNPK5TT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743218328; x=1743823128; i=quwenruo.btrfs@gmx.com;
	bh=ns7emykhs/9vGwC8e9Yzf18Rr6HbIsVr+Fc8+0pnW/8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nqNPK5TT5Pkwk2deeEcXahbtToSzCTFz+wTPgpvafoIuwAoSaM5FNBZVTQyB1ciF
	 wsHVTEVj4n54U6+e3xroatrdutVqJbJsCotYRmrh3EMWdUKKQ5uwpjSrDYSmXwIF6
	 zRHRv2j+jlWSWpRnDCEYxgTF0wCygLqWN4sSfkhQnhkwft31LtS3BpFNKVJH50zEc
	 /9tF5XYNEVBN7CQXFWYv42IRtWeSf++fzUp6BvWL+rU8HtPqxxk+r1LSDOJBpzfMC
	 hPx+ZmMpRFTO3fA/SDPh2Hm/WgFEZ5o1ugG8tJPjlPywzyK+hMaGovWEHv5FJ4aUu
	 +i7tf3eSGfjDG1kqtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1ps8-1u0Ze32LW4-00Gy3F; Sat, 29
 Mar 2025 04:18:48 +0100
Message-ID: <4e47199a-8257-457f-933d-d310e67bdd64@gmx.com>
Date: Sat, 29 Mar 2025 13:48:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: prepare btrfs_punch_hole_lock_range() for
 large data folios
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1743113694.git.wqu@suse.com>
 <64d8a34bed1360c4771ead6a66e3c6df0ab86a7f.1743113694.git.wqu@suse.com>
 <CAL3q7H4hxQbKfcuW+hPEFkiJk3KX9bRzNbjLms+Z1z_U=9PNPw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAL3q7H4hxQbKfcuW+hPEFkiJk3KX9bRzNbjLms+Z1z_U=9PNPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C3fMgjg1xPWWWHgVKztucxGrt+TdjU16oXYpdTik4frSJjW5zrF
 180brVNYjdH5/xq5jvu7x7RMT6DdCcW/h528Wodhm2CSxeMAZrNCU3mQOc8Dwrc0Zylf6WE
 jQG4OCwq1W5K8zc/u+shK3XqP/m97Sc87xCqL0qiQgYIeAT/pE8RtUNgYDmqaAidSahgI77
 nBZ/HbiV91xVXof2Tng2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sSf7e8q88Qw=;wbHloDvQsngTLe0C/slCKrQ6zcI
 RA2/AZG1QNmResR3UnxPGQb24qu5aNclCLrfRURikN/JJKSv5UNoGi2s6ficn0qkblspun2w3
 +WrT9vnYWEOEFd+wMoc3I1vSW+1Qz6Vw+Niek4AxIUWlFEInvmZwT2vXyXM7641yoJoOo9siX
 OkOD+e+uV8NJ2hdgCkaznc2YAvngCebRl/PR15/9Qu0HOEryO444GP8untTQHiFssK2POsgwE
 n2kPqcG/Osou+i5zNSC0PGvXgfKuRGyiUi+dFiBw7i2/3o/D/8TNDN7uAx7QGvDJVfV/b60Tk
 uJW72xeFvpdW7u0WFMcmuEycHB6mCfZa+/jXCJC2o5TDknfZoq4XQKF2HY56dZzWfDXKr9L4q
 BjaHnOscuaCiImNv52oGeRYpmK0K3rwa61nM7FeOgM7CW/DlU4QAUs2Y7d24BkrPcusViHjwN
 lnuEcR0F4yah9Ik6YgMc2rr0O1248IlpodfN3xyj83Zhw1q+E5uzsnm457H5jBo/r9Qt1DnMo
 nZWciT34uZvZJOn5I/bopplDCwdnG8s3CJO/DXFQdTN+zE2Gv8m0eonEG7zHue8l0fSow29hS
 YBF2rT+roEHcE8JbMcq2ZaJ80P26OwrVS63/EOCwHGENj2ktqx9hpnZgc7ZIxJTf0iQikoj9y
 yu1m4Hn0Jbg+gEn8Jn2X70EFoyMouMM1kz4RpLXwJjPkjTY7B2WzsayoTopMKeMtdx2zxbir1
 fvM1SbPXAbphT/jAbpDmBS3Pu7liSdwPsgxv63B1pFgUi3NFqpRIN7+MLG54r1XXHuWbG9u7q
 AlMushqvt6dpRDZUQFrUnOTp5/moNJLwa7fng//mxXVkvgFdTM/Ar+KhUhIfqw5Mp7IKrPkX6
 qplskg2n5kVFRAZokquJ+ruj1ymrUW7ZsY8YkvFc2Yv+5NxMiwDLUgHs9aOix8kXiDhUoVGQM
 0sc6dy0bsbv0402+mOHppPa2Y/6ZBzClvJfO8jluJLp3/cX4WcqJMJHjK3r71M16K50jXAmP5
 70zx9auQgVvlowQLxWJ694etSlhdePPOwoTITyALVDWRCi+zkSj4/TimsafYeBI8UtdzD85lS
 /xZnjeWAjvqJ+JPxP0cBiJGO+Fkkm7nzjolE46eKa3eE9cfsiMXSS+VKWAqlPNkG4NECJ3gEJ
 Y+Cz5tdBiXdIJfbIZoj0YeMNxy7gXwR/pXxW2/YsZpGRL2A3PPojFp4mEV4/OynS2qUavhVck
 fxVPyJIHyYnHNaE6hCXX6WTjR9rQH2N0AAvDYIyWZDEZfqBp/IIWIlQHMMFIO3PWwSaNa5iT9
 f1rydAc+Ab8rIZVGm6fU19Tdk/xi5lJ5NoH5bpbSCci5O0aECGTWm/Ji1O+FCPJGHhY/Wpyi8
 BS8ZAMXQqG4PnaAbVnX5Qf1l44fOi+BSzMjdsA39/ZceAjnty1RbPHYfEVAokK8bQo7cRDwcL
 7x9zv4TxJr1T06yeoJBtNhhUN3QE=



=E5=9C=A8 2025/3/29 04:27, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Mar 27, 2025 at 10:33=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The function btrfs_punch_hole_lock_range() needs to make sure there is
>> no other folio in the range, thus it goes with filemap_range_has_page()=
,
>> which works pretty fine.
>>
>> But if we have large folios, under the following case
>> filemap_range_has_page() will always return true, forcing
>> btrfs_punch_hole_lock_range() to do a very time consuming busy loop:
>>
>>          start                            end
>>          |                                |
>>    |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
>>     \         /                         \   /
>>      Folio A                            Folio B
>>
>> In above case, folio A and B contains our start/end index, and there is
>
> contains -> contain
> index -> indexes
> there is -> there are
>
>> no other folios in the range.
>> Thus there is no other folios and we do not need to retry inside
>
> is -> are.
>
> "Thus there is no other folios" is repeated from the previous
> sentence, so it can be just:
>
> Thus we do not need to retry inside...
>
>> btrfs_punch_hole_lock_range().
>>
>> To prepare for large data folios, introduce a helper,
>> check_range_has_page(), which will:
>>
>> - Grab all the folios inside the range
>>
>> - Skip any large folios that covers the start and end index
>
> covers -> cover
> index -> indexes
>
>>
>> - If any other folios is found return true
>
> is found -> are found
>
>>
>> - Otherwise return false
>>
>> This new helper is going to handle both large folios and regular ones.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/file.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++-=
-
>>   1 file changed, 49 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 5d10ae321687..417c90ffc6fa 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -2157,6 +2157,54 @@ static int find_first_non_hole(struct btrfs_inod=
e *inode, u64 *start, u64 *len)
>>          return ret;
>>   }
>>
>> +/*
>> + * The helper to check if there is no folio in the range.
>> + *
>> + * We can not utilized filemap_range_has_page() in a filemap with larg=
e folios
>> + * as we can hit the following false postive:
>
>   postive -> positive
>
>> + *
>> + *        start                            end
>> + *        |                                |
>> + *  |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
>> + *   \         /                         \   /
>> + *    Folio A                            Folio B
>> + *
>> + * That large folio A and B covers the start and end index.
>
> covers -> cover
> index -> indexes
>
> Anyway, those are minor things, so:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>


Thanks a lot for the review, although there is some more fixes needed in
this patch.

Thus I'll resent with all your comments addressed, but not with RoB tag
in case you find something else wrong in the fix.

>
> Thanks.
>
>
>
>> + * In that case filemap_range_has_page() will always return true, but =
the above
>> + * case is fine for btrfs_punch_hole_lock_range() usage.
>> + *
>> + * So here we only ensure that no other folio is in the range, excludi=
ng the
>> + * head/tail large folio.
>> + */
>> +static bool check_range_has_page(struct inode *inode, u64 start, u64 e=
nd)
>> +{

Fsstress exposed rare cases where btrfs_punch_hole_lock_range() can be
called with a range inside the same folio:

   btrfs_punch_hole_lock_range: r/i=3D5/2745 start=3D4096(65536)
end=3D20479(18446744073709551615) enter

And since both @lockstart and @lockend are inside the same folio 0, the
page_lockend calculation will be -1, causing us to check to the end of
the inode.

But then we can hit a cases some one else is still holding the folio at 64=
K:

   check_range_has_page: r/i=3D5/2745 start=3D65536(1)
end=3D18446744073709551615(281474976710655) enter
   check_range_has_page: found folio=3D65536(1) size=3D65536(1)

Then we will hit a deadloop waiting for folio 64K meanwhile our zero
range doesn't even need that folio.

The original filemap_range_has_page() has a basic check to skip such
case completely, which is missing in the new helper.

Will get this fixed and resend.

Thanks,
Qu>> +       struct folio_batch fbatch;
>> +       bool ret =3D false;
>> +       const pgoff_t start_index =3D start >> PAGE_SHIFT;
>> +       const pgoff_t end_index =3D end >> PAGE_SHIFT;
>> +       pgoff_t tmp =3D start_index;
>> +       int found_folios;
>> +
>> +       folio_batch_init(&fbatch);
>> +       found_folios =3D filemap_get_folios(inode->i_mapping, &tmp, end=
_index,
>> +                                         &fbatch);
>> +       for (int i =3D 0; i < found_folios; i++) {
>> +               struct folio *folio =3D fbatch.folios[i];
>> +
>> +               /* A large folio begins before the start. Not a target.=
 */
>> +               if (folio->index < start_index)
>> +                       continue;
>> +               /* A large folio extends beyond the end. Not a target. =
*/
>> +               if (folio->index + folio_nr_pages(folio) > end_index)
>> +                       continue;
>> +               /* A folio doesn't cover the head/tail index. Found a t=
arget. */
>> +               ret =3D true;
>> +               break;
>> +       }
>> +       folio_batch_release(&fbatch);
>> +       return ret;
>> +}
>> +
>>   static void btrfs_punch_hole_lock_range(struct inode *inode,
>>                                          const u64 lockstart,
>>                                          const u64 lockend,
>> @@ -2188,8 +2236,7 @@ static void btrfs_punch_hole_lock_range(struct in=
ode *inode,
>>                   * locking the range check if we have pages in the ran=
ge, and if
>>                   * we do, unlock the range and retry.
>>                   */
>> -               if (!filemap_range_has_page(inode->i_mapping, page_lock=
start,
>> -                                           page_lockend))
>> +               if (!check_range_has_page(inode, page_lockstart, page_l=
ockend))
>>                          break;
>>
>>                  unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, loc=
kend,
>> --
>> 2.49.0
>>
>>
>


