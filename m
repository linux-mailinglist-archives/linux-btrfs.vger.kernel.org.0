Return-Path: <linux-btrfs+bounces-8550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91A99008E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 12:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFAAB2460C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B914A614;
	Fri,  4 Oct 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qDgZ3OX8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B900146A72
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036542; cv=none; b=E5IxokJUGubEOJvVZgTgq3nwVYd0b2jXoaZeIPG9JEVf11KTblSC4HFLLoA1Okq7kvfMmiA6OvYjdfE73KJabsoJdhuIXZXTtcceow3/vMEcL9Zc9Vev7KylGRc4f1ZS8zMTWzA+V4whRhOMaHtnHMemrmxQxUYRzWFXvonGayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036542; c=relaxed/simple;
	bh=t+2+bIsyXsrDcfj4ABmD7JqHT+VsWheeq9S+yrBD2ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SX4nBFuUesLJ5Zya/RvkNTAcChNBIn0DjnwLP7ltPfwUiIIf0jRMWF1HK7pgbPQ3Y4gwF8wcbUo7NRy+BZL/D1QqK8OdcJgmbPq3e9KZ27Wupucc4P5lNUlqbi4yDobrP1jgs+640J1ua0crVJRAK/Ki21EWakq+TfpMYqTqfz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qDgZ3OX8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728036533; x=1728641333; i=quwenruo.btrfs@gmx.com;
	bh=XtlKoS3FO5ITI9UBz8dGSXMGeoeSmwVakRw76qbLDnk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qDgZ3OX8cVXiwvxzw5NbEgCH88ta0xkjuB1xv0FgTlNzeOqH55cN/qzsgbYK1/Eh
	 eYbhQCtTwTbeCQz7rYx+vMOO9l8M7Dt8t3vjd+ron9AYeuN/ScsD0ye7fW4UOJKUu
	 r6UXZE4qsEubwqwh++I5v9J+YKQOzMN/YF8O1bHWsJ73ggugirGtetcpj9HOS13HE
	 +payBC0oeYcq1YRtcdnhrck6H7WmIq43jZmqCmIEkgp2tELquoCSCgplTWzSL2JKz
	 pdVdVN1OSz2yeGxgO7/S289kGPFOgmqL72o3e2xWo20xeSdhtPXa+absoy7oviDD/
	 rOWuqNRz/3yLFnxOtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq2E-1s3aeK3koC-00stiw; Fri, 04
 Oct 2024 12:08:53 +0200
Message-ID: <e5ddc5d0-cfb7-4a86-bc6d-d88cfa93c103@gmx.com>
Date: Fri, 4 Oct 2024 19:38:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix the wrong rcu_str_deref() usage
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <a4a0faeba1d195f2eb71fcaae388f5976f822dc2.1727904561.git.wqu@suse.com>
 <ace405db-4089-4fe0-b9dc-ef7bacb08f09@wdc.com>
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
In-Reply-To: <ace405db-4089-4fe0-b9dc-ef7bacb08f09@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B1Nzy42MX5PTl9j4cGqOF6BzPrIUc3RDHpDL5gg/MTtDq9dPUGN
 5MK/XT//KMhq2l9+opzsQ74CznU3uc+D0Y4gvWU7FaJp9FlUdq49AauL4T/boWaxz11JMLI
 a9E6pG+FbuGGPBerOqW/ND8XPFlito46M+xsIrH1VKAqIiNRbDA617GUGzM4wQDB7TPoesa
 Sc7vII1hYFWMaDf4m5cEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q2CgkqUmE4o=;I6dWzVwrr6f2m73uVOv5kpqv6GA
 AWHmrQVUkXljkMtIzw8RpyC+TbDc+dESpyHI0K+1DG5iuBXoQus26wgKaic6HuRY9iWwqje1m
 r74sN7CaIa2cOcNQxzlGigPR6nmNoO8nCRgC9dXVwSjf7wi88+lE6TMK5/l4sQSqXr3mztvYq
 cphfMweZQ9MfF0QjNbTCSp5x8CejnxFc67J74PUch44FEPMuA/tA05QAjVhRzkFfnFQjXpt6F
 V9wm5ihs/WI4wT16qWxqSO+P2CE5afU13PjCbgCO9nc5uGATo/geS69CgGhaRfUmdbL5PRVCn
 iut7WvxGu5o8er/gife0277rWBNUEr0P71u2hug4zkNCFpVYiDI1+DzzbYZ85FIqhX3ydWOkk
 FPKNJe/ZkDf6VCAy6vRrhYJrkdGdBXtrfny75FLsqLw9Ys9BhMaxeEenoAsmyazN7OtKTQMxu
 ZF0rnWyksFcUCz09e36AE4g3SSDvYFt7galQY8a4C8s+U3cQE7QZcm3YmsD9ThLS4V2g1fWCY
 iCVl1BDJh4fMzhOZOFuRzcwWQ6uBtqeOyXNGsznBMMF4TLWYXHKWjaOHz1umklnF/SPwabhnY
 MDnj5ibI/IJNFS4TmyRj3ypXkqqJInmkXUp5V1BGX3C92V10a14l5e0LTV2aMd8U0UZLYaeq4
 7vV6TtSpw0xzrMURcZ+RfoLnWLeVQHIgE6yjh0DSwOiguBOY5/HhhLmzlIsOBeQ+6uqbZ6B0X
 7Or2CUZL9T5d5egKwjH+fihGdaxAdRrfL/4Khh6O4vAh4xuw9DAazoKXJMYP7kmOFtOZkncuj
 DEm9MWkEMc87X6XOltsKNYfNvMqZrbfp+r+EtR9n8A81k=



