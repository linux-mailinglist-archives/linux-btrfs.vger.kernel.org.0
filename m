Return-Path: <linux-btrfs+bounces-14689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE9FADBD44
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 00:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B2A7A4827
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37D62264AF;
	Mon, 16 Jun 2025 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy8gv2w6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DD14C5B0
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114426; cv=none; b=Br3dmA2gjYLENE6rT+OvsaJn11EwkzN9Z/RnxmKpcDOjdYuT6ThqTTDubg0MGBa7yUjB8+Tuf26f9Vk1sDRtOVqEgC6sciOxJaYSIYfDuLiYMRuc/vTjB093TT/tXySh3eT6tLYwCbRgLrhIeSVbE1/vIXJOkKBIssJS/PE3PmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114426; c=relaxed/simple;
	bh=GEqV1vxjJE1d6qOclvq9wFLOjR46dNuNH2WG2mgvuBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta4Dmai7ZYziOl3v3wyvGbplUT4dFGXnGyihL39kfqzy/cTMXUtIvH0zpizBsXhAk6jQHdra/SZNfW6VLVaKJoR2pPL6G1j8Og+qOIsrw0icH3YwMdgN/81Ih326kLbo5jQQMFewIWDlWrXIQbW3tIXsSNiHhcaGuijGoE9w4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy8gv2w6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673EFC4CEEA
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 22:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750114425;
	bh=GEqV1vxjJE1d6qOclvq9wFLOjR46dNuNH2WG2mgvuBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qy8gv2w6Ky+QFxlCp2/8uv5JkZotCgehaco5NaPCWNctR7eo+jmxCXPkdA9HMa+e/
	 PIW5Pt6Jb7f0Juub4N1Tw1VbG3ra3p96vgENzdWwIen/YISlI8EpbuEe+gxY9RTxKc
	 E1ChY65qC+n+FKgzX1w5relA8lloZH4p0zWdOusTaDppefS8aPmct2fHmWlVp52koC
	 hKN1jaSesuef4KWFfubLxv2D0pR5EYcMnWXM/L7Li0zZe+Urr5avMoMx3vui5DYRLy
	 dN0WB+che3IqnMPrOH6E1Ta5+PMZ+1MyAa3dkdE5eyvYc6lLCastd+DT+CDB9IUirH
	 8FC4r2zLSkJaA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so8653811a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 15:53:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YzwgdiVd1KWYPgJ/cQfCirHsCDU/Bxc57Nm9SHPEUgrXUEqaxSf
	GXsEdMHAKlg2gYPgEd7qFmMwS4tJZAGVyLklHYE2olnuVc9n4y41Feea/QFK+XfvB5mlPdxdz8X
	9b9huPyZYzsnu0KPgAmBfNLVTYfg70FU=
X-Google-Smtp-Source: AGHT+IFHWiqovzfcQ8j4arko6wBaO0ZjQJouLnoxB6JsRkALoJVM+zEDqIIXthzHAzZTcG40yDy9ERF+18EyN2QIciE=
X-Received: by 2002:a17:906:f597:b0:ad1:e7f0:d8e5 with SMTP id
 a640c23a62f3a-adfad31a6b6mr1149223866b.16.1750114423812; Mon, 16 Jun 2025
 15:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <24414ba3107560a48f2e6a70e102de63b6bca4ca.1750112614.git.boris@bur.io>
