Return-Path: <linux-btrfs+bounces-1957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A812E8439C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 09:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E393283E64
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7067750;
	Wed, 31 Jan 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hopUMv0f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877769952
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690632; cv=none; b=c+lbDskCYp62ZUTjS+yKx6gOGR++LXBumskEiG8VeBMPhlmQ4t2+9CF1vp+TADw8xFQ45IixhJ+hgyLAsPu0bpcaLcsoUBZJiQSzlqNCMCP5AOhEhhqaHM5KwpQHIcGVT7siBbTabpr9yjdvVwwiinhQVO7YIevvnAp13JylGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690632; c=relaxed/simple;
	bh=rnjJTppalm/AXiahPbaaOQnSoI8EEPRaJwoNxLTMIHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgDQVKiYFQAVXwKyWrmgxh7ITsicdMAJtw5BGK4jhkdYz8/J5ryVVTC/z3PO07QSWoY+Uh10dPxPKwQGh9pWxe39XLLdw1fGqzLZ2EL7MQV3Ky5IekrN5rD90wX/xIRpnPaeQw3RfHK1BB7E2PdYM0WEGBLc4DazNRIYalhHrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hopUMv0f; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706690626; x=1707295426; i=quwenruo.btrfs@gmx.com;
	bh=rnjJTppalm/AXiahPbaaOQnSoI8EEPRaJwoNxLTMIHE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=hopUMv0fNzytYYKLJHhK4HBWIFZLhaOcMW0DZfyD2rOFx89aNJRaR/M3Evub8D2/
	 yE9XG9E1yFUdmWvoGHmTW6Bj5he79K3Ggf/GqWzPzj16ZZhLdcabhp45vICVQ4wi9
	 R2AHbFOgFfWpgq5IUBQ1pM1LLAxMBTEHvk4E0K5bhFxjvv8L78oie0ArNhwifs+aQ
	 g1B/F8cuiPpvo1Zv404Qu35liqfvETCamCjQNp+8aUF2PNK1ogI+DNvZsQbvA7XUG
	 tz1WBenvhGpQr+eDvbUqjpf5a7kLamRceIgyyLVZD91MheMhLcI2i/xSZxJpUrOhi
	 sE7S5iBibjXaLCSCFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtfJd-1rCKYn0ZgN-00v92W; Wed, 31
 Jan 2024 09:43:46 +0100
Message-ID: <0da45be9-f26b-4cca-9f55-6d1230938e51@gmx.com>
Date: Wed, 31 Jan 2024 19:13:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Content-Language: en-US
To: dsterba@suse.cz, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1706553080.git.dsterba@suse.com>
 <edd12dabd0ce57ba84a4c2b82c51becd64fd7a6f.1706553080.git.dsterba@suse.com>
 <20240131072308.GJ31555@twin.jikos.cz>
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
In-Reply-To: <20240131072308.GJ31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v83SLxnLBIXvTXTz6OBqLi7ZhTtvJCGR8uF4z4YyiWb6XgglZQP
 5SAwzr9AYGEF7UHgKuCW9z/PLthqGJ/i9GN24aD8DZ/qZ9o6ljtF/ADFKuow0dVKKl05MTt
 z4KKsLormfJXuLXFn7yZhtB0dmidZ1/RW1QlWdP/RcSLFKKrNKYgVrCQ/X45WwM829/o1we
 ZQj/ANHYhBPpo3sZ9bkcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xx/1UfhbZ8w=;d2hC2ANscDlCWf558nl9aKK3mWr
 vIfBClj2qGJjJSoZ3tXfpglr7feoGG6LuR4MqckCTGVye+sqCJaWUvigDVdvdq+tHkDhHgXtz
 EnRiSgnAop1syyo3xbLnMflWBIT5SvbQ+YbJ1X4JBX4MKRXLOldABu8PGSaaCtanFqMc82mtw
 pNZ7iLsjbN/q9E9dOiw2Lqo157b0rdX7A4tu0/jWlTR1UQelllTcJfF4TZpr1wqPl1xSBQxRW
 D5bNq+U8gNWLbA8KN4AjstpC8UnB9nwaNCvHzhh8OOZdfNEftu7+doR6hM27+n8FMPFxKb149
 tXq4B63QNpeIn+DX8FSX/x8yS/D3VoV0lfMHxTn1Xp7w/x9404LUF4P3Q0tic/Se8coxmnVjt
 qi2qK2SMlBTyFy7f3jgMiUkbYceQc4Igw+KG5r7KmbbNW3etiL8JrmiGR4JhOaK3rC+Hp2Uzw
 hx2AmTW450veh+rcsTRIaCeRKS18yPenZY1OpT91TqghL4v9Te5QpCGzgxd7tjSQS9vAu9gu3
 sS58meWfaYZUC1SKtxzqGYrvnzPg+pFr9DTrrl+Oyuc3O+Bl0vR8tTe2Hw0ggMue8WMyuWamh
 sVY1pjxPPusHk4tNmTOnARkP/M7rpv3HT59XbwZaqmxxwlOALTwYKxNqSbHF2FhWMXUjS3q1D
 cCvephSa5NBVkyV72A9CgIqli/s9XyiODkvFj9S1bbW/Pf6SNEs/pcHWA8kK4okMe/rhmG0dn
 VTGKJP/7HShVB9d8RFHcAYP4k7vk1Qypnhoj9O7M1nXyBLQPBw5dOfpYlHRqMoKghyrSItXXl
 ccD1dPROk+YifgQVZyBx9o7kKC5AESlbV26OH4QatcPV4uDlINlZi4AhRZJZhp9iB6GRlqZxT
 Am9et5eaGjTz6mlDii/qbyQTQQ4yx8EPyvou3uAZREDhnPyGupQbIP7GJvLjqP8Ru2078spc/
 xh9jdbTNz/Smo1L2cl18yJ8iu9k=



