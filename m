Return-Path: <linux-btrfs+bounces-675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE0805F2D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 21:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7261D1F216C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E784E6DD00;
	Tue,  5 Dec 2023 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fv5dWIEq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBCC0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701807213; x=1702412013; i=quwenruo.btrfs@gmx.com;
	bh=Ap2axUIKhMkacYRj/wwtqGol4CEBETsCKvwxNpaT5lQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=fv5dWIEqRtWP1+LfIp+fZrSRxUAWk/RWgQixyE69wQnBPevQfC6YvEN7IDujijEN
	 XFBpO2R3T5i4pSZ+WmTn+9rdMt3sSZufImim5cPP4v9ufULdspSlOhwfc0ds2oHKB
	 sAueZXT4XTx24mIcUtD/3Yq+ag2WEzWq3KEt+6Tuhc8NIbQv9AWSvGDk0o6dcmgq+
	 VlsfVJ0cJ0sd/FWgtFijzY8Bb9fL8zwB7RO/EP7K7Sa6+qT5mnAnWJKm0YhNMJDyi
	 p0gp0wm037rDsOx8mkG2Ba7nPXwAy4WDw0sAuyPIf5/RZnE6oc5uiHB6fDZ1NEQMq
	 hJNGgyYe2JbkWg0jyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv2xU-1rS8gG07Zg-00r0i4; Tue, 05
 Dec 2023 21:13:33 +0100
Message-ID: <d7182926-f2bd-4ee7-9f74-4c276ac6c7e2@gmx.com>
Date: Wed, 6 Dec 2023 06:43:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: cleanup metadata page pointer usage
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1701410200.git.wqu@suse.com>
 <1d39380364ff0a1c8e6e352a98312fb2a860f25b.1701410201.git.wqu@suse.com>
 <20231205140023.GA2751@twin.jikos.cz>
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
In-Reply-To: <20231205140023.GA2751@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AN80wdRMjhyDkhx4yCLy7D86Dmck4ac2sOTHZ1i9uSq6GbFokOF
 5prKVLNt/axF9BYt3ZHSLSine/9uM6i/aPSMgOn2/p6NMegFFvy2tx8mnn1ycRybeLYdjm6
 flzvj32MnlY2woOnwFBZjUySl/Atf78qCplD5eJAwOe2OorC7aJG7VxgkCN5Jke/1xmggfM
 35FwD+eX7TcB3BjiZDsPA==
UI-OutboundReport: notjunk:1;M01:P0:WSXBNb4aHZw=;FyJRNkDEgHPYX/ImAQRiRDkgUEf
 G6sOaMU/Ld5iR/sfY/Aav+sNbPx8PNVgB6SbGsjjTlT1GN3S4PLH2UYb2bgUjuaPL3/FeM1mH
 ZG7qcos3QnAW0bjHPbb2pgb4em02xDLVAWCDUoLE/R2ZaG9GcpEcInRjTW6tkPCoE85GY5eIC
 bmAU82ZOWd0/Clg+DCMLuU0avcIYSjYrb+Ok8q2PuHU9ub1Uk2BkdTOM2Z78h+gaKtNUM9EGF
 Hq2UmkKQ1b7blLmL3YOWKJnXciK+ACMmwAQV83mycyWPtyCis3ZSFxVkgWVxnkSN8mfW/Tarz
 LYhNAKo4FtmPozfrbl5yOZL5zZEBHW7GP5S3pas0A9L26sHBtPJih6b3kVchNG66rYiNdMl/M
 5siRAOVpZj1sBPVjCNvJmYOiX/fy/Ofpj394DHS9GPAzcIxAhcPbh9vkOg7KyAj5Zq5af8HT+
 Nk72s+9JAkCoIZpsUTZQLkstPnvrBcFEEVtU6cKgH93oD3m0jdBWOiuZ/zv5eJf6mLDyEysSP
 vznX+yoFofhNNYb+7BWBv0eAMwM/UNeVrurGZNPa7dj3V40FvVgUKKHV1KW7/OBRHFMOhSgyJ
 K/bm1uuPqXw02B1wG8r3Blh+chFsZiCZvLXgEFD54fmCK1OmNeg61Z2S6+5UatBTp5f1hlcRF
 Io5a8+NGmlkr18/O/dPEjfb4fxCBAK0kc2X7AknoJRIKTznnxd20nerw/i3i0q4TbmkIdmK0q
 QbfV3SSuAIBsquNan4SL5qTRuBi3SWcRR7w8uk9bQj0M2GevagFaqnC/1PM6ky6rL5TYmibU1
 ACLo6WgoL3N5Dt0LHsghng1SdBl8iBPHUjTSR6jL8joRahp2evMuT0rZp++TD5RVpTQrYHeYz
 hCDD7B7ulqHLBRUmVuuDW4LWgGyVEBw+zfPK/f02v2ZQRDqZBle/F6ruwYc3O1eBVtmt4gc1z
 xOkptpFntrFKYci3/a+4HDlJUSA=



