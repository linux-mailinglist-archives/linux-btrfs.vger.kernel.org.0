Return-Path: <linux-btrfs+bounces-5351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C28D35CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 13:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3241F23C15
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 11:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BEF1802D7;
	Wed, 29 May 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAzU8u2P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930E1BC57
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716983512; cv=none; b=bIG7ScprfK2ik31jy05ykYnP5FU1UHPYo0Wx77QMjWYNoQf6aE4xE3c/a1am5jz4xlPjno2QXq/0kzbftfkLbpoMdnIG4zNDr/I3sIdfp3eknI6C9//+NwzLBnXSixPLTFEXrIuWx9cXMioZviwKmXDIl4iiVtDlevkHQaNREdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716983512; c=relaxed/simple;
	bh=TTlA84GPuDMgWa1oe8laEZM4p2X89s0/Mdv6b/DOoZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOU74nzrPe0q0PqcgrUpi8X+4Rppzr/cWkvum868VySZOkuII7k5Mherx7AUctZXS8ROf7wDdHaHy4Q1LHwkNz2slLCSpxrsdC3Fg/geDqDKWHGORvQwD0cYc+8URgyziCPeYetOVruSjyEJs+wKg36iIncWGmMwTMMqbsRXYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAzU8u2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99060C2BD10
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716983511;
	bh=TTlA84GPuDMgWa1oe8laEZM4p2X89s0/Mdv6b/DOoZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qAzU8u2Pj+r3qKOwlLeaIccQ1fVk0Xu/f7yVb0CE6Hzq3B7c5tagWgB5Xpl/S1eBP
	 1RagpUCo3eURPQYaR5RFBOyev1f/pnQuLpW0OuScZ+tBa4N3TWtgqiLjHFCGapG7b4
	 WV0iqaDHan+0Vg9ukXCXcO8nopU/DQsNZdm3dRTMNF8+du7qZoHpTtPQ2GPbfGDqQl
	 lmwx7w0Fm+fNL76mmvX5GN6NB8GKqVidIWLS5ZF0nRZA0fKJXjepM52FKL6AFbn1Bl
	 OXejozly5ErhWJ0uqk1EpCwLjwVkl0FOyTnSJTk6ouIvxg+stn0kFVEOehs5TpGlyQ
	 k1x1qrLBRRMow==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a626776cc50so214021566b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 04:51:51 -0700 (PDT)
X-Gm-Message-State: AOJu0Yygcf4DfbbKXQGZ+6ZmvsJteUqrzYVIEEanVWnSuUASJJU2YZUR
	+MkyS07UWfaA4UexRmyuEvRnkS+6zRnW82jZADhXfIM/OXfGRG62Bm5Bk5vkUUJ4xDeCY31wrEq
	ndO6huFLl52JzTLMCOG4KmBUPmpc=
X-Google-Smtp-Source: AGHT+IGsaYVH40tt3u9XI6s0jlqP/a+KIyVsET4I9zDmmhcRmD1DV/3TLri/4nTNmAa0RqlgTRNrnJWtco9pzca6zU4=
X-Received: by 2002:a17:906:f353:b0:a55:9dec:355f with SMTP id
 a640c23a62f3a-a626511604fmr844488966b.70.1716983510221; Wed, 29 May 2024
 04:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <719ec85c5bda1d711067e5b1c20a2de336240140.1715688262.git.fdmanana@suse.com>
 <6bd1663678f119791c1e2b6071f4973f35dcf049.1715708811.git.fdmanana@suse.com> <20240528222252.GJ8631@twin.jikos.cz>
In-Reply-To: <20240528222252.GJ8631@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 29 May 2024 12:51:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7BeHGskUeNf+mAbGXPqBMWzf-34xftiEuwdQz8GoCyXQ@mail.gmail.com>
Message-ID: <CAL3q7H7BeHGskUeNf+mAbGXPqBMWzf-34xftiEuwdQz8GoCyXQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: reduce ordered_extent_lock section at btrfs_split_ordered_extent()
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:22=E2=80=AFPM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Tue, May 14, 2024 at 06:54:18PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There's no need to hold the root's ordered_extent_lock for so long at
> > btrfs_split_ordered_extent(). We don't need to hold it in order to modi=
fy
> > the inode's rb tree of ordered extents, to modify the trimmed ordered
> > extent and move checksums between the trimmed and the new ordered exten=
t.
> > That's only increasing contention of the root's ordered_extent_lock for
> > other writes that are starting or completing.
> >
> > So lock the root's ordered_extent_lock only before we add the new order=
ed
> > extent to the root's ordered list and increment the root's counter for =
the
> > number of ordered extents.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: David Sterba <dsterba@suse.com>

This needs to be dropped for now as there are some problems there.
I'll address those in a patch set.

Thanks.

