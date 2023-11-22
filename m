Return-Path: <linux-btrfs+bounces-314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C47F50FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8345EB20B31
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 20:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C575B1E1;
	Wed, 22 Nov 2023 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="d3L+vF0t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8903A3
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 12:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700683209; x=1701288009; i=quwenruo.btrfs@gmx.com;
	bh=GKM+MmIvDC61aFHst39vM8r/DfH+21MMGYPdBxHCkko=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=d3L+vF0tGw9yPiraQTBzGB0ksy3nvuidmE6+VJVjajy20tgwhQS/WYspWMqJCiPR
	 U1sFwevZatPIWLSztsaVwvaFnE4pdjGMLOtOBvpQKgQsBCEBBlcOfQyjkzfAOnU25
	 FTBgogkOAfzax6kW6jziMYj7tMeyIZ4zsLDeQjo1VEr0JsAai2P5ea4uloHka+LKq
	 16bd0SIqv68/xn9YSw/mRgrbXw+HXg8j3Ulc02KZReV7Wd/SabM2eAHQwepUb6K2e
	 zN+l7fK4U/KzZunv85MBBLHi4NN/sEjcxw0MvCIbrJ/QYY6GcjlbLqCvKmbL1Y8uU
	 9Wzyo3RP5KZzD9FqkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSbxD-1qv7k93hWL-00Sudw; Wed, 22
 Nov 2023 21:00:09 +0100
Message-ID: <5e56826f-2463-42f3-8714-f4eb3e76dab7@gmx.com>
Date: Thu, 23 Nov 2023 06:30:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: refactor alloc_extent_buffer() to
 allocate-then-attach method
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
 <20231122141403.GD1733890@perftesting>
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
In-Reply-To: <20231122141403.GD1733890@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/fanNhszcTRWllgDlpPM0L4UJP8FmVBwCFHYDkm055kia3wN0oi
 2DlnSybU8QNfeT8slVZdO0JO4z8AVyGm2lsIUWoTa2J3T5aHqkK178xyS88VrNhkB6+0Pq3
 /yPX+f3Qgb7Ob/AMW2CnS+ymE44nRNJ/AaOhUxYqXZBusgj3czhGN4x/8bfQjvqCPkY6l36
 gJOJ4axbDhdPse6DDo7lw==
UI-OutboundReport: notjunk:1;M01:P0:NgoTdZsXBSE=;JdP98gWVlVrmJU5r3xZqtUkkqPY
 h/yam4d4EJTYL5aZZF6JfiJ/aRO50vlOnBhy8MbEa/XDAwtS2LvCP/Pq9xGEBwGcQ02adlmyN
 50FlPFbT+n7G67+YkaHlc7YlP0jsiLNcLBVed4hJaTvjDMgAYygiflt7RSHy/ZS+XwSOenHl8
 N1QnBgvnbTbsd02H7EPk2zh79DP98TKYxlmdmxH1y/Y/fkWMEF6wempkSjTMdUNjl3TwXDV1D
 eMBJYJAv5SDWquIlcbRymnCOV16BHrm/4zUDRxAWGfNUDDElBLUT/a31kVRwLxet+ZT2FhAVs
 E4Su1i/wv4oKgjkAcEuiBdWmQr8Axgj2joqgc4EZuhecTDtUL5Pp7gRUqazKbYM78Bj9ZBZR9
 HJcpxo4mH8sEjwvGXSsLjBLpv68Nh4OsKp+ejEmy7o9e6p645qfhUy+mH7iZjwm841dy5Z/De
 ybNotll2EyLxEdHdtu52cbNiKFh54jqHtX8C6ps+1jDLT4IHtTpVfQ5GoG3ayM+Oz3zMEzBUU
 5hu9RF+6KfSZS0LhKEeO0bS1EpciVw7GzkunzSTgV7GJtisto9g8d4qDoUHolnp5XJADFtQUZ
 vQOaDtR9YiP/Bspln+x5SGPEkU5KcjeAdqEsPCBTEWt7YSi/YYSNxuonrfDOPD4XF4uF0yEUA
 32lBC1b3w+JrOi2H+QIAY/K163MPL8CvM04PqPRQobUAB0SfUbmei36XwjchFM+TwvfeKNrVi
 s76vFfdqE6JO1zUbigsixwxnx2RCGZnvG0LgFbpiq6b/NEFYDxgdKUSIsiRMvGxsGQad1g6Ya
 c4F7SsRSvCSxzJU2imXt4PQZg8vo/7x7+PhR7rBGqzGhA6WDmAp0XNTgUlXpqk4S9P560Ict4
 KOly5qUDFEFRCXzQerGCCcaDL7nUIjvWwqb2WyhmGMLCTzq1TJZlgldHKJq4OZR1YDSByFSha
 pB/+7c2J6DM9UQlxxNkK0Qk5iG0=



