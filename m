Return-Path: <linux-btrfs+bounces-8189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FFB983D20
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 08:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F92F1C2265E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 06:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636DA77112;
	Tue, 24 Sep 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxNeBuXd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB757406D
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159246; cv=none; b=oUBCDizOy5JPBPZu6fiXW8gm6n87mqWCXIgKy9pMfbr9Iq+Tgvv0F93oRHd7XL7dS+jQ22GJQSNIwRLwyx5jdlTPa6EHFpCYxayQfUqawOTf7F2W7GJ+obChTdVnSAqxXMmnqk1IK0MI6blxROt2FpEM27WFfn5pKy+ww8gcK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159246; c=relaxed/simple;
	bh=r6wuAFe4+Y8xbgtm5xvR2QgG5vjLODUmMld4e7BZ+q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZKbGEmoO3RSswdov5X02xNqfOXVdZSho+p+b9G8RKtXl/VCNA5aY2RE0+pXC37/EfhkKaoB1URe9e2kr3apBWYS0/jXQbdceRgDfNUc4lev0ENDvKzpHFr5bfoNEEPHuodnBKRVGgAGIYwI3q1yVK5LWM5gNioXlTK7dBy9bhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxNeBuXd; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e1baf0f764so1513088eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 23:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727159242; x=1727764042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRz8CnAmHfeyU8QlplMJS5ppYhyFRhbFroKEoA7k8NM=;
        b=fxNeBuXdnV2vK5sFMxHN8ICBDIQeLVdLCXZmC1ZcMwMalEJRk/+G1yKSrMt4ENGqlv
         uGPY38QPOWyiZDNCKR7Hq2tr2wlWEL0QOkgjrBVW2I+17mEMIwZhIYsPaqBQ5C0hM2R0
         aVI6zj5x25xwsOGzfXM1In15y7tOF0wAIS4Ga8wfQCmh2UBLRELi34zK6AgcbNorhwhe
         Qe5hvhB1cP6Fqhq35l7yXoq+K7DHUKhGk+ackfa8jE3pekNY6+7pGQzonwI0rOj1pQmC
         WXQnxujzG0MFgwjbcvWOrjxQCGH+lWONnYvXzGrRAMuB1xOJynIIEiNgk9DdE8o5cW1a
         aq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727159242; x=1727764042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRz8CnAmHfeyU8QlplMJS5ppYhyFRhbFroKEoA7k8NM=;
        b=J+kbwGuJJqXd7CqVbLL5ELF/2KndMq836YWEUJq1bZxiFBR24Br2DXE/UFNejh5Y+h
         cXiZYnQwIZqyop6WACxOzrf9xtYx+Ds+v/7rTxPwi61mAPTORInwIpx+hKszhd+sB4aT
         HCzMYuDP9E2ayFcaueXD+rjKJtbU4+WzC/VZfsIEoqKqDR95/DD0YWNRQm9+q11nmJ+Z
         z5ZHpE2OKulzhPJUuJbEsCTmOkcanxyOAG9eXupbkbiw5aaZyBU8KzCPcVEJaoAdwNkp
         piZ/1IlaxXigEL1V/73fMzUz4KMunFOBugZ36Cw0qZkAfe2TVo3jqs/HVwSouWvYOOzQ
         F2vQ==
X-Gm-Message-State: AOJu0YxeH0ejMH1UPNLNDUqaicsVkDBWmgtkyx4NbccsyXnnGBmuZb/5
	5xC5HGUcpXZKAZzVDytVMUq6R5v1hU+FeZiYByenrJX/ZHrFJqRkJ+1sP8bp6WdwR9B5MgeTaZS
	/Q9JPozB1J+4g57CK9TRhRjNpfcZH0bux5QI=
X-Google-Smtp-Source: AGHT+IFGBpbuORiHeYvna7o22jc8CNmaKqH9jONfSZ0+Voa8N/oHdUhfwBWudMUC2qYCjpew4968AHUjgouANqeQ6HI=
X-Received: by 2002:a05:6820:614:b0:5e1:ea03:928f with SMTP id
 006d021491bc7-5e58ba6ad96mr7692952eaf.7.1727159242209; Mon, 23 Sep 2024
 23:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4TvLV=6JNyk+m+R-bkec-y+GZo4MaaMK8cn=5ghf9Sgg@mail.gmail.com>
 <a9793ad6-1254-43d3-8a78-6bad7a27eaf1@gmx.com>
