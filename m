Return-Path: <linux-btrfs+bounces-398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1717FAD42
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 23:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD78B281703
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395AC48CCE;
	Mon, 27 Nov 2023 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qD8P33kO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5DD3840
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 14:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701123436; x=1701728236; i=quwenruo.btrfs@gmx.com;
	bh=1T10qdyIpidW11TFUGDHCWJs0UHwuO67pL0zTCgsAX0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qD8P33kOvZi/7oR1ubDkLlvlC31VOx0OHf/iylUCpCfIxDO9BGu1udUFUDBE8BN6
	 Stc63F7P56oVA7qGMTxHcSRLwa6O30dl/DU3S/DmvPQtwI9trHlTab9B1H9/Vde6d
	 Nui7uHe+yTTDDd1pyza2d8dn6FopLiv+H9cYauH+3Y+DZu9b034wXCImt2vyFM9K2
	 6uzuxP0LmyYLu4FxRYVY6oz9Owsdy7F3hiz4mPbxzHm7DLluDcN4x2hxtBPBl9u1D
	 U6pmM+C2UK94uwmdHT9JAtoyvao/sg5zxbzmMg87ocAQGYssFLL1d/ktFQ/9ZuhXp
	 2ZZ439VHgqgwvkBrqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDnI-1r0dAD288k-00CkrU; Mon, 27
 Nov 2023 23:17:16 +0100
Message-ID: <ec785c3e-7466-4fcd-9cd6-f9ea454a41fd@gmx.com>
Date: Tue, 28 Nov 2023 08:47:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: refactor alloc_extent_buffer() to
 allocate-then-attach method
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
 <20231122141403.GD1733890@perftesting>
 <5e56826f-2463-42f3-8714-f4eb3e76dab7@gmx.com>
 <20231127162801.GE2366036@perftesting>
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
In-Reply-To: <20231127162801.GE2366036@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x+2qowK4i+XAYjQjZYCZL+X1r0GjeHiQe3Yvv5Czy/EXHV3k3fu
 CIMQfa/4vdsUR1M7rc6cGBO55Z6mHOYy3owSt6XNPDjogX9DHGt+wqaaqKUyiCWyto9NMx/
 IsEh7Y1lJ6T4xtey0wY/SQt4SKg8ozR1+bkkflZGfERgsXOVwSxVHxCDsuE1Jd4pBQkSsJv
 wvsdTIedr3LTW59zRDg0g==
UI-OutboundReport: notjunk:1;M01:P0:V3OTAHUcp+A=;pRlAG76+E+SbjNSi3cfy0JAhACK
 jptqM5PkIEBwQbON8DC7bvb0xcm0w8hT8Jt7P2fmz1zfnEh1+qbUPizoBXHe2PRdgRVsJVGeE
 MIwEcw3o8H62sFB9yMcHNFYTPo7IUUMQMgcQ1Ktd6JhKuR64wRRQ7p8c3FkXowvuT991GEq3G
 29syMnmClT5+6AHjK9RLZB5/CbBozDnefjOC1V5hhAfPYf4ch/LCGvCxQbA2pt62BdovYSoAB
 SjyH2VNVGCOjHcvFpF2+J4mnOaS90uXpb0EIaRx4/yjpCw/YcGsEDQj7fHFnqsTlyAD8plE8F
 SGhHQF+R8gWSknhRBJR16RfqCSidkN6hRV6lb+4zFrfjpKy6Tosaev3d0JtedyOzRBjim4FdG
 gtNKEbi6I1KEncWqGlIElMZ+hrs42YTgXWqVfRtkhcmbDuYKC6OJGScQt6hkocyFwQBWZdAXa
 zsrsHTU1ZtLq9XzgiLA7HSIubBGysua5Xeg2Eyrgi9EOT4mIiI6ollysiw356mqThn2o+Fn9k
 72gHMJV5WeKl5ou5iDJ0wJlbn/VrLlQ++j8WfOYMkjdVOAzztN/wuZVGFv/UZ9bKfjjvKNtjC
 q/3QljzFwM9cKqNvoUPRnk2NUmxLrsC2wfzg+1YgMrruEZLjkpZ9qL8YiGrUsSb1MQ2pzzoVL
 LyL7Oqyftakj6oV9/k8M7Xh7u5i3Bv1CQaqaMF+UxsbSG4aQ5hQSJ+iQcDjTQyT5z2sZ0Fwym
 88M7IQHArBIFs7VlX/01uj5D3OenWbB4UBqLRDXX21+VV6C+GVIBMqgSrwmfGcy0FU8D9LcTG
 xwzMUABMjDGN7TS2kCmYGplEeGdQGSjOTNn8BVsPBkOQ6ofV2dGG9EAajVLPZYz/8rj7Ev4zi
 Y7fYdI8i80nvhA4lh+2888geF5PffcaYTQrVE66WMdzfOdYDxKlAlclXIJraRKFaPu9iWhdk+
 yP1MmA==



