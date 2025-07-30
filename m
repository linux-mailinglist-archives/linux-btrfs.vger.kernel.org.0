Return-Path: <linux-btrfs+bounces-15759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348AAB1664F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 20:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A8E58294F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6242E1723;
	Wed, 30 Jul 2025 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Q3BzXkBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EI5Uhlhl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C64CA4E
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900402; cv=none; b=qlHtMqFShCSwh6FeMxM8tyJOd5N2Sgz/Z/DLnGaE4TzNjIa6Dygu9xgSNYwXJ3w3Et6lSBmf6pDyYQJNchmZjVKEFv/NqbnU0fC6uZClZCM7bsQjtN5rVVI5D5p5pidrjkeyiWmNJS/ORngZxjZSHZo+r/6QyJA7rcO5PQEfMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900402; c=relaxed/simple;
	bh=uyUc1K6cLbOWlzZOtqj+LLj6kL2f1j5683YsvhvlPyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogE6H8onDJSXIejo8GkIunCIX3Tzko1crSxgloZjnnoHlyBYXf1DupquTHtt8mr2UuPRuskFbLHkbtT/Z9WT+3J8j/uUuPp9H1qEHxe9echLdYskrv83aXEToTpIPqk2j1W/oEU5FIFOVxkq+QRk0RqISwrWQkeWGLQBn+06Lu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Q3BzXkBY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EI5Uhlhl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6912AEC1CDB;
	Wed, 30 Jul 2025 14:33:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 30 Jul 2025 14:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753900399;
	 x=1753986799; bh=7meUWjJqoWN6zfI7544UdDY1ac8g30NgJM9k2c1hIDk=; b=
	Q3BzXkBYEGLHNNyuziuXgPfvV5M8l58D8zJafVAdrxnu33sw9z1zoa7Mvkb6VPu0
	1cu6k6oI/4gjF4L44C3u07XWMM6bifcr7t1LKGdsk7SdygPCXvrQ/oLLBz6T6dH7
	Go2m8/lPI5LENzjQJgNpmCmCFXJSyOIry06rSp/6iT0uqOQXLgTLAUxAmUrN0PRk
	X8HBY5f8s23W5jTgYOk+ey2t1r9rP2iZYZr4l90DDSQYNXfghF4pVEiI9ikdV11j
	JuEZXz39C737Iag2HZOGuAFob7GldKEQHlCVwEwT/sg7x+d/+j7f0izl8ebMy0AP
	Zsf4vwEH7VYygSlmoXD+Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753900399; x=
	1753986799; bh=7meUWjJqoWN6zfI7544UdDY1ac8g30NgJM9k2c1hIDk=; b=E
	I5UhlhlqHvRXImw14VrZmvL4G/G2/WSrmvdsmPwWXBOVuwAdORPPKQaFpGc1AVmh
	LVDk2l1GB1ymimbTfdRL1UOuyAdibUdRvac3HkUD1JXJzCUAN622dIuj0h+VH6XN
	LiTh9QSVD2ERr1qW/AsqljjIpdLRHfnUm5rZckbWIZxoH9lvRHE9A5MgpMgdD7fI
	1gzn4reNmIFJCMzaPqHnsErcTg4NQWaMfEXKPuDAxZSafEI1lrbG/57ZjNM4xT7H
	gPG2jRPz7ZSvP4w/U4PUH1VAFljy/t5DlrBldi4hy68sV49sHpnuAxSWgH3l7x8E
	ZemfnJe/q9+sr1nZ0sqDg==
X-ME-Sender: <xms:b2WKaEYk09flYnFt_poUlhhrDFWYUf5gYIeY9veIz6v8CdYR1z_U2A>
    <xme:b2WKaPlLTvD43J5FMX3e6utxZSXA0jeBt7YZDe27fwEZtk7rfNhHqicrtmiwJxoF5
    y9u8zlsUiVMk2KIleU>
