Return-Path: <linux-btrfs+bounces-17783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06168BDB4E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 22:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B0464F258C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB122DECB1;
	Tue, 14 Oct 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="D74hUHsV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF12DC777
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474757; cv=none; b=T03HMm5rvhCvbTIcNsyAHWE3FCLTTRpSnjh5Yw0MldfRU7cRrOATBNRqfR4+L1LR4XUNV8GgiqIqqGfYCM8rF1a/bRqPwgUHNebjz0CoBO9XUAg4Z/dWvGr1ZoywPmIDpREN6VZzZWSbfOgJxCFoVSmrIc/3AM8yniMx5Z9YFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474757; c=relaxed/simple;
	bh=mLMiOvkuQ1waPsYJBAJdPUyickusJQ8ORxj4y3Zep3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXOlfqqDmV/suyCenDJyCGmPBJO0OSH0aB/U2UaxbEzHD9OvEQ/ECj0ATi7yc6Vg0Cc/6XpZaw9Bk560NZuIpLOLv/wtZ664C1ricgt6IZPKpf4HGXdQe1clwLoD9WjlIu2AhHIi+TiNitiOKLMOVRB4xxhlHIEWH5sPfnUjik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=D74hUHsV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso1081205b3a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760474754; x=1761079554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ProMLWdJiYhd+ReUg4Q/nfu5OGup3NKBCnvPEIlS8hk=;
        b=D74hUHsVIAuXAszKT9OyaSP01aDFJeS4dtESAdmyVJsGXoAAl6SoLYFzgqG8sO3LVj
         6ERxo1FSU1Y3JKmYIIaOBI7kPi3x4Gpy/qkXd2rlwvWCRrTYb1eyGj+5O2baZ6fukQik
         Gb4qo2yhiBLvajFZ1uKdHX00YcoaXpBLLYt1ZH+9jgc4mxK3LSaG3HibkB4KlKCev0e7
         3Xiuj63FONPcDeoK99vIV5AkSYSkhgQq6jbXRMFs8xps1Rd79gaHNdZeCeH0pQZyYIlX
         43GH4VKUCNcsCnnFnPE93PllXNK2XvANDk2T9wezW0mBUN0nkZ9WgYK8q0nQIF3CpbgA
         CMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474754; x=1761079554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ProMLWdJiYhd+ReUg4Q/nfu5OGup3NKBCnvPEIlS8hk=;
        b=p9B/M0lCfgTVx6T5JfkEz7ygdKmwDD0kmsJUsn49AphITeklVrev9FWyx0Gy22gQUh
         tOroUO3Et2d9ZsiVJbE4AQ2WexLBoTQjGkbmLUIOFFOrgS0/1+UvhdtzKwyt62KcDnDu
         VxNlzIdu+ZBkN68fNNNgM3b6/DcrIjJi7yRqAeOkjPCj/Y4/lhFeMxNjuXJLSXPptjNf
         Gx8FZNYiaUPmNrsaOJuktL2SCZ6ONzZzeAsTpXtyT7ax2USK1gPiWn9Gqj3irqn65nSp
         toqLSEHalyd8EYRp2T1E0qwsxDmbxXgA66yZzJ3AxzDejDSKe7HC9PVdJRdLZzyYYkpL
         p7GA==
X-Forwarded-Encrypted: i=1; AJvYcCUCw4qr+TYnZ/g305+Kn1YIybiPyWJfSVLdgK33MO1flYB0npiOXcrF1xcmaNQapjtwPZ0eQT4yhYMWjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzag835j9cc29xNbAvhr9/XV/1O98XOyryopmO2hOWdXAvolzzz
	spAaR15u0CHPB5ENq0ojWnWPA+vJ1X/pGz6CdI9cxpci0G1Wyak7t6YSiKW46XY6ZBM=