In-Reply-To: <a9793ad6-1254-43d3-8a78-6bad7a27eaf1@gmx.com>
From: Dave T <davestechshop@gmail.com>
Date: Tue, 24 Sep 2024 02:27:11 -0400
Message-ID: <CAGdWbB4-4KkN_1P8WbnbkSM7mXfAh6CQhc8KHDHTvRFwA54hiQ@mail.gmail.com>
Subject: Re: Filesystem corrupted
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[  +0.000001] ---[ end trace 0000000000000000 ]---
[  +0.000045] BTRFS: error (device dm-3 state A) in
__btrfs_free_extent:3213: errno=3D-117 Filesystem corrupted
[  +0.000040] BTRFS info (device dm-3 state EA): forced readonly
[  +0.000006] BTRFS info (device dm-3 state EA): leaf 253860954112 gen
33587 total ptrs 44 free space 7040 owner 2
[  +0.000006]   item 0 key (227177136128 168 4096) itemoff 16165 itemsize 1=
18
[  +0.000004]           extent refs 6 gen 135 flags 1
[  +0.000003]           ref#0: extent data backref root 490 objectid
426314 offset 0 count 1
[  +0.000006]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000004]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000003]   item 1 key (227177140224 168 4096) itemoff 16047 itemsize 1=
18
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426315 offset 0 count 1
[  +0.000004]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000003]   item 2 key (227177144320 168 4096) itemoff 15929 itemsize 1=
18
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426316 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000002]   item 3 key (227177148416 168 4096) itemoff 15811 itemsize 1=
18
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426317 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000003]   item 4 key (227177152512 168 4096) itemoff 15693 itemsize 1=
18
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426318 offset 0 count 1
[  +0.000004]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000002]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000003]   item 5 key (227177156608 168 4096) itemoff 15575 itemsize 1=
18
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426319 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000002]   item 6 key (227177160704 168 4096) itemoff 15457 itemsize 1=
18
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426320 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000003]   item 7 key (227177164800 168 4096) itemoff 15339 itemsize 1=
18
[  +0.000002]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426325 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000002]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000003]   item 8 key (227177168896 168 4096) itemoff 15221 itemsize 1=
18
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426326 offset 0 count 1
[  +0.000004]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000002]   item 9 key (227177172992 168 4096) itemoff 15103 itemsize 1=
18
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426327 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 10 key (227177177088 168 69632) itemoff 14985 itemsize=
 118
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426328 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 11 key (227177246720 168 4096) itemoff 14867 itemsize =
118
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426329 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 12 key (227177250816 168 4096) itemoff 14749 itemsize =
118
[  +0.000002]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426330 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 13 key (227177254912 168 69632) itemoff 14631 itemsize=
 118
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426334 offset 0 count 1
[  +0.000004]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000002]   item 14 key (227177324544 168 69632) itemoff 14513 itemsize=
 118
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426336 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 15 key (227177394176 168 69632) itemoff 14395 itemsize=
 118
[  +0.000002]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426337 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 16 key (227177463808 168 69632) itemoff 14277 itemsize=
 118
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426338 offset 0 count 1
[  +0.000004]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000002]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 17 key (227177533440 168 69632) itemoff 14159 itemsize=
 118
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426339 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000002]   item 18 key (227177603072 168 57344) itemoff 14041 itemsize=
 118
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426340 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 19 key (227177660416 168 57344) itemoff 13923 itemsize=
 118
[  +0.000002]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426341 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 20 key (227177717760 168 77824) itemoff 13805 itemsize=
 118
[  +0.000002]           extent refs 6 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426342 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000003]   item 21 key (227177795584 168 61440) itemoff 13596 itemsize=
 209
[  +0.000003]           extent refs 13 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426346 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent
18014665013673984 count 1
[  +0.000003]           ref#2: shared data backref parent 267180048384 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 267147673600 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 267079155712 coun=
t 1
[  +0.000002]           ref#5: shared data backref parent 266967482368 coun=
t 1
[  +0.000003]           ref#6: shared data backref parent 266640375808 coun=
t 1
[  +0.000003]           ref#7: shared data backref parent 266567467008 coun=
t 1
[  +0.000003]           ref#8: shared data backref parent 266540056576 coun=
t 1
[  +0.000003]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000002]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000003]           ref#11: shared data backref parent 254191419392 cou=
nt 1
[  +0.000003]           ref#12: shared data backref parent 253777068032 cou=
nt 1
[  +0.000003]   item 22 key (227177857024 168 77824) itemoff 13348 itemsize=
 248
[  +0.000003]           extent refs 16 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426347 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000003]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000003]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000002]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000003]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000003]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000002]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000003]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000003]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000003]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000003]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000002]   item 23 key (227177934848 168 77824) itemoff 13100 itemsize=
 248
