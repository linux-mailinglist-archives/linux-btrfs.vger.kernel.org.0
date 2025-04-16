Return-Path: <linux-btrfs+bounces-13097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA67A90A8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 19:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AC4444FC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC92192FE;
	Wed, 16 Apr 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="x6pV/Ex5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF4218EBD
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826067; cv=none; b=UFIzhO6ixBRBTsDoPu2Haf5jWy2djL7tM5KfsgY9Yk01MSAEd02tgQujSb5KGr7U+ZIXCXYP45TOubWgF8cScFg9zS3/xT4zVjqBbZr4WARDuIIF6PH1VKRJFCBGRQVIixNS6QU4dQMr1HuqXBfkfpQrf5z5MMdV6Z0qPJXqLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826067; c=relaxed/simple;
	bh=GfNz4q/mabXrblsL2M3LCQs5saqkT9AcHXKywWpzioI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMbLr4qEdT7OVwYbu8PV535fPEOm0M5JA/b6JVfiXtPJc4azm4n0Dj02E+LCini0EvVpbZnSJ+8ZvTWXdHCYtOGXE+/tYZzpgq+y+ijZ9DOdVem0gmJxN1Tmny2iEn0M6UpY8kNDNDAQ8YhtNfCcBPqTdhqQMsRRVY8Jb+vFTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=x6pV/Ex5; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e6405b5cd9bso954564276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744826064; x=1745430864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIT0jgl3pGxIxIljl3Y2Oarunq7HhO7TVfv/pqKABvo=;
        b=x6pV/Ex5mG+GDhoqjd69IwhdoIVXtw5cujQu9agv+0maGQ3xa1S/sn80Cibhu1DZnN
         VkaEMEyvBFUUgz8UeTitVZKIYyes/b2Gv0EI/cV6YC1Hg49FCvEpPDPWS0+IXXydX2XT
         xwkx13jAJqezXWkU/C5XTB6fjv2UYOv6faAFKUmff71g64+aqBICpMp3vKAidBjmONg3
         7ldxb0JDk0em0e8Caqr18N2AjVLLU8eobNVmDWFuJkCymM2WMaJ9b522OFkeKXnp9uhp
         PhIqgrj3e+31WdgK82LpvQb9TZhOaf/ouMxntZPlCk/yMEi9rVaHsB3NIyTe75SU+O4s
         K1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826064; x=1745430864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIT0jgl3pGxIxIljl3Y2Oarunq7HhO7TVfv/pqKABvo=;
        b=qfmZYFQ+brMBlQp5yuXGWqgIf6ZEICM8DKJGIuuRCQBv1Uzu/9+KpYRlPKo09sNsB+
         0+xSegW1/JPR+F2nX5BDZrjEif6m/Ed5qRDBn9LjyJV2/bO17hYGgKQZ4vnLjVGRaThs
         uMyVbGGu4Y9PVclgafCmnrTq4ao0yQD50twjtSXbeRR8FYs/kz5n21Fj74H/VGEU6zKd
         qI6rXi/tDWpF5bldxJYSvna68uEwz9QRLENN7GtIl7G+vCE/9503n6IgrRNirZH6AC8r
         W2XidtIc0VGKPlwYIz+LMQrVDBQtfhNOzR0Ha3LcNJZl7CyokmsnjHdDAwmnszFz48N2
         SNcw==
X-Gm-Message-State: AOJu0YxPRzoZ8YyLMSG1bqrIUOAgDE9TpRXjuJTmfL+sRBeL35tOq0Q3
	KjvKu4cMzvXKDRgeGhKPmw6U0JbGP/gMf20dQJrMVyodSTRHW6hIDmUohxkPkZhhbL7zAVn6jqN
	EWVpYKQ==
X-Gm-Gg: ASbGncuIXzx2q4iwV+lLr+gWuRHTihe26DnyQ5CUoS3sE6pYaQEVB8OoFVsopBQNuCt
	PZh0n2eHvXd6SOw6JKHTyEJBzZijGidFMfvOC+gjuJJ9/c1Wqr182248HX2uCKtTdlexVE8if6l
	8fGiU9WJA7EE1PaZVPru9hKV5cmOcUgIlk3cbmTGi20U7qURDai+Vzzgooad2saAG6jH1M25r9j
	cWsmcYfW2vhy16mrqbnyu3do6KG3UWmkcKZD+42i6g1XUm123WD/lDJUXnSe7h7lzx36DgV85v1
	/7psZioy1QTFaqyq9FSeQ2xbTlGAFvbzP1zZMn+kSVSEONPq51HJqs5YFnId+3jsIYeGgalzxO2
	zFg==
