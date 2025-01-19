Return-Path: <linux-btrfs+bounces-10998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5FA15FC9
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 02:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10CD3A6407
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 01:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188D3E56C;
	Sun, 19 Jan 2025 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCeyEh+f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1C6FC3
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737249802; cv=none; b=jPpZ9Fw8Saeg1QTUZf3ao9j62kQbA3LehMFqZa5qJyJ8bVJFu/IHkQAkjzRcYqCGw5NREKWmDLC83qACoFc78GkSuqLj+wRC+GVmCb1/kSp8OZ2tSVCCSenCOjKhEQr4DcAIHBCkwhK5VwaJ25+EWX/4yAMneWnd/xpNmlAquR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737249802; c=relaxed/simple;
	bh=WrtgAH/HsMyxHusP7YshFCh64Z3OWFYnhb/IzBUyPiw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jkuoGsttTRJRMDxpLdmsYCrDiLqdznUlEsW+YHNH6JKInJYvIOYWo95wKHaB9fkV/892Gebg3sbsOUWVDgfop11WCrRca4XN4Wj5zNM3vcbU1etnglqumLZ7V5TXP/PZl6DD7Ouyqq0dLo02EWGubxKE3b3TDFVYe9+Jd+DW9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCeyEh+f; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e4419a47887so4910674276.0
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jan 2025 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737249799; x=1737854599; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/Q9Tuhz89l90hTw87Wazxs3Jf87Euf5WUkwGEm9Zk8=;
        b=YCeyEh+fj1INgsDXBhff16eqH1KeQJwA4z4AyTZlqKdqQwMEG6opabIe/56AOu0ay2
         0AhZZ1p1QDfPJz9joBT7PhKzZZLgUuHeBvFV/4xYzlXkJ+UyPp4GT8yb9KaD/HoSXBGo
         mjnb966EADqZiRzSSZsEzyBZAKEHEsTHij1xrYfysKb909AOOhyUgW/s8g3v2zv94UlV
         G0vNyvj7NltUprKjX5c4UiN4khZOAmiwVIxuukh+eaTGKvzOHV4464nTVpZfC3BgBNq9
         x6SFUjmXRnBmtUhPkYyHVwHYPoYR1o8FEssrzWv/Wd3hJYvbIDs6dYIEUZHE6WxpL2Ep
         nhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737249799; x=1737854599;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/Q9Tuhz89l90hTw87Wazxs3Jf87Euf5WUkwGEm9Zk8=;
        b=Qz3OWb31oMIIPwJyvImOEfKyradn/OnlG3m7TSwKrzrLQDigabaEeD2KAmoxFVPxtj
         1l3n11EtAcfNHrHrhMjWUGreA/JVBpSupD4pZCNkbqC67HoPLoV2IPbtrofjTC9INTJ/
         cIJo8QW4dLyoPgeNUPcBXDKNpc6YEbA4MdsHrY+KnrUcJxr2EqA8+HgI1e3/jtcq2wcT
         wOTL11zZ/74zA2W33LZ8JdoJtOvReoiBTJ/pkAWVGglnXJZdp/4815vK+3Xke9JOm5tQ
         F5OQ+uUSSJXm5yBCDhT6BbIwI9RyzFj07R9CUlEgIV7NyUQdSYPlb0U+/cCUIO85FmwZ
         0NtA==
X-Gm-Message-State: AOJu0YwikTwd11lemmV9y/bn0to/55Pg0vKtsTqo6a/pwaYSI9VrVLMX
	Py1IKyBHerlQYvkzL7kGO39eFJSWoRurMJme1lTk4nZjoK0LETzOyBp3x+amg+whiKl0QIA2ojX
	EGRon2nLWVxEeMlr4IK4drVMkmIKLHdWiHsQ=
X-Gm-Gg: ASbGncvc5XSGh2LP+aBQQthbv5DaXfndYXvv9w1YsCRWGkAKNBt923gZoDcXP4+LlTk
	omexvZOAbHaeIi16cq5fDbI/zv0YiGUjCUYcunwmIX1ZwxEjvvpY=
X-Google-Smtp-Source: AGHT+IELAKxfhDhhVA4qPP+X0eeu6a0nG6D0SHEJAFJsMdz6FwBsI1z+VPtsOxK/Pglcp4rI67AJE3yPLfjW1EaiGXU=
X-Received: by 2002:a05:690c:f0a:b0:6ef:5fee:1ca6 with SMTP id
 00721157ae682-6f6eb6b08c3mr63521197b3.18.1737249799153; Sat, 18 Jan 2025
 17:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave T <davestechshop@gmail.com>
