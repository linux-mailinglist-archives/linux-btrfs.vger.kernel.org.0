Return-Path: <linux-btrfs+bounces-10631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8879FA209
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2024 19:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D9518889BF
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2024 18:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06516EBE8;
	Sat, 21 Dec 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b="TrFkgB+L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.tnonline.net (mx.tnonline.net [135.181.111.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330D5BAF0
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.111.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734807077; cv=none; b=YwPRTB1TAOWs7M/Qf+Q8sMJF0nbh0ISL/yysZRY2/9LxUnx/So4BxAXZydydtlACY9rW8YwKsLRCuqUS29GTm4Ihm16QJaG/XuYpWhxswYjA4YfaRgPWSHoSfbWNT+ogLa4Xnfc1VD9xq9NIsjjQiIcf1OD/D/wN/31MRf1AvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734807077; c=relaxed/simple;
	bh=d616iCBMJGgQupp3KrPVd+bOs0laUDbHHvaN5CDr+Os=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aZjyLW3APTvhsiiJjtFbZjb4ZwwwelflUNVg1BUqjOQ+pC9uR+i2858KKZMN6Xueof4r6Pf9KT0YqyEWCJZWnkfR55bQfPlCgdGu1A0LSxESx3bfELXguNFNdKQ2oFEgu7s+116Iz75KVweluHJzA+5hUVUMENca9pr1TWMeB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net; spf=pass smtp.mailfrom=tnonline.net; dkim=pass (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b=TrFkgB+L; arc=none smtp.client-ip=135.181.111.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnonline.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tnonline.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xlWYzKDmf94C884hYAuSlzvNIHZ8SZsON7px3UXBnX0=; t=1734807074; x=1736016674; 
	b=TrFkgB+Lg1JRZxd8SyJJ4Wcj9p0tH3i+nJUOJWUBNEjzzxN8yQz0hSF0DUCfJRmvNx+zC4G1Mdn
	QF+O79P977aGo7nvJFMQM79VYIHBnwhbdQpXVqAnsivevhOv2hTyAY5BswCyrc1m5lBSS9zKQvmq5
	7xk3ICimgs/fSW12YmSPXBCxw7BnFq0fat92MGJeaZ3JJWe/nzWY+x7ofMPtP+UOtckSzev7sg5pj
	EzSgbkwiyQVnVFhbhlm6ePSBBxTvb0QieywxPK+CGL26yt4ZGY2jqocQYs+E0Sjqy8xYfuhPPK7DB
	Um8p6xuna3E6CP1lekxn/g6uy5TN4XoLaO4Q==;
Received: from [2001:470:28:704::1] (port=47914 helo=tnonline.net)
	by mx.tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <forza@tnonline.net>)
	id 1tP4HU-000000001MZ-00sH;
	Sat, 21 Dec 2024 18:32:52 +0000
Received: from [192.168.0.114] (port=33836)
	by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <forza@tnonline.net>)
	id 1tP4HS-00000000HjR-34L0;
	Sat, 21 Dec 2024 19:32:50 +0100
Date: Sat, 21 Dec 2024 19:32:50 +0100 (GMT+01:00)
From: Forza <forza@tnonline.net>
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
	Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
