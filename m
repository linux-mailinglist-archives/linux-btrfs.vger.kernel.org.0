Return-Path: <linux-btrfs+bounces-19673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC3BCB754F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 00:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB04301B2F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 23:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B015285058;
	Thu, 11 Dec 2025 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aWczOm4n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A646432C8B;
	Thu, 11 Dec 2025 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765494341; cv=none; b=M7BRsXomToZBAddsuSdm4Ol8DTlAowPJ+M2NrqrqszVu0BsVbhfrEoO+1sgf53t3sVIZAVWc1N6ycCaJY001bwMTfq1OF6BM0pzQ3mB+9X3TI4K0Uj7cvGVsDGoEjKnlOtMOMBgGW+6g4eYhKXKST/I5heP5+8Yze9pl86whkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765494341; c=relaxed/simple;
	bh=+cdYFFd1Xm9B8OtBBJaeRTj81Q8I3KR1UIEjXDdP/tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxISIBTRpyYylpVr7I0NL1MjdWYaT1EpT7k1r2ua8atEuE+Zmk+zwLIiPcVfl7tr3s76D3j14FXlnQY8Rax1aQ8fKxs70tFMOFmFR+BjcAuWKFvy/pZs2e6jHXg92FvEwOk+r5fOx1F3zWJR3AMuAPU+rcYW9I7vrK+UQz+JMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aWczOm4n; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765494332; x=1766099132; i=quwenruo.btrfs@gmx.com;
	bh=zj1TA86k55GQ8YueViXpkWIpVuSBwKWb9WN70RNFI30=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aWczOm4nDnS6iexOWMIyZxerM1bmV8U9QDEThsmxGo2ALpYX8Q2d/VwCFY6Gql62
	 TX4N5h0bdeZEhfmayohInaoSG6C8jt9YJp2h5SszMuPgkPZv4Ar+T19P1uaCP6OzM
	 mhs+Vq4FGQ0SiMHr1H4Xosq/m83dbtQrhIL6P8xId2R0zUesu7wOf+DiwPMPsfGd2
	 bev7e4yTp+t/K7RWqDf9VZQFFxlAFrmOB/aKTc6Gb28aD00U3jkFc+y3wTioIdx8k
	 BmlTmgqS1/HReFwGhVj5Oiz4ur/L/HP+HRBz0/aguz+RKr1V9zOvkbkg+jq/Y3oXE
	 pDpypgY3WZvu9e02kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MaJ3n-1vZ2OP0n6z-00OVci; Fri, 12
 Dec 2025 00:05:32 +0100
Message-ID: <0a294777-4711-472f-997f-454817c47a79@gmx.com>
Date: Fri, 12 Dec 2025 09:35:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: fix beyond-EOF write handling
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <cover.1765418669.git.wqu@suse.com>
 <2e646aa21c452f80c2afbbf50ceda081c5c3ed4c.1765418669.git.wqu@suse.com>
 <CAL3q7H5_AU-SUacEd8H0Qz8vg8jAq1fmSEkhvwx_qpmQTGvS8w@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5_AU-SUacEd8H0Qz8vg8jAq1fmSEkhvwx_qpmQTGvS8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ivZhjjwNc6fvrV8e8gF6ZLjEAVRMhctY53fKzm6jqdl0H3bWs72
 oeTeD5Lr0RnmtWirVpMLv4iF3sbb5Y3ZRplKTZTdormiCTza8yd/p1vywp7cQ5I6vN9NuA4
 ZACJj6S8bWMJmcZC6GH9f3pS0zIwWTZmO9bdscCYgmIxMYWNdBzS6FrJ9K04qigeS5gibd/
 8hLEyaQ9+tXAWWYjekCPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:myDdo9zWeAU=;BjcF1hpnxDt3abTSPd63I/Zf/1t
 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



=E5=9C=A8 2025/12/11 21:56, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Dec 11, 2025 at 2:15=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> For the following write sequence with 64K page size and 4K fs block siz=
e,
>> it will lead to file extent items to be inserted without any data
>> checksum:
>>
>>    mkfs.btrfs -s 4k -f $dev > /dev/null
>>    mount $dev $mnt
>>    xfs_io -f -c "pwrite 0 16k" -c "pwrite 32k 4k" -c pwrite "60k 64K" \
>>              -c "truncate 16k" $mnt/foobar
>>    umount $mnt
>=20
> If you can, add this to fstests.

The problem is, it's very hard to cause any observable result.

For most if not all cases, the file extent item insertion and truncation=
=20
happen in the same transaction thus no error can be detected.

We need either a way to force all btrfs_end_transaction() to commit the=20
trans, or very heavy workload to trigger enough transactions, then along=
=20
with log-replay to detect such problem.

Thanks,
Qu

