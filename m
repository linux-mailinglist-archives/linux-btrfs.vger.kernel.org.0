Return-Path: <linux-btrfs+bounces-10645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5E19FBB49
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Dec 2024 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055547A2D3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Dec 2024 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C901A8F98;
	Tue, 24 Dec 2024 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="l0fxg/eX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E28C1F
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Dec 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032835; cv=none; b=WRDtxnaK0eMTHLJAdbMfRv2g7DiH0y5gIdacuvOXIkt5OIWkGOJAuuxfOvh8VcK0Hrcc58AMIM/RdBDlrOBgtQCfbq32r7UagZtGqF0vdvIRUyz4z/esM30vY1CkToFZcB5rgJTFyYfA4szDMTLRt4HFrggwe3h0LrE3IyQfVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032835; c=relaxed/simple;
	bh=AmuzAFgda/6LcVNBnCUMMgHiABdLfmbwi5tS43TgX5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbFwrs9KGf9T1vQTt/DcB33upwPJQxaFykpkNV0wOqJxS0GTi2VsUYWQ8SZ1+RlM7dEDPtpAM0fIk/BOzAtmGrSuKWcRwxxgbIobYaBAwvlqt6C9oAO8PreAILFw2PcfMIAq2vinc7EneRBUcsBxe5cE4Br3bKA+ZL68+gCHt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=l0fxg/eX; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPSA
	id Q1FwtMikHhfWJQ1FwtsZKy; Tue, 24 Dec 2024 10:31:13 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1735032673; bh=NfR4ZYKC0iSI1L87R4DR05oYFZWiwQqMUhm4ey5tHf0=;
	h=From;
	b=l0fxg/eXDUN2yAgNEhCTxDd/HUhbobY9VuQ/zr3KrMwMCVlX/OQ0S/lwfLC/hVAbl
	 2JQ4jA139g24KWv1lswoV+OXRz0gV9ZSqUb4EFb5posLzq+pzL9IMkzBbX9xcFfMCw
	 Ya9ql1a2CI/SM8T2OSCZXdvirPp8642WBVCDZRbk6Bn96NowGyidD3me1pKUS4lc12
	 YENEQnIzNi9qw7KwBjTOCRvQTlXBxlysWGFlp2MUphDHSYr98Z+fpFYlzrlMp/fXet
	 ARKrQD5HRD0YRwwI8Zw5Rquwt9KOUSI1BgAAlUaRUVxFrkzvHkYEYTfnFjjUSBzzdQ
	 w7Tua3tzYCbLw==
X-CNFS-Analysis: v=2.4 cv=ducQCEg4 c=1 sm=1 tr=0 ts=676a7f61 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=y-U2rMXBQ2PRuriArNAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <1fa6e438-a2d0-4aea-a647-b09b619f70af@inwind.it>
Date: Tue, 24 Dec 2024 10:31:12 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: Proposal for RAID-PN (was Re: Using btrfs raid5/6)
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: Forza <forza@tnonline.net>, Zygo Blaxell
 <ce3g8jdj@umail.furryterror.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Qu Wenruo <wqu@suse.com>, Scoopta <mlist@scoopta.email>,
 linux-btrfs@vger.kernel.org
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
 <e2ca9ceb-4ead-4739-af8b-f37b1a902170@libero.it>
 <CAA91j0VkpOLjRtSjTDLKoT6zwoKmTPZkOZqpkon040zyn=dNiw@mail.gmail.com>
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAA91j0VkpOLjRtSjTDLKoT6zwoKmTPZkOZqpkon040zyn=dNiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfO5XleQ37g4fu1dLkbKMwhUkSlErO04dMKZPY2xHwBbYELdZTArCsDES8wFBhFhcWgBxhtwhYlsb/WpoX1j27t+X4M3Tb+S88Fx/9IKzaYoQSF8PUrmt
 /RXndTX6mMJAns7qEblnJ+9ov7ty56BSaN7I8BbsL3pHT8H0Rp7k1qfAlckT8ahVqMBeiGNtLeJ//DQyS5isl4TIjKKisfv/HErUnki271r6DRr9L11MN4qB
 Ae2KLNCzJp4snimTsRRB98YE2lKsNtP53/I6Dz43W2ygKIX5c7YtobpjB7iIlDDNhN/m5BtV7tjMxC9ut9A6EppfmO36SjXh6SxzyXGOhd7E/H0pG5tH4Syl
 Hdi3IPY9mlDvvZ9/ex4zEHF6twAafJSwXkeDFM2J09vXqHQ3+D4=

On 23/12/2024 08.42, Andrei Borzenkov wrote:
> On Sun, Dec 22, 2024 at 3:00 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
>> On 21/12/2024 19.32, Forza wrote:
>>>
>>>
>>>
>>>
>>> Hi,
>>>
>>> Thank you for the detailed explanations and suggestions regarding the write hole issues in Btrfs RAID5/6. I would like to contribute to this discussion by proposing an alternative implementation, which I call RAID-PN, an extent-based parity scheme that avoids the write hole while addressing the shortcomings of the current RAID5/6 implementation.
>>>
>>>
>>> I hope this proposal provides a useful perspective on addressing the write hole and improving RAID performance in Btrfs. I welcome feedback on its feasibility and implementation details.
>>>
>>>
>>> ---
>>>
>>> Proposal: RAID-PN
>>>
>>> RAID-PN introduces a dynamic parity scheme that uses data sub-extents and parity extents rather than fixed-width stripes. It eliminates RMW cycles, ensures atomic writes, and provides flexible redundancy levels comparable to or exceeding RAID6 and RAID1c4.
>>>
>>> Design Overview
>>>
>>> 1. Non-Striped Data and Parity:
>>>
>>> Data extents are divided into sub-extents based on the pool size. Parity extents are calculated for the current data sub-extents and written atomically in the same transaction.
>>>
>>> Each parity extent is independent and immutable, ensuring consistency.
>>>
>>> Example: A 6-device RAID-P3 setup allocates 3 data sub-extents and 3 parity extents. This configuration achieves 50% space efficiency while tolerating the same number of device failures as RAID1c4, which only achieves 25% efficiency on 6 devices.
> 
> Giving something a pretty name does not really explain how it works.
> Can you show an example layout?
> 

