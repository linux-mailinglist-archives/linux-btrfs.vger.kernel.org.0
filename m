Return-Path: <linux-btrfs+bounces-19720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802A9CBB469
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 23:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A6B5300B28E
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 22:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B381FDE39;
	Sat, 13 Dec 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RzRBqdzC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752535958
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765665114; cv=none; b=Bhzc1rvu1eFzInwtYbs1FGL4bGTvv5TcLC7VZT1FQDMq+n4Ay6duxuzpVw8R0Is2/XQQQ2v3b5BNFoqW4e5s4Vw3IjwXuDKSxJ+/OhoyF8kigo2rOocESb3HJoNT66eVNfms2jKvaYhUuLlL9Jlvcf0lpw7x19uAkEjqYplwI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765665114; c=relaxed/simple;
	bh=HjV2kLGBQE92ejuT1IS392oGdeV+FvyIckDi75Wke7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9uMWPcXZsilppqCYFZ40MHoTQYbaDZzRfMta/OTvD8H9RV40cgYfEXWRLXFZO+ujCKSxhkoT8cgkjxYsgzxpEhJFJYe7SVbG3oqqB9u6e2+xEFOHHOGb4DVeRr9SbOEARxmZAcJPb9bJDzRPwI7Uh8Vifr/Br8AEm51FZ5T3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RzRBqdzC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso10233665e9.1
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 14:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765665110; x=1766269910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ODCIVYYbehBGDcGwxxsOJiTRjx2bH54jL4ZykMiX9rA=;
        b=RzRBqdzCUNt/l2RhmieUFLT+QeqSoeSvkN+8JghV87UeRtNZt2syFJt7uTQhHD6ljV
         Yo6OQiYoWKexbW5mJGpNIklCdB8778gvFcSiDvxI3Dc0xBvrxYLCjYv9pnuWfydBW2M8
         otnAWZAfXZ4PbIMFR179xvNV1XsMqE5vSXf9h0cmw7y+mKNTKT69BpEhaLmReJF2hWn4
         mt4vpPMbtwB5y03thbwA01Wb64mWTFellTO3j2AzI676KsXArnSC3oE3siprC3PMPk+X
         mVAKVE3Ia6pqSVPvrKGj1ZLW0uKzHobyZ++i748HZD1X1H7Cf1wW2OY9plbTRBdK8x8M
         E53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765665110; x=1766269910;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODCIVYYbehBGDcGwxxsOJiTRjx2bH54jL4ZykMiX9rA=;
        b=gyb7O5k9jBedJK3tnda3H6EYN2i/vyf0AxT+k90sHuvgO4999l45KcztnT4vR4061h
         ZCo5TLwj/8tvnAMeRcE5jU2d1osBokrzRKvA1VQbTg1lRwnVp1CtXtYndwsLGiQl7MBw
         jVXecHNB96ZlF6fYKC4k2AE7ijNp+aGXNTMcObdw0sWx388Rtrh8IEo1xOggvHa0Ga68
         v4nTxdBmy4mu2BLzPeHd6gdO7YJOhIyRwzHRW+LvqxO9Gqc6ox1kfcqvcHKNnIn1dJED
         BdMw9Pa0BOpgFZHPEzT4jDfHydhPjZkrUsaBogBnPZo3CBS09fFZDGJ/jOHXUU3IPbyk
         auzw==
X-Gm-Message-State: AOJu0YzAKG4g3YPfraoAT2BgCA5kUsNvcyNIN4taZnezdSyhL58NcqUe
	k5m1KLfqipYe7waOec4UWw7jqadRgEjbt06fcWgG8aFrrHXFuKTHesUGMDFA3G7eY2eMwkKEFpM
	XyBPF
X-Gm-Gg: AY/fxX78I6mD6nyr9c5lDLYshW+IlJiWPxAQ5Voxfi/6NxEinQeLbGrOejpDEfkJeJM
	fxdDSG3lzsZpIvSNBP2e1Wc4Bq7yCVo75PAGuKVPxWKkzeeGBNbacYcc8DifUFhVL80lY8g64gK
	qUzTyD2SJVrZoA7f9vXeTBNt8VY/wRBXvpyMqRwOQITt8js3WDQ0Z8Rv9OCyColSEDY2lJDq4gq
	a0Zs+uCrHPViKibV46cUU9naD/XVDuKQ7bnmkr8ixQ5aiIhbSnmu9qeAlzRJ3zqDmvfqnRxMzFf
	RslR4391ZESNoYY7CijOOr+I9RataGuDi8weiWXlq2tx0DYvfuf5oS5/cl93C61KEuacUzPSuK/
	7WqkEG3ybarnA9uQmY5/LoBXOIhAUkSqhDflP68kXDDaMlbK/KSmdnu4cduUZXDRg+ZLjM8SBtc
	T/wFza4AAmQwZGdpYdSNFUbN4sxv4Ve9IP2MrHaqY=
