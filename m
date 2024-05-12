Return-Path: <linux-btrfs+bounces-4916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152AA8C35C7
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D70BB20EB1
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0E1BC46;
	Sun, 12 May 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="anWUMHl/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921011CA9
	for <linux-btrfs@vger.kernel.org>; Sun, 12 May 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715504189; cv=none; b=FqYSBb6/dwyhaRi6bolA8yXTn5qnYbkTGapLSStRceEfEE7ICPPmIXbyvVr4Aj8sAhES8zwQyESPjvY/ddRNwN9qwZa0srbqngHSkLYP0mo3081mbacSUSyDqohEDI0EiSRZZVUyadm3f/XdhmaobnnkxxyVLa814IgYkOYdEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715504189; c=relaxed/simple;
	bh=ME0TN8/0EMa7K+qKR9QqEGXo+eKLMHIOyWQFF7eo2SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCYHqU9LIIeF4yR7gzbqMHQsnt7bfcOyYzpuwTe4z9qfqLGLLihb+nI9m3hO/XEGh/Cs41mtwk9c3aZho5Yws9Mvl8bLQzkjxlK3ZObq9v0pWbbVe3UqddVw5LwlVGnXOOguFuwIUFJaqf3Pys4QNvoGG0AVutpWMYMA+7R0UTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=anWUMHl/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715504183; x=1716108983; i=quwenruo.btrfs@gmx.com;
	bh=m+TDZuFk4SVR95iwWmHGg/z+G95HAe+6iFurc0KGgZI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=anWUMHl/5dpqzWfowC/A/BaJ5g+auhoPH9kwXYjYDnxtlqz50kq47a+ckd9/JBzE
	 5Uap1QtKXvwyEwPkU+7bocj4oz8n07tlKxH5wMYtUFSzY5/BVJDyVd+cArzp4VCMz
	 VhIWpiEMxMgkAcOjGkmVIVbwwWeLfv1yiC9Rkh+zNo+SV/17hpUMi1EAnX5GatISP
	 pggsRj7Fxk55KgKPIT35E3Wr1GEirtNV92oBKhBWhTRs6xb/iwhP1OwxuVi692WRh
	 ugawv9z3nn65VH2XJggQZ44OmVRiTEezEbP2nZ52SrZ+e5tOL2XfIkbw9iYH3x0LI
	 t7AEZSoSiQCM+pZUFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryTF-1stlLf42S5-00nvo7; Sun, 12
 May 2024 10:56:23 +0200
Message-ID: <6882e4dc-bab7-4cde-8021-a571b8a2fb2b@gmx.com>
Date: Sun, 12 May 2024 18:26:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: do not clear page dirty inside
 extent_write_locked_range()
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1709677986.git.wqu@suse.com>
 <ebf001731e2ebafd5c2a435a7e0848634a421ed7.1709677986.git.wqu@suse.com>
 <20240510142525.GA90506@perftesting>
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
In-Reply-To: <20240510142525.GA90506@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m445RCdrUEFBCtUjsYat2MGwDSPWLDau161q8WCiP9WpQT6ZUeS
 bnxFXQNfEzPMePtozpZjTaruk1th6qjjrch7uT7nHjyzBeUfOLM6WTMZR8smGV+lvvgit37
 MSSDctWBcvJqjxxz0i0JGN43BoEva7BbuzCjXxkQ1jzLH3GxMUIrNKm84mHsoVZ+DzN4HJF
 qwuRB7MS3sYOKA9LkZEpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B5WnWtzZ714=;eNsuFpbHP83I4C5tGkcb+sBSD5r
 1v1N9DTMlUDZXI/qRLttRJeChz82Ao2TBaxnIK6G1KjlprIqfcHQ2017VpQ76/Dt1z/8WmJxA
 Y5wQQPkYzVZXyObjR7H0Th9LbD0K3mCup/O4XGQr/NFK/5ZBGKzLjaaHorvRtwoyjl8VR2Ag4
 JkrNWZZFiQJ4DFH1bgBq89wW4eWQqqqPRuWqX9MAQtE5vJHyjzV8Abyliprh3BKTAI6IFBRN9
 7DqyEdeRRgwtQEu7SK2Jd+KmxPaocNUCv2W3PFyn7vTkUlHI48ioL8hDiEp5Y42FiMJio//Ii
 vTdzud0CTgcYLY3qZN63Y9VXTHsw4QFtyD1NoSa7tIYn3pEVIbcI8vPkzBPVFpb4j+lgYbT3T
 Vz1lQzBdgruWvRZfEagPI0wHRtlSLyGslu2t6RpTHv6mwO5Pf5zDhmiz5VZH4oI/TYv+BN9QM
 WxvNCD/BLEyp59JvUxaOOyOXnOWW0Y1wUnIjSSzMa60pSHhWNwHluxfzw4abXG6RkUqdphwN4
 R32PJ1OLRVAJidZL10pprxrFu5AlukUsAF1d4NJImmFw9RqnaPdWY/N8KsUcE8O3avpfOZfNj
 Pk2SRFhCZ925ScgwTCtLs93kHDcFUWJNcpDyjQ+rdqqWBHAr3DKPDyshsOHUeesSU/lwZVD4V
 vrh1OzrFuMzNueXqHvn8H4q04fKLVKukOumt1N+l+LNI+vvnoCkMRN1Q+K8GdhImNF/xqaCFy
 mA7DuCHYHRTYvpgJlb4GN7HBNe/F9vJmX0ihSobD8On8nmlznjSUuqADtypUQje5O8xG+03Ca
 OQGrDstb0PwFvwAefkaldpKfSVZF3SDIuk2XQY0DszQFg=



