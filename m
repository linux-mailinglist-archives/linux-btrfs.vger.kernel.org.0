Return-Path: <linux-btrfs+bounces-1508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036608300CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 08:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D30B1F24FD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 07:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C54C8CE;
	Wed, 17 Jan 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Y4E0/MfR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C1BE6B;
	Wed, 17 Jan 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478033; cv=none; b=uUuFWaqLFCj+ocjyVV5h9jWZ4AMugvP5A6nWS/m0KXzzo3BXegr42312XdOFuIFMAs6V0c0yrQJ+uU6TOysKGSu7+1SIfkvqg9p5ZfenA2qIaZOvWY9ZvSxbE3LYikoaSSZ1AJXXukDWGe8kYAB5QRsb9LsaEbQaogqYTewGYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478033; c=relaxed/simple;
	bh=nQBIfiMdjuXoRVFhHvhcr0wzkugaOIbQV7K82qxMKUQ=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-OQ-MSGID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding; b=Qfu+6gzZkh585qyExRlP4AWhL0eF3tQ2TWBM2wjdb3gbhkkT0gPQhe3CD+O+H3pVNBPvK4O1NTTKc0+suapWOHAlNbWjfNb+eHNrPB5k+v0V9+9S7+XhEXVybq+HgH/8IJxlECKMM7qgv7MsLuIVK4FUinbD433tumyg71eopTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Y4E0/MfR; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1705478028;
	bh=H88yXa+7QlAq2GcfOoSWuyw4EXHKRyO0Rb0v/DyhfrM=;
	h=Date:To:Cc:From:Subject;
	b=Y4E0/MfR/sgsy8/ydlsu67vwBZLVIbJsDpwqIJiGoAjmbggy268kngECd3Wwclqk1
	 WQ19Hh22mRoWbDXN2W06OpKwoO2JhCLPe6/DD3F67axDcViHmggvMgqZh9cFZF5/TP
	 UXkUtAEM0h9TMu1AeUvk7269UGMzAIy8kuVOaQN8=
Received: from [192.168.3.231] ([116.128.244.171])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id BE82DAF9; Wed, 17 Jan 2024 15:47:40 +0800
X-QQ-mid: xmsmtpt1705477660tlh8pq5do
Message-ID: <tencent_0C621A54ED78C4A1ED4ECA25F87A9619CE09@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDVyWBygWfLrWKTpzeb6UejZtAoI3WoEBPougL/n1DQA5eQtbXaof
	 QdIu7RaIESJhN17S3AjdqcJN9fAsz8iRoX+Vzd3GgrWGWBf+VPdPP2c+Ds4sUMJklxVGjWlAWs7y
	 KeRn+vYBa44I0aonijPPSl+xORRM8CMGcQCh6vqZHLvuF/58PZgQ/XFrgJp52tR5QB5ExxtIZy5B
	 364kcVq3i3bYze5an/bBkLsG4ZOratEO6i/HL1V50nUKI3Ob32iP0U0bAUqak6QLWyCHImn0z3fE
	 TpXmbbHzI7XPD0kkSvgUPI+FFLKaPd0Ijg3KYPU/hBOnqzlL5Bbtpjdq98V1uBpd0Np9S37kYCdi
	 QNn9GmtaEW9XZfDS2pnwkI91K4sm+KQz9Rdjc4dI2vnFMAWBV06KclwyWmGccNL2q2vaHL2KakXx
	 JuZuBAGJT22DIo21y/RcHKKu+BlQNWHfrj7BmL0rYrzgtMnST9rx/deXQCYMd9Hj2KKeFojjp8kl
	 mNsLZ4V1+08Eb3cyKqzvXPAl253wpY4x2yq8OJ0CuhTPuyIZhPa/1MUKBVBdpMjI2+u/bA6nphJ2
	 BJ73clzFaubdeNLYD9NPvpVBioNXw+9/Amm743b4Qpw4GCxfqrUg9e5OVxpNRcUzEaLX4uT6Km2x
	 5clNMrZDMwZQc4qwMmkuRuqQDE6wVVOIpY/WdlAEF2LlIzZkZqK8Pcg0/2QP2fPB7kJZrEvmvzOe
	 IBWDmcEnhnQLiCImEE2tLstGi/eWOD9t/gUMhwMcmemtQZzC6RfBC8Z+uO9a3tjebWW9DZSkz8qt
	 T7EiTLgdAGHgT/BFLE/fBtQsaUrvx6tz5fnadmED2mZUA869zoiyMNvR5LjXJvJW1zxIIc4m9JWT
	 Gs+75/oDvqP3MH/eI3GOjsd0o7mMli1MqkrUSgKRCoG7gu8/jG7LuRl6/28yp0O9pr2yaZf9E6Id
	 K00SYR4kqgVfcaS1sadkj/613oaJh0+s9fADLb7BN9kGFWx01Y7erEAsNm1OmtAWCfvWcSFpbFv8
	 CoOH0aTDadjVLcmKTC3EBnhHkeBoc=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <5ad68cf2-0067-4b4e-bb05-b8098d918f56@foxmail.com>
Date: Wed, 17 Jan 2024 15:47:40 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 quwenruo.btrfs@gmx.com
Cc: chenxiaosong@kylinos.cn, liuzhengyuan@kylinos.cn, huhai@kylinos.cn,
 liuyun01@kylinos.cn, zhangduo@kylinos.cn, liuzhucai@kylinos.cn,
 zhangshida@kylinos.cn
From: ChenXiaoSong <chenxiaosongemail@foxmail.com>
Subject: Question about btrfs no space left error and forced readonly
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,

We had a btrfs no space left error and forced readonly, the stack trace 
is [1]. This happened on our kernel release version based on lts 4.19.

