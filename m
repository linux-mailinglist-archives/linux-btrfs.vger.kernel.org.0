Return-Path: <linux-btrfs+bounces-6258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159D9291BD
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 10:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454A21F23178
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB6D45BF9;
	Sat,  6 Jul 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lQCFq8Fd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B86AC0
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Jul 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253467; cv=none; b=h7vaHugZB6K08zOXbu2+JQVXYKRnDKHzSqXPwfVAbuzeACmr3KXrp1VpyKiQkaU4zur9zQKSYX/nviKuJh4iQK3tBnoo4nVCt6hIjGIRytJ2jutZvMc2twbGfZ2mvki09LPll9gFTVSFz0767PWCqS/sAGtLiMGG6esjXmCnnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253467; c=relaxed/simple;
	bh=Bcvb3dk3MfFO4HllkAzX7ZgR0hdcdB4bU2VOhSAMuXk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SpW6CuQ36uXIP7z3w21HkBQVuV1idrlCxB8v+g144WuS+6Y9QTm+ujGaHVk/PMZoHlrH4S1+MF07r5YC3F7FQcdevxbekEai5MU/LCNlv594yB9CldKLh2ahQh/Q2C77BavxTW9cyc/8ckPaN8bhEj7yLscXF77GNz3u/d9BO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lQCFq8Fd; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720253459; x=1720858259; i=quwenruo.btrfs@gmx.com;
	bh=DuPUGaP5333Y/q2ssh5McriHZfSiXSY17VOQfBcKCZs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lQCFq8Fd9yc6HuI7J/9KI6BXcJfXt+kA5dWVm0tzLw9qOh6kIDbQtrorFZaM80Qm
	 5S6p7dD1Hf3cs71Axcu04VJKHBa5bTMeQhBnTmlmb8MoQbwAgJy4rIhDqyxLsuuVM
	 FMk5jT69Oi8fU/TnzJExTjfsPxq/tE3ATMHZgQYa64XiJ9Yd16s3D1Zoo5fX9rB5l
	 SJRWv7ai8JPn1iQcag89qX5I7nW2lsV6N6xzwNpc/KaocUu/VDOTe9cWM0FuPEGEX
	 sabxMKrJW++yJpWLat4STmwBriUtqNl+aBF+hEgBREb1N2uNDIXUFQK2882gmbJEK
	 VXJx234O5YEWTRVgDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1sF2HD35C5-00xEQ8; Sat, 06
 Jul 2024 10:10:59 +0200
Message-ID: <603269e5-f3d6-4c42-a2af-6287f5e0ceca@gmx.com>
Date: Sat, 6 Jul 2024 17:40:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Memory Management List <linux-mm@kvack.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Memory cgroup and special hidden inodes
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5400uQ2riDUdO96ce+lv8SPaMc+5119tDE43wdFO10oC0EI7QCD
 VpIOz8aOqwFxHb9O/kQdRkGBZOpuYwvul07MNY570mRYqkjJuQQz4IWmp+dGf0eKgzOKiVP
 tzpZiTrTpB9A3qHn6EMnC8MWItag+h0O1ErC6TPzkpMvt7iuhdKhZtBebFlhIR9j4NFI8Qm
 cf/lop2MR36ZWm77JmAEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bl9tXzdf3aU=;1Ho6lFkBn5g+4oGKJcPoAX9yq6p
 sMivGkdPaHqzTLdac/OSLmJs+QiWqoZctJNYPiqhVuG09R0yAs0wXU5kYxO1D9qBvEbEY3NpE
 Dx+w2YgsQtin/i8C6uQeDgrN7zdAUErNhjMNxaTJ5IfNykbsNfNgF2EcjVWmM920pFRUUJ8dj
 GDyHmG/jM98quYkQuAQMJGNUU6eG7THWxdtsJEGvQU0R1Ph2I5UC+dMx3guZv4gm7jWo2PTFL
 3UGXphlqgK1TGVWD9GaCNAnOYsoqfj5yFOl9RcbfWCFJavcM0q2gdtCGghvVHybdNVksqKYFu
 bhRR3469flTnsKWmzQfPaT67qNk+Z9MJOlqFCerVrVXYJoNik8cj+m60iKShwj0BGkFbehcot
 CPg5/qxyyeuI364fRyPTdhe1Qumoh4nUSv+IB1eJP6rrcKSp8w0OV8kbQ5zw2srlVGcr0nb//
 TaMdQ9GgZVPB8/RtOl/XAxGqZ0Rj3JAL0i5CzjY1JvvPbA2l/SbJfrELwo+UGcoxcI9XGapFT
 8oMm+UNc+izsGiATaZcIK/Occ3RbBqcMCMkHlXXz8yBc7GngbV+3vMRGK+zE4PCvoDztbw+NE
 QlQ4yn+Qvd3HGTDYHzOo7VmI073VmCFYNNBdbCqhs4f+bS7TwqKy3moEx/23gYBhskb4WaKQC
 ms0zIuKH+AR2wLDQ/k4JyUirB0h2M956GJOZ690JNjMMhdoec0aJ58PawOtra9Hm5qhrtqE0W
 50IATERtQgzqzRBOGGTMGOyGrttRfjD5sVQqF8efBep9IFWvekWTG4YLOOtyOTANKKFewpAyj
 l6Kfge03kMDmrm9apYs16zVD75sotbkMJpI8kgWAfVL5Y=

Hi,

I'm wondering how memory cgroup handles the special inodes, which are
not exposed to end users and are only utilized by the filesystem itself.

Btrfs has at least 3 usages of such hidden special inodes:

- Btree (metadata) inode
   All metadata are mapped in the page cache of btree inode.
   This is the most critical usage, as btrfs has tons of metadata and
   if mem cgroup is limiting the memory usage of btree inode page cache,
   a lot of thing can go wrong pretty easily.

   And a lot of operation on this inode has no obvious task bound to.
   E.g. a lot of delayed operations happens in workqueue context, I'm not
   sure which cgroup those memory would be charged on.

- Data reloc inode
   This is only utilized by relocation, and is only transient.

- Free space cache inode(s)
   They are already being phased out, and the new free space cache tree
   is fully rely on the btree inode.

So my question is, do these special inodes need to be managed by cgroup
in the first place?

Thanks,
Qu