=E5=9C=A8 2024/5/10 23:55, Josef Bacik =E5=86=99=E9=81=93:
> On Wed, Mar 06, 2024 at 09:05:33AM +1030, Qu Wenruo wrote:
>> [BUG]
>> For subpage + zoned case, btrfs can easily hang with the following
>> workload, even with previous subpage delalloc rework:
>>
>>   # mkfs.btrfs -s 4k -f $dev
>>   # mount $dev $mnt
>>   # xfs_io -f -c "pwrite 32k 128k" $mnt/foobar
>>   # umount $mnt
>>
>> The system would hang at unmount due to unfinished ordered extents.
>>
>> Above $dev is a tcmu-runner emulated zoned HDD, which has a max zone
>> append size of 64K, and the system has 64K page size.
>>
>
> This whole explanation confuses me, because in the normal case we clear =
the
> whole page dirty before we enter into __extent_writepage_io(), so what w=
e're
> doing here is no different than the regular case, so I don't get how thi=
s is a
> problem?

Although I have sent out the updated (in fact just my github branch
version) version, I still like to explain it a little more, as there are
several more hidden (existing) problems here.

The example I would go with would be the same one page layout, with 64K
page size and 4K sector size:

     0      32K      64K     96K    128K    160K    192K
     I      |////////I//////////////I///////|       I

Where "I" is the page boundary.

Firstly, the biggest confusion comes from where we clear the PageDirty.
We do it in several locations:

- folio_clear_dirty_for_io() inside extent_write_cache_pages()
   I'd say, this is the worst location to call.
   It is not subpage aware, nor at the right timing.

   The only good news is, it's not causing real problems, thus I'll
   clean it up later.

- btrfs_folio_clear_dirty() inside __extent_writepage_io()
   This is subpage aware, and timing correct after we have set the
   (sub)page range writeback.

- clear_page_dirty_for_io() inside extent_write_locked_range()
   The offending part we're discussing here.


For the "normal" subpage case, we go the following sequence:

1. folio_clear_dirty_for_io() on page [0, 64K)
    As I said already, this is not subpage aware nor timing correctly.

2. writepage_delalloc() to allocate an OE for range [32K, 160K)

3. __extent_writepage_io() for page [0, 64K)
    Which would then search subpage bits (not yet cleared), and submit
    range [32K, 64K) correctly.
    And correctly clear the subpage dirty flags.

4. folio_clear_dirty_for_io() on page [64K, 128K)

