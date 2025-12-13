Return-Path: <linux-btrfs+bounces-19718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE1CBB42C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 22:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E56A13002152
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 21:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA930ACF8;
	Sat, 13 Dec 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaishome.de header.i=@kaishome.de header.b="gEVL3c9G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672621EB5F8
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765662196; cv=none; b=qJfC9sCrE258arLW5MjCI1ZS1koRSku2b26+AiZvr/rMpKwz+WPOKNn3/Z1qUSzurFgI0j4UMRORaqrwPM4ScWVV3VkdrPRZyLjJAggwMxJNd4/vxNydlsesy7x7/6vBaljH8HCS3HNvwY5DbN3rzOfbVrwp1Vxn/TSQjFQ4heE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765662196; c=relaxed/simple;
	bh=V8x6oidsynV/qbJ7EfefKCJJV1Jy6DtMFQJlo5kQ6HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIzRMtDgAHsF9h7hhfLzUmuF4B8hGhM0Jupo+HReXB8FeA1tHlFRI+I+amJMJ+eyMoIEPJFTxJVX9bDOugyMfSPU1thjS/kkeDtIXw2zCnTf00fGK0sn8QOG2kJUY4N4dzz/0Rwa0rW8CvwnZC/YylWdz24PGXGIpSNAdeF42DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaishome.de; spf=pass smtp.mailfrom=kaishome.de; dkim=pass (1024-bit key) header.d=kaishome.de header.i=@kaishome.de header.b=gEVL3c9G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaishome.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaishome.de
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a637712so15460545e9.1
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 13:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaishome.de; s=google; t=1765662193; x=1766266993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFdOtytyw3foFplAt83NM0JeU8jbTg4yqE2aCOCEMH0=;
        b=gEVL3c9GksRRXKsu9yBnnFgRVyO2VSB3i3woIYsewWauopFZZ0MPCDdbaInRxZrwTq
         fdOYwbtH3xWMuShjhGbe2e+RQMocJXsx2gny4qgKrCP398dsVnIkOvsReAcQCbhDlkZa
         CYFm7dd0HwxT9LqzJJsavWwgzV2GNo+qVtqpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765662193; x=1766266993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFdOtytyw3foFplAt83NM0JeU8jbTg4yqE2aCOCEMH0=;
        b=Q5bsl9j4lpXhh0ELq8MHt5QGCPCwHYGRnCWhwj4TIzU2JPPqUs2x0IAibP/GP8bIj6
         kPobNVl0C1XCfnuwKJaS+OCfwJWU4kfpLvEHQxq+pmm5L9x8IJEldqm03Ew54NX/INLw
         0Foa+hY3zDNMcTXse4whjOQjVmlqiY4Xnok4oEmWBH7c7vZNFprLA3C5/IIQ1BKk5J/f
         yER+y2eHq/PY+pT/aiA/KTvgy6g7ugpLOnXgSgylydldOoi1B27oePWEoz+g6GcLli+C
         sGcTr4EKFnI2mjImhepPg2GVuydviMZid8iGD8U4plX2F2hnAImzCIso2pNOm6ju5phR
         8JJg==
X-Gm-Message-State: AOJu0YznDWatpj0nlp3SUf9GPoEBe+ePlCsJt3ZWCoFQQg5ONhe7tECg
	aQZ4tqVqomumRJevJFYXjqbtEAomEZJVQ5W6umnXtB+LHHJAvMUPPI1MVBnA75mKwpPTjVqS1uz
	hnJN0m+qJorUekP0kMwut3kfcFxyiiufHTdOp3++nBQ==
X-Gm-Gg: AY/fxX4rg8E+3kPG0qEDCl4HuAaJagNjgvYlngOs8n/ufLjWY3MAqBgfjXokEoxb+a3
	PRkoQvEkiKUg5DW20Bt2eEHw3BP5FXhTJSWbL+at6TFMmG//DujTT3f2fjaZuji2UCEfhqywrL0
	ZGpmu2FhF009Syftt8VqbXyvU/QrL4Os4ZFWNwrNItEoYFGGy4ZlWuHuGue8mRfi2WXDki0vxiF
	0QMKcg1pCdrp87TXpEkM8arXNejYwYUC3n6pvny8BdFLrh1GxIIr8m0/6WVhHiHy1yC56Av0lMd
	VNvplW5X0eodHQAgHceI8ns/VkJp