X-Google-Smtp-Source: AGHT+IEo10oqmxUhv7D9jAWSXoBnD+hvpPhG2y23iXVj4Ck/vlwXqyZGnfxkhEXO6d7pE+UC93Onww==
X-Received: by 2002:a05:6902:cc9:b0:e6d:d7d8:7fcf with SMTP id 3f1490d57ef6-e7280949d7amr605475276.24.1744826063773;
        Wed, 16 Apr 2025 10:54:23 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e70a7745e17sm916301276.30.2025.04.16.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:54:23 -0700 (PDT)
Date: Wed, 16 Apr 2025 13:54:22 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: simplify extent buffer writeback
Message-ID: <20250416175422.GA3234941@perftesting>
References: <cover.1744822090.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744822090.git.josef@toxicpanda.com>

On Wed, Apr 16, 2025 at 12:51:05PM -0400, Josef Bacik wrote:
> Hello,
> 
> We currently have two different paths for writing out extent buffers, a subpage
> path and a normal path.  This has resulted in subtle bugs with subpage code that
> took us a while to figure out.  Additionally we have this complex interaction of
> get folio, find eb, see if we already started writing that eb out, write out the
> eb.
> 
> We already have a radix tree for our extent buffers, so we can use that
> similarly to how pagecache uses the radix tree.  Tag the buffers with DIRTY when
> they're dirty, and WRITEBACK when we start writing them out.
> 
> The unfortunate part is we have to re-implement folio_batch for extent buffers,
> so that's where most of the new code comes from.  The good part is we are now
> down to a single path for writing out extent buffers, it's way simpler, and in
> fact quite a bit faster now that we don't have all of these folio->eb
> transitions to deal with.
> 
> I ran this through fsperf on a VM with 8 CPUs and 16gib of ram.  I used
> smallfiles100k, but reduced the files to 1k to make it run faster, the
> results are as follows, with the statistically significant improvements
> marked with *, there were no regressions.  fsperf was run with -n 10 for
> both runs, so the baseline is the average 10 runs and the test is the
> average of 10 runs.
> 
> smallfiles100k results
>       metric           baseline       current        stdev            diff
> ================================================================================
> avg_commit_ms               68.58         58.44          3.35   -14.79% *
> commits                    270.60        254.70         16.24    -5.88%
> dev_read_iops                  48            48             0     0.00%
> dev_read_kbytes              1044          1044             0     0.00%
> dev_write_iops          866117.90     850028.10      14292.20    -1.86%
> dev_write_kbytes      10939976.40   10605701.20     351330.32    -3.06%
> elapsed                     49.30            33          1.64   -33.06% *
> end_state_mount_ns    41251498.80   35773220.70    2531205.32   -13.28% *
> end_state_umount_ns      1.90e+09      1.50e+09   14186226.85   -21.38% *
> max_commit_ms                 139        111.60          9.72   -19.71% *
> sys_cpu                      4.90          3.86          0.88   -21.29%
> write_bw_bytes        42935768.20   64318451.10    1609415.05    49.80% *
> write_clat_ns_mean      366431.69     243202.60      14161.98   -33.63% *
> write_clat_ns_p50        49203.20         20992        264.40   -57.34% *
> write_clat_ns_p99          827392     653721.60      65904.74   -20.99% *
> write_io_kbytes           2035940       2035940             0     0.00%
> write_iops               10482.37      15702.75        392.92    49.80% *
> write_lat_ns_max         1.01e+08      90516129    3910102.06   -10.29% *
> write_lat_ns_mean       366556.19     243308.48      14154.51   -33.62% *
> 
> As you can see we get about a 33% decrease runtime, with a 50%
> throughput increase, which is pretty significant.  Thanks,

Ignore this for now, the xarray<->radix thing isn't quite one to one, so I've
got to convert the buffer radix to a proper xarray first.  Thanks,

Josef

