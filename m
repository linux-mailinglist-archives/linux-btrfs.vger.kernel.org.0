Return-Path: <linux-btrfs+bounces-8156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69097E580
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 06:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B71B20BCE
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 04:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8BFBF6;
	Mon, 23 Sep 2024 04:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JoU7dqIm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B644437
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727066765; cv=none; b=l/x7kE762ZLs0EzX9FyxxOz3lifwGQCFF/tqw5SbLHTdkz3Y/y90yHT5xvEEgiGXildglVjIrAWRoPmhxQaXRIIFZzym5j9ErCMGHsT5eT1Qs8is10x1Wp0TBCylPUWRvkkS8/rxmLHq5dJKkjPP5QGH5XAYDP8VMsb7mPKr2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727066765; c=relaxed/simple;
	bh=aBQMri7rKQb8DdXKzL4chctO0k8gOSDQIDd+PSvSrQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=biVkussBG+sWcJom41c/gjNtNCXe9mEJQmNhzGRAiOXjGjf+2B7YUMGGyxzB5/7MCMQ8aI6r5yVj33xpa5k48p2f98GEc5/nfGcQKqPv2I9t1FcJ3DVwCjhh9D7wYYYZnJyyucnS0iqOID0DaV78/Mvoam4o/Ur94KKHr6Di4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JoU7dqIm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso30056965e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Sep 2024 21:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727066760; x=1727671560; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yuORWz95wqvnmj1slOAQ8mdzgOBU8Vl7ZEB0b2nbGo=;
        b=JoU7dqIm5Xo0/7CTGIXVNfHDzkmHDR/q9DOT3+l00aYB/SCeFBCsl9KHumU8XY5IN+
         vfPHnZxmrcGeFXzsF1be8PRSdimg+hWaAOcqzgyOC0k9NQaiqmF4vMxk7mZieZzMImwL
         aNbVCFIELrs8lprQM9THXXSAahPeuw3OmdTVpgET915IHpY93L5oB7j7r6m9AKCD5PQK
         dwW/PSYl6s3pI/ePznjpGvmR0U/1B9owDEGK7f2cIBJfFJPzYMXPdtVlvElMWaphXl85
         Dck2OearJMptoPvwC5OGHkOBGGB2ZT7XOs1Na6Wu6MdG0G5cQQq96YNuiHNmBOvenxXb
         RzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727066760; x=1727671560;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yuORWz95wqvnmj1slOAQ8mdzgOBU8Vl7ZEB0b2nbGo=;
        b=iWHgAEF2PGezKVqt3JXhWFfWW1o15xuzLpu65PtxjiwgJa7rMH8kVhiDcU4jmoE/OS
         /kmuXJWYjhAfkKm8u6lOkcTES/13LXjt5U63tPKIPxnr+sGfoM/9wxrxX7/IcVY2NF+Y
         fwqECeSx91jjT+UDu60zURSpHNdjutfw0Zclc9wV2X8t+YX4I6pv55glC/UFMoE5E77H
         yKlvpft73GzgQTzwP3AWIoruWGEWtyWnF47C4bsr8vvraIUeceUTymF/C0JSEDrr6LSW
         5p49KG6ME1Jsqu321qpbuCm8gboPOc8ggZvRAAbtW6dOSLCVdsz0PcRWFyo6JXuQuAxp
         Xf6g==
X-Forwarded-Encrypted: i=1; AJvYcCU7peoM3AMEV9jJkShWOySe2TfCIqJEBL0IcjNTK7h5p9YjMx4CeJm2O5El+VCAPjhru/xVWzJcoAxOEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tuGjBdaHQBnWev7PQ353R2SI7zaqG9znE/zyE9bId7ZpYwh0
	cm1cdDD9LMNoO5m3o2TQLCywYLks8aTiDoWR07/A3mGMwcF+4UA3C4/aKbvPXGM=
X-Google-Smtp-Source: AGHT+IGe5tfzOElNhCX2mW65nXY4nlxkGchw7kuZ0qh03E5DTn0wqnKAovH3Q59sy9QWKjXoEhldww==
X-Received: by 2002:a5d:4f0e:0:b0:374:bf97:ba10 with SMTP id ffacd0b85a97d-37a43154b16mr5187451f8f.25.1727066760499;
        Sun, 22 Sep 2024 21:46:00 -0700 (PDT)