=E5=9C=A8 2024/10/4 19:33, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 02.10.24 23:35, Qu Wenruo wrote:
>> For rcu_str_deref(), it should be called with rcu read lock hold.
>> But inside the function is_same_device(), the rcu string is accessed
>> without holding the rcu read lock, causing rcu warnings.
>>
>> Fix it by holding the rcu read lock during the path resolution of the
>> existing device.
>>
>> This will be folded into the offending patch "btrfs: avoid unnecessary
>> device path update for the same device"
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>    fs/btrfs/volumes.c | 2 ++
>>    1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 35c4d151b5b0..3867d3c18be5 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -807,8 +807,10 @@ static bool is_same_device(struct btrfs_device *de=
vice, const char *new_path)
>>    	if (!device->name)
>>    		goto out;
>>
>> +	rcu_read_lock();
>>    	old_path =3D rcu_str_deref(device->name);
>>    	ret =3D kern_path(old_path, LOOKUP_FOLLOW, &old);
>> +	rcu_read_unlock();
>>    	if (ret)
>>    		goto out;
>>    	ret =3D kern_path(new_path, LOOKUP_FOLLOW, &new);
>
>
> With that patch applied I get the following in btrfs/006 with Qemu
> emulated NVMe drives:
> [  150.421039] run fstests btrfs/006 at 2024-10-04 09:50:53
> [  151.322158] BTRFS: device fsid e9489dbd-0346-4c23-9b8b-9a0221e235f8
> devid 1 transid 8 /dev/nvme0n1 (259:1) scanned by mount (29282)
> [  151.322779] BTRFS info (device nvme0n1): first mount of filesystem
> e9489dbd-0346-4c23-9b8b-9a0221e235f8
> [  151.322789] BTRFS info (device nvme0n1): using crc32c (crc32c-intel)
> checksum algorithm
> [  151.322794] BTRFS info (device nvme0n1): using free-space-tree
> [  152.831300] BTRFS: device fsid 05148ba4-7ee1-480f-af62-7aa0b80b35f2
> devid 1 transid 6 /dev/nvme1n1 (259:0) scanned by mkfs.btrfs (29450)
> [  152.831712] BTRFS: device fsid 05148ba4-7ee1-480f-af62-7aa0b80b35f2
> devid 2 transid 6 /dev/nvme2n1 (259:3) scanned by mkfs.btrfs (29450)
> [  152.832292] BTRFS: device fsid 05148ba4-7ee1-480f-af62-7aa0b80b35f2
> devid 3 transid 6 /dev/nvme3n1 (259:2) scanned by mkfs.btrfs (29450)
> [  152.832747] BTRFS: device fsid 05148ba4-7ee1-480f-af62-7aa0b80b35f2
> devid 4 transid 6 /dev/nvme4n1 (259:4) scanned by mkfs.btrfs (29450)
> [  152.833189] BTRFS: device fsid 05148ba4-7ee1-480f-af62-7aa0b80b35f2
> devid 5 transid 6 /dev/nvme5n1 (259:5) scanned by mkfs.btrfs (29450)
> [  152.872989] BUG: sleeping function called from invalid context at
> include/linux/sched/mm.h:337

