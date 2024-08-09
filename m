Return-Path: <linux-btrfs+bounces-7080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC4194D951
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 01:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2373FB22116
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 23:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570E216D9C0;
	Fri,  9 Aug 2024 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQwItig3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F72716D9AF
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247726; cv=none; b=MzhJu6ieGyfONWG9r0GU2246xVhu8Z1er3njyYMohC0nE6WqT45dHxssZzjmdu5n9TSFEniVhcnuk1nMc5XHLSueMbZfFZdHI5L8mbVU19bSIwOhOIGnJRiuDMLCvd44je5L/gXWuGYFZ3hI5BzdwqrShmXvT2PEHfZoWymHPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247726; c=relaxed/simple;
	bh=rKsx7Fz0PxnHu+sT4TiSMkyOkBuqjHkz00zTrLT8Qnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qg1FVuWPp9nfA9Z5qyDDaqTksisfWpLXL/y2Ok46fDMf3MTMbqzj9uTdd6a5rjleo5dVB+ZkRFCJqXxITtDTK6/X4QfNPKK3K9vblfhL7yxNTJRJI9mLq4DdCMEUPXQU7J24ygFyjy/28EFHdFz3MVwrs7Sep3GTYGyewm7lBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQwItig3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED41C4AF0F
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 23:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723247726;
	bh=rKsx7Fz0PxnHu+sT4TiSMkyOkBuqjHkz00zTrLT8Qnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FQwItig32NNMSD+fxs3+kkW6h0l6aJM3qM6sAOI79L5+ygT2AaM1+Wl6qJ+GTo54V
	 fsurvafXIaJWS7h3cpEOfTtPD8IajQxHve7GhOHbqCmdjhBJe86nKiGFUAylGubtXE
	 bsj/n0QJmkyIHCTgeLDUPUKDhe66WD/APnWez+zDG2wIkvab9lZrU/INVk7PbMasVx
	 JE2xkrJ65XA3D4okE39JmEc/cL2PirSZ2KZwzRwZWA9AY2hAHWBBqqdOZnsY/9tbA6
	 ttTtOAUeCQnJfVinnpkE/isQLy4YEEVw+BZJEu1QXjafN2qlwuEXIApfyMqYNLxbWX
	 z6DPFrcHqb5Xw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so3089356a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2024 16:55:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIYneMiaehmQPfZNhSnS9NZ0Pk8goZ+m47pjmfgxZOXfVjnpfM7tWZgN4LjBorR68UwP9FSxvnlPG0Hqt2POcfkXp4NqP2xN9jzNo=
X-Gm-Message-State: AOJu0YwiATdCHhiVagxcUczoffWnul1uL583k6zssmvLclBMiPaP8x3s
	j5+e3SKwUeKTCleu0RjIDO1h1LMAgQk9ootOHdaXmRTHqW/84W5opXaLmtHANXjhU59dysYCLaf
	2G+4rsl+C1+XU5jZrDuXzDBlC55U=
X-Google-Smtp-Source: AGHT+IGiqvhNUKXKmRDp+aCihfOXS14A5erPwb8sKFVybqBZ8a28N9mlsgoOpqhOOYC+d+N5IK8qMAv+sE1i9E8yQEE=
X-Received: by 2002:a17:907:c7d2:b0:a7a:8876:4427 with SMTP id
 a640c23a62f3a-a80aa59b6b6mr236626666b.25.1723247724572; Fri, 09 Aug 2024
 16:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPNGSSt-a4ZZWrtJdVyYnJFscFjP9S7rMcvEMaNSpR556DdLA@mail.gmail.com>
 <CAHPNGSTZJW9Rn2Aac=PhjSTiDYX_wc3DwtK=QkiHh-haShBybQ@mail.gmail.com>
In-Reply-To: <CAHPNGSTZJW9Rn2Aac=PhjSTiDYX_wc3DwtK=QkiHh-haShBybQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 10 Aug 2024 00:54:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4jcWK9AnJ=T+U84Rq9dmJXmpdGyN10oBqFdw7JCqLmew@mail.gmail.com>
Message-ID: <CAL3q7H4jcWK9AnJ=T+U84Rq9dmJXmpdGyN10oBqFdw7JCqLmew@mail.gmail.com>
Subject: Re: [REGRESSION] bisected: btrfs: spin locks way too much when
 accessing many files concurrently
