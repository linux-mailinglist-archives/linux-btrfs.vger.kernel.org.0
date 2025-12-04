Return-Path: <linux-btrfs+bounces-19507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E827FCA2498
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 05:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F556300DCA9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 04:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9571F1F75A6;
	Thu,  4 Dec 2025 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Abf/3R06";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f65akjvq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA48398F99
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 04:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764821122; cv=none; b=uD6vUsbIDQWF8mixkiSS5Gmb98WGxfjxqhPIOXcuyN2r43v/as7CyWYAAQl3slh58xp63Ey0Z2vmslK8BFfu9KIHmxXV7aVkzf8ytoiLJms6iExZaPPKa3jH1E4mzZKxq8AtietEz0IgYKPjcHbqsnclh/Jm4sQpaiGG23HMUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764821122; c=relaxed/simple;
	bh=poqFRMIzgbluOWOHPPsKQU1oWXjAD5bSIMQKA8WOx8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ0+4vcXtgo0AXUtMYP0miEVP8NJ6Aio/ZMQujjbrypyV/FBcUeoQKjr4r+2yvfX1sbRcuBaiQZ2HKzzbzr/WT3GbUKgFB19Ym/5IXU6GuIuZzeHVTVqT75fttLkdT4Xpr0mok0XSOZqfhUgYk2pHl6Q+y0THCI7VxtNZPh457o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Abf/3R06; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f65akjvq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 70B5F1D0026C;
	Wed,  3 Dec 2025 23:05:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 03 Dec 2025 23:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764821118;
	 x=1764907518; bh=8X0eR001i+x7O2IpzjUFKrx1LSQXOzANeFz9WPuPK/A=; b=
	Abf/3R066mBu8Y5avgcJe1hfFOcSLPfyFsuw77roAcjiWKz5+nwCcRd/Nq88GpLo
	dlV+OsWmc438rAezDjcwlATUvTMnNaDMo2rw6CjrNjhQyBDk9LGhYYRIQTBAkZFb
	bwpfmA0guBt7d9uWosIeqIqCj3+4+4fd18ennxnkcjC04fz/h86ir+8RHKH9YsC5
	qneEKTVpMtuTx8SB6QL+yFxu2BuHYihb5v4OwixCJ+IDHiMYGaw/GQYemiaxL+d7
	yWPuEvnWgX1ebir1nqKt1Nm9LSnqCf7Pec152TCoRibN4yJoU8IamU/SPvOSeFFp
	pGjfdtusyX5Lt+oqLP47nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764821118; x=
	1764907518; bh=8X0eR001i+x7O2IpzjUFKrx1LSQXOzANeFz9WPuPK/A=; b=f
	65akjvq8RgQarK9uX79ypkZELeQq1k/IZVSBY3BJFpeGNH+8FNav76+7rx8i4QYC
	WFmzX1ofyhR1dKgmCDkjdPKvxVO3Ge4lfz51ojp2mp6clirMeZoCzpvZ6eIDHA6j
	1k4ROnNl9scj7NCpXsZtKkLRaA2WiQRgazV5XfWHWoMbBiGQRo20btZw69tGndTE
	5j2r63sNnK/WhSBft+tCg74j9DsK5EVJ0stII7FY0yFGkUkK1icmhRgs9agbg+cP
	Z359ItVsMuid2xyGwQcTdpb0pCVkzxCBOE2kgRNpFmb9gcr8N9T6EUghYqASo3XB
	Njt9DAKrkkny5u+2ODwBw==
X-ME-Sender: <xms:fggxaUPLz7t2YhW-HBMrv-6XqghLv48M7JJH_A4D-p_Pl2kcJmAF6Q>
    <xme:fggxaSa1rdXtDkDO6wugwMS0jo7JqRQ8Af5ZGZ8GPSdJlScQNVmwh7Il-0Cx6lgdY
    QpJZpt3lfGJdmurtlEOvxAamFPoIvZdsgGugEtnVoId5pPZzL3Bc75k>
X-ME-Received: <xmr:fggxaYpNPDMoSQLli-p8t1QJ9cTmp5FerBh5HfX2cl1G6FjiF2HsIzyBvfax3pQvGd2ETNObZ09y8MGM0j0du1monWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttd
    dtjeenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltd
    dvveegtdeuuddtiedtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfhhssehgmhig
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:fggxaWaDWQ5Gvch2Z5Sxm9DlhXkYK3HR7LJMyWE268yI2CRN-B6YXA>
    <xmx:fggxaQQSlIgJHpZGWpd7S-p6B5BO355Jc_T6T0o6Vw3OtSR7klXa0A>
    <xmx:fggxad7EfE3hrfidLYH5VX00miTmW38KnjVYo8udPzE8oxw-iSibiw>
    <xmx:fggxaVxQeoW9E0DFqkgYK4187TEcO_PJRRLFMsJBoKm-zyQQEAz-Ng>
    <xmx:fggxaU-9-kVWeGeGFTJVpTIgvOIhYNBe97eEp2ycPfCM4WkhCHlfpBL0>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 23:05:17 -0500 (EST)
