Return-Path: <linux-btrfs+bounces-22024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCQrH8q5oGnClwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22024-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 22:23:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A41AFB0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 22:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE613057E98
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C138BF73;
	Thu, 26 Feb 2026 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiaSqKLj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C830AABE
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140726; cv=none; b=cxPhjzMv0aaK1twGR61cAMH36Mzo1Q/LL56HpHSkLy+6g8I71oZ8f1ctuCsagAYzgql2Ta289eiqD9+fmX3dQZcYM88eT68hGjgSsRl30cIUfrAW9uzQX8F0N6YZWN9R6V/u37VPLZZstSuOTh9QhMiNUr12TmTeU4CQ9YzAD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140726; c=relaxed/simple;
	bh=86kVzDeSBt52t/9TW8Ko5HBiD4KbQsQI20C1hpEZCR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0otHc/ME3jPl11dj6qyku8DHEbQaA/qkQGTZepdZHgRUHd5FDjOKOnqjY6ypj+kTSY5Tv+ScAC1KlKUoNpoJMsqKqEW1GgHUka6B9pXHXKa1XXOodNXqiK48dHC0hxmqPo3H9Nc7cwwX98AHuw7tukH/HZFfL3aaVuekyikNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiaSqKLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA0CC116C6
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772140726;
	bh=86kVzDeSBt52t/9TW8Ko5HBiD4KbQsQI20C1hpEZCR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kiaSqKLjQV8KBIirlgkG603xKk7TIx1+dhYCifXMJajyorhWMy8m87pmYsjqS/joM
	 X2iDvLtpqsQ87BPFriu5bJD78JtJ9OXhURAX8C3a86Ujl24Vxl2PQXk1NhDu23QL0L
	 /Isal5ECuJ8u2YHNZKjlBmAjj+4x8sUKAJmjeKRkLYRcJ0dGvFuEfLhFkzCOlHigcr
	 sSFU4y/wO/gOGZ7zC56mBXOwUAw0LxhZtHAGjojkhEX+3eOzNzJXZwbxdKoWTJ6kdz
	 BrG9m57+mjmo56F17tXFxYucaT5ywRMUiz/viN7jSAsgWUFxVwsolP55DNKofAAyBl
	 HAnD/kjLvvikg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b886fc047d5so223975566b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 13:18:45 -0800 (PST)
X-Gm-Message-State: AOJu0YwR+qaqtaOvIb78yW72d8KD26SB6iMiFU8v7qZC94lBpeP6YbzP
	FGx/KfatCXppXZT2QyRc16NmwD7d8WXrsOb3jHu7b0eHzba3DkcX8RQh985A9q6ygvyCOLI8hp4
	b5dixu24+UUHmNTqRaq0grb+3ULenH6k=
X-Received: by 2002:a17:907:944d:b0:b8f:9ef2:bfac with SMTP id
 a640c23a62f3a-b937637a758mr25813166b.12.1772140724450; Thu, 26 Feb 2026
 13:18:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772105193.git.fdmanana@suse.com> <20260226191009.GB2996252@zen.localdomain>
In-Reply-To: <20260226191009.GB2996252@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Feb 2026 21:18:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5QVSU6nPt3H27keGWNpjJNG9nzQphjSQZmK8uU9KXt1g@mail.gmail.com>
X-Gm-Features: AaiRm51iXaNjz5fK6iY1Fq2iSNqZeYSF_8x9tXX7tyujcDBu7yR_zTZkVQ_AqBw
Message-ID: <CAL3q7H5QVSU6nPt3H27keGWNpjJNG9nzQphjSQZmK8uU9KXt1g@mail.gmail.com>
Subject: Re: [PATCH 0/5] btrfs: fix exploits that allow malicious users to
 turn fs into RO mode
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22024-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 684A41AFB0D
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 7:09=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Feb 26, 2026 at 02:33:57PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We have a couple scenarios that regular users can exploit to trigger a
> > transaction abort and turn a filesystem into RO mode, causing some
> > disruption. The first 2 patches fix these, the remainder are just a few
> > trivial and cleanups.
>
> Bug fixes and cleanups look good. No need to abort in these cases as you
> have shown.
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> But on the topic of security, or malicious users:
>
> How is this sort of attack conceptually different from simply filling
> up the filesystem with fallocates then doing random metadata operations
> until we ENOSPC and go readonly?

What makes you think that users causing an ENOSPC that triggers a
transaction abort isn't an issue?

If we know of any intentional way to trigger that, we should definitely fix=
 it.
Even some weeks ago I fixed such a case reported by a user when
running bonnie++:

https://lore.kernel.org/linux-btrfs/SA1PR18MB56922F690C5EC2D85371408B998FA@=
SA1PR18MB5692.namprd18.prod.outlook.com/

We often see users reporting that sort of issue, but we don't know the
workloads, how to reproduce and the state of their fs most of the
time.

>
> What about if the attacker also exploits the behavior of the extent
> allocator to try to produce fragmentation driven metadata ENOSPCs
> aborts?

Do you know of a way to do that?
If you do, we should fix it.

No matter what a user does, especially a non-privileged user, it
should not trigger transaction aborts in an easy way (or anything else
bad, like memory leaks, use-after-frees, NULL pointer derefs, etc).

Thanks.

>
> Thanks,
> Boris
>
> >
> > Filipe Manana (5):
> >   btrfs: fix transaction abort on file creation due to name hash collis=
ion
> >   btrfs: fix transaction abort when snapshotting received subvolumes
> >   btrfs: stop checking for -EEXIST return value from btrfs_uuid_tree_ad=
d()
> >   btrfs: remove duplicated uuid tree existence check in btrfs_uuid_tree=
_add()
> >   btrfs: remove pointless error check in btrfs_check_dir_item_collision=
()
> >
> >  fs/btrfs/dir-item.c    |  4 +---
> >  fs/btrfs/inode.c       | 19 +++++++++++++++++++
> >  fs/btrfs/ioctl.c       |  2 +-
> >  fs/btrfs/transaction.c | 18 +++++++++++++++++-
> >  fs/btrfs/uuid-tree.c   |  5 +----
> >  5 files changed, 39 insertions(+), 9 deletions(-)
> >
> > --
> > 2.47.2
> >

