Return-Path: <linux-btrfs+bounces-7598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D89961ACA
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 01:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2398C283430
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F95A1D415F;
	Tue, 27 Aug 2024 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oEI84dlp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883477117
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802500; cv=none; b=mtEtKGhsMO3VYykqHMhcjHo+pX5UzMvVaGTYnQxE/NAoRMhT/yPqiJKmFc3UjY8BMNsAvIbFNYFxad2Yxem9cK89uTKttbo1ebnn5pTe5lSbKvMOpQbaI1jVlwe6a+/r8GwVC3EuM9AIVVXYKFlh18g/ekcP22H1YmfCHA6ZnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802500; c=relaxed/simple;
	bh=CVh8GR8wPCWx+6OTjriMoDOcO1SfoM1aGWgSnnYnS5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/fdRantUvhfVYNnN3J8tAioM5jRvGEg61DQk2xQuTt0Z6uGvAy7bjbb2pGNTm2jg+jmYsdJZohI4dtPsj8IoVKuDd5dDzICy91weZ9f2IuqrJ1YCPv9r1O1vLJk14hqgKRZ7lGwGOYnxn1wbslALsx63KxjpeY3ruJdlg8pJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oEI84dlp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724802495; x=1725407295; i=quwenruo.btrfs@gmx.com;
	bh=CVh8GR8wPCWx+6OTjriMoDOcO1SfoM1aGWgSnnYnS5Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oEI84dlpn2l3LY8S0bfQy8I/JaTJWThf4OFt/YW/QsGr7anoUKI8F2OFvh0fuUe8
	 KM3nYzsFnKPArEFLKHcqGkC2QK+yLsIjYTuMItizW2cmeZ6XhVJTHoNRF9weQcSl8
	 WciA0WXKAE/N0i/vh49ebr8TiYcgwpIAQcUh4oIgV1lFcfgBcYXd0xCqLtujHf47z
	 hLn5wIYDwq5a0hF8nHrNKoUCLRLID6Gh35myqoZsBvXl9YpCiww8t1sWFrakZCTRa
	 CpyeTgyhn5Dy476iPyhgf8wE2qjJI9+oQdFM39Q+SxW+mu05GRCxue6hHfO6CzJ8+
	 1GQqXZrbXIukP/Jdrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmULx-1sJ4Yh2VDF-00kN1f; Wed, 28
 Aug 2024 01:48:15 +0200
Message-ID: <9dd14187-ecae-4633-8823-52269ec8dd70@gmx.com>
Date: Wed, 28 Aug 2024 09:18:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] btrfs: clear defragmented inodes using postorder in
 btrfs_cleanup_defrag_inodes()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1724795623.git.dsterba@suse.com>
 <e4ad6d8e46f084001770fb9dad6ac8df38cd3e2e.1724795624.git.dsterba@suse.com>
 <b8754522-47d4-41e6-b47a-261bda449d80@suse.com>
 <20240827231803.GA25962@twin.jikos.cz>
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
In-Reply-To: <20240827231803.GA25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t4xUsfj7CNfZp/iVAjx1HvUnAKrz98HyHXCN3CtilwCpXAa5Qys
 9Ztz0cFp4+QhlL+vEBRkDqqT+k7e+htie/MLw2hesyklE5l6Q7Ornr48cgXLa5XZh2XOnmp
 iF4OEL0wpGuKKXfqLRn7J4CCQ5tdfNqvigAzGDDmRNvGTHkDbHn2036VicSXKiORTmTUnyR
 ily+dDZaaXNsL4O9VwrvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uK7XOq5JdMY=;ZJD97Fr4ZhR8VIwszSBI5nEx3jg
 VvXwoVLZY1QeUnn0DK8ThcLNq2uL8fMGV9DmoNHbDAKQ5XNfwQknIJS9JznBYvcDkJ4I4mOrt
 ZwlNnCIBHFL5ELrMEJzybiFrtAfWrw0wSaeytqRSSprYQHFnjInPW1r4i9y5WVbzwSbehrqaL
 WkDYOiQRQsBdHq9Vljfat4NLVX2+Zd3EBmF66BxPO0SOIIZOFXiw1N+2Oymd6OU4yf4+NfaGK
 kUIqYHL2HApGTo6DEJ3TAo4/JSCz8n1uTl21rS/AKQKYaM4FjEtITyBq5eH1/Mn2H6/HEYbkI
 k7g+HcCRdaNkRM5emj1jiJbq4oZMb1kgB95E6pzEt9YaFY5tVB8JhFK5xn+Oejw0HcL0+4OMk
 bccSGYHoudSfdrNL6f9L7BmKl/EQ5p9DsQj+cmg2LmzQjSaaKtLoGijBKioCH1Px3UfHxw3QC
 MUCkI/fItktePhqoEhAfi8V2G42GQOZZdf/JiO2MoWE+LxGzh/Yl72/PAZM05zH4QJ8em0xIy
 EpefoufT57QE2tCKX1p10imT8xqunGOSBCVtbDn16i+bYfZdbgIbl8SABLRikrFRvUHRd+Svz
 bwdbflWPe5KhF5OaiC6KFj+wamaFroT4wB1i7gIcz+0+aodWeea39tdKC6L1hJs7dIUD9uiYi
 MSgAJiLrJ7D0GXb6P2IJmJAirfGdbIEXIBwMtMeiR+crUyDytXISh3m/DHclG1k7+u/m+h/6N
 q0PAw4EujPdjcQ3yoDMkb0qoGuaJIhLPLLKS/ECwxOwivLgKi6OheZyh8tQ92nACx2vkp26do
 AvPAtBAFgoxYizFmh9ef2xmg==



=E5=9C=A8 2024/8/28 08:48, David Sterba =E5=86=99=E9=81=93:
> On Wed, Aug 28, 2024 at 08:29:23AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/8/28 07:25, David Sterba =E5=86=99=E9=81=93:
>>> btrfs_cleanup_defrag_inodes() is not called frequently, only in remoun=
t
>>> or unmount, but the way it frees the inodes in fs_info->defrag_inodes
>>> is inefficient. Each time it needs to locate first node, remove it,
>>> potentially rebalance tree until it's done. This allows to do a
>>> conditional reschedule.
>>>
>>> For cleanups the rbtree_postorder_for_each_entry_safe() iterator is
>>> convenient but if the reschedule happens and unlocks fs_info->defrag_i=
nodes_lock
>>> we can't be sure that the tree is in the same state. If that happens,
>>> restart the iteration from the beginning.
>>
>> In that case, isn't the rbtree itself in an inconsistent state, and
>> restarting will only cause invalid memory access?
>>
>> So in this particular case, since we can be interrupted, the full tree
>> balance looks like the only safe way we can go?
>
> You're right, the nodes get freed so even if the iteration is restarted
> it would touch freed memory, IOW rbtree_postorder_for_each_entry_safe()
> can't be interrupted. I can drop the reschedule, with the same argument
> that it should be relatively fast even for thousands of entries, this
> should not hurt for remouunt/umount context.
>

Considering the autodefrag is only triggered for certain writes, and at
remount (to RO) or unmount time, there should be no more writes, the
solution looks fine.

Thanks,
Qu

