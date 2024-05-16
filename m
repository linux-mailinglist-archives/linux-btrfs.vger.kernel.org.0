Return-Path: <linux-btrfs+bounces-5035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452758C735E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F541C21533
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ADE143720;
	Thu, 16 May 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JryNDAFA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B67142912;
	Thu, 16 May 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850128; cv=none; b=ImlV0uuRZBSAK1T0UeYKUG40HLTqMypl6zFp41qjKjBp9g8/tCelsea2ddfXQMeDns2vNS36NTckLncQDlgJ2uvj63g24z4ZXMdkAlQG2ttEmohk4ELPyushGFSEqMNJaW9e9/bhroHtauAqmi7xk8kR/aoeMrCxSTSrlPNBEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850128; c=relaxed/simple;
	bh=lIRA8UJBvXfoXmKVmWIGOJ0GywIizfIUSdLRyMXqjMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKVBpEUB+IK2BJpJwLpr1+lsqAI5P/zC02fwA8RR9JDbXljRV9Jm5iHjMx1tcEGnWDECKR+vi4HsWnPhFcVvnSmWutdMjaC+iflM03xZNveom3QWnu1pVPPY0/Yn/g4gF5aQQ/Is0g5wfRorn1kr/HwtEHGRYnMS/gUVz44aubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JryNDAFA; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715850122; x=1716454922; i=quwenruo.btrfs@gmx.com;
	bh=mnnHi7dEPrzkF5r/8QGFI2q704iOW15PoFd8fUilYcM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JryNDAFA144apy42OoPmPAIMaifYmMeiwZjtV2/mjHUGG1lSJrMztA4xTwjlpW06
	 Ut6gjBUXi/ilH84cunooz/LOOZhT7KAD+oqwNdIsSsMj9JGdyTsof93CNd111/86m
	 lCCD+ZSkwgTV7q+wvqd3bM0jQsLp/6J/f4jdue9fNhiJjMkFGsTjx+yOmShHbiDKm
	 RQmxJPGlZElEJSFKskEFqiaevOe+oVCiasIc/zUQz6dgvxSQ76aJFCc/9/p2F7dqj
	 kl12GY+MmWEWJ9tC62sINqVmYPOYctBGprWc86jHjkgU/9jYagXE57kfewo9yWvfx
	 C4kpC/fPpNDz5SREKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUjC-1sPTI33Hda-00vBbD; Thu, 16
 May 2024 11:02:02 +0200
Message-ID: <32730052-b40e-4262-a1c4-0d45a9b6de53@gmx.com>
Date: Thu, 16 May 2024 18:31:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Btrfs updates for 6.10
To: Linus Torvalds <torvalds@linux-foundation.org>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715616501.git.dsterba@suse.com>
 <CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com>
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
In-Reply-To: <CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:th+2L7V190rD1RfZG7IykMwoYEu+a/e8iWdrSQcDSM7CF3pGlE0
 ED4C6ybhHVhS72ZRzw1PPP5ygvEt/G8t2qa5Xvr2NmzVezeLJbGIDUi8zIr8gxiKMDFo9/v
 CZkajmKEvkbMLyR3lpRryDeEre0AnDqMZkNZBtO9rOiE69NY8X5dLZ+6htYWRmrFSM0eyK2
 6nIVbANucZKuG2wPoVuoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4078ckCVUVY=;5I3RZz7zgkLCRpnmRxPUhXv5DQa
 T9GDZ7+06Eii5qb3kGHsBg/rUo02h2rwo9HT2bWCflAga/Ii3L9nsIINJRlYPSEXHileqa8b2
 Pp4OwS0cdFFThFRSSg2wPD2mtIDoFv2emG6/v+lvNu9d3SRsbMaOmn80Jl2GfybRcfem3goXD
 eVPg6SYHBJeYq0J8/jfD7E0ETwjE0VI7ftCk062S3rarOA/dxtaQEwyHuZQ6BRueiegYelOFp
 8fhHUXhuTnNmrofZkUBFWq1R/skhqC112MkmYlnND3WQ7WPehY1gkrpl3XdWwbol4h9t5CFUI
 /Bi+WAi2vOku1b6kU0M4MYgR+nip+lSvRPCzMXWtvrwYcB5qJIFoD9FBvUP5Q9/LUx5OC8+EE
 kPhP74ZW2jJ7RxIkfy0PSRZ0QWlpP9plZck/qIRqcjNHQE3K+VXpjkNB4nilS3NglwvgvQO4p
 9fTd9UoQmYqvb4pNpBpn0+vf2BWQXngTpz0okx/c8d2/GJyBWI4d90Tkliq23eV8Sb3LsIsKO
 uyLK5S0CgW6N62N15JfkwgQHXu6AWDugnTR3oBFy529vPfVKLk6ZBkDVh6d6t/phaCcxFiLj+
 LVRT39D33m4K0f3SrrqkuirmrhpjseGcCIoghxGKj14AOZMT/u2/ueDR+yoX+HSi1+jJX7Jy+
 rDguDFhaco+x0yEuDmJ06tJSV3ucHWfsglWE0jTn5y+0egvT0Tj/VDB+3Si3I8k1WwTYMrq+R
 RQAY4Llr1FD03LDGiiZJ6hVHq2rcpxnPy1d96JImRVBFyNF0/f2VjFd79kzsmd1Id9y4eivre
 SEdWfRhs16NVFKACk1cR5Nu9/Q118S38Kvs58yBqX9/H8=