On 2023/12/6 00:30, David Sterba wrote:
> On Fri, Dec 01, 2023 at 04:36:55PM +1030, Qu Wenruo wrote:
>> Although we have migrated extent_buffer::pages[] to folios[], we're
>> still mostly using the folio_page() help to grab the page.
>>
>> This patch would do the following cleanups for metadata:
>>
>> - Introduce num_extent_folios() helper
>>    This is to replace most num_extent_pages() callers.
>>
>> - Use num_extent_folios() to iterate future large folios
>>    This allows us to use things like
>>    bio_add_folio()/bio_add_folio_nofail(), and only set the needed flag=
s
>>    for the folio (aka the leading/tailing page), which reduces the loop
>>    iteration to 1 for large folios.
>>
>> - Change metadata related functions to use folio pointers
>>    Including their function name, involving:
>>    * attach_extent_buffer_page()
>>    * detach_extent_buffer_page()
>>    * page_range_has_eb()
>>    * btrfs_release_extent_buffer_pages()
>>    * btree_clear_page_dirty()
>>    * btrfs_page_inc_eb_refs()
>>    * btrfs_page_dec_eb_refs()
>>
>> - Change btrfs_is_subpage() to accept an address_space pointer
>>    This is to allow both page->mapping and folio->mapping to be utilize=
d.
>>    As data is still using the old per-page code, and may keep so for a
>>    while.
>>
>> - Special corner case place holder for future order mismatches between
>>    extent buffer and inode filemap
>>    For now it's  just a block of comments and a dead ASSERT(), no real
>>    handling yet.
>>
>> The subpage code would still go page, just because subpage and large
>> folio are conflicting conditions, thus we don't need to bother subpage
>> with higher order folios at all. Just folio_page(folio, 0) would be
>> enough.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> KASAN reports some problems:
>
> [  228.984474] Btrfs loaded, debug=3Don, assert=3Don, ref-verify=3Don, z=
oned=3Dyes, fsverity=3Dyes
> [  228.986241] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
> [  228.987192] BTRFS: selftest: running btrfs free space cache tests
> [  228.988141] BTRFS: selftest: running extent only tests
> [  228.989096] BTRFS: selftest: running bitmap only tests
> [  228.990108] BTRFS: selftest: running bitmap and extent tests
> [  228.991396] BTRFS: selftest: running space stealing from bitmap to ex=
tent tests
> [  228.993137] BTRFS: selftest: running bytes index tests
> [  228.994741] BTRFS: selftest: running extent buffer operation tests
> [  228.995875] BTRFS: selftest: running btrfs_split_item tests
> [  228.997062] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  228.998388] BUG: KASAN: global-out-of-bounds in alloc_eb_folio_array+=
0xd6/0x180 [btrfs]

Unfortunately I failed to reproduce here, even I have enabled KASAN and
always have selftest enabled.

> [  229.000005] Read of size 8 at addr ffffffffc07f32e8 by task modprobe/=
13543

The address looks like stack address, and since it's not reported from
btrfs_alloc_page_array(), it must be the
   "eb->folios[i] =3D page_folio(page_array[i]);" line.

But I failed to see any obvious problem here.

Any extra clue for debugging?