My bad, I forgot that the kern_path() can sleep, thus it can not be
utilized inside RCU context.

Instead I should dump the rcu string into a local buffer instead.

And of course I should enable the sleep in atomic for my aarch64 VM too.

Sorry for the RCU related regression again and again.
Qu

> [  152.872995] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
> 29459, name: (udev-worker)
> [  152.872997] preempt_count: 0, expected: 0
> [  152.872999] RCU nest depth: 1, expected: 0
> [  152.873001] 3 locks held by (udev-worker)/29459:
> [  152.873003]  #0: ffffffff8253e968 (uuid_mutex){....}-{3:3}, at:
> btrfs_control_ioctl+0xcb/0x1a0
> [  152.873016]  #1: ffff8881105c18d8
> (&fs_devs->device_list_mutex){....}-{3:3}, at:
> device_list_add.constprop.0+0x126/0x670
> [  152.873027]  #2: ffffffff824cdb60 (rcu_read_lock){....}-{1:2}, at:
> device_list_add.constprop.0+0x193/0x670
> [  152.873036] CPU: 0 UID: 0 PID: 29459 Comm: (udev-worker) Tainted: G
>        W          6.11.0-rc7+ #800
> [  152.873040] Tainted: [W]=3DWARN
> [  152.873042] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  152.873044] Call Trace:
> [  152.873047]  <TASK>
> [  152.873050]  dump_stack_lvl+0x4b/0x70
> [  152.873056]  __might_resched.cold+0xbf/0xcf
> [  152.873061]  kmem_cache_alloc_noprof+0x1c5/0x2e0
> [  152.873067]  ? getname_kernel+0x29/0x150
> [  152.873073]  getname_kernel+0x29/0x150
> [  152.873077]  kern_path+0x17/0x50
> [  152.873081]  device_list_add.constprop.0+0x1c1/0x670
> [  152.873085]  ? device_list_add.constprop.0+0x193/0x670
> [  152.873089]  ? device_list_add.constprop.0+0x193/0x670
> [  152.873092]  ? btrfs_scan_one_device+0x1bf/0x410
> [  152.873101]  btrfs_scan_one_device+0x239/0x410
> [  152.873112]  btrfs_control_ioctl+0xdb/0x1a0
> [  152.873119]  __x64_sys_ioctl+0x96/0xc0
> [  152.873127]  do_syscall_64+0x54/0x110
> [  152.873132]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  152.873139] RIP: 0033:0x7fa8daf99f9b
> [  152.873143] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f
> 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [  152.873146] RSP: 002b:00007ffd34cd5cf0 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  152.873150] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007fa8daf99f9b
> [  152.873152] RDX: 00007ffd34cd5d70 RSI: 0000000090009427 RDI:
> 0000000000000005
> [  152.873154] RBP: 00007ffd34cd5d70 R08: 0000000000000000 R09:
> 00007ffd34cd6cd0
> [  152.873156] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00005639a2ce2b60
> [  152.873158] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000005
> [  152.873166]  </TASK>
> [  153.117462] BTRFS info (device nvme1n1): first mount of filesystem
> 05148ba4-7ee1-480f-af62-7aa0b80b35f2
> [  153.117475] BTRFS info (device nvme1n1): using crc32c (crc32c-intel)
> checksum algorithm
> [  153.117480] BTRFS info (device nvme1n1): using free-space-tree
> [  153.120689] BTRFS info (device nvme1n1): checking UUID tree
> [  153.632137] BTRFS info (device nvme0n1): last unmount of filesystem
> e9489dbd-0346-4c23-9b8b-9a0221e235f8
> [  153.715256] BTRFS info (device nvme1n1): last unmount of filesystem
> 05148ba4-7ee1-480f-af62-7aa0b80b35f2
> [  153.818188] BTRFS info (device nvme1n1): first mount of filesystem
> 05148ba4-7ee1-480f-af62-7aa0b80b35f2
> [  153.818203] BTRFS info (device nvme1n1): using crc32c (crc32c-intel)
> checksum algorithm
> [  153.818209] BTRFS info (device nvme1n1): using free-space-tree
> [  153.884093] BTRFS info (device nvme1n1): last unmount of filesystem
> 05148ba4-7ee1-480f-af62-7aa0b80b35f2


