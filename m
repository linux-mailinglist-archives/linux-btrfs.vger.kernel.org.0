Return-Path: <linux-btrfs+bounces-10634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CD29FA580
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2024 13:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981751651B1
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2024 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E1B18A6D4;
	Sun, 22 Dec 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="CuIMC/dV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90D63B9
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734868979; cv=none; b=lr3CozhEI+iaMOj6WPnbJB9oqm3thwAnjBjy4ggQ5Pn7xKQF4DMMe/Or1cvieH0O3mESMtlpkg558VHUze/GvXdgATpyw47khcTzNJWxh3KN9BBF4YYw03E4wGxHiGrJBd9QYN57gUEwlHJnsVdLrM7XsPPDuwk8/5uh/OO+Wsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734868979; c=relaxed/simple;
	bh=SAuC83cSPN0Hy/ZgAv7GSzTZegxLjOJoNMMQApAW2Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdkMwYdiff1shfs3TtkhxIGLaDJgFek/Vqq/WrsAS5QfGEw5NumOWWyIyKP4PjgbeKHvhcAHyGqQn7ziiJUMcEgnISvKHDAB2mS2U2hOa7qN+lp8pALwXViv9VD+oMfRdXsYT2AEbr7Vgk9YhQNWpXYiubMAWIogkYtLEzkb3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=CuIMC/dV; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id PKd6tlyVMgetmPKd6t3p7g; Sun, 22 Dec 2024 13:00:18 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1734868818; bh=D1J14tLu6wfw769Oi7o/bs/U5iHMNbI80E0eiUg3+MM=;
	h=From;
	b=CuIMC/dVVCwnbpP2FGwcwtjavlrPc/JlGHvoWcWV9QCnPQUlsBQiR8QrjXlkeM0vx
	 s4oE8o6geEfwua7HIlJ7PKW8lCh2tkJbuOMXSpV29NDVs+UqeHPzyukwzOiJ4UQJnI
	 spDA6Aj1THGBQkdEdbKSs45+4acfHkbevdNkLCEpkfMScG4Zn3H3BDZNAHbIIcTLUT
	 MNk2x5cb1CUqkzb/UJh2n8ZZieNIOscOSscvZG7WYvW9kYzHNMj5IabMi9QBZf2cfl
	 3+anegPXlYqnkIVPeX9wvf1GY57Sx/JnUa+IzWnL0jwO1gnG9DyN2FyPrLnYfEkWtz
	 hodYXI9V7B1EQ==
X-CNFS-Analysis: v=2.4 cv=QPmjRRLL c=1 sm=1 tr=0 ts=6767ff52 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=cWKlxCslBCwoSmCUM3sA:9 a=QEXdDO2ut3YA:10
Message-ID: <e2ca9ceb-4ead-4739-af8b-f37b1a902170@libero.it>
Date: Sun, 22 Dec 2024 13:00:16 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: Proposal for RAID-PN (was Re: Using btrfs raid5/6)
To: Forza <forza@tnonline.net>, Zygo Blaxell
 <ce3g8jdj@umail.furryterror.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 <Z1eonzLzseG2_vny@hungrycats.org> <8d4d83e.80527959.193ea7e5d3e@tnonline.net>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <8d4d83e.80527959.193ea7e5d3e@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBLmEEf0KoNrPTwUIwifRC6KWERyIMFvRYedx4UZJ4B6z5e8ov8/2Mrd7MwXgnmjXkicBwdNyRuKweE29EECHk5i7m4G+g1sFdoxQmPV01Xo/hFDME9a
 HggGJg1A0XtVkRG87tBU/j8nq/U9uRP1EXEPw/5URlmvh8wsQzAzlAgu2atwu3uKKQuxYdV6b8bpDSczz3RvyG4VxMn01W8fJs0pPvrTO3n4dNqq78m5jdZU
 Es+sPkoHQUc4zW4Qk1DnnMWd2oGBaA/L/uf5FqVcbaaITldSnwWxA9/tRkRYQClLMrjv9c7Ny0Uo2FIvxmBxZzL6wIiOxtQWsTt2zLfbcswAIegZcHf9kStH
 63xBO0FpK0Nji7iU3uoS40IlFYGrhjYAK7dnmHrESeT0QhcngNk=

On 21/12/2024 19.32, Forza wrote:
> 
>
> 
> 
> Hi,
> 
> Thank you for the detailed explanations and suggestions regarding the write hole issues in Btrfs RAID5/6. I would like to contribute to this discussion by proposing an alternative implementation, which I call RAID-PN, an extent-based parity scheme that avoids the write hole while addressing the shortcomings of the current RAID5/6 implementation.
> 
> 
> I hope this proposal provides a useful perspective on addressing the write hole and improving RAID performance in Btrfs. I welcome feedback on its feasibility and implementation details.
> 
> 
> ---
> 
> Proposal: RAID-PN
> 
> RAID-PN introduces a dynamic parity scheme that uses data sub-extents and parity extents rather than fixed-width stripes. It eliminates RMW cycles, ensures atomic writes, and provides flexible redundancy levels comparable to or exceeding RAID6 and RAID1c4.
> 
> Design Overview
> 
> 1. Non-Striped Data and Parity:
> 
> Data extents are divided into sub-extents based on the pool size. Parity extents are calculated for the current data sub-extents and written atomically in the same transaction.
> 
> Each parity extent is independent and immutable, ensuring consistency.
> 
> Example: A 6-device RAID-P3 setup allocates 3 data sub-extents and 3 parity extents. This configuration achieves 50% space efficiency while tolerating the same number of device failures as RAID1c4, which only achieves 25% efficiency on 6 devices.
> 
I see here few technical challenges:

1) I assume that each substripe is "device" specific. This means that the allocator should not find an empty space big enough to host the data, but  the allocator should find 6 empty spaces on different disks.

2) the efficency depend by the data size. If the extent is a 1 sector size, the system should allocate: 1 sub-extent for data and 3 sub-extent for the parity.

3) the number of sub extent grows by factor equal to the number of disks


> 2. Avoidance of RMW:
> 
> Parity is calculated only for the data sub-extents being written. No previously written data extents or parity extents are read or modified, completely avoiding RMW cycles.
> 
> 
> 3. Atomicity of Writes:
> 
> Both data and parity extents are part of the same transaction. If a crash occurs, uncommitted writes are rolled back, leaving only valid, consistent extents on disk.
> 
> 
> 4. Dynamic Allocation:
> 
> RAID-PN eliminates partially filled stripes by dynamically allocating data sub-extents. Parity extents are calculated only for the allocated sub-extents. This avoids garbage collection and balancing operations required by fixed-stripe designs.
> 
> 
> 5. Checksummed Parity:
> 
> Parity extents are checksummed, allowing verification during scrubbing and recovery.
> 
> 
> 
> Addressing Btrfs RAID5/6 Issues
> 
> 1. Write Hole:
> 
> RAID-PN ensures parity and data extents are written atomically and never updated across transactions, inherently avoiding the write hole issue.
> 
> 
> 2. Degraded Mode Recovery:
> 
> Checksummed parity extents ensure reliable recovery from missing or corrupt data, even in degraded mode.
> 
> 
> 3. Scrubbing and Updates:
> 
> Scrubbing validates parity extents against checksums. Inconsistent parity can be recomputed using data sub-extents without relying on crash-free states.
> 
> 
> 4. Small Writes and Performance:
> 
> For writes smaller than the pool size, RAID-PN is less space efficient due to parity overhead (e.g., a 4 KiB write in RAID-P2 requires 1 data sub-extent and 2 parity extents, totaling 12 KiB). However, random small I/O performance is likely better than RAID56 due to the absence of RMW cycles.
> 
> 
> 
> Comparison to Proposed Fixes
> 
> 1. Allocator Changes (Option 1):
> 
> RAID-PN achieves similar outcomes without requiring garbage collection or balancing operations to reclaim partially filled stripes.
> 
> 
> 2. Stripe Journal (Option 2):
> 
> RAID-PN avoids the need for a stripe journal by writing parity atomically alongside data in a single transaction.
> 
> 
> 3. RAID-Stripe-Tree (Option 3):
> 
> RAID-PN avoids the complexity of a remapping layer, though extent allocator changes are required to handle sub-extents.
> 
> 
> 4. Replacement Profile (Option 4):
> 
> RAID-PN offers a new profile that supports multiple-device redundancy, avoids RMW and journaling, and remains write-hole-free while adhering to Btrfs's CoW principles. I think it provides an interesting alternative, or complement, to RAID56.
> 
> 


5 - let me to add another possible implementation:

The parity is stored inside the extent, at fixed offset. Then the extent is written in a striped profile.

1) map the disks like a striped (non raid) profile: the first block is the first block of the 1st disk, the second block is the 1st block of the 2nd disk... the n block is the 1st block of the n disk, the n+1 block is the 2nd block of the first disk...

2) in the begin of the extent there are the parity blocks, and the parity blocks are at fixed offset (each n blocks); in the example below we assume 6 disks, and 3 parity

     if we have to write 1 data block, the extent will contain
		{P11, P21, P31,     D1}

     if we have to write 2 data block, the extent will contain
		{P112, P212, P312,  D1, D2}

     if we have to write 6 data block, the extent will contain:
		{P1135, P2135, P3135,  D1, D3, D5,
                  P1246, P2246, P3246,  D2, D4, D6}

     if we have to write 12 data block, the extent will contain
		{P1159,  P2159,  P3159,   D1, D5, D9,
                  P12610, P22610, P2610,   D2, D6, D10,
                  P13711, P23711, P33711,  D3, D7, D11,
                  P14812, P24812, P34812,  D4, D8, D12}

In this way, the number of the extents remain low, and the allocator logic should be the same.

Rewriting in the middle of an extent would be a mess, but as pointed out by Zygo, this doesn't happen.


> Implementation Considerations
> 
> RAID-PN requires changes to support sub-extents for data. Parity extents must be tracked and linked to the corresponding data extents/sub-extents..
> 
> 
> NoCOW files remain problematic. We need to be able to generate parity data, which is similarly difficult to generating csum, making NoCOW files unprotected under RAID-PN.
> 
> 
> Random small I/O is likely to outperform RAID56 due to the lack of RMW cycles. Large sequential I/O should perform similarly to RAID56.
> 
> ---
> 
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