X-Google-Smtp-Source: AGHT+IGey+oQlq0fPPoHPE8ThZql3844BHfqY966iFUUtvqw7LukMiHI1ydkZfOrD1hw9PI1O+X+Ue/Pqm7aFa2kfec=
X-Received: by 2002:a05:600c:3492:b0:477:9392:8557 with SMTP id
 5b1f17b1804b1-47a8f905983mr61214165e9.18.1765662192576; Sat, 13 Dec 2025
 13:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213200920.1808679-1-kai@kaishome.de> <350e9b44-7a16-4c3f-a54f-5b6b3f4931f3@suse.com>
 <CAC2ZOYtgvzThSVX7tsajF=czm3JaYzpKjCsJB72Tw3_35Notzw@mail.gmail.com> <4a4c04ff-3855-467c-af75-77c6ddf27098@suse.com>
In-Reply-To: <4a4c04ff-3855-467c-af75-77c6ddf27098@suse.com>
From: Kai Krakow <kai@kaishome.de>
Date: Sat, 13 Dec 2025 22:43:01 +0100
X-Gm-Features: AQt7F2rOno9Q5l5Bbbm0-o0mGldU-pdzg1zXJ9Ml3FR9hkB_iAYpREfyMicNXl0
Message-ID: <CAC2ZOYvY1x-vx9rUs-tZ2J_oHjX-pj7C1muFwvnH5NHSHn0ntw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: harden __reserve_bytes() with space_info==NULL
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Eli Venter <eli@genedx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Sa., 13. Dez. 2025 um 22:15 Uhr schrieb Qu Wenruo <wqu@suse.com>:
>
>
>
> =E5=9C=A8 2025/12/14 07:40, Kai Krakow =E5=86=99=E9=81=93:
> > Hello Qu!
> >
> > Am Sa., 13. Dez. 2025 um 21:48 Uhr schrieb Qu Wenruo <wqu@suse.com>:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/12/14 06:39, Kai Krakow =E5=86=99=E9=81=93:
> >>> During mount, the global block reserve might not have its space_info
> >>> initialized yet. If we try to reserve bytes in this state (e.g. via
> >>> early sysfs writes), we must not crash.
> >>>
> >>> This happened while developing patches which allow modification of th=
e
> >>> devinfo.type field via sysfs. If this write access is executed by the
> >>> user before the mount finished, the kernel crashed with a NULL pointe=
r
> >>> dereference:
> >>
> >>
> >> I'd say the modification through sysfs itself is a dangerous idea, it
> >> will need to hold the proper locks and if not properly checked can
> >> easily introduce unexpected races.
> >>
> >>
> >> Furthermore currently there is no RW support for devinfo related membe=
r.
> >>
> >> So this means your patch is fixing something that is only affecting yo=
ur
> >> out-of-tree development branch, which is not bringing much usefulness =
to
> >> upstream.
> >>
> >> Thanks,
> >> Qu
> >
> > Okay, thanks. I understand your argumentation. I almost expected that
> > this won't be accepted because it is triggered by out-of-tree code.
> >
> > In case, you'd like to see the code causing this:
> > https://gist.github.com/kakra/8ccdcb96ca8426b95bcd86c7e0b5115e
> >
> > It's part of Goffredo's "allocator hint" patches which I rebased to 6.1=
8.
> >
> > As you may see, I already guarded the call with:
> >
> > if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags)) return -EBUSY;
>
> Currently the RW sysfs interfaces follows the pattern that no
> transaction is triggered from sysfs write context.
>
> I strongly doubt if it's a good idea to trigger a transaction without
> any VFS checks.
>
> So if you really want to change a member, do a proper in-memory update
> only, and find a way (e.g. a new dirty dev list) to tell the fs to
> update the device item at commit time.

