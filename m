Return-Path: <linux-btrfs+bounces-18467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11349C25518
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 14:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34490188D284
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81C23BCED;
	Fri, 31 Oct 2025 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="lxhBoj+n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D81DFE22;
	Fri, 31 Oct 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918314; cv=none; b=McSTGL5azuJv9WNhvKrciSt8qTBd/+5qSNe3pheRujkDBv5+Ml48Q3kkBlsaLTTyV3rZ0KPPXaVYH5ZIfQzWj6LBN8Kvw3lKyE5Pt6Qfyn+KlHEgu6MVhSgkv85Jp80RSCFq638f4q/CpDrSkMO3fXBrLP9I2xiGxpFs7WN1Bys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918314; c=relaxed/simple;
	bh=O45XE8Vu9DTRBTlT3E54Vbg2Iy5Ih0eKSesjW5/ErXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hj/lGBrWUFN+WDHTlSnH3onX/SJDtFIkU5+RmpqhCCWG5Zknki5F4C4ujO6DA+XmjX/9NDKwB8F/MmqTd2BVgPPFl0ISSIN8d9JOUeLIy6vcE9ygPRygvBC0F8L5E2Qd9EJe/9N2VCzsaR24dAw7AINAEmse4yLkr6oNNbJaMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=lxhBoj+n; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cyj0D3R39z9t4k;
	Fri, 31 Oct 2025 14:45:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761918300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0O5a8R1BPxwQ8QmbLrr2Wpw5/Ede2Ocx8fNc84mnug=;
	b=lxhBoj+nFifMqHZUHZELdPLthribMfxIBRsBMTlBfvwz5xz4/7t+MNuSL0r/tcY4TfU7E/
	wXfVoCkZonsSLKVYm6gQN27Z4vJoIZbBvX8naz5PSpBBHY+dSaw8229s6l+BmBpO8vtOUN
	z5vxQPH9XH1aIwislHMRClGbPNCAIdC7Ls7QMMEbqVwDe6IZ9MEfwcNurM5Gc5g6wEY6s0
	hvZiCew18WkHvtblFouRihf+lZdmMc5sMI1ffH1N79bF/4KWtH49tworqBnHhJTF/nbRCi
	ThgmoDtkVwPD3N//0WzuZlLVmI/K1XxUDLD5guNCGcTdDkT5zOKuYTQz0W+VRQ==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,  clm@fb.com,  dsterba@suse.com,
  johannes.thumshirn@wdc.com,  fdmanana@suse.com,  boris@bur.io,
  wqu@suse.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: define and apply the AUTO_K(V)FREE_PTR
 macros
In-Reply-To: <20251031022241.GE13846@twin.jikos.cz> (David Sterba's message of
	"Fri, 31 Oct 2025 03:22:41 +0100")
References: <20251024102143.236665-1-mssola@mssola.com>
	<20251031022241.GE13846@twin.jikos.cz>
Date: Fri, 31 Oct 2025 14:44:53 +0100
Message-ID: <87v7jv89t6.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Sterba @ 2025-10-31 03:22 +01:

> On Fri, Oct 24, 2025 at 12:21:39PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> Changes since v1:
>>   - Remove the _PTR suffix
>>   - Rename the ipath cleanup function to inode_fs_paths, so it's more
>>     explicit on the type.
>>   - Improve git message in patch 1.
>>
>> This patchset introduces and applies throughout the btrfs tree two new
>> macros: AUTO_KFREE and AUTO_KVFREE. Each macro defines a pointer,
>> initializes it to NULL, and sets the kfree/kvfree cleanup attribute. It =
was
>> suggested by David Sterba in the review of a patch that I submitted here
>> [1].
>>
>> I have not applied these macros blindly through the tree, but only when
>> using a cleanup attribute actually made things easier for
>> maintainers/developers, and didn't obfuscate things like lifetimes of
>> objects on a given function. So, I've mostly avoided applying this when:
>>
>> - The object was being re-allocated in the middle of the function
>>   (e.g. object re-allocation in a loop).
>> - The ownership of the object was transferred between functions.
>> - The value of a given object might depend on functions returning ERR_PT=
R()
>>   et al.
>> - The cleanup section of a function was a bunch of labels with different
>>   exit paths with non-trivial cleanup code (or code that depended on thi=
ngs
>>   to go on a specific order).
>>
>> To come up with this patchset I have glanced through the tree in order to
>> find where and how kfree()/kvfree() were being used, and while doing so I
>> have submitted [2], [3] and [4] separately as they were fixing memory
>> related issues. All in all, this patchset can be divided in three parts:
>>
>> 1. Patch 1: transforms free_ipath() to be defined via DEFINE_FREE(), whi=
ch
>>    will be useful in order to further simplify some code in patch 3.
>> 2. Patch 2 and 3: define and use the two macros.
>> 3. Patch 4: removing some unneeded kfree() calls from qgroup.c as they w=
ere
>>    not needed. Since these occurrences weren't memory bugs, and it was a
>>    somewhat simple patch, I've refrained from sending this separately as=
 I
