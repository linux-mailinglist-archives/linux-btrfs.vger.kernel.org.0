Return-Path: <linux-btrfs+bounces-11172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C448BA22A1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 10:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5DD3A6303
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5221B4F09;
	Thu, 30 Jan 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lpx4tRMy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C901B415E
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228431; cv=none; b=gAzhZ0bK+NFqkATAWn4WV1r2GKaZ3VT0l3DKTmcQHVutJuO2bpO/CJdEp22/hlyr3GLzK236e0pvtUzy9td/LcPgxVRBDAUK/mU2DAiUS/M/RQFfsTQKrbsMQVEH9w5Fsop6OH/TBhvDjZXVHOW71l2q38Am4+806rXCIw1sS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228431; c=relaxed/simple;
	bh=ctulR3cRWtcJlO4spCKfZY6Dgeg/I15rDLRkaQwAcu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G59owVLJ12a/iwXEia9ofV8tFVjYY20FIGPFvuuxy++jas6d3LAFCu77lNdK1rRHf8Mv8bDsNO2uCO6l32C6m2yhT3I3xSQ88EXNCDZAE8eFVISTG6WYQrXsnFTgbEuaCnoBVlZovfRwcWrNCeaYaeWM0E4k2jVx24jQHGf7Opg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lpx4tRMy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso131183366b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738228427; x=1738833227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8p8aAb0X1bp6hHlymQNq9HzSfsnECJPQUElhLE6JPO0=;
        b=Lpx4tRMyM9Sw7tFZwuNXlZFIZpIclesbAMfNgxXKMad5f2+Z3SueqNsq2zQmOjhMEA
         0M4TDoVdtOM0upYlOwGF6PWsL7scxSDbax3JrgEz7iQ5/fKUyhNrSXEsZYL5i3OxNXUP
         5oqUXxi026Z/R62i0EvOJzXpGkVKHf4O4/Aiv154U9sb99NZdQlThdMyCyj1/ccKbfAp
         jCzaQcXfQjo8Sea6eunt3dXvJPOFLamKcfoxg0Uw5WBVKXJQkBj78cKlyEAXs/1+aLUH
         QzTlefZyKa0BBJjvdvbIVlhTIEnEysJVIxN12mO6zH78d2yw8Pq0HZZg5GoEQvd7rn7z
         /w2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738228427; x=1738833227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8p8aAb0X1bp6hHlymQNq9HzSfsnECJPQUElhLE6JPO0=;
        b=d/LVs16TxjXM9cfXGoOABFjFIl2P4gZUvRDgBsk9it5XAaUROntsuw6/occZkM/dQ+
         pRv0HN9pwWeHexEAHpiAHbfqr2g4GKsZ+N0QUyecGhGRkO4/fsa7MZYwgx2o1Fe6IbMA
         GuDq3v5FcZdcpUHTHW1ztYVmFj4qr45RdcLhmWLdf8+kU+nR6PGeOPSfn3ikwdPjpis3
         L0W0YDmwWYbWdVPIDRXsIDP25ptrnHRURR+FrC4BqXETCpT96Y1F3yZnVYnTiV1ytScn
         vSl6XqkrRf0/2Hg/rbjPW+kMNp5ScmM1rS7GQ3YocU8/etKyftLagacBtKf9kaHsuCoL
         OZgw==
X-Forwarded-Encrypted: i=1; AJvYcCXnPz2D6gw5OIhSM0vF/nu2D2wH1HHQ1JmQo256ERpiJWx/7k1J5gCuL/5IyjoJNA7k/yvl/Cn3cvfT+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq46LRxCXuFuX6BdxNSOY1IVovbug08astOszAnyHli++jSYmA
	oEI2Olfqa29XCztYO7gtzRZr9doqMADZQ3ls48brZWgDk7w4Sbfa4Au+IGrWqTA6ba5ABHD2bGy
	1ZO97IvZ4t+pKt7svINlqxi2/AIzT7fWyMP+7Iw==
X-Gm-Gg: ASbGncv1Bx9OpWMi6LGOtwV7+MGMDDUzWUcILcZJwpqPkrWewgOYW2nddjKWsBLq4D3
	JdyqyxTFVU3/yQVE7ztBKMxS3z5ZkpAU2U6AcRLczWaD9kXxG2Y+CZnaLEgm1wjags0JKIaQ=
X-Google-Smtp-Source: AGHT+IF/2X4mlWad9vHOgVn9WF5VBG09lohncqS+VBI3G2OOsXV4DtAXNxX6+CrCHPNcEVR9WF0nlwvMYCHczIlI02A=
X-Received: by 2002:a17:907:1c08:b0:ab2:c0b9:68d with SMTP id
 a640c23a62f3a-ab6cfc859b1mr644296866b.1.1738228427035; Thu, 30 Jan 2025
 01:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124075558.530088-1-neelx@suse.com> <20250127180250.GQ5777@twin.jikos.cz>
 <CAPjX3FdaxfzULnRjN7TqyS9uK_ZJSk2PRzLgQCLVGBrR0yKLGw@mail.gmail.com> <20250129224253.GF5777@twin.jikos.cz>
