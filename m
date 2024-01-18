Return-Path: <linux-btrfs+bounces-1544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D28312F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 08:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64916B21B00
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 07:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC8947F;
	Thu, 18 Jan 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="J4mZEjsR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E78F60;
	Thu, 18 Jan 2024 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561697; cv=none; b=uQkdgo1ewNmelRKM6NiDzTzlN95XPRvWxas8ULFOUPuv3gn2KTZ8qvBR5p6Xb98se9Um7L3DDX3k0uBWEM+gGaLsbLYQVNbrU74g7J3bdfIp6bx0/BNAs1EGgq8A2+ICJdGSBDo9J8/RuPJDNxemJGDoDy3OyuCsG8FS6zK+qrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561697; c=relaxed/simple;
	bh=dALoVQISrgtmxR83PyloY3Qo9jnDMa1Pg3Js0EzNK6A=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=lD7BZv6jPhpBvM06g5W4zXSHzXHP45IdrRdB8tIkMBBOnGS4VVnyCXrQt3yhMUtmw9fcr04Q4ZOQUgxpdUYYWGDyrv5/g7p4YT2v+hvOTqAgqp1S6151ookNTcvhrb1PXDxGnSnUaS+yMGlp3l8qg7v/dpPIY25B5WE7fdaE8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=J4mZEjsR; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705561657; x=1706166457; i=quwenruo.btrfs@gmx.com;
	bh=dALoVQISrgtmxR83PyloY3Qo9jnDMa1Pg3Js0EzNK6A=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=J4mZEjsRhT0WMRB3KYtGXrTiF2ZJ6QrZwQSMVVagPCu0SrW1/zNC3uZSoKPXqyB+
	 XbHV7/jgCFluN7B6GARPIztQRdELIr+2b0P560g0Da60lfOMP46DMvNu3/Jc3seJ8
	 MVtJE5cVTeZ/AeRI22wKS7gpdEtW7olWsg4sObQN3qyiWFGQXUPAfh5kKPFm1DuK9
	 jWpR2PGGDKXZX5OElPu/ihGYrXv+IVVIsfGG9p2qUxC4wlnJ6Wi1JOY0ZW4ormsR5
	 KoPj5Kd0QvUgYylNnTwPDM+w5eYiodc0YDDvxGzlr/Gf67eIuObHYaJqXT6MDS3Yo
	 Z8niJQMMv4WuAcMjKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MStCY-1rYYuV0Mnu-00ULTG; Thu, 18
 Jan 2024 08:07:37 +0100
Message-ID: <2870e41e-c0a8-4ab4-baaa-bbffbcd1e6a4@gmx.com>
Date: Thu, 18 Jan 2024 17:37:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about btrfs no space left error and forced readonly
To: ChenXiaoSong <chenxiaosongemail@foxmail.com>, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: chenxiaosong@kylinos.cn, liuzhengyuan@kylinos.cn, huhai@kylinos.cn,
 liuyun01@kylinos.cn, zhangduo@kylinos.cn, liuzhucai@kylinos.cn,
 zhangshida@kylinos.cn
