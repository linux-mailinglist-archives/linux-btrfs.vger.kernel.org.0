Return-Path: <linux-btrfs+bounces-10208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFC9EBA29
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 20:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A036281878
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 19:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE60E226171;
	Tue, 10 Dec 2024 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="NP8WAcP9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC6204684
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733859377; cv=none; b=bfhh7eqI24VGk7qcJPjYMwA0/wXoxQclIove9RuqJzKTUwasKbCFxHPpn23QL5PSdcSQ6s7rD6dPZWoPm/OqJ6aDDtoNwdCp1xnLXu8QHFEA1ON4XA8d7zSKLPOzkmNg1Y0hadqX5H03Agp8appzKUBK4pGR74QQxbnT5kloIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733859377; c=relaxed/simple;
	bh=j/s7LtWMyB9oKKhg78D4qizqe4lC2n7/oTfRFhaV2tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9PV8Jzz76KcSMkL3wz45ByxhQSNlDW0xl4R4SiMK6bY7wgwWo3l177wD0wwppIfS2cwPQgQK+xg6PN3ncbkP/OYM3Gq+COn86PpklvcrDtxwDP6ySar0V7o2g8wfy9TKpr4tVfgw9iCLcvvaKtKYJfatnwtWCD1PlTbCrT1Ju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=NP8WAcP9; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id L61dtDWhDzGIhL61dtdLFp; Tue, 10 Dec 2024 20:36:06 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1733859366; bh=Tz4Q7ktFp4ErSt2bPF7nPY9n6FGzbyEQdfxvpb0855M=;
	h=From;
	b=NP8WAcP9r+UxyHkPZ6U9OrHhWf6A0pROl0zLTFZAL8QIaaVVxxUWTiPFQEwX4x8/q
	 w0jdChOJj63i9gl8cXicECliG3zQn3K9vsg4GfDGjx9zMdtAtXpiyBsTpvVBPec84G
	 jreagEz/ysVjO02Rc+76KbAbdKJ8iaswH+daUQO1LQKopPfqwGE6NsSpvup5T4I6+X
	 aSEFeAfg9sRiYp7fpgiAS+9NRIh2DeArxGtaBvA8Ue5dusBfsZPmp93NzuRiipcTQH
	 fZJNIgEUtVLL79cra1osHxCQwuTnCdk7ORzh+dFmdjiZTSI7sDBSyDzbHjzMxwZh1H
	 q7mLLlOr3QyMw==
X-CNFS-Analysis: v=2.4 cv=ZN0cmm7b c=1 sm=1 tr=0 ts=67589826 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=kHFAZzBmicq46ddY7i8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <08082848-9633-4b3c-9d9d-6135efab8e2d@libero.it>
Date: Tue, 10 Dec 2024 20:36:05 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: Using btrfs raid5/6
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
 <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
 <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
 <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
 <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com>
 <cfa74363-b310-49f0-b4bf-07a98c1be972@gmx.com>
 <Z1eonzLzseG2_vny@hungrycats.org>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <Z1eonzLzseG2_vny@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDBSs5cIN+WxND2e0gzgR0w65bk4uMSCBjQiIv/V9/jY+uDqmd06E9n8A+deX/XZ5wHtS0fxBB4aIEBSM1REIOInmIy6IVijgMy093hcLIn2TMGS/aJb
 nzw5tczE9x///mrVryz/z2TZwKzoSLl3bVfHDcU4siudD/e68PyoxC7pID6sJ/CO70Ke4ub3GjYfHlXC4MDRtNqYGc/ZcrC7EY0FA4v9LoMppmxz4dV2mz4m
 NKUFmjsf27JxiNoiAvgdY5tbWuH3aq68rdI3pl7ASy2pBv5/QyCqOIikV7kb7Nr6HM8KPNqabAvw3d/veRgAPnzD/k+mV5ahcOVE49yAlBhQh6VqkhwyMDL4
 nMmhQNJC

On 10/12/2024 03.34, Zygo Blaxell wrote:
> On Sun, Dec 08, 2024 at 06:56:00AM +1030, Qu Wenruo wrote:


Hi Zygo,


thank for this excellent analisys

[...]


> There's several options to fix the write hole:
>
> 1.  Modify btrfs so it behaves the way Qu thinks it does:  no allocations
> within a partially filled raid56 stripe, unless the stripe was empty
> at the beginning of the current transaction (i.e. multiple RMW writes
> are OK, as long as they all disappear in the same crash event).  This
> ensures a stripe is never written from two separate btrfs transactions,
> eliminating the write hole.  This option requires an allocator change,
> and some rework/optimization of how ordered extents are written out.
> It also requires more balances--space within partially filled stripes
> isn't usable until every data block within the stripe is freed, and
> balances do exactly that.

My impression  is that this solution would degenerate in a lot of waste space, in case

of small/frequent/sync writes.

> 2.  Add a stripe journal.  Requires on-disk format change to add the
> journal, and recovery code at startup to replay it.  It's the industry
> standard way to fix the write hole in a traditional raid5 implementation,
> so it's the first idea everyone proposes.  It's also quite slow if you
> don't have dedicated purpose-built hardware for the journal.  It's the
> only option for closing the write hole on nodatacow files.

I am not sure about the "quite slow" part. In the journal only the "small" write should go. The

"bigger" write should go directly in the "fully empty" stripe (where it is not needed a RMW

cycle).

So a typical transaction  would be composed by:

- update the "partial empty" stripes with a RMW cycle with the data that were stored in the journal

in the *previous* transaction

- updated the journal with the new "small" write

- pass-through the "big write" directly to the "fully empty" stripes

- commit the transaction (w/journal)


The key point is that the allocator should know if a stripe is fully empty or is partially empty. A classic

block-based raid doesn't have this information. BTRFS has this information.



BR

G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


