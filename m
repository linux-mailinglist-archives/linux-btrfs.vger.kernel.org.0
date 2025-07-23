Return-Path: <linux-btrfs+bounces-15649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85A5B0F9F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA1718952DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF482206BB;
	Wed, 23 Jul 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSwpKq9N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94221FF35
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293927; cv=none; b=EkNVxNmxcrGHnfBcpBS7MfSaqv0osNA0a9gtj8v8F6tI0SDI0hwvPGVTEquxsMfnSj2HO6PtHD/CMOPu6RnCZvhdULtsPf484vCorJ8bHRH4xCA1HUZ6E0pDbFhttozWDSMwf7NO/c/2kIfTPkBzIKHnK3Gs4FCeNc9iHT7wzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293927; c=relaxed/simple;
	bh=hniMwS27NUBM6BPbrolUGqinai7SJ9XHKCWMyhrjCtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUUR5Vmp/1vaNM+UuaivwKLSgEi34qSDhnJVCyQFETNUjmS0ajwYWDYPX6Cu7x30N4Wnlg+QzYvpXbfUQewtipZamHZ9aRQFWQpTxM17kY0yaBXxWnhuc9Vls03QcEKSLtO3KOXE5UCX3LyhMlm36tIuvegh3DvvgjsC0atbHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSwpKq9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C1AC4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753293927;
	bh=hniMwS27NUBM6BPbrolUGqinai7SJ9XHKCWMyhrjCtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JSwpKq9NrF8/ovfHDglNDgOMPEaIKc9zGg3u357YytGTed8umNqWtrKTCcgXaO2/N
	 lKmibMf4t1p6k4m7gJJRr+VN3NO9QigcIzZ1NGtbSwgwqvqSRFYWTg/RimZ3xF2A4k
	 oxpbRGDn1yVvQ3n3SMlHUrAs1okgst8tfmW1P6TtfYrNBwVd3AvGkSodmczFhecyDV
	 F7Pbm3EQap54gJmV5SiBGD4kAX5jH+bsQSYUI74/KsyD0RNYT11fFxPLgzecjEOPzJ
	 IM3AaL6KF3rcp6i6OH3/eFUXwgo0KMYNg4sIKu8mgFfAJEmdVdIhtgVbwzedYgeM+H
	 l8qvpQ3z3pvcA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae9be1697easo239433266b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:05:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzMH1QMkg/KG6KUMVdaE2rE6uB4Cm1AwigzNyEWb7WBxzgBJUw+Tfu0pT6kraZ5rm38NgtcYeX8xeP+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YywMvbIP2B7AE+03ryrq7vGzZAadQEmO2/XUsngMqAYDNO6+/S1
	EAfODgyM1llVRwh+e2YeaKD9Q3/cVhTYoLhJI37Fl40wVn4RDDwQqbYMyeqHDTZHYMvw1Jyaqbb
	vT3YkD4GzUM1tFJa7HHLklun/lW+bTiU=
X-Google-Smtp-Source: AGHT+IEWDpyUbdtaAqUn9vIAP6EhnxbpQN9TDuqmvqbInTzzgFHdt2Uy4F+4eYR/gE9ySaE0uG/ietgQWMKUPAypQNs=
X-Received: by 2002:a17:907:7fa9:b0:ae0:6621:2f69 with SMTP id
 a640c23a62f3a-af15331c1e6mr879165366b.13.1753293925673; Wed, 23 Jul 2025
 11:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711103853.GC22472@twin.jikos.cz> <20250723174434.3484810-1-loemra.dev@gmail.com>
