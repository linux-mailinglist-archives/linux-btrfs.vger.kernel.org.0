Return-Path: <linux-btrfs+bounces-11282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE8A285F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 09:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B745A7A5754
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 08:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC02216617;
	Wed,  5 Feb 2025 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="l5mu7ql8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44825765
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738745459; cv=none; b=MnkmkDh1AIxlMVY7zISFsgNTF58Pu82kq5OrK/kOAyt95Eg3smJqexUL3HYLpj62klvqaSFEsjKNRR2sk4rJw+9NCwBXJeA4b0eFldIYyAtEiMFsCR31XLS0sALZD7Gt4xS+/Qwts3k5fpG4QHJ76lS9sxE+Q8sGcOG16FItF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738745459; c=relaxed/simple;
	bh=4Qd0NYz8NKNRVFP89r7rRfIy3l+HC2JwPvwrkSxJHOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzpkCKzDq63BVySj5RHQ5PxbZ/R9gXWnyDkhF1tS3OIQuxHGlwrH5CfDogqtYpbaQaSmENahD4k1zgMbwbe5UGqqczo8NquwJNI18WGQrz0RAI/LBY/iO7jnvS1konssocwVmjsP+svyW6Z5hzv53wlXQFAakuKRyeQNdefpdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=l5mu7ql8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738745455; x=1739350255; i=quwenruo.btrfs@gmx.com;
	bh=IYJaf+QpjmXO9BgwOUjwu5HTT0mg4Sr3GSpkZXsibR0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l5mu7ql87uby2gHTvpJ5yDzvdlpfZug4hIG3UPppBW1t0oGUuSfH37V6pFbmOWuW
	 SL82UX8U8lmuT7ZXwAsJlhuI7qOkczSKbRaLJYUSlCwGOvGBMcbV3Ue7uSsilXxB5
	 XCIZuZ5/wKDb459p43m3cjty/NF+Rql4YrmQfECLr7Eg3z1b0MbwHMH0wK/SJ3brK
	 PI/ANUgotvixZ02Se09Zu5upQ1IPab9dSJc2Jr/IIUXD9Q+C/gukksso+SDhczV0R
	 R4CMw1T3I6MuUatMvth4ToPMsJY3rNG5XgJdK3vrrbGe94Uztxpr6ISzBOPLSBRjp
	 WyaSaIQkOK0LXVgujA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzBp-1twzVv3t69-00IhRb; Wed, 05
 Feb 2025 09:50:55 +0100