Message-ID: <8d4d83e.80527959.193ea7e5d3e@tnonline.net>
In-Reply-To: <Z1eonzLzseG2_vny@hungrycats.org>
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email> <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com> <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com> <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com> <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com> <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com> <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com> <b5f70481-34a1-4d65-a607-a3151009964d@suse.com> <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com> <cfa74363-b310-49f0-b4bf-07a98c1be972@gmx.com> <Z1eonzLzseG2_vny@hungrycats.org>
Subject: Re:  Proposal for RAID-PN (was Re: Using btrfs raid5/6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
X-Spam-Score: -4.1 (----)



---- From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org> -- Sent: 2024-12-1=
0 - 03:34 ----

> On Sun, Dec 08, 2024 at 06:56:00AM +1030, Qu Wenruo wrote:
>> =E5=9C=A8 2024/12/7 18:07, Andrei Borzenkov =E5=86=99=E9=81=93:
>> > 06.12.2024 07:16, Qu Wenruo wrote:
>> > > =E5=9C=A8 2024/12/6 14:29, Andrei Borzenkov =E5=86=99=E9=81=93:
>> > > > 05.12.2024 23:27, Qu Wenruo wrote:
>> > > > > =E5=9C=A8 2024/12/6 03:23, Andrei Borzenkov =E5=86=99=E9=81=93:
>> > > > > > 05.12.2024 01:34, Qu Wenruo wrote:
>> > > > > > > =E5=9C=A8 2024/12/5 05:47, Andrei Borzenkov =E5=86=99=E9=81=
=93:
>> > > > > > > > 04.12.2024 07:40, Qu Wenruo wrote:
>> > > > > > > > >=20
>> > > > > > > > > =E5=9C=A8 2024/12/4 14:04, Scoopta =E5=86=99=E9=81=93:
>> > > > > > > > > > I'm looking to deploy btfs raid5/6 and have read some =
of the
>> > > > > > > > > > previous
>> > > > > > > > > > posts here about doing so "successfully." I want to ma=
ke sure I
>> > > > > > > > > > understand the limitations correctly. I'm looking to r=
eplace an
>> > > > > > > > > > md+ext4
>> > > > > > > > > > setup. The data on these drives is replaceable but obv=
iously
>> > > > > > > > > > ideally I
>> > > > > > > > > > don't want to have to replace it.
>> > > > > > > > >=20
>> > > > > > > > > 0) Use kernel newer than 6.5 at least.
>> > > > > > > > >=20
>> > > > > > > > > That version introduced a more comprehensive check for a=
ny RAID56
>> > > > > > > > > RMW,
>> > > > > > > > > so that it will always verify the checksum and rebuild w=
hen
>> > > > > > > > > necessary.
>> > > > > > > > >=20
>> > > > > > > > > This should mostly solve the write hole problem, and we =
even have
>> > > > > > > > > some
>> > > > > > > > > test cases in the fstests already verifying the behavior=
.
>> > > > > > > >=20
>> > > > > > > > Write hole happens when data can *NOT* be rebuilt because =
data is
>> > > > > > > > inconsistent between different strips of the same stripe. =
How btrfs
>> > > > > > > > solves this problem?
>> > > > > > >=20
>> > > > > > > An example please.
>> > > > > >=20
>> > > > > > You start with stripe
>> > > > > >=20
>> > > > > > A1,B1,C1,D1,P1
>> > > > > >=20
>> > > > > > You overwrite A1 with A2
>> > > > >=20
>> > > > > This already falls into NOCOW case.
>> > > > >=20
>> > > > > No guarantee for data consistency.
>> > > > >=20
>> > > > > For COW cases, the new data are always written into unused slot,=
 and
>> > > > > after crash we will only see the old data.
>> > > >=20
>> > > > Do you mean that btrfs only does full stripe write now? As I recal=
l from
>> > > > the previous discussions, btrfs is using fixed size stripes and it=
 can