On 2024/1/31 17:53, David Sterba wrote:
> On Mon, Jan 29, 2024 at 07:33:18PM +0100, David Sterba wrote:
>> @@ -5211,7 +5211,7 @@ static struct btrfs_trans_handle *evict_refill_an=
d_join(struct btrfs_root *root,
>>
>>   void btrfs_evict_inode(struct inode *inode)
>>   {
>> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>> +	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>
> This leads to a crash in btrfs/232, happened twice:
>
>    BUG: KASAN: null-ptr-deref in btrfs_evict_inode+0xac/0x6b0 [btrfs]
>    BUG: kernel NULL pointer dereference, address: 0000000000000208
>    Read of size 8 at addr 0000000000000208 by task fsstress/21264
>    #PF: supervisor read access in kernel mode
>
>    CPU: 3 PID: 21264 Comm: fsstress Not tainted 6.8.0-rc2-default+ #2288
>    #PF: error_code(0x0000) - not-present page
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.=
2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>    PGD 683f8067
>    Call Trace:
>    P4D 683f8067
>     <TASK>
>     dump_stack_lvl+0x46/0x70
>     kasan_report+0x123/0x150
>     ? btrfs_evict_inode+0xac/0x6b0 [btrfs]
>     ? btrfs_evict_inode+0xac/0x6b0 [btrfs]
>     btrfs_evict_inode+0xac/0x6b0 [btrfs]
>     ? local_clock_noinstr+0x11/0xc0
>     ? btrfs_rmdir+0x380/0x380 [btrfs]
>     ? reacquire_held_locks+0x280/0x280
>     ? wake_up_var+0x120/0x120
>     evict+0x17f/0x2d0
>
>     btrfs_create_common+0xe4/0x1c0 [btrfs]
>     ? btrfs_tmpfile+0x2b0/0x2b0 [btrfs]
>     ? init_special_inode+0xb9/0xe0
>     vfs_mknod+0x25c/0x320
>     do_mknodat+0x2fd/0x360
>     ? kern_path_create+0x50/0x50
>     ? getname_flags+0xb5/0x220
>     __x64_sys_mknodat+0x5d/0x70
>     do_syscall_64+0x6f/0x140
>     entry_SYSCALL_64_after_hwframe+0x46/0x4e
>
> The new macro does BTRFS_I(inode)->root->fs_info while the old one uses
> fs_info in the super block. From the context I don't see why a root
> pointer would be NULL or how would anyone see that right away and not
> introduce such crashes by using the helpers.
>

The function btrfs_evict_inode() only utilize BTRFS_I(inode)->root when
the inode's i_nlink is not 0, and there are even explicit check on root.

So I guess BTRFS_I(inode)->root can be NULL, and the old code is already
handing it.

If you need, I can definitely dig deeper to give a more comprehensive
call trace and analyze.

But it looks like if you want to grab fs_info, i_sb is way safer.

Thanks,
Qu

