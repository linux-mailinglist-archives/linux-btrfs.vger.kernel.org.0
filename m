Return-Path: <linux-btrfs+bounces-21504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEX1BSXxiGlNzQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21504-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:25:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146B10A182
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B403300CC20
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 20:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27620342C9E;
	Sun,  8 Feb 2026 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGQ/8LoY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7B33F394
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770582297; cv=none; b=R+cIyNnAZa0gEKeQAv+L/oSmQWoEK0/LyDu8tYVeFgqXLCSdIDSfjVC8+8hqo5ChJWLAvpCVeUvovfu2zno7SIaUaFaNlQK3m3/UP9tf1Y7av1Dbbdv9eE5gCs225PU9LcPhHYNN95WnpjNal97rKBsrdQGeN+eJBWbpIJIEkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770582297; c=relaxed/simple;
	bh=7I5tpO5lnpAjUdoPJlZ1e8rzJIirROGyAbdC46pMEuc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qV9bsEvae2r4YaS9XlycE6Pea/ZMjbLIrqT3ASfnKru43fpDPpcX/Bu68OjyXTVW4AQNy6D7GFI4i3MY+Q9+D3ngckedGJnOKn1iHCv2z+67VJdCS3TPNk9okzLo5TIoFdgAEZ6TCgt4whBalFHfjxPDRMzYGm/x0k8kQmkB9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGQ/8LoY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso36180115e9.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 12:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770582295; x=1771187095; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:autocrypt:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No9hZh/TPs6Rz123TtgTM22XGXcBCHjjm/8jeiUo7sg=;
        b=ZGQ/8LoY96ZkXypCTt7hWZHPoB64n8yFKijpk318BX7Ksv9wtWRdmxig/cvm2b8pg3
         OeKtFrpJvIL7OSV1V3G62toIhAeqlDsOcUZShfDiiGeE6Mq17IiuL0s1DqHUfPTnKM2h
         4+kGp7fMS0CXre62E75aEx+NWYmAMoHetNBbgWg+upgWZIJ4Dfit9yFqHRqygFGB+sKo
         rjSdmIciKUzKmJIn//o775vRmrsMfZm3AQo17upE/5q4KcDiAAzJo+PuyCrdQIGWiOCw
         7EtVFyaXOYdC04dxbH+1R56wS17hZ2cnUxswKiPtx088QsWyIkkyZJ2pkPztSlU/8yH4
         /NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770582295; x=1771187095;
        h=content-transfer-encoding:subject:autocrypt:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=No9hZh/TPs6Rz123TtgTM22XGXcBCHjjm/8jeiUo7sg=;
        b=Q8T6DfsDEcSHi/Huwj6YyVXUSl7VMUKYQyid4qmixx25hVYVSrNPoXhNoT/madWwsy
         Nq2ycKc5zH2+sdhwstJloUrBb7MXMe0XQPts8dkmXV7pCQOTDOoM180rkZtN1KZ2q5qT
         gQMXy61qWRqjr3UOmjnF93K+WK7clru2xbWY2RvOLcsGEa73Dd5PPC8lxfnIEzTrRy8p
         XLFhYtEZsjp/3pGG62RzSLgGzyQSJCW2JFZji8Em09h88acvR6OIpRFN6Ue9pGMwGJlI
         8gBW/o3+bWpYUIi1S3gNj3tqft63BlEfjQr7zROQf7XAB05qfjsfidV0daPEqF7lW9CB
         ni4Q==
X-Gm-Message-State: AOJu0YyZM5p0bQAU6EQQQI8q5bWz4R6QmtsGZopfvc2fmFLYPJQ9Y0JG
	ElDL9gvSDfXIhPK4gOSKKxRG+B08b0UgpQjG1kUYkFHQLJBzhW5CoyzDUNoPLA==