X-Google-Smtp-Source: AGHT+IHEc+Wt9Qk3FJDcAqsEZ7g46uOneuxgUMyYqCzBZHknNz5oTyLb1dnxC3HMihAb36GOjAK/wQ==
X-Received: by 2002:a05:600c:64c8:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-47a8f8c0532mr70151735e9.12.1765665110092;
        Sat, 13 Dec 2025 14:31:50 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c22851besm8705365b3a.11.2025.12.13.14.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 14:31:48 -0800 (PST)
Message-ID: <684a6f99-0df8-428a-8e57-294a38b8788e@suse.com>
Date: Sun, 14 Dec 2025 09:01:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: harden __reserve_bytes() with space_info==NULL
To: Kai Krakow <kai@kaishome.de>
Cc: linux-btrfs@vger.kernel.org, Eli Venter <eli@genedx.com>
References: <20251213200920.1808679-1-kai@kaishome.de>
 <350e9b44-7a16-4c3f-a54f-5b6b3f4931f3@suse.com>
 <CAC2ZOYtgvzThSVX7tsajF=czm3JaYzpKjCsJB72Tw3_35Notzw@mail.gmail.com>
 <4a4c04ff-3855-467c-af75-77c6ddf27098@suse.com>
 <CAC2ZOYvY1x-vx9rUs-tZ2J_oHjX-pj7C1muFwvnH5NHSHn0ntw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <CAC2ZOYvY1x-vx9rUs-tZ2J_oHjX-pj7C1muFwvnH5NHSHn0ntw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/14 08:13, Kai Krakow 写道:
> Am Sa., 13. Dez. 2025 um 22:15 Uhr schrieb Qu Wenruo <wqu@suse.com>:
[...]
>>
>> So if you really want to change a member, do a proper in-memory update
>> only, and find a way (e.g. a new dirty dev list) to tell the fs to
>> update the device item at commit time.
> 
> I don't want to steal your time,

I'm totally fine discussing the implementation details here.

> but is this a better approach?
> https://gist.github.com/kakra/aa3eb8473cc05c1d3dd000160a5ee481

Unfortunately as long as if you're trying to do any metadata 
modification, e.g. calling btrfs_update_device(), it will be a huge change.


My idea would be something like this:

btrfs_dev_info_type_store()
{
	btrfs_device *device = container_of();

	/* Do the proper locking. */

	WRITE_ONCE(device->type, type);
	if (!list_empty(&dev->dirty_list))
		list_add_tail(&fs_info->dirty_dev_list, &dev->dirty_list);

	return len;
}


Then inside btrfs_commit_transaction(), I do not yet have a good idea on 
the timing, but I guess it can done before btrfs_start_delalloc_flush().

Do something like this to write those dirty devices to chunk tree:

btrfs_commit_transaction()
{
	list_for_each_entry(dev, &fs_info->dirty_dev_list, dirty_list) {
		ret = btrfs_update_device(dev);
	}

	/* The remaining code. */
	ret = btrfs_start_delalloc_flush();
}