[  +0.000003]           extent refs 16 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426348 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000003]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000002]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000003]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000003]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000002]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000003]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000003]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000003]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000002]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000003]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000003]   item 24 key (227178012672 168 77824) itemoff 12852 itemsize=
 248
[  +0.000003]           extent refs 16 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426349 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000002]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000003]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000003]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000003]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000002]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000003]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000003]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000003]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000002]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000003]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000003]   item 25 key (227178090496 168 77824) itemoff 12604 itemsize=
 248
[  +0.000002]           extent refs 16 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426350 offset 0 count 1
[  +0.000004]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000002]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000003]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000003]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000002]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000003]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000003]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000003]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000002]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000003]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000003]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000003]   item 26 key (227178168320 168 77824) itemoff 12356 itemsize=
 248
[  +0.000003]           extent refs 16 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426351 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000003]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000002]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000003]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000003]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000003]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000002]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000003]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000020]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000005]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000005]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000005]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000005]   item 27 key (227178246144 168 5492736) itemoff 12108
itemsize 248
[  +0.000005]           extent refs 16 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426352 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000003]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000003]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000002]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000003]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000003]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000002]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000003]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000003]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000003]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000002]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000003]   item 28 key (227183738880 168 1945600) itemoff 11860
itemsize 248
[  +0.000003]           extent refs 16 gen 135 flags 1
[  +0.000002]           ref#0: extent data backref root 490 objectid
426353 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000003]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000003]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000003]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000003]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000003]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000002]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000003]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000003]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000003]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000002]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000003]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000003]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000003]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000016]   item 29 key (227185684480 168 5492736) itemoff 11612
itemsize 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426354 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000000]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000000]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 30 key (227191177216 168 1945600) itemoff 11364
itemsize 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426355 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000000]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 31 key (227193122816 168 77824) itemoff 11116 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426356 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000000]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 32 key (227193200640 168 77824) itemoff 10868 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426357 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 33 key (227193278464 168 102400) itemoff 10620 itemsiz=
e 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426358 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000000]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 34 key (227193380864 168 77824) itemoff 10372 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426359 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000000]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 35 key (227193458688 168 77824) itemoff 10124 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426360 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000000]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 36 key (227193536512 168 102400) itemoff 9876 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426364 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000000]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 37 key (227193638912 168 57344) itemoff 9628 itemsize =
248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426366 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 38 key (227193696256 168 102400) itemoff 9380 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426367 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000000]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 39 key (227193798656 168 73728) itemoff 9132 itemsize =
248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426368 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000000]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 40 key (227193872384 168 155648) itemoff 8884 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426369 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 41 key (227194028032 168 372736) itemoff 8636 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426370 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000000]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 42 key (227194400768 168 372736) itemoff 8388 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426375 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180081152 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147689984 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079172096 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967515136 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640392192 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567483392 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540072960 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504208384 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489937920 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355163136 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357438464 cou=
nt 1
[  +0.000000]           ref#12: shared data backref parent 254230626304 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217519104 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191435776 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777051648 cou=
nt 1
[  +0.000001]   item 43 key (227194773504 168 61440) itemoff 8140 itemsize =
248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426378 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180081152 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147689984 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079172096 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967515136 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640392192 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567483392 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540072960 coun=
t 1
[  +0.000000]           ref#8: shared data backref parent 266504208384 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489937920 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355163136 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357438464 cou=
nt 1
[  +0.000002]           ref#12: shared data backref parent 254230626304 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217519104 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191435776 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777051648 cou=
nt 1
[  +0.000001] BTRFS critical (device dm-3 state EA): unable to find
ref byte nr 227177795584 parent 266504192000 root 490 owner>
[  +0.000018] BTRFS error (device dm-3 state EA): failed to run
delayed ref for logical 227177795584 num_bytes 61440 type 184 a>
[  +0.000017] BTRFS: error (device dm-3 state EA) in
btrfs_run_delayed_refs:2207: errno=3D-2 No such entry