>> > > > fill unused strips. Like
>> > > >=20
>> > > > First write
>> > > >=20
>> > > > A1,B1,...,...,P1
>> > > >=20
>> > > > Second write
>> > > >=20
>> > > > A1,B1,C2,D2,P2
>> > > >=20
>> > > > I.e. A1 and B1 do not change, but C2 and D2 are added.
>> > > >=20
>> > > > Now, if parity is not updated before crash and D gets lost we have
>> > >=20
>> > > After crash, C2/D2 is not referenced by anyone.
>> > > So we won't need to read C2/D2/P2 because it's just unallocated spac=
e.
>> >=20
>> > You do need to read C2/D2 to build parity and to reconstruct any missi=
ng
>> > block. Parity no more matches C2/D2. Whether C2/D2 are actually
>> > referenced by upper layers is irrelevant for RAID5/6.
>>=20
>> Nope, in that case whatever garbage is in C2/D2, btrfs just do not care.
>>=20
>> Just try it yourself.
>>=20
>> You can even mkfs without discarding the device, then btrfs has garbage
>> for unwritten ranges.
>>=20
>> Then do btrfs care those unallocated space nor their parity?
>> No.
>>=20
>> Btrfs only cares full stripe that has at least one block being referred.
>>=20
>> For vertical stripe that has no sector involved, btrfs treats it as
>> nocsum, aka, as long as it can read it's fine. If it can not be read
>> from the disk (missing dev etc), just use the rebuild data.
>>=20
>> Either way for unused sector it makes no difference.
>=20
> The assumption Qu made here is that btrfs never writes data blocks to the
> same stripe from two or more different transactions, without freeing and
> allocating the entire stripe in between.  If that assumption were true,
> there would be no write hole in the current implementation.
>=20
> The reality is that btrfs does exactly the opposite, as in Andrei's secon=
d
> example.  This causes potential data loss of the first transaction's
> data if the second transaction's write is aborted by a crash.  After the
> first transaction, the parity and uninitialized data blocks can be used
> to recover any data block in the first transaction.  When the second
> transaction is aborted with some but not all of the blocks updated, the
> parity will no longer be usable to reconstruct the data blocks from _any_
> part of the stripe, including the first transaction's committed data.
>=20
> Technically, in this event, the second transaction's data is _also_
> lost, but as Qu mentioned above, that data isn't part of a committed
> transaction, so the damaged data won't appear in the filesystem after a
> crash, corrupted or otherwise.
>=20
> The potential data loss does not become actual data loss until the stripe
> goes into degraded mode, where the out-of-sync parity block is needed to
> recover a missing or corrupt data block.  If the stripe was already in
> degraded mode during the crash, data loss is immediate.
>=20
> If the drives are all healthy, the parity block can be recomputed
> by a scrub, as long as the scrub is completed between a crash and a
> drive failure.
>=20
> If drives are missing or corrupt and parity hasn't been properly updated,
> then data block reconstruction cannot occur.  btrfs will reject the
> reconstructed block when its csum doesn't match, resulting in an
> uncorrectable error.
>=20
> There's several options to fix the write hole:
>=20
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
>=20
> 2.  Add a stripe journal.  Requires on-disk format change to add the
> journal, and recovery code at startup to replay it.  It's the industry
> standard way to fix the write hole in a traditional raid5 implementation,
> so it's the first idea everyone proposes.  It's also quite slow if you
> don't have dedicated purpose-built hardware for the journal.  It's the
> only option for closing the write hole on nodatacow files.
>=20
> 3.  Add a generic remapping layer for all IO blocks to avoid requiring
> RMW cycles.  This is the raid-stripe-tree feature, a brute-force approach
> that makes RAID profiles possible on ZNS drives.  ZNS drives have similar
> but much more strict write-ordering constraints than traditional raid56,
> so if the raid stripe tree can do raid5 on ZNS, it should be able to
> handle CMR easily ("efficiently" is a separate question).
>=20
> 4.  Replace the btrfs raid5 profile with something else, and deprecate
> the raid5 profile.  I'd recommend not considering that option until
> after someone delivers a complete, write-hole-free replacement profile,
> ready for merging.  The existing raid5 is not _that_ hard to fix, we
> already have 3 well-understood options, and one of them doesn't require
> an on-disk format change.
>=20
>=20
> Option 1 is probably the best one:  it doesn't require on-disk format
> changes, only changes to the way kernels manage future writes.  Ideally,
> the implementation includes an optimization to collect small extent write=
s
> and merge them into full-stripe writes, which will make those _much_
> faster on raid56.  The current implementation does multiple unnecessary
> RMW cycles when writing multiple separate data extents to the same
> stripe, even when the extents are allocated within a single transaction
> and collectively the extents fill the entire stripe.
>=20
> Option 1 won't fix nodatacow files, but that's only a problem if you
> use nodatacow files.
>=20
> I suspect options 2 and 3 have so much overhead that they are far
> slower than option 1, even counting the extra balances option 1 requires.
> With option 1, the extra overhead is in a big batch you can run overnight=
,
> while options 2 and 3 impose continuous overhead on writes, and for
> option 3, on reads as well.
>=20
>> > > So still wrong example.
>> > >=20
>> >=20
>> > It is the right example, you just prefer to ignore this problem.
>>=20
>> Sure sure, whatever you believe.
>>=20
>> Or why not just read the code on how the current RAID56 works?
>=20
> The above is a summary of the state of raid56 when I last read the code
> in depth (from circa v6.6), combined with direct experience from running
> a small fleet of btrfs raid5 arrays and observing how they behave since
> 2016, and review of the raid-stripe-tree design docs.
>=20
>> > > Remember we should discuss on the RMW case, meanwhile your case does=
n't
>> > > even involve RMW, just a full stripe write.
>> > >=20
>> > > >=20
>> > > > A1,B1,C2,miss,P1
>> > > >=20
>> > > > with exactly the same problem.
>> > > >=20
>> > > > It has been discussed multiple times, that to fix it either btrfs =
has to
>> > > > use variable stripe size (basically, always do full stripe write) =
or
>> > > > some form of journal for pending updates.
>> > >=20
>> > > If taking a correct example, it would be some like this:
>> > >=20
>> > > Existing D1 data, unused D2 , P(D1+D2).
>> > > Write D2 and update P(D1+D2), then power loss.
>> > >=20
>> > > Case 0): Power loss after all data and metadata reached disk
>> > > Nothing to bother, metadata already updated to see both D1 and D2,
>> > > everything is fine.
>> > >=20
>> > > Case 1): Power loss before metadata reached disk
>> > >=20
>> > > This means we will only see D1 as the old data, have no idea there i=
s
>> > > any D2.
>> > >=20
>> > > Case 1.0): both D2 and P(D1+D2) reached disk
>> > > Nothing to bother, again.
>> > >=20
>> > > Case 1.1): D2 reached disk, P(D1+D2) doesn't
>> > > We still do not need to bother anything (if all devices are still
>> > > there), because D1 is still correct.
>> > >=20
>> > > But if the device of D1 is missing, we can not recover D1, because D=
2
>> > > and P(D1+D2) is out of sync.
>> > >=20
>> > > However I can argue this is not a simple corruption/power loss, it's=
 two