=E5=9C=A8 2024/5/16 10:01, Linus Torvalds =E5=86=99=E9=81=93:
> On Mon, 13 May 2024 at 09:28, David Sterba <dsterba@suse.com> wrote:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/f=
or-6.10-tag
>
> So I initially blamed a GPU driver for the following problem, but Dave
> Airlie seems to think it's unlikely that problem would cause this kind
> of corruption, so now it looks like it might just be btrfs itself:
>
>    BUG: Bad page state in process kworker/u261:13  pfn:31fb9a
>    page: refcount:0 mapcount:0 mapping:00000000ff0b239e index:0x37ce8
> pfn:0x31fb9a
>    aops:btree_aops ino:1
>    flags: 0x2fffc600000020c(referenced|uptodate|workingset|node=3D0|zone=
=3D2|lastcpupid=3D0x3fff)
>    page_type: 0xffffffff()
>    raw: 02fffc600000020c dead000000000100 dead000000000122 ffff9b191efb0=
338
>    raw: 0000000000037ce8 0000000000000000 00000000ffffffff 0000000000000=
000
>    page dumped because: non-NULL mapping
>    CPU: 18 PID: 141351 Comm: kworker/u261:13 Tainted: G        W
>    6.9.0-07381-g3860ca371740 #60
>    Workqueue: btrfs-delayed-meta btrfs_work_helper
>    Call Trace:
>     bad_page+0xe0/0xf0
>     free_unref_page_prepare+0x363/0x380
>     ? __count_memcg_events+0x63/0xd0
>     free_unref_page+0x33/0x1f0
>     ? __mem_cgroup_uncharge+0x80/0xb0
>     __folio_put+0x62/0x80
>     release_extent_buffer+0xad/0x110
>     btrfs_force_cow_block+0x68f/0x890
>     btrfs_cow_block+0xe5/0x240
>     btrfs_search_slot+0x30e/0x9f0
>     btrfs_lookup_inode+0x31/0xb0
>     __btrfs_update_delayed_inode+0x5c/0x350
>     ? kfree+0x80/0x250
>     __btrfs_commit_inode_delayed_items+0x7a1/0x7d0
>     btrfs_async_run_delayed_root+0xf7/0x1b0
>     btrfs_work_helper+0xc0/0x320
>     process_scheduled_works+0x196/0x360
>     worker_thread+0x2b8/0x370
>     ? pr_cont_work+0x190/0x190
>     kthread+0x111/0x120
>     ? kthread_blkcg+0x30/0x30
>     ret_from_fork+0x30/0x40
>     ? kthread_blkcg+0x30/0x30
>     ret_from_fork_asm+0x11/0x20
>
> Note the line
>
>      page dumped because: non-NULL mapping
>
> but the actual mapping pointer isn't a valid kernel pointer. I suspect
> that may be due to pointer hashing, though. I'm not convinced that's a
> great idea for this case, but hey, here we are. Sometimes those "don't
> leak kernel pointers" things cause problems for debugging.
>
> Anyway, it looks like the btrfs_cow_block -> btrfs_force_cow_block ->
> release_extent_buffer -> __folio_put path might be releasing a page
> that is still attached to a mapping. Perhaps some page counting
> imbalance?
>
> This all happened under fairly normal - for me - workstation loads. I
> was (of course) doing an allmodconfig kernel build after a pull, and I
> had a handful of terminals and the web browser open. Nothing
> particularly interesting or odd.

Considering aarch64 is going more and more common, is the workstation
also an aarch64 platform? (the Ampere one?)
If so, mind to share the page size and the fs sectorsize?
That would at least help us to know if it's the subpage routine or the
regular routine.

Thanks,
Qu

>
> Does the above make any btrfs people go "Ahh, I see how that would be
> a problem"?
>
>              Linus
>