On Tue, Sep 24, 2024 at 1:18=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/9/24 12:53, Dave T =E5=86=99=E9=81=93:
> > Hi. I hope you all are doing great today.
> >
> Full dmesg please, the important thing is in the tree block dump.
>
> Thanks,
> Qu
>
> > My errors, shown by dmesg, are:
> >
> >      [  +0.000001] ---[ end trace 0000000000000000 ]---
> >      [  +0.000045] BTRFS: error (device dm-3 state A) in
> > __btrfs_free_extent:3213: errno=3D-117 Filesystem corrupted
> >      [  +0.000040] BTRFS info (device dm-3 state EA): forced readonly
> >      [  +0.000006] BTRFS info (device dm-3 state EA): leaf 253860954112
> > gen 33587 total ptrs 44 free space 7040 owner 2
> >      [  +0.000006]   item 0 key (227177136128 168 4096) itemoff 16165
> > itemsize 118
> >      [  +0.000004]           extent refs 6 gen 135 flags 1
> >      [  +0.000003]           ref#0: extent data backref root 490
> > objectid 426314 offset 0 count 1
> >      [  +0.000006]           ref#1: shared data backref parent
> > 266540040192 count 1
> >      [  +0.000004]           ref#2: shared data backref parent
> > 266489888768 count 1
> >      [  +0.000002]           ref#3: shared data backref parent
> > 266355113984 count 1
> >      [  +0.000003]           ref#4: shared data backref parent
> > 254191386624 count 1
> >      [  +0.000003]           ref#5: shared data backref parent
> > 253776723968 count 1
> >      [  +0.000003]   item 1 key (227177140224 168 4096) itemoff 16047
> > itemsize 118
> >      [  +0.000003]           extent refs 6 gen 135 flags 1
> >      [  +0.000002]           ref#0: extent data backref root 490
> > objectid 426315 offset 0 count 1
> >
> > [ many more lines similar to those ...]
> >
> > 1
> >      [  +0.000001]           ref#1: shared data backref parent
> > 267180081152 count 1
> >      [  +0.000001]           ref#2: shared data backref parent
> > 267147689984 count 1
> >      [  +0.000001]           ref#3: shared data backref parent
> > 267079172096 count 1
> >      [  +0.000001]           ref#4: shared data backref parent
> > 266967515136 count 1
> >      [  +0.000001]           ref#5: shared data backref parent
> > 266640392192 count 1
> >      [  +0.000001]           ref#6: shared data backref parent
> > 266567483392 count 1
> >      [  +0.000001]           ref#7: shared data backref parent
> > 266540072960 count 1
> >      [  +0.000000]           ref#8: shared data backref parent
> > 266504208384 count 1
> >      [  +0.000001]           ref#9: shared data backref parent
> > 266489937920 count 1
> >      [  +0.000001]           ref#10: shared data backref parent
> > 266355163136 count 1
> >      [  +0.000001]           ref#11: shared data backref parent
> > 254357438464 count 1
> >      [  +0.000002]           ref#12: shared data backref parent
> > 254230626304 count 1
> >      [  +0.000001]           ref#13: shared data backref parent
> > 254217519104 count 1
> >      [  +0.000001]           ref#14: shared data backref parent
> > 254191435776 count 1
> >      [  +0.000001]           ref#15: shared data backref parent
> > 253777051648 count 1
> >      [  +0.000001] BTRFS critical (device dm-3 state EA): unable to
> > find ref byte nr 227177795584 parent 266504192000 root 490 owner>
> >      [  +0.000018] BTRFS error (device dm-3 state EA): failed to run
> > delayed ref for logical 227177795584 num_bytes 61440 type 184 a>
> >      [  +0.000017] BTRFS: error (device dm-3 state EA) in
> > btrfs_run_delayed_refs:2207: errno=3D-2 No such entry
> >
> > The drive is a Samsung SSD 970 EVO Plus 2TB.
> >
> > Overall:
> >      Device size:                   1.82TiB
> >      Device allocated:           300.04GiB
> >      Device unallocated:            1.53TiB
> >      Device missing:                  0.00B
> >      Device slack:                    0.00B
> >      Used:                        299.07GiB
> >      Free (estimated):              1.53TiB      (min: 1.53TiB)
> >      Free (statfs, df):             1.53TiB
> >      Data ratio:                       1.00
> >      Metadata ratio:                   1.00
> >      Global reserve:              398.55MiB      (used: 16.00KiB)
> >      Multiple profiles:                  no
> >
> > Data,single: Size:298.01GiB, Used:297.82GiB (99.94%)
> >     /dev/mapper/userluks  298.01GiB
> >
> > Metadata,single: Size:2.00GiB, Used:1.25GiB (62.51%)
> >     /dev/mapper/userluks    2.00GiB
> >
> > System,single: Size:32.00MiB, Used:48.00KiB (0.15%)
> >     /dev/mapper/userluks   32.00MiB
> >
> > What is the recommended course of action given this error?
> >
> > What other info do I need to share, if any?
> >
> > Thank you!
> >
>