In-Reply-To: <24414ba3107560a48f2e6a70e102de63b6bca4ca.1750112614.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Jun 2025 23:53:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6t2qrKQ7qudfUp68=LLOHHy5QqTz8C1FLWcu2v2FX-Dw@mail.gmail.com>
X-Gm-Features: AX0GCFvWTzQxQzQzVq8cA1LIbx1Wp2txYwkqao9fdnw3IBq8FNRemqBDUB3pyfw
Message-ID: <CAL3q7H6t2qrKQ7qudfUp68=LLOHHy5QqTz8C1FLWcu2v2FX-Dw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use readahead_expand on compressed extents
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 11:22=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> We recently received a report of poor performance doing sequential
> buffered reads of a file with compressed extents. With bs=3D128k, a naive
> sequential dd ran as fast on a compressed file as on an uncompressed
> (1.2GB/s on my reproducing system) while with bs<32k, this performance
> tanked down to ~300MB/s.
>
> i.e.,
> slow:
> dd if=3Dsome-compressed-file of=3D/dev/null bs=3D4k count=3DX
> vs
> fast:
> dd if=3Dsome-compressed-file of=3D/dev/null bs=3D128k count=3DY
>
> The cause of this slowness is overhead to do with looking up extent_maps
> to enable readahead pre-caching on compressed extents
> (add_ra_bio_pages()), as well as some overhead in the generic VFS
> readahead code we hit more in the slow case. Notably, the main
> difference between the two read sizes is that in the large sized request
> case, we call btrfs_readahead() relatively rarely while in the smaller
> request we call it for every compressed extent. So the fast case stays
> in the btrfs readahead loop:
>
> while ((folio =3D readahead_folio(rac)) !=3D NULL)
>         btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
>
> where the slower one breaks out of that loop every time. This results in
> calling add_ra_bio_pages a lot, doing lots of extent_map lookups,
> extent_map locking, etc.
>
> This happens because although add_ra_bio_pages() does add the
> appropriate un-compressed file pages to the cache, it does not
> communicate back to the ractl in any way. To solve this, we should be
> using readahead_expand() to signal to readahead to expand the readahead
> window.
>
> This change passes the readahead_control into the btrfs_bio_ctrl and in
> the case of compressed reads sets the expansion to the size of the
> extent_map we already looked up anyway. It skips the subpage case as
> that one already doesn't do add_ra_bio_pages().

Maybe add a comment in the code about why the subpage case is skipped?
And can't this be done for non-compressed extents too, why do we have
to skip them?


