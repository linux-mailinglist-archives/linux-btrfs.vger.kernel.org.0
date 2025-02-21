Return-Path: <linux-btrfs+bounces-11708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62491A402E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 23:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E4D1897619
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D96205500;
	Fri, 21 Feb 2025 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qgakVPCP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186681FF612
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177574; cv=none; b=gwaPnGG1eugGOU8QHfoOUCNQSLs7UKxIYEosUih42V3d9VjRw5ogwlMZyZHlyrloUaHcSN+UVHLdbfcA1GjvXFSTU1dAp1LEYn4DdX+/YFh0LHNFDq3GcwgEPrXGzP1cq67KV8li4aQmJJvy9+iUu7wYXljBCjSb6uDS5zhpc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177574; c=relaxed/simple;
	bh=lHXtJDAJJHP8uTr2aDK75Di04jbBfXXXJGdKErGnVVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4kBJO+7eqFA201bfcKxWL+rGelZEcNq+CPfblwlm0wScct+YFLi25lO0NgY4UCUmYExClD9gRDN2eljs34UoiTeteK2pNaeH8hPeU52lboDKwiBITaEJp3xjF0xhMK5UFlRQJ2CVwhz6PaiX4oGNS+RNu1LidGwvW594xpXuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qgakVPCP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740177565; x=1740782365; i=quwenruo.btrfs@gmx.com;
	bh=qKv5Vwbc1IkQouFbi2eBV6JSQqt8/eYWCHGn0jYatf8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qgakVPCPsmMg2XXSoUhfHTL+5s301Pl+cS5wldIDOmR7quX619/Nim+x1j+NDNNY
	 cbWHAYBUQZXW7v4pQgqdwgz4VHHoNjnn5BWqNfoTSoKEnt4xoidbi0rvrGxSurVeA
	 r0c7VDI9uinOb0XGZV9bHjYY5pw5NGjFEjcCZFAhZBYFcyTB8BCIpa7gL4zWPgDJ+
	 RRiRXVrHoAEzQqX6/OhOX4qACQx3CFARr0edu3KAXawPRIqLjMKpz2fnSdYBJclGA
	 Z0egexOC+nDBYhpFpxcr6r6Azw5x/h67JQWM6+p65GxUFIMdg+wQ+F39ulqdhvmmY
	 yaMbtt5Qz9455akNmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1t28r03Qcc-00cgqj; Fri, 21
 Feb 2025 23:39:25 +0100
Message-ID: <64782982-20d5-41e7-81d0-6960f3b5c0ee@gmx.com>
Date: Sat, 22 Feb 2025 09:09:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs: fix inline data extent reads which zero out
 the remaining part
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1739608189.git.wqu@suse.com>
 <4e0368b2d4ab74e1a2cef76000ea75cb3198696a.1739608189.git.wqu@suse.com>
 <CAL3q7H5yrvxK5QFeCmfU+_sMmxpFyfcL_W8CALcCPLjkbbJHLQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5yrvxK5QFeCmfU+_sMmxpFyfcL_W8CALcCPLjkbbJHLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t5ffWz7q0owyZwjUBkCE5xeiIRxbIE9TMQj9j7gZbiZXrE1fLT3
 h3tQSKez6qbO2iWMuvJ5mpU6F39enSW4BJyedWhcVPtq1ltIIHtZmEz+s4gQBw9mncaOvnA
 kzPaVEMj12Y5268iY8mq25C2HkVxs8Qf/MRuBeoyz5DVaPuS7MxsT8ZRtNiBRs87Df0VjIv
 OQm4XgmVV/zHXCpxLmEQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yYD5Xb3OC2M=;qbJN2zY5TM4UIkqU5rOYO8+ZomR
 W+Ly7fe8dgQrptyxqHLXork1XrLR0HvBiYr+dFBuzPCfgAgKsb6s+cKX3QYiD60B6vUX3pLZz
 oci4tOHrTLJsyGLEsdMRrmgM2tT7q2phJ6INi9BUIUAE6/ht7xH0YumEZTx3BD3qwxGhLPQPC
 f5gDpuEq+CT+ZeFnmSKn219sewZjhhqX8eiZrZVINO0M+djcobqM5ttcFjAl0olqFJSxWDTQB
 2k+HE26/gOWykc0OBsavTuIus6ym67vfBzQLM7QOTHgR5DpY4rEWnd5OUpSAjBX82EoDCfllB
 b08Mx9g8fjndjPS060LalMbwFTH/U++uH7R6Nh9VjgynZaGsDBOxE7L/WWXua4fe2JbQ/87jJ
 7Eqeh41bFZiZxn+IhFZvloHaoF3F1iuHnPV+wPWAaDqOl3fhuQlhw9WO9s3opqW5pFKA/zKHi
 0zUQNFLYBneBXFxPSDjFMz4xf9Yg3JG/yhADbuKzABU9zOLGR9+CgksYi86jaIZMwmdnCbn63
 Tj1uiBk+OGeaCT8AjUk8KwMWz/ab07eq4HfVUJKyaNxJjZkKjl2KZT6rTxyKYtmYrFCZtkrqw
 bFeIbZbgrEggpSJ3qrjJWbYQaVqR6UmB4lzsq08SwwRpjcgQfNfSl5kHVl1/3goKZxTH8Y14u
 U1w+IaS9I5/VmOnFykuI4v0/s7/uFAmUlWN9jPHDOjWiholYsB0p0XRLF/cZmeF+3/N65/ach
 g5MVXYbQU4P5y9Y+zRl7xA3JLHzNd94XKsdCYCsKZLkcJ19ebFeDDRrYWwicPEY8PFtLWZkR9
 8yl7Jd3jeEYUupcTngfxQ8PovmRBvEAaBBpgNh/j5tWtRunSoG1zObDgZ7xM2n0Nf7uSS7Rmb
 wNKOfUvZcp+bK7ZR34ZWT+NIJnUzbfsIYGAsnLAOCt1cuQYeX8qWrRohh1kJ6QMWzSoQdSGYy
 0WO6BRA7ZPVcRhRFawlyulU9PwGaPmqRTJoAKS/W/CZZ3pJrt00DRZeW2v7K3tcZE7vsHZsiO
 5Qo20GGnTCQBmdbQ5XdeAwGQX8up58GnYYEb/B/UpKjNWuuU6kUJa7omLrGfZv1vcLwUXnW3H
 1CY/8OrpSJGf034fsdTPkj+n2hgBcI4eraJ7Djhg59XkC2rUS9WVGbtfAfiE7RjHVXqND3hLR
 rrale94J+JBLmWx/Sk7ffEfh7yMB56O4gxCrXvlnjd2aeU2u8QH88tfb92xxLhKJCsxfCL7mV
 xdpxPVIrkzO+v+t62ISHgIKigDVAdmhSJmArkfMqO2+50Z4dNJXWexhwjHXoQb/UvbspsUvA/
 C19JJxd38XM/nTy3g0FU/SH0e5shwRzsKj6EoQ55Br1fArp5ho1OGiNdo2Zj1AN8652yjA8CA
 3txOlJ3HxTxhm7CQzhubnjRHsevz+3yXVmtpKNZnNpaIxkVyN+VeVQ6zuG