Date: Wed, 3 Dec 2025 20:05:36 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs: relax squota parent qgroup deletion rule
Message-ID: <20251204040536.GA3743796@zen.localdomain>
References: <cover.1764796022.git.boris@bur.io>
 <4b63df0e26492b520b8b145e1d95e356ad89d51a.1764796022.git.boris@bur.io>
 <c7cf2a0b-8ee8-4527-9b50-dee1916fa1d1@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7cf2a0b-8ee8-4527-9b50-dee1916fa1d1@gmx.com>

On Thu, Dec 04, 2025 at 01:49:53PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/12/4 07:41, Boris Burkov 写道:
> > Currently, with squotas, we do not allow removing a parent qgroup with
> > no members if it still has usage accounted to it. This makes it really
> > difficult to recover from accounting bugs, as we have no good way of
> > getting back to 0 usage.
> > 
> > Instead, allow deletion (it's safe at 0 members..) while still warning
> > about the inconsistency by adding a squota parent check.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/qgroup.c | 51 +++++++++++++++++++++++++++++++++--------------
> >   1 file changed, 36 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 9e7e0c2e98ac..731ab71ff8ef 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1458,6 +1458,7 @@ static void qgroup_iterator_clean(struct list_head *head)
> >   	}
> >   }
> > +
> 
> A stray new line.
> 
> Otherwise looks good to me. I'll reply on the cover letter.
> 
> Thanks,
> Qu
> 

I didn't quite get to sending the new fstest before leaving on a
vacation before LPC, but I intend to do it next week. So please don't
feel the burden to also prepare an fstest of the new reproducer.

Thanks for the review,
Boris

> >   /*
> >    * The easy accounting, we're updating qgroup relationship whose child qgroup
> >    * only has exclusive extents.
> > @@ -1730,6 +1731,36 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> >   	return ret;
> >   }
> > +static bool can_delete_parent_qgroup(struct btrfs_qgroup *qgroup)
> > +
> > +{
> > +	ASSERT(btrfs_qgroup_level(qgroup->qgroupid));
> > +	return list_empty(&qgroup->members);
> > +}
> > +
> > +/*
> > + * Return true if we can delete the squota qgroup and false otherwise.
> > + *
> > + * Rules for whether we can delete:
> > + *
> > + * A subvolume qgroup can be removed iff the subvolume is fully deleted, which
> > + * is iff there is 0 usage in the qgroup.
> > + *
> > + * A higher level qgroup can be removed iff it has no members.
> > + * Note: We audit its usage to warn on inconsitencies without blocking deletion.
> > + */
> > +static bool can_delete_squota_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *qgroup)
> > +{
> > +	ASSERT(btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE);
> > +
> > +	if (btrfs_qgroup_level(qgroup->qgroupid) > 0) {
> > +		squota_check_parent_usage(fs_info, qgroup);
> > +		return can_delete_parent_qgroup(qgroup);
> > +	}
> > +
> > +	return !(qgroup->rfer || qgroup->excl || qgroup->rfer_cmpr || qgroup->excl_cmpr);
> > +}
> > +
> >   /*
> >    * Return 0 if we can not delete the qgroup (not empty or has children etc).
> >    * Return >0 if we can delete the qgroup.
> > @@ -1740,23 +1771,13 @@ static int can_delete_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup
> >   	struct btrfs_key key;
> >   	BTRFS_PATH_AUTO_FREE(path);
> > -	/*
> > -	 * Squota would never be inconsistent, but there can still be case
> > -	 * where a dropped subvolume still has qgroup numbers, and squota
> > -	 * relies on such qgroup for future accounting.
> > -	 *
> > -	 * So for squota, do not allow dropping any non-zero qgroup.
> > -	 */
> > -	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE &&
> > -	    (qgroup->rfer || qgroup->excl || qgroup->excl_cmpr || qgroup->rfer_cmpr))
> > -		return 0;
> > +	/* Since squotas cannot be inconsistent, they have special rules for deletion. */
> > +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> > +		return can_delete_squota_qgroup(fs_info, qgroup);
> >   	/* For higher level qgroup, we can only delete it if it has no child. */
> > -	if (btrfs_qgroup_level(qgroup->qgroupid)) {
> > -		if (!list_empty(&qgroup->members))
> > -			return 0;
> > -		return 1;
> > -	}
> > +	if (btrfs_qgroup_level(qgroup->qgroupid))
> > +		return can_delete_parent_qgroup(qgroup);
> >   	/*
> >   	 * For level-0 qgroups, we can only delete it if it has no subvolume
> 

