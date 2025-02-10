Return-Path: <linux-btrfs+bounces-11355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67790A2E2E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 04:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB8518879C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 03:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58314136353;
	Mon, 10 Feb 2025 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Y3yHEFnm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DCEAF9;
	Mon, 10 Feb 2025 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739159042; cv=none; b=m/rkb646/KHmiiXwzm8olTyhuu8d1VHHPbOfpSbwAy6+/LEtkrnnZQzxNmXCz2Gzk6XMnWKg8aQ7taCZAn8Ooa3iMGy/cHIvxThGMynUG0upokXZpURUwKrAQdzMuvxuont1IqwoROflye74PntcRbJ2xU18Q1v0K7bufupjHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739159042; c=relaxed/simple;
	bh=etRl/w/+lJahfy7085LciTan6joe4zZley44pzfY5Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZyAw7O3E8X5uK42pWmIXJhUPzocY48KtnyRNWdXvJi8vHKR5XUlDzIDgYPGCxyBSti9JB1NlGWSDGZl3EhPgwGzEqGr5ZwSb3CHXzm+c9+XclVFF1/boO8b/LQYpOXlQUeBgJnlJuhMKov1VRRn4xxoxTal/mFZVCbNljz0Egc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Y3yHEFnm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739159038; x=1739763838; i=quwenruo.btrfs@gmx.com;
	bh=EeYCEnuyMNkJlhJ3+18Q0rFZXH4JqLrlkJiGZ+0f8Ac=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y3yHEFnmD69y5D6YdGydIWgGBMpYJsrkRr9wIzGkADOD5brudyvMNErhopfnhywS
	 NOm5qY9+5KuWzbbco/p/D30C8EVWPBk6egxACw1dqiyh6JxM0B3ylZ2Xn3NbckYvy
	 wfEAfaBcWhVcaaNSlfeRt4mgaqphKB3xVr6LzhbWPW2Fus5fYt4ojotuUxqXQfK5c
	 VIvz+3UEXy5mc9BIo4ifIGWAsQbtlL8nQgaMEzZM7dG6ujOE35WIFetkehcmXUC+O
	 P8UpYlVDGiN1eKC0sKrXXhSr5YLLUX+btN+4Pzc0Sx9rO01W1lpADCaEIlfkb6SzX
	 yJJDwfQO23+rKcq+lQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4hvR-1tIL8M2ioh-017pcA; Mon, 10
 Feb 2025 04:43:58 +0100