Message-ID: <9fba7307-fb07-4d83-8d25-295dc5562e06@gmx.com>
Date: Wed, 5 Feb 2025 19:20:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix stale page cache after race between readahead
 and direct IO write
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <24617a89550bed4ef0e0db12d17187940de551b0.1738685146.git.fdmanana@suse.com>
 <a94fb3db-ac05-4fea-afda-df42cd9286b1@gmx.com>
 <CAL3q7H5nYQiV++o6jtOc98S1P7B1O2kwFKXa8e2u-GzAdJAaoA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5nYQiV++o6jtOc98S1P7B1O2kwFKXa8e2u-GzAdJAaoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xxTTmyV/19Zf8ELzFUSWh48yG83T07sirqSm9EeZzcgiUILIcCd
 QAb8aPtWkOCtRQ/JrVv0jM1vdGvKzTb7282kKdjzhAgn5qOHvEsy4/NfVlVEKQDpgWsstK5
 KRB9oQDiKBCGpm7dP0AK1RMUJL7rIO23EqToVwBNh8Bgl5aub8Li7IKxe6CntkuNl7KZoK9
 2QaqEqQg2AoLQB2Xjr7BA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IjlqcOu9Eeg=;B7TzpKj4H66yV66WePzh8EYIsdu
 kVE8IvQkUBrvAxcY6vUphnYwlsZke7sjLgRU7LsU6QQmSDSURy9oQL7o4Y+4Cf6mq1GL9IQIu
 AT1sTqFlHc2QdPTSGTDqfHx5m2bcfmkgNLIKwDX0XRelzPG4VpruzZe4HO3q3IPVKy/3yunK7
 cxcote+zv4IiCfrOOcgk6bp0ngZkOGTPMrQNUOHluoJMeKVkpgqB3Xx654zSqaJ2WgORXSTrW
 3DNRSuyk704X1OpBwCA0EoHsNPx3BhlkhG9xpUc97w4IA5BEadydiKWnTCJfio7euiZtRhBTn
 e5YkQl5MfxzEIRWsiqIt8kh/qBIjYT5O4uRLfRr+Vy1QOezGJgke3LptTjJVUc1Wybck+RIjV
 vb3ClRJ4+DVx+khafLLBzcSAdBMuNjk5Nid36XukSr6Z91ayFDqOl7pMVuK51wlrUCv7e5X4j
 84OOcR9IU7deVhirVGvnpQ9JxjhkzkaA/hALUVzDw3vlgrJ8k0Dq9mFBTor0Am5hCl9ZSk6bn
 1T/DDmrelTgMvzT1cvi1pz0tAm6idQgz0pyamgvjinHbLshKgVQSaSbXtAgK+FZjQkurWIBaW
 6BOOo/ZBJfta2rCnH/DQjll7h+Am1W0A1W75NrsRfkX7fWvt46ImcpUHEZBGdwmSYeSBxXvrM
 4hS4VqGLm1vv/7HqjS7Lp0Vu2K1N8OXwYs79/uarDrxseD6tK/Ev4meQasPCdOGI6oj6xtln8
 bFfLmzijuAsOVqiw6PHUy68suc8MR23QSxxr3is3B0se0ALwBYvtNqCRDry6noScyhLgGLXj/
 0GtNFp1J+IkdMlVoaYBA7ZxakLStGDFO94vL2qZQXDKETgwA2XznbhLIoFaYElfldL2X8yrd4
 JD2xmWZbBZZkP28heH7tqK3dz41YIKzxnSK2+h703aHHsyR6wUZu0BxY4r3pFO+Ik/OaXcK5t
 o3IEvjKlzvP7i2i6TANUOGssOiQWeW/4Vegc+R6lYKE1AtS5M7lBj8wvW2B58zAgj/saBQIPM
 YkCfufsQdNW7u72n4zRkIewTzoP6NDS5RQz3wGDS1l8/TShRucLK3g4btEDkv/tbtsOBgQwOK
 5n3b592n90OUQvDJjodq00UP/NrmETPtMcsKlfhlqZWcUFE6GFMKKJH6MZiSKW4CO1iHqoled
 zpUvuMrJJNP8zGtVAxSIBRLrbSEV63K5cwNouTAz9YbIfn1wDtzNoOQiZGmCPqYA3CeCvyJhw
 q6t9uN+kDAgCsE/mYE0gHVJnwKhj0lpGUvPkn7eNMkCi1cPMB8JWu/wZrcvuL17hLHTtupjl1
 Px3XR7qSQAt7m+8d0M+FdmQAA==



=E5=9C=A8 2025/2/5 18:54, Filipe Manana =E5=86=99=E9=81=93:
> On Wed, Feb 5, 2025 at 5:15=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
[...]
>> I'm not confident enough about this lock, as it can cross several pages=
.
>>
>> E.g. if we have the following case, 4K page size 4K block size.
>>
>>           0       4K      8K      12K     16K
>>           |       |///////|               |
>>
>> And range [4K, 8K) is uptodate, and it has been submitted for writeback=
,
>> and finished writeback.
>> But it still have ordered extent, not yet finished.
>>
>> Then we go into the following call chain:
>> btrfs_lock_and_write_flush()
>> |- btrfs_start_ordered_extent()
>>      |- filemap_fdatawrite_range()
>>
>> Which will try to writeback the range [4K, 8K) again.
>
> But you just said above that the writeback has finished...

