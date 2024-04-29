Return-Path: <linux-btrfs+bounces-4634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4A58B6566
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A21C21944
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB4194C6F;
	Mon, 29 Apr 2024 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="1nNdxs5K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3DleE+y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352F194C79
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429049; cv=none; b=iX0RYZm7N9xiMHZ/J8R7pTrcAPij4+caMyfzo4ANAI76uC1KdUaPzAPEEs9kYXFoO2uOlORFCAeMpkAYXSww3J7F4v2kk4Bz6PN88zakSp49bismJ8RcKIS9WWa4YRtdVUxLNCR2nXS6n5c09goIrfUk+N5vNyTyifGQxjX9OTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429049; c=relaxed/simple;
	bh=0LNr+0salXmxVRjkIy5UGMHJCa8jEQ1TOhNhk5tOmLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXgrbz7+/VIY7q8ilxPBc71UrUKYwWFEqVYa3nGnxfyyjWZPPnmIyLgt3hahhmmdiqlQYAhLtFjxEVonYlraVvHi+2pCj/TrhHtj4Aiu52yVjtHnMlDKM9WCqVlxIP3jyyrAMi+9yANQRAVb4bdbW6JLxFrY7A81QASFpCM4FMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=1nNdxs5K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3DleE+y; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 750DC1800109;
	Mon, 29 Apr 2024 18:17:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 18:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714429045;
	 x=1714515445; bh=JBBP5mvZk9ulGYx8bbcYIJOs1J26NsrYRWVqvUN1aAw=; b=
	1nNdxs5KWw4qAN5JNpKoQUKc77NEg/LSKlfBubJoba5/1Sra0R56H+WIyaqtHIKM
	UW7a4KTr9N/YZI9F3ayhBJTvXEggQ8zATNh9+Fm615b3Nu0krUQrA54espE2RJb9
	ftHoRSehDCBoQj0C4M5Zkb9JdOQA4l7rhGZUHbyHlx+KqZT7UEWpT/1KQnHJmEOX
	EzstBmJGnEe4Q9ADv6X5caF8hwWOmuCh0at5f/InsMldXMH7MMMpUKA8RL4y8w0I
	SV2jWnsaH4SCUSiEuLgkVwQfM9LbRA+oLqAX0sYvGR9kuwCnJU45CCz/BV0+H6/+
	evyqx79lyGqCZ2P5ouAYVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714429045; x=
	1714515445; bh=JBBP5mvZk9ulGYx8bbcYIJOs1J26NsrYRWVqvUN1aAw=; b=h
	3DleE+yFnA+09cWL3D191O2uOZdkvM4KL1nPs9f4Kp9Mu6Tj+/TX5r+Wf/zOb0hp
	G/GhhMlmPi/O/QmLAcpY1cuAooNttb+bBxUTUQkZ1RgqmM8i8yvkb5EIjxt1BmyB
	CklWBXIXZssjS7hK6e72Wj619gFDW3gMls96C6oZKNb6djs6mgUWu5O7nI3DDz3p
	FAgLMDe2J3IJH/Zyz6/8a2C5uwDSyTF9xGGTyb7xTO04XjzQz13d+8iR8cYegbGm
	MsMyuTn+teMzZEoF6VYmDLiNIKdqSduGb3OIgEBh/jykd/fJvLHf3cykh08C9dBm
	NU83qOLkaZG3pJ9oQICRQ==
X-ME-Sender: <xms:dBwwZnxHytKzZhos1O_Japfo7HOraFnN3-g_0N6YAObgHUuOdaLaGQ>
    <xme:dBwwZvTznzLbNSaEnaWmgFRT5FdsrGoulrRnpsniNb-EFlEQHGJV0pdpBjfWy0l7A
    6TzcVzgXsuz5rA0Uxg>
X-ME-Received: <xmr:dBwwZhVvmLfIQo6uQKCznDoHYiIpQvB_Ml4Fs5DUWuBaxanE198opJEID7p0uwRNL9gWXFCCOJE-LoDv8JzI7a1tO5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:dBwwZhiW8wEgd48Qe6R_QLtudUSWXqdGBXhSKrnVvoHfKOmDLD-yfA>
    <xmx:dBwwZpA89Bf4jjxlvUMTvYwKLMrECporHZ4BSSSSqufam_V9jUrhEA>
    <xmx:dBwwZqLFDdfFf3lks7lW2tAoBfixMzx3S3cAgF7P1_XuPPjj9uCWvQ>
    <xmx:dBwwZoBDYhDh0nJkFQ0_sM2utDcdtYeFMmOthIBLMKlUff02YmqBYQ>
    <xmx:dRwwZoN9mFpF1v0uGOOUVB2FmPP_gqOovDoDFbMy6HfcYX-6Dz-LH7zc>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 18:17:24 -0400 (EDT)