My understanding is that every "strip" part of a "stripe" is referenced
by an extent. So if you want to update a stripe, you can rewrite it in a COW
way the impacted part (the data strip and the parity stripS).
To me it seems what already happen with RST+Raid.

>>
>> 5 - let me to add another possible implementation:
>>
>> The parity is stored inside the extent, at fixed offset. Then the extent is written in a striped profile.
>>
>> 1) map the disks like a striped (non raid) profile: the first block is the first block of the 1st disk, the second block is the 1st block of the 2nd disk... the n block is the 1st block of the n disk, the n+1 block is the 2nd block of the first disk...
>>
>> 2) in the begin of the extent there are the parity blocks, and the parity blocks are at fixed offset (each n blocks); in the example below we assume 6 disks, and 3 parity
>>
>>       if we have to write 1 data block, the extent will contain
>>                  {P11, P21, P31,     D1}
>>
> 
> What happens with the holes? If they can be filled later, we are back
> on square one. If not, this is a partial stripe that was mentioned
> already.

It is a "standard" extent, which means that it is "written" (or better,
referenced) atomically, so write hole can't happen. The only differences
is that these kind of extents host also the parity blocks.

Assuming a raid 5 with 6 disks, you can have an arrangement like

{P1 D1 D1} {P2 D2   D2
  D2 D2 D2} {P3 D3} {P4
  D4 D4 D4   D4 D4   P4
  D4 D4 D4} ...

The column are the disks, the {} pair delimites an extents. In this case
I showed extents with:
  D1: 2 blocks,
  D2: 5 blocks
  D3: 1 blocks
  D4: 8 blocks

During a extent read, the parity blocks are skipped; if a read error
happen, the extent is fully read, and the missing information are
rebuild on the basis of the parity blocks. Being an extent, it is
not updated in place.

Exception is NOCOW, for which it is impossible to preserve the
property of being a "light" write and maintain a "sync" of the
parity block (except a journal is used).

Regarding the comparison with the "partial stripe" design (I assume
that you are referring to the Zygo email) this design doesn't
coalesce small (unrelated) writes; or at least nothing more than
the usual delalloc extents handling.

> The challenge with implementing partial stripes is tracking unused
> (and unusable) space efficiently. The most straightforward
> implementation - only use RAID stripe for one extent. Practically it
> means always allocating and freeing space in the units of RAID stripe.
> This should not require any on-disk format changes and minimal
> allocator changes but can waste space for small extents. Making RAID
> strip size smaller than 64K will improve space utilization at the cost
> of impacting sequential IO.

The advantage of putting the parity inside the extent, is that you have
a variable stripe size, so the problem of wasting the space disappear.
However for small extent you have to pay the cost of impacting
the sequential IO (but does it still matters in a world which is turning
into a SSD storage ?).

For larger extents, you can have an arrangement which preserves the 64K strip,
as show below in a 3 disks raid 5 layout.

{ P1  D1  D17
   P2  D2  D18
   P3  D3  D19
   [...]
   P16 D16 D32
   P17 D33 D49
   P18 D34 D50
[...]
}

> 
> Packing multiple small extents in one stripe needs extra metadata to
> track still used stripe after some extents are deallocated.
> 
>>       if we have to write 2 data block, the extent will contain
>>                  {P112, P212, P312,  D1, D2}
>>
>>       if we have to write 6 data block, the extent will contain:
>>                  {P1135, P2135, P3135,  D1, D3, D5,
>>                    P1246, P2246, P3246,  D2, D4, D6}
>>
>>       if we have to write 12 data block, the extent will contain
>>                  {P1159,  P2159,  P3159,   D1, D5, D9,
>>                    P12610, P22610, P2610,   D2, D6, D10,
>>                    P13711, P23711, P33711,  D3, D7, D11,
>>                    P14812, P24812, P34812,  D4, D8, D12}
>>
>> In this way, the number of the extents remain low, and the allocator logic should be the same.
>>
>> Rewriting in the middle of an extent would be a mess, but as pointed out by Zygo, this doesn't happen.
>>
>>
>>> Implementation Considerations
>>>
>>> RAID-PN requires changes to support sub-extents for data. Parity extents must be tracked and linked to the corresponding data extents/sub-extents..
>>>
>>>
>>> NoCOW files remain problematic. We need to be able to generate parity data, which is similarly difficult to generating csum, making NoCOW files unprotected under RAID-PN.
>>>
>>>
>>> Random small I/O is likely to outperform RAID56 due to the lack of RMW cycles. Large sequential I/O should perform similarly to RAID56.
>>>
>>> ---
>>>
>>>
>>>
>>
>>
>> --
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