Date: Sat, 18 Jan 2025 20:23:08 -0500
X-Gm-Features: AbW1kvZWa6GMeINlT216LWVFY3azr7bAYzGYitVJHsuGXdXHML7ElzCIayFhsdE
Message-ID: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
Subject: BTRFS critical: unable to find chunk map for logical
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I have BTRFS running on a laptop with a SK Hynix Gold P31 NVMe 2TB
drive. Since I started using this drive I have seen a few BTRFS
errors, but scrub has been able to fix them. But today I went one step
further and found this "critical" error. Here's how it happened.

I was downloading a large (4GB) file when my filesystem went
read-only. I was not out of space. I rebooted. After rebooting,
everything seemed fine. I ran my usual BTRFS maintenance, which is a
filtered balance and scrub. No errors were found. (This is the 2nd or
3rd time I have seen this exact scenario since I upgraded to the SK
Hynix SSD.)

This time I decided to run full balance without filters. That task
failed the first time with the error:

BTRFS info (device dm-0): balance: ended with status: -22

The filtered balance ran successfully again, but the second full
balance also failed with:

BTRFS critical (device dm-0): unable to find chunk map for logical
404419657728 length 16384

I will paste most of my console output with just a few parts trimmed
to make it less redundant. My bash function for the filtered balance
is included too.

balance() {
        echo "starting btrfs balance for $path"
        path=$1
        runtime=0
        while [ $runtime -le $max_runtime ] && [ $dval -le $max_dusage ]
        do
                echo "starting btrfs balance with $dval, $mval ..."
                start=$(date +%s)
                time btrfs balance start -dusage=$dval -dlimit=2..10
-musage=$mval -mlimit=2..10 "$path"
                end=$(date +%s)
                runtime=$(( $end - $start ))
                #echo "runtime = $runtime"
                dval=$(( $dval + $step_size ))
                mval=$(( $mval + $step_size ))
        done
}

dval=15
mval=15
runtime=0
max_dusage=100 #btrfs balance filter parameter for maximum dusage so
balance does not run a very long time
max_runtime=360 #if any balance iteratin exceeds this time, that is
the last balance run on that path
step_size=5 #increment of dusage and musage filter parameters with
each loop iteration

Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/rootluks  1.9T  733G  1.1T  40% /
Overall:
    Device size:                   1.80TiB
    Device allocated:            741.04GiB
    Device unallocated:            1.08TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                        731.96GiB
    Free (estimated):              1.08TiB      (min: 1.08TiB)
    Free (statfs, df):             1.08TiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:736.01GiB, Used:728.07GiB (98.92%)
   /dev/mapper/rootluks  736.01GiB

Metadata,single: Size:5.00GiB, Used:3.90GiB (77.98%)
   /dev/mapper/rootluks    5.00GiB

System,single: Size:32.00MiB, Used:112.00KiB (0.34%)
   /dev/mapper/rootluks   32.00MiB

Unallocated:
   /dev/mapper/rootluks    1.08TiB

starting btrfs balance for /
starting btrfs balance with 15, 15 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 20, 20 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 25, 25 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 30, 30 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 35, 35 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 40, 40 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 45, 45 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 50, 50 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 55, 55 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 60, 60 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 65, 65 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 70, 70 ...
Done, had to relocate 2 out of 743 chunks

starting btrfs balance with 75, 75 ...
Done, had to relocate 3 out of 743 chunks

starting btrfs balance with 80, 80 ...
Done, had to relocate 4 out of 743 chunks

starting btrfs balance with 85, 85 ...
Done, had to relocate 5 out of 743 chunks

starting btrfs balance with 90, 90 ...
Done, had to relocate 3 out of 741 chunks

starting btrfs scrub ...
Starting scrub on devid 1
scrub done for xxxxxxxxxxx
Scrub started:    Sat Jan 18 13:23:04 2025
Status:           finished
Duration:         0:05:15
Total to scrub:   732.04GiB
Rate:             2.32GiB/s
Error summary:    no errors found

btrfs bal start /
WARNING:

        Full balance without filters requested. This operation is very
        intense and takes potentially very long. It is recommended to
        use the balance filters to narrow down the scope of balance.
        Use 'btrfs balance start --full-balance' option to skip this
        warning. The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting balance without any filters.
