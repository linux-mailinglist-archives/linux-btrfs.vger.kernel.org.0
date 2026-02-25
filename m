Return-Path: <linux-btrfs+bounces-21909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIZRHajKnmm0XQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21909-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:10:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D0195883
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB0C53014A1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D03921ED;
	Wed, 25 Feb 2026 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK8q7foQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D802C0F7F
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014208; cv=pass; b=hODbni+aYxzZvWBfVTMqBfocT0P53MGC2epW4B95hxxj+SIxhSf3yU645dY7/cSBr3SQQ6U3zUqr02B3E90INGdWKmNuO4CmZ1k3HNDivA0B0CPNVKJq4aKCRp77CeFFE6jHB5enCaEdMiPybWNPGxbn1Em1Y5kPcO4sdVI12Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014208; c=relaxed/simple;
	bh=c6P2MiT8REJE7gGBs+ZOgREEwT3g0omUor095BHIa2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGHa6npCNvWf5FTtHSGsD3mN6u+nuKljxhx0/qQkaINu5cQGRd0T2sM7iaMcdQlUw7xv/d73WYyPcB1KW6LsJfncvFaDHYnawfBzhspn80nHgQUuFEazpvhQyReTMRNsWBJBH2JykVLOgzJ3HbYwsbb7L+tuOoYDPeUrGzt/8t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK8q7foQ; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-358f5317857so512586a91.3
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 02:10:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772014206; cv=none;
        d=google.com; s=arc-20240605;
        b=bg/DoKZW1hCc8u3IFp5biifIaj/Zc5Fz6Nw6nbeougxBlwR8L/53jS+kJ0s0bty3nm
         glsJjvI+1lyR5MxF2uEUl8Leccgf2Z6JxykqO2mUfbmXbG1q2cRCfg9Bnm2FAaxakvWy
         NgbqzYPUQ1gwIgXNwVdycYiGXc/bDkDdZfcLj558WnSHPmLeJNKeiGlOGSKgbhSXTTq6
         Eyk5hrGwUMZGl9g+MZpyAxVHju5SZzMmo6K/qGLEYlt4vw1flVQ2hr2FATntSNK3idNn
         z20wtIM421PbS1SXh9qqssGyPZTjx97DspB2EZMB4acsSVMKBhyP/Dhs3UiitN4Scn04
         SCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViBaWvRSVLD8JyGpqaEWV2E/iQlpTZYxzPRh/CeufEE=;
        fh=OXwDqFfnvKIKMJ9lAGYqni94FqznM0w8Exywlywhs7k=;
        b=fMkY7drBlGMKH+hkWGOtOhelrA85mKZ/2mwsrrZaiQfcLVBk6FxLABNtHEvuDRgzk/
         VpamosjPQ8cSjRYpqryfl6+KdhVMuSFh2eDWp4OzsaihE4IFPlJ6VvUCV7wE8woMvsV6
         VXzpD3hv1TqSZ5vqXqQc2qwsFEKkZImOVKoBKRAmkpix0ZyBgXbk8fLyldd95Z7RHkOM
         n6dcQrYFLRYXLQDvi6OfqCZ/Ie34p00fh9uJ4KSRpeIeMcolp9Iizvf6gYx6QpnP8eQa
         /yzZ4ZfiMF/cNJddRQtDOYQjacXwqCrJpFTatgR7NWW6anKKdAxnMuDznZOgNbWBa6L1
         O/4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772014206; x=1772619006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViBaWvRSVLD8JyGpqaEWV2E/iQlpTZYxzPRh/CeufEE=;
        b=XK8q7foQ96NPcJYq8JnfbHJDRKpeR7OKH6eNRWSulGPun3F6Gf+SgWysN4OFpBfilY
         3FL3hcz4fZZ6KydBzFNxQxEH8iVfzArERPgyEyA6iJdq66looPmNZKi8oTuzyf7NQa+8
         psPywjudqrkmt6jT5ddrImdBZYAuouCQxQ0UHS5h+W0M/gHjNDcd65RxNO7pnslNAzWq
         0zr1Sydm0UitVp512MKHkQDVhoOz0wAaT8AsEJQIhcNeFMfyAXKZSrOqSebZI3z+EGnp
         CcsL6u06s9eAOTeWz0RkM5PyZvh5sBCgig5hyPxHYT4kgDGF8JDM4AAv85tl5T1OU7MD
         J91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014206; x=1772619006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViBaWvRSVLD8JyGpqaEWV2E/iQlpTZYxzPRh/CeufEE=;
        b=A1ZpzaC06CDZXvOHXpSn86S6GKit2NDjQGRq233kWRY4PyiO8CydPYLK/MUA5seq1i
         v+qFUeMJGgATjmtRV4sEns0DRxTTGUvISsidoyh1p7IZMU07dBTNjpxGZ4BGvfifOs4s
         kHKcHzC5VaWEBVFDaHwp5g0O407ssZMMJlaiNtga8OaVxRll7cnCVhhhHbI3R0lpsxuX
         lwLf+ybfatXs8hjEEzIKMaUZlwkF1O1+v5EZK+Qg9hWmACIvvdxKcVUOy3OM5OOdChKU
         WyRUr8EYZ0Nm7/3TtgBONRcEVbXqVi05SruPajo+XjBF98COTfb56NQfX9tn5A95LOzI
         0nlw==