Received: from [10.202.80.134] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd50c054d8sm7628396a91.0.2024.09.22.21.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 21:45:59 -0700 (PDT)
Message-ID: <380a5687c475baad34771425902eae42e3e3eca4.camel@suse.com>
Subject: Re: [PATCH] btrfs/315: update 315.out to adapt mount cmd
From: An Long <lan@suse.com>
To: Zorro Lang <zlang@redhat.com>, Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Date: Mon, 23 Sep 2024 12:45:58 +0800
In-Reply-To: <20240920142819.oczpp5iah5ojsycl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <bb85eb7d443b2da482b6087d8946f0efafa15f87.camel@suse.com>
	 <20240919120156.apamqapyuytpf3ii@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	 <CAL3q7H7VvysO7S6DxOUwoR-1TWT61NAeHBVcidZca_yiT+q3BQ@mail.gmail.com>
	 <20240920142819.oczpp5iah5ojsycl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Autocrypt: addr=lan@suse.com; prefer-encrypt=mutual; keydata=mQENBFvqfKcBCADKdcrLxNKpkBPfxZwVu1Q3ADpyWdnXZfyQOIO+1Z/WSDeXgr70HUhk/zu81WoO5WyXMK3N1dcS4KrOdNOmDp0H4G5hR+BIkgbIJpo4ekYWVdrAMT8oJgX5EgSIeuDdn2ZJ7K0EDLX9M7969gaw2nHWgBzj/ALGFdCE8zYkZAfPrwN80M5Xl+NBvOrTMypW78WOg5NdGd3E4jjgbKreHFdc9/Bmp2XKQKhjClelfM5aThhsM9wljzWdX1frN2AoAomHKuxKJGvZf30eHoXAs/ikHM4cvoUcY/8H8VgJO3mQMYEFWJR6qSbnfdy3T9Ns/Xy5QGj/XmATwhDg3BMBwvEZABEBAAG0FkFuIExvbmcgPGxhbkBzdXNlLmNvbT6JAU4EEwEIADgWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBmwA3KtD5SBuAwCACDifSf/raZ05H/0l2xAjZo9JFrWib391QLNbDYFi+Nm7nJ3ATse33ibLheOP0hJ07bsZo7uKNio8DIHDZ5CsTMd21ZvvJlNGT+l9BQV/OLRExCTcK9CpLcHoEI3M1niqL42QjVZPkKcjSwbTCa8mySNmIl64K0YTq1HnuWxShTHNlLBBkId9OMEnztgp9Ke4g+SxcU2+058v8ZTnM5wUp6fMsQelsfigJJfRqHbpy6Fap3XIY+1gKuNVIdyKWXovxtwd++fADyZVh/Zh5IKgp/1HyWE9g0MG6TUzJ+LV57jOrIJJbzl39HUp+5mFBI+RSHiJjoBZAQ7diUzT7+ns+0uQENBFvqfKcBCADCPC4telre7E8pAZITzcVsl1BP3PoMAaow4gh1SOO44J34GHJS7CRqpt4YfbPBEVmFZQiJEhb0GL2KH
 qg7J8hO7J9fmpEiCe1Vv+cK8DSxygXXL0fltVkQlgOjFlzYks+tv g58qti7uykoyavLPSu7yuGvDtzIxB3lXwUnvmS0X8MTBFIdK0s4vJOu/2cDIAnYCNdypZ8H44XtYZVDdB9r4E253y35Nd1QDjJFu/8BQxQXK5sReIYl5fRtz+4TzZQPxWt3/j62RmjY5elPEBTd2q4K6reqRuIwDBXjTWjEKylx9yw47nMH7TzIrXpSWLG08+F8Cb9KhUJysBN4tJY1ABEBAAGJATYEGAEIACAWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbDAAKCRBmwA3KtD5SBlJuCACzhZDj5+zuuqYMl07AiV5BqOkGmjghybACLtHjMZDbFOmxnvt7GOfTdf7ug1YguQQI6xIssqzGvXTJVgIfTP38dOSAssrYp78VyFtcAZMiN25GxOOqYlpwhKH1PAr04Ylizz/EZlbfCQ8XCFuTziZ7HwEyjTkvs5XUYJObEhj2Sv9ebhwm3vTZv0VTb8+BpxyQuuGYYakbH94D5Ne5gAC6FaCevXdeqjSCTzV6NZ5seldc3FogQ+TB+riX4G4SA4Nq36Xt4hpAoDoZhh25KsH/9Kq65+eyYKsCnpY+N3f4SAEf5NEODmGF9eKC0K8XcjhXGcpDmnae2tUnjWnjLBXO