X-Gm-Gg: AZuq6aJmWIuUE4Gb9yyH+3NfLZ/XsHiyMFfshpIC9MW9Ao3SE7ieZkb8u96Dk4ddCRD
	HtI5nZwESeFBE3pDhwCEULIYwfJY1lfZM9j4tC0N3HH2M8+rtqWizRxB6mg/zZ4MCQL9esyGPzm
	/LxadakzS3jpxvdgPNFvUbjuZJhY4/44IH3ZttulCNQWbNxfzgtD6LkTuYYcWPZ5sOStUVHAQnK
	SblaHtqM7nlyuPSmzyllNO3ykF2z6+1tDithF0184CARu2gn1pvi0JpXoj4J10NHNxqMtebceax
	Jj7IH5h6IQgW0IM6y1BBUq9nUNNeSglTWIfl5lQwKbthYJ744UEO8gqyhxv7gjwzTlWmGk2DlIl
	SFVBgFeHivQZ6GvduKX4kDU65kcupQG9nFWGXLSV9l8+xjpwWu71QQtvf97KF1mSOQ5RQ+ira1V
	HBQfycMEr5QhZj30P94vPuOI0Z4we6MJIOsGyIlXwzBFAS3EvfJzoR95q1e3ar/vIaG7dczS8=