X-Gm-Gg: ASbGncvmqPRbI3UROei9UGY9eMFNRIo1iBwTle0t/vWWKmleFD+021Ec/CqYmyBI8ew
	B5OOME1M9DaVEo37dzX8tIHb4HADhy0C0riT/RqX5kAUSbas8Pgagc3jvqwZDTvtynFZ0uBUaNb
	gl/I6yzVSlHb298RjAVZWyAtZDjDsIUS9rC9EoOuf1PqyrTusuciR35g9OhPE4uAY9KhNeCX03Y
	u8veqb8PE22d9NVEmHK90qtZv0gQvryjkoNJzlS3G16bvWC9BsndqSq9QPZZ/mxU+uJlpZOHRba
	C0M9scndV9NeE/IZs+Mad9utqlMAEYCAXsjESHho6ISmNUXDslPUvxpA6C60mir4+zJc5oOdQct
	whrtNdDGpLk4an0JrqcdAQQmwKVlbokP6z6Dj+1woYw+lqqDeaMvXPMX10R5yjdWRd4aEzAGNm3
	tv2NMZpY2LJIcvmUwr
X-Google-Smtp-Source: AGHT+IEha/464YLIDe1S05FMmmIwJiiHJqNozxP/E/7ahWiUSHSloNCgr/S9uHudRNKH/rfSTuG4WQ==
X-Received: by 2002:a17:90b:3947:b0:31e:c95a:cef8 with SMTP id 98e67ed59e1d1-33b5139a259mr32044929a91.32.1760474754350;
        Tue, 14 Oct 2025 13:45:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62631266sm16839994a91.3.2025.10.14.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:45:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v8lu3-0000000Es6g-0Y5G;
	Wed, 15 Oct 2025 07:45:51 +1100
Date: Wed, 15 Oct 2025 07:45:51 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/10] mm,btrfs: add a filemap_fdatawrite_kick_nr helper
Message-ID: <aO62fx2B5ZZLsRVM@dread.disaster.area>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-7-hch@lst.de>
 <74593bac-929b-4496-80e0-43d0f54d6b4c@kernel.org>
 <4bcpiwrhbrraau7nlp6mxbffprtnlv3piqyn7xkm7j2txxqlmn@3knyilc526ts>
 <20251014044723.GA30978@lst.de>
 <qh7xhmefm54k3hgny3iwkxbdrgjf35swqokiiicu5gg3ahvf4s@xhyw4sfagjgw>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qh7xhmefm54k3hgny3iwkxbdrgjf35swqokiiicu5gg3ahvf4s@xhyw4sfagjgw>

On Tue, Oct 14, 2025 at 11:33:26AM +0200, Jan Kara wrote:
> On Tue 14-10-25 06:47:23, Christoph Hellwig wrote:
> > On Mon, Oct 13, 2025 at 01:58:15PM +0200, Jan Kara wrote:
> > > I don't love filemap_fdatawrite_kick_nr() either. Your
> > > filemap_fdatawrite_nrpages() is better but so far we had the distinction
> > > that filemap_fdatawrite* is for data integrity writeback and filemap_flush
> > > is for memory cleaning writeback. And in some places this is important
> > > distinction which I'd like to keep obvious in the naming. So I'd prefer
> > > something like filemap_flush_nrpages() (to stay consistent with previous
> > > naming) or if Christoph doesn't like flush (as that's kind of overloaded
> > > word) we could have filemap_writeback_nrpages().
> > 
> > Not a big fan of flush, but the important point in this series is
> > to have consistent naming.
> 
> I fully agree on that.

*nod*

> >  If we don't like the kick naming we should standardize on _flush (or
> >  whatever) and have the _range and _nrpages variants of whatever we pick
> >  for the base name.
> > 
> > Anyone with strong feelings and or good ideas about naming please speak
> > up now.
> 
> I agree with either keeping filemap_flush* or using filemap_writeback* (and
> renaming filemap_flush to filemap_writeback).

I'd prefer filemap_flush* because most people are already familiar
with that naming and the expected semnatics. But I could live with
filemap_writebacki*, too. Both are better than "kick", IMO.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

