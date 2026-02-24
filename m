Return-Path: <linux-btrfs+bounces-21865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPIqGVhqnWnhPwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21865-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 10:07:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C85FD184407
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 10:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 770D83106BBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D636A02D;
	Tue, 24 Feb 2026 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asYDmCFY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454236681C
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923822; cv=pass; b=P/WODlmnxaJezoyd7Rcl04FoGPlX6sHIzz6gMsrlC0wDt5EblsIwBwvF3BvzURbZBjvi+mNWe9ThlunVefYmV3rnEX3zvLEPZ+A7f86zYQiaYNMCrg2cFnUZgZoKPhr7ksZZ36JiW2yTCiffiCmstJm2LB+FuIIKUtVruiJaPBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923822; c=relaxed/simple;
	bh=PIkbfT51VikyVhEwJGtusF9LabqRuzvO43m+tYKOj70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM+/MkELCpE+Dhrcab+BrojADenjy4Eo3YKjoxJlyCa7b3tLSXHDhEpqWqzwXd/OEKJMok1po9PksGZX/bnsVDNb+KBrkVU1HU7mbOcKke/798MS1+wngGwsQSt8AyxceVCV3LMymqvcCByq45zGWoSPwPCfcMkr2zWeSopkuFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asYDmCFY; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81df6a302b1so5054661b3a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 01:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771923820; cv=none;
        d=google.com; s=arc-20240605;
        b=YDVbUAajR1RWDXTwI95TrXvhkW0YjV6dGJFvKIHTBSFbQs1F0uu4WoQJPq7KqSIgu3
         w8VcEgqHBTHlvGzCINAjZTSbvbdLfhhvibODOinfAeo/mrYL+ECjb127k/rk1eFXbuew
         2PqhQLia46ROD5M77T/WFlR4oBgJBFiz3Ff8cyiKOK1GOeKCgDbEi3SKAD8/xeYCcQRK
         6+1mP98Se1IPi3XBvFYkYtMYYSM7ismmZKx8SSGzLkaBDUsrWZjEmrVfSF347I25EVZ4
         edDp5Cq8WadoagwQj+SRo5qpTVyV/rDDJcsQK/w9opJ8M1XMRhH00YBRKw80QsrqpENN
         wi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=znIlhhnbagcz2zMsWF4Ooi2zRtDyYf/EmpmzlKC0Xmw=;
        fh=pB/nojOpvdBEJuOkA30Miyvg7km7DHHu4zfYMsyYlhU=;
        b=GfCCYPXEHY3Iwd3ffOcVuZQZ9fQ8sqVbjuEK3+iw38qwicauyJmUg7vlA0waa4UYSx
         3GMnGFhpFBcb/da+ZWlsWotukPYUR1FRzk4asLJArj6WP3LAFyarQ6qMA/P289yNda1A
         JfQZKKxziYdt4W11KkHhNmuS18NZW0lwyfIDColIAU3J//+jCFNuU0RLmKpk0DAl3VI2
         2m6bvKavQ8hu23NvKW+7Mnu7sgmeeKCxDHsngttmSF4szaaTToM6rF5b8sH4TDXBWyFb
         s6at6kU31atFqoSrx+szn6xw6qNY6civz3NhGgLuP7RTYoGNT71EgJwcf8Wtrldt4zZF
         4A1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771923820; x=1772528620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znIlhhnbagcz2zMsWF4Ooi2zRtDyYf/EmpmzlKC0Xmw=;
        b=asYDmCFYEt0jhEg17LYwulqZGVozjctSdHr1nE5f9bM9nYCHBVCKpUYkoGxi89Jx4I
         FcS7EvleeM/yPEji7u6CBar4NvyZ8KHQ97cfp956CjhbkSvaCI4qzf91M65GfR7Drl4V
         en80R6NjFE9JjbDSy2cyHPNgjocHefvdnPc5A1R0H2lrLWUr0rKFikVrlx+xl3uC6o78
         /BTGPJN58GKbf9zbHGpYsQGQmiTL5+72dua/3+/rVEENG3iNC/0TTcKvqDDEVQ/5y2Rg
         /xy9BNEWZEA/aOggd4tSwrVDxEHlQ2V/O09PobxsesjCnL7DG3eeicrT5FO8H7DVPAOd
         5Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771923820; x=1772528620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znIlhhnbagcz2zMsWF4Ooi2zRtDyYf/EmpmzlKC0Xmw=;
        b=sBUISrJAzp1939hOrpKkSa7oeLICICFeKndVMDfwr1GYBzGQ6VHvI0WuJwsvkgTd54
         fSMVm5vPuB7IEDSMPWt2q7Z2NlAQzuRCLScyuiW8FapMNL2qBSEgQ3qPHlVGLw21z8JX
         KvDfglrc/itHG87aDJYzkpCciiKbn05yAyODelcZofeHpnWp1rODmZfAEAf7Qxr1qWK7
         /Bz8MhSDfNOwTCi+rIuJeL5EFmSCsHLht06cvTP+zeiokhSJnpcO7NsCLkCJNbgVC2Ez
         FpDN6KWbuiI5YLrVSUXPcwlgg2vUEHYFNe9y9dyvtL/PvmCIlThLqRHAajy3+NLS1y4L
         zOtw==