On 2023/11/28 02:58, Josef Bacik wrote:
> On Thu, Nov 23, 2023 at 06:30:05AM +1030, Qu Wenruo wrote:
>>
>>
>> On 2023/11/23 00:44, Josef Bacik wrote:
>>> On Wed, Nov 22, 2023 at 10:05:04AM +1030, Qu Wenruo wrote:
>>>> Currently alloc_extent_buffer() utilizes find_or_create_page() to
>>>> allocate one page a time for an extent buffer.
>>>>
>>>> This method has the following disadvantages:
>>>>
>>>> - find_or_create_page() is the legacy way of allocating new pages
>>>>     With the new folio infrastructure, find_or_create_page() is just
>>>>     redirected to filemap_get_folio().
>>>>
>>>> - Lacks the way to support higher order (order >=3D 1) folios
>>>>     As we can not yet let filemap to give us a higher order folio (ye=
t).
>>>>
>>>> This patch would change the workflow by the following way:
>>>>
>>>> 		Old		   |		new
>>>> -----------------------------------+---------------------------------=
----
>>>>                                      | ret =3D btrfs_alloc_page_array=
();
>>>> for (i =3D 0; i < num_pages; i++) {  | for (i =3D 0; i < num_pages; i=
++) {
>>>>       p =3D find_or_create_page();     |     ret =3D filemap_add_foli=
o();
>>>>       /* Attach page private */      |     /* Reuse page cache if nee=
ded */
>>>>       /* Reused eb if needed */      |
>>>> 				   |     /* Attach page private and
>>>> 				   |        reuse eb if needed */
>>>> 				   | }
>>>>
>>>> By this we split the page allocation and private attaching into two
>>>> parts, allowing future updates to each part more easily, and migrate =
to
>>>> folio interfaces (especially for possible higher order folios).
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/extent_io.c | 173 +++++++++++++++++++++++++++++++--------=
----
>>>>    1 file changed, 126 insertions(+), 47 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index 99cc16aed9d7..0ea65f248c15 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -3084,6 +3084,14 @@ static bool page_range_has_eb(struct btrfs_fs_=
info *fs_info, struct page *page)
>>>>    static void detach_extent_buffer_page(struct extent_buffer *eb, st=
ruct page *page)
>>>>    {
>>>>    	struct btrfs_fs_info *fs_info =3D eb->fs_info;
>>>> +	/*
>>>> +	 * We can no longer using page->mapping reliably, as some extent bu=
ffer
>>>> +	 * may not have any page mapped to btree_inode yet.
>>>> +	 * Furthermore we have to handle dummy ebs during selftests, where
>>>> +	 * btree_inode is not yet initialized.
>>>> +	 */
>>>> +	struct address_space *mapping =3D fs_info->btree_inode ?
>>>> +					fs_info->btree_inode->i_mapping : NULL;
>>>
>>> I don't understand this, this should only happen if we managed to get
>>> PagePrivate set on the page, and in that case page->mapping is definit=
ely
>>> reliable.  We shouldn't be getting in here with a page that hasn't act=
ually been
>>> attached to the extent buffer, and if we are that needs to be fixed, w=
e don't
>>> need to be dealing with that case in this way.  Thanks,
>>
>> The problem is, with the new way of allocating pages first, then attach
>> them to filemap, we can have a case where the extent buffer has 4 pages=
,
>> but only the first page is attached to filemap of btree inode.
>>
>> In that case, we still want to lock the btree inode private, but
>> page->mapping is still NULL for the remaining 3 pages.
>>
>
> In this case I think we just change the error handling at the end, as we=
 already
> have to do something special anyways, so we now would do
>
> for (int i =3D 0; i < attached; i++) {
> 	unlock_page(eb->pages[i]);
> 	detach_extent_buffer_page(eb->pages[i]);
> }
>
> for (int i =3D 0; i < num_pages; i++) {
> 	if (!eb->pages[i])
> 		break;
> 	put_page(eb->pages[i]);
> }
>
> and then we can leave detach_extent_buffer_page on its own.  Thanks,

This sounds pretty reasonable, I'll do more tests to make sure this works.

Thanks,
Qu
>
> Josef
>

