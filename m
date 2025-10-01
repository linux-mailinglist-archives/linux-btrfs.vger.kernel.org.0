Return-Path: <linux-btrfs+bounces-17320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C2BB1C9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 23:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583913A696B
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF68F30F54B;
	Wed,  1 Oct 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="QKYy8rW4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwo6Ihch"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E022EACF8
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353255; cv=none; b=SXupd0ow4GyTfolRX5gAvZCCEX2uOuNlC1MwCQMNbsr9vW6aWRobUDaB2kTG4Hy6ZvwNOc8QmgL4VjqmjY23V0quVOHzpNy6qp/3VGkGQw9400tL3XdNVFet4qu/rWIGxyG3d0mqCPq3dD9gJlmT/R67LXhUwVH/60/mM7oneF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353255; c=relaxed/simple;
	bh=+4lwneuqYSDqvYOLtBS96w4SsecjkIdtVt0LI1sVrYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEPdWdYe8q70ifQXsKlgcx5DauuL0uuIRE8WyCJw7n9XrrvNobtptpHZhhTCX0/lva9owV5VunNDOjXNxzVobvq0rAR/8hS2G0P762ElOZBlBqj8iWut9hZR7z4TP4cAdVq350SAvyN5Qg3W+2VinQqF6gEpJpEDpYP/Ou2Uxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=QKYy8rW4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwo6Ihch; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 48CBDEC01ED;
	Wed,  1 Oct 2025 17:14:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 01 Oct 2025 17:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1759353252;
	 x=1759439652; bh=E4kyG8dSubuE9gFsSpjcAKfkxohvqcLBuG/lIKCChOs=; b=
	QKYy8rW4iQiH6y9/T8Rzn+u3K1nf0vUTZTCLiE7AbvmLxAPBUex0/nRinVA1B80F
	jbFau5x5pWAyCt38NWzBmFVGDJrzQpL+zCAGzSLUvBdYrGAgJZOzrCjqgNiC60YP
	gXJ0Vo4SaY0QAEOxv5gY3rgSYo+BMyGFRNxNJDNzaMWCu2g3/zNdlHlrAkKo0fmU
	3YJRrh1SflnDtUplReVWL3SHqUCBJvYv1ZMoo3zjEtKt9Y6zJ3O+eZ/eSwn01ev/
	0VtA3eoMdGzhowTPcQ1JA4bCJdmvuJ4qgZdxtojUg7KuAgBWGU+6tfKaunLQmbko
	8tWzF0WFMvZC1DOjzXeqxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759353252; x=
	1759439652; bh=E4kyG8dSubuE9gFsSpjcAKfkxohvqcLBuG/lIKCChOs=; b=k
	wo6Ihch+G7uMLHFS2ux8v0TSltwtaP716wYD6ILwxl7ZiqDaQBMoThOnDM5bgatb
	B3a05c4cdFcd2KQZC3dW0lzzQHnc5/8rId8IZICTaWwh8GQHU57vUosXSCoXOzLG
	QLcyYEeO51mOZwCTsfmgQcWWD6SAmKfqlxobq7wkVPfZIHpxKRpe9S0QCxH4HGwa
	gdBm0ocLww6paCNM8/M9fQ6YnW4Ad/QG0Qd8ekeE1RnmVvDqWLuB0D4Iqvjk1Uh3
	sx3qEf5uEhuvAjOGrgRXWqU2YndCfw2suXcaCY1BFKQTc5nXXLUczY5xTEAt/Lxh
	el3h6qAfYIRaLF54xd9Nw==
X-ME-Sender: <xms:o5ndaJHm797UYvgGANkIi80R97nli012XKSq9k99s4MtAIsWN0V_bg>
    <xme:o5ndaFxpyXLCtDV_HzZIWZqna7tnqrRXGKatGhGzdxmnwNgO50EKRH6QFsifpcldC
    FtA8eyFpsv5AaHoA1bdKN4YTkl3pEI4lJ0g1RD6rmcnxLpp50qLew>
X-ME-Received: <xmr:o5ndaIiMuPFi6fsP9aW947te8yjJX8IBYvNwDQqJ11yUv31nNzD9ySW6weDpFoQAGN28iRnJPh4Hi4Z49OTil7sJcHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehue
    etffefleejheevvdejffduueffheevfedviedvhfffgfetgfefvdehvefgvdenucffohhm
    rghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:pJndaIyJACC_j_1DfTkyKZIXqpV0uxcnsPX0joTA1_QnNUVH8AH97g>
    <xmx:pJndaDLUP7s45Jqd1NYOCiDJT5nambVLJnRX0AfeDTL356U6wZlKeg>
    <xmx:pJndaHTGexeLJYaOvmAdTs5WJFbE7g7G2mBhDgCVluw753LbiGYWow>
    <xmx:pJndaDrBwiwVH2sH9PV3Ih3d_CQ8kDOgNc5i8Nbn1rVMYdbXEZRN0A>
    <xmx:pJndaJQLaO2L3t7b5EPuqHuZupWfiA6YC1VA31djCZgikqMAS7b89Y8M>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 17:14:11 -0400 (EDT)