=E5=9C=A8 2025/2/21 23:02, Filipe Manana =E5=86=99=E9=81=93:
> On Sat, Feb 15, 2025 at 8:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG in DEVEL BRANCH]
>> This bug itself can only be reproduced with the following out-of-tree
>> patches:
>>
>>    btrfs: allow inline data extents creation if sector size < page size
>
> At least this patch could be part of this patchset no? It seems related.
> It makes it harder to review with unmerged dependencies.

Sure, I can merge all those patches into a much larger series.

>
>>    btrfs: allow buffered write to skip full page if it's sector aligned
>>
>> With those out-of-tree patches, we can hit a data corruption:
>>
>>    # mkfs.btrfs -f -s 4k $dev
>>    # mount $dev $mnt -o compress=3Dzstd
>>    # xfs_io -f -c "pwrite 0 4k" $mnt/foobar
>>    # sync
>>    # echo 3 > /proc/sys/vm/drop_caches
>>    # xfs_io -f -c" pwrite 8k 4k" $mnt/foobar
>>    # md5sum $mnt/foobar
>>    65df683add4707de8200bad14745b9ec
>>
>> Meanwhile such workload should result a md5sum of
>>    277f3840b275c74d01e979ea9d75ac19
>
> So this is hard for us human beings to understand - we don't compute
> checksums in our heads.
> So something easier:
>
> # mkfs.btrfs -f -s 4k $dev
> # mount $dev $mnt -o compress=3Dzstd
> # xfs_io -f -c "pwrite -S 0xab 0 4k" $mnt/foobar
> # sync
> # echo 3 > /proc/sys/vm/drop_caches
> # xfs_io -f -c "pwrite -S 0xcd 8k 4k" $mnt/foobar
> # od -A d -t x1 $mnt/foobar
>
> Now display the result of od which is easy to understand and
> summarises repeated patterns.
> It should be obvious here that the expected pattern isn't observed,
> bytes range 0 to 4095 full of 0xab and 8192 to 12K full of 0xcd.
>
> See, a lot easier for anyone to understand rather than comparing checksu=
ms.