On 2023/11/23 00:44, Josef Bacik wrote:
> On Wed, Nov 22, 2023 at 10:05:04AM +1030, Qu Wenruo wrote:
>> Currently alloc_extent_buffer() utilizes find_or_create_page() to
>> allocate one page a time for an extent buffer.
>>
>> This method has the following disadvantages:
>>
>> - find_or_create_page() is the legacy way of allocating new pages
>>    With the new folio infrastructure, find_or_create_page() is just
>>    redirected to filemap_get_folio().
>>
>> - Lacks the way to support higher order (order >=3D 1) folios
>>    As we can not yet let filemap to give us a higher order folio (yet).
>>
>> This patch would change the workflow by the following way:
>>
>> 		Old		   |		new
>> -----------------------------------+-----------------------------------=
--
>>                                     | ret =3D btrfs_alloc_page_array();
>> for (i =3D 0; i < num_pages; i++) {  | for (i =3D 0; i < num_pages; i++=
) {
>>      p =3D find_or_create_page();     |     ret =3D filemap_add_folio()=
;
>>      /* Attach page private */      |     /* Reuse page cache if needed=
 */
>>      /* Reused eb if needed */      |
>> 				   |     /* Attach page private and
>> 				   |        reuse eb if needed */
>> 				   | }
>>
>> By this we split the page allocation and private attaching into two
>> parts, allowing future updates to each part more easily, and migrate to
>> folio interfaces (especially for possible higher order folios).
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 173 +++++++++++++++++++++++++++++++-----------=
-
>>   1 file changed, 126 insertions(+), 47 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 99cc16aed9d7..0ea65f248c15 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3084,6 +3084,14 @@ static bool page_range_has_eb(struct btrfs_fs_in=
fo *fs_info, struct page *page)
>>   static void detach_extent_buffer_page(struct extent_buffer *eb, struc=
t page *page)
>>   {
>>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
>> +	/*
>> +	 * We can no longer using page->mapping reliably, as some extent buff=
er
>> +	 * may not have any page mapped to btree_inode yet.
>> +	 * Furthermore we have to handle dummy ebs during selftests, where
>> +	 * btree_inode is not yet initialized.
>> +	 */
>> +	struct address_space *mapping =3D fs_info->btree_inode ?
>> +					fs_info->btree_inode->i_mapping : NULL;
>
> I don't understand this, this should only happen if we managed to get
> PagePrivate set on the page, and in that case page->mapping is definitel=
y
> reliable.  We shouldn't be getting in here with a page that hasn't actua=
lly been
> attached to the extent buffer, and if we are that needs to be fixed, we =
don't
> need to be dealing with that case in this way.  Thanks,

The problem is, with the new way of allocating pages first, then attach
them to filemap, we can have a case where the extent buffer has 4 pages,
but only the first page is attached to filemap of btree inode.

In that case, we still want to lock the btree inode private, but
page->mapping is still NULL for the remaining 3 pages.

Thanks,
Qu
>
> Josef
>