X-Forwarded-Encrypted: i=1; AJvYcCVYe1y7kII9eEOKAP1bLy54rp8n5gnfRMJQm1u6haiZhXYuKC5TMLUy6q1HAv+0TEfBcAEn0ZB5Jz2Ikg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qDoxxESwPKH782pHxayVXh0Vg3uRE+78N/yK629YboMjQ2Q4
	ILDSmu8p2TeBwyjeYy9WGRQTz+TV7LK1+tXyFZM8mLV3KHTgPuhDOqiBGQv6VoSkDLVeWcGCJTw
	Nu4VnmiCRCzYMUQEsZR8DiRoLjQuemNA=
X-Gm-Gg: ATEYQzwNK7fO2uJwmvS4eci8X9rJYVSEICXXuvQn9apyViOrSFckoQq+SBQESnXpKQU
	CWh/HOFcvhJh6cII1jEvI74jh/qR1e6YtXJMmN+ONDTnFN1c7hOs1T5ftoTmkeiZvGV8bmYPWPE
	iMl54GbUuHZ1XjSyv8s7rFI9QT68k7PmpijwYPmRv4NXke6Jnl21iiv9zBpHH+XIHR1BWpJK1KC
	gaorwVLYMBklDYpDeV4KVKAqUWsFf4JCiIQ6wFCMnpuT/2j4sczpzE9fr/zULjfIG87L3qt1G6H
	uDwIw2ujLtzj7wreymWosgfvG2bFYWKW6QT0NWA=
X-Received: by 2002:a17:90b:3842:b0:354:a09a:1016 with SMTP id
 98e67ed59e1d1-358ae8da552mr12599730a91.30.1772014205880; Wed, 25 Feb 2026
 02:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHzMYBSfK7Ms9W9rc1mzsyP0aRkXg=3G6VXuur15jm7OE2JoCA@mail.gmail.com>
 <6e46e258-4589-4cb8-8548-036ad36884b5@wdc.com> <CAHzMYBSCtpHamhBCCgPf4WNDmY5-DOdnXJ8NMLf4C-CLL09oiA@mail.gmail.com>
 <DGMZYSH7JG2W.1DBICE2W4XI3X@wdc.com> <CAHzMYBTUrh7XGkj3VD5rOew+8s_9D0U8bskureT2jZAx4wLWfQ@mail.gmail.com>