Is there already a fix patch for this issue?

Or can anybody please advise on how to debug this further?

Thanks,
ChenXiaoSong.

[1]
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328533] ------------[ 
cut here ]------------
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328594] WARNING: CPU: 
42 PID: 460094 at fs/btrfs/extent-tree.c:6805 
__btrfs_free_extent.isra.71+0x65c/0xbd0 [btrfs]
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328595] Modules linked 
in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace 
fscache fuse xt_nat veth nf_conntrack_netlink xt_conntrack br_netfilter 
bridge sch_htb xt_addrtype xt_set ipt_MASQUERADE xt_mark 
ip_set_hash_ipportnet ip_set_bitmap_port ip_set_hash_ipportip 
ip_set_hash_ipport dummy xt_comment iptable_nat nf_nat_ipv4 nf_nat 
iptable_filter nls_utf8 isofs bonding 8021q garp mrp stp llc ip_set 
nfnetlink ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 sunrpc amd64_edac_mod edac_mce_amd btrfs xor 
zstd_decompress zstd_compress raid6_pq libcrc32c kvm_amd ccp kvm 
irqbypass ipmi_ssif ast ttm drm_kms_helper syscopyarea sysfillrect igb 
sysimgblt i2c_algo_bit fb_sys_fops pcspkr txgbe sg dca drm i2c_piix4 
k10temp ipmi_si ipmi_devintf ipmi_msghandler binfmt_misc
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328634]  ip_tables 
ext4 mbcache jbd2 sd_mod crc32c_intel ahci libahci megaraid_sas libata 
dm_mirror dm_region_hash dm_log dm_mod
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328647] CPU: 42 PID: 
460094 Comm: httpWorkerThrea Kdump: loaded Tainted: G        W 
4.19.90-17.ky10.x86_64 #1
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328648] Hardware name: 
Sugon H620-G30/65N32-US, BIOS 0SSSX245 06/07/2020
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328656] RIP: 
0010:__btrfs_free_extent.isra.71+0x65c/0xbd0 [btrfs]
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328659] Code: 44 89 e9 
ba c8 1a 00 00 48 c7 c6 a0 aa 06 c1 e8 fc ba 09 00 e9 fe fa ff ff 0f 0b 
44 89 ee 48 c7 c7 68 7c 07 c1 e8 14 e9 2d e5 <0f> 0b e9 ce fa ff ff 41 
83 f8 29 0f 86 d6 01 00 00 48 8b 7c 24 08
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328660] RSP: 
0018:ffffae7f9f6e78c8 EFLAGS: 00010286
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328661] RAX: 
0000000000000000 RBX: 000000000000a0c9 RCX: 0000000000000006
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328662] RDX: 
0000000000000007 RSI: 0000000000000092 RDI: ffff90a4ffa96850
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328663] RBP: 
00000470931db000 R08: 000000000210773e R09: 0000000000000004
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328664] R10: 
00000000ffffffe4 R11: 0000000000000001 R12: ffff909b302e2a80
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328664] R13: 
00000000ffffffe4 R14: 0000000000000000 R15: 000000000003fc62
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328666] FS: 
00007f4aedae2700(0000) GS:ffff90a4ffa80000(0000) knlGS:0000000000000000
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328667] CS:  0010 DS: 
0000 ES: 0000 CR0: 0000000080050033
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328667] CR2: 
00007efce4073ff0 CR3: 0000006413d3c000 CR4: 00000000003406e0
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328668] Call Trace:
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328682] 
__btrfs_run_delayed_refs+0x4f8/0x1150 [btrfs]
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328707] 
btrfs_run_delayed_refs+0xe7/0x1b0 [btrfs]
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328717] 
btrfs_truncate_inode_items+0xa56/0xeb0 [btrfs]
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328728] 
btrfs_evict_inode+0x496/0x4f0 [btrfs]
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328733]  evict+0xd2/0x1a0
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328736] 
__dentry_kill+0xdd/0x180
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328738] 
dentry_kill+0x4d/0x260
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328740]  dput+0x183/0x200
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328743] __fput+0x118/0x1f0
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328747] 
task_work_run+0x8a/0xb0
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328750] 
do_exit+0x2ec/0xbf0
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328753] 
do_group_exit+0x3a/0xa0
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328755] 
get_signal+0x13f/0x7a0
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328758] 
do_signal+0x36/0x610
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328768] 
exit_to_usermode_loop+0x71/0xe0
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328770] 
do_syscall_64+0x1a3/0x1d0
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328773] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328779] RIP: 
0033:0x7f4b12fae10c
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328785] Code: Bad RIP 
value.
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328785] RSP: 
002b:00007f4aedae1550 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328786] RAX: 
fffffffffffffe00 RBX: 00007f4b0d1914e0 RCX: 00007f4b12fae10c
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328787] RDX: 
0000000000000000 RSI: 0000000000000080 RDI: 00007f4b0d19150c
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328787] RBP: 
0000000000000000 R08: 0000000000000000 R09: 0000000794039ff8
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328788] R10: 
0000000000000000 R11: 0000000000000246 R12: 00007f4b0d1914b8
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328789] R13: 
0000000000008223 R14: 0000000000000000 R15: 00007f4b0d19150c
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328790] ---[ end trace 
74a7f2461a0f9473 ]---
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.328961] BTRFS: error 
(device dm-9) in __btrfs_free_extent:6805: errno=-28 No space left
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.439057] BTRFS info 
(device dm-9): forced readonly
Dec  8 15:25:17 pjdhcpaasnap8pn kernel: [13439425.439067] BTRFS: error 
(device dm-9) in btrfs_run_delayed_refs:2935: errno=-28 No space left