5. __extent_writepage_io() for page [64K, 128K)
    Now this time it would submit [64K, 128K) for the range.
    And correctly clear the subpage dirty flags.

6. folio_clear_dirty_for_io() on page [128K, 160K)

7. __extent_writepage_io() for page [128K, 160K)
    Now this time it would submit [128K, 160K) for the range.
    And correctly clear the subpage dirty flags.

The point here is, __extent_writepage_io() is only called for the exact
page from extent_write_cache_pages(). It would never be called on other
pages.

But for the subpage + zoned case, things can go a little different:

1. folio_clear_dirty_for_io() on page [0, 64K)
    This is still the same.

2. writepage_delalloc() to allocate an OE for range [32K, 96K)
    As our zoned append size limit is 64K.

3. __extent_writepage_io() for page [0, 64K)
    So far still no difference, submitted range [32K, 64K)

4. clear_page_dirty_for_io() for page [64K, 128K) inside
    extent_write_locked_range().
    This is different now. We are handling page other than the locked
    page.
    This would only cause problem later.

5. __extent_writepage_io() for page [64K, 128K)
    Now we only submit the range [64K, 96K), as our range is limited by
    the extent_write_locked_range().

    At this page, page dirty is cleared, but subpage dirty is only
    cleared for [64K, 96K), the remaining half still has subpage dirty
    flags. AKA, a desync between page flags and subpage flags.

6. folio_test_dirty() for page [64K, 128K) from
    extent_write_cache_pages()
    Now since that page no longer has dirty flags (even it still has
    subpage flags), extent_write_cache_pages() would simply skip this
    page, causing the range [96K, 128K) not submitted.

That's why this patch is required to fix the problem.

I hope my newer patch would be enough to explain it already, as it
explicitly showed the step 6) using a lot of trace_printk().

And if you find the explanation here is better, I'm pretty happy to
merge the explanation into the v4 patchset.

And thanks to your questions, I'm more confident to do further cleanup
on the page dirty handling.

Thanks,
Qu

>
>> [CAUSE]
>> There is a bug involved in extent_write_locked_range() (well, I'm
>> already surprised by how many subpage incompatible code are inside that
>> function):
>>
>> - If @pages_dirty is true, we will clear the page dirty flag for the
>>    whole page
>>
>>    This means, for above case, since the max zone append size is 64K,
>>    we got an ordered extent sized 64K, resulting the following writebac=
k
>>    range:
>>
>>    0               64K                 128K            192K
>>    |       |///////|///////////////////|/////////|
>>            32K               96K
>>             \       OE      /
>>
>>    |///| =3D subpage dirty range
>>
>>    And when we go into the __extent_writepage_io() call to submit [32K,
>>    64K), extent_write_locked_range() would find it's the locked page, a=
nd
>>    not clear its page dirty flag, so the submission go without any
>>    problem.
>>
>>    But when we go into the [64K, 96K) range for the second half of the
>>    ordered extent, extent_write_locked_range() would clear the page dir=
ty
>>    flag for the whole page range [64K, 128K), resulting the following
>>    layout:
>>
>>    0               64K                 128K            192K
>>    |       |///////|         |         |/////////|
>>            32K               96K
>>             \       OE      /
>
> Huh?  We come into extent_write_locked_range(), the first page is the lo=
cked
> page so we don't clear dirty, because it's already been cleared dirty by=
 the
> original start from extent_write_cache_pages() right?  So we would have
>
> Actual page
> [0, 64k) !PageDirty()
> [64k, 128k) PageDirty()
>
> Subpage
> [0, 64k) not dirty
> [64k, 160k) dirty
>
>>
>>    Then inside __extent_writepage_io(), since the page is no longer
>>    dirty, we skip the submission, causing only half of the ordered exte=
nt
>>    can be finished, thus hanging the whole system.
>
> Huh? We _always_ call __extent_writepage_io() with the actual page not d=
irty, so
> how are we skipping the submission?  We only clear the subpage range for=
 the
> part we actually submitted.
>
> This needs a better explanation, because I'm super confused about how th=
e page
> state matters here when the main path does exactly this.  Thanks,
>
> Josef
>

