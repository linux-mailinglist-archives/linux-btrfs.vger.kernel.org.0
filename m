Return-Path: <linux-btrfs+bounces-7600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322B961B01
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 02:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446C41C22E06
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C28BFC;
	Wed, 28 Aug 2024 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oEDelO50"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A7A48
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804008; cv=none; b=cWoh+ddg39sqQwPASHIn6lOIyg3USsjeYHs0UAgmfvhIKZl4G2sc5ABm3chdID7k75zA1wTDY02EFy5E1oPHcvlf9jib/XAxMeDPmKV7IRx/WSJtSepeVDuAfqHBTNnG9eEwonQ9KU5GHt84QPxHAT+J5iA01XwSc7GsLlV1Nak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804008; c=relaxed/simple;
	bh=FDJQv6T3BPg6xctW0+jDoPg68ch0kYYCvnkn65OUmx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvfAAGoroI5pdCYarWzTiYd8ywU+IBfnWedllM0cSMGhWCjzawgCpmbsyLxD1JNMEL1GCEi5/DUQeWrrt3FY9ByDlirr4wlWJ9KGhV1Fw1ES/tJbmJ6aeAlCBv3krTVdWwVAjPZ/buFRtFsK7tfuYlzSECJhQIrND2UIc7NQv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oEDelO50; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724804002; x=1725408802; i=quwenruo.btrfs@gmx.com;
	bh=uOVP045SSl8fKBmoGqRSbGxq3r/7lYxrOJovSdqXQTs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oEDelO50RnEVNEYZW1eRqjxHpQiYdjpMdXv66EMmjQ/2+ew78s2IpDrItdrS7NFg
	 hpQ1cdEaDY207nddGy8tpbpjJraoZelL3pT0Mxgn2hYCF42OktwY/6RsekKlpdSz6
	 Huo1WvlmTpoHQ/D8tcirC7smln7Cs6648P4JgHurYZt3o8ZsW/i+/Z0PkU7k9chQV
	 4JvCYlajI5Zm3+3cZnwgYlSWPIf8y8TqTaJ+JKcyxJJhZ1Z0EEaDT5d8vpy9StA+d
	 Kcw47uHlimrwvH1DvK1AC6UD9Am4g6T7iOqZJcIRd68hNH4350FjFHARhA52jEO4q
	 NkRBnY9dG0qpePHemA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42nY-1sj6JN2dpQ-007zKz; Wed, 28
 Aug 2024 02:13:22 +0200
Message-ID: <8cc59c80-444b-4e2a-8d70-40c7b7fd3ff6@gmx.com>
Date: Wed, 28 Aug 2024 09:43:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] btrfs: clear defragmented inodes using postorder in
 btrfs_cleanup_defrag_inodes()
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1724795623.git.dsterba@suse.com>
 <e4ad6d8e46f084001770fb9dad6ac8df38cd3e2e.1724795624.git.dsterba@suse.com>
 <b8754522-47d4-41e6-b47a-261bda449d80@suse.com>
 <20240827231803.GA25962@twin.jikos.cz>
 <9dd14187-ecae-4633-8823-52269ec8dd70@gmx.com>
 <20240828001147.GB25962@twin.jikos.cz>
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
In-Reply-To: <20240828001147.GB25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ikLSyiLdfo1fSbjrfRdSSjEMXIWCCwyiDZk485GECwVyLaQRzr3
 V37riHgbj4pPaCzZYri7T8iiNlZ784WTQ+Uo5Jpi50TTRiUmde0kzCubAnuYKCyhUele5Nn
 bWi6dNZdAswc1ReoZaHgycpJAYNiSNKrOm1S7xezIzb7WUa/VgQ1yRaXIKGpbwir9SLiPj1
 /mnI9EIDmvuwtARLCwjsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OHvWRpyH75s=;FtZI5a+57JHeDaw6NZ+P9zS95cz
 zcgAkC2FLvGPeZTWc+xf9N0lx0wBLaF/cx+RDckCIhNz28NN+xuM+TAY4DR+R5Cc8fO1B97vI
 4BlMGqp867tVgHtpTjopBhdUKd0/EIefHV4COjuZWPzMEmzfGYA2X6F5ZgKzH1QNgcJ4fvJ00
 1PBXJSdCL/82JYfQ09zY+9/Suj0zu7Bx/Tt8Gp2q+ZSwDPzMjmnFUkb0wIqac0BTkvV+FeQPQ
 9EpyUiScgvzpaqtJm3FIuItyZsFSAr8i8EkAClI7tnAHEr1OdVtO675KbYaJjsQR04Dlm84fa
 YJVtsTnmCFw3+w+NsN1azID2Od4eTFxm2azXzwwXszGZfl8isEP4zAc6W5XrFqoqVE1lRT9xT
 tHMDbL0stcIoKTW8jIk6O34NmlcatdLoo7aTSwSrqRpB5B/gj4T5tmXrI3KgRpMgXGSVNLRKn
 QVSqSGjMAQZ29ahMojucB45N+b84Qu49Le4XFi+7ZGAQ069MalMfyHEJpeFt04z8NCrz215Cv
 irp+1iRBDrGrJhz69ZIicO1237SgjL2HGo3lIT1CvppyUj8kmAT5z6uJhH0f+8l6UupWhl7Po
 aj7PyY72qr/0iWCKJyfwfWP4Gu/OrQWH8QN23EMUHsupqQVpBPHaWvmu6LiyDwkPZEgOvwqy+
 gOj991AgjybtMIyODlbaz4hzkdZ6bKUG1PubjIcVfDH0ZxSzVlvwnw94DZWvO3uMGnl4fF9Zw
 n4yCg5YzHemGjOuPVIz75DU08qG3JsvG3WHQfG+dZ8AtuNqxlzsDNTPAnwzPqngXGYXK13Q/g
 B2Ag8qw295UN2cJmGnjRF8Ig==