To: Octavia Togami <octavia.togami@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 11:53=E2=80=AFPM Octavia Togami <octavia.togami@gmai=
l.com> wrote:
>
> Oh, I did forget I also captured a `perf report` for this:
> https://nextcloud.octyl.net/s/xmbGAziwTCjRLnc

It's more useful if you provided the output of "perf report", because
with a different kernel version or compiled with different config and
settings, the name resolution fails:

$ perf report
No kallsyms or vmlinux with build-id
8c3b2978a6fc575ae62885e359d781865efe6a0f was found
# To display the perf.data header info, please use
--header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 40K of event 'cycles:P'
# Event count (approx.): 1771180105130
#
# Children      Self  Command  Shared Object
        Symbol
# ........  ........  .......
..............................................
..................................................
#
    94.38%     0.01%  rg       [kernel.kallsyms]
        [k] 0xffffffff9900012f
            |
             --94.38%--0xffffffff9900012f
                       |
                        --94.14%--0xffffffff98e464b2
                                  |
                                  |--82.08%--0xffffffff9842eb0d
                                  |          |
                                  |           --81.96%--0xffffffff9842dcb9
                                  |                     |
                                  |
|--79.91%--0xffffffff983127d0
(...)

So in the future please paste the output of "perf report" too.

Thanks.

