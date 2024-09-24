Return-Path: <linux-btrfs+bounces-8207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396E984CA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1D01F24984
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392AA13CA8A;
	Tue, 24 Sep 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hU5Sv7+S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F4139D
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212699; cv=none; b=i9iNE5753h6she7hNRX69S6fDvFu+ptsdaTdHpApo3xOjmA1fGiM+4UptnoGyNfyZz4xFa4zUdP+CMnFq2Z1fmJ/YT5kmQmDbqOyNuHA3Ei7YqjBgzmxtZJntlMVnr71hBwGffpMRi5OxFUYw9veh/ONfZcjx9FRYSyke6FnAUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212699; c=relaxed/simple;
	bh=BeC4bDjRsjKvpviO6SjItNZaM7rszmZlfFIRcr4CdvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZagoYdXcmSPRCxqavD4gyRSZbk0Aa9qRgg9cRX4R9yBALFIrWv1KzwHrkLYEQxW0iMHfVK/ucmc2e5Dmcp23J3B58rmYT/JaQf9/XBRqZDffKYBMp+8V8izpOaURQDsKWxDTXhfPGDjrHHrFGxNQ+w0oW1A10gM3+YCTXpWw1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hU5Sv7+S; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727212687; x=1727817487; i=quwenruo.btrfs@gmx.com;
	bh=FUnh1TlE3Ocxe71nkKqoITm/c4P9mGmEld9SIqueDNc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hU5Sv7+SgotL1hWZCOWTZ63Erf9czJRM1BKmFySUCjHx/TfMFtzTkZ6b9zcG1JWE
	 43fsatCfkTA0mg9eRugjdElycIlndNB2T6f6meyO/YZcHSzY0lRr2ijhzNmJrci+x
	 DTNTutK9pYSUHmH+0X0QlJpLNlwUBoWaIHgW70tbqUVwu7vfhCLGRwTXY7CXmLnm8
	 UPDevgBcdOVkSCq2Dk7egiPNdgBFL2UhNBq6fHKVQ/vGLJZGtveynxuvppw45be+H
	 fDlqzIJ81aRlq0pITGpeJS5kU/26umeT3FzL6a1Mjj1exqLlswu+8SQtRWU5oBWsE
	 XiVVmliZyY2KqlzKfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26r3-1sv7nK0qHR-00A4kr; Tue, 24
 Sep 2024 23:18:07 +0200
Message-ID: <46b027e8-1c60-4d40-b53e-7f97ba65d982@gmx.com>
Date: Wed, 25 Sep 2024 06:48:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: send: fix buffer overflow detection when copying
 path to cache entry
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <ee24884b0255f717071ca932bda1ab398707d9cf.1726782272.git.fdmanana@suse.com>
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
In-Reply-To: <ee24884b0255f717071ca932bda1ab398707d9cf.1726782272.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xVrpLbMpPZ0gZTEUu1KivQgJGejLNh0cxsfwU5bMXWA/VxtdpgW
 l3MNz+GsUR9NbZ2c5ScjHeMlGKhtVQOrgQMsxqpZxlpuXsH63GWyVvPrFLb2u+VWpgkU7xV
 15sAfFyFjgIJ580BOmAEoyl7Vigmfg63Um+oifHfsvM8SxzGKSA+Y2LnophWKzFa4BMLYd8
 lATirjiMgo49cGnWOULWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X2dXAYJ3qSk=;0Noo/Yv2TshXBGpw9wgpw8RExkm
 yfH8gJ3PkGJmoc+kFKUnOBUypTbFp6x8gu50b0bhoJ7AaLZuKE5/3UNRH9mmTo8C+kG1zZCcI
 P2BihfxRXhE9RsvDYKIJCiyIx1Uyqut0EW1G/EaK+SoLJSB6YDTTjGOXMe7nCUT9ZuCzJEJTs
 ji5j51lOHis0UMhR8TsYUqFvESyzfSrzp9+Wrbq+ZSInNU3wvHuW2rDqjcCgNOuEWJlXjZxdX
 InUjsZRBMX/FWJMi4zuCW/8x/7b/1f8xYXjVfS1yvfzbD79guY2RMX1stIT+BRajJ4neQBrcy
 E1BB+DQvdo4fPrGa7lvskdI7zawmengoAMnfGBpFXz5y86Bj5I1ruy0prTpYtkjJQ7ldV5w1R
 7HwEJk4koWpHcC2VMTKn1kFlFqODtSGGifyD2HH1u4b8oBipEL9NOa8uerCMg6zr8KXEn/fRa
 EHy4RB33CpgqS/M2iAsjp9Wx0EqronlJAy3Ct8S0Dqm1hWhVezkpAxbcpQfjJwYThNCEVFpDx
 +YYYwpqJ/Iq/rfB6fFs3TjAo7/G6MIrCiWuKo2OIGeeoFTC3JAJ4FWYecMAzyDbmgh339/vEc
 S+nksQCSQ52O0DPRApUDPfwME7X2ZCsnhVfME2QzwlM+eDfg80Jj6jehyWt0wtZikjgsX8Zuw
 q1Xudq9yw64vxglg+V0zqWoVwvsvaBZl6syIvaqfwTdkakBfSbOVSDUafrR5OTz9s2s5/TS9k
 gc3/VBpAsGstloyz1jXbOOBMemx5daBvPenjwNGEbxRy+JKieKuamdrK4Aor56IBY8AONal1n
 LAO5wKUvOmwnMIiFOlZ3AknO1wJsfErr0EONKOvBge5xk=



