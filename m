Return-Path: <linux-btrfs+bounces-11474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C9A367A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 22:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD537A1E5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 21:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202951DDC00;
	Fri, 14 Feb 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="leA+Ax7F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154251DCB0E
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569207; cv=none; b=EGegAnwKXfVKgprmz5hKA/4Q/f/oO8elA5JyRLbNPlZifSBZU4ZiNM0Qh55Rtq1HOdpGL6WCXdEXRFZYkrS4tHRXjDmNDHeP1ae2iUC/O0QvTx6YPxlk+Ekjh/Cl+tMCU7Dz/LcbgzIzHXrPu1cq82HiEAJuUYOoRmRLEN2MsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569207; c=relaxed/simple;
	bh=AA4z34uy4uwPbBiAZIFyCoDeDbxN+XFbQmlTPMTPEEQ=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=hhG8eMG2yh6IOS2VtGJMyQUxI5EYlDmMsCmQoVYmeFL4LVNZAMQ6vN/DnMyZGUV09gq5idBk5E88aH8s6jlvSkJWxZCE28/1cn0mSSShZR37iHoKWcOU9anJoURfDOExJIsG1FpNf/Phtboz7Z6U4v3qkDNdlflQgP9bVRYRf4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=leA+Ax7F; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f2f391864so580211f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 13:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739569203; x=1740174003; darn=vger.kernel.org;
        h=mime-version:user-agent:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mzq8AeYrwcq0lVjVLw9GZ7bau5JMYpC8y7BQzAOLk/k=;
        b=leA+Ax7FhWvp6BDWpNiOTUmzFl2CKihI7dTdM+i7Niv+nOUJj9otBWxixN14DAYBLc
         tZjSM3CFwYCRFV0y7gztkpSt6iE/ATHaRTTlC3Qxqk71SItJU2YNpoFr86FScQ2s8UzP
         BhDtI6/ySWPwZXZOIcLjZq5gJvoOmxZSMBF8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739569203; x=1740174003;
        h=mime-version:user-agent:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzq8AeYrwcq0lVjVLw9GZ7bau5JMYpC8y7BQzAOLk/k=;
        b=soX9dSo6jvWWjO8vGcP2QXNlRM0UApfpRfgl+B3BIusAv/SlFsQiw/Y6QqaMiqocxc
         YCpTC61nxI1Amccx+77PjFx6y+lCcLf4TfKP+z67xtqnZA7P6/YF92CjfetQ9EJ7Zz+3
         ZGAMxpxij6/AZPXvuLBipfyuDR4hPGwuM/DMHbrKkaCCFTHrAsYOGHtyP6Qqqwtv3ppm
         IahnlNhBb/JpWoFZ2JMyKZ1u3Dz6bmMuAAbUqlz4qb/NsWuFhppO1Pqrfh3/XaM3lMDU
         X5gFKNfQeIQwUnFeWxbl9lCvEk8+T7lDyz/PN8KPpwLzjEJq9Xfxa/Brd49QAf6JuK0X
         PuFQ==
X-Gm-Message-State: AOJu0Yyw0CSziVHiEQUGOhfqUH1AduvKnW9QvtMxBtf4Lpq7NFKLz+NZ
	6AFq3ilIAsysiZDSMRkMKndnh6WEDeQgnKPB+IWRpoDRJ/wv6UySs0+8eqIU7A3CDDVMtiHvWSH
	KW2vDKw==
X-Gm-Gg: ASbGnctnLRo8BCXd89+Z58xNtIw1mrYY6kxlFZgbMyBhXsj71fAgWSePQ4k3ovwvNCt
	rEhmQ8p/mqB7U1eC7n1pkpsiy87+BD1CQw0OvF5b7fzrbrcwv/FwooAsuNMYmrjkGIG+zBlIpSw
	m0SlS0mPYEa3ZsieT3UT7DXi+LrObWRDp3uKkTyW1yPeTdpW6RqRYdXx2wdsrm6UQpf3nEsmgMt
	zZfKoxp1ohwht3dcnWodzVSJEmworxW9uipjMH000xW78k24aZx6PQQxEIhWkAo1VPXzdRmdKHf
	Efh8H3kO3SsCRzQdlpMIFH25MRw4i6WTY934IvigUFIuNySPrQ==
X-Google-Smtp-Source: AGHT+IHMX0569QDJLhAwPc9R2DDnSJhC9orQzMa3mBI2eyJX9Kz2ojngQCgLyPqGQpcbPcpVHyCArQ==
X-Received: by 2002:a5d:47a2:0:b0:38f:2f78:39d7 with SMTP id ffacd0b85a97d-38f33f65f8bmr722988f8f.50.1739569202684;
        Fri, 14 Feb 2025 13:40:02 -0800 (PST)