=E5=9C=A8 2024/8/28 09:41, David Sterba =E5=86=99=E9=81=93:
> On Wed, Aug 28, 2024 at 09:18:11AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/8/28 08:48, David Sterba =E5=86=99=E9=81=93:
>>> On Wed, Aug 28, 2024 at 08:29:23AM +0930, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2024/8/28 07:25, David Sterba =E5=86=99=E9=81=93:
>>>>> btrfs_cleanup_defrag_inodes() is not called frequently, only in remo=
unt
>>>>> or unmount, but the way it frees the inodes in fs_info->defrag_inode=
s
>>>>> is inefficient. Each time it needs to locate first node, remove it,
>>>>> potentially rebalance tree until it's done. This allows to do a
>>>>> conditional reschedule.
>>>>>
>>>>> For cleanups the rbtree_postorder_for_each_entry_safe() iterator is
>>>>> convenient but if the reschedule happens and unlocks fs_info->defrag=
_inodes_lock
>>>>> we can't be sure that the tree is in the same state. If that happens=
,
>>>>> restart the iteration from the beginning.
>>>>
>>>> In that case, isn't the rbtree itself in an inconsistent state, and
>>>> restarting will only cause invalid memory access?
>>>>
>>>> So in this particular case, since we can be interrupted, the full tre=
e
>>>> balance looks like the only safe way we can go?
>>>
>>> You're right, the nodes get freed so even if the iteration is restarte=
d
>>> it would touch freed memory, IOW rbtree_postorder_for_each_entry_safe(=
)
>>> can't be interrupted. I can drop the reschedule, with the same argumen=
t
>>> that it should be relatively fast even for thousands of entries, this
>>> should not hurt for remouunt/umount context.
>>>
>>
>> Considering the autodefrag is only triggered for certain writes, and at
>> remount (to RO) or unmount time, there should be no more writes, the
>> solution looks fine.
>
> Ok, thanks. I'll commit the following updated version:
>
> btrfs: clear defragmented inodes using postorder in btrfs_cleanup_defrag=
_inodes()
>
> btrfs_cleanup_defrag_inodes() is not called frequently, only in remount
> or unmount, but the way it frees the inodes in fs_info->defrag_inodes
> is inefficient. Each time it needs to locate first node, remove it,
> potentially rebalance tree until it's done. This allows to do a
> conditional reschedule.
>
> For cleanups the rbtree_postorder_for_each_entry_safe() iterator is
> convenient but we can't reschedule and restart iteration because some of
> the tree nodes would be already freed.
>
> The cleanup operation is kmem_cache_free() which will likely take the
> fast path for most objects so rescheduling should not be necessary.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
>
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -212,19 +212,12 @@ static struct inode_defrag *btrfs_pick_defrag_inod=
e(
>
>   void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
>   {
> -       struct inode_defrag *defrag;
> -       struct rb_node *node;
> +       struct inode_defrag *defrag, *next;
>
>          spin_lock(&fs_info->defrag_inodes_lock);
> -       node =3D rb_first(&fs_info->defrag_inodes);
> -       while (node) {
> -               rb_erase(node, &fs_info->defrag_inodes);
> -               defrag =3D rb_entry(node, struct inode_defrag, rb_node);
> +       rbtree_postorder_for_each_entry_safe(defrag, next, &fs_info->def=
rag_inodes,
> +                                            rb_node) {
>                  kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
> -
> -               cond_resched_lock(&fs_info->defrag_inodes_lock);
> -
> -               node =3D rb_first(&fs_info->defrag_inodes);
>          }

Since it's just a simple kmem_cache_free() line, there is no need for
the brackets.

Otherwise the whole series looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>          spin_unlock(&fs_info->defrag_inodes_lock);
>   }
>