I don't want to steal your time, but is this a better approach?
https://gist.github.com/kakra/aa3eb8473cc05c1d3dd000160a5ee481

Thanks,
Kai

> It's much safer and avoid a new and untested direct way to trigger
> metadata modification.
>
> Thanks,
> Qu
>
> >
> > So I should be safe there even without this patch.
> >
> > Thanks,
> > Kai
> >
> >>>> Noticed an oops with these patches when doing echo 1 >devinfo/2/type
> >>>> while mount is still ongoing. My btrfs is big so the mount takes
> >>>> 20-30 minutes. Reboot and wait until mount is complete and this
> >>>> worked fine.
> >>>
> >>> BUG: kernel NULL pointer dereference, address: 0000000000000008
> >>> PGD 0 P4D 0
> >>> Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
> >>> CPU: 4 UID: 0 PID: 3520 Comm: bash Not tainted 6.12.52-dirty #2
> >>> Hardware name: Penguin Computing Relion 1900/MD90-FS0-ZB-XX, BIOS R15=
 06/25/2018
> >>> RIP: 0010:_raw_spin_lock+0x17/0x30
> >>> Code: 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f =
1e fa 0f 1f 44 00 00 65 ff 05 e8 c0 d8 5e 31 c0 ba 01 00 00 00 0f b1 17 75 =
05 c3 cc cc cc cc 89 c6 e9 97 01 00 00 0f 1f 80 00
> >>> RSP: 0018:ffffbc13a95837c8 EFLAGS: 00010246
> >>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> >>> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
> >>> RBP: 0000000000000008 R08: ffffbc13a9583a07 R09: 0000000000000001
> >>> R10: d800000000000000 R11: 0000000000000001 R12: ffff9bee913db000
> >>> R13: 0000000000000000 R14: 00000000fffffffb R15: ffff9bee913db000
> >>> FS: 00007fd6e270f740(0000) GS:ffff9bfddfc00000(0000) knlGS:0000000000=
000000
> >>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 0000000000000008 CR3: 00000008d9986004 CR4: 00000000003706f0
> >>> Call Trace:
> >>>
> >>> __reserve_bytes+0x70/0x720 [btrfs]
> >>> ? get_page_from_freelist+0x343/0x1570
> >>> btrfs_reserve_metadata_bytes+0x1d/0xd0 [btrfs]
> >>> btrfs_use_block_rsv+0x153/0x220 [btrfs]
> >>> btrfs_alloc_tree_block+0x83/0x580 [btrfs]
> >>> btrfs_force_cow_block+0x129/0x620 [btrfs]
> >>> btrfs_cow_block+0xcd/0x230 [btrfs]
> >>> btrfs_search_slot+0x566/0xd60 [btrfs]
> >>> ? kmem_cache_alloc_noprof+0x106/0x2f0
> >>> btrfs_update_device+0x91/0x1d0 [btrfs]
> >>> btrfs_devinfo_type_store+0xb8/0x140 [btrfs]
> >>> kernfs_fop_write_iter+0x14c/0x200
> >>> vfs_write+0x289/0x440
> >>> ksys_write+0x6d/0xf0
> >>> trace_clock_x86_tsc+0x20/0x20
> >>> ? do_wp_page+0x838/0xf90
> >>> ? __do_sys_newfstat+0x68/0x70
> >>> ? __pte_offset_map+0x1b/0xf0
> >>> ? __handle_mm_fault+0xa6c/0x10f0
> >>> ? __count_memcg_events+0x53/0xf0
> >>> ? handle_mm_fault+0x1c4/0x2d0
> >>> ? do_user_addr_fault+0x334/0x620
> >>> ? arch_exit_to_user_mode_prepare.isra.0+0x11/0x90
> >>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>> RIP: 0033:0x7fd6e27a1687
> >>> Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 =
f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1=
f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> >>> RSP: 002b:00007ffecb401260 EFLAGS: 00000202 ORIG_RAX: 000000000000000=
1
> >>> RAX: ffffffffffffffda RBX: 00007fd6e270f740 RCX: 00007fd6e27a1687
> >>> RDX: 0000000000000002 RSI: 0000557a2c38ad20 RDI: 0000000000000001
> >>> RBP: 0000557a2c38ad20 R08: 0000000000000000 R09: 0000000000000000
> >>> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> >>> R13: 00007fd6e28fa5c0 R14: 00007fd6e28f7e80 R15: 0000000000000000
> >>>
> >>> Modules linked in: rpcsec_gss_krb5 nfsv3 nfsv4 dns_resolver nfs netfs=
 zram lz4hc_compress lz4_compress dm_crypt bonding tls ipmi_ssif intel_rapl=
