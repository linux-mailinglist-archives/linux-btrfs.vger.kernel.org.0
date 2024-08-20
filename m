Return-Path: <linux-btrfs+bounces-7347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD56959042
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 00:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47501C21C36
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D801C7B65;
	Tue, 20 Aug 2024 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Zd/X86e5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7A1E86E
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191762; cv=none; b=Ykz2S1DCNmE3ztz5et2aWID1cylNZ+AvqcwbOjrwQ2WlLAA1gRLO4BBxzWbqpjTCLArUexbcwWOVqaMFnqtCY0Ftf5+w7DYO6d2gGeZB49UCwwzUrmqMHMok00Vaexah1DwclWZduiSJ1E36boRk4/8kQZONS264rpkildnvy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191762; c=relaxed/simple;
	bh=lZQh9JilL2lJgajjYSjG7l+OLbcOZftaSg5x1rXbLqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F5ttSs02VXCXVpvmxfbNBRuPFgZbzyJphuRX3iMisXJTqdh9AKBV3y6P2bjAZyCBzZTicenkbdvv9FX4KWc8sqnQp69um9d+Tp0mTsJqPHzDJhTdohHw6UCklRzgeG0o+lOz3ujRh/zABlKL9DWGnWNCxRwiUJsfQS6VwZvAKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Zd/X86e5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724191749; x=1724796549; i=quwenruo.btrfs@gmx.com;
	bh=lZQh9JilL2lJgajjYSjG7l+OLbcOZftaSg5x1rXbLqA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zd/X86e5Wj2oyEbJGTDaMBY4irIjAMHKquIry6BQpxNHhakpfENNVW3WimUnwy5S
	 WguQMqNH6UtNsMTUbsbW7vogeeJN/A24RbWdQGozM+ajQm1yxG9+qeYrO0+m+TUYJ
	 gjkq/rmX/X99IRtbeyWSG2VbH01Kqz98TJiD+V19VRCkBYzd4GB9etpHw933EwXp5
	 +HcVoe6Pz7/JJYNUuhqRKl5N/rbohqxdb8Af+IYZoLXjQ92DQL0UydZLqjOhQJ9pv
	 5tvfgGJMeGzmmQl5gfeyWezwVoFyDCFDm8d/xLNCTT0w0FNzhEcO7RmNoDnGTJ+Hx
	 z/YrcA96pzIb/PVdew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1s23Rg3cQe-017pl2; Wed, 21
 Aug 2024 00:09:09 +0200
Message-ID: <6b17f157-49c3-4874-898f-68541b2dce0a@gmx.com>
Date: Wed, 21 Aug 2024 07:39:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: out of space (>865 GB free), filesystem remounts read-only - how
 to recover?