>> > > problems (power loss + missing device), this should count as 2
>> > > missing/corrupted sectors in the same vertical stripe.
>=20
> A raid56 array must still tolerate power failures while it is degraded.
> This is table stakes for a modern parity raid implementation.
>=20
> The raid56 write hole occurs when it is possible for an active stripe
> to enter an unrecoverable state.  This is an implementation bug, not a
> device failure.
>=20
> Leaving an inactive stripe in a corrupted state after a crash is OK.
> Never modifying any active stripe, so they are never corrupted, is OK.
> btrfs corrupts active stripes, which is not OK.
>=20
> Hopefully this is clear.
>=20
>> > This is the very definition of the write hole. You are entitled to hav=
e
>> > your opinion, but at least do not confuse others by claiming that btrf=
s
>> > protects against write hole.
>> >=20
>> > It need not be the whole device - it is enough to have a single
>> > unreadable sector which happens more often (at least, with HDD).
>> >=20
>> > And as already mentioned it need not happen at the same (or close) tim=
e.
>> > The data corruption may happen days and months after lost write. Sure,
>> > you can still wave it off as a double fault - but if in case of failed
>> > disk (or even unreadable sector) administrator at least gets notified =
in
>> > logs, here it is absolutely silent without administrator even being
>> > aware that this stripe is no more redundant and so administrator canno=
t
>> > do anything to fix it.
>> >=20
>> > > As least btrfs won't do any writeback to the same vertical stripe at=
 all.
>> > >=20
>> > > Case 1.2): P(D1+D2) reached disk, D2 doesn't
>> > > The same as case 1.1).
>> > >=20
>> > > Case 1.3): Neither D2 nor P(D1+D2) reached disk
>> > >=20
>> > > It's the same as case 1.0, even missing D1 is fine to recover.
>> > >=20
>> > >=20
>> > > So if you believe powerloss + missing device counts as a single devi=
ce
>> > > missing, and it doesn't break the tolerance of RAID5, then you can c=
ount
>> > > this as a "write-hole".
>> > >=20
>> > > But to me, this is not a single error, but two error (write failure =
+
>> > > missing device), beyond the tolerance of RAID5.
>> > >=20
>> > > Thanks,
>> > > Qu
>> >=20
>>=20
>>=20
>=20