>
> With this change, whether we use bs=3D4k or bs=3D128k, the readahead wind=
ow
> opens up to the the largest compressed extent we have seen so far
> (in the trivial example: 128k) and the call stacks of the two modes look
> identical. Notably, we barely call add_ra_bio_pages at all. And the
> performance becomes identical as well. So this change certainly "fixes"
> this performance problem.
>
> Of course, it does seem to beg a few questions:
> 1. Will this waste too much page cache with a too large ra window?
> 2. Will this somehow cause bugs prevented by the more thoughtful
>    checking in add_ra_bio_pages?
> 3. Why only compressed extents?
> 4. Should we delete add_ra_bio_pages?
>
> My tenative answers/follow-ups:
> 1. Hard to say. See attempts at generic performance testing below. Is
>    there a "readahead_shrink" we should be using? Should we expand more
>    slowly, by half the remaining em size each time?
> 2. I think not. Since the new behavior is essentially indistiguishable
>    from reading the file with a larger read size passed in, I don't see
>    why one would be safe but not the other.
> 3. They have a nice natural cap on how big the readahead window will
>    get. It would almost certainly be a bad idea to expand it to the max
>    uncompressed extent size. Room for improvement here, though,
>    probably.
> 4. Probably! I tested that and it was fine in fstests, and it seems like
>    the pages would get re-used just as well in the readahead case.
>    However, it is possible some reads that use page cache but not
>    btrfs_readahead() could suffer.
>
> I tested the performance implications of this change in 3 ways (using
> compress-force=3Dzstd:3 for compression):
>
> Directly test the affected workload of small sequential reads on a
> compressed file (improved from ~300MB/s to ~1.3GB/s)
>
> Built the linux kernel from clean (no change)
>
> Ran fsperf. Mostly neutral results with some improvements and
> regressions here and there. Notably dbench looked a lot faster, but most
> of the fio jobs didn't show anything conclusive. Some read improvements
> on some of the fio tests, but also some regressions on commit latency
> that feel like noise, but hard to be sure. No horrendous, must fix
> regressions as far as I can see.
>
> FSPERF RESULTS (excluding irrelevant dio tests):
> bufferedrandwrite16g results
>       metric          baseline     current    stdev         diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> avg_commit_ms           2594.25     2607.85       0     0.52%
> commits                     106         105       0    -0.94%
> dev_read_iops                67         174       0   159.70%
> dev_read_kbytes            1072        2784       0   159.70%
> dev_write_iops          6182312     6172004       0    -0.17%
> dev_write_kbytes       50582368    50393220       0    -0.37%
> elapsed                     720         712       0    -1.11%
> end_state_mount_ns     42581144    44832716       0     5.29%
> end_state_umount_ns    7.83e+09    8.06e+09       0     2.96%
> max_commit_ms              4909        5009       0     2.04%
> sys_cpu                   16.54       16.58       0     0.25%
> write_bw_bytes         23906517    24164054       0     1.08%
> write_clat_ns_mean    170247.65   168027.72       0    -1.30%
> write_clat_ns_p50         24192       23680       0    -2.12%
> write_clat_ns_p99         77312       76288       0    -1.32%
> write_io_kbytes        16777216    16777216       0     0.00%
> write_iops              5836.55     5899.43       0     1.08%
> write_lat_ns_max       4.60e+09    4.71e+09       0     2.39%
> write_lat_ns_mean     170307.56   168084.36       0    -1.31%
> write_lat_ns_min          17290       16620       0    -3.88%
>
> dbench60 results
>       metric          baseline   current    stdev         diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> avg_commit_ms            90.21      89.08       0    -1.25%
> close                     3.84       3.74       0    -2.66%
> commits                     24         24       0     0.00%
> deltree                 397.45     266.30       0   -33.00%
> dev_write_iops         1387847    1381466       0    -0.46%
> dev_write_kbytes      12669712   12355392       0    -2.48%
> end_state_mount_ns    21310089   17077137       0   -19.86%
> end_state_umount_ns   1.62e+09   1.64e+09       0     1.48%
> flush                   119.80     125.96       0     5.14%
> lockx                     0.83       0.36       0   -57.06%
> max_commit_ms              110        115       0     4.55%
> mkdir                     0.12       0.03       0   -72.36%
> ntcreatex                40.36      33.87       0   -16.08%
> readx                     3.82       3.80       0    -0.65%
> rename                   43.98      36.07       0   -17.98%
> throughput              480.34     493.91       0     2.82%
> unlink                   55.02      39.77       0   -27.73%
> unlockx                   0.59       0.90       0    50.59%
> writex                   52.24      42.94       0   -17.79%
>
> randwrite2xram results
>       metric          baseline     current    stdev         diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> avg_commit_ms           1727.90     1691.89       0    -2.08%
> commits                      31          27       0   -12.90%
> dev_read_iops                 1           1       0     0.00%
> dev_read_kbytes              16          16       0     0.00%
> dev_write_iops          2773322     2723559       0    -1.79%
> dev_write_kbytes       15972064    15112412       0    -5.38%
> elapsed                     312         313       0     0.32%
> end_state_mount_ns     37474061    37768468       0     0.79%
> end_state_umount_ns    1.35e+10    1.12e+10       0   -17.02%
> max_commit_ms              3580        3508       0    -2.01%
> sys_cpu                    5.17        4.94       0    -4.47%
> write_bw_bytes         31705620    31497234       0    -0.66%
> write_clat_ns_mean    516037.52   519262.94       0     0.63%
> write_clat_ns_p50         22400       21888       0    -2.29%
> write_clat_ns_p99        127488      104960       0   -17.67%
> write_io_kbytes         9339256     9285840       0    -0.57%
> write_iops              7740.63     7689.75       0    -0.66%
> write_lat_ns_max       3.90e+09    3.81e+09       0    -2.34%
> write_lat_ns_mean     516098.08   519332.21       0     0.63%
> write_lat_ns_min           9151        9400       0     2.72%
>
> smallfiles100k results
>       metric          baseline     current    stdev         diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> avg_commit_ms            664.53      680.53       0     2.41%
> commits                      15          15       0     0.00%
> dev_read_iops                77          85       0    10.39%
> dev_read_kbytes            1232        1360       0    10.39%
> dev_write_iops          2261542     2251234       0    -0.46%
> dev_write_kbytes       22295236    22187780       0    -0.48%
> elapsed                     487         484       0    -0.62%
> end_state_mount_ns     43139533    42184833       0    -2.21%
> end_state_umount_ns    1.15e+10    1.15e+10       0     0.26%
> max_commit_ms               908         988       0     8.81%
> sys_cpu                   35.95       35.88       0    -0.20%
> write_bw_bytes         4.31e+08    4.34e+08       0     0.70%
> write_clat_ns_mean     29920.68    29556.47       0    -1.22%
> write_clat_ns_p50         11584       11456       0    -1.10%
> write_clat_ns_p99         27776       27776       0     0.00%
> write_io_kbytes        2.04e+08    2.04e+08       0     0.00%
> write_iops            105319.81   106058.66       0     0.70%
> write_lat_ns_max       43247837    38438628       0   -11.12%
> write_lat_ns_mean      29978.36    29611.45       0    -1.22%
> write_lat_ns_min           7100        6931       0    -2.38%
>
> untarfirefox results
>       metric           baseline     current      stdev            diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> avg_commit_ms                2166       2209        26.87     1.99%
> commits                         1          1            0     0.00%
> dev_write_iops              81689      81990       298.40     0.37%
> dev_write_kbytes          1050690    1053004      2146.78     0.22%
> elapsed                     43.48      43.24         0.14    -0.54%
> end_state_mount_ns    25958221.50   18432393   9346169.03   -28.99%
> end_state_umount_ns      9.73e+09   9.81e+09     2.39e+08     0.83%
> max_commit_ms                2166       2209        26.87     1.99%
>
> bufferedreadwrite16g results
>       metric          baseline   current    stdev         diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> avg_commit_ms           558.20     628.20       0    12.54%
> commits                      5          5       0     0.00%
> dev_read_iops             1078       1009       0    -6.40%
> dev_read_kbytes        5209120    5210432       0     0.03%
> dev_write_iops          103848     104906       0     1.02%
> dev_write_kbytes      19690880   19707780       0     0.09%
> elapsed                     44         43       0    -2.27%
> end_state_mount_ns    35691645   35922610       0     0.65%
> end_state_umount_ns   9.03e+09   8.13e+09       0    -9.87%
> max_commit_ms              657        787       0    19.79%
> read_bw_bytes         1.97e+08   2.03e+08       0     3.10%
> read_clat_ns_mean      1782.71    1654.28       0    -7.20%
> read_clat_ns_p50           612        588       0    -3.92%
> read_clat_ns_p99          1736       1528       0   -11.98%
> read_io_bytes         8.59e+09   8.59e+09       0     0.00%
> read_io_kbytes         8392180    8392180       0     0.00%
> read_iops             48125.82   49615.59       0     3.10%
> read_lat_ns_max       42629453   42295738       0    -0.78%
> read_lat_ns_mean       1822.29    1685.25       0    -7.52%
> read_lat_ns_min            380        380       0     0.00%
> sys_cpu                  86.79      87.80       0     1.16%
> write_bw_bytes        1.97e+08   2.03e+08       0     3.10%
> write_clat_ns_mean    17720.61   17282.46       0    -2.47%
> write_clat_ns_p50        15552      15808       0     1.65%
> write_clat_ns_p99        32640      30080       0    -7.84%
> write_io_kbytes        8385036    8385036       0     0.00%
> write_iops            48084.85   49573.36       0     3.10%
> write_lat_ns_max      23628727   22092538       0    -6.50%
> write_lat_ns_mean     17770.70   17328.15       0    -2.49%
> write_lat_ns_min         12580      12560       0    -0.16%
>
> bufferedrandrw16g results
>       metric          baseline     current    stdev         diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> avg_commit_ms           2388.47     2090.56       0   -12.47%
> commits                      17          55       0   223.53%
> dev_read_iops           2098095     2098107       0     0.00%
> dev_read_kbytes         8392980     8393172       0     0.00%
> dev_write_iops          2436170     2982710       0    22.43%
> dev_write_kbytes       30531984    39376068       0    28.97%
> elapsed                     477         502       0     5.24%
> end_state_mount_ns     42563800    40885321       0    -3.94%
> end_state_umount_ns    1.10e+10    1.05e+10       0    -5.04%
> max_commit_ms              4637        3915       0   -15.57%
> read_bw_bytes          18040576    17148429       0    -4.95%
> read_clat_ns_mean     189961.32   189943.65       0    -0.01%
> read_clat_ns_p50         193536      193536       0     0.00%
> read_clat_ns_p99         313344      370688       0    18.30%
> read_io_bytes          8.59e+09    8.59e+09       0     0.00%
> read_io_kbytes          8392180     8392180       0     0.00%
> read_iops               4404.44     4186.63       0    -4.95%
> read_lat_ns_max        23827276    19711541       0   -17.27%
> read_lat_ns_mean      190032.26   190001.95       0    -0.02%
> read_lat_ns_min           75311       75882       0     0.76%
> sys_cpu                   34.51       30.85       0   -10.60%
> write_bw_bytes         18025218    17133831       0    -4.95%
> write_clat_ns_mean     30433.26    46309.80       0    52.17%
> write_clat_ns_p50         22912       22656       0    -1.12%
> write_clat_ns_p99         75264       73216       0    -2.72%
> write_io_kbytes         8385036     8385036       0     0.00%
> write_iops              4400.69     4183.06       0    -4.95%
> write_lat_ns_max       7.60e+08    2.29e+09       0   200.56%
> write_lat_ns_mean      30536.15    46410.87       0    51.99%
> write_lat_ns_min          13110       12901       0    -1.59%
>
> bufferedrandread16g results
>       metric          baseline     current    stdev        diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> avg_commit_ms            460.33      713.67       0   55.03%
> commits                       3           3       0    0.00%
> dev_read_iops           4194350     4194353       0    0.00%
> dev_read_kbytes        16777952    16778000       0    0.00%
> dev_write_iops            36169       36277       0    0.30%
> dev_write_kbytes       16831512    16833240       0    0.01%
> elapsed                     655         608       0   -7.18%
> end_state_mount_ns     39907520    37797198       0   -5.29%
> end_state_umount_ns    9.73e+09    1.04e+10       0    6.37%
> max_commit_ms               630         798       0   26.67%
> read_bw_bytes          26258473    28291169       0    7.74%
> read_clat_ns_mean     155255.66   144060.78       0   -7.21%
> read_clat_ns_p50         171008      162816       0   -4.79%
> read_clat_ns_p99         288768      268288       0   -7.09%
> read_io_bytes          1.72e+10    1.72e+10       0    0.00%
> read_io_kbytes         16777216    16777216       0    0.00%
> read_iops               6410.76     6907.02       0    7.74%
> read_lat_ns_max        14450146    13306941       0   -7.91%
> read_lat_ns_mean      155319.15   144139.23       0   -7.20%
> read_lat_ns_min           74752       74511       0   -0.32%
> sys_cpu                   24.17       23.73       0   -1.81%
>
> bufferedread16g results
>       metric          baseline     current    stdev         diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> avg_commit_ms               683         718       0     5.12%
> commits                       3           3       0     0.00%
> dev_read_iops              2462        2335       0    -5.16%
> dev_read_kbytes        16778192    16778080       0    -0.00%
> dev_write_iops            36317       36259       0    -0.16%
> dev_write_kbytes       16833880    16832952       0    -0.01%
> elapsed                      29          28       0    -3.45%
> end_state_mount_ns     39222067    38744238       0    -1.22%
> end_state_umount_ns    9.43e+09    9.19e+09       0    -2.59%
> max_commit_ms               725         808       0    11.45%
> read_bw_bytes          6.17e+08    6.21e+08       0     0.69%
> read_clat_ns_mean       6450.45     6404.71       0    -0.71%
> read_clat_ns_p50            532         532       0     0.00%
> read_clat_ns_p99           1208        1128       0    -6.62%
> read_io_bytes          1.72e+10    1.72e+10       0     0.00%
> read_io_kbytes         16777216    16777216       0     0.00%
> read_iops             150549.32   151588.56       0     0.69%
> read_lat_ns_max        32655542    29052552       0   -11.03%
> read_lat_ns_mean        6482.87     6437.16       0    -0.71%
> read_lat_ns_min             430         430       0     0.00%
> sys_cpu                   22.46       22.29       0    -0.76%
>
> Link: https://lore.kernel.org/linux-btrfs/34601559-6c16-6ccc-1793-20a97ca=
0dbba@gmx.net/

