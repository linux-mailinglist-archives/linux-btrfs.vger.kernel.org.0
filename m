Return-Path: <linux-btrfs+bounces-7081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469EC94D9A1
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 02:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D681F22C38
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 00:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F94437A;
	Sat, 10 Aug 2024 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9SdsIAH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8243B1A4
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2024 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723251449; cv=none; b=Ygv+HWIgVxj7MT4/YIlaH0iiwWc6w5PMA7XrQ6xXhnGm/Ru0yy9601425ivIGM+cTAYXTaAjeDWqC2ezPdhjRXq7ZsU9sKN1ArNSrC2d0fynRtFXcowi7/CYuOrke5PO9B7R90BGJjEvrLbGh9fvsrwJRZWcU56jf2l3FG3nRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723251449; c=relaxed/simple;
	bh=Go2k8G4SX0Fz1DcB6goLCxGlv+oILub9PAxcLjq7ECg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZI+WJYrCUJaaE7g1APjOzYpgFMOccTtSWQcu5ui+FTtYv4lNmq37bO1PxfhhFFSWNV6qyJio4re/Y2iBvcLKhocGzcmRR3OO7f0Qd5BUGWJWaIXx618vI9lq3l5MEuMG1MSQNHs1RkVg4li28ncmU64HlFTHD4Q0PrQ3exiWkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9SdsIAH; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-823227e7572so2235059241.1
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2024 17:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723251447; x=1723856247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8nkAw5HON5nlvuf1NYyl2IY357pzJAy3/mytwvvcjE=;
        b=J9SdsIAHrXapfnN2zRm8Zc9aF5OaIikvfHMui7fVl4kMPQW4iVFCUFcoJfMfQo2wM1
         e9gBSCWU2xzxgPQKsxAJfbt9eBGzsaade8bOnEj3G+NbM4LfNZcRIPgsEH7tRyQPa5Q2
         5CRhALQwfr1fMgPdwSKEolIUfOQx6IVUs75ZamH75aK2a/WmWSgDXQFMeEA2Ibl/ax4s
         EsLbroVhQgRzDUOPMeckKCnGnBog+M82etbSBmCp2DWtoJ6Z74yhriWHeT3Lx05uqB5e
         LCMw4Rgk7DxLtAtkAC6wL2f9aGUwFDbldTKEYKe/AJTG38laELS09UtmJRIlYF1TKU53
         MANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723251447; x=1723856247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8nkAw5HON5nlvuf1NYyl2IY357pzJAy3/mytwvvcjE=;
        b=qWwV2i58wdp8zzHeQhtERwrXNN9UOdZRdub9yeay6Rs/LpB4ta46QC2w0b0veqkgpb
         VcZTGxJTTpRZKQ0nON2gFAbZLxN1u554JjI2SWEtnoPLPuy2i08aLdOlSOpTByoZKnyl
         p7BhzckRdzDS+h6ZBdyu6xXptHBo3iY3jy7+olvSr9qwdborE43cC1Yr4m3lUyLZzoFl
         yBnzK7UTlhCq/48Lz5xkGIGAxsxp3mVcnHk/PwGdrv6YrLt0WTrgb4bOXSqacXLToy7S
         v8JRgSZHNba3E3ovdymYQIvMbqBLRCuybyBzZbBtJLJMhSVk9c4C8DShL1k06JW4HpyX
         J1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU5gbr8dbEyudEaiZu+Mbb/TRsVun7AqAmGZ0FY5SDaVxgVQMCSB0HmZ/YOi8G+qZv0ByOCwrmIrjJB4+xrsERGxGIhIEzpDNw/Zs=
X-Gm-Message-State: AOJu0Yw/dY0YP/77yGttCvhXNZxfIlH6oQN5NpQbsW+r4FWWK/GBMpmY
	Vg184KxwmLndvx1aaU2KUkl04yF7pFvaRbAmPZ2Rpmc7JFV6rW9Koethyp5jJnpwJDBdg0Ef6++
	NBeF8Id6KtkzlEpvnEDfGCn/ANNU=
X-Google-Smtp-Source: AGHT+IFB2dwGNCe+Jgi577iLFq1lNYJwPzbQpOhx4gR4wW2I29v2CEujrshMYohiFHYdXDm73LNboZQNgf8RW4mP23w=
X-Received: by 2002:a05:6102:b12:b0:493:eff7:3122 with SMTP id
 ada2fe7eead31-495d8c8e17fmr2483835137.9.1723251446925; Fri, 09 Aug 2024
 17:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPNGSSt-a4ZZWrtJdVyYnJFscFjP9S7rMcvEMaNSpR556DdLA@mail.gmail.com>
 <CAHPNGSTZJW9Rn2Aac=PhjSTiDYX_wc3DwtK=QkiHh-haShBybQ@mail.gmail.com> <CAL3q7H4jcWK9AnJ=T+U84Rq9dmJXmpdGyN10oBqFdw7JCqLmew@mail.gmail.com>