>>    did in [2], [3] and [4]; but I'll gladly do it if you think it's bett=
er
>>    for the review.
>>
>> Note that after these changes some 'return' statements could be made more
>> explicit, and I've also written an explicit 'return 0' whenever it would
>> make more explicit the "happy" path for a given branch, or whenever a 'r=
et'
>> variable could be avoided that way.
>>
>> Last, checkpatch.pl script doesn't seem to like patches 2 and 3; but so =
far
>> it looks like false positives to me. But of course I might just be wrong=
 :)
>>
>> [1] https://lore.kernel.org/all/20250922103442.GM5333@twin.jikos.cz/
>> [2] https://lore.kernel.org/all/20250925184139.403156-1-mssola@mssola.co=
m/
>> [3] https://lore.kernel.org/all/20250930130452.297576-1-mssola@mssola.co=
m/
>> [4] https://lore.kernel.org/all/20251008121859.440161-1-mssola@mssola.co=
m/
>>
>> Miquel Sabat=C3=A9 Sol=C3=A0 (4):
>>   btrfs: declare free_ipath() via DEFINE_FREE()
>>   btrfs: define the AUTO_K(V)FREE helper macros
>>   btrfs: apply the AUTO_K(V)FREE macros throughout the tree
>>   btrfs: add ASSERTs on prealloc in qgroup functions
>
> Thanks, patches now added to for-next with some minor adjustments. Feel
> free to send more conversions, there are still some kvfree candidate
> calls. I think we would not mind using it even for the short functions
> (re what's mentioned in the 3rd patch), so it's established as a common
> coding pattern. This change has net negative effect on lines and also
> simplifies the control flow.

Thanks for adding them!

Will keep an eye then if there are places where it's safe to use them.

Greetings,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmkEvVUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZaSwD/0bftnJ/zbP87OB9IgTaDW+7z5sqlQ4cATReNX2FyRMTYy3FGBaBG6AUNPn
DiD5Y5OC+n3vas7tQgfIYoI+z7gcmIwaTLDOMPQtMuRq6e5BFhcsAlsXfbJjkKdp
b046c0iWe9Xwb0aURP6wNN1pm88OR4yAe4cx8FaDevH9ZIn+wjpqUaaT3pNZBgZ6
15iFI68f5VyjChxLHIDoYMDIrLccYNxVPqc88sC170F2a7A2V4nl4hIBy8wMDgYn
98XHcmznW3HRvXj8ZG4f5XzKrMCWDpoAdg2ijB/ucC/zwffclVUg1OG7B7xPEjpV
GCK6CQS3HJz1BF0GbMOdxtKKS7hxLwQ7maqyjqYDVVyV2kYgqcttrrIS0q3lVlFi
5V92Q0A9yWca8TNjSJ+FSLkTpkXtHrfmztygLpt2+A052uDpA9zSvA1xPrvTpQe8
h3AXjgYmFeOa9v8AqOHnVXRqvyXuzK9nd97ZyzPJ1j1NHnXA+bs55QJyLxxQZmHF
iycUu6XenZtrRjiJQZlvtntpY/dgsHieEAH2zWsjss10aeH3qUQO/dRJDJ4Nv86R
CLDlWxndlOAGpWP1actZtv4mqjz1DqvCdat6eBoRy85iISK5L7t4vlqv42PiKC/Q
Rfn+M4LU79SVgRwwmNhSsi1ZICwbmp5BXjZYjceJBTVK5y8Jmw==
=zMc4
-----END PGP SIGNATURE-----
--=-=-=--