Date: Mon, 29 Apr 2024 15:19:56 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: slightly loose the requirement for qgroup
 removal
Message-ID: <20240429221956.GA36465@zen.localdomain>
References: <cover.1713519718.git.wqu@suse.com>
 <3fa525bceeec6096ddd131da98036e07b9947c9c.1713519718.git.wqu@suse.com>
 <20240429124741.GA21573@zen.localdomain>
 <d817e2ba-799c-4c88-b5b6-98b8e7233687@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d817e2ba-799c-4c88-b5b6-98b8e7233687@gmx.com>

On Tue, Apr 30, 2024 at 07:30:58AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/4/29 22:17, Boris Burkov 写道:
> > On Fri, Apr 19, 2024 at 07:16:52PM +0930, Qu Wenruo wrote:
> > > [BUG]
> > > Currently if one is utilizing "qgroups/drop_subtree_threshold" sysfs,
> > > and a snapshot with level higher than that value is dropped, btrfs will
> > > not be able to delete the qgroup until next qgroup rescan:
> > > 
> > >    uuid=ffffffff-eeee-dddd-cccc-000000000000
> > > 
> > >    wipefs -fa $dev
> > >    mkfs.btrfs -f $dev -O quota -s 4k -n 4k -U $uuid
> > >    mount $dev $mnt
> > > 
> > >    btrfs subvolume create $mnt/subv1/
> > >    for (( i = 0; i < 1024; i++ )); do
> > >    	xfs_io -f -c "pwrite 0 2k" $mnt/subv1/file_$i > /dev/null
> > >    done
> > >    sync
> > >    btrfs subv snapshot $mnt/subv1 $mnt/snapshot
> > >    btrfs quota enable $mnt
> > >    btrfs quota rescan -w $mnt
> > >    sync
> > >    echo 1 > /sys/fs/btrfs/$uuid/qgroups/drop_subtree_threshold
> > >    btrfs subvolume delete $mnt/snapshot
> > >    btrfs subv sync $mnt
> > >    btrfs qgroup show -prce --sync $mnt
> > >    btrfs qgroup destroy 0/257 $mnt
> > >    umount $mnt
> > > 
> > > The final qgroup removal would fail with the following error:
> > > 
> > >    ERROR: unable to destroy quota group: Device or resource busy
> > > 
> > > [CAUSE]
> > > The above script would generate a subvolume of level 2, then snapshot
> > > it, enable qgroup, set the drop_subtree_threshold, then drop the
> > > snapshot.
> > > 
> > > Since the subvolume drop would meet the threshold, qgroup would be
> > > marked inconsistent and skip accounting to avoid hanging the system at
> > > transaction commit.
> > > 
> > > But currently we do not allow a qgroup with any rfer/excl numbers to be
> > > dropped, and this is not really compatible with the new
> > > drop_subtree_threshold behavior.
> > > 
> > > [FIX]
> > > Instead of a strong requirement for zero rfer/excl numbers, just check
> > > if there is any child for higher level qgroup, and for subvolume qgroups
> > > check if there is a corresponding subvolume for it.
> > > 
> > > For rsv values, do extra warnings, and for rfer/excl numbers, only do the
> > > warning if we're in full accounting mode and the qgroup is consistent.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   fs/btrfs/qgroup.c | 69 ++++++++++++++++++++++++++++++++++++++++++-----
> > >   1 file changed, 62 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > > index 9a9f84c4d3b8..2ea16a07a7d4 100644
> > > --- a/fs/btrfs/qgroup.c
> > > +++ b/fs/btrfs/qgroup.c
> > > @@ -1736,13 +1736,38 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> > >   	return ret;
> > >   }
> > > 
> > > -static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
> > > +static bool can_delete_qgroup(struct btrfs_fs_info *fs_info,
> > > +			      struct btrfs_qgroup *qgroup)
> > >   {
> > > -	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
> > > -		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
> > > -		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
> > > -		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
> > > -		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
> > > +	struct btrfs_key key;
> > > +	struct btrfs_path *path;
> > > +	int ret;
> > > +
> > > +	/* For higher level qgroup, we can only delete it if it has no child. */
> > > +	if (btrfs_qgroup_level(qgroup->qgroupid)) {
> > > +		if (!list_empty(&qgroup->members))
> > > +			return false;
> > > +		return true;
> > > +	}
> > > +
> > > +	/*
> > > +	 * For level-0 qgroups, we can only delete it if it has no subvolume
> > > +	 * for it.
> > > +	 * This means even a subvolume is unlinked but not yet fully dropped,
> > > +	 * we can not delete the qgroup.
> > > +	 */
> > 
> > This was what I originally considered for normal qgroups before observing
> > that usage is 0 anyway. I didn't know about the drop tree threshold,
> > my mistake.
> > 
> > With that said, I support this change for non-squota qgroups.
> > 
> > For squota, I think this behavior would be OK, but undesirable, IMO. Any
> > parent qgroup would still have its usage incremented against the limit,
> > but it would be impossible to find any information on where it was from.
> 
> That's indeed another problem.
> 
> For regular qgroup that could only happen when qgroup is inconsistent,
> and we're fine to drop the qgroup without updating the parent.
> 
> But for squota, there is no inconsistent state, meaning we should also
> drop all the numbers from parent too.
> 
> > 
> > How do you feel about making this patch add the new logic and make it
> > conditional on qgroup mode?
> 
> I'm totally fine to do it conditional, although I'd also like to get
> feedback on dropping the numbers from parent qgroup (so we can do it for
> both qgroup and squota).
> 
> Would the auto drop for parent numbers be a solution?

It's a good question. It never occurred to me until this discussion
today.

Thinking out loud, squotas as a feature is already "comfortable" with
unaccounted space. If you enable it on a live FS, all the extents that
already exist are unaccounted, so there is no objection on that front.

I think from a container isolation perspective, the current behavior
makes more sense than auto dropping from the parent on subvol delete to
allow cleaning up the qgroup.

Suppose we create a container wrapping parent qgroup with ID 1/100. To
enforce a limit on the container customer, we set some limit on 1/100.
Then we create a container subvol and put 0/svid0 into 1/100. The
customer gets to do stuff in the subvol. They are a fancy customer and
create a subvol svid1, snapshot it svid2, and delete svid1.

svid1 and svid2 are created in the subvol of id svid0, so auto-inheritance
ensured that 1/100 was the parent of 0/svid1 and 0/svid2, but now
deleting svid1 frees all that customer usage from 1/100 and allows the
customer to escape the limit. This is obviously quite undesirable, and
wouldn't require a particularly malicious customer to hit.

Boris

> 
> Thanks,
> Qu
> > 
> > Thanks,
> > Boris
> > 
> > > +	key.objectid = qgroup->qgroupid;
> > > +	key.type = BTRFS_ROOT_ITEM_KEY;
> > > +	key.offset = -1ULL;
> > > +	path = btrfs_alloc_path();
> > > +	if (!path)
> > > +		return false;
> > > +
> > > +	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
> > > +	btrfs_free_path(path);
> > > +	if (ret > 0)
> > > +		return true;
> > > +	return false;
> > >   }
> > > 
> > >   int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> > > @@ -1764,7 +1789,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> > >   		goto out;
> > >   	}
> > > 
> > > -	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
> > > +	if (!can_delete_qgroup(fs_info, qgroup)) {
> > >   		ret = -EBUSY;
> > >   		goto out;
> > >   	}
> > > @@ -1789,6 +1814,36 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> > >   	}
> > > 
> > >   	spin_lock(&fs_info->qgroup_lock);
> > > +	/*
> > > +	 * Warn on reserved space. The subvolume should has no child nor
> > > +	 * corresponding subvolume.
> > > +	 * Thus its reserved space should all be zero, no matter if qgroup
> > > +	 * is consistent or the mode.
> > > +	 */
> > > +	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
> > > +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
> > > +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
> > > +	/*
> > > +	 * The same for rfer/excl numbers, but that's only if our qgroup is
> > > +	 * consistent and if it's in regular qgroup mode.
> > > +	 * For simple mode it's not as accurate thus we can hit non-zero values
> > > +	 * very frequently.
> > > +	 */
> > > +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL &&
> > > +	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
> > > +		if (WARN_ON(qgroup->rfer || qgroup->excl ||
> > > +			    qgroup->rfer_cmpr || qgroup->excl_cmpr)) {
> > > +			btrfs_warn_rl(fs_info,
> > > +"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
> > > +				      btrfs_qgroup_level(qgroup->qgroupid),
> > > +				      btrfs_qgroup_subvolid(qgroup->qgroupid),
> > > +				      qgroup->rfer,
> > > +				      qgroup->rfer_cmpr,
> > > +				      qgroup->excl,
> > > +				      qgroup->excl_cmpr);
> > > +			qgroup_mark_inconsistent(fs_info);
> > > +		}
> > > +	}
> > 
> > If you go ahead with making it conditional, I would fold this warning
> > into the check logic. Either way is fine, of course.
> > 
> > >   	del_qgroup_rb(fs_info, qgroupid);
> > >   	spin_unlock(&fs_info->qgroup_lock);
> > > 
> > > --
> > > 2.44.0
> > > 
> > 

