Return-Path: <linux-btrfs+bounces-7711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D189675CA
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 11:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A207C1F21970
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36D14D280;
	Sun,  1 Sep 2024 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ggk6DLn9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A951F951
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Sep 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725183310; cv=none; b=YYN8JKOAWfyoATGtmBc72E1wN9sxAKnVbkAwv5fhwKNB3ponMV2iPIq0E1SgLKFByhPh9lONxN136iqOWtr9wkDuCgbuAAnrv8If+YSfpWP4imVS2Vm6FyKw3IVmxdMDWSbU+JseIpvOjSZLp7Cvfgq/bBpKFXQp3uxAAIc6l9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725183310; c=relaxed/simple;
	bh=zQNWwNXrEC3RMuBgbb+9fMrZqORJV07Q8W1gL5o/eUQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EV+Lfex+WbowvlExyIgL5enhHPOFxbFVXM4yrsicigxyQ7Pr+LUFIcNYBBrZrRUfRYSeEGf3peaCzodOnpdli88bIyJJKUj9JgWAA6ud7nvcyVqVHL7O+KOF+Zucz4I+XB675H0Rk6sTMnu0JH+QaCbEWQYJs99QktCRUo00ByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ggk6DLn9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725183305; x=1725788105; i=quwenruo.btrfs@gmx.com;
	bh=3DVHIOQagjzGfZXx6pe8kbDC21dnRTTLkDKhRfd0D0w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ggk6DLn9H+zaYBfbxJmg1yJ9kiqCrmqKfVyoYWyQDvyqFq1dKkKUNJQi6Y4w4rev
	 GyaohatJeJqiw2Lrm4ozGk7Zwitwxj2DMdinGXmvjGTKtVRmYPoJ/PpV89tm0zwCE
	 UpYptnofBy3OVXTufdFkdoo1WBCpODFxL5a5wt6yEI3yatiCC6gulaqgfMJBxfdKe
	 7Q+ACpknw3EDa6rA0Owx9RiyQUfmPTvbG6TbFzeniQFFuZh82d3Tbr7gRYZDJHVoy
	 QZSxBeOF+DZeDsuSOTumhuGYkAWZ6aacweyMmgRUZPUtF08gAxtsgPTBw2J3QANy7
	 2GeZU1NanPOV2dKf9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1rtp9T423b-00udYS for
 <linux-btrfs@vger.kernel.org>; Sun, 01 Sep 2024 11:35:05 +0200
Message-ID: <0d4c34a2-dc58-440f-94e0-2d2524cb091f@gmx.com>
Date: Sun, 1 Sep 2024 19:05:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: About the roadmap for the future of compressed writes
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
X-Provags-ID: V03:K1:+a2EoKWGuWJG/a2QDpg9trxz6ogQPr/CkDuf57KuSKbic0mJtc1
 UYI0tY8ph1plhhTSB6LcM9kOfSjC/PTgAoYActP/x9FC1y2M6lCt4IO687aoo9HHqFI0Cl9
 pZhnCHvnUphgtQip38I+lnPXvR6iyHfrhtOw5nwnlQYd3XAgaGGPvc3C0Sjk5oBm0oBDFoI
 P9XXR2dgSpzC6h8fLLw6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LMZUCBfXpeM=;iOB3PiNuppmhfJhBG2YJ6PLN1EU
 ZlAxHE1IAzmWfn9uqe7N6DCPAn9rr+67w3is0RWWx6PrE6ZIHJwKIgvLKETNyBRYL5rWMJWg5
 BQiUC+huTC7NLmGB/NmtQy5P6cUjNx39l5RiucSkzysj63+L1XOhyWR8FHs6lUku0wTfS3F/T
 MuEcmw0ns7mI7j/pU9MhWE2DtXE9I1QTjv/5a1adprXGAsQubEkCgcOObl2rv9kr2+srmGPOA
 uQ2wtdDLYfcQT14IheG4XMrVWdkN/Xw/LtsrYgOfMzvH10DS6kOhP2qcfscfmVxNHQr0h5FqO
 1c2yD7QmUg2TsDGnLhwQ6K8d0i2dNWUM4B1nO3cxbX7hojvHvcTLcpc4ayQkpSydXxy7+lriK
 LW4G/5jM3nyqwAhT3MUl3G8S/ege02JlVKirXkYKgCvCCak/y9LxJGMs+Y5kfKCJ30ECwLLt4
 2J9+s/biD6p9c7LIH1IAnT36B/v57Jumos5FDSnv9AHQvWKWHx3wssqGR4ak0UVQB+/BDv0At
 QMcQO6DUVNb1OY6EmEWYOEmoJUiZfLRZS1UuAj28Dl/aDImT5iwqFXEPJLnmKJrJ5ygYU+uIs
 jbiceCyJIU9PzyTUXtdENkhbkprMgp+fAs42/yusL08sXCArpxVs1E7fQPBVKcZbrg0wiKleA
 tquti7ClaBrF9mJ1M5fK9S/vQXReTlyDiyp5C28vC9r0NxSMa4hDqpwvOhZD1HPSBNjL+oJT9
 BANaqOB0QdAxmiCpNphXuA60KerQlZTt6DKMVbIWM5AwSCwucUIYiLYeNzJnHMJcowUKxRSp1
 LJPRVEcthnac0h1XBixpPmg4T+9Wrk5bHYeaen8LVamNE=