> 
> Thanks,
> Kai
> 
>> It's much safer and avoid a new and untested direct way to trigger
>> metadata modification.
>>
>> Thanks,
>> Qu
>>
>>>
>>> So I should be safe there even without this patch.
>>>
>>> Thanks,
>>> Kai
>>>
>>>>>> Noticed an oops with these patches when doing echo 1 >devinfo/2/type
>>>>>> while mount is still ongoing. My btrfs is big so the mount takes
>>>>>> 20-30 minutes. Reboot and wait until mount is complete and this
>>>>>> worked fine.
>>>>>
>>>>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>>>>> PGD 0 P4D 0
>>>>> Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
>>>>> CPU: 4 UID: 0 PID: 3520 Comm: bash Not tainted 6.12.52-dirty #2
>>>>> Hardware name: Penguin Computing Relion 1900/MD90-FS0-ZB-XX, BIOS R15 06/25/2018
>>>>> RIP: 0010:_raw_spin_lock+0x17/0x30
>>>>> Code: 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 ff 05 e8 c0 d8 5e 31 c0 ba 01 00 00 00 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e9 97 01 00 00 0f 1f 80 00
>>>>> RSP: 0018:ffffbc13a95837c8 EFLAGS: 00010246
>>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>>> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
>>>>> RBP: 0000000000000008 R08: ffffbc13a9583a07 R09: 0000000000000001
>>>>> R10: d800000000000000 R11: 0000000000000001 R12: ffff9bee913db000
>>>>> R13: 0000000000000000 R14: 00000000fffffffb R15: ffff9bee913db000
>>>>> FS: 00007fd6e270f740(0000) GS:ffff9bfddfc00000(0000) knlGS:0000000000000000
>>>>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 0000000000000008 CR3: 00000008d9986004 CR4: 00000000003706f0
>>>>> Call Trace:
>>>>>
>>>>> __reserve_bytes+0x70/0x720 [btrfs]
>>>>> ? get_page_from_freelist+0x343/0x1570
>>>>> btrfs_reserve_metadata_bytes+0x1d/0xd0 [btrfs]
>>>>> btrfs_use_block_rsv+0x153/0x220 [btrfs]
>>>>> btrfs_alloc_tree_block+0x83/0x580 [btrfs]
>>>>> btrfs_force_cow_block+0x129/0x620 [btrfs]
>>>>> btrfs_cow_block+0xcd/0x230 [btrfs]
>>>>> btrfs_search_slot+0x566/0xd60 [btrfs]
>>>>> ? kmem_cache_alloc_noprof+0x106/0x2f0
>>>>> btrfs_update_device+0x91/0x1d0 [btrfs]
>>>>> btrfs_devinfo_type_store+0xb8/0x140 [btrfs]
>>>>> kernfs_fop_write_iter+0x14c/0x200
>>>>> vfs_write+0x289/0x440
>>>>> ksys_write+0x6d/0xf0
>>>>> trace_clock_x86_tsc+0x20/0x20
>>>>> ? do_wp_page+0x838/0xf90
>>>>> ? __do_sys_newfstat+0x68/0x70
>>>>> ? __pte_offset_map+0x1b/0xf0
>>>>> ? __handle_mm_fault+0xa6c/0x10f0
>>>>> ? __count_memcg_events+0x53/0xf0
>>>>> ? handle_mm_fault+0x1c4/0x2d0
>>>>> ? do_user_addr_fault+0x334/0x620
>>>>> ? arch_exit_to_user_mode_prepare.isra.0+0x11/0x90
>>>>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>> RIP: 0033:0x7fd6e27a1687
>>>>> Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
>>>>> RSP: 002b:00007ffecb401260 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>>>>> RAX: ffffffffffffffda RBX: 00007fd6e270f740 RCX: 00007fd6e27a1687
>>>>> RDX: 0000000000000002 RSI: 0000557a2c38ad20 RDI: 0000000000000001
>>>>> RBP: 0000557a2c38ad20 R08: 0000000000000000 R09: 0000000000000000
>>>>> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
>>>>> R13: 00007fd6e28fa5c0 R14: 00007fd6e28f7e80 R15: 0000000000000000
>>>>>
>>>>> Modules linked in: rpcsec_gss_krb5 nfsv3 nfsv4 dns_resolver nfs netfs zram lz4hc_compress lz4_compress dm_crypt bonding tls ipmi_ssif intel_rapl_msr nfsd binfmt_misc auth_rpcgss nfs_acl lockd grace intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp rapl intel_cstate s>
>>>>> intel_pmc_bxt ixgbe ehci_pci iTCO_vendor_support xfrm_algo gf128mul libata mpt3sas xhci_hcd ehci_hcd watchdog crypto_simd mdio_devres libphy cryptd raid_class usbcore scsi_transport_sas mdio igb scsi_mod wmi usb_common i2c_i801 lpc_ich scsi_common i2c_smbus i2c_algo_bit dca
>>>>> CR2: 0000000000000008
>>>>> ---[ end trace 0000000000000000 ]---
>>>>> RIP: 0010:_raw_spin_lock+0x17/0x30
>>>>> Code: 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 ff 05 e8 c0 d8 5e 31 c0 ba 01 00 00 00 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e9 97 01 00 00 0f 1f 80 00
>>>>> RSP: 0018:ffffbc13a95837c8 EFLAGS: 00010246
>>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>>> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
>>>>> RBP: 0000000000000008 R08: ffffbc13a9583a07 R09: 0000000000000001
>>>>> R10: d800000000000000 R11: 0000000000000001 R12: ffff9bee913db000
>>>>> R13: 0000000000000000 R14: 00000000fffffffb R15: ffff9bee913db000
>>>>> FS: 00007fd6e270f740(0000) GS:ffff9bfddfc00000(0000) knlGS:0000000000000000
>>>>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 0000000000000008 CR3: 00000008d9986004 CR4: 00000000003706f0
>>>>>
>>>>> Reported-by: Eli Venter <eli@genedx.com>
>>>>> Signed-off-by: Kai Krakow <kai@kaishome.de>
>>>>> ---
>>>>>     fs/btrfs/space-info.c | 8 ++++++++
>>>>>     1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>>>>> index 97452fb5d29b..cbb6c4924850 100644
>>>>> --- a/fs/btrfs/space-info.c
>>>>> +++ b/fs/btrfs/space-info.c
>>>>> @@ -1752,6 +1752,14 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
>>>>>                 ASSERT(flush != BTRFS_RESERVE_FLUSH_EVICT);
>>>>>         }
>>>>>
>>>>> +     /*
>>>>> +      * During mount, the global block reserve might not have its space_info
>>>>> +      * initialized yet. If we try to reserve bytes in this state (e.g. via
>>>>> +      * early sysfs writes), we must not crash.
>>>>> +      */
>>>>> +     if (unlikely(!space_info))
>>>>> +             return -EBUSY;
>>>>> +
>>>>>         if (flush == BTRFS_RESERVE_FLUSH_DATA)
>>>>>                 async_work = &fs_info->async_data_reclaim_work;
>>>>>         else
>>>>
>>