In-Reply-To: <20250129224253.GF5777@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 30 Jan 2025 10:13:36 +0100
X-Gm-Features: AWEUYZnie91Dh1atsgKxQgjtcE2FM4rg-rsuiaBZqXyHQkMZTEOeDoYysmlCatA
Message-ID: <CAPjX3FdJynRY91N-1aJ0wOrMJY+cKvSuhLDPGAuCybEvSzS0KA@mail.gmail.com>
Subject: Re: [PATCH] btrfs/zstd: enable negative compression levels mount option
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 23:42, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Jan 28, 2025 at 09:46:02AM +0100, Daniel Vacek wrote:
> > > > ==============================================================+===============================================
> > > > level -15     0m0,261s        0m0,329s        141M    100%  | 0m2,511s        0m2,794s        598M    40%  |
> > > > level -14     0m0,145s        0m0,291s        141M    100%  | 0m1,829s        0m2,443s        581M    39%  |
> > > > level -13     0m0,141s        0m0,289s        141M    100%  | 0m1,832s        0m2,347s        566M    38%  |
> > > > level -12     0m0,140s        0m0,291s        141M    100%  | 0m1,879s        0m2,246s        548M    37%  |
> > > > level -11     0m0,133s        0m0,271s        141M    100%  | 0m1,789s        0m2,257s        530M    35%  |
> > >
> > > I found an old mail asking ZSTD people which realtime levels are
> > > meaningful, the -10 was mentioned as a good cut-off. The numbers above
> > > confirm that although this is on a small sample.
> >
> > The limit is really arbitrary. We may as well not even set one and
> > leave it to the user. It's not like we allocate additional memory or
> > any other resources.
>
> Yes, it is arbitrary, the criteria is what are the practical benefits of
> keeping the levels, what is the trade off compression/speed. It does not
> matter much if the realtime level is ultra fast when it is not able to
> reduce the size, given the constraints.
>
> I agree that we should leave it up to user but I'd say it may be unclear
> which level select. The level number is translated to some internal
> compression logic so even very high numbers are allowed.
>
> The testing file I've used is output of 'find -ls', so mostly textual
> data, high level of redundancy.
>
> Generated by a series of "zstd -b$i --fast=$i zstd-test"
>
> -1#zstd-test         :   6126812 ->   1017901 (x6.019), 1055.7 MB/s, 2826.0 MB/s
> -2#zstd-test         :   6126812 ->   1065645 (x5.749), 1143.0 MB/s, 3005.8 MB/s
> -3#zstd-test         :   6126812 ->   1128314 (x5.430), 1204.2 MB/s, 3153.6 MB/s
> -4#zstd-test         :   6126812 ->   1210669 (x5.061), 1220.5 MB/s, 3172.8 MB/s
> -5#zstd-test         :   6126812 ->   1280004 (x4.787), 1242.7 MB/s, 3221.3 MB/s
> -6#zstd-test         :   6126812 ->   1371974 (x4.466), 1259.8 MB/s  3277.1 MB/s
> -7#zstd-test         :   6126812 ->   1440333 (x4.254), 1304.4 MB/s, 3293.0 MB/s
> -8#zstd-test         :   6126812 ->   1496071 (x4.095), 1356.9 MB/s, 3391.2 MB/s
> -9#zstd-test         :   6126812 ->   1566788 (x3.910), 1452.9 MB/s, 3613.6 MB/s
> -10#std-test         :   6126812 ->   1613304 (x3.798), 1497.1 MB/s, 3738.7 MB/s
>
> -11#std-test         :   6126812 ->   1685217 (x3.636), 1541.4 MB/s, 3829.2 MB/s
> -12#std-test         :   6126812 ->   1766056 (x3.469), 1556.0 MB/s, 3875.6 MB/s
> -13#std-test         :   6126812 ->   1826338 (x3.355), 1563.3 MB/s, 3886.6 MB/s
> -14#std-test         :   6126812 ->   1899464 (x3.226), 1623.8 MB/s, 3963.5 MB/s
> -15#std-test         :   6126812 ->   1989219 (x3.080), 1641.9 MB/s, 3901.3 MB/s
> -16#std-test         :   6126812 ->   2057101 (x2.978), 1646.0 MB/s, 3781.2 MB/s
> -17#std-test         :   6126812 ->   2101038 (x2.916), 1639.9 MB/s, 3809.8 MB/s
> -18#std-test         :   6126812 ->   2151170 (x2.848), 1667.4 MB/s, 3887.3 MB/s
> -19#std-test         :   6126812 ->   2185255 (x2.804), 1675.8 MB/s, 3932.5 MB/s
> -20#std-test         :   6126812 ->   2228180 (x2.750), 1655.2 MB/s, 3983.3 MB/s
>
> -21#std-test         :   6126812 ->   2275855 (x2.692), 1748.4 MB/s, 4188.4 MB/s
> -22#std-test         :   6126812 ->   2324370 (x2.636), 1758.7 MB/s, 4245.0 MB/s
> -23#std-test         :   6126812 ->   2373789 (x2.581), 1810.8 MB/s, 4345.4 MB/s
> -24#std-test         :   6126812 ->   2423045 (x2.529), 1856.4 MB/s, 4326.7 MB/s
> -25#std-test         :   6126812 ->   2470722 (x2.480), 1860.7 MB/s, 4425.6 MB/s
> -26#std-test         :   6126812 ->   2519621 (x2.432), 1872.8 MB/s, 4447.8 MB/s
> -27#std-test         :   6126812 ->   2571890 (x2.382), 1865.0 MB/s, 4432.7 MB/s
> -28#std-test         :   6126812 ->   2630088 (x2.330), 1892.7 MB/s, 4480.3 MB/s
> -29#std-test         :   6126812 ->   2678598 (x2.287), 1892.3 MB/s, 4458.1 MB/s
> -30#std-test         :   6126812 ->   2730233 (x2.244), 1886.9 MB/s, 4415.0 MB/s
>
> -100#td-test         :   6126812 ->   3878531 (x1.580), 2546.7 MB/s, 7076.8 MB/s
> -101#td-test         :   6126812 ->   3873153 (x1.582), 2549.6 MB/s, 7053.4 MB/s
> -102#td-test         :   6126812 ->   3878200 (x1.580), 2572.9 MB/s  7173.3 MB/s
> -103#td-test         :   6126812 ->   3900441 (x1.571), 2581.2 MB/s  7164.9 MB/s
> -104#td-test         :   6126812 ->   3902470 (x1.570), 2559.0 MB/s, 7133.3 MB/s
> -105#td-test         :   6126812 ->   3912874 (x1.566), 2596.4 MB/s, 7150.9 MB/s
> -106#td-test         :   6126812 ->   3917867 (x1.564), 2553.8 MB/s, 7260.1 MB/s
> -107#td-test         :   6126812 ->   3930050 (x1.559), 2599.6 MB/s, 7284.5 MB/s
> -108#td-test         :   6126812 ->   3946701 (x1.552), 2622.5 MB/s, 7288.1 MB/s
> -109#td-test         :   6126812 ->   3954437 (x1.549), 2605.8 MB/s, 7334.4 MB/s
> -110#td-test         :   6126812 ->   3955273 (x1.549), 2601.0 MB/s, 7389.1 MB/s
>
> -1000#d-test         :   6126812 ->   5982024 (x1.024), 9253.0 MB/s, 22210.0 MB/s
> -1001#d-test         :   6126812 ->   5986021 (x1.024), 9120.1 MB/s, 23034.3 MB/s
> -1002#d-test         :   6126812 ->   5984005 (x1.024), 9086.7 MB/s, 22827.0 MB/s
> -1003#d-test         :   6126812 ->   5978004 (x1.025), 9199.4 MB/s, 21718.3 MB/s
> -1004#d-test         :   6126812 ->   5977133 (x1.025), 9120.3 MB/s, 21995.3 MB/s
> -1005#d-test         :   6126812 ->   5979294 (x1.025), 9231.6 MB/s, 22204.5 MB/s
> -1006#d-test         :   6126812 ->   5981595 (x1.024), 9175.6 MB/s, 21794.4 MB/s
> -1007#d-test         :   6126812 ->   5989283 (x1.023), 9298.9 MB/s, 24239.1 MB/s
> -1008#d-test         :   6126812 ->   5986954 (x1.023), 9242.1 MB/s, 23809.4 MB/s
> -1009#d-test         :   6126812 ->   5988383 (x1.023), 9199.3 MB/s, 24322.1 MB/s
> -1010#d-test         :   6126812 ->   5985304 (x1.024), 9221.2 MB/s, 23711.9 MB/s
>
> Up to -15 it's 3x improvement which translates to about 33% of the
> original size. And this is only for rough estimate, kernel compression
> could be slightly worse due to slightly different parameters.
>
> We can let it to -15, so it's same number as the upper limit.

I was getting less favorable results with my testing which leads me to
the ultimate rhetorical question:

What do we know about the dataset users are possibly going to apply?
And how do you want to assess the right cut-off having incomplete
information about the nature of the data?
Why doesn't zstd enforce any limit itself?
Is this even a matter (or responsibility) of the filesystem to force
some arbitrary limit here? Maybe yes?

As mentioned before, personally I'd leave it to the users so that they
can freely choose whatever suits them the best. I don't see any
technical or maintenance issues opening this limit.
Well in the end as a maintainer it's up to you. Feel free to amend the
patch to your liking. I'm fine with both -10 or -15. Or whatever else
you choose, that said.

So let me know if you need v4 and how to tune it or if you're fine
fixing the v3 up yourself.

