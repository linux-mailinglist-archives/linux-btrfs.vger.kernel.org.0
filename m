Return-Path: <linux-btrfs+bounces-8201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFF89847DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D91C1C22E3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A91AAE0F;
	Tue, 24 Sep 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FhKmOCdJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775848CFC
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188909; cv=none; b=SwohVTcTL9h7aLZ7GOhoH4mN4vfEfblVsXtV81vbOLG5czSaLNxPQp8lSN98oLPzxTLuRWTCgUb6wTXaOiPG6wYEmve4fKIMijP5XNGBkS/LY8K/j1iq587KtF9A4S0HtwFH0zphuW2ZCkbu/WYpcdUqkgLsnOMonQW7XPuyYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188909; c=relaxed/simple;
	bh=OqA0IMlvwrNjuLJlvQUET9aK7hxiw/Amq9NDIlr1/Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l14qS1bO7iXnCW+0gerZahvuecYMBkOrVKUxDnd4uZWdfAzGa8KtWjChum6xRRe2Hs6hUihLLjwkpj2iMHf6UDgIQItqGMrWyT770qlrj44Gc0xbTVahiEwaXz5xXXvOwYUiMrbAKaT478rgp+KwigvhdBKDXOUhA9jL33KVbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FhKmOCdJ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c524b4a3aeso43189066d6.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727188905; x=1727793705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ih4vZ3uH9UBnPLRjGzcAGmpUvGWchVEvW/CoKCB7JZI=;
        b=FhKmOCdJ+kXzaRI/HUKM0zNRgDoKyo8W87UkIzCkJg2Dso0+7swRxfUHeXioWG0PGW
         bdUS0aBf1mPxzAPtSmqeayNqFTCLaeNSUaaeqq+K0EoOqXRMb1nSzVbbtgbiB2gzmmz1
         gFLGxVQ279tnJMadgm4Isrne/sN+4L3RvdR6m3avhBSrxpyG+M51v0FXjbxr6rIMT0tz
         BWPPz0lU0f6LIUcWtcra4FTmVNu8tLggOrf91MBOee/mzVgaxmJ9Y1Wxgu28/u5ij7dL
         xvaPpEXstdmxOK2m1QWxlrrktJL86+ehajs2L0RcOD09fqZkZwf/Zncho5+WoraFJ0u1
         56hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727188905; x=1727793705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih4vZ3uH9UBnPLRjGzcAGmpUvGWchVEvW/CoKCB7JZI=;
        b=HR59VZgSNjVpK1vChVVDlv0TmhxDGzO/HvBFZ0RWmKYVpFF3FPipUUYOFWAgbpnuE7
         OYF0vz7QcJv+xXXVfizvbDTffHmGZbVU39GY4jJnW5/BReuFOUPETOOR368tt9HN2sxk
         qatKogxBlt4qePFXg+SpFN1sBsMtgrMa0qxCmwWd3FgTbXIjuVnVo9pSZJiA0HK+8IHL
         XdcjHjX+FSeutIr0fRRvHfcZDBIfIX+youvQ+Z49N1eeaKp/9ZnaQEJCr0vfsBX/5Ko5
         t/xW1pN8m7Tf9zDGHZjxpk+GqeMdBDizoyZTgWOgjFS8z2557RSxHd0VZ50FHaTz+9KT
         pPGQ==
X-Gm-Message-State: AOJu0Yy4H0FdYLUY1nJdbT1k8MLYTArxYuyRAfXmsxFjroDz8S0rOgTK
	04wpQTTea1xmWDxT81p7zb8hd6wPJ8EHG5pUO0/n68SxPVtPX/lMVZeGEkmaI4jXudxka4z8oD6
	H
X-Google-Smtp-Source: AGHT+IE8iIQptz52UI7rqSh2ZQgCZFyUrVy/nyZtvO1QoJv57us5whUHF/eI53r/B4TSQyjI9xguEQ==
X-Received: by 2002:a05:6214:5987:b0:6c5:52fc:44fc with SMTP id 6a1803df08f44-6c7bd51f533mr262271096d6.30.1727188905378;
        Tue, 24 Sep 2024 07:41:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4e9e28sm7107926d6.74.2024.09.24.07.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:41:44 -0700 (PDT)
Date: Tue, 24 Sep 2024 10:41:43 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: fix buffer overflow detection when copying
 path to cache entry
Message-ID: <20240924144143.GB183026@perftesting>
References: <ee24884b0255f717071ca932bda1ab398707d9cf.1726782272.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee24884b0255f717071ca932bda1ab398707d9cf.1726782272.git.fdmanana@suse.com>