Message-ID: <a33deb4e-3f6c-4a5e-9da9-ad403a858aca@gmx.com>
Date: Mon, 10 Feb 2025 14:13:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs crash on generic/437 on x86_64
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <152296f3-5c81-4a94-97f3-004108fba7be@gmx.com>
 <Z6ly-MHIztjtS98S@casper.infradead.org>
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
In-Reply-To: <Z6ly-MHIztjtS98S@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LLy5GXbSUeY6DS6SNu1Kc1wnYrQtHb2NWtYku0Wtdtme58CupFV
 r4yMuDCvYnGx8ub0SSYB7wZz5aWLUIS4cod4DRBxwErjhZpKhWDtHXUwJqSd9YZgJflIGmm
 dvvM1cwMThPJn3kBpis+zd7GrPWAdW8uhfaMdEujbxXUb5poDtJt4rROjfswGPV3acsY37E
 D2fj+r8r5gltD/CgTbk1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M02VkZt4hM4=;ve7NtMkG2tFgPtZcDkDih72urOY
 +9Jmv43FA6YL9T4J5Wf9rwAveSBkqwZ4L20sWpIzQuQs3Fipy3I5EeeY4HbNMEnwvsFfKBsAr
 z3V+deX4bDSwc73w/h9ue695NFUZ/HCqYpWfMhj4Yll7hjNrWBaOpRKtdHL7sBANnnrdhLKV5
 PSeL9aPvueo4UWmJosp22jDPF2Ma7Xsb5h7K2AjCOHFSRp7nPW+hR5SbV5EkQNp7EoYgs7Mcg
 PlxBgICe64QQp9BI0F6FyfATdx9gdX6WSGodRvRkFHcUivcgQ5Yyi3MOQnbs0t9XowLGj4ufB
 GgKd9qjGDgSdazspAziqAeOY+AJi7iS2jCUOJ66jqc0kaCMSw3wUqWxjg55DMxiMqf7zXaVdV
 v9+OrcqRiF7YGyWUYr1+pBTLNrbZcxZTs9bMDaKAzeq2zQvm7knb28PtCs2QSvwEjPZnc1gKI
 6dtDlXy6TcNEkyDpg8GP7matDCia6j+HZ6lVOSjqMvOaPH04X+Re4+TtAgL17hu2gHMxDQ7d4
 8UgPKxBOzPNlQvFrogPTVf8315IwXLlIUsjD7JmgQEbWu6KYwHgJmjqnqkc1PYauw1LETdcCE
 y4D3Te9WkFvEOeh2sGelFuz7zwsGLOMMeYAjglULECUM7yM4bmqKRyNXsG+K1rWQ88GP4Pf0h
 HdS939PI7QWc7k6Ht9HicMo35xKnGS/WHzfvBjiZapFHhl7xUsOZ8entTbIe9XUSm/lleLuj1
 aqNWQwqQl8nsP23wOMw/IwNS9rgBDEjT478OHahpfJwyadQhV4n21+ZYXlOE2sRYDWkOJESm1
 HN1S+EMfwYFycHcgZ0PleX9iHs6syFN+sAV02pudD2CHeohqrGpzpqAbOSm7HuUsXjSiA1DL7
 19KM7uhKBfy+Gdu6J0UVhGVm1w3s+2pVlOWp1KuLMSOZb0PeTiKqhxEwuL1nao2yEJjQ880JU
 tSxycJM6pmRWrmo4ZYtKDVjQvmwbfTsBv5gr0fXzPGlg66H5fJr1v21WiAf/qhpYJLOWb9sOm
 vXQ/jmKwmriNUOOB0pe0UycwvMpf1bsRi9ZDt6H6HYd9K0KWcGLGxonByS3NvPNKtUfFHG9kA
 br/Gp26ct3N6oqNaEgFC/v7GW5EjnIW7CFR3Gq1q8OEE2DyLH779HYqv1vs8W2TrlT7D8YF3k
 LdpRk09Rq4XfXMFbzi6hDb6WBDi1Xjkbtm5UvB5E2X7MUqFDm0woF9mf2EU9EvXd1dp8bwk+R
 OfxuGH7pDlZYOYTlXMCxYDoNaDFI0tutBxogV5HxfCMvdm181XIBhqhCKH+/9IsKATt61n/ON
 SVeeIpLfTbQDchuX+gHreRsAXXkHc0pyFpAkGG8rC5+A+8gjAOsvAhlspUs4RSGWQXwz0NM0F
 37ys/MoyZ31aGDMaTcHcUdWbreB2SMWc/W4E4s9XR9Z8J0pE1DiYEbzHxo



