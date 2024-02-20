Return-Path: <linux-btrfs+bounces-2551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12DF85B05D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 02:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1A61F227A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F076B1DFCE;
	Tue, 20 Feb 2024 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bIUcAKYc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79625171AA;
	Tue, 20 Feb 2024 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391792; cv=none; b=EOzTdDTl5NPhkbzQWDuFfYCnHLl+FbIz//30p7txvmILI51GcXCxE+/dpPJXTVgEgkX4WIUhzfy6XGNOcYt1cUro9CLF6eCK/GSXsBeHar9krTBedm728lNjx2NDKZ/Gmy/xnWBnSocLDXF+UG2GkdiOvEPDvLw2VqpeAVUOxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391792; c=relaxed/simple;
	bh=Ks64e+HVFsMUXnwea7cDFfNMmf7ADzTLXbEx7qK+sQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWKTeiiUMFruR4fUHHERNEOF6kBBSpW/Obcbfz2t1jnHUmb0br1EnT3CJa5iOXPIkYfa1pQxwtC0J4sT7Szf+hSiiS3EwsICTZptMB1jZRSJp76GJIVu+Wv5ZEHqc4cQiSoumWDX1fdgRc80mRHzPtQC9reKe0DIhUwdwQUDmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bIUcAKYc; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708391781; x=1708996581; i=quwenruo.btrfs@gmx.com;
	bh=Ks64e+HVFsMUXnwea7cDFfNMmf7ADzTLXbEx7qK+sQE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bIUcAKYcTvwI0irl7utWvP7L6B5k9DpfjqV6/YcpOwxSSPj2qzC95WgGhG1zEJtN
	 smXeRXdLsKt5A61DReQd4fTp7gCF6aWL7aVwB8XigxnjWzve9Tfz/SNFteJkUe91t
	 xWJ/+/HH+y1GvhKDQCiwewPVYMqZSCUzyz2ILgBxaVsPDiAugV9hcD8xee0ffZ47a
	 KHRnwZPldiImhp7DKSxDSOUgMc8wlEHQwLJi6ngettghyy1vToGg1UtMNnknhUDvE
	 u/H46vm3ZMNkp3Qobf/ltnZaO5kB/GRGQGHgVdyAQRxMLIyp2ZG5pqXJHHkVZicYd
	 HYSW2pzpb6+IYFBuyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTN9-1rGyIq021F-00NUpF; Tue, 20
 Feb 2024 02:16:21 +0100
Message-ID: <549a5778-ee2f-4520-9147-f09854a50948@gmx.com>
Date: Tue, 20 Feb 2024 11:46:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs: subpage: introduce helpers to handle subpage
 delalloc locking
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
References: <02f5ad17b6415670bea37433c8ca332a06253315.1708322044.git.wqu@suse.com>
 <202402200823.Su3xBnia-lkp@intel.com>
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
In-Reply-To: <202402200823.Su3xBnia-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j4Ps9b/qnXdzhxu60gfMCsU2QkhUwueb7dNEHgVuuG/eDcbVSO8
 2ZBawLQjp/rEcz7TU/StriRCmJJPSFhya7ctbLXV5i0jK1pX7d/Rwc59Swv5vJzNxwOzcQh
 3sgKaK5u/tqGTE2Nd5y5N//eMhnWTb5YbwaU5rK4Te5qaT0f7a/YHOtLKwHgJXgN4PSs0ql
 aJ136ID/usidYfUCP3p2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eQGl0hFGnIw=;Jf/HmagBqFMtcZCmYukZmEQhIl6
 AxdfyzDzsTrwFULByG1sVTPWMeCM2lbueTxglko6Juap5l8IXabcLMNuAZbc5t3t6lz6OvIah
 j+P/Xpk2wviFEWW+F6xxP0ShUhRcxnFfuc3Diat5YwYAz7weogHI8yplGHmXtecZyQ7wJCHYC
 25UUk9PofNV10Mfom3kK3D/d9f8o9Q9ErqUbnLkDBB6o4uK1bjolimnAEg2vByY1w8vj/Bza6
 5W6dpoZyzC5AaiReOUI4uuItrkvONy9lc0Y5u6KtALsZclQnzsTtTvz3uOV0/21r0N0Fs8qmI
 WyCvIGA9S55uheg9D4rKsMjOnoD4KDJdo1M/4F568IbXg/HP4N6cnHbbLWpnal2hJHQJdD69y
 IPRipYe9WZ42Et1Nm9TWL1QOq14iPLqZJkcDT4nuOM2egh4PsxuowT6cHpvTLShVmNwWLumfg
 vkuBbcQTl0bmoBEzH6vlJhLmOEaBOkIzYwozQOguQ69lX+MgH8apwJ5nnIFKK62i7GLK8e5Km
 irRpwdZniDBWQTBmVhnkZ0MBQWFDPY6FqMVES5jI+48qv5BAECAJqB8yfF1dK2eGUMgLV6smZ
 OwXS1oKSypiERkwofIgDfPOPLyRrtzZYaGeHQKQcK9CUcTVGFg491qvHvZ8zoxiW/b+MDTJPR
 LevZYMHKKiMnN4el2Oz+yqlTSwBszSEX1OUvPj30Qed6COLjioxbpfHssdt914C3c7pVvu/yj
 AhcmAQY8Sqla0pQoDIKKvXLJWj4AFZpy5X0CCCg04OI6n/DT4HebzPbMVUyzZPs0wcoUWgIwy
 kwuBVGQ+0cESdp6vb/v1+RlalxMZKtKvVy7THVigdfQUA=