X-ME-Received: <xmr:b2WKaAxY_siIos3kEkHKq7iqehDoGafAWEGQR5IdQTyfbD-AKHvemEyyf1m0JdVbbE3QvnntLIseQ-dzpbdr7b5RIHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehhf
    duhefgkeehudefvdetgfetleeuiefgfefhfeegjeekfeehhffgkeejhfdvheenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:b2WKaNPCPJQE_hVRdAF69UxByMGMAZ1KApJh8HK1H5pHWdKa7McC_g>
    <xmx:b2WKaERxBOdtX_495jqgHZVXD_JQtZtffCVYV101IS4FUOo3P_xN9g>
    <xmx:b2WKaLYE7JgCvcbfpwnKaVbZrKMLQAO_br_vQz9DiUUNm-kB9C0SUA>
    <xmx:b2WKaB19UwZqGO9yxZVl5ynlITP3ygfNz-2HlVd2G1Sv3w3NsQPeaQ>
    <xmx:b2WKaJ-97A-gZYk7hKSJGVgr7O40JKRE72M5U9SvBC-TL3B84bhsKiR0>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 14:33:18 -0400 (EDT)
Date: Wed, 30 Jul 2025 11:34:28 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix race between logging inode and checking if it
 was logged before
Message-ID: <20250730183428.GA874072@zen.localdomain>
References: <7585d15c0e9c163d5cdf32307014a4e792e62541.1753807163.git.fdmanana@suse.com>
 <20250730173855.GB2742973@zen.localdomain>
 <CAL3q7H4HbqbGnX8jzTSHcEh8X5nZc2mW+COG+Avv_by8xRfVJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4HbqbGnX8jzTSHcEh8X5nZc2mW+COG+Avv_by8xRfVJA@mail.gmail.com>