X-Received: by 2002:a05:600c:6986:b0:480:1c1c:47d6 with SMTP id 5b1f17b1804b1-483203ab641mr131408965e9.6.1770582294665;
        Sun, 08 Feb 2026 12:24:54 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1978:7401:8935:e471:7003:e5cc? ([2a0a:ef40:1978:7401:8935:e471:7003:e5cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203e37f9sm94193475e9.3.2026.02.08.12.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 12:24:53 -0800 (PST)
Message-ID: <0c33ef9a-24b1-43a6-9f93-72249b1cceac@gmail.com>
Date: Sun, 8 Feb 2026 20:24:52 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Qiyu Yan <yanqiyu01@gmail.com>
Autocrypt: addr=yanqiyu01@gmail.com; keydata=
 xsFNBF6yAhQBEADsMD+lk6hzk5Cr47oC/LdvnMrX5YULzcBcSBj+MJ+mWxQajQRIripNMU0Z
 08SvopYr/WNhqFRy+f+DdBVuUGKqzmXJ2Hy3FI2raaXueJllxCuxjyUT6D/EWDaC26NOVfbF
 bJ2qZkksSJniHmwjYVq160o9bTNSNMsm6ZkKcZfbI/K+qUgF7R1GalxYSHZzDNomN5AExJ85
 2Aou8tfPW36brFR5P2s98NZ2mZP4A8uXPcZEXyTXNudwqxF+bh1/awnx5rBZr7iylLcjgxgF
 29GNG4TvuX9EdXWEoemn5TLix94AJBtQyczPZ/aCDjyN2fCl6u2/SveBP1wDztmYnKqsyq+N
 PhuC5DtqfSRhc+9+Xq215WCKPjdSYIAXaqbjcDILbNb/MDsH29E9M4AyUydLtrQ65+hhnTXb
 mFFTHJln/MO7bnixaPrkIe1eTzXFub08nhcKQKZMLZa9Q3wh+rc8cIM4RqOnvEC0WHTz6M75
 ZskKq4kyVw2MgkHfRTCQyKQeSSqfF4Pbvnn5eCIWFBC0iCUHtz40zcmEu7XfVTGsPtSw+COw
 ZE2//mtqQk0myvGOXpzDbuVWdqPDCTF7X4v6QAiT5szp+W21Gk3FqVXumOqn/ot9qsvJfF5V
 lNXl3ZLG2Iygu9mtKtMw//SYVkarq0by/FhNpoOImD6ohPIFLQARAQABzS1LYXJ1Ym9uaXJ1
 IChLYXJ1Ym9uaXJ1KSA8eWFucWl5dTAxQGdtYWlsLmNvbT7CwZEEEwEIADsCGwMFCwkIBwIG
 FQoJCAsCBBYCAwECHgECF4AWIQSpO+x6D2gs+0BcMOhPyRTwZfLfEgUCX0B2jQIZAQAKCRBP
 yRTwZfLfEq77EACN5pJaWRlG9AwZ+gesmdpm+mtw0kRhUH+bvJqjdwVV5L6vBbUtpsB+b6yf
 jyN+ZjTxirYTT5Ci2yxxueApES8d4VaHNERk1S2mcUdcHGEQEkSzrCN4jIUyTAm5eeo7Yryv
 pUnfVQNkc/RpQwg+4nKo675eGxduGT9wvhEv2izNo3VNONEilMwleqyvq27BnNT4xwVqJJpH
 VotIVHHRXPbcGF6ubAG+wHBMM7iv0W9RPSw3LzJ0Hv2OzeXXNMa1TpYj+E0FDGoeQAkodATM
 7pLC1pL7vHvqf//I9H2R6KT3gFoR9FPqSMh7fAL9uUKOr8ub2kY5OqjFOnubZYs226vIG27g
 m/thzmgplOrjnSxPELg2ms2RU7dmbiswvpFM9W0LjQUOojsR4z+9FDQ4S2pT6cGaVQ2S40+q
 kA3cQ3uS5eGsDYkqVE8YsDTs9g1CrB0wHKd6m6z3Axw3oVz+KpmDiCBUHjUZJHytfmfyijDk
 a4WMTMNV9/u1erFnhjRbjRUhyDY1OUrhX/UwEpRjIrZRh841iVZMHBfYsXFiWysNf+9BchtP
 x1QRegEeraDaed0UTE/ynsI9W9J0+HxMJOIlvl8BVwQw/lhZg/qt1po/7H6TM40hI48MvaWf
 TmNA7ooIdW0loeT8oVHVRRDNHZgZPkljijwsBS6psniNi3mmLc7DTQRoptQPEBAAtaoLRjUI
 C0E34gFaF3hm7MDm0KgVgBIzbWQGByflKedWABQUYOg0MWkwlfs9VWQfINaeaCCjSxsyudS/
 cgUpufcDy4YKiK3xS2lVZAR6sWTihPdPAFeItS5Qjzd4HBkdj519M//QneeZ3/8i4ligKdzN
 IheECXezrYoAvke+wiGonLE+5uLsR2smaU7cgRTJSrQA402/FCp4o2BnqyJa95zgOnlVxUMY
 dcPgrOIKWJG2rKXP3zoaq9NBKdRf2tz4deU+cDZP2Y7QoS6l4ud8H7iXvtB5eL520Lz5juC8
 lxaZOZDJyj5RvCTjtNbua8gWbknaFTMkxa926JGq5BK+gNUYhdhe/utJ1/ysJVRBwH69EQEK
 gQaLuCZlIHyahWE0l2ikyizLguy6x1bkjyC43t5N4nVRD89ZPgqkuMI8A7frJoV2Bkha+Ukf
 cByD3NoCFolrzbBb2K2MUFGZ4go43D2SBwTwtRAiCsIiqc/E9TUk4tnHAvxJzfbQGuAOaRfR
 tWNmfZH+/oAWHNXQvG6MmGMPZz6ZocN6fqjjffTx/P2arh0qx/s009gMVg+OHYwAfoKg510T
 ZlFfFFjUevYWppvinUKVTbH1Y5uI8stz95++ZCqrvLeIgMZd3CuYtPw3pgnl9KBxY4EyAjWR
 /9yxBWQ7pkA00Quc0AMoNa2edfcAAwUP/ROqETnWuYRwzKW4dAZ69cEs4rOZp0x7YBBYVIA3
 x+iwgs/ONM1Y9nAX8MSHWbuIXUY2M/JDB3SXwfDnjAFw3PZW1RdGCW6zGT+4vFUUdgYmQ75j
 rIjboBeQrFXVxz3m7AEifvDyHYIX3S0B9HcHUuP8dluSyqOI4wDtVGjmn2LddebJm9Fi4mcY
 ozt8KNHabJI8rBgLD7O6pHrKxXL3HN1WmLXhniJPHItHUXOsgmuGR7PEd4K+OQlriYZawQPn
 0mWjQQj9ef+nm2xO9H0DqYzrPMw57FZ9LW1zjBOdAenwRGumgNQ49arYoQMjaGGhXiJenH/O
 930gDHe/ufkNvqdZWEus2MNqjYZo0nIwwUXZgEBt0j5nZ5D16SKsbz515XecWv6mNOZkHoyN
 y80M3y2xZbDC35gvpie3cC7xXS0WRb53rhpH+qK5K+CtyT15yxGdYZd3R/wV27JcQa8F9+Mn
 hMORrHqtMUxPA3qqYy0QC5mnlF1fHQMX969glEJ9AEedrk9YorQGrWJPsaXGu04ZEkOwqFnh
 DUBZbQnec9/7qKH/k53+S2KO0t2l6E7CBaW0BQeqqwiPibkaOmn2jyHzUOWFIleePjQ4oegj
 Bed9euXK4LWCvrlJlj3o+B4NdIOMkBwR4wZhjTI54S4owII1mc2QY6ZX4ENA5/sxLMdawsF2
 BBgBCgAgFiEEqTvseg9oLPtAXDDoT8kU8GXy3xIFAmim1A8CGwwACgkQT8kU8GXy3xKHRg//
 RgHM98dEjhCeuFJhu3iCDnU64egy1DIs/w1E0bDG/TUw5z12+FUw5lkCDyx4aRgu+LHjBeQT
 Iet5rVSntKAO+Sexs8IhYmUxDvXJcxLmBwP6XtL3VOAqSHpNltzyN3mXfZwaPxsVpeo5yn9g
 9kAV0UPEKbnBXlK3K7yFHvY2Rja1cBy+WXuaips/GhhaSwpT2SH5HI8YCA0oWPsbma2vw81c
 zIBhqU2he/FzNz/EfbEHuD+D4l20B70vsWhamIKM99szAGN6aqgo/ypmnJXfuX0+3iELHd9W
 Mn7c4+KAroAQRMb9nOjb3/TAjzXa4IC/aFkDAhDaDizKCD2LHykeUqcTwxZBXgqLlv6JTLmH
 DRuGA+5Z7LRVDRT3P4OE7OWHVdzmi9NXR65POMp7BCq/H052t2NBAZqoA9BlB1ajtpvPT0M4
 qLfi/wWo62D0de5/sh1wBS2N1OgsaX8N/OY/4hqcaUh64RZCrWFJxjUUkNhj1X0uteTSrTUF
 323cEt5w3rIegvWFeePPjPoZLe3EBg+tA0J+tiqlOZQbmHoAfeVddbmZJmRW1/QzKm0hzXQT
 qborf9eFXEuCNE7dDj2BSF+aY9EUe7lhfxLIHFWPf0QLXjryzw3dwfOaGitg8dPP5A4prx8R
 0/GqXYttz/srV15jCiDuGPfZQbeDq0BQ3sM=
Subject: [BUG] btrfs_commit_transaction error -11 on ZONED device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21504-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanqiyu01@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3146B10A182
X-Rspamd-Action: no action

Hi all,

I am facing another issue with btrfs on zoned device, the filesystem 
goes ro when writing several TBs of files to it (6.18.7-200.fc43.x86_64 
kernel)

BTRFS: error (device sdg) in btrfs_commit_transaction:2536: errno=-11 
unknown (Error while writing out transaction)
BTRFS info (device sdg state E): forced readonly
BTRFS warning (device sdg state E): Skipping commit of aborted transaction.
------------[ cut here ]------------
BTRFS: Transaction aborted (error -11)
WARNING: CPU: 4 PID: 44149 at fs/btrfs/transaction.c:2021 
cleanup_transaction+0xd0/0xe0
Modules linked in: nft_flow_offload nf_flow_table_inet nf_flow_table 
nft_nat nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib veth bridge 
cfg80211 vfio_pci vfio_pci_core vfio_iommu_type1 vfio iommufd macvlan 
wireguard libcurve25519 ip6_udp_tunnel udp_tunnel 8021q garp mrp stp llc 
rfkill nf_conntrack_netbios_ns nf_conntrack_broadcast nft_redir nft_masq 
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_chain_nat 
nf_nat nft_socket nf_socket_ipv4 nf_socket_ipv6 nft_ct nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nct6775 nct6775_core hwmon_vid 
binfmt_misc vfat fat intel_rapl_msr intel_rapl_common edac_mce_amd 
ipmi_ssif kvm_amd snd_hda_codec_nvhdmi xfs snd_hda_codec_hdmi 
snd_hda_intel kvm snd_hda_codec snd_hda_core snd_intel_dspcfg 
snd_intel_sdw_acpi irqbypass snd_hwdep rapl acpi_cpufreq snd_seq pcspkr 
snd_seq_device acpi_ipmi snd_pcm ipmi_si snd_timer ipmi_devintf snd 
i2c_piix4 ipmi_msghandler ptdma k10temp i2c_smbus soundcore mlx5_ib 
mlx5_fwctl macsec fwctl nfsd auth_rpcgss nfs_acl tcp_bbr
  lockd grace nfs_localio nvidia_drm(OE) nvidia_uvm(OE) 
nvidia_modeset(OE) drivetemp drm_ttm_helper nvidia(OE) ttm tun video wmi 
loop zram lz4hc_compress lz4_compress overlay erofs netfs mlx5_core 
nvme_tcp nvme nvme_fabrics polyval_clmulni nvme_core ghash_clmulni_intel 
ast mlxfw igb nvme_keyring psample nvme_auth dca hkdf i2c_algo_bit 
sp5100_tco be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls cxgb3i cxgb3 rpcrdma 
mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs sunrpc iscsi_tcp 
libiscsi_tcp rdma_ucm ib_uverbs ib_srpt ib_isert iscsi_target_mod 
target_core_mod ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm 
ib_ipoib scsi_dh_rdac iw_cm scsi_dh_emc scsi_dh_alua ib_cm fuse ib_core 
dm_multipath nfnetlink
CPU: 4 UID: 0 PID: 44149 Comm: btrfs-transacti Tainted: G     U  OE      
  6.18.7-200.fc43.x86_64 #1 PREEMPT(lazy)
Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./EPYCD8, 
BIOS L2.52 11/25/2020
RIP: 0010:cleanup_transaction+0xd0/0xe0
Code: be 00 48 8b 45 28 48 8d 4d 28 49 89 cf 48 39 c1 0f 85 a5 22 87 ff 
e9 9f 23 87 ff 44 89 ee 48 c7 c7 20 55 44 bd e8 a0 b3 9e ff <0f> 0b eb 
a8 0f 0b e9 5f ff ff ff 0f 1f 44 00 00 90 90 90 90 90 90
RSP: 0018:ffffcde5f977fda8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8d06c4fb7000 RCX: 0000000000000000
RDX: ffff8d2588a2b308 RSI: 0000000000000001 RDI: ffff8d2588a1cfc0
RBP: ffff8d06fbeef600 R08: 0000000000000000 R09: ffffcde5f977fc50
R10: ffff8d2586c7ffa8 R11: 00000000fffeffff R12: ffff8d070f6dea80
R13: 00000000fffffff5 R14: 00000000fffffff5 R15: ffff8d06c4fb7320
FS:  0000000000000000(0000) GS:ffff8d25c8429000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f09ffd76000 CR3: 0000000134139000 CR4: 0000000000350ef0
Call Trace:
  <TASK>
  btrfs_commit_transaction+0xb2e/0xd20
  transaction_kthread+0x157/0x1c0
  ? __pfx_transaction_kthread+0x10/0x10
  kthread+0xfc/0x240
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0xf4/0x110
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
---[ end trace 0000000000000000 ]---
BTRFS: error (device sdg state EA) in cleanup_transaction:2021: 
errno=-11 unknown
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3206 start=341311488 len=524288 cur_offset=341311488 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3206 start=341311488 len=524288: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3204 start=513343488 len=524288 cur_offset=513343488 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3204 start=513343488 len=524288: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3203 start=588185600 len=163840 cur_offset=588185600 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3203 start=588185600 len=163840: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3203 start=655785984 len=524288 cur_offset=655785984 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3203 start=655785984 len=524288: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3203 start=730791936 len=524288 cur_offset=730791936 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3203 start=730791936 len=524288: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3205 start=805634048 len=163840 cur_offset=805634048 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3205 start=805634048 len=163840: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3205 start=880115712 len=524288 cur_offset=880115712 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3205 start=880115712 len=524288: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3205 start=954957824 len=163840 cur_offset=954957824 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3205 start=954957824 len=163840: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3205 start=1029439488 len=524288 cur_offset=1029439488 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3205 start=1029439488 len=524288: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3205 start=1104281600 len=163840 cur_offset=1104281600 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3205 start=1104281600 len=163840: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3204 start=1284046848 len=524288 cur_offset=1284046848 
cur_alloc_size=0: -30
BTRFS error (device sdg state EA): cow_file_range failed, root=257 
inode=3205 start=1293680640 len=524288 cur_offset=1293680640 
cur_alloc_size=0: -30
submit_uncompressed_range: 1 callbacks suppressed
BTRFS error (device sdg state EA): submit_uncompressed_range failed, 
root=257 inode=3205 start=1293680640 len=524288: -30

Remount on git latest kernel also show similar error:

BTRFS: error (device vda) in btrfs_commit_transaction:2555: errno=-11 
unknown (Error while writing out transaction)
BTRFS info (device vda state E): forced readonly
BTRFS warning (device vda state E): Skipping commit of aborted transaction.
------------[ cut here ]------------
BTRFS: Transaction aborted (error -11)
WARNING: fs/btrfs/transaction.c:2037 at 
btrfs_commit_transaction+0xe24/0xef0, CPU#0: btrfs-transacti/588
CPU: 0 UID: 0 PID: 588 Comm: btrfs-transacti Not tainted 
6.19.0-rc8-00216-ge98f34af6116 #7 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
edk2-20251119-3.fc43 11/19/2025
RIP: 0010:btrfs_commit_transaction+0xe2c/0xef0
Code: 48 81 c7 50 03 00 00 e8 b2 9e 86 ff e9 7a fb ff ff 0f 1f 44 00 00 
e9 7d fb ff ff 48 8d 3d dc 39 b5 01 4c 8b 64 24 10 44 89 e6 <67> 48 0f 
b9 3a 48 8b 1c 24 e9 c9 fc ff ff e8 a1 0e d7 00 90 0f 0b
RSP: 0018:ffff9edd02247e20 EFLAGS: 00010296
RAX: 0000000000000013 RBX: ffff9211c6f68000 RCX: 0000000002040001
RDX: 0000000000000000 RSI: 00000000fffffff5 RDI: ffffffffa218e190
RBP: ffff9211c2cda300 R08: 0000000000001fff R09: ffffffffa1e5c870
R10: 0000000000005ffd R11: 00000000ffffdfff R12: 00000000fffffff5
R13: ffff9211c2832600 R14: ffff9211c28ab000 R15: ffff9211c2832600
FS:  0000000000000000(0000) GS:ffff921d6ceb3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f04aa9d8ae0 CR3: 000000010571f000 CR4: 0000000000350eb0
Call Trace:
  <TASK>
  transaction_kthread+0xe1/0x160
  ? __pfx_transaction_kthread+0x10/0x10
  kthread+0x20b/0x240
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0xad/0x160
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
---[ end trace 0000000000000000 ]---
BTRFS: error (device vda state EA) in cleanup_transaction:2037: 
errno=-11 unknown

Best,
Qiyu