>=20
>>
>> This will result the following 2 file extent items to be inserted (extr=
a
>> trace point added to insert_ordered_extent_file_extent()):
>>
>>     btrfs_finish_one_ordered: root=3D5 ino=3D257 file_off=3D61440 num_b=
ytes=3D4096 csum_bytes=3D0
>>     btrfs_finish_one_ordered: root=3D5 ino=3D257 file_off=3D0 num_bytes=
=3D16384 csum_bytes=3D16384
>>
>> Note for file offset 60K, we're inserting an file extent without any
>=20
> an file -> a file
>=20
>> data checksum.
>>
>> Also note that range [32K, 36K) didn't reach
>> insert_ordered_extent_file_extent(), which is the correct behavior as
>> that OE is fully truncated, should not result any file extent.
>>
>> Although file extent at 60K will be later dropped by btrfs_truncate(),
>> if the transaction got committed after file extent inserted but before
>> the file extent dropping, we will have a small window where we have a
>> file extent beyond EOF and without any data checksum.
>>
>> That will cause "btrfs check" to report error.
>>
>> [CAUSE]
>> The sequence happens like this:
>>
>> - Buffered write dirtied the page cache and updated isize
>>
>>    Now the inode size is 64K, with the following page cache layout:
>>
>>    0             16K             32K              48K           64K
>>    |/////////////|               |//|                        |//|
>>
>> - Truncate the inode to 16K
>>    Which will trigger writeback through:
>>
>>    btrfs_setsize()
>>    |- truncate_setsize()
>>    |  Now the inode size is set to 16K
>>    |
>>    |- btrfs_truncacte()
>=20
> truncacte -> truncate
>=20
> It looks good otherwise, so:
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>=20
> Thanks.
>=20
>>       |- btrfs_wait_ordered_range() for [16K, u64(-1)]
>>          |- btrfs_fdatawrite_range() for [16K, u64(-1)}
>>             |- extent_writepage() for folio 0
>>                |- writepage_delalloc()
>>                |  Generated OE for [0, 16K), [32K, 36K] and [60K, 64K)
>>                |
>>                |- extent_writepage_io()
>>
>>    Then inside extent_writepage_io(), the dirty fs blocks are handled
>>    differently:
>>
>>    - Submit write for range [0, 16K)
>>      As they are still inside the inode size (16K).
>>
>>    - Mark OE [32K, 36K) as truncated
>>      Since we only call btrfs_lookup_first_ordered_range() once, which
>>      returned the first OE after file offset 16K.
>>
>>    - Mark all OEs inside range [16K, 64K) as finished
>>      Which will mark OE ranges [32K, 36K) and [60K, 64K) as finished.
>>
>>      For OE [32K, 36K) since it's already marked as truncated, and its
>>      truncated length is 0, no file extent will be inserted.
>>
>>      For OE [60K, 64K) it has never been submitted thus has no data
>>      checksum, and we insert the file extent as usual.
>>      This is the root cause of file extent at 60K to be inserted withou=
t
>>      any data checksum.
>>
>>    - Clear dirty flags for range [16K, 64K)
>>      It is the function btrfs_folio_clear_dirty() which search and clea=
r
>>      any dirty blocks inside that range.
>>
>> [FIX]
>> The bug itself is introduced a long time ago, way before subpage and
>> larger folio support.
>>
>> At that time, fs block size must match page size, thus the range
>> [cur, end) is just one fs block.
>>
>> But later with subpage and larger folios, the same range [cur, end)
>> can have multiple blocks and ordered extents.
>>
>> Later commit 18de34daa7c6 ("btrfs: truncate ordered extent when skippin=
g
>> writeback past i_size") is fixing a bug related to subpage/larger
>> folios, but it's still utilizing the old range [cur, end), meaning only
>> the first OE will be marked as truncated.
>>
>> The proper fix here is to make EOF handling block-by-block, not trying
>> to handle the whole range to @end.
>>
>> By this we always locate and truncate the OE for every dirty block.
>>
>> Cc: stable@vger.kernel.org # 5.15+
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 629fd5af4286..a4b74023618d 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1728,7 +1728,7 @@ static noinline_for_stack int extent_writepage_io=
(struct btrfs_inode *inode,
>>                          struct btrfs_ordered_extent *ordered;
>>
>>                          ordered =3D btrfs_lookup_first_ordered_range(i=
node, cur,
>> -                                                                  foli=
o_end - cur);
>> +                                                                  fs_i=
nfo->sectorsize);
>>                          /*
>>                           * We have just run delalloc before getting he=
re, so
>>                           * there must be an ordered extent.
>> @@ -1742,7 +1742,7 @@ static noinline_for_stack int extent_writepage_io=
(struct btrfs_inode *inode,
>>                          btrfs_put_ordered_extent(ordered);
>>
>>                          btrfs_mark_ordered_io_finished(inode, folio, c=
ur,
>> -                                                      end - cur, true)=
;
>> +                                                      fs_info->sectors=
ize, true);
>>                          /*
>>                           * This range is beyond i_size, thus we don't =
need to
>>                           * bother writing back.
>> @@ -1751,8 +1751,8 @@ static noinline_for_stack int extent_writepage_io=
(struct btrfs_inode *inode,
>>                           * writeback the sectors with subpage dirty bi=
ts,
>>                           * causing writeback without ordered extent.
>>                           */
>> -                       btrfs_folio_clear_dirty(fs_info, folio, cur, en=
d - cur);
>> -                       break;
>> +                       btrfs_folio_clear_dirty(fs_info, folio, cur, fs=
_info->sectorsize);
>> +                       continue;
>>                  }
>>                  ret =3D submit_one_sector(inode, folio, cur, bio_ctrl,=
 i_size);
>>                  if (unlikely(ret < 0)) {
>> --
>> 2.52.0
>>
>>
>=20