We normally put the Reported-by tag too, right above the Link tag.

> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e9ba80a56172..4982290384a1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -110,6 +110,7 @@ struct btrfs_bio_ctrl {
>          * This is to avoid touching ranges covered by compression/inline=
.
>          */
>         unsigned long submit_bitmap;
> +       struct readahead_control *ractl;
>  };
>
>  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> @@ -882,6 +883,20 @@ static struct extent_map *get_extent_map(struct btrf=
s_inode *inode,
>
>         return em;
>  }
> +
> +static void btrfs_readahead_expand(struct readahead_control *ractl, stru=
ct extent_map *em)

The extent map can be made const.

> +{
> +       ASSERT(ractl);

We normally place code after all variable declarations, and neither
before or in the middle.
Without the ASSERT the stack trace of a NULL pointer deref would still
be easy to identify.
The only caller for now, already checks it's not NULL.

> +       u64 ra_pos =3D readahead_pos(ractl);
> +       u64 ra_len =3D readahead_length(ractl);
> +       u64 ra_end =3D ra_pos + ra_len;

ra_len is only used once, so we can replace it with
readahead_length(ractl) and get rid of the ra_len variable.

> +       u64 em_end =3D em->start + em->ram_bytes;

All the variables can be made const too.

> +
> +       ASSERT(em_end >=3D ra_pos);
> +       if (em_end > ra_end)
> +               readahead_expand(ractl, ra_pos, em_end - ra_pos);
> +}
> +
>  /*
>   * basic readpage implementation.  Locked extent state structs are inser=
ted
>   * into the tree that are removed when the IO is done (by the end_io
> @@ -939,12 +954,21 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>                         end_folio_read(folio, false, cur, end + 1 - cur);
>                         return PTR_ERR(em);
>                 }
> +

Stray new line, accidental?

>                 extent_offset =3D cur - em->start;
>                 BUG_ON(btrfs_extent_map_end(em) <=3D cur);
>                 BUG_ON(end < cur);
>
>                 compress_type =3D btrfs_extent_map_compression(em);
>
> +               if (bio_ctrl->ractl) {
> +                       bool subpage =3D fs_info->sectorsize < PAGE_SIZE;

We have a helper for this, btrfs_is_subpage(), which we use in most places.

> +                       bool compressed =3D compress_type !=3D BTRFS_COMP=
RESS_NONE;

This is only used once, so we can just use the comparison expression below.
It also makes it consistent with the rest of the code in this function
- it would be odd to have such a variable for this block while the
rest of the function does that comparison.

Thanks.

> +
> +                       if (!subpage && compressed)
> +                               btrfs_readahead_expand(bio_ctrl->ractl, e=
m);
> +               }
> +
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE)
>                         disk_bytenr =3D em->disk_bytenr;
>                 else
> @@ -2541,7 +2565,10 @@ int btrfs_writepages(struct address_space *mapping=
, struct writeback_control *wb
>
>  void btrfs_readahead(struct readahead_control *rac)
>  {
> -       struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ | REQ_R=
AHEAD };
> +       struct btrfs_bio_ctrl bio_ctrl =3D {
> +               .opf =3D REQ_OP_READ | REQ_RAHEAD,
> +               .ractl =3D rac
> +       };
>         struct folio *folio;
>         struct btrfs_inode *inode =3D BTRFS_I(rac->mapping->host);
>         const u64 start =3D readahead_pos(rac);
> --
> 2.49.0
>
>