On Thu, Sep 19, 2024 at 10:50:52PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with commit c0247d289e73 ("btrfs: send: annotate struct
> name_cache_entry with __counted_by()") we annotated the variable length
> array "name" from the name_cache_entry structure with __counted_by() to
> improve overflow detection. However that alone was not correct, because
> the length of that array does not match the "name_len" field - it matches
> that plus 1 to include the nul string terminador, so that makes a
> fortified kernel think there's an overflow and report a splat like this:
> 
>    Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here ]------------
>    Sep 15 23:32:17 sdslinux1 kernel: strcpy: detected buffer overflow: 20
>    byte write of buffer size 19
>    Sep 15 23:32:17 sdslinux1 kernel: WARNING: CPU: 3 PID: 3310 at
>    __fortify_report+0x45/0x50
>    Sep 15 23:32:17 sdslinux1 kernel: Modules linked in: nfsd auth_rpcgss
>    lockd grace nfs_acl bridge stp llc bonding tls vfat fat binfmt_misc
>    snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common x8
>    6_pkg_temp_thermal intel_powerclamp kvm_intel iTCO_wdt intel_pmc_bxt
>    spi_intel_platform kvm at24 mei_wdt spi_intel mei_pxp
>    iTCO_vendor_support mei_hdcp btusb snd_hda_codec_realtek btbcm btinte
>    l snd_hda_scodec_component i915 rapl iwlwifi snd_hda_codec_generic btrtl
>    intel_cstate btmtk cec snd_hda_intel intel_uncore cfg80211
>    snd_intel_dspcfg drm_buddy coretemp snd_intel_sdw_acpi bluet
>    ooth ttm pcspkr snd_hda_codec rfkill snd_hda_core snd_hwdep intel_vbtn
>    snd_pcm mei_me drm_display_helper snd_timer sparse_keymap i2c_i801 mei
>    snd i2c_smbus lpc_ich soundcore cdc_mbim cdc_wdm cdc_ncm cdc_ether
>    usbnet crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
>    polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3
>    igb r8152 serio_raw i2c_algo_bit mii dca e1000e video wmi sunrpc
>    Sep 15 23:32:17 sdslinux1 kernel: CPU: 3 UID: 0 PID: 3310 Comm: btrfs
>    Not tainted 6.11.0-prnet #1
>    Sep 15 23:32:17 sdslinux1 kernel: Hardware name: CompuLab Ltd.
>    sbc-ihsw/Intense-PC2 (IPC2), BIOS IPC2_3.330.7 X64 03/15/2018
>    Sep 15 23:32:17 sdslinux1 kernel: RIP: 0010:__fortify_report+0x45/0x50
>    Sep 15 23:32:17 sdslinux1 kernel: Code: 48 8b 34 (...)
>    Sep 15 23:32:17 sdslinux1 kernel: RSP: 0018:ffff97ebc0d6f650 EFLAGS:
>    00010246
>    Sep 15 23:32:17 sdslinux1 kernel: RAX: 7749924ef60fa600 RBX:
>    ffff8bf5446a521a RCX: 0000000000000027
>    Sep 15 23:32:17 sdslinux1 kernel: RDX: 00000000ffffdfff RSI:
>    ffff97ebc0d6f548 RDI: ffff8bf84e7a1cc8
>    Sep 15 23:32:17 sdslinux1 kernel: RBP: ffff8bf548574080 R08:
>    ffffffffa8c40e10 R09: 0000000000005ffd
>    Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000004 R11:
>    ffffffffa8c70e10 R12: ffff8bf551eef400
>    Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000000 R14:
>    0000000000000013 R15: 00000000000003a8
>    Sep 15 23:32:17 sdslinux1 kernel: FS:  00007fae144de8c0(0000)
>    GS:ffff8bf84e780000(0000) knlGS:0000000000000000
>    Sep 15 23:32:17 sdslinux1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>    0000000080050033
>    Sep 15 23:32:17 sdslinux1 kernel: CR2: 00007fae14691690 CR3:
>    00000001027a2003 CR4: 00000000001706f0
>    Sep 15 23:32:17 sdslinux1 kernel: Call Trace:
>    Sep 15 23:32:17 sdslinux1 kernel:  <TASK>
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __warn+0x12a/0x1d0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
>    Sep 15 23:32:17 sdslinux1 kernel:  ? report_bug+0x154/0x1c0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? handle_bug+0x42/0x70
>    Sep 15 23:32:17 sdslinux1 kernel:  ? exc_invalid_op+0x1a/0x50
>    Sep 15 23:32:17 sdslinux1 kernel:  ? asm_exc_invalid_op+0x1a/0x20
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __fortify_report+0x45/0x50
>    Sep 15 23:32:17 sdslinux1 kernel:  __fortify_panic+0x9/0x10
>    Sep 15 23:32:17 sdslinux1 kernel: __get_cur_name_and_parent+0x3bc/0x3c0
>    Sep 15 23:32:17 sdslinux1 kernel:  get_cur_path+0x207/0x3b0
>    Sep 15 23:32:17 sdslinux1 kernel:  send_extent_data+0x709/0x10d0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? find_parent_nodes+0x22df/0x25d0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? mas_nomem+0x13/0x90
>    Sep 15 23:32:17 sdslinux1 kernel:  ? mtree_insert_range+0xa5/0x110
>    Sep 15 23:32:17 sdslinux1 kernel:  ? btrfs_lru_cache_store+0x5f/0x1e0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? iterate_extent_inodes+0x52d/0x5a0
>    Sep 15 23:32:17 sdslinux1 kernel:  process_extent+0xa96/0x11a0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_lookup_backref_cache+0x10/0x10
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_store_backref_cache+0x10/0x10
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_iterate_backrefs+0x10/0x10
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx_check_extent_item+0x10/0x10
>    Sep 15 23:32:17 sdslinux1 kernel:  changed_cb+0x6fa/0x930
>    Sep 15 23:32:17 sdslinux1 kernel:  ? tree_advance+0x362/0x390
>    Sep 15 23:32:17 sdslinux1 kernel:  ? memcmp_extent_buffer+0xd7/0x160
>    Sep 15 23:32:17 sdslinux1 kernel:  send_subvol+0xf0a/0x1520
>    Sep 15 23:32:17 sdslinux1 kernel:  btrfs_ioctl_send+0x106b/0x11d0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __pfx___clone_root_cmp_sort+0x10/0x10
>    Sep 15 23:32:17 sdslinux1 kernel:  _btrfs_ioctl_send+0x1ac/0x240
>    Sep 15 23:32:17 sdslinux1 kernel:  btrfs_ioctl+0x75b/0x850
>    Sep 15 23:32:17 sdslinux1 kernel:  __se_sys_ioctl+0xca/0x150
>    Sep 15 23:32:17 sdslinux1 kernel:  do_syscall_64+0x85/0x160
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __count_memcg_events+0x69/0x100
>    Sep 15 23:32:17 sdslinux1 kernel:  ? handle_mm_fault+0x1327/0x15c0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? __se_sys_rt_sigprocmask+0xf1/0x180
>    Sep 15 23:32:17 sdslinux1 kernel:  ? syscall_exit_to_user_mode+0x75/0xa0
>    Sep 15 23:32:17 sdslinux1 kernel:  ? do_syscall_64+0x91/0x160
>    Sep 15 23:32:17 sdslinux1 kernel:  ? do_user_addr_fault+0x21d/0x630
>    Sep 15 23:32:17 sdslinux1 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    Sep 15 23:32:17 sdslinux1 kernel: RIP: 0033:0x7fae145eeb4f
>    Sep 15 23:32:17 sdslinux1 kernel: Code: 00 48 89 (...)
>    Sep 15 23:32:17 sdslinux1 kernel: RSP: 002b:00007ffdf1cb09b0 EFLAGS:
>    00000246 ORIG_RAX: 0000000000000010
>    Sep 15 23:32:17 sdslinux1 kernel: RAX: ffffffffffffffda RBX:
>    0000000000000004 RCX: 00007fae145eeb4f
>    Sep 15 23:32:17 sdslinux1 kernel: RDX: 00007ffdf1cb0ad0 RSI:
>    0000000040489426 RDI: 0000000000000004
>    Sep 15 23:32:17 sdslinux1 kernel: RBP: 00000000000078fe R08:
>    00007fae144006c0 R09: 00007ffdf1cb0927
>    Sep 15 23:32:17 sdslinux1 kernel: R10: 0000000000000008 R11:
>    0000000000000246 R12: 00007ffdf1cb1ce8
>    Sep 15 23:32:17 sdslinux1 kernel: R13: 0000000000000003 R14:
>    000055c499fab2e0 R15: 0000000000000004
>    Sep 15 23:32:17 sdslinux1 kernel:  </TASK>
>    Sep 15 23:32:17 sdslinux1 kernel: ---[ end trace 0000000000000000 ]---
>    Sep 15 23:32:17 sdslinux1 kernel: ------------[ cut here ]------------
> 
> Fix this by not storing the nul string terminator since we don't actually
> need it for name cache entries, this way "name_len" corresponds to the
> actual size of the "name" array. This requires marking the "name" array
> field with __nonstring and using memcpy() instead of strcpy() as
> recommended by the guidelines at:
> 
>    https://github.com/KSPP/linux/issues/90
> 
> Reported-by: David Arendt <admin@prnet.org>
> Link: https://lore.kernel.org/linux-btrfs/cee4591a-3088-49ba-99b8-d86b4242b8bd@prnet.org/
> Fixes: c0247d289e73 ("btrfs: send: annotate struct name_cache_entry with __counted_by()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

