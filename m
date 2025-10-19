Return-Path: <linux-btrfs+bounces-18019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45718BEEE46
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 00:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 201934E2A75
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 22:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0125A359;
	Sun, 19 Oct 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kKbsrrM6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDB1F5437
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760914144; cv=none; b=aeLZDquy2vGQS9S8GSeGF7sJLU1epD4dAt2aJLJzHEzkFBN8qod5BpqeA9oYbUT2RauszB1mL3KwPJbItEG+c6JLjVWj3Dy93fN+wBQePDevagP4Euhzw3Zpn6cZcjXRcJg0aTStfdkhxkzmDUFPMcvJiCuwzPEO/sv7zS4X98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760914144; c=relaxed/simple;
	bh=ZaZt9xtafq3mMoWRVPoIiPSW7NhPoCU/A8KM+qulFxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z8nNeF25VKQiKE6WavCMwHCcYJARah6UWdKgcLeJAUuA15I9hTDx+r4qcbHE76q1dCfEXyukDguOwFLnYpV6hFcKcOLMIpIPGysLcoT5G/uZK0rdD0elOb/gMIAblqIKMCC02Wlqwe6Br/NlSIM+v9P61KGfrhuiYLhhs7G910s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kKbsrrM6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760914136; x=1761518936; i=quwenruo.btrfs@gmx.com;
	bh=ZaZt9xtafq3mMoWRVPoIiPSW7NhPoCU/A8KM+qulFxs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kKbsrrM6HQcUCo/fbdZDRx4I55V37Mzo92GaTaX9zmMZKLEW2AIpDupXGtZBEsMh
	 yqM71cmaJvXqItrbitka3U3U4NHZgRkockbuN4cl/7WKYKdZzLTXJ2k/jWAO5VnsQ
	 IBlPS50IyZWq/ZXCDWr09GtBVLyOf7YVVu5HYP5imTQZby53ppk2sc6lPn4EyHMEL
	 lTYNHfQ7AwXJ2Lson/1X/yowxLSqMR8Reh+pXNqTFxkziYTGyrHImytXrJ5xRUuvU
	 QkqcVejjh+/kV6rI1vbHCfxVwncay4c775kw6nf/ukYKJo92C9QOxcFQCtpwPsLL9
	 Qh5V0hozY9IdxNruWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVDM-1uv8ee0HSy-00WxOe; Mon, 20
 Oct 2025 00:48:56 +0200
Message-ID: <d715c901-d6b0-4edf-bc72-e0770d6ddce0@gmx.com>
Date: Mon, 20 Oct 2025 09:18:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem lockup during backup
To: =?UTF-8?Q?Torbj=C3=B6rn_Jansson?= <torbjorn@jansson.tech>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <4e2d3143-5383-491d-86c2-6b3eb7e21c3e@jansson.tech>
 <974df153-cbdf-443a-aa3b-0a30c121928d@suse.com>
 <a13db09c-a6c8-4029-a5b6-1ba0aee728e2@jansson.tech>
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
In-Reply-To: <a13db09c-a6c8-4029-a5b6-1ba0aee728e2@jansson.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RD4hhop51l36K1mEsiQopRGZT1S7Usd0HtMDgyt72DQRfq63Br0
 njLtqALYM1Vp6NssbcfOVFPm3m+ITNnr13NRWSzIunAGNXCaBiM0pb/vULjWJqgMnexsuqX
 Jt0Gez1MSpbyYhfAzhlrx2SPexhHWJlza9XrYI44dC0wPR0Dzo2Vqd2ZqQQT1MKQO/Mv5JQ
 XmYfRM2k8+r5QG5NfJSyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hkyY/MhlkG0=;rpGwv17lnNfDM/13qsBFVYHVNz0
 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
 cNMZKks31nwUHKj8/aMss8fX71OA+sWzTDc=



=E5=9C=A8 2025/10/20 08:25, Torbj=C3=B6rn Jansson =E5=86=99=E9=81=93:
> On 2025-10-19 22:42, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/10/19 20:43, Torbj=C3=B6rn Jansson =E5=86=99=E9=81=93:
>>> Hello.
>>>
>>> i have a btrfs filesystem on two 18tb disks that i use as backup=20
>>> destination for my proxmox cluster.
>>> the filesystem is using btrfs raid1 mirroring and is exported over=20
>>> nfs to the other nodes.
>>>
>>> because this is used primarily for backups there are periods of heavy=
=20
>>> writes (several backups running at the same time) and when this=20
>>> happens it is very likely the filesystem and nfsd locks up completely.
>>> this then starts a chain reaction due to the default hard mount=20
>>> blocking processes then eventually ceph also becomes unhappy and then=
=20
>>> the vms goes down.
>>>
>>> below is the hung task output from dmesg on the computer with the disk=
s.
>>>
>>> any idea whats going on and what i can do about it?
>>>
>>>
>>>
>>> [1560204.654347] INFO: task nfsd:5136 blocked for more than 122 second=
s.
>>> [1560204.654351]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tainted: P=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.14.11-2-pve #1
>>
>> v6.14 is EOL, you're completely on the vendor to provide any fix/=20
>> backport.
>>
>> Recommended to go either LTS kernels or latest upstream one.
>>
>=20
> ok, not sure i can easily fix that.
> i can go back to 6.8 but i think thats not an lts release.
> i believe proxmox just released a 6.17 kernel but thats still in the=20
> test repo and if i enable that i might accidentally end up with test=20
> versions of other packages and i dont want that.