ERROR: error during balancing '/': Invalid argument
There may be more info in syslog - try dmesg | tail

# dmesg | tail
[  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000074c0e2887ced
[  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI: 0000000000000003
[  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09: 0000000000000000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15: 0000000000000000
[  +0.000004]  </TASK>
[  +0.000001] ---[ end trace 0000000000000000 ]---
[ +15.464049] BTRFS info (device dm-0): balance: ended with status: -22
[Jan18 14:39] perf: interrupt took too long (2506 > 2500), lowering
kernel.perf_event_max_sample_rate to 79800

starting filtered btrfs balance again...
[...]
starting btrfs balance with 90, 90 ...
Done, had to relocate 5 out of 739 chunks

starting btrfs scrub ...
Starting scrub on devid 1
scrub done for xxxxxxxxx
Scrub started:    Sat Jan 18 14:54:41 2025
Status:           finished
Duration:         0:04:59
Total to scrub:   732.45GiB
Rate:             2.45GiB/s
Error summary:    no errors found
Finished btrfs maintenance.


btrfs bal start /
WARNING:

        Full balance without filters requested. This operation is very
        intense and takes potentially very long. It is recommended to
        use the balance filters to narrow down the scope of balance.
        Use 'btrfs balance start --full-balance' option to skip this
        warning. The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting balance without any filters.
ERROR: error during balancing '/': Input/output error
There may be more info in syslog - try dmesg | tail

dmesg | tail -n 40
[  +1.771510] BTRFS info (device dm-0): found 28 extents, stage: move
data extents
[  +0.316996] BTRFS info (device dm-0): found 28 extents, stage:
update data pointers
[  +0.220585] BTRFS info (device dm-0): relocating block group
1585334714368 flags data
[  +1.846705] BTRFS info (device dm-0): found 24 extents, stage: move
data extents
[  +0.354401] BTRFS info (device dm-0): found 24 extents, stage:
update data pointers
[  +0.204265] BTRFS info (device dm-0): relocating block group
1584260972544 flags data
[  +1.731777] BTRFS info (device dm-0): found 32 extents, stage: move
data extents
[  +0.213906] BTRFS info (device dm-0): found 32 extents, stage:
update data pointers
[  +0.172966] BTRFS info (device dm-0): relocating block group
1583187230720 flags data
[  +2.552611] BTRFS info (device dm-0): found 30749 extents, stage:
move data extents
[Jan18 15:43] BTRFS info (device dm-0): found 30749 extents, stage:
update data pointers
[  +4.242339] BTRFS info (device dm-0): relocating block group
1579966005248 flags data
[  +1.595657] BTRFS info (device dm-0): found 1399 extents, stage:
move data extents
[  +1.134944] BTRFS info (device dm-0): found 1399 extents, stage:
update data pointers
[  +0.766037] BTRFS info (device dm-0): relocating block group
1578892263424 flags data
[  +1.355692] BTRFS info (device dm-0): found 31 extents, stage: move
data extents
[  +0.202763] BTRFS info (device dm-0): found 31 extents, stage:
update data pointers
[  +0.162848] BTRFS info (device dm-0): relocating block group
1577818521600 flags data
[  +1.329057] BTRFS info (device dm-0): found 21 extents, stage: move
data extents
[  +0.148113] BTRFS info (device dm-0): found 21 extents, stage:
update data pointers
[  +0.125740] BTRFS info (device dm-0): relocating block group
1576744779776 flags data
[  +1.325564] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.118156] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.093427] BTRFS info (device dm-0): relocating block group
1575671037952 flags data
[  +1.416460] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.133543] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.107911] BTRFS info (device dm-0): relocating block group
1574563741696 flags data
[  +1.765062] BTRFS info (device dm-0): found 862 extents, stage: move
data extents
[  +0.951968] BTRFS info (device dm-0): found 862 extents, stage:
update data pointers
[  +0.628234] BTRFS info (device dm-0): relocating block group
1573489999872 flags data
[  +1.721233] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.275571] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.155941] BTRFS info (device dm-0): relocating block group
1572416258048 flags data
[  +2.470482] BTRFS info (device dm-0): found 21244 extents, stage:
move data extents
[  +8.365052] BTRFS info (device dm-0): found 21244 extents, stage:
update data pointers
[  +5.340568] BTRFS info (device dm-0): relocating block group
299998642176 flags data
[  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
move data extents
[  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
for logical 404419657728 length 16384
[  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
for logical 404419657728 length 16384
[Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: -5