Hi,

Thank you for the detailed explanations and suggestions regarding the write=
 hole issues in Btrfs RAID5/6. I would like to contribute to this discussio=
n by proposing an alternative implementation, which I call RAID-PN, an exte=
nt-based parity scheme that avoids the write hole while addressing the shor=
tcomings of the current RAID5/6 implementation.


I hope this proposal provides a useful perspective on addressing the write =
hole and improving RAID performance in Btrfs. I welcome feedback on its fea=
sibility and implementation details.


---

Proposal: RAID-PN

RAID-PN introduces a dynamic parity scheme that uses data sub-extents and p=
arity extents rather than fixed-width stripes. It eliminates RMW cycles, en=
sures atomic writes, and provides flexible redundancy levels comparable to =
or exceeding RAID6 and RAID1c4.

Design Overview

1. Non-Striped Data and Parity:

Data extents are divided into sub-extents based on the pool size. Parity ex=
tents are calculated for the current data sub-extents and written atomicall=
y in the same transaction.

Each parity extent is independent and immutable, ensuring consistency.

Example: A 6-device RAID-P3 setup allocates 3 data sub-extents and 3 parity=
 extents. This configuration achieves 50% space efficiency while tolerating=
 the same number of device failures as RAID1c4, which only achieves 25% eff=
iciency on 6 devices.


2. Avoidance of RMW:

Parity is calculated only for the data sub-extents being written. No previo=
usly written data extents or parity extents are read or modified, completel=
y avoiding RMW cycles.


3. Atomicity of Writes:

Both data and parity extents are part of the same transaction. If a crash o=
ccurs, uncommitted writes are rolled back, leaving only valid, consistent e=
xtents on disk.


4. Dynamic Allocation:

RAID-PN eliminates partially filled stripes by dynamically allocating data =
sub-extents. Parity extents are calculated only for the allocated sub-exten=
ts. This avoids garbage collection and balancing operations required by fix=
ed-stripe designs.


5. Checksummed Parity:

Parity extents are checksummed, allowing verification during scrubbing and =
recovery.



Addressing Btrfs RAID5/6 Issues

1. Write Hole:

RAID-PN ensures parity and data extents are written atomically and never up=
dated across transactions, inherently avoiding the write hole issue.


2. Degraded Mode Recovery:

Checksummed parity extents ensure reliable recovery from missing or corrupt=
 data, even in degraded mode.


3. Scrubbing and Updates:

Scrubbing validates parity extents against checksums. Inconsistent parity c=
an be recomputed using data sub-extents without relying on crash-free state=
s.


4. Small Writes and Performance:

For writes smaller than the pool size, RAID-PN is less space efficient due =
to parity overhead (e.g., a 4 KiB write in RAID-P2 requires 1 data sub-exte=
nt and 2 parity extents, totaling 12 KiB). However, random small I/O perfor=
mance is likely better than RAID56 due to the absence of RMW cycles.



Comparison to Proposed Fixes

1. Allocator Changes (Option 1):

RAID-PN achieves similar outcomes without requiring garbage collection or b=
alancing operations to reclaim partially filled stripes.


2. Stripe Journal (Option 2):

RAID-PN avoids the need for a stripe journal by writing parity atomically a=
longside data in a single transaction.


3. RAID-Stripe-Tree (Option 3):

RAID-PN avoids the complexity of a remapping layer, though extent allocator=
 changes are required to handle sub-extents.


4. Replacement Profile (Option 4):

RAID-PN offers a new profile that supports multiple-device redundancy, avoi=
ds RMW and journaling, and remains write-hole-free while adhering to Btrfs'=
s CoW principles. I think it provides an interesting alternative, or comple=
ment, to RAID56.



Implementation Considerations

RAID-PN requires changes to support sub-extents for data. Parity extents mu=
st be tracked and linked to the corresponding data extents/sub-extents..


NoCOW files remain problematic. We need to be able to generate parity data,=
 which is similarly difficult to generating csum, making NoCOW files unprot=
ected under RAID-PN.


Random small I/O is likely to outperform RAID56 due to the lack of RMW cycl=
es. Large sequential I/O should perform similarly to RAID56.

---