References: <tencent_0C621A54ED78C4A1ED4ECA25F87A9619CE09@qq.com>
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
In-Reply-To: <tencent_0C621A54ED78C4A1ED4ECA25F87A9619CE09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BvLzrnBsDvnRnExracrmxKqgvYnidagAPEU9aKUSM5bHmAYUVlF
 ETLt9K2oFqAYzSGXjPBa9qkOgvyyN+ZWn7WxFA9V6ERjIPWAoe/0snnyFMvsrwinaXYN8a7
 m/gHu2m8vgtcsYRwQQPuDzX35gOO0uhP/pOwLvVShpgWTFQKE81/Gvklyw/M8P/xLEdv3OW
 JJb1wXyOhwWGbIlTHawvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jI7/YAQJWPs=;foTrbi4V5cHxpGLYiPhJ6egPbfV
 8tcaGH/cwu8PYQbWRimiIMJR57RdmuG04p2Ec05xYcveTHXyuXWelQLp0i/qVTSVkCkvpMRlM
 iBFEsvHC9d4zLGbCL1rJYArgowQ4QxQ5mrid8C6L+ZN9gBEnKFrL9MfHp37qKcbyPGfB5brdE
 miCem8ANyhvOmMH82L1RDD6T1Lkn1zRO5TzjZl069nMw+K1RNAiD+XAK7JqFSEW0nKy0hjE6C
 qOD8kCzP8u0hmOcPo2DMi4TUmO7v/WCGxkk6t07PQDsvMDeGOfa2ubeDJFNS2tMvSYcgcOwY/
 dKTnjuoaV08E5nuWy3aGO3oPuCZnst8//b90yDVm9EsV7vsaqrFxGOemaRYQGfguPcyKL3AwT
 ItCoU2+ytTWwbeXMGkioFmTeyx4SUbu1ahTCo1ZpfEm6pkVB3nqJ3HbWKT+3YaVOefdwZ2ATv
 qwmjf+0DDrDbflpJSZKQY6nTJwnE4qplp2n/090sFJb3Fwyw0k83S0LTmXGsBBwwr6ficXtIT
 aECjFszYEtwSgl27XDi2QhwhYUHoPqlbAJHZc4Kae3vL5lnKP7La72We9rF0ah4iA/fCti1xA
 NEtM04ipylcIf6ClZuJDETojZr/wFnyV5Cp8SeD9EFY4kO/40jux0kv4qM6imo4XpYBMr/dPX
 sS0mhn1okSuT7fAgrz9IeVppwhtjXc4rgyGmD1CX8ilVQjVpZqIjBItBKY0/VXhVYLPAVwWkL
 DZjrASeP26GZgDsIqYsV8PpqUdzRTHO3bMqTE1LD+elobuNZB7j37qxOlSq8DV0v2OLmE+h1Z
 OfGJxJgm4fZTE5iHv7Y84ZZvPZOYtqdNa9GxLLDGhNItnxbCwodkbs3Whua4qb33zAHmWx3VH
 CmcpAj+oPkszsHGf21jlHVleSUlhPlwjMpoeLg9P9jt6NFZ7GHVaVVjaKgedPsojCj/4zVZMF
 WbVM5FbxHyCEaKP8IfxuwUaXL4I=



On 2024/1/17 18:17, ChenXiaoSong wrote:
> Greetings,
>
> We had a btrfs no space left error and forced readonly, the stack trace
> is [1]. This happened on our kernel release version based on lts 4.19.
>
> Is there already a fix patch for this issue?
>
> Or can anybody please advise on how to debug this further?

Full dmesg please (if there is any one before the call trace).

And `btrfs fi usage`, `btrfs fi df` output, along with `btrfs check
=2D-readonly` if possible.