=E5=9C=A8 2024/9/20 07:20, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Starting with commit c0247d289e73 ("btrfs: send: annotate struct
> name_cache_entry with __counted_by()") we annotated the variable length
> array "name" from the name_cache_entry structure with __counted_by() to
> improve overflow detection. However that alone was not correct, because
> the length of that array does not match the "name_len" field - it matche=
s
> that plus 1 to include the nul string terminador, so that makes a
> fortified kernel think there's an overflow and report a splat like this:
>
>     Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here ]----------=
--
>     Sep 15 23:32:17 sdslinux1 kernel: strcpy: detected buffer overflow: =
20
>     byte write of buffer size 19
>     Sep 15 23:32:17 sdslinux1 kernel: WARNING: CPU: 3 PID: 3310 at
>     __fortify_report+0x45/0x50
>     Sep 15 23:32:17 sdslinux1 kernel: Modules linked in: nfsd auth_rpcgs=
s
>     lockd grace nfs_acl bridge stp llc bonding tls vfat fat binfmt_misc
>     snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common x8
>     6_pkg_temp_thermal intel_powerclamp kvm_intel iTCO_wdt intel_pmc_bxt
>     spi_intel_platform kvm at24 mei_wdt spi_intel mei_pxp
>     iTCO_vendor_support mei_hdcp btusb snd_hda_codec_realtek btbcm btint=
e
>     l snd_hda_scodec_component i915 rapl iwlwifi snd_hda_codec_generic b=
trtl
>     intel_cstate btmtk cec snd_hda_intel intel_uncore cfg80211
>     snd_intel_dspcfg drm_buddy coretemp snd_intel_sdw_acpi bluet
>     ooth ttm pcspkr snd_hda_codec rfkill snd_hda_core snd_hwdep intel_vb=
tn
>     snd_pcm mei_me drm_display_helper snd_timer sparse_keymap i2c_i801 m=
ei
>     snd i2c_smbus lpc_ich soundcore cdc_mbim cdc_wdm cdc_ncm cdc_ether
>     usbnet crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
>     polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_s=
sse3
>     igb r8152 serio_raw i2c_algo_bit mii dca e1000e video wmi sunrpc
>     Sep 15 23:32:17 sdslinux1 kernel: CPU: 3 UID: 0 PID: 3310 Comm: btrf=
s
>     Not tainted 6.11.0-prnet #1
>     Sep 15 23:32:17 sdslinux1 kernel: Hardware name: CompuLab Ltd.
>     sbc-ihsw/Intense-PC2 (IPC2), BIOS IPC2_3.330.7 X64 03/15/2018
>     Sep 15 23:32:17 sdslinux1 kernel: RIP: 0010:__fortify_report+0x45/0x=
50
>     Sep 15 23:32:17 sdslinux1 kernel: Code: 48 8b 34 (...)
>     Sep 15 23:32:17 sdslinux1 kernel: RSP: 0018:ffff97ebc0d6f650 EFLAGS:
>     00010246
>     Sep 15 23:32:17 sdslinux1 kernel: RAX: 7749924ef60fa600 RBX:
>     ffff8bf5446a521a RCX: 0000000000000027
>     Sep 15 23:32:17 sdslinux1 kernel: RDX: 00000000ffffdfff RSI:
>     ffff97ebc0d6f548 RDI: ffff8bf84e7a1cc8
>     Sep 15 23:32:17 sdslinux1 kernel: RBP: ffff8bf548574080 R08:
>     ffffffffa8c40e10 R09: 0000000000005ffd
>     Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000004 R11:
>     ffffffffa8c70e10 R12: ffff8bf551eef400
>     Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000000 R14:
>     0000000000000013 R15: 00000000000003a8
>     Sep 15 23:32:17 sdslinux1 kernel: FS:  00007fae144de8c0(0000)
>     GS:ffff8bf84e780000(0000) knlGS:0000000000000000
>     Sep 15 23:32:17 sdslinux1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>     0000000080050033
>     Sep 15 23:32:17 sdslinux1 kernel: CR2: 00007fae14691690 CR3:
>     00000001027a2003 CR4: 00000000001706f0
>     Sep 15 23:32:17 sdslinux1 kernel: Call Trace:
>     Sep 15 23:32:17 sdslinux1 kernel:  <TASK>
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __warn+0x12a/0x1d0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
>     Sep 15 23:32:17 sdslinux1 kernel:  ? report_bug+0x154/0x1c0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? handle_bug+0x42/0x70
>     Sep 15 23:32:17 sdslinux1 kernel:  ? exc_invalid_op+0x1a/0x50
>     Sep 15 23:32:17 sdslinux1 kernel:  ? asm_exc_invalid_op+0x1a/0x20
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
>     Sep 15 23:32:17 sdslinux1 kernel:  __fortify_panic+0x9/0x10
>     Sep 15 23:32:17 sdslinux1 kernel: __get_cur_name_and_parent+0x3bc/0x=
3c0
>     Sep 15 23:32:17 sdslinux1 kernel:  get_cur_path+0x207/0x3b0
>     Sep 15 23:32:17 sdslinux1 kernel:  send_extent_data+0x709/0x10d0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? find_parent_nodes+0x22df/0x25d0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? mas_nomem+0x13/0x90
>     Sep 15 23:32:17 sdslinux1 kernel:  ? mtree_insert_range+0xa5/0x110
>     Sep 15 23:32:17 sdslinux1 kernel:  ? btrfs_lru_cache_store+0x5f/0x1e=
0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? iterate_extent_inodes+0x52d/0x5=
a0
>     Sep 15 23:32:17 sdslinux1 kernel:  process_extent+0xa96/0x11a0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_lookup_backref_cache+0x10=
/0x10
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_store_backref_cache+0x10/=
0x10
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_iterate_backrefs+0x10/0x1=
0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_check_extent_item+0x10/0x=
10
>     Sep 15 23:32:17 sdslinux1 kernel:  changed_cb+0x6fa/0x930
>     Sep 15 23:32:17 sdslinux1 kernel:  ? tree_advance+0x362/0x390
>     Sep 15 23:32:17 sdslinux1 kernel:  ? memcmp_extent_buffer+0xd7/0x160
>     Sep 15 23:32:17 sdslinux1 kernel:  send_subvol+0xf0a/0x1520
>     Sep 15 23:32:17 sdslinux1 kernel:  btrfs_ioctl_send+0x106b/0x11d0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx___clone_root_cmp_sort+0x1=
0/0x10
>     Sep 15 23:32:17 sdslinux1 kernel:  _btrfs_ioctl_send+0x1ac/0x240
>     Sep 15 23:32:17 sdslinux1 kernel:  btrfs_ioctl+0x75b/0x850
>     Sep 15 23:32:17 sdslinux1 kernel:  __se_sys_ioctl+0xca/0x150
>     Sep 15 23:32:17 sdslinux1 kernel:  do_syscall_64+0x85/0x160
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __count_memcg_events+0x69/0x100
>     Sep 15 23:32:17 sdslinux1 kernel:  ? handle_mm_fault+0x1327/0x15c0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? __se_sys_rt_sigprocmask+0xf1/0x=
180
>     Sep 15 23:32:17 sdslinux1 kernel:  ? syscall_exit_to_user_mode+0x75/=
0xa0
>     Sep 15 23:32:17 sdslinux1 kernel:  ? do_syscall_64+0x91/0x160
>     Sep 15 23:32:17 sdslinux1 kernel:  ? do_user_addr_fault+0x21d/0x630
>     Sep 15 23:32:17 sdslinux1 kernel: entry_SYSCALL_64_after_hwframe+0x7=
6/0x7e
>     Sep 15 23:32:17 sdslinux1 kernel: RIP: 0033:0x7fae145eeb4f
>     Sep 15 23:32:17 sdslinux1 kernel: Code: 00 48 89 (...)
>     Sep 15 23:32:17 sdslinux1 kernel: RSP: 002b:00007ffdf1cb09b0 EFLAGS:
>     00000246 ORIG_RAX: 0000000000000010
>     Sep 15 23:32:17 sdslinux1 kernel: RAX: ffffffffffffffda RBX:
>     0000000000000004 RCX: 00007fae145eeb4f
>     Sep 15 23:32:17 sdslinux1 kernel: RDX: 00007ffdf1cb0ad0 RSI:
>     0000000040489426 RDI: 0000000000000004
>     Sep 15 23:32:17 sdslinux1 kernel: RBP: 00000000000078fe R08:
>     00007fae144006c0 R09: 00007ffdf1cb0927
>     Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000008 R11:
>     0000000000000246 R12: 00007ffdf1cb1ce8
>     Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000003 R14:
>     000055c499fab2e0 R15: 0000000000000004
>     Sep 15 23:32:17 sdslinux1 kernel:  </TASK>
>     Sep 15 23:32:17 sdslinux1 kernel: ---[ end trace 0000000000000000 ]-=
--
>     Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here ]----------=
--
>
> Fix this by not storing the nul string terminator since we don't actuall=
y
> need it for name cache entries, this way "name_len" corresponds to the
> actual size of the "name" array. This requires marking the "name" array
> field with __nonstring and using memcpy() instead of strcpy() as
> recommended by the guidelines at:
>
>     https://github.com/KSPP/linux/issues/90
>
> Reported-by: David Arendt <admin@prnet.org>
> Link: https://lore.kernel.org/linux-btrfs/cee4591a-3088-49ba-99b8-d86b42=
42b8bd@prnet.org/
> Fixes: c0247d289e73 ("btrfs: send: annotate struct name_cache_entry with=
 __counted_by()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/send.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 7f48ba6c1c77..ae2872033601 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -346,8 +346,10 @@ struct name_cache_entry {
>   	u64 parent_gen;
>   	int ret;
>   	int need_later_update;
> +	/* Name length without NUL terminator. */
>   	int name_len;
> -	char name[] __counted_by(name_len);
> +	/* Not NUL terminaed. */
> +	char name[] __counted_by(name_len) __nonstring;
>   };
>
>   /* See the comment at lru_cache.h about struct btrfs_lru_cache_entry. =
*/
> @@ -2388,7 +2390,7 @@ static int __get_cur_name_and_parent(struct send_c=
tx *sctx,
>   	/*
>   	 * Store the result of the lookup in the name cache.
>   	 */
> -	nce =3D kmalloc(sizeof(*nce) + fs_path_len(dest) + 1, GFP_KERNEL);
> +	nce =3D kmalloc(sizeof(*nce) + fs_path_len(dest), GFP_KERNEL);
>   	if (!nce) {
>   		ret =3D -ENOMEM;
>   		goto out;
> @@ -2400,7 +2402,7 @@ static int __get_cur_name_and_parent(struct send_c=
tx *sctx,
>   	nce->parent_gen =3D *parent_gen;
>   	nce->name_len =3D fs_path_len(dest);
>   	nce->ret =3D ret;
> -	strcpy(nce->name, dest->start);
> +	memcpy(nce->name, dest->start, nce->name_len);
>
>   	if (ino < sctx->send_progress)
>   		nce->need_later_update =3D 0;