>
> On Fri, Aug 9, 2024 at 3:45=E2=80=AFPM Octavia Togami <octavia.togami@gma=
il.com> wrote:
> >
> > [1.] One line summary of the problem: BTRFS spin locks way too much
> > when accessing many files concurrently
> > [2.] Full description of the problem/report:
> >
> > Accessing many files concurrently at once causes BTRFS to spin lock
> > too much and basically lock up all other processes for seconds at a
> > time.
> >
> > Mostly happens when accessing their content, not the other metadata.
> >
> > This appears to be a performance regression since v6.9. I bisected to
> > this commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/commit/?id=3D956a17d9d050761e34ae6f2624e9c1ce456de204
> >
> > The commit before this one has no issues, this one reliably reproduces
> > the issue for me.
> >
> > [3.] Keywords (i.e., modules, networking, kernel): btrfs, spin_lock,
> > super_cache_scan
> > [4.] Kernel information
> > [4.1.] Kernel version (from /proc/version): Linux version
> > 6.10.3-arch1-1 (linux@archlinux) (gcc (GCC) 14.2.1 20240802, GNU ld
> > (GNU Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Sun, 04 Aug 2024
> > 05:11:32 +0000
> > [4.2.] Kernel .config file:
> > https://gist.github.com/octylFractal/1344722b55f0a9eef4fc22fcfcc34177
> > [5.] Most recent kernel version which did not have the bug: v6.9
> > [6.] Output of Oops.. message (if applicable) with symbolic information
> >      resolved (see Documentation/admin-guide/bug-hunting.rst): N/A
> > [7.] A small shell script or example program which triggers the
> >      problem (if possible): Not possible as it appears to need a
> > specific set of data and/or an NVMe-speed drive (1-2GB/s). I was using
> > `rg --no-ignore uncommon-phrase ~/Documents/` but it didn't appear to
> > work in QEMU or on a different drive, only when using my NVMe SSD. I
> > have 1,425,292 files comprising 424GB in my `~/Documents`.
> > [8.] Environment
> > [8.1.] Software (add the output of the ver_linux script here)
> > Linux Draconnet 6.10.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 24 Jul 2024
> > 22:25:43 +0000 x86_64 GNU/Linux
> >
> > GNU C                   14.1.1
> > GNU Make                4.4.1
> > Binutils                2.42.0
> > Util-linux              2.40.2
> > Mount                   2.40.2
> > Module-init-tools       32
> > E2fsprogs               1.47.1
> > Jfsutils                1.1.15
> > Reiserfsprogs           3.6.27
> > Xfsprogs                6.9.0
> > PPP                     2.5.0
> > Bison                   3.8.2
> > Flex                    2.6.4
> > Linux C++ Library       6.0.33
> > Linux C++ Library       5.0.7
> > Dynamic linker (ldd)    2.40
> > Procps                  4.0.4
> > Net-tools               2.10
> > Kbd                     2.6.4
> > Console-tools           2.6.4
> > Sh-utils                9.5
> > Udev                    256
> > Wireless-tools          30
> > Modules Loaded          aesni_intel af_alg algif_hash algif_skcipher
> > amd_atl amdgpu amdxcp asus_wmi blake2b_generic bluetooth bnep bridge
> > btbcm btintel btmtk btrfs btrtl b
> > tusb ccp cec cmac crc16 crc32c_generic crc32c_intel crc32_pclmul
> > crct10dif_pclmul cryptd crypto_simd crypto_user dm_mod drm_buddy
> > drm_display_helper drm_exec drm_suballoc_
> > helper drm_ttm_helper eeepc_wmi enclosure ext4 fat gf128mul
> > ghash_clmulni_intel gpio_amdpt gpio_generic gpu_sched hid_generic
> > hwmon_vid i2c_algo_bit i2c_dev i2c_piix4 i804
> > 2 intel_rapl_common intel_rapl_msr ip_tables jbd2 jfs joydev kvm
> > kvm_amd ledtrig_timer libcrc32c libphy llc loop mac_hid mbcache mc
> > mdio_devres mousedev nct6775 nct6775_co
> > re nf_conntrack nf_defrag_ipv4 nf_defrag_ipv6 nf_nat nfnetlink
> > nf_reject_ipv4 nf_tables nft_chain_nat nft_compat nft_ct nft_masq
> > nft_reject nft_reject_ipv4 nilfs2 nls_iso8
> > 859_1 nls_ucs2_utils nvidia nvidia_drm nvidia_modeset nvidia_uvm nvme
> > nvme_auth nvme_core pkcs8_key_parser platform_profile polyval_clmulni
> > polyval_generic r8169 raid6_pq
> > rapl realtek rfcomm rfkill scsi_transport_sas serio ses sg sha1_ssse3
> > sha256_ssse3 sha512_ssse3 snd snd_hda_codec snd_hda_codec_generic
> > snd_hda_codec_hdmi snd_hda_codec_re
> > altek snd_hda_core snd_hda_intel snd_hda_scodec_component snd_hrtimer
> > snd_hwdep snd_intel_dspcfg snd_intel_sdw_acpi snd_pcm snd_seq
> > snd_seq_device snd_seq_dummy snd_timer
> > soundcore sp5100_tco sparse_keymap stp ttm tun uas uinput usbhid usblp
> > usb_storage uvc uvcvideo vfat video videobuf2_common videobuf2_memops
> > videobuf2_v4l2 videobuf2_vmall
> > oc videodev wacom wmi wmi_bmof xfs xhci_pci xhci_pci_renesas xor
> > x_tables xt_conntrack xt_mark xt_MASQUERADE xt_tcpudp zenpower
> >
> > [8.2.] Processor information (from /proc/cpuinfo):
> > https://gist.github.com/octylFractal/1dcb65816561aab9205fce590ec85e59
> > [8.3.] Module information (from /proc/modules):
> > https://gist.github.com/octylFractal/9c78960190b12e3634ae87e895858cb2
> > [8.4.] Loaded driver and hardware information (/proc/ioports,
> > /proc/iomem): https://gist.github.com/octylFractal/40a9f67dbaabac78cd2d=
03028dd994f7
> > [8.5.] PCI information ('lspci -vvv' as root):
> > https://gist.github.com/octylFractal/325a0f211094ff11643c16f1d1f63362
> > [8.6.] SCSI information (from /proc/scsi/scsi):
> > Attached devices:
> > Host: scsi4 Channel: 00 Id: 00 Lun: 00
> >  Vendor: ATA      Model: CT4000MX500SSD1  Rev: 045
> >  Type:   Direct-Access                    ANSI  SCSI revision: 05
> > [8.7.] Other information that might be relevant to the problem
> >        (please look in /proc and include all information that you
> >        think to be relevant): The NVMe SSD I'm using is a WDS100T3X0C-0=
0SJG0.
> >
> > #regzbot introduced: 956a17d9d050761e34ae6f2624e9c1ce456de204
>