Thanks a lot, will go that reproducer in the commit message.
>
>
>>
>> [CAUSE]
>> The first buffered write into range [0, 4k) will result a compressed
>> inline extent (relies on the patch "btrfs: allow inline data extents
>> creation if sector size < page size" to create such inline extent):
>>
>>          item 6 key (257 EXTENT_DATA 0) itemoff 15823 itemsize 40
>>                  generation 9 type 0 (inline)
>>                  inline extent data size 19 ram_bytes 4096 compression =
3 (zstd)
>>
>> Then all page cache is dropped, and we do the new write into range
>> [8K, 12K)
>>
>> With the out-of-tree patch "btrfs: allow buffered write to skip full pa=
ge if
>> it's sector aligned", such aligned write won't trigger the full folio
>> read, so we just dirtied range [8K, 12K), and range [0, 4K) is not
>> uptodate.
>
> And without that out-of-tree patch, do we have any problem?

Fortunately no.

> If that patch creates a problem then perhaps fix it before being
> merged or at least include it early in this patchset?

I'll put this one before that patch in the merged series.

>
> See, at least for me it's confusing to have patches saying they fix a
> problem that happens when some other unmerged patch is applied.
> It raises the doubt if that other patch should be fixed instead and
> therefore making this one not needed, or at least if they should be in
> the same patchset.

But I'm wondering what's the proper way to handle such cases?

Is putting this one before that patch enough?

I really want to express some strong dependency, as if some one
backported that partial uptodate folio support, it will easily screw up
a lot of things.

On the other hand, it's also very hard to explain why this patch itself
is needed, without mentioning the future behavior change.

Any good suggestions? Especially I'm pretty sure such pattern will
happen again and again as we're approaching larger data folios support.

Thanks,
Qu

>
> It's not clear here if this patch serves other purposes other than
> fixing that other out-of-tree patch.
>
> The patch itself looks fine, but all these references to other
> unmerged patches and that they cause problems, make it hard and
> confusing to review.
> Sorry, it's just hard to follow these patchsets that depend on other
> not yet merged patchsets :(
>
> Thanks.
>
>>
>> Then md5sum triggered the full folio read, causing us to read the
>> inlined data extent.
>>
>> Then inside function read_inline_extent() and uncomress_inline(), we ze=
ro
>> out all the remaining part of the folio, including the new dirtied rang=
e
>> [8K, 12K), leading to the corruption.
>>
>> [FIX]
>> Thankfully the bug is not yet reaching any end users.
>> For upstream kernel, the [8K, 12K) write itself will trigger the full
>> folio read before doing any write, thus everything is still fine.
>>
>> Furthermore, for the existing btrfs users with sector size < page size
>> (the most common one is Asahi Linux) with inline data extents created
>> from x86_64, they are still fine, because two factors are saving us:
>>
>> - Inline extents are always at offset 0
>>
>> - Folio read always follows the file offset order
>>
>> So we always read out the inline extent, zeroing the remaining folio
>> (which has no contents yet), then read the next sector, copying the
>> correct content to the zeroed out part.
>> No end users are affected thankfully.
>>
>> The fix is to make both read_inline_extent() and uncomress_inline() to
>> only zero out the sector, not the whole page.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/inode.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 2620c554917f..ea60123a28a2 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -6780,6 +6780,7 @@ static noinline int uncompress_inline(struct btrf=
s_path *path,
>>   {
>>          int ret;
>>          struct extent_buffer *leaf =3D path->nodes[0];
>> +       const u32 sectorsize =3D leaf->fs_info->sectorsize;
>>          char *tmp;
>>          size_t max_size;
>>          unsigned long inline_size;
>> @@ -6808,17 +6809,19 @@ static noinline int uncompress_inline(struct bt=
rfs_path *path,
>>           * cover that region here.
>>           */
>>
>> -       if (max_size < PAGE_SIZE)
>> -               folio_zero_range(folio, max_size, PAGE_SIZE - max_size)=
;
>> +       if (max_size < sectorsize)
>> +               folio_zero_range(folio, max_size, sectorsize - max_size=
);
>>          kfree(tmp);
>>          return ret;
>>   }
>>
>> -static int read_inline_extent(struct btrfs_path *path, struct folio *f=
olio)
>> +static int read_inline_extent(struct btrfs_fs_info *fs_info,
>> +                             struct btrfs_path *path, struct folio *fo=
lio)
>>   {
>>          struct btrfs_file_extent_item *fi;
>>          void *kaddr;
>>          size_t copy_size;
>> +       const u32 sectorsize =3D fs_info->sectorsize;
>>
>>          if (!folio || folio_test_uptodate(folio))
>>                  return 0;
>> @@ -6836,8 +6839,8 @@ static int read_inline_extent(struct btrfs_path *=
path, struct folio *folio)
>>          read_extent_buffer(path->nodes[0], kaddr,
>>                             btrfs_file_extent_inline_start(fi), copy_si=
ze);
>>          kunmap_local(kaddr);
>> -       if (copy_size < PAGE_SIZE)
>> -               folio_zero_range(folio, copy_size, PAGE_SIZE - copy_siz=
e);
>> +       if (copy_size < sectorsize)
>> +               folio_zero_range(folio, copy_size, sectorsize - copy_si=
ze);
>>          return 0;
>>   }
>>
>> @@ -7012,7 +7015,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_=
inode *inode,
>>                  ASSERT(em->disk_bytenr =3D=3D EXTENT_MAP_INLINE);
>>                  ASSERT(em->len =3D=3D fs_info->sectorsize);
>>
>> -               ret =3D read_inline_extent(path, folio);
>> +               ret =3D read_inline_extent(fs_info, path, folio);
>>                  if (ret < 0)
>>                          goto out;
>>                  goto insert;
>> --
>> 2.48.1
>>
>>
>