X-Forwarded-Encrypted: i=1; AJvYcCWfatWPRnT5XDzS4S0ftN45BZo9eBVDswBF5qpYgBqOrZetQMout7sOINa8epAITuzC8OlTET9SBZ/Fcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEke2Bshj+ZUQnf52waQ6aLtM/OXmA9CPphTGLskFwTzRzhNY2
	wC6ITK18+c1AyQ1k5KFtZ0C72OPVAvaLRimUYTryWG6n8Uft/WUTNlD8nmG8+IuEavSbepGv7Hj
	8J48yWK/SiN6dfR//GEvlfbMaCoIuEr/NCrp2
X-Gm-Gg: AZuq6aJYrUWwpLco/IL1LosQdqP0J4PZ5ldTe304+LepGMRlaQBHiDa5I4c5DFs3BL9
	WF15ZIiHwMwzX8lLi8qC6YcW3OxwEeSqd2ol7/zNI6JB7l99yHEBkszjXT9CFM/l7IbIxAeajlY
	8ToIIg2atNB2PPQrOGqdmWoafz8iEv6Yy6ZaaHt1aAhskpbsUYh5yDQoqnKgm3bKSXOUsBr6wCj
	kAtesj3pzDStcbyuK1LH6kFp7TwmYTilEHcCC4p4tao+HY/TOsU+k4OcIkpWbUUGXaht8XrO6AH
	F8dQUSYorAHcF06KwQFghmARf42Iwbk7xvgGLtsH
X-Received: by 2002:a05:6a21:687:b0:394:427b:eab with SMTP id
 adf61e73a8af0-39545e388f7mr9694233637.11.1771923819860; Tue, 24 Feb 2026
 01:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHzMYBSfK7Ms9W9rc1mzsyP0aRkXg=3G6VXuur15jm7OE2JoCA@mail.gmail.com>
 <6e46e258-4589-4cb8-8548-036ad36884b5@wdc.com> <CAHzMYBSCtpHamhBCCgPf4WNDmY5-DOdnXJ8NMLf4C-CLL09oiA@mail.gmail.com>
 <DGMZYSH7JG2W.1DBICE2W4XI3X@wdc.com>
In-Reply-To: <DGMZYSH7JG2W.1DBICE2W4XI3X@wdc.com>
From: Jorge Bastos <jorge.mrbastos@gmail.com>
Date: Tue, 24 Feb 2026 09:03:30 +0000
X-Gm-Features: AaiRm51eppf1FQJNMWMaA0DQDXwpAyj-8zJdQ29gJbl3XYxc1_aW16dDICaCd9A
Message-ID: <CAHzMYBTUrh7XGkj3VD5rOew+8s_9D0U8bskureT2jZAx4wLWfQ@mail.gmail.com>
Subject: Re: Btrfs with zoned devices
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21865-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C85FD184407
X-Rspamd-Action: no action