_msr nfsd binfmt_misc auth_rpcgss nfs_acl lockd grace intel_rapl_common int=
el_uncore_frequency intel_uncore_frequency_common sb_edac x86_pkg_temp_ther=
mal intel_powerclamp coretemp rapl intel_cstate s>
> >>> intel_pmc_bxt ixgbe ehci_pci iTCO_vendor_support xfrm_algo gf128mul l=
ibata mpt3sas xhci_hcd ehci_hcd watchdog crypto_simd mdio_devres libphy cry=
ptd raid_class usbcore scsi_transport_sas mdio igb scsi_mod wmi usb_common =
i2c_i801 lpc_ich scsi_common i2c_smbus i2c_algo_bit dca
> >>> CR2: 0000000000000008
> >>> ---[ end trace 0000000000000000 ]---
> >>> RIP: 0010:_raw_spin_lock+0x17/0x30
> >>> Code: 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f =
1e fa 0f 1f 44 00 00 65 ff 05 e8 c0 d8 5e 31 c0 ba 01 00 00 00 0f b1 17 75 =
05 c3 cc cc cc cc 89 c6 e9 97 01 00 00 0f 1f 80 00
> >>> RSP: 0018:ffffbc13a95837c8 EFLAGS: 00010246
> >>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> >>> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
> >>> RBP: 0000000000000008 R08: ffffbc13a9583a07 R09: 0000000000000001
> >>> R10: d800000000000000 R11: 0000000000000001 R12: ffff9bee913db000
> >>> R13: 0000000000000000 R14: 00000000fffffffb R15: ffff9bee913db000
> >>> FS: 00007fd6e270f740(0000) GS:ffff9bfddfc00000(0000) knlGS:0000000000=
000000
> >>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 0000000000000008 CR3: 00000008d9986004 CR4: 00000000003706f0
> >>>
> >>> Reported-by: Eli Venter <eli@genedx.com>
> >>> Signed-off-by: Kai Krakow <kai@kaishome.de>
> >>> ---
> >>>    fs/btrfs/space-info.c | 8 ++++++++
> >>>    1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> >>> index 97452fb5d29b..cbb6c4924850 100644
> >>> --- a/fs/btrfs/space-info.c
> >>> +++ b/fs/btrfs/space-info.c
> >>> @@ -1752,6 +1752,14 @@ static int __reserve_bytes(struct btrfs_fs_inf=
o *fs_info,
> >>>                ASSERT(flush !=3D BTRFS_RESERVE_FLUSH_EVICT);
> >>>        }
> >>>
> >>> +     /*
> >>> +      * During mount, the global block reserve might not have its sp=
ace_info
> >>> +      * initialized yet. If we try to reserve bytes in this state (e=
.g. via
> >>> +      * early sysfs writes), we must not crash.
> >>> +      */
> >>> +     if (unlikely(!space_info))
> >>> +             return -EBUSY;
> >>> +
> >>>        if (flush =3D=3D BTRFS_RESERVE_FLUSH_DATA)
> >>>                async_work =3D &fs_info->async_data_reclaim_work;
> >>>        else
> >>
>