In-Reply-To: <CAL3q7H4jcWK9AnJ=T+U84Rq9dmJXmpdGyN10oBqFdw7JCqLmew@mail.gmail.com>
From: Octavia Togami <octavia.togami@gmail.com>
Date: Fri, 9 Aug 2024 17:57:15 -0700
Message-ID: <CAHPNGSQGA9OAj5xTOv6DOnGpbLjt7yoqNhN98L1wsmuAkQg86w@mail.gmail.com>
Subject: Re: [REGRESSION] bisected: btrfs: spin locks way too much when
 accessing many files concurrently
To: Filipe Manana <fdmanana@kernel.org>
Cc: Octavia Togami <octavia.togami@gmail.com>, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, I wasn't aware of that. I've uploaded here:
https://gist.githubusercontent.com/octylFractal/3823b25fc154f99fb4dc610195c=
54b5d/raw/d587038eaec217c337c3b602d6f10483cd955eb3/perf-report.txt

I will test the patches ASAP and comment on the bug tracker with my results=
.

On Fri, Aug 9, 2024 at 4:55=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Fri, Aug 9, 2024 at 11:53=E2=80=AFPM Octavia Togami <octavia.togami@gm=
ail.com> wrote:
> >
> > Oh, I did forget I also captured a `perf report` for this:
> > https://nextcloud.octyl.net/s/xmbGAziwTCjRLnc
>
> It's more useful if you provided the output of "perf report", because
> with a different kernel version or compiled with different config and
> settings, the name resolution fails:
>
> $ perf report
> No kallsyms or vmlinux with build-id
> 8c3b2978a6fc575ae62885e359d781865efe6a0f was found
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 40K of event 'cycles:P'
> # Event count (approx.): 1771180105130
> #
> # Children      Self  Command  Shared Object
>         Symbol
> # ........  ........  .......
> ..............................................
> ..................................................
> #
>     94.38%     0.01%  rg       [kernel.kallsyms]
>         [k] 0xffffffff9900012f
>             |
>              --94.38%--0xffffffff9900012f
>                        |
>                         --94.14%--0xffffffff98e464b2
>                                   |
>                                   |--82.08%--0xffffffff9842eb0d
>                                   |          |
>                                   |           --81.96%--0xffffffff9842dcb=
9
>                                   |                     |
>                                   |
> |--79.91%--0xffffffff983127d0
> (...)
>
> So in the future please paste the output of "perf report" too.
>
> Thanks.
>
> >
> > On Fri, Aug 9, 2024 at 3:45=E2=80=AFPM Octavia Togami <octavia.togami@g=
mail.com> wrote:
> > >
> > > [1.] One line summary of the problem: BTRFS spin locks way too much
> > > when accessing many files concurrently
> > > [2.] Full description of the problem/report:
> > >
> > > Accessing many files concurrently at once causes BTRFS to spin lock
> > > too much and basically lock up all other processes for seconds at a
> > > time.
> > >
> > > Mostly happens when accessing their content, not the other metadata.
> > >
> > > This appears to be a performance regression since v6.9. I bisected to
> > > this commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git/commit/?id=3D956a17d9d050761e34ae6f2624e9c1ce456de204
> > >
> > > The commit before this one has no issues, this one reliably reproduce=
s
> > > the issue for me.
> > >
> > > [3.] Keywords (i.e., modules, networking, kernel): btrfs, spin_lock,
> > > super_cache_scan
> > > [4.] Kernel information
> > > [4.1.] Kernel version (from /proc/version): Linux version
> > > 6.10.3-arch1-1 (linux@archlinux) (gcc (GCC) 14.2.1 20240802, GNU ld
> > > (GNU Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Sun, 04 Aug 2024
> > > 05:11:32 +0000
> > > [4.2.] Kernel .config file:
> > > https://gist.github.com/octylFractal/1344722b55f0a9eef4fc22fcfcc34177
> > > [5.] Most recent kernel version which did not have the bug: v6.9
> > > [6.] Output of Oops.. message (if applicable) with symbolic informati=
on
> > >      resolved (see Documentation/admin-guide/bug-hunting.rst): N/A
> > > [7.] A small shell script or example program which triggers the
> > >      problem (if possible): Not possible as it appears to need a
> > > specific set of data and/or an NVMe-speed drive (1-2GB/s). I was usin=
g
> > > `rg --no-ignore uncommon-phrase ~/Documents/` but it didn't appear to
> > > work in QEMU or on a different drive, only when using my NVMe SSD. I
> > > have 1,425,292 files comprising 424GB in my `~/Documents`.
> > > [8.] Environment
> > > [8.1.] Software (add the output of the ver_linux script here)
> > > Linux Draconnet 6.10.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 24 Jul 202=
4
> > > 22:25:43 +0000 x86_64 GNU/Linux
> > >
> > > GNU C                   14.1.1
> > > GNU Make                4.4.1
> > > Binutils                2.42.0
> > > Util-linux              2.40.2
> > > Mount                   2.40.2
> > > Module-init-tools       32
> > > E2fsprogs               1.47.1
> > > Jfsutils                1.1.15
> > > Reiserfsprogs           3.6.27
> > > Xfsprogs                6.9.0
> > > PPP                     2.5.0
> > > Bison                   3.8.2
> > > Flex                    2.6.4
> > > Linux C++ Library       6.0.33
> > > Linux C++ Library       5.0.7
> > > Dynamic linker (ldd)    2.40
> > > Procps                  4.0.4
> > > Net-tools               2.10
> > > Kbd                     2.6.4
> > > Console-tools           2.6.4
> > > Sh-utils                9.5
> > > Udev                    256
> > > Wireless-tools          30
> > > Modules Loaded          aesni_intel af_alg algif_hash algif_skcipher
> > > amd_atl amdgpu amdxcp asus_wmi blake2b_generic bluetooth bnep bridge
> > > btbcm btintel btmtk btrfs btrtl b
> > > tusb ccp cec cmac crc16 crc32c_generic crc32c_intel crc32_pclmul
> > > crct10dif_pclmul cryptd crypto_simd crypto_user dm_mod drm_buddy
> > > drm_display_helper drm_exec drm_suballoc_
> > > helper drm_ttm_helper eeepc_wmi enclosure ext4 fat gf128mul
> > > ghash_clmulni_intel gpio_amdpt gpio_generic gpu_sched hid_generic
> > > hwmon_vid i2c_algo_bit i2c_dev i2c_piix4 i804
> > > 2 intel_rapl_common intel_rapl_msr ip_tables jbd2 jfs joydev kvm
> > > kvm_amd ledtrig_timer libcrc32c libphy llc loop mac_hid mbcache mc
> > > mdio_devres mousedev nct6775 nct6775_co
> > > re nf_conntrack nf_defrag_ipv4 nf_defrag_ipv6 nf_nat nfnetlink
> > > nf_reject_ipv4 nf_tables nft_chain_nat nft_compat nft_ct nft_masq
> > > nft_reject nft_reject_ipv4 nilfs2 nls_iso8
> > > 859_1 nls_ucs2_utils nvidia nvidia_drm nvidia_modeset nvidia_uvm nvme
> > > nvme_auth nvme_core pkcs8_key_parser platform_profile polyval_clmulni
> > > polyval_generic r8169 raid6_pq
> > > rapl realtek rfcomm rfkill scsi_transport_sas serio ses sg sha1_ssse3
> > > sha256_ssse3 sha512_ssse3 snd snd_hda_codec snd_hda_codec_generic
> > > snd_hda_codec_hdmi snd_hda_codec_re
> > > altek snd_hda_core snd_hda_intel snd_hda_scodec_component snd_hrtimer
> > > snd_hwdep snd_intel_dspcfg snd_intel_sdw_acpi snd_pcm snd_seq
> > > snd_seq_device snd_seq_dummy snd_timer
> > > soundcore sp5100_tco sparse_keymap stp ttm tun uas uinput usbhid usbl=
p
> > > usb_storage uvc uvcvideo vfat video videobuf2_common videobuf2_memops
> > > videobuf2_v4l2 videobuf2_vmall
> > > oc videodev wacom wmi wmi_bmof xfs xhci_pci xhci_pci_renesas xor
> > > x_tables xt_conntrack xt_mark xt_MASQUERADE xt_tcpudp zenpower
> > >
> > > [8.2.] Processor information (from /proc/cpuinfo):
> > > https://gist.github.com/octylFractal/1dcb65816561aab9205fce590ec85e59
> > > [8.3.] Module information (from /proc/modules):
> > > https://gist.github.com/octylFractal/9c78960190b12e3634ae87e895858cb2
> > > [8.4.] Loaded driver and hardware information (/proc/ioports,
> > > /proc/iomem): https://gist.github.com/octylFractal/40a9f67dbaabac78cd=
2d03028dd994f7
> > > [8.5.] PCI information ('lspci -vvv' as root):
> > > https://gist.github.com/octylFractal/325a0f211094ff11643c16f1d1f63362
> > > [8.6.] SCSI information (from /proc/scsi/scsi):
> > > Attached devices:
> > > Host: scsi4 Channel: 00 Id: 00 Lun: 00
> > >  Vendor: ATA      Model: CT4000MX500SSD1  Rev: 045
> > >  Type:   Direct-Access                    ANSI  SCSI revision: 05
> > > [8.7.] Other information that might be relevant to the problem
> > >        (please look in /proc and include all information that you
> > >        think to be relevant): The NVMe SSD I'm using is a WDS100T3X0C=
-00SJG0.
> > >
> > > #regzbot introduced: 956a17d9d050761e34ae6f2624e9c1ce456de204
> >