=E5=9C=A8 2025/2/10 14:01, Matthew Wilcox =E5=86=99=E9=81=93:
> On Mon, Feb 10, 2025 at 01:40:16PM +1030, Qu Wenruo wrote:
>> But this one is a little weird, we got a folio which is still mapped
>> during filemap_unaccount_folio().
>>
>> I can reproduce it with default mount option with generic/437, so far 3=
2
>> runs are enough to trigger it reliably.
>>
>> And I'm not yet able to reproduce it on aarch64 (64K page size, 4K page
>> size so far).
>>
>> I'm already trying to bisect the bug, it so far it's still reproducible
>> at 6.14-rc1.
>>
>> Any advice/clue would be appreciated.
>>
>> Dmesg:
>>
>> [   58.305921] BTRFS info (device dm-0): using free-space-tree
>> [   58.319296] run fstests generic/437 at 2025-02-10 13:24:19
>> [   59.283069] BUG: Bad rss-counter state mm:0000000048578720
>> type:MM_FILEPAGES val:1
>
> This is the original problem, all else is a consequence.  We're calling
> check_mm() in __mmdrop() -- ie we're dropping the last refcount on a
> task, and the counters show one page is still mapped.  And it's a file
> page.  (now see below for the consequence)
>
>> [   59.296485] page: refcount:3 mapcount:1 mapping:00000000828f872f
>> index:0x0 pfn:0x13ab4f
>
> This folio still has a mapcount of 1.
>
>> [   59.297223] memcg:ffff888105a32000
>> [   59.297533] aops:btrfs_aops [btrfs] ino:1031b
>> [   59.298188] flags:
>> 0x2ffff800000002d(locked|referenced|uptodate|lru|node=3D0|zone=3D2|last=
cpupid=3D0x1ffff)
>> [   59.298955] raw: 02ffff800000002d ffffea0004184948 ffffea0004c40c88
>> ffff888107c7a2b8
>> [   59.299607] raw: 0000000000000000 0000000000000000 0000000300000000
>> ffff888105a32000
>> [   59.300261] page dumped because: VM_BUG_ON_FOLIO(folio_mapped(folio)=
)
>> [   59.300846] ------------[ cut here ]------------
>> [   59.301256] kernel BUG at mm/filemap.c:154!
>> [   59.301635] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> [   59.302144] CPU: 4 UID: 0 PID: 17354 Comm: umount Tainted: G
>>   OE      6.14.0-rc1-custom+ #211
>> [   59.302953] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
>> [   59.303447] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> unknown 02/02/2022
>> [   59.304291] RIP: 0010:filemap_unaccount_folio+0x153/0x1f0
>> [   59.305224] Code: b0 f0 00 00 00 e9 5d f6 00 00 48 c7 c6 80 1b 43 82
>> 48 89 df e8 ae 89 04 00 0f 0b 48 c7 c6 10 d8 44 82 48 89 df e8 9d 89 04
>> 00 <0f> 0b 48 8b 06 a8 40 74 4c 8b 43 50 e9 ce fe ff ff 48 c7 c6 80 1b
>> [   59.308807] RSP: 0018:ffffc90005387a18 EFLAGS: 00010046
>> [   59.309382] RAX: 0000000000000039 RBX: ffffea0004ead3c0 RCX:
>> 0000000000000027
>> [   59.310313] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
>> ffff888277c21880
>> [   59.311856] RBP: ffff888107c7a2b8 R08: ffffffff82cad0a8 R09:
>> 00000000fffff000
>> [   59.312879] R10: ffffffff82c55100 R11: 6d75642065676170 R12:
>> 0000000000000001
>> [   59.313607] R13: ffffffffffffffff R14: ffffc90005387ad8 R15:
>> ffff888107c7a2c0
>> [   59.314347] FS:  00007ff0455f2b80(0000) GS:ffff888277c00000(0000)
>> knlGS:0000000000000000
>> [   59.315159] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   59.315744] CR2: 000055e761f94f58 CR3: 0000000166a44000 CR4:
>> 00000000000006f0
>> [   59.316476] Call Trace:
>> [   59.316749]  <TASK>
>> [   59.321408]  delete_from_page_cache_batch+0x95/0x3c0
>> [   59.321912]  truncate_inode_pages_range+0x142/0x570
>> [   59.322413]  btrfs_evict_inode+0x8b/0x390 [btrfs]
>
> So we're evicting an inode, and we ask truncate_inode_pages_range()
> to get rid of all the folios in the inode's mapping.  It walks the
> rmap to find them all ... and doesn't find the one above because it's
> exited already.
>
> We need to figure out how we came to not unmap the page from the page
> tables originally.  Looking through the merge log of the mm tree, my
> suspicion falls on the following patchsets:
>
>         - "synchronously scan and reclaim empty user PTE pages" from Qi =
Zheng
>           addresses an issue where "huge" amounts of pte pagetables are
>           accumulated:
>
>         - "mm/vma: make more mmap logic userland testable" from Lorenzo
>           Stoakes continues the work of moving vma-related code into the
>           (relatively) new mm/vma.c
>
> but of course it could be almost anything.
>
Bisecting now, thankfully v6.13 seems good, so it's just in this merge
window.

Would report back with bisect result and log.

Thanks,
Qu