To: Tomasz Chmielewski <mangoo@wpkg.org>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <f11daee5026d303e673d480f3f812b15@wpkg.org>
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
In-Reply-To: <f11daee5026d303e673d480f3f812b15@wpkg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eVyOraEoY7m8zlAWf2B2Zo0w+wWjXKwxq90HfxqBlfbXoIl5BTW
 gAaZuI6RVbsfIeoYaS4TgZaiLZAPOyehvRpDh6Rgbhsq++LVXqOfOSBJ/qY+1LpwVozWizE
 p+EOyAl9UP/uEgfuh/6bAJWKnFOMDJbjB/ld5GlFkVwP+2R0rQwExgYROy9oSGNQdJn+xBy
 G1UqNYGU/Ej2Vsx9flWaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jGLjqdyfoBY=;AwpWMJwpPJd5np8mg1ZwaXIMc4r
 FOto2DjDkhLj8iX3X8Ixtq9bmbpR8MvZUuizj/FOhYXhwWOWrWlBw+2zIidektXdJdqiMFmyN
 EUtrc8h6TnC/YJumV9f5t9ed+qYlTSCzbmUCIFsgBIkIV/8vUfPmOxeC47wySPYlXG2FsDogW
 i79aUnaaZ2OHVkMic675ZrEXyQrQ2ytwJYVqGKK9ugLYH9PhTFtbtIEX71LZKx3gswbIGwN4k
 luFgfXu6VsmuIPkba6jKuUeLLcNNFHcrbRxDLjBCo0v2wGJ+QbOmRT7glly6F883KnLeuqBjS
 zIuezKOOfR/+8pOs9Yv11FnJxNPh9/MTANdmcud2yKErwcTQuB8HkzxdvNZQah/q5kuq9AWvX
 9bnrmel/5IN+cjKtuhYwL8g+PXCB1yQQixd/oyv1gbuqop9SWJ/Hz2b8YkqcYvC1AgQecX2Ab
 FKz3tDZiMcXHUqQJMDS9oCDjj7CpEJ+4B+1pHt3BqFocv42xZ/Oxll7grVAfWL1lDD3MeTFyR
 5g6VAlNWJHNMb9nkqXvWoPBwaw1M/qysKvubY6TgWbTNcxQQaO1BBfOxv0XYimHHLQ2/w7LqL
 iG3ngGotpoyPJM7rgzmdGM6nSi7riWmbv4LoAiJv7+5veAA/Lzg7fLJprtwV1VgIParsAQFPC
 S4VtdT23nZO3Rt48Vjygzz4zQe17zWkYhxMlO+4eKBS61Z5yMrNqVinD+U/rqiHrerZ1hEDH6
 Z0Y9bSHJMO70mfTPY+6SVymjtN/rRF4wPnqcOtJhSRGmrfom8H04IDgGjvQvCcLRKm/SEvrye
 qDKCOZAeA5/t9AyUUqrHeJ+w==



=E5=9C=A8 2024/8/20 23:07, Tomasz Chmielewski =E5=86=99=E9=81=93:
> My 44 TB filesystem was getting full (~865 GB free out of 44 TB in
> total), so I thought removing some old data would be a good thing to do.

btrfs fi usage output please.

I bet it's some btrfs RAID setup, maybe RAID1/10 or RAID1C3/C4 for metadat=
a.
And the disk usages got unbalanced, the metadata overcommitment did a
wrong estimation and cause the ENOSPC.