Thanks,
Qu
> [  229.000973]
> [  229.001294] CPU: 2 PID: 13543 Comm: modprobe Tainted: G           O  =
     6.7.0-rc4-default+ #2250
> [  229.002556] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [  229.004054] Call Trace:
> [  229.004489]  <TASK>
> [  229.004913]  dump_stack_lvl+0x46/0x70
> [  229.005546]  print_address_description.constprop.0+0x30/0x420
> [  229.006431]  print_report+0xb0/0x260
> [  229.007023]  ? kasan_addr_to_slab+0x9/0xc0
> [  229.007685]  kasan_report+0xbe/0xf0
> [  229.008275]  ? alloc_eb_folio_array+0xd6/0x180 [btrfs]
> [  229.009212]  ? alloc_eb_folio_array+0xd6/0x180 [btrfs]
> [  229.010113]  alloc_eb_folio_array+0xd6/0x180 [btrfs]
> [  229.010932]  ? btrfs_alloc_page_array+0x100/0x100 [btrfs]
> [  229.011816]  ? is_module_address+0x11/0x30
> [  229.012488]  ? static_obj+0x73/0xa0
> [  229.013054]  ? lockdep_init_map_type+0xe8/0x360
> [  229.013751]  ? __raw_spin_lock_init+0x73/0x90
> [  229.014426]  ? __alloc_extent_buffer+0x14a/0x190 [btrfs]
> [  229.015225]  __alloc_dummy_extent_buffer+0x2e/0x2b0 [btrfs]
> [  229.016121]  test_btrfs_split_item+0xcf/0x7d0 [btrfs]
> [  229.016995]  ? btrfs_test_free_space_cache+0x1e0/0x1e0 [btrfs]
> [  229.017872]  ? info_print_prefix+0x100/0x100
> [  229.018523]  ? btrfs_test_free_space_cache+0xda/0x1e0 [btrfs]
> [  229.019461]  ? __kmem_cache_free+0xfa/0x200
> [  229.020064]  btrfs_run_sanity_tests+0x78/0x140 [btrfs]
> [  229.020976]  init_btrfs_fs+0x38/0x220 [btrfs]
> [  229.021867]  ? btrfs_interface_init+0x20/0x20 [btrfs]
> [  229.022818]  do_one_initcall+0xc3/0x3b0
> [  229.023473]  ? trace_event_raw_event_initcall_level+0x150/0x150
> [  229.024436]  ? __kmem_cache_alloc_node+0x1b5/0x2e0
> [  229.025279]  ? do_init_module+0x38/0x3b0
> [  229.025806]  ? kasan_unpoison+0x40/0x60
> [  229.026477]  do_init_module+0x135/0x3b0
> [  229.027134]  load_module+0x11c1/0x13c0
> [  229.027766]  ? layout_and_allocate.isra.0+0x280/0x280
> [  229.028435]  ? kernel_read_file+0x252/0x3f0
> [  229.029060]  ? __ia32_sys_fsconfig+0x70/0x70
> [  229.029755]  ? init_module_from_file+0xd1/0x130
> [  229.030489]  init_module_from_file+0xd1/0x130
> [  229.031184]  ? __do_sys_init_module+0x1a0/0x1a0
> [  229.031954]  ? idempotent_init_module+0x3b9/0x3d0
> [  229.032727]  ? do_raw_spin_unlock+0x84/0xf0
> [  229.033393]  idempotent_init_module+0x1ac/0x3d0
> [  229.034101]  ? init_module_from_file+0x130/0x130
> [  229.034837]  ? __fget_files+0xfd/0x1e0
> [  229.035449]  __x64_sys_finit_module+0x72/0xb0
> [  229.037902]  do_syscall_64+0x41/0xe0
> [  229.038495]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> [  229.039314] RIP: 0033:0x7f07839f53dd
> [  229.042725] RSP: 002b:00007fff7eb94c18 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000139
> [  229.043642] RAX: ffffffffffffffda RBX: 00005574ab37ba20 RCX: 00007f07=
839f53dd
> [  229.044833] RDX: 0000000000000000 RSI: 00005574ab372c5a RDI: 00000000=
0000000e
> [  229.046002] RBP: 00005574ab372c5a R08: 0000000000000000 R09: 00005574=
ab37baa0
> [  229.047195] R10: 00005574ab37f850 R11: 0000000000000246 R12: 00000000=
00040000
> [  229.048275] R13: 0000000000000000 R14: 00005574ab3841b0 R15: 00005574=
ab37b480
> [  229.049320]  </TASK>
> [  229.049767]
> [  229.050124] The buggy address belongs to the variable:
> [  229.050961]  __func__.1+0x288/0xffffffffffeeafa0 [btrfs]
> [  229.051928]
> [  229.052205] Memory state around the buggy address:
> [  229.052971]  ffffffffc07f3180: f9 f9 f9 f9 00 04 f9 f9 f9 f9 f9 f9 00=
 00 00 00