=E5=9C=A8 2024/2/20 11:22, kernel test robot =E5=86=99=E9=81=93:
> Hi Qu,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on linus/master v6.8-rc5 next-20240219]
> [If your patch is applied to the wrong git tree, kindly drop us a note.

This is applied without the previous preparation patches.

Is it possible to teach LKP to fetch from certain branch other than
applying them directly to for-next?

Do I need certain keyword in the cover letter?

Thanks,
Qu
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-m=
ake-__extent_writepage_io-to-write-specified-range-only/20240219-141053
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> patch link:    https://lore.kernel.org/r/02f5ad17b6415670bea37433c8ca332=
a06253315.1708322044.git.wqu%40suse.com
> patch subject: [PATCH 3/4] btrfs: subpage: introduce helpers to handle s=
ubpage delalloc locking
> config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/2024022=
0/202402200823.Su3xBnia-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arch=
ive/20240220/202402200823.Su3xBnia-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402200823.Su3xBnia-lk=
p@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     fs/btrfs/subpage.c: In function 'btrfs_folio_set_writer_lock':
>>> fs/btrfs/subpage.c:758:60: error: 'struct btrfs_subpage_info' has no m=
ember named 'locked_offset'; did you mean 'checked_offset'?
>       758 |         start_bit =3D subpage_calc_start_bit(fs_info, folio,=
 locked, start, len);
>           |                                                            ^=
~~~~~
>     fs/btrfs/subpage.c:374:45: note: in definition of macro 'subpage_cal=
c_start_bit'
>       374 |         start_bit +=3D fs_info->subpage_info->name##_offset;=
              \
>           |                                             ^~~~
>     fs/btrfs/subpage.c: In function 'btrfs_subpage_find_writer_locked':
>     fs/btrfs/subpage.c:785:70: error: 'struct btrfs_subpage_info' has no=
 member named 'locked_offset'; did you mean 'checked_offset'?
>       785 |         const int start_bit =3D subpage_calc_start_bit(fs_in=
fo, folio, locked,
>           |                                                             =
         ^~~~~~
>     fs/btrfs/subpage.c:374:45: note: in definition of macro 'subpage_cal=
c_start_bit'
>       374 |         start_bit +=3D fs_info->subpage_info->name##_offset;=
              \
>           |                                             ^~~~
>     fs/btrfs/subpage.c:787:55: error: 'struct btrfs_subpage_info' has no=
 member named 'locked_offset'; did you mean 'checked_offset'?
>       787 |         const int locked_bitmap_start =3D subpage_info->lock=
ed_offset;
>           |                                                       ^~~~~~=
~~~~~~~
>           |                                                       checke=
d_offset
>
>
> vim +758 fs/btrfs/subpage.c
>
>     736
>     737	/*
>     738	 * This is for folio already locked by plain lock_page()/folio_l=
ock(), which
>     739	 * doesn't have any subpage awareness.
>     740	 *
>     741	 * This would populate the involved subpage ranges so that subpa=
ge helpers can
>     742	 * properly unlock them.
>     743	 */
>     744	void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_=
info,
>     745					 struct folio *folio, u64 start, u32 len)
>     746	{
>     747		struct btrfs_subpage *subpage;
>     748		unsigned long flags;
>     749		int start_bit;
>     750		int nbits;
>     751		int ret;
>     752
>     753		ASSERT(folio_test_locked(folio));
>     754		if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->map=
ping))
>     755			return;
>     756
>     757		subpage =3D folio_get_private(folio);
>   > 758		start_bit =3D subpage_calc_start_bit(fs_info, folio, locked, st=
art, len);
>     759		nbits =3D len >> fs_info->sectorsize_bits;
>     760		spin_lock_irqsave(&subpage->lock, flags);
>     761		/* Target range should not yet be locked. */
>     762		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, =
nbits));
>     763		bitmap_set(subpage->bitmaps, start_bit, nbits);
>     764		ret =3D atomic_add_return(nbits, &subpage->writers);
>     765		ASSERT(ret <=3D fs_info->subpage_info->bitmap_nr_bits);
>     766		spin_unlock_irqrestore(&subpage->lock, flags);
>     767	}
>     768
>