In that case, I'm afraid you have to ask PVE for support.

Neither 6.8 bir 6.14 are supported upstream, thus there must be some PVE=
=20
specific backports there.

Or you may want to explore how to install upstream kernels on your distro.
>=20
>=20
>>> [1560204.654353] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
>>> disables this message.
>>> [1560204.654355] task:nfsd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 state:D stack:0=C2=A0=C2=A0=C2=A0=C2=A0 pid:5136=
=20
>>> tgid:5136=C2=A0 ppid:2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task_flags:0x2000=
40 flags:0x00004000
>>
>> The only message? No more other tasks?
>>
>=20
> the same (or very similar) message is repeated 10 times, all related to=
=20
> nfsd and then it stops with:
> "Future hung task reports are suppressed, see sysctl=20
> kernel.hung_task_warnings"
>=20
> if you want i can provide all 10

Please provide full dmesg when reporting kernel related bugs.

It may seem the same to you, but a lot of time important details are=20
hidden inside the full dmesg.

Thanks,
Qu

>=20
>=20
>>> [1560204.654361] Call Trace:
>>> [1560204.654363]=C2=A0 <TASK>
>>> [1560204.654366]=C2=A0 __schedule+0x466/0x1400
>>> [1560204.654376]=C2=A0 schedule+0x29/0x130
>>> [1560204.654381]=C2=A0 io_schedule+0x4c/0x80
>>> [1560204.654387]=C2=A0 folio_wait_bit_common+0x122/0x2e0
>>> [1560204.654393]=C2=A0 ? __pfx_wake_page_function+0x10/0x10
>>> [1560204.654400]=C2=A0 __folio_lock+0x17/0x30
>>
>> This hangs at folio locking, which normally means another process has=
=20
>> locked the data folio, but no more hanging messages to further debug it=
.
>>
>> Thanks,
>> Qu
>>
>>> [1560204.654404]=C2=A0 extent_write_cache_pages+0x36e/0x7f0 [btrfs]
>>> [1560204.654559]=C2=A0 btrfs_writepages+0x75/0x130 [btrfs]
>>> [1560204.654703]=C2=A0 do_writepages+0xde/0x280
>>> [1560204.654710]=C2=A0 ? __pfx_ip_finish_output+0x10/0x10
>>> [1560204.654715]=C2=A0 ? wbc_attach_and_unlock_inode+0xd1/0x130
>>> [1560204.654721]=C2=A0 filemap_fdatawrite_wbc+0x58/0x80
>>> [1560204.654726]=C2=A0 ? __ip_queue_xmit+0x19b/0x4e0
>>> [1560204.654731]=C2=A0 __filemap_fdatawrite_range+0x6d/0xa0
>>> [1560204.654744]=C2=A0 filemap_fdatawrite_range+0x13/0x30
>>> [1560204.654748]=C2=A0 btrfs_fdatawrite_range+0x28/0x70 [btrfs]
>>> [1560204.654889]=C2=A0 start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
>>> [1560204.655029]=C2=A0 btrfs_sync_file+0xa9/0x610 [btrfs]
>>> [1560204.655159]=C2=A0 ? list_lru_del_obj+0xad/0xe0
>>> [1560204.655168]=C2=A0 vfs_fsync_range+0x42/0xa0
>>> [1560204.655174]=C2=A0 nfsd_commit+0x9f/0x180 [nfsd]
>>> [1560204.655275]=C2=A0 nfsd4_commit+0x60/0xa0 [nfsd]
>>> [1560204.655367]=C2=A0 nfsd4_proc_compound+0x3ad/0x760 [nfsd]
>>> [1560204.655427]=C2=A0 nfsd_dispatch+0xce/0x220 [nfsd]
>>> [1560204.655486]=C2=A0 svc_process_common+0x464/0x6f0 [sunrpc]
>>> [1560204.655553]=C2=A0 ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>> [1560204.655611]=C2=A0 svc_process+0x136/0x1f0 [sunrpc]
>>> [1560204.655675]=C2=A0 svc_recv+0x7bb/0x9a0 [sunrpc]
>>> [1560204.655741]=C2=A0 ? __pfx_nfsd+0x10/0x10 [nfsd]
>>> [1560204.655798]=C2=A0 nfsd+0x90/0xf0 [nfsd]
>>> [1560204.655852]=C2=A0 kthread+0xf9/0x230
>>> [1560204.655855]=C2=A0 ? __pfx_kthread+0x10/0x10
>>> [1560204.655858]=C2=A0 ret_from_fork+0x44/0x70
>>> [1560204.655862]=C2=A0 ? __pfx_kthread+0x10/0x10
>>> [1560204.655864]=C2=A0 ret_from_fork_asm+0x1a/0x30
>>> [1560204.655871]=C2=A0 </TASK>
>>>
>=20
>=20
>=20