In-Reply-To: <20250723174434.3484810-1-loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 23 Jul 2025 19:04:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H634nKAhre3RLNy+=czj-=poiHLg+ZtDg7rph_t+DnQmQ@mail.gmail.com>
X-Gm-Features: Ac12FXy8_GI01hLDVlkoBDFh1STs5sUZ-dIJsENE0oPhRHz6zjcKqJ21WoRneMg
Message-ID: <CAL3q7H634nKAhre3RLNy+=czj-=poiHLg+ZtDg7rph_t+DnQmQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: implement ref_tracker for delayed_nodes
To: Leo Martins <loemra.dev@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 6:44=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> On Fri, 11 Jul 2025 12:38:53 +0200 David Sterba <dsterba@suse.cz> wrote:
>
> > On Thu, Jul 10, 2025 at 12:54:34PM +0100, Filipe Manana wrote:
> > > > @@ -63,10 +109,18 @@ struct btrfs_delayed_node {
> > > >         struct rb_root_cached del_root;
> > > >         struct mutex mutex;
> > > >         struct btrfs_inode_item inode_item;
> > > > +
> > > >         refcount_t refs;
> > > > -       int count;
> > > > +       /* Used to track all references to this delayed node. */
> > > > +       btrfs_delayed_node_ref_tracker_dir ref_dir;
> > > > +       /* Used to track delayed node reference stored in node list=
. */
> > > > +       btrfs_delayed_node_ref_tracker node_list_tracker;
> > > > +       /* Used to track delayed node reference stored in inode cac=
he. */
> > > > +       btrfs_delayed_node_ref_tracker inode_cache_tracker;
> > > > +
> > > >         u64 index_cnt;
> > > >         unsigned long flags;
> > > > +       int count;
> > >
> > > Why are you moving the count field?
> > > This increases the size of the struct even without the new config
> > > option enabled and as a result we get less objects per page.
> > > You are essentially reverting this commit:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Da20725e1e7014642fc8ba4c7dd2c4ef6d4ec56a9
> > >
> > > Without any explanation about why.
>
> Good catch, did not realize that moving the count field increased
> struct size.

For structures of things we can have many instances of, it's always
important to check if the structure size changes.
In this case it was puzzling why the field was moved when there's no
need to do it all for this patch and no mention in the changelog.

>
> > >
> > > I'm also not a big fan of the typedefs and would prefer to have
> > > struct ref_tracker used directly in the structure surrounded by an
> > > #ifdef block.
> >
> > Agreed, we use typedefs only for function callbacks, for variable types
> > not anymore.
>
> When I try and not use typedefs I end up using more conditional compilati=
on
> which I think hinders readability. Here's a snippet of my best attempt, l=
et
> me know if you see any improvements.
>
> ```C
> struct btrfs_delayed_node {
>         ...
> #ifdef CONFIG_BTRFS_DEBUG
>         struct ref_tracker_dir ref_dir;
>         struct ref_tracker *node_list_tracker;
>         struct ref_tracker *inode_cache_tracker;
> #endif
>         ...
> }
>
> #ifdef
> static inline void
> btrfs_release_delayed_node(struct btrfs_delayed_node *node,
>                            struct ref_tracker **tracker)
> {
>         __btrfs_release_delayed_node(node, 0, tracker);
> }
>
> void btrfs_remove_delayed_node(struct btrfs_inode *inode)
> {
>         struct btrfs_delayed_node *delayed_node;
>
>         delayed_node =3D READ_ONCE(inode->delayed_node);
>         if (!delayed_node)
>                 return;
>
>         inode->delayed_node =3D NULL;
> #ifdef CONFIG_BTRFS_DEBUG
>         btrfs_release_delayed_node(delayed_node,
>                                    &delayed_node->inode_cache_tracker);
> #else
>         btrfs_release_delayed_node(delayed_node, NULL);
> #endif
> }
> ```
>
> With this approach I end up needing to add conditional compilation
> anywhere I use node_list_tracker or inode_cache_tracker. This isn't
> too big of an issue since their usage is relatively limited.
> However, I believe this would be an appropriate place for typedefs.
>
> Alternatively, I could have two versions of btrfs_release_delayed_node
> one that takes a struct ref_tracker ** and one that takes a struct {}.
> However, this would mean doing the same for all the functions that
> take a tracker, btrfs_get_delayed_node, btrfs_get_or_create_delayed_node,
> ... But, I feel like that is the same as manually unwinding the typedef.
>
> Any guidance would be greatly appreciated! Also curious about the aversio=
n
> to typedefs outside of function callbacks?

https://www.kernel.org/doc/html/v4.14/process/coding-style.html#typedefs

>
> >
> > > I also don't like adding a new Kconfig option just for this... How
> > > much slower would a build with CONFIG_BTRFS_DEBUG=3Dy be?
> > >
> > > If that's really a lot slower, then perhaps a more generic config
> > > option name in case we add similar tracking to other data structures
> > > one day.
>
> I gathered some data here using fsperf and got some mixed results, most
> tests performed slightly worse, and some got much worse

Running fsperf and benchmarks tools is not the most important for
development IMO.
While developing we normally use CONFIG_BTRFS_DEBUG=3Dy and the most
important thing is how much slower fstests become (or anything else
used for functional tests).

When we really want to test for performance, we do it so with
CONFIG_BTRFS_DEBUG disabled and then use fsperf and other tools -
users/distros don't tend to have a kernel config with
CONFIG_BTRFS_DEBUG=3Dy.


> (dbench60, emptyfiles500k). I think it would be acceptible to keep in
> CONFIG_BTRFS_DEBUG, but I think it could definitely benefit from
> its own option, CONFIG_BTRFS_REF_TRACKER.
>
> >
> > Right, we want to keep the config options at minimum and for debugging
> > features it should be fine under BTRFS_DEBUG. If this needs to be
> > configured for performance reasons then it can be a mount option, same
> > as we have ref-verify or fragment already.
>
> If we wanted to allow turning ref_tracker on via mount option we would
> not be able to compile out the ref_tracker objects in delayed_node which
> would cause a change in size from 304 bytes to 400 bytes.
>
> baseline represents CONFIG_BTRFS_DEBUG=3Dy without ref_tracker
> current represents CONFIG_BTRFS_DEBUG=3Dy with ref_tracker
> ** means 2*stdev worse
> ```
> [root@localhost fsperf]# ./fsperf -p "baseline" -n 5
> ...
> <enable ref_tracker>
> [root@localhost fsperf]# ./fsperf -p "tracker" -n 5
> ...
> [root@localhost fsperf]# ./fsperf-compare "baseline" "tracker"
> ['btrfs']
> btrfs test results
> bufferedappenddatasync results
>       metric           baseline      current       stdev            diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> avg_commit_ms               1.91          1.85         0.13    -3.23%
> bg_count                    4.60          4.40         0.55    -4.35%
> commits                       20         21.20         2.12     6.00%
> dev_read_iops          262187.60     262190.40         8.32     0.00%
> dev_read_kbytes          1020.80          1040        42.93     1.88%
> dev_write_iops        3129696.80       3126160      2909.20    -0.11%
> dev_write_kbytes        43783448   43726868.80     46497.53    -0.13%
> elapsed                   301.60        300.60         9.29    -0.33%
> end_state_mount_ns      46733159      44610208   3503084.15    -4.54%
> end_state_umount_ns     2.77e+09      2.58e+09     2.17e+08    -6.65%
> max_commit_ms               2.80          2.40         0.84   -14.29%
> sys_cpu                    61.80         61.69         0.54    -0.17%
> write_bw_bytes           3572197    3584941.20    106296.35     0.36%
> write_clat_ns_mean      29694.09      29299.92      4510.28    -1.33%
> write_clat_ns_p50       28262.40      27955.20      4380.52    -1.09%
> write_clat_ns_p99       48793.60      48281.60      7226.28    -1.05%
> write_io_kbytes          1048576       1048576            0     0.00%
> write_iops                872.12        875.23        25.95     0.36%
> write_lat_ns_max       764860.40        634311    354679.35   -17.07%
> write_lat_ns_mean       29981.52      29539.17      4518.22    -1.48%
> write_lat_ns_min        21404.80      21060.40       315.78    -1.61%
>
> bufferedrandwrite16g results
>       metric           baseline       current       stdev            diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> avg_commit_ms              794.59        773.06        27.11    -2.71%
> commits                     83.20         79.80         2.05    -4.09%
> dev_read_iops              658.60        521.20       335.31   -20.86%
> dev_read_kbytes           9478.40       7334.40      5341.58   -22.62%
> dev_write_iops         5801247.80    5721033.20     53643.07    -1.38%
> dev_write_kbytes      44303422.40   43038694.40    853851.59    -2.85%
> elapsed                       360           347        21.94    -3.61%
> end_state_mount_ns    58480927.20   59131105.80    873330.39     1.11%
> end_state_umount_ns      9.10e+09      8.71e+09     3.41e+08    -4.33%
> max_commit_ms                1624       1630.60        53.77     0.41%
> sys_cpu                     35.52         35.88         1.25     1.00%
> write_bw_bytes        47983181.20      49673467   2727170.05     3.52%
> write_clat_ns_mean       83559.03      80805.49      5123.88    -3.30%
> write_clat_ns_p50        27622.40      27417.60       879.39    -0.74%
> write_clat_ns_p99       152166.40     171417.60      9864.47    12.65%
> write_io_kbytes          16777216      16777216            0     0.00%
> write_iops               11714.64      12127.31       665.81     3.52%
> write_lat_ns_max         2.93e+09      2.21e+09     1.41e+09   -24.81%
> write_lat_ns_mean        83674.85      80915.46      5128.53    -3.30%
> write_lat_ns_min         16718.40      16552.40       455.01    -0.99%
>
> dbench60 results
>       metric           baseline     current       stdev            diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> avg_commit_ms               31.72      33.63          1.24     6.04%
> bg_count                        4          4             0     0.00%
> close                        4.32       6.06          0.54    40.36%**
> commits                        24         24             0     0.00%
> deltree                    526.48     610.32         31.73    15.92%**
> dev_read_iops            75597.20      65111       1808.47   -13.87%**
> dev_read_kbytes              1040       1040             0     0.00%
> dev_write_iops         1545476.80    1347859      52326.80   -12.79%**
> dev_write_kbytes      18026305.60   15533764     691195.60   -13.83%**
> end_state_mount_ns    48171843.60   45794087    2671959.83    -4.94%
> end_state_umount_ns      1.85e+09   1.85e+09   41447992.49    -0.14%
> find                        29.76      41.82          2.56    40.52%**
> flush                      122.33     111.94         19.45    -8.49%
> lockx                        0.95       1.21          0.45    27.55%
> max_commit_ms               38.40      45.40          2.30    18.23%**
> mkdir                        0.08       0.18          0.04   129.35%**
> ntcreatex                   35.41      48.84          3.60    37.95%**
> qfileinfo                    3.52       3.31          1.12    -6.11%
> qfsinfo                      4.25       4.46          0.33     4.95%
> qpathinfo                   25.30      32.56          3.72    28.68%
> readx                        7.56       7.97          1.92     5.49%
> rename                      50.33      50.86         12.36     1.06%
> sfileinfo                    9.17       8.60          1.67    -6.22%
> throughput                 315.59     282.74         10.32   -10.41%**
> unlink                      44.87      54.50          6.19    21.44%
> unlockx                      0.75       2.19          0.37   191.39%**
> writex                      98.36      92.78         17.51    -5.68%
>
> dio4kbs16threads results
>       metric           baseline       current        stdev            dif=
f
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> avg_commit_ms             2339.20       1071.20        975.30   -54.21%
> bg_count                       20            20             0     0.00%
> commits                         1             1             0     0.00%
> dev_read_iops                  48            48             0     0.00%
> dev_read_kbytes              1040          1040             0     0.00%
> dev_write_iops         1105312.80       1070254      11754.77    -3.17%**
> dev_write_kbytes       4919395.20    4815462.40      57354.39    -2.11%
> elapsed                        61            61             0     0.00%
> end_state_mount_ns    50869016.60   50826535.40    1496475.65    -0.08%
> end_state_umount_ns      3.02e+09      2.99e+09   43691601.05    -0.97%
> frag_pct_max                98.38         98.43          0.55     0.05%
> frag_pct_mean               51.91         51.61          0.27    -0.59%
> frag_pct_min                 5.45          4.79          0.29   -12.12%
> frag_pct_p50                51.91         51.61          0.27    -0.59%
> frag_pct_p95                98.38         98.43          0.55     0.05%
> frag_pct_p99                98.38         98.43          0.55     0.05%
> fragmented_bg_count             2             2             0     0.00%
> max_commit_ms             2339.20       1071.20        975.30   -54.21%
> sys_cpu                     18.11         17.24          0.06    -4.78%
> write_bw_bytes           72547808   69915896.40     851270.12    -3.63%**
> write_clat_ns_mean      900096.95     933821.96      10417.71     3.75%**
> write_clat_ns_p50       400179.20     394444.80       4486.94    -1.43%
> write_clat_ns_p99      2657484.80       2867200      37361.27     7.89%**
> write_io_kbytes        4255195.20    4102859.20      48123.74    -3.58%**
> write_iops               17711.87      17069.31        207.83    -3.63%**
> write_lat_ns_max         9.19e+08      9.59e+08      1.02e+08     4.37%
> write_lat_ns_mean       900449.84     934178.51      10411.01     3.75%**
> write_lat_ns_min        148662.20     149014.40       3485.37     0.24%
>
> diorandread results
>       metric           baseline       current        stdev            dif=
f
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> avg_commit_ms                5.31          5.49          0.08     3.35%**
> bg_count                       18            18             0     0.00%
> commits                        18            18             0     0.00%
> dev_read_iops          2755803.60    2722414.60      23232.33    -1.21%
> dev_read_kbytes       11022186.40   10888630.40      92929.32    -1.21%
> dev_write_iops           41688.20      42010.80        312.31     0.77%
> dev_write_kbytes         16897548      16897548             0     0.00%
> elapsed                        61            61             0     0.00%
> end_state_mount_ns    47309004.80   49367506.20    1371322.67     4.35%
> end_state_umount_ns      1.07e+09      1.07e+09    6066020.04    -0.10%
> max_commit_ms                6.60          6.60          0.55     0.00%
> read_bw_bytes            1.88e+08      1.86e+08    1587441.01    -1.21%
> read_clat_ns_mean       345830.30     350152.25       2831.51     1.25%
> read_clat_ns_p50        327270.40     331366.40       2243.47     1.25%
> read_clat_ns_p99        647987.20     656179.20       9340.32     1.26%
> read_io_bytes            1.13e+10      1.11e+10   95159625.71    -1.21%
> read_io_kbytes        11022186.40   10888630.40      92929.32    -1.21%
> read_iops                45924.71      45368.09        387.56    -1.21%
> read_lat_ns_max           4530461   13372441.20    2563283.41   195.17%**
> read_lat_ns_mean        346044.45     350359.97       2846.68     1.25%
> read_lat_ns_min         138696.20        134640       4341.30    -2.92%
> sys_cpu                     24.22         24.16          0.21    -0.23%
>
> emptyfiles500k results
>       metric           baseline       current        stdev           diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> avg_commit_ms               26.60         24.20          5.13   -9.02%
> bg_count                        3             3             0    0.00%
> commits                         1             1             0    0.00%
> dev_read_iops                  48            48             0    0.00%
> dev_read_kbytes              1040          1040             0    0.00%
> dev_write_iops             842.80           842         15.27   -0.09%
> dev_write_kbytes         13460.80         13448        244.33   -0.10%
> elapsed                     42.20         42.20          0.84    0.00%
> end_state_mount_ns    48019710.20   47157285.80    2091327.38   -1.80%
> end_state_umount_ns      1.46e+09      1.46e+09   26640049.48    0.04%
> max_commit_ms               26.60         24.20          5.13   -9.02%
> sys_cpu                      5.47          7.76          0.18   41.97%**
> write_bw_bytes         3077613.60    3073469.80      66469.32   -0.13%
> write_clat_ns_mean       67202.18      98477.96       1091.86   46.54%**
> write_clat_ns_p50        63027.20      93900.80       1061.71   48.98%**
> write_clat_ns_p99       135270.40     169779.20       4165.81   25.51%**
> write_io_kbytes            125000        125000             0    0.00%
> write_iops                 751.37        750.36         16.23   -0.13%
>
> randwrite2xram results
>       metric           baseline       current       stdev           diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> avg_commit_ms              872.44        847.24        13.74   -2.89%
> commits                        60         71.40         4.85   19.00%**
> dev_read_iops              630.40       1092.60       240.86   73.32%
> dev_read_kbytes           9414.40      16627.20      3800.10   76.61%
> dev_write_iops         5119929.40    5187028.80    123210.86    1.31%
> dev_write_kbytes      37392001.60   39529271.20   1840547.09    5.72%
> elapsed                    312.80        312.20         0.84   -0.19%
> end_state_mount_ns    58923162.40   58027381.60   2021748.73   -1.52%
> end_state_umount_ns      1.06e+10      1.07e+10     5.74e+08    0.87%
> max_commit_ms             1608.60       1549.20       116.36   -3.69%
> sys_cpu                      9.83          9.63         0.10   -2.02%
> write_bw_bytes        48972662.80   47887587.20    400536.11   -2.22%**
> write_clat_ns_mean      331763.74     339356.86      2837.07    2.29%**
> write_clat_ns_p50        29721.60      30028.80       642.55    1.03%
> write_clat_ns_p99       297164.80        329728     34486.16   10.96%
> write_io_kbytes       14378941.60   14054288.80    129599.67   -2.26%**
> write_iops               11956.22      11691.31        97.79   -2.22%**
> write_lat_ns_max         2.24e+09      2.23e+09     1.17e+08   -0.41%
> write_lat_ns_mean       331873.49     339472.07      2838.23    2.29%**
> write_lat_ns_min         18096.40      17637.40       772.99   -2.54%
>
> smallfiles100k results
>       metric           baseline       current        stdev           diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> avg_commit_ms               71.00         76.99          3.72    8.44%
> bg_count                       19            19             0    0.00%
> commits                     12.40         12.60          1.52    1.61%
> dev_read_iops                 111        111.80          9.82    0.72%
> dev_read_kbytes           1865.60       1875.20        166.89    0.51%
> dev_write_iops         2183867.80    2183585.60      12589.22   -0.01%
> dev_write_kbytes      21161021.60   21168306.40      71548.04    0.03%
> elapsed                    390.40        391.40         47.79    0.26%
> end_state_mount_ns    42532681.60   42288602.40    1686619.50   -0.57%
> end_state_umount_ns      7.44e+09      8.06e+09      4.25e+08    8.30%
> max_commit_ms              132.20           135          9.83    2.12%
> sys_cpu                     39.03         39.36          4.34    0.86%
> write_bw_bytes           5.46e+08      5.45e+08   58484454.42   -0.16%
> write_clat_ns_mean       12794.53      12769.69       3097.83   -0.19%
> write_clat_ns_p50        11315.20         11264       3334.89   -0.45%
> write_clat_ns_p99        27545.60      27494.40       5067.25   -0.19%
> write_io_kbytes          2.04e+08      2.04e+08             0    0.00%
> write_iops              133271.81     133057.37      14278.43   -0.16%
> write_lat_ns_max         34433966   34705517.60    4302608.84    0.79%
> write_lat_ns_mean        12881.08      12859.97       3106.37   -0.16%
> write_lat_ns_min             5946       5814.40        204.95   -2.21%
> ```
>
> Sent using hkml (https://github.com/sjp38/hackermail)