Date: Wed, 1 Oct 2025 14:14:10 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix incorrect readahead expansion length
Message-ID: <20251001211410.GA2927167@zen.localdomain>
References: <763f1e5a6d9611638977e24aeead5c9a266da678.1759337413.git.boris@bur.io>
 <CAL3q7H4uPf0+dV=7-x4GyfqU2SxW1uzr5iT32aH10Pupa6r81g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4uPf0+dV=7-x4GyfqU2SxW1uzr5iT32aH10Pupa6r81g@mail.gmail.com>

On Wed, Oct 01, 2025 at 06:10:21PM +0100, Filipe Manana wrote:
> On Wed, Oct 1, 2025 at 5:51 PM Boris Burkov <boris@bur.io> wrote:
> >
> > The intent of btrfs_readahead_expand() was to expand to the length of
> > the current compressed extent being read. However, "ram_bytes" is *not*
> > that, in the case where a single physical compressed extent is used for
> > multiple file extents.
> >
> > Consider this case with a large compressed extent C and then later two
> > non-compressed extents N1 and N2 written over C, leaving C1 and C2
> > pointing to offset/len pairs of C:
> > [               C                 ]
> > [ N1 ][     C1     ][ N2 ][   C2  ]
> >
> > In such a case, ram_bytes for both C1 and C2 is the full uncompressed
> > length of C. So starting readahead in C1 will expand the readahead past
> > the end of C1, past N2, and into C2. This will then expand readahead
> > again, to C2_start + ram_bytes, way past EOF. First of all, this is
> > totally undesirable, we don't want to read the whole file in arbitrary
> > chunks of the large underlying extent if it happens to exist. Secondly,
> > it results in zeroing the range past the end of C2 up to ram_bytes. This
> > is particularly unpleasant with fs-verity as it can zero and set
> > uptodate pages in the verity virtual space past EOF. This incorrect
> > readahead behavior can lead to verity verification errors, if we iterate
> > in a way that happens to do the wrong readahead.
> 
> So this misses being clear, explicit, about the worst problem:
> buffered read corruption (even when not using verity).
> In that case the readahead loaded data from C into the page cache
> range for N2, so then later anyone doing a buffered read for N2's
> range, will get data from C.

I believe you, but I actually don't see it myself yet. Can you help me
understand?

As I currently see it:

Changing the readahead window will change which folios we call
btrfs_do_readpage() on, but inside btrfs_do_readpage(), we still have
the same logic to force submissions on extent boundaries. Whether due to
holes/inline extents, changing compression types or mismatched em->start
and bio_ctrl->last_em_start for compressed extents.

I have prepared an fstest that is roughly:

        # write a big-ish compressed extent
        _scratch_mount "-o compress-force=zstd:3" >/dev/null 2>&1
        $XFS_IO_PROG -f -c "pwrite -S 0xab 0 65536" $SCRATCH_MNT/foo &>/dev/null

        # put a couple smaller normal extents in over it
        _scratch_unmount
        _scratch_mount "-o compress=none" >/dev/null 2>&1
        $XFS_IO_PROG -f -c "pwrite -S 0xcd 4096 4096" $SCRATCH_MNT/foo &>/dev/null
        $XFS_IO_PROG -f -c "pwrite -S 0xcd 32768 16384" $SCRATCH_MNT/foo &>/dev/null

        # do some verification
        fsverity enable $SCRATCH_MNT/foo
        _scratch_unmount
        _scratch_mount "-o compress=none" >/dev/null 2>&1
        # clean cache read of 1 byte from the compressed extent. File
        # extent size 4096, ram bytes size 64k
        dd if=$SCRATCH_MNT/foo bs=1 count=1 2>/dev/null | _hexdump
        # if the read of "C1" wrote into "N", then we should see it on
        # this read, right?
        dd if=$SCRATCH_MNT/foo bs=1 count=1 skip=4096 2>/dev/null | _hexdump

And it triggers the fsverity errors, but I am not able to make the read
into the uncompressed range see the compressed bytes, yet.

Maybe that will be a clue towards my misunderstanding...

Thanks for the review and help,
Boris

> 
> This should be easy to turn into a test case for fstests too.
> 
> With that changelog update:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> >
> > Fix this by using em->len for readahead expansion, not em->ram_bytes,
> > resulting in the expected behavior of stopping readahead at the extent
> > boundary.
> >
> > Reported-by: Max Chernoff <git@maxchernoff.ca>
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2399898
> > Fixes: 9e9ff875e417 ("btrfs: use readahead_expand() on compressed extents")
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/extent_io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index dfda8f6da194..3a8681566fc5 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -972,7 +972,7 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
> >  {
> >         const u64 ra_pos = readahead_pos(ractl);
> >         const u64 ra_end = ra_pos + readahead_length(ractl);
> > -       const u64 em_end = em->start + em->ram_bytes;
> > +       const u64 em_end = em->start + em->len;
> >
> >         /* No expansion for holes and inline extents. */
> >         if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
> > --
> > 2.50.1
> >
> >