Hi,

[CHALLENGES]
Although compression is a pretty awesome feature, there are still some
work left for it:

- Sector perfect compressed write for sectorsize < PAGE_SIZE (subpage)
   For those already enjoying 4K sector sized btrfs on 16K/64K page sized
   systems, the compression is only done at page size.
   Thus a lot of small files can not be compressed on those system until
   page size is changed to 4K (iff that's possible).

- The hard (if not impossible) integration into iomap
   Iomap goes a map-then-submit method, but our compressed writes go
   asynchronous submission, making it way harder to align to iomap.

The root problem here is in how we handle compressed write (in the
buffered write path).

[REGULAR PATH]
For non-compressed write, we go a pretty straight forward way:

- Run delayed allocation for each dirty range inside a page
   This will create an ordered extent, which records all the needed info
   for a btrfs bio (the logical bytenr to be submitted to).

- Queue the dirty range(s) of the page into a btrfs bio and submit
   After queuing each sector, we set the writeback flag for the sector,
   and clear its dirty flag.

   And eventually unlock all the submitted sector(s).

- Once the btrfs bio finished
   Clear the writeback flag for each sector, and finish the ordered
   extent (normally insert a new file extent item for COW cases).

If there is an extent crossing multiple pages, we just iterate through
all involved dirty pages of it, with the above steps.

This is also what iomap and ext4 doing.

[COMPRESSED PATH]
But for compressed write, the timing happens very differently:

- Run delayed allocation for each dirty range
   If it's compressed write, we lock the whole range for the write.
   Then queue a delayed work to do the compression.

- Inside the delayed work
   We do the compression, only after the compression is done, we create
   an ordered extent for it.
   Then after compression is all done, and before submitting the
   compressed write bio, we unlock the pages, clear page dirty and set
   writeback flags.

- Once the compressed write bio finished
   We insert the file extent item for the compressed write, clear the
   writeback flag.

Furthermore, if we hit a range crossing multiple pages, on the second
page we won't do anything, but waiting for the page to be fully written.

This also means, if we hit a sector that's going to be compressed, we do
not do any regular bio submission.

This changed timing is not making it much harder to go iomap, but also
harder for subpage (we need avoid all the compressed write range carefully=
).

[ROADMAP]
For now I have several planned work for the situation, from the easiest
to the hardest:

1)Add sector perfect compression support for subpage case (sector size <
   PAGE_SIZE)
   The idea is not to modify the compression write path for now, but add
   the extra dancing to avoid touching anything for the compressed path,
   but still submit the writes for the regular path.

   This is mostly to add extra bitmaps for extent_writepages() to do the
   dancing.

   Then making the compression path to be subpage compatible (if there is
   any incompatible part left).

2)Change compressed write to do the regular submission
   This requires quite some changes:
   * A place holder ordered extent
     Without a proper logical bytenr to write, but only to keep the
     submission path to be happy

   * Submit compressed writes as regular writes
     Only the final btrfs bio submission needs different handling for
     compressed (queue for compression) and regular (direct submission)
     writes.

   * Make compression to only require page writeback set
     Not the page locked.
     For page with writeback flag, its content should not really change.
     (new write will wait for the writeback to finish).

3)Prepare for iomap integration
   This has extra work like cleaning up the subpage handling (reduce
   bitmaps, remove unnecessary tracing, the usual folio conversion,
   and eventually the mixed folio size support).

The objective 1) is slightly conflicting with 2), as if we finished 2)
first, there is no special handling needed at all.

But from my experience, a larger and more complex development target is
never a good way to resolve immediate problems.

Any feedback is appreciated, especially I'm not yet determined on the
details of objective 2).

Thanks,
Qu