Thanks,
Qu
>
> Unfortunately now I'm not able to recover - the filesystem remounts
> read-only (no free space in metadata) a few minutes after mounting.
>
> - kernel is 6.10.6
>
> - the filesystem was writable and did not have any problems
>
> - I've decided to delete some subvolumes with "btrfs sub del ..."
>
> - a couple of minutes later after deleting the subvolumes, the
> filesystem went read only
>
> - when I unmount and mount again - it resumes deleting the subvolumes in
> the background, free space goes up from 865G to 870G and filesystem
> remounts read-only
>
> - after unmounting/mounting again, it again has 865GB free
>
> - even if I remove some files right after mounting, as soon as the
> filesystem goes read-only - I unmount/mount again - removed files
> magically appear again
>
> - I've added a 100 GB device to the filesystem - but it doesn't help,
> the filesystem still goes read only shortly after mounting
>
> - tried running data and metadata balance - but the filesystem still
> goes read only shortly after mounting
>
> How can I recover from that?
>
> 1) dmesg after mounting with "skip_balance" option:
>
> [26883.769459] BTRFS info (device sdc1 state EA): last unmount of
> filesystem a80ce575-8c39-4065-80ce-2ca015fa1d51
> [26890.241370] BTRFS info (device sdc1): first mount of filesystem
> a80ce575-8c39-4065-80ce-2ca015fa1d51
> [26890.241402] BTRFS info (device sdc1): using crc32c (crc32c-intel)
> checksum algorithm
> [26890.241414] BTRFS info (device sdc1): using free-space-tree
> [27025.188366] BTRFS info (device sdc1): balance: resume skipped
>
>
> 2) dmesg after it goes read-only:
>
> [27493.879003] ------------[ cut here ]------------
> [27493.879014] BTRFS: Transaction aborted (error -28)
> [27493.887226] BTRFS: error (device sdc1 state A) in
> do_free_extent_accounting:2968: errno=3D-28 No space left
> [27493.936410] WARNING: CPU: 7 PID: 2990 at fs/btrfs/extent-tree.c:2968
> do_free_extent_accounting.cold+0xec/0x1f0 [btrfs]
> [27494.050834] BTRFS info (device sdc1 state EA): forced readonly
> [27494.050841] BTRFS error (device sdc1 state EA): failed to run delayed
> ref for logical 7329684533248 num_bytes 53248 type 184 action 2 ref_mod
> 1: -28
> [27494.051372] Modules linked in: tls
> [27494.052220] BTRFS: error (device sdc1 state EA) in
> btrfs_run_delayed_refs:2207: errno=3D-28 No space left
> [27494.211400]=C2=A0 isofs binfmt_misc ip6t_REJECT nf_reject_ipv6
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nf_tables nfnetlink
> nls_iso8859_1 intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel ipmi_ssif kvm rapl intel_cstate
> cmdlinepart spi_nor input_leds mei_me joydev intel_pch_thermal mtd mei
> ioatdma acpi_ipmi mac_hid ipmi_si ipmi_devintf ipmi_msghandler acpi_pad
> sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr
> efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c raid0 raid1 hid_generic usbhid hid crct10dif_pclmul
> crc32_pclmul polyval_clmulni spi_intel_platform polyval_generic ixgbe
> ghash_clmulni_intel spi_intel ahci gpio_ich igb i2c_i801 xfrm_algo
> sha256_ssse3 mxm_wmi i2c_mux libahci lpc_ich sha1_ssse3 i2c_smbus
> i2c_algo_bit xhci_pci
> [27494.325621]=C2=A0 dca xhci_pci_renesas mdio wmi aesni_intel crypto_si=
md
> cryptd
> [27494.325631] CPU: 7 PID: 2990 Comm: btrfs-transacti Tainted: G
> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.10.6-061006-ge=
neric #202408190440
> [27494.325635] Hardware name: Supermicro Super Server/X10SDV-TLN4F, BIOS
> 2.1.v1 06/05/2020
> [27494.325637] RIP: 0010:do_free_extent_accounting.cold+0xec/0x1f0 [btrf=
s]
> [27494.325721] Code: 83 e0 01 e8 ec 52 00 00 e9 d0 5f f1 ff 89 df e8 e0
> ee ff ff 84 c0 0f 84 e8 00 00 00 89 de 48 c7 c7 d0 4f a4 c0 e8 4a c4 b7
> fb <0f> 0b eb bc 45 31 c0 41 83 e0 01 89 d9 ba b1 0b 00 00 4c 89 e7 48
> [27494.325724] RSP: 0018:ffff956e01fbbb50 EFLAGS: 00010246
> [27494.325727] RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX:
> 0000000000000000
> [27494.325729] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [27494.325731] RBP: ffff956e01fbbb80 R08: 0000000000000000 R09:
> 0000000000000000
> [27494.325733] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff8a4135049f18
> [27494.325735] R13: 000006aa92150000 R14: 0000000000010000 R15:
> ffff956e01fbbc08
> [27494.325738] FS:=C2=A0 0000000000000000(0000) GS:ffff8a479f980000(0000=
)
> knlGS:0000000000000000
> [27494.325740] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [27494.325742] CR2: 0000713914aeef04 CR3: 000000016223c002 CR4:
> 00000000003706f0
> [27494.325745] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [27494.325747] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [27494.325749] Call Trace:
> [27494.325751]=C2=A0 <TASK>
> [27494.325754]=C2=A0 ? show_trace_log_lvl+0x1be/0x310
> [27494.325761]=C2=A0 ? show_trace_log_lvl+0x1be/0x310
> [27494.325766]=C2=A0 ? __btrfs_free_extent.isra.0+0x62a/0x900 [btrfs]
> [27494.325838]=C2=A0 ? show_regs.part.0+0x22/0x30
> [27494.325842]=C2=A0 ? show_regs.cold+0x8/0x10
> [27494.325845]=C2=A0 ? do_free_extent_accounting.cold+0xec/0x1f0 [btrfs]
> [27494.325928]=C2=A0 ? __warn.cold+0xa7/0x101
> [27494.325934]=C2=A0 ? do_free_extent_accounting.cold+0xec/0x1f0 [btrfs]
> [27494.326010]=C2=A0 ? report_bug+0x114/0x160
> [27494.326015]=C2=A0 ? irq_work_queue+0x2d/0x70
> [27494.326021]=C2=A0 ? handle_bug+0x51/0xa0
> [27494.326025]=C2=A0 ? exc_invalid_op+0x18/0x80
> [27494.326028]=C2=A0 ? asm_exc_invalid_op+0x1b/0x20
> [27494.326034]=C2=A0 ? do_free_extent_accounting.cold+0xec/0x1f0 [btrfs]
> [27494.326109]=C2=A0 __btrfs_free_extent.isra.0+0x62a/0x900 [btrfs]
> [27494.326181]=C2=A0 run_delayed_data_ref+0x6c/0x1d0 [btrfs]
> [27494.326247]=C2=A0 btrfs_run_delayed_refs_for_head+0x30a/0x420 [btrfs]
> [27494.326312]=C2=A0 __btrfs_run_delayed_refs+0x106/0x1b0 [btrfs]
> [27494.326375]=C2=A0 btrfs_run_delayed_refs+0x3c/0xd0 [btrfs]
> [27494.326437]=C2=A0 btrfs_commit_transaction+0x6a/0xc70 [btrfs]
> [27494.326513]=C2=A0 transaction_kthread+0x167/0x1d0 [btrfs]
> [27494.326584]=C2=A0 ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [27494.326653]=C2=A0 kthread+0xe4/0x110
> [27494.326657]=C2=A0 ? __pfx_kthread+0x10/0x10
> [27494.326660]=C2=A0 ret_from_fork+0x47/0x70
> [27494.326665]=C2=A0 ? __pfx_kthread+0x10/0x10
> [27494.326667]=C2=A0 ret_from_fork_asm+0x1a/0x30
> [27494.326673]=C2=A0 </TASK>
> [27494.326674] ---[ end trace 0000000000000000 ]---
> [27494.326678] BTRFS info (device sdc1 state EA): dumping space info:
> [27494.326681] BTRFS info (device sdc1 state EA): space_info DATA has
> 928231587840 free, is not full
> [27494.326684] BTRFS info (device sdc1 state EA): space_info
> total=3D35882286448640, used=3D34948418105344, pinned=3D5635772416,
> reserved=3D0, may_use=3D0, readonly=3D983040 zone_unusable=3D0
> [27494.326688] BTRFS info (device sdc1 state EA): space_info METADATA
> has -6576521216 free, is full
> [27494.326691] BTRFS info (device sdc1 state EA): space_info
> total=3D78383153152, used=3D77616775168, pinned=3D71188480,
> reserved=3D695123968, may_use=3D6576521216, readonly=3D65536 zone_unusab=
le=3D0
> [27494.326695] BTRFS info (device sdc1 state EA): space_info SYSTEM has
> 5980160 free, is not full
> [27494.326698] BTRFS info (device sdc1 state EA): space_info
> total=3D8388608, used=3D2408448, pinned=3D0, reserved=3D0, may_use=3D0, =
readonly=3D0
> zone_unusable=3D0
> [27494.326701] BTRFS info (device sdc1 state EA): global_block_rsv: size
> 536870912 reserved 536805376
> [27494.326703] BTRFS info (device sdc1 state EA): trans_block_rsv: size
> 0 reserved 0
> [27494.326706] BTRFS info (device sdc1 state EA): chunk_block_rsv: size
> 0 reserved 0
> [27494.326708] BTRFS info (device sdc1 state EA): delayed_block_rsv:
> size 0 reserved 0
> [27494.326710] BTRFS info (device sdc1 state EA): delayed_refs_rsv: size
> 1727549669376 reserved 6039715840
> [27494.326713] BTRFS: error (device sdc1 state EA) in
> do_free_extent_accounting:2968: errno=3D-28 No space left
> [27494.443071] BTRFS error (device sdc1 state EA): failed to run delayed
> ref for logical 7329665056768 num_bytes 65536 type 184 action 2 ref_mod
> 1: -28
> [27494.603135] BTRFS: error (device sdc1 state EA) in
> btrfs_run_delayed_refs:2207: errno=3D-28 No space left
>
>
>
>
> Tomasz Chmielewski
>