Organization: SUSE QE LSG, QE 2, Beijing
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-20 at 22:28 +0800, Zorro Lang wrote:
> On Fri, Sep 20, 2024 at 11:12:12AM +0100, Filipe Manana wrote:
> > On Thu, Sep 19, 2024 at 1:02=E2=80=AFPM Zorro Lang <zlang@redhat.com>
> > wrote:
> > >=20
> > > On Thu, Sep 19, 2024 at 01:07:53AM +0800, An Long wrote:
> > > > Mount error info changed since util-linux v2.40
> > > > (91ea38e libmount: report failed syscall name).
> > > > So add "mount" before "system call failed".
> > > >=20
> > > > Signed-off-by: An Long <lan@suse.com>
> > > > ---
> > > > =C2=A0tests/btrfs/315.out | 2 +-
> > > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> > > > index 3ea7a35a..a19ae8d5 100644
> > > > --- a/tests/btrfs/315.out
> > > > +++ b/tests/btrfs/315.out
> > > > @@ -1,7 +1,7 @@
> > > > =C2=A0QA output created by 315
> > > > =C2=A0---- seed_device_must_fail ----
> > > > =C2=A0mount: SCRATCH_MNT: WARNING: source write-protected, mounted
> > > > read-
> > > > only.
> > > > -mount: TEST_DIR/315/tempfsid_mnt:=C2=A0 system call failed: File
> > > > exists.
> > > > +mount: TEST_DIR/315/tempfsid_mnt: mount system call failed:
> > > > File
> > >=20
> > > This change will bring failure to downstream distro. Please refer
> > > to
> > > _filter_error_mount (or other filters you like), add new filter
> > > to
> > > it to help this test passed on old and new util-linux.
> >=20
> > Isn't that what I said in my previous reply [1]?
> >=20
> > [1]
> > https://lore.kernel.org/fstests/CAL3q7H7fzCQE0qjZEgeAJ2jvBsJxbYN-S=3DXp=
WFu5KDoaXgqsZQ@mail.gmail.com/
>=20
> Oh, sorry I replied directly due to I thought my old change when
> I saw this patch.
>=20
> =C2=A0 commit e937e23d202173d112cfe7621d8b860f691ce42d
> =C2=A0 Author: Zorro Lang <zlang@kernel.org>
> =C2=A0 Date:=C2=A0=C2=A0 Fri May 27 20:11:15 2022 +0800
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common/filter: filter out extra mount erro=
r output
>=20
> Sure, you're right, thanks for reviewing :)
>=20
> Thanks,
> Zorro
>=20
> >=20
> > >=20
> > > Thanks,
> > > Zorro
> > >=20
> > >=20
> > > > exists.
> > > > =C2=A0---- device_add_must_fail ----
> > > > =C2=A0wrote 9000/9000 bytes at offset 0
> > > > =C2=A0XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > > --
> > > > 2.43.0
> > > >=20
> > > >=20
> > >=20
> > >=20
> >=20
>=20


Mount error info changed since util-linux v2.40
(91ea38e libmount: report failed syscall name).
So update _filter_mount_error() to match it.

Signed-off-by: An Long <lan@suse.com>
---
 tests/btrfs/315 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/315 b/tests/btrfs/315
index 5852afad..da5d0ce4 100755
--- a/tests/btrfs/315
+++ b/tests/btrfs/315
@@ -39,7 +39,8 @@ _filter_mount_error()
        # mount: <mnt-point>: fsconfig system call failed: File exists.
        # dmesg(1) may have more information after failed mount system
call.

-       grep -v dmesg | _filter_test_dir | sed -e
"s/mount(2)\|fsconfig//g"
+       grep -v dmesg | _filter_test_dir | sed -e
"s/mount(2)\|fsconfig//g" | \
+        sed -E "s/mount( system call failed:)/\1/"
 }

 seed_device_must_fail()
--=20
2.43.0