In-Reply-To: <CAHzMYBTUrh7XGkj3VD5rOew+8s_9D0U8bskureT2jZAx4wLWfQ@mail.gmail.com>
From: Jorge Bastos <jorge.mrbastos@gmail.com>
Date: Wed, 25 Feb 2026 10:09:54 +0000
X-Gm-Features: AaiRm52jKoaEdqDEkgppyNr0twMF-UHXzgqAR0zjRH2rZIFIQX_hplMldjgIYe8
Message-ID: <CAHzMYBSxPzHrHgYEGuK=CXLqdLwoH6UkEU+tC4cPSDBECDYJog@mail.gmail.com>
Subject: Re: Btrfs with zoned devices
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21909-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jorgemrbastos@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wdc.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E40D0195883
X-Rspamd-Action: no action

One final update: I changed the commit mount option to commit=3D360, and
it finished the initial data loading without more crashes.

While I cannot be certain this helped, it crashed 3 times for the
first 5T loaded, and after adding that, I was able to write the
remaining 8T in one go without any more crashes, so it may have.

In any case, now the data will be mostly static, with small updates
once in a while, so hopefully it will not crash more.

Cheers,
Jorge


On Tue, Feb 24, 2026 at 9:03=E2=80=AFAM Jorge Bastos <jorge.mrbastos@gmail.=
com> wrote:
>
> Roger that, sorry I can't provide the debug info, I'm afraid it
> crashed ahgain, so the mount options didn't help, but there are some
> new erros before the crash this time, not sure if they help, hundreds
> of lines like these:
>
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2483 folio=3D288358400 submit_bitmap=3D0
> start=3D288358400 len=3D524288: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
> cow_file_range failed, root=3D5 inode=3D2481 start=3D739246080 len=3D5242=
88
> cur_offset=3D739246080 cur_alloc_size=3D0: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2481 folio=3D739246080 submit_bitmap=3D0
> start=3D739246080 len=3D524288: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
> cow_file_range failed, root=3D5 inode=3D2480 start=3D747634688 len=3D5242=
88
> cur_offset=3D747634688 cur_alloc_size=3D0: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2480 folio=3D747634688 submit_bitmap=3D0
> start=3D747634688 len=3D524288: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
> cow_file_range failed, root=3D5 inode=3D2477 start=3D862453760 len=3D5242=
88
> cur_offset=3D862453760 cur_alloc_size=3D0: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2477 folio=3D862453760 submit_bitmap=3D0
> start=3D862453760 len=3D524288: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
> cow_file_range failed, root=3D5 inode=3D2472 start=3D1995964416 len=3D524=
288
> cur_offset=3D1995964416 cur_alloc_size=3D0: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2472 folio=3D1995964416 submit_bitmap=3D0
> start=3D1995964416 len=3D524288: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
> cow_file_range failed, root=3D5 inode=3D2479 start=3D726138880 len=3D5242=
88
> cur_offset=3D726138880 cur_alloc_size=3D0: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2479 folio=3D726138880 submit_bitmap=3D0
> start=3D726138880 len=3D524288: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
> cow_file_range failed, root=3D5 inode=3D2473 start=3D1681391616 len=3D524=
288
> cur_offset=3D1681391616 cur_alloc_size=3D0: -28
> Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2473 folio=3D1681391616 submit_bitmap=3D0
> start=3D1681391616 len=3D524288: -28
> Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc):
> cow_file_range failed, root=3D5 inode=3D2471 start=3D2265972736 len=3D524=
288
> cur_offset=3D2265972736 cur_alloc_size=3D0: -28
> Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2471 folio=3D2265972736 submit_bitmap=3D0
> start=3D2265972736 len=3D524288: -28
> Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc):
> cow_file_range failed, root=3D5 inode=3D2475 start=3D1724907520 len=3D524=
288
> cur_offset=3D1724907520 cur_alloc_size=3D0: -28
> Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2475 folio=3D1724907520 submit_bitmap=3D0
> start=3D1724907520 len=3D524288: -28
> Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc):
> cow_file_range failed, root=3D5 inode=3D2474 start=3D1701314560 len=3D524=
288
> cur_offset=3D1701314560 cur_alloc_size=3D0: -28
> Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc): failed to run
> delalloc range, root=3D5 ino=3D2474 folio=3D1701314560 submit_bitmap=3D0
> start=3D1701314560 len=3D524288:
>
> Then it crashed:
>
> Feb 24 08:32:30 Tower7 kernel: BTRFS: error (device sdc) in
> btrfs_commit_transaction:2536: errno=3D-11 unknown (Error while writing
> out transaction)
> Feb 24 08:32:30 Tower7 kernel: BTRFS info (device sdc state E): forced re=
adonly
> Feb 24 08:32:30 Tower7 kernel: BTRFS warning (device sdc state E):
> Skipping commit of aborted transaction.
> Feb 24 08:32:30 Tower7 kernel: ------------[ cut here ]------------
> Feb 24 08:32:30 Tower7 kernel: BTRFS: Transaction aborted (error -11)
> Feb 24 08:32:30 Tower7 kernel: WARNING: CPU: 9 PID: 21919 at
> fs/btrfs/transaction.c:2021 btrfs_commit_transaction+0x994/0xb20
> Feb 24 08:32:30 Tower7 kernel: Modules linked in: br_netfilter
> nft_compat nf_conntrack_netlink xt_nat af_packet iptable_raw veth
> xt_conntrack bridge stp llc xfrm_user xfrm_algo xt_set ip_set
> xt_addrtype md_mod xt_MASQUERADE xt_tcpudp xt_mark tun nf_tables
> nfnetlink ip6table_nat iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 ipmi_devintf ip6table_filter ip6_tables iptable_filter
> ip_tables x_tables macvtap macvlan tap mlx5_core mlxfw tls igb
> intel_rapl_msr amd64_edac edac_mce_amd edac_core intel_rapl_common
> kvm_amd ast drm_shmem_helper drm_client_lib drm_kms_helper ipmi_ssif
> kvm ghash_clmulni_intel aesni_intel drm rapl acpi_cpufreq i2c_algo_bit
> backlight input_leds joydev led_class ccp i2c_piix4 i2c_smbus ses
> acpi_ipmi enclosure k10temp i2c_core ipmi_si button zfs(PO) spl(O)
> [last unloaded: mlxfw]
> Feb 24 08:32:30 Tower7 kernel: CPU: 9 UID: 0 PID: 21919 Comm:
> btrfs-transacti Tainted: P        W  O        6.18.9-Unraid #4
> PREEMPT(voluntary)
> Feb 24 08:32:30 Tower7 kernel: Tainted: [P]=3DPROPRIETARY_MODULE,
> [W]=3DWARN, [O]=3DOOT_MODULE
> Feb 24 08:32:30 Tower7 kernel: Hardware name: Supermicro Super
> Server/H11SSL-i, BIOS 2.4 12/27/2021
> Feb 24 08:32:30 Tower7 kernel: RIP: 0010:btrfs_commit_transaction+0x994/0=
xb20
> Feb 24 08:32:30 Tower7 kernel: Code: ba ff 49 8b 7c 24 60 89 da 48 c7
> c6 2a 81 57 82 e8 81 14 a9 ff e8 2c ef ba ff eb 10 89 de 48 c7 c7 4b
> 81 57 82 e8 6c d5 b1 ff <0f> 0b 41 b0 01 41 83 e0 01 89 d9 ba e5 07 00
> 00 4c 89 e7 48 c7 c6
> Feb 24 08:32:30 Tower7 kernel: RSP: 0018:ffffc9002dde7de0 EFLAGS: 0001028=
2
> Feb 24 08:32:30 Tower7 kernel: RAX: 0000000000000000 RBX:
> 00000000fffffff5 RCX: 0000000000000002
> Feb 24 08:32:30 Tower7 kernel: RDX: 0000000000000027 RSI:
> ffffffff825f9e70 RDI: 00000000ffffffff
> Feb 24 08:32:30 Tower7 kernel: RBP: ffff8881d3244000 R08:
> 0000000000000000 R09: 0000000000000000
> Feb 24 08:32:30 Tower7 kernel: R10: 0000000000000019 R11:
> 00000000312d2072 R12: ffff88826fe59888
> Feb 24 08:32:30 Tower7 kernel: R13: ffff888302e73000 R14:
> ffff8881d3244000 R15: ffff88828da56300
> Feb 24 08:32:30 Tower7 kernel: FS:  0000000000000000(0000)
> GS:ffff88a0499bc000(0000) knlGS:0000000000000000
> Feb 24 08:32:30 Tower7 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Feb 24 08:32:30 Tower7 kernel: CR2: 00001455a3905d88 CR3:
> 000000026dba6000 CR4: 0000000000350ef0
> Feb 24 08:32:30 Tower7 kernel: Call Trace:
> Feb 24 08:32:30 Tower7 kernel: <TASK>
> Feb 24 08:32:30 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> Feb 24 08:32:30 Tower7 kernel: ? start_transaction+0x46e/0x5e0
> Feb 24 08:32:30 Tower7 kernel: ? hrtimer_nanosleep_restart+0x50/0x60
> Feb 24 08:32:30 Tower7 kernel: transaction_kthread+0xf0/0x170
> Feb 24 08:32:30 Tower7 kernel: ? __pfx_transaction_kthread+0x10/0x10
> Feb 24 08:32:30 Tower7 kernel: kthread+0x1ce/0x1e0
> Feb 24 08:32:30 Tower7 kernel: ? finish_task_switch.isra.0+0x13c/0x210
> Feb 24 08:32:30 Tower7 kernel: ? finish_task_switch.isra.0+0x139/0x210
> Feb 24 08:32:30 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> Feb 24 08:32:30 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> Feb 24 08:32:30 Tower7 kernel: ret_from_fork+0x24/0x130
> Feb 24 08:32:30 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> Feb 24 08:32:30 Tower7 kernel: ret_from_fork_asm+0x1a/0x30
> Feb 24 08:32:30 Tower7 kernel: </TASK>
> Feb 24 08:32:30 Tower7 kernel: ---[ end trace 0000000000000000 ]---
> Feb 24 08:32:30 Tower7 kernel: BTRFS: error (device sdc state EA) in
> cleanup_transaction:2021: errno=3D-11 unknown
>
> On Tue, Feb 24, 2026 at 7:02=E2=80=AFAM Naohiro Aota <Naohiro.Aota@wdc.co=
m> wrote:
> >
> > On Tue Feb 24, 2026 at 1:03 AM JST, Jorge Bastos wrote:
> > > Thanks for the reply, I'm afraid I'm using a built kernel, and
> > > building my own with debug info is beyond my knowledge.
> > >
> > > Gemini believes the issue may be caused by too many open zones. I've
> > > monitored blkzone report output, and there are typically >100 zones i=
n
> > > the 'Implicitly Open' or 'Explicitly Open' state, and I've seen it go
> > > over 120 before.
> > >
> > > I checked the queue limits for the device and
> > > /sys/block/sdb/queue/max_active_zones reports 0
> > > but
> > > /sys/block/sdb/queue/max_open_zones reports 128
> > >
> > > Could it be that btrfs is hitting the max_open_zones limit and
> > > receiving EAGAIN (-11) during btrfs_commit_transaction, possibly
> > > because it isn't self-limiting based on the max_open_zones value when
> > > max_active_zones is 0."
> >
> > Not really. Btrfs now limits by max_open_zones as below in zoned.c
> >
> >         max_active_zones =3D min_not_zero(bdev_max_active_zones(bdev),
> >                                         bdev_max_open_zones(bdev));
> >
> > And, EAGAIN basically should be coming from
> > btrfs_check_meta_write_pointer() when there is a hole in a writing
> > region. Usually at the transaction commit phase, all metadata in the
> > writing region should be allocated and ready for sequential writing. So=
,
> > something wrong happens here either mis-ordering or mis-skipping a
> > block.
> >
> > >
> > > Thanks,
> > > Jorge
> > >
> > > On Mon, Feb 23, 2026 at 3:15=E2=80=AFPM Johannes Thumshirn
> > > <Johannes.Thumshirn@wdc.com> wrote:
> > >>
> > >> On 2/23/26 3:59 PM, Jorge Bastos wrote:
> > >> > Hi,
> > >> >
> > >> > I'm using a zoned device for the first time; it's a 27TB WD Ultras=
tar
> > >> > HC680, formatted with single data and DUP metadata.
> > >> >
> > >> > This will be used for non-critical WORM media data, but during the
> > >> > initial data load, using a single rsync thread, the filesystem cra=
shed
> > >> > twice, 1st time after copying around 1.25T, 2nd time around 2.5T
> > >> > total.
> > >> >
> > >> > I'm now using some mount options suggested by LLMs, and it hasn't
> > >> > crashed so far, but it's not been long; currently at 3.58T used.
> > >> >
> > >> > mount -o rw,noatime,commit=3D60,flushoncommit,discard=3Dasync
> > >>
> > >> discard=3Dasync doesn't make a lot of sense on zoned and it will be =
ignored.
> > >>
> > >>
> > >> > My question is, are these mount options good for HM-SMR or do you
> > >> > recommend different ones, and could they help with the crashing?
> > >> >
> > >> >
> > >> > These were the crashes I saw, they look similar to me, and after
> > >> > unmounting and remounting, it worked again:
> > >>
> > >>
> > >> Yes these errors are transient (luckily).
> > >>
> > >>
> > >> > Kernel 6.18.9
> > >> > btrfs-progs v6.17.1
> > >> >
> > >> > 1st one:
> > >> >
> > >> > Feb 22 21:35:56 Tower7 kernel: BTRFS: error (device sdb) in
> > >> > btrfs_commit_transaction:2536: errno=3D-11 unknown (Error while wr=
iting
> > >> > out transaction)
> > >> > Feb 22 21:35:56 Tower7 kernel: BTRFS info (device sdb state E): fo=
rced readonly
> > >> > Feb 22 21:35:56 Tower7 kernel: BTRFS warning (device sdb state E):
> > >> > Skipping commit of aborted transaction.
> > >> > Feb 22 21:35:56 Tower7 kernel: ------------[ cut here ]-----------=
-
> > >> > Feb 22 21:35:56 Tower7 kernel: BTRFS: Transaction aborted (error -=
11)
> > >> > Feb 22 21:35:56 Tower7 kernel: WARNING: CPU: 8 PID: 109946 at
> > >> > fs/btrfs/transaction.c:2021 btrfs_commit_transaction+0x994/0xb20
> > >> > Feb 22 21:35:56 Tower7 kernel: Modules linked in: md_mod br_netfil=
ter
> > >> > nft_compat af_packet veth nf_conntrack_netlink xt_nat iptable_raw
> > >> > xt_conntrack bridge stp llc xfrm_user xfrm_algo xt_set ip_set
> > >> > xt_addrtype xt_MASQUERADE xt_tcpudp xt_mark tun nf_tables nfnetlin=
k
> > >> > ip6table_nat iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
> > >> > nf_defrag_ipv4 ipmi_devintf ip6table_filter ip6_tables iptable_fil=
ter
> > >> > ip_tables x_tables macvtap macvlan tap mlx5_core mlxfw tls igb
> > >> > intel_rapl_msr amd64_edac edac_mce_amd edac_core intel_rapl_common
> > >> > kvm_amd ast kvm drm_shmem_helper drm_client_lib drm_kms_helper
> > >> > ipmi_ssif ghash_clmulni_intel aesni_intel drm rapl acpi_cpufreq
> > >> > backlight i2c_algo_bit input_leds joydev led_class ccp i2c_piix4
> > >> > i2c_smbus acpi_ipmi ses enclosure i2c_core k10temp ipmi_si button
> > >> > zfs(PO) spl(O) [last unloaded: md_mod]
> > >> > Feb 22 21:35:56 Tower7 kernel: CPU: 8 UID: 0 PID: 109946 Comm:
> > >> > btrfs-transacti Tainted: P        W  O        6.18.9-Unraid #4
> > >> > PREEMPT(voluntary)
> > >> > Feb 22 21:35:56 Tower7 kernel: Tainted: [P]=3DPROPRIETARY_MODULE,
> > >> > [W]=3DWARN, [O]=3DOOT_MODULE
> > >> > Feb 22 21:35:56 Tower7 kernel: Hardware name: Supermicro Super
> > >> > Server/H11SSL-i, BIOS 2.4 12/27/2021
> > >> > Feb 22 21:35:56 Tower7 kernel: RIP: 0010:btrfs_commit_transaction+=
0x994/0xb20
> > >> > Feb 22 21:35:56 Tower7 kernel: Code: ba ff 49 8b 7c 24 60 89 da 48=
 c7