Thanks,
Qu
>
> Thanks,
> ChenXiaoSong.
>
> [1]
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328533] ---------=
---[
> cut here ]------------
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328594] WARNING: =
CPU:
> 42 PID: 460094 at fs/btrfs/extent-tree.c:6805
> __btrfs_free_extent.isra.71+0x65c/0xbd0 [btrfs]
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328595] Modules l=
inked
> in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace
> fscache fuse xt_nat veth nf_conntrack_netlink xt_conntrack br_netfilter
> bridge sch_htb xt_addrtype xt_set ipt_MASQUERADE xt_mark
> ip_set_hash_ipportnet ip_set_bitmap_port ip_set_hash_ipportip
> ip_set_hash_ipport dummy xt_comment iptable_nat nf_nat_ipv4 nf_nat
> iptable_filter nls_utf8 isofs bonding 8021q garp mrp stp llc ip_set
> nfnetlink ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 sunrpc amd64_edac_mod edac_mce_amd btrfs xor
> zstd_decompress zstd_compress raid6_pq libcrc32c kvm_amd ccp kvm
> irqbypass ipmi_ssif ast ttm drm_kms_helper syscopyarea sysfillrect igb
> sysimgblt i2c_algo_bit fb_sys_fops pcspkr txgbe sg dca drm i2c_piix4
> k10temp ipmi_si ipmi_devintf ipmi_msghandler binfmt_misc
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328634]=C2=A0 ip_=
tables
> ext4 mbcache jbd2 sd_mod crc32c_intel ahci libahci megaraid_sas libata
> dm_mirror dm_region_hash dm_log dm_mod
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328647] CPU: 42 P=
ID:
> 460094 Comm: httpWorkerThrea Kdump: loaded Tainted: G=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 W
> 4.19.90-17.ky10.x86_64 #1
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328648] Hardware =
name:
> Sugon H620-G30/65N32-US, BIOS 0SSSX245 06/07/2020
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328656] RIP:
> 0010:__btrfs_free_extent.isra.71+0x65c/0xbd0 [btrfs]
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328659] Code: 44 =
89 e9
> ba c8 1a 00 00 48 c7 c6 a0 aa 06 c1 e8 fc ba 09 00 e9 fe fa ff ff 0f 0b
> 44 89 ee 48 c7 c7 68 7c 07 c1 e8 14 e9 2d e5 <0f> 0b e9 ce fa ff ff 41
> 83 f8 29 0f 86 d6 01 00 00 48 8b 7c 24 08
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328660] RSP:
> 0018:ffffae7f9f6e78c8 EFLAGS: 00010286
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328661] RAX:
> 0000000000000000 RBX: 000000000000a0c9 RCX: 0000000000000006
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328662] RDX:
> 0000000000000007 RSI: 0000000000000092 RDI: ffff90a4ffa96850
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328663] RBP:
> 00000470931db000 R08: 000000000210773e R09: 0000000000000004
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328664] R10:
> 00000000ffffffe4 R11: 0000000000000001 R12: ffff909b302e2a80
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328664] R13:
> 00000000ffffffe4 R14: 0000000000000000 R15: 000000000003fc62
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328666] FS:
> 00007f4aedae2700(0000) GS:ffff90a4ffa80000(0000) knlGS:0000000000000000
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328667] CS:=C2=A0=
 0010 DS:
> 0000 ES: 0000 CR0: 0000000080050033
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328667] CR2:
> 00007efce4073ff0 CR3: 0000006413d3c000 CR4: 00000000003406e0
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328668] Call Trac=
e:
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328682]
> __btrfs_run_delayed_refs+0x4f8/0x1150 [btrfs]
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328707]
> btrfs_run_delayed_refs+0xe7/0x1b0 [btrfs]
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328717]
> btrfs_truncate_inode_items+0xa56/0xeb0 [btrfs]
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328728]
> btrfs_evict_inode+0x496/0x4f0 [btrfs]
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328733]=C2=A0 evi=
ct+0xd2/0x1a0
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328736]
> __dentry_kill+0xdd/0x180
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328738]
> dentry_kill+0x4d/0x260
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328740]=C2=A0 dpu=
t+0x183/0x200
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328743]
> __fput+0x118/0x1f0
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328747]
> task_work_run+0x8a/0xb0
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328750]
> do_exit+0x2ec/0xbf0
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328753]
> do_group_exit+0x3a/0xa0
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328755]
> get_signal+0x13f/0x7a0
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328758]
> do_signal+0x36/0x610
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328768]
> exit_to_usermode_loop+0x71/0xe0
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328770]
> do_syscall_64+0x1a3/0x1d0
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328773]
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328779] RIP:
> 0033:0x7f4b12fae10c
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328785] Code: Bad=
 RIP
> value.
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328785] RSP:
> 002b:00007f4aedae1550 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328786] RAX:
> fffffffffffffe00 RBX: 00007f4b0d1914e0 RCX: 00007f4b12fae10c
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328787] RDX:
> 0000000000000000 RSI: 0000000000000080 RDI: 00007f4b0d19150c
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328787] RBP:
> 0000000000000000 R08: 0000000000000000 R09: 0000000794039ff8
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328788] R10:
> 0000000000000000 R11: 0000000000000246 R12: 00007f4b0d1914b8
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328789] R13:
> 0000000000008223 R14: 0000000000000000 R15: 00007f4b0d19150c
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328790] ---[ end =
trace
> 74a7f2461a0f9473 ]---
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328961] BTRFS: er=
ror
> (device dm-9) in __btrfs_free_extent:6805: errno=3D-28 No space left
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.439057] BTRFS inf=
o
> (device dm-9): forced readonly
> Dec=C2=A0 8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.439067] BTRFS: er=
ror
> (device dm-9) in btrfs_run_delayed_refs:2935: errno=3D-28 No space left
>
>