You're right, for the writeback finished case, the page is no longer
dirty and write path will not try to hold the lock.

So it's still only possible for subpage with partial uptodate page support=
.
Not possible for the current cases.

>
>> But since the folio at [4K, 8K) is going to be passed to
>> btrfs_do_readpage(), it should already have been locked.
>>
>> Thus the writeback will never be able to lock the folio, thus causing a
>> deadlock.
>
> readahead (and readpage) are never called for pages that are already
> in the page cache,
> so how can that happen?

Mind to be more explicit on the readahead requirement?
E.g. if we have a folio that's dirty but not uptodate, what will happen?

I know readapge can be called on page that's already in the page cache,
especially for subpage cases (although not for now).

E.g. 16K page size, 4K block size.

    0       4K       8K      12K     16K
    |       |////////|               |

Where [4K, 8K) is dirtied by buffered write, which lands exactly at [4K,
8K).

It's not possible for now, because at buffered write we will read out
the whole page if the write is not page aligned.

But XFS/EXT4 allows to skip the full page read, and just dirty the block
aligned range, and I'm making btrfs to support that.
(https://lore.kernel.org/linux-btrfs/cover.1736848277.git.wqu@suse.com/)

So in that case, if we hit a such dirty but not uptodate page, will
readahead still try to read it, because the folio is not uptodate.

>
> And why do you think that is specific to the case where the range
> covers more than one page?
> I.e. why doesn't the current scenario of locking only [4K, 8K) doesn't
> lead to that?

Right, the dead lock is really limited to the subpage + partial uptodate
case.

But I really believe, without such subpage mindset, we are never going
to support larger data folios.

>
>>
>> Or did I miss something specific to readahead so it will avoid readahea=
d
>> on already uptodate pages?
>
> It will skip pages already in the page cache (whether uptodate, under
> writeback, etc).
>
> If you look closer, what this patch is doing is restoring the
> behaviour we had before
> commit ac325fc2aad5 ("btrfs: do not hold the extent lock for entire
> read"), with the
> exception of doing the unlock in readahead/readpage instead of when
> submitted bios complete.

I'm fine reverting to the old behavior, and so far it looks good to me.

So I can give it a reviewed-by:

Reviewed-by: Qu Wenruo <wqu@suse.com>



My concern is, with the multi-folio lock back, what is the proper way to
avoid the subpage deadlock for subpage partial uptodate folio, and
future larger data folio?


My current fix will not be feasible, as it relies on the single folio
pointer, to determine if btrfs_start_ordered_extent() should skip
writeback, and now we have multi-folio range back.

Maybe we should just make those
btrfs_lock_and_flush_ordered_range()/btrfs_start_ordered_extent() to
avoid writeback for those read page related call sites?

I know it's not your responsibility to bother those subpage cases, but
if you can give some ideas/advices, it would be great.

Thanks,
Qu

>
> If there was a possibility for such a deadlock, we would almost
> certainly have noticed it before,
> as that has been the behaviour for ages until that commit that landed
> last summer.
>
>
>>
>>
>> And even if it will not cause the above deadlock, I'm not confident the
>> mentioned subpage fix conflict can be proper fixed.
>> In the subpage fix, I can only add a folio parameter to
>> btrfs_lock_and_flush_ordered_range(), but in this case, we have multipl=
e
>> folios, how can we avoid the same subpage dead lock then?
>
> About the subpage case I have no idea.
> But given that readahead/readpage is never called for pages already in
> the page cache, I don't think there should be a problem even for
> subpage scenario.
>
> We also have many places where we lock ranges wider than 1 page, so I
> don't see why this specific place would be a problem.
>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>
>>>        while ((folio =3D readahead_folio(rac)) !=3D NULL)
>>>                btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_e=
m_start);
>>>
>>> +     unlock_extent(&inode->io_tree, start, end, &cached_state);
>>> +
>>>        if (em_cached)
>>>                free_extent_map(em_cached);
>>>        submit_one_bio(&bio_ctrl);
>>