> > >> > c6 2a 81 57 82 e8 81 14 a9 ff e8 2c ef ba ff eb 10 89 de 48 c7 c7 =
4b
> > >> > 81 57 82 e8 6c d5 b1 ff <0f> 0b 41 b0 01 41 83 e0 01 89 d9 ba e5 0=
7 00
> > >> > 00 4c 89 e7 48 c7 c6
> > >> > Feb 22 21:35:56 Tower7 kernel: RSP: 0018:ffffc9003cac7de0 EFLAGS: =
00010282
> > >> > Feb 22 21:35:56 Tower7 kernel: RAX: 0000000000000000 RBX:
> > >> > 00000000fffffff5 RCX: 0000000000000002
> > >> > Feb 22 21:35:56 Tower7 kernel: RDX: 0000000000000027 RSI:
> > >> > ffffffff825f9e70 RDI: 00000000ffffffff
> > >> > Feb 22 21:35:56 Tower7 kernel: RBP: ffff88826a27d000 R08:
> > >> > 0000000000000000 R09: 0000000000000000
> > >> > Feb 22 21:35:56 Tower7 kernel: R10: 0000000000000000 R11:
> > >> > 00000000312d2072 R12: ffff888290a1b7e0
> > >> > Feb 22 21:35:56 Tower7 kernel: R13: ffff888249304c00 R14:
> > >> > ffff88826a27d000 R15: ffff888100ec6300
> > >> > Feb 22 21:35:56 Tower7 kernel: FS:  0000000000000000(0000)
> > >> > GS:ffff88a04997c000(0000) knlGS:0000000000000000
> > >> > Feb 22 21:35:56 Tower7 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
> > >> > Feb 22 21:35:56 Tower7 kernel: CR2: 00007ffcad620af8 CR3:
> > >> > 00000001f5915000 CR4: 0000000000350ef0
> > >> > Feb 22 21:35:56 Tower7 kernel: Call Trace:
> > >> > Feb 22 21:35:56 Tower7 kernel: <TASK>
> > >> > Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> > >> > Feb 22 21:35:56 Tower7 kernel: ? start_transaction+0x46e/0x5e0
> > >> > Feb 22 21:35:56 Tower7 kernel: ? hrtimer_nanosleep_restart+0x50/0x=
60
> > >> > Feb 22 21:35:56 Tower7 kernel: transaction_kthread+0xf0/0x170
> > >> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_transaction_kthread+0x10/0x=
10
> > >> > Feb 22 21:35:56 Tower7 kernel: kthread+0x1ce/0x1e0
> > >> > Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> > >> > Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> > >> > Feb 22 21:35:56 Tower7 kernel: ? finish_task_switch.isra.0+0x139/0=
x210
> > >> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> > >> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> > >> > Feb 22 21:35:56 Tower7 kernel: ret_from_fork+0x24/0x130
> > >> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> > >> > Feb 22 21:35:56 Tower7 kernel: ret_from_fork_asm+0x1a/0x30
> > >> > Feb 22 21:35:56 Tower7 kernel: </TASK>
> > >> > Feb 22 21:35:56 Tower7 kernel: ---[ end trace 0000000000000000 ]--=
-
> > >> > Feb 22 21:35:56 Tower7 kernel: BTRFS: error (device sdb state EA) =
in
> > >> > cleanup_transaction:2021: errno=3D-11 unknown
> > >>
> > >> The FS is trying to commit a transaction and something down the path=
 is
> > >> returning EAGAIN. Would be interesting who did it.
> > >>
> > >> Do you have the debug info for this kernel, so we can find out where=
 it
> > >> breaks?
> > >>