Received: from able.exile.i.intelfx.name ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961884f93sm53945645e9.27.2025.02.14.13.40.01
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:40:02 -0800 (PST)
Message-ID: <0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name>
Subject: Linux 6.13: excessive CPU usage by btrfs-cleaner/kswapd (again?)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: linux-btrfs@vger.kernel.org
Date: Sat, 15 Feb 2025 01:39:59 +0400
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-uauqw3+X6X+2pAc7dulj"
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-uauqw3+X6X+2pAc7dulj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Linux 6.13.2 (+the pf-kernel patchset at 6.13-pf4, but I don't see
any relevant patches in there), I'm seeing excessive CPU usage by the
btrfs-cleaner and kswapd threads during batch "snapshot backup" runs
(involving mounting historical snapshots one by one and running borg on
them, which is basically lots of stat and open+close pairs):

```
    PID CPU USER       PRI  NI  VIRT   RES   SHR  SWAP      MINFLT      MAJ=
FLT   DISK READ  DISK WRITE    DISK R/W S  CPU% MEM%   TIME+ =E2=96=BDComma=
nd
    423   1 root        20   0     0     0     0     0           0         =
  0         N/A         N/A         N/A R  53.4  0.0 51:12.81 btrfs-cleaner
     97   3 root        20   0     0     0     0     0           0         =
  0         N/A         N/A         N/A S  17.0  0.0 49:42.98 kswapd0
   2065   5 intelfx     20   0 5812M  158M 74588     0     2548068      602=
311         N/A         N/A         N/A S  14.5  1.0 46:34.02 /usr/bin/gnom=
e-shell
```

(these are the top 3 processes by cumulative CPU time on my work
laptop, after a few hours of uptime.)

perf top on btrfs-cleaner (which is the best I know how to do... I suck
at investigative profiling) says:

```
  Children      Self  Shared Object     Symbol
+  100,00%     0,68%  [kernel]          [k] cleaner_kthread
+   94,22%     1,71%  [kernel]          [k] btrfs_run_delayed_iputs
+   75,88%    23,45%  [kernel]          [k] run_delayed_iput_locked
+   50,63%     4,15%  [kernel]          [k] iput
+   25,27%     2,48%  [kernel]          [k] list_lru_add_obj
+   24,18%    22,77%  [kernel]          [k] _raw_spin_lock
+   20,36%     4,38%  [kernel]          [k] _atomic_dec_and_lock
+   16,70%    11,57%  [kernel]          [k] _raw_spin_lock_irq
+   15,48%     1,76%  [kernel]          [k] list_lru_add
+    6,82%     6,78%  [kernel]          [k] mem_cgroup_from_slab_obj
+    6,39%     6,22%  [kernel]          [k] native_queued_spin_lock_slowpat=
h
+    5,29%     0,88%  [kernel]          [k] xa_load
```

perf top on kswapd0 is inconclusive, all of it is shrink_folio_list and
zswap from there, but I don't remember seeing that kind of CPU usage
before. All of it is bursty, with kswapd0 eating CPU at the same time
as btrfs-cleaner.

Any ideas? Anything I can do to profile better?

Thanks,
--=20
Ivan Shapovalov / intelfx /

--=-uauqw3+X6X+2pAc7dulj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmevuC8VHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6dIScQAK6q1HjmPgxqoAarfBOZomvkOGqZ
HUJDH4MxoY1HVla7qzrAKRIdhOLe8rnHygNAP9EYJ+36OYfTchZBAq4O+viXw4C6
Z12svb/f7CVWW0eiYFGVG4ih3lLSJc/lx1t2NKReuDZjshbRpwMhNEZS76YPhZQt
HRcmhe8zARBcY8VQIZGU5r4qeqHx1v9Vk1ihpV321l1Iuah6lW8mhx3hIz/rZMZp
7fQ8JDCIaTfslbyH4aCxwqScGLbihLB9ORIn8ao3QbDF1EMfpf4WdxhWkFqsS8V7
Yf3y4T7HIizUwie9H8I+vk2knweUnIIi6dHA8gt3PdasQoxeot2o09cuFlzxjSw0
vO/h+aXt+pcDYKeTLmWG/5b5VZfjtwDG8Xjas47rzywZeQ3sL2IKI65hx2XT1wFx
vMr5yD+abLTdIwjiUYnewmdgKlqJxM5RUZvC6qjsQN1GALOWsOJgpUwLWPcsWb31
1fusVa6iHkwThuwEdBjOx+wiqFTyUmLOR/t3rQABqbxKhEkSHQI4qrj4HofzSV4G
Nf7Lwk61J4SjCCLcYBLWcy1pXO6qq9QHETAH2+KBvRAXyK8FX2ayKqc7Fy8xIm//
wT1bN6PRDZro09rw9bsw24scRobG0BwqjL5FZ2+eF5i78L8plegd/hZxvzdtkX4u
6wffazDPtWIlzISU
=7p8C
-----END PGP SIGNATURE-----

--=-uauqw3+X6X+2pAc7dulj--