On Wed, Jul 30, 2025 at 07:30:30PM +0100, Filipe Manana wrote:
> On Wed, Jul 30, 2025 at 6:37 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Tue, Jul 29, 2025 at 06:02:05PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > There's a race between checking if an inode was logged before and logging
> > > an inode that can cause us to mark an inode as not logged just after it
> > > was logged by a concurrent task:
> > >
> > > 1) We have inode X which was not logged before neither in the current
> > >    transaction not in past transaction since the inode was loaded into
> > >    memory, so it's ->logged_trans value is 0;
> > >
> > > 2) We are at transaction N;
> > >
> > > 3) Task A calls inode_logged() against inode X, sees that ->logged_trans
> > >    is 0 and there is a log tree and so it proceeds to search in the log
> > >    tree for an inode item for inode X. It doesn't see any, but before
> > >    it sets ->logged_trans to N - 1...
> > >
> > > 3) Task B calls btrfs_log_inode() against inode X, logs the inode and
> > >    sets ->logged_trans to N;
> > >
> > > 4) Task A now sets ->logged_trans to N - 1;
> > >
> > > 5) At this point anyone calling inode_logged() gets 0 (inode not logged)
> > >    since ->logged_trans is greater than 0 and less than N, but our inode
> > >    was really logged. As a consequence operations like rename, unlink and
> > >    link that happen afterwards in the current transaction end up not
> > >    updating the log when they should.
> > >
> > > The same type of race happens in case our inode is a directory when we
> > > update the inode's ->last_dir_index_offset field at inode_logged() to
> > > (u64)-1, and in that case such a race could make directory logging skip
> > > logging new entries at process_dir_items_leaf(), since any new dir entry
> > > has an index less than (u64).
> > >
> > > Fix this by ensuring inode_logged() is always called while holding the
> > > inode's log_mutex.
> >
> > Reviewed-by: Boris Burkov <boris@bur.io>
> >
> > The fix and explanation of the inode_logged() vs btrfs_log_inode() logic
> > as it pertains to setting logged_trans make sense to me.
> >
> > I do have one question, though, if you don't mind:
> >
> > How come higher level inode locking doesn't protect us? What paths down
> > into inode_logged() and btrfs_log_inode() can run concurrently on the
> > same inode? Intuitively, I would expect that anything which calls
> > btrfs_log_inode() would need to write lock the inode and anything that
> > calls inode_logged() would at least read lock it? Poking around the code
> > myself as well, but figured I would ask..
> 
> Higher inode level locking usually happens - we protect using the
> inode's vfs level lock - in the fsync call, during renames, unlinks.
> But in some cases when logging one inode we need to log another one -
> for example when logging a file that had a link removed in the current
> transaction, we log all previous parents, see for example:
> 
> commit 18aa09229741364280d0a1670597b5207fc05b8d ("Btrfs: fix stale dir
> entries after removing a link and fsync")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18aa09229741364280d0a1670597b5207fc05b8d
> 
> There are several other cases while logging an inode we need to log
> others (due to name collisions, logging new dentries for new inodes,
> etc).
> In these cases we can't take the vfs inode lock, as that would create
> ABBA type deadlocks, so we rely only on the inode's log_mutex and that
> is safe for directories and files as long as we don't log extents
> (LOG_INODE_EXISTS mode).
> 
> So that's why logged_inode() and inode logging can race.
> 

Thanks for the explanation, that's really helpful.

> >
> > Thanks,
> > Boris
> >
> > >
> > > Fixes: 0f8ce49821de ("btrfs: avoid inode logging during rename and link when possible")
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/tree-log.c | 34 ++++++++++++++++++++++++++++++----
> > >  1 file changed, 30 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > > index 43a96fb27bce..8c6d1eb84d0e 100644
> > > --- a/fs/btrfs/tree-log.c
> > > +++ b/fs/btrfs/tree-log.c
> > > @@ -3485,14 +3485,27 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
> > >   * Returns 1 if the inode was logged before in the transaction, 0 if it was not,
> > >   * and < 0 on error.
> > >   */
> > > -static int inode_logged(const struct btrfs_trans_handle *trans,
> > > -                     struct btrfs_inode *inode,
> > > -                     struct btrfs_path *path_in)
> > > +static int inode_logged_locked(const struct btrfs_trans_handle *trans,
> > > +                            struct btrfs_inode *inode,
> > > +                            struct btrfs_path *path_in)
> > >  {
> > >       struct btrfs_path *path = path_in;
> > >       struct btrfs_key key;
> > >       int ret;
> > >
> > > +     /*
> > > +      * The log_mutex must be taken to prevent races with concurrent logging
> > > +      * as we may see the inode not logged when we are called but it gets
> > > +      * logged right after we did not find it in the log tree and we end up
> > > +      * setting inode->logged_trans to a value less than trans->transid after
> > > +      * the concurrent logging task has set it to trans->transid. As a
> > > +      * consequence, subsequent rename, unlink and link operations may end up
> > > +      * not logging new names and removing old names from the log.
> > > +      * The same type of race also happens if out inode is a directory when
> > > +      * we update inode->last_dir_index_offset below.
> > > +      */
> > > +     lockdep_assert_held(&inode->log_mutex);
> > > +
> > >       if (inode->logged_trans == trans->transid)
> > >               return 1;
> > >
> > > @@ -3594,6 +3607,19 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
> > >       return 1;
> > >  }
> > >
> > > +static inline int inode_logged(const struct btrfs_trans_handle *trans,
> > > +                            struct btrfs_inode *inode,
> > > +                            struct btrfs_path *path)
> > > +{
> > > +     int ret;
> > > +
> > > +     mutex_lock(&inode->log_mutex);
> > > +     ret = inode_logged_locked(trans, inode, path);
> > > +     mutex_unlock(&inode->log_mutex);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  /*
> > >   * Delete a directory entry from the log if it exists.
> > >   *
> > > @@ -6678,7 +6704,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
> > >        * inode_logged(), because after that we have the need to figure out if
> > >        * the inode was previously logged in this transaction.
> > >        */
> > > -     ret = inode_logged(trans, inode, path);
> > > +     ret = inode_logged_locked(trans, inode, path);
> > >       if (ret < 0)
> > >               goto out_unlock;
> > >       ctx->logged_before = (ret == 1);
> > > --
> > > 2.47.2
> > >