> [  229.054075]  ffffffffc07f3200: 00 00 00 00 03 f9 f9 f9 f9 f9 f9 f9 00=
 00 00 03
> [  229.055173] >ffffffffc07f3280: f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9 00=
 07 f9 f9
> [  229.056210]                                                          =
 ^
> [  229.057066]  ffffffffc07f3300: f9 f9 f9 f9 00 00 00 00 04 f9 f9 f9 f9=
 f9 f9 f9
> [  229.058152]  ffffffffc07f3380: 00 00 00 02 f9 f9 f9 f9 00 00 03 f9 f9=
 f9 f9 f9
> [  229.059119] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  229.060341] Disabling lock debugging due to kernel taint
> [  229.061254] BUG: unable to handle page fault for address: 00006b636f6=
c5f7a
> [  229.062383] #PF: supervisor read access in kernel mode
> [  229.063232] #PF: error_code(0x0000) - not-present page
> [  229.064079] PGD 0 P4D 0
> [  229.064544] Oops: 0000 [#1] PREEMPT SMP KASAN
> [  229.065296] CPU: 2 PID: 13543 Comm: modprobe Tainted: G    B      O  =
     6.7.0-rc4-default+ #2250
> [  229.066783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [  229.068574] RIP: 0010:folio_flags.constprop.0+0x12/0x30 [btrfs]
> [  229.072394] RSP: 0018:ffff88800294f840 EFLAGS: 00010282
> [  229.073281] RAX: 0000000000000000 RBX: 00006b636f6c5f72 RCX: ffffffff=
c05c5c12
> [  229.074409] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00006b63=
6f6c5f7a
> [  229.075488] RBP: 00006b636f6c5f72 R08: 0000000000000001 R09: fffffbff=
f37183f8
> [  229.076600] R10: ffffffff9b8c1fc7 R11: 0000000000000001 R12: 00000000=
00000000
> [  229.077723] R13: ffff88801d1e4008 R14: 0000000000001000 R15: ffffffff=
c08b0228
> [  229.078905] FS:  00007f07838e5740(0000) GS:ffff88806ce00000(0000) knl=
GS:0000000000000000
> [  229.080262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  229.081228] CR2: 00006b636f6c5f7a CR3: 000000000598a000 CR4: 00000000=
000006b0
> [  229.082417] Call Trace:
> [  229.082849]  <TASK>
> [  229.083289]  ? __die+0x1f/0x60
> [  229.083896]  ? page_fault_oops+0x71/0xa0
> [  229.084629]  ? exc_page_fault+0x69/0xd0
> [  229.085354]  ? asm_exc_page_fault+0x22/0x30
> [  229.086130]  ? folio_flags.constprop.0+0x12/0x30 [btrfs]
> [  229.087170]  ? folio_flags.constprop.0+0x12/0x30 [btrfs]
> [  229.088173]  __alloc_dummy_extent_buffer+0x5b/0x2b0 [btrfs]
> [  229.089206]  test_btrfs_split_item+0xcf/0x7d0 [btrfs]
> [  229.090139]  ? btrfs_test_free_space_cache+0x1e0/0x1e0 [btrfs]
> [  229.091192]  ? info_print_prefix+0x100/0x100
> [  229.091900]  ? btrfs_test_free_space_cache+0xda/0x1e0 [btrfs]
> [  229.092924]  ? __kmem_cache_free+0xfa/0x200
> [  229.093604]  btrfs_run_sanity_tests+0x78/0x140 [btrfs]
> [  229.094544]  init_btrfs_fs+0x38/0x220 [btrfs]
> [  229.095401]  ? btrfs_interface_init+0x20/0x20 [btrfs]
> [  229.096325]  do_one_initcall+0xc3/0x3b0
> [  229.096948]  ? trace_event_raw_event_initcall_level+0x150/0x150
> [  229.097765]  ? __kmem_cache_alloc_node+0x1b5/0x2e0
> [  229.098594]  ? do_init_module+0x38/0x3b0
> [  229.099189]  ? kasan_unpoison+0x40/0x60
> [  229.099794]  do_init_module+0x135/0x3b0
> [  229.100479]  load_module+0x11c1/0x13c0
> [  229.101095]  ? layout_and_allocate.isra.0+0x280/0x280
> [  229.101874]  ? kernel_read_file+0x252/0x3f0
> [  229.102481]  ? __ia32_sys_fsconfig+0x70/0x70
> [  229.103189]  ? init_module_from_file+0xd1/0x130
> [  229.103918]  init_module_from_file+0xd1/0x130
> [  229.104615]  ? __do_sys_init_module+0x1a0/0x1a0
> [  229.105352]  ? idempotent_init_module+0x3b9/0x3d0
> [  229.106118]  ? do_raw_spin_unlock+0x84/0xf0
> [  229.106787]  idempotent_init_module+0x1ac/0x3d0
> [  229.107592]  ? init_module_from_file+0x130/0x130
> [  229.108413]  ? __fget_files+0xfd/0x1e0
> [  229.108979]  __x64_sys_finit_module+0x72/0xb0
> [  229.109686]  do_syscall_64+0x41/0xe0
> [  229.110286]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> [  229.111074] RIP: 0033:0x7f07839f53dd
> [  229.114183] RSP: 002b:00007fff7eb94c18 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000139
> [  229.115057] RAX: ffffffffffffffda RBX: 00005574ab37ba20 RCX: 00007f07=
839f53dd
> [  229.116099] RDX: 0000000000000000 RSI: 00005574ab372c5a RDI: 00000000=
0000000e
> [  229.117162] RBP: 00005574ab372c5a R08: 0000000000000000 R09: 00005574=
ab37baa0
> [  229.118178] R10: 00005574ab37f850 R11: 0000000000000246 R12: 00000000=
00040000
> [  229.119254] R13: 0000000000000000 R14: 00005574ab3841b0 R15: 00005574=
ab37b480
> [  229.120183]  </TASK>
> [  229.120582] Modules linked in: btrfs(O+) blake2b_generic libcrc32c xo=
r lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhas=
h zstd_common loop
> [  229.122735] CR2: 00006b636f6c5f7a
> [  229.123266] ---[ end trace 0000000000000000 ]---
> [  229.123916] RIP: 0010:folio_flags.constprop.0+0x12/0x30 [btrfs]
> [  229.127469] RSP: 0018:ffff88800294f840 EFLAGS: 00010282
> [  229.128273] RAX: 0000000000000000 RBX: 00006b636f6c5f72 RCX: ffffffff=
c05c5c12
> [  229.129305] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00006b63=
6f6c5f7a
> [  229.130327] RBP: 00006b636f6c5f72 R08: 0000000000000001 R09: fffffbff=
f37183f8
> [  229.131362] R10: ffffffff9b8c1fc7 R11: 0000000000000001 R12: 00000000=
00000000
> [  229.132442] R13: ffff88801d1e4008 R14: 0000000000001000 R15: ffffffff=
c08b0228
> [  229.133657] FS:  00007f07838e5740(0000) GS:ffff88806ce00000(0000) knl=
GS:0000000000000000
> [  229.134887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  229.135776] CR2: 00006b636f6c5f7a CR3: 000000000598a000 CR4: 00000000=
000006b0
>