Roger that, sorry I can't provide the debug info, I'm afraid it
crashed ahgain, so the mount options didn't help, but there are some
new erros before the crash this time, not sure if they help, hundreds
of lines like these:

Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2483 folio=3D288358400 submit_bitmap=3D0
start=3D288358400 len=3D524288: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
cow_file_range failed, root=3D5 inode=3D2481 start=3D739246080 len=3D524288
cur_offset=3D739246080 cur_alloc_size=3D0: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2481 folio=3D739246080 submit_bitmap=3D0
start=3D739246080 len=3D524288: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
cow_file_range failed, root=3D5 inode=3D2480 start=3D747634688 len=3D524288
cur_offset=3D747634688 cur_alloc_size=3D0: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2480 folio=3D747634688 submit_bitmap=3D0
start=3D747634688 len=3D524288: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
cow_file_range failed, root=3D5 inode=3D2477 start=3D862453760 len=3D524288
cur_offset=3D862453760 cur_alloc_size=3D0: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2477 folio=3D862453760 submit_bitmap=3D0
start=3D862453760 len=3D524288: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
cow_file_range failed, root=3D5 inode=3D2472 start=3D1995964416 len=3D52428=
8
cur_offset=3D1995964416 cur_alloc_size=3D0: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2472 folio=3D1995964416 submit_bitmap=3D0
start=3D1995964416 len=3D524288: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
cow_file_range failed, root=3D5 inode=3D2479 start=3D726138880 len=3D524288
cur_offset=3D726138880 cur_alloc_size=3D0: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2479 folio=3D726138880 submit_bitmap=3D0
start=3D726138880 len=3D524288: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc):
cow_file_range failed, root=3D5 inode=3D2473 start=3D1681391616 len=3D52428=
8
cur_offset=3D1681391616 cur_alloc_size=3D0: -28
Feb 24 08:32:26 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2473 folio=3D1681391616 submit_bitmap=3D0
start=3D1681391616 len=3D524288: -28
Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc):
cow_file_range failed, root=3D5 inode=3D2471 start=3D2265972736 len=3D52428=
8
cur_offset=3D2265972736 cur_alloc_size=3D0: -28
Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2471 folio=3D2265972736 submit_bitmap=3D0
start=3D2265972736 len=3D524288: -28
Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc):
cow_file_range failed, root=3D5 inode=3D2475 start=3D1724907520 len=3D52428=
8
cur_offset=3D1724907520 cur_alloc_size=3D0: -28
Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2475 folio=3D1724907520 submit_bitmap=3D0
start=3D1724907520 len=3D524288: -28
Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc):
cow_file_range failed, root=3D5 inode=3D2474 start=3D1701314560 len=3D52428=
8
cur_offset=3D1701314560 cur_alloc_size=3D0: -28
Feb 24 08:32:27 Tower7 kernel: BTRFS error (device sdc): failed to run
delalloc range, root=3D5 ino=3D2474 folio=3D1701314560 submit_bitmap=3D0
start=3D1701314560 len=3D524288:

Then it crashed:

Feb 24 08:32:30 Tower7 kernel: BTRFS: error (device sdc) in
btrfs_commit_transaction:2536: errno=3D-11 unknown (Error while writing
out transaction)
Feb 24 08:32:30 Tower7 kernel: BTRFS info (device sdc state E): forced read=
only
Feb 24 08:32:30 Tower7 kernel: BTRFS warning (device sdc state E):
Skipping commit of aborted transaction.
Feb 24 08:32:30 Tower7 kernel: ------------[ cut here ]------------
Feb 24 08:32:30 Tower7 kernel: BTRFS: Transaction aborted (error -11)
Feb 24 08:32:30 Tower7 kernel: WARNING: CPU: 9 PID: 21919 at
fs/btrfs/transaction.c:2021 btrfs_commit_transaction+0x994/0xb20
Feb 24 08:32:30 Tower7 kernel: Modules linked in: br_netfilter
nft_compat nf_conntrack_netlink xt_nat af_packet iptable_raw veth
xt_conntrack bridge stp llc xfrm_user xfrm_algo xt_set ip_set
xt_addrtype md_mod xt_MASQUERADE xt_tcpudp xt_mark tun nf_tables
nfnetlink ip6table_nat iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ipmi_devintf ip6table_filter ip6_tables iptable_filter
ip_tables x_tables macvtap macvlan tap mlx5_core mlxfw tls igb
intel_rapl_msr amd64_edac edac_mce_amd edac_core intel_rapl_common
kvm_amd ast drm_shmem_helper drm_client_lib drm_kms_helper ipmi_ssif
kvm ghash_clmulni_intel aesni_intel drm rapl acpi_cpufreq i2c_algo_bit
backlight input_leds joydev led_class ccp i2c_piix4 i2c_smbus ses
acpi_ipmi enclosure k10temp i2c_core ipmi_si button zfs(PO) spl(O)
[last unloaded: mlxfw]
Feb 24 08:32:30 Tower7 kernel: CPU: 9 UID: 0 PID: 21919 Comm:
btrfs-transacti Tainted: P        W  O        6.18.9-Unraid #4
PREEMPT(voluntary)
Feb 24 08:32:30 Tower7 kernel: Tainted: [P]=3DPROPRIETARY_MODULE,
[W]=3DWARN, [O]=3DOOT_MODULE
Feb 24 08:32:30 Tower7 kernel: Hardware name: Supermicro Super
Server/H11SSL-i, BIOS 2.4 12/27/2021
Feb 24 08:32:30 Tower7 kernel: RIP: 0010:btrfs_commit_transaction+0x994/0xb=
20
Feb 24 08:32:30 Tower7 kernel: Code: ba ff 49 8b 7c 24 60 89 da 48 c7
c6 2a 81 57 82 e8 81 14 a9 ff e8 2c ef ba ff eb 10 89 de 48 c7 c7 4b
81 57 82 e8 6c d5 b1 ff <0f> 0b 41 b0 01 41 83 e0 01 89 d9 ba e5 07 00
00 4c 89 e7 48 c7 c6
Feb 24 08:32:30 Tower7 kernel: RSP: 0018:ffffc9002dde7de0 EFLAGS: 00010282
Feb 24 08:32:30 Tower7 kernel: RAX: 0000000000000000 RBX:
00000000fffffff5 RCX: 0000000000000002
Feb 24 08:32:30 Tower7 kernel: RDX: 0000000000000027 RSI:
ffffffff825f9e70 RDI: 00000000ffffffff
Feb 24 08:32:30 Tower7 kernel: RBP: ffff8881d3244000 R08:
0000000000000000 R09: 0000000000000000
Feb 24 08:32:30 Tower7 kernel: R10: 0000000000000019 R11:
00000000312d2072 R12: ffff88826fe59888
Feb 24 08:32:30 Tower7 kernel: R13: ffff888302e73000 R14:
ffff8881d3244000 R15: ffff88828da56300
Feb 24 08:32:30 Tower7 kernel: FS:  0000000000000000(0000)
GS:ffff88a0499bc000(0000) knlGS:0000000000000000
Feb 24 08:32:30 Tower7 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Feb 24 08:32:30 Tower7 kernel: CR2: 00001455a3905d88 CR3:
000000026dba6000 CR4: 0000000000350ef0
Feb 24 08:32:30 Tower7 kernel: Call Trace:
Feb 24 08:32:30 Tower7 kernel: <TASK>
Feb 24 08:32:30 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
Feb 24 08:32:30 Tower7 kernel: ? start_transaction+0x46e/0x5e0
Feb 24 08:32:30 Tower7 kernel: ? hrtimer_nanosleep_restart+0x50/0x60
Feb 24 08:32:30 Tower7 kernel: transaction_kthread+0xf0/0x170
Feb 24 08:32:30 Tower7 kernel: ? __pfx_transaction_kthread+0x10/0x10
Feb 24 08:32:30 Tower7 kernel: kthread+0x1ce/0x1e0
Feb 24 08:32:30 Tower7 kernel: ? finish_task_switch.isra.0+0x13c/0x210
Feb 24 08:32:30 Tower7 kernel: ? finish_task_switch.isra.0+0x139/0x210
Feb 24 08:32:30 Tower7 kernel: ? __pfx_kthread+0x10/0x10
Feb 24 08:32:30 Tower7 kernel: ? __pfx_kthread+0x10/0x10
Feb 24 08:32:30 Tower7 kernel: ret_from_fork+0x24/0x130
Feb 24 08:32:30 Tower7 kernel: ? __pfx_kthread+0x10/0x10
Feb 24 08:32:30 Tower7 kernel: ret_from_fork_asm+0x1a/0x30
Feb 24 08:32:30 Tower7 kernel: </TASK>
Feb 24 08:32:30 Tower7 kernel: ---[ end trace 0000000000000000 ]---
Feb 24 08:32:30 Tower7 kernel: BTRFS: error (device sdc state EA) in
cleanup_transaction:2021: errno=3D-11 unknown

On Tue, Feb 24, 2026 at 7:02=E2=80=AFAM Naohiro Aota <Naohiro.Aota@wdc.com>=
 wrote:
>
> On Tue Feb 24, 2026 at 1:03 AM JST, Jorge Bastos wrote:
> > Thanks for the reply, I'm afraid I'm using a built kernel, and
> > building my own with debug info is beyond my knowledge.
> >
> > Gemini believes the issue may be caused by too many open zones. I've
> > monitored blkzone report output, and there are typically >100 zones in
> > the 'Implicitly Open' or 'Explicitly Open' state, and I've seen it go
> > over 120 before.
> >
> > I checked the queue limits for the device and
> > /sys/block/sdb/queue/max_active_zones reports 0
> > but
> > /sys/block/sdb/queue/max_open_zones reports 128
> >
> > Could it be that btrfs is hitting the max_open_zones limit and
> > receiving EAGAIN (-11) during btrfs_commit_transaction, possibly
> > because it isn't self-limiting based on the max_open_zones value when
> > max_active_zones is 0."
>
> Not really. Btrfs now limits by max_open_zones as below in zoned.c
>
>         max_active_zones =3D min_not_zero(bdev_max_active_zones(bdev),
>                                         bdev_max_open_zones(bdev));
>
> And, EAGAIN basically should be coming from
> btrfs_check_meta_write_pointer() when there is a hole in a writing
> region. Usually at the transaction commit phase, all metadata in the
> writing region should be allocated and ready for sequential writing. So,
> something wrong happens here either mis-ordering or mis-skipping a
> block.
>
> >
> > Thanks,
> > Jorge
> >
> > On Mon, Feb 23, 2026 at 3:15=E2=80=AFPM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 2/23/26 3:59 PM, Jorge Bastos wrote:
> >> > Hi,
> >> >
> >> > I'm using a zoned device for the first time; it's a 27TB WD Ultrasta=
r
> >> > HC680, formatted with single data and DUP metadata.
> >> >
> >> > This will be used for non-critical WORM media data, but during the
> >> > initial data load, using a single rsync thread, the filesystem crash=
ed
> >> > twice, 1st time after copying around 1.25T, 2nd time around 2.5T
> >> > total.
> >> >
> >> > I'm now using some mount options suggested by LLMs, and it hasn't
> >> > crashed so far, but it's not been long; currently at 3.58T used.
> >> >
> >> > mount -o rw,noatime,commit=3D60,flushoncommit,discard=3Dasync
> >>
> >> discard=3Dasync doesn't make a lot of sense on zoned and it will be ig=
nored.
> >>
> >>
> >> > My question is, are these mount options good for HM-SMR or do you
> >> > recommend different ones, and could they help with the crashing?
> >> >
> >> >
> >> > These were the crashes I saw, they look similar to me, and after
> >> > unmounting and remounting, it worked again:
> >>
> >>
> >> Yes these errors are transient (luckily).
> >>
> >>
> >> > Kernel 6.18.9
> >> > btrfs-progs v6.17.1
> >> >
> >> > 1st one:
> >> >
> >> > Feb 22 21:35:56 Tower7 kernel: BTRFS: error (device sdb) in
> >> > btrfs_commit_transaction:2536: errno=3D-11 unknown (Error while writ=
ing
> >> > out transaction)
> >> > Feb 22 21:35:56 Tower7 kernel: BTRFS info (device sdb state E): forc=
ed readonly
> >> > Feb 22 21:35:56 Tower7 kernel: BTRFS warning (device sdb state E):
> >> > Skipping commit of aborted transaction.
> >> > Feb 22 21:35:56 Tower7 kernel: ------------[ cut here ]------------
> >> > Feb 22 21:35:56 Tower7 kernel: BTRFS: Transaction aborted (error -11=
)
> >> > Feb 22 21:35:56 Tower7 kernel: WARNING: CPU: 8 PID: 109946 at
> >> > fs/btrfs/transaction.c:2021 btrfs_commit_transaction+0x994/0xb20
> >> > Feb 22 21:35:56 Tower7 kernel: Modules linked in: md_mod br_netfilte=
r
> >> > nft_compat af_packet veth nf_conntrack_netlink xt_nat iptable_raw
> >> > xt_conntrack bridge stp llc xfrm_user xfrm_algo xt_set ip_set
> >> > xt_addrtype xt_MASQUERADE xt_tcpudp xt_mark tun nf_tables nfnetlink
> >> > ip6table_nat iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
> >> > nf_defrag_ipv4 ipmi_devintf ip6table_filter ip6_tables iptable_filte=
r
> >> > ip_tables x_tables macvtap macvlan tap mlx5_core mlxfw tls igb
> >> > intel_rapl_msr amd64_edac edac_mce_amd edac_core intel_rapl_common
> >> > kvm_amd ast kvm drm_shmem_helper drm_client_lib drm_kms_helper
> >> > ipmi_ssif ghash_clmulni_intel aesni_intel drm rapl acpi_cpufreq
> >> > backlight i2c_algo_bit input_leds joydev led_class ccp i2c_piix4
> >> > i2c_smbus acpi_ipmi ses enclosure i2c_core k10temp ipmi_si button
> >> > zfs(PO) spl(O) [last unloaded: md_mod]
> >> > Feb 22 21:35:56 Tower7 kernel: CPU: 8 UID: 0 PID: 109946 Comm:
> >> > btrfs-transacti Tainted: P        W  O        6.18.9-Unraid #4
> >> > PREEMPT(voluntary)
> >> > Feb 22 21:35:56 Tower7 kernel: Tainted: [P]=3DPROPRIETARY_MODULE,
> >> > [W]=3DWARN, [O]=3DOOT_MODULE
> >> > Feb 22 21:35:56 Tower7 kernel: Hardware name: Supermicro Super
> >> > Server/H11SSL-i, BIOS 2.4 12/27/2021
> >> > Feb 22 21:35:56 Tower7 kernel: RIP: 0010:btrfs_commit_transaction+0x=
994/0xb20
> >> > Feb 22 21:35:56 Tower7 kernel: Code: ba ff 49 8b 7c 24 60 89 da 48 c=
7
> >> > c6 2a 81 57 82 e8 81 14 a9 ff e8 2c ef ba ff eb 10 89 de 48 c7 c7 4b
> >> > 81 57 82 e8 6c d5 b1 ff <0f> 0b 41 b0 01 41 83 e0 01 89 d9 ba e5 07 =
00
> >> > 00 4c 89 e7 48 c7 c6
> >> > Feb 22 21:35:56 Tower7 kernel: RSP: 0018:ffffc9003cac7de0 EFLAGS: 00=
010282
> >> > Feb 22 21:35:56 Tower7 kernel: RAX: 0000000000000000 RBX:
> >> > 00000000fffffff5 RCX: 0000000000000002
> >> > Feb 22 21:35:56 Tower7 kernel: RDX: 0000000000000027 RSI:
> >> > ffffffff825f9e70 RDI: 00000000ffffffff
> >> > Feb 22 21:35:56 Tower7 kernel: RBP: ffff88826a27d000 R08:
> >> > 0000000000000000 R09: 0000000000000000
> >> > Feb 22 21:35:56 Tower7 kernel: R10: 0000000000000000 R11:
> >> > 00000000312d2072 R12: ffff888290a1b7e0
> >> > Feb 22 21:35:56 Tower7 kernel: R13: ffff888249304c00 R14:
> >> > ffff88826a27d000 R15: ffff888100ec6300
> >> > Feb 22 21:35:56 Tower7 kernel: FS:  0000000000000000(0000)
> >> > GS:ffff88a04997c000(0000) knlGS:0000000000000000
> >> > Feb 22 21:35:56 Tower7 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
> >> > Feb 22 21:35:56 Tower7 kernel: CR2: 00007ffcad620af8 CR3:
> >> > 00000001f5915000 CR4: 0000000000350ef0
> >> > Feb 22 21:35:56 Tower7 kernel: Call Trace:
> >> > Feb 22 21:35:56 Tower7 kernel: <TASK>
> >> > Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> >> > Feb 22 21:35:56 Tower7 kernel: ? start_transaction+0x46e/0x5e0
> >> > Feb 22 21:35:56 Tower7 kernel: ? hrtimer_nanosleep_restart+0x50/0x60
> >> > Feb 22 21:35:56 Tower7 kernel: transaction_kthread+0xf0/0x170
> >> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_transaction_kthread+0x10/0x10
> >> > Feb 22 21:35:56 Tower7 kernel: kthread+0x1ce/0x1e0
> >> > Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> >> > Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> >> > Feb 22 21:35:56 Tower7 kernel: ? finish_task_switch.isra.0+0x139/0x2=
10
> >> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> >> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> >> > Feb 22 21:35:56 Tower7 kernel: ret_from_fork+0x24/0x130
> >> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> >> > Feb 22 21:35:56 Tower7 kernel: ret_from_fork_asm+0x1a/0x30
> >> > Feb 22 21:35:56 Tower7 kernel: </TASK>
> >> > Feb 22 21:35:56 Tower7 kernel: ---[ end trace 0000000000000000 ]---
> >> > Feb 22 21:35:56 Tower7 kernel: BTRFS: error (device sdb state EA) in
> >> > cleanup_transaction:2021: errno=3D-11 unknown
> >>
> >> The FS is trying to commit a transaction and something down the path i=
s
> >> returning EAGAIN. Would be interesting who did it.
> >>
> >> Do you have the debug info for this kernel, so we can find out where i=
t
> >> breaks?
> >>

