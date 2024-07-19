Return-Path: <linux-btrfs+bounces-6611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CA937C39
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 20:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECE61C2207A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58757146D6C;
	Fri, 19 Jul 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A4wlPLhM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1EB8C1E
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412822; cv=none; b=RaJVU247Sk7EjMBnnGqDce4GOqCtjFjGttJm6jzgQr6nH4c4wdhG0OKaFk5JP1BTKo1fQNVuZMhw3YwM9H2fsBT0FtiFkc9CcFLY9J8ODKlZoD+SRQiOow+fKHJH0H1pEhlASnUtVGZ0N3jnYn46CzzeRN3EhJrOyU1OvDppG/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412822; c=relaxed/simple;
	bh=32zNyKgl9F/vi7TIXtY1pDCcbcQEj3CRShBeS4KycAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM73yeOMgCnm4Yn0XZ0Mv56xkxpBDKQkJgtRcgJbL73miMLI248rEQolX7o8rJvQGzI/NXgG0i9wE/gjqM38JaOB24GncB3JvTSNFSlyYYR95fsdY6IveY5Y8u0ee+eFLvqJoPRBywSWk/wfY5mt4bs7KgW2ssFZ/eOktuAwe1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A4wlPLhM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3687fd09251so471310f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721412818; x=1722017618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtkgtrgq5T9527z52jU1fuPROGptcAZm6NwuubLRp0s=;
        b=A4wlPLhMsnQTT91q051JRXMCj/S0mAHdxfa6ffW/wMzQZMYayoG+2ri1GxxOEfYZUp
         4NxYRByKCMWgq6lAjhldYTIhEry1Ug+NzY+fR0oPpQ4+uSZKMHonB7xJ059ShjFYLKwt
         XqOlYcsWpjTYIB/iZMFJZTAiLhGiZzDVS/8p7HaWcOBsdJMe5FaITvNzGaetI+06EcIP
         iFZQXzMSKYBAVWeNiY9qrDDk3Wl1jgDXroHRhs6OGO2ro1iEWEkKsVCYbHJ4SaWsPfDN
         yEmiXXHYtBUf4Ry0ACkA42e5KbhHOIetMUVfyUxo+XsyuccmLs+wBPB8xlGHtRc91ODA
         uYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721412818; x=1722017618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtkgtrgq5T9527z52jU1fuPROGptcAZm6NwuubLRp0s=;
        b=w+R4TmZC6iSyvnBGrw2f47eGSYmGDms6CNWv/5G/hwGFke4oK82QtrPMRuo0EzF1+j
         jb9Ex6jfPhLRuHiBwzm5Co+ggLTa5dFGWuYRO0DKp+KJPI8MSO+yEwYB0iLznnCJaMMV
         k3wVW/Zutj5/5h1Ld88gYLDjdGmjlWxsvkiHVkyHMIu/QzlwEUt1xANsLrtp8zSjnyWn
         DyG7c/SkZPV/fyavVhM1BLCwK98eAhG8UsvIBogjeUO79PRYsqO+hhhP44ecMi3DFI41
         dXrXNaDesKTDnpI8V3vV0UKYRrr+Mdg066WcfQqjDeI0sS2MryJx5k0Q2Q/S0L41w9Jf
         k04A==
X-Forwarded-Encrypted: i=1; AJvYcCWbHDf7e/LhcbTl0i7netJGo9QIy2NuzQt9RfA5kUHmtTbS6Jkjo2TI2z1fglPlKw8tE9F2laWHETJs/zlIJnDDi752HTf9SMB2TFo=
X-Gm-Message-State: AOJu0Ywh77aBGLKmT6WLf+rFry/nm4lqWM3VaL2OMHM1TLfkRuMLInH0
	RXIbQbkMcov9EfwYtxq9W1qFlFcmfG2ndwPDjqrFY7j4OLwBx95/cWfNZhMppFY=
X-Google-Smtp-Source: AGHT+IFX6MK/dNO28N7btu/BHuth1OXIjPKoRHbGCTlplFaJwfwdjS2joP6EcRYcvcM+RpKYHrt2xw==
X-Received: by 2002:a5d:4b0e:0:b0:368:7a18:908c with SMTP id ffacd0b85a97d-3687a18926amr1457236f8f.51.1721412817507;
        Fri, 19 Jul 2024 11:13:37 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a6fd5fsm59755435e9.22.2024.07.19.11.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 11:13:37 -0700 (PDT)
Date: Fri, 19 Jul 2024 20:13:36 +0200
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v7 2/3] btrfs: always uses root memcgroup for
 filemap_add_folio()
Message-ID: <Zpqs0HdfPCy2hfDh@tiehlicka>
References: <cover.1721384771.git.wqu@suse.com>
 <6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com>
 <20240719170206.GA3242034@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719170206.GA3242034@cmpxchg.org>

On Fri 19-07-24 13:02:06, Johannes Weiner wrote:
> On Fri, Jul 19, 2024 at 07:58:40PM +0930, Qu Wenruo wrote:
> > [BACKGROUND]
> > The function filemap_add_folio() charges the memory cgroup,
> > as we assume all page caches are accessible by user space progresses
> > thus needs the cgroup accounting.
> > 
> > However btrfs is a special case, it has a very large metadata thanks to
> > its support of data csum (by default it's 4 bytes per 4K data, and can
> > be as large as 32 bytes per 4K data).
> > This means btrfs has to go page cache for its metadata pages, to take
> > advantage of both cache and reclaim ability of filemap.
> > 
> > This has a tiny problem, that all btrfs metadata pages have to go through
> > the memcgroup charge, even all those metadata pages are not
> > accessible by the user space, and doing the charging can introduce some
> > latency if there is a memory limits set.
> > 
> > Btrfs currently uses __GFP_NOFAIL flag as a workaround for this cgroup
> > charge situation so that metadata pages won't really be limited by
> > memcgroup.
> > 
> > [ENHANCEMENT]
> > Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
> > memory cgroup to attach metadata pages.
> > 
> > With root memory cgroup, we directly skip the charging part, and only
> > rely on __GFP_NOFAIL for the real memory allocation part.
> > 
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  fs/btrfs/extent_io.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index aa7f8148cd0d..cfeed7673009 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2971,6 +2971,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> >  
> >  	struct btrfs_fs_info *fs_info = eb->fs_info;
> >  	struct address_space *mapping = fs_info->btree_inode->i_mapping;
> > +	struct mem_cgroup *old_memcg;
> >  	const unsigned long index = eb->start >> PAGE_SHIFT;
> >  	struct folio *existing_folio = NULL;
> >  	int ret;
> > @@ -2981,8 +2982,17 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> >  	ASSERT(eb->folios[i]);
> >  
> >  retry:
> > +	/*
> > +	 * Btree inode is a btrfs internal inode, and not exposed to any
> > +	 * user.
> > +	 * Furthermore we do not want any cgroup limits on this inode.
> > +	 * So we always use root_mem_cgroup as our active memcg when attaching
> > +	 * the folios.
> > +	 */
> > +	old_memcg = set_active_memcg(root_mem_cgroup);
> >  	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
> >  				GFP_NOFS | __GFP_NOFAIL);

I thoutght you've said that NOFAIL was added to workaround memcg
charges. Can you remove it when memcg is out of the picture?

It would be great to add some background about how much memory are we
talking about. Because this might require memcg configuration in some
setups.

> > +	set_active_memcg(old_memcg);
> 
> It looks correct. But it's going through all dance to set up
> current->active_memcg, then have the charge path look that up,
> css_get(), call try_charge() only to bail immediately, css_put(), then
> update current->active_memcg again. All those branches are necessary
> when we want to charge to a "real" other cgroup. But in this case, we
> always know we're not charging, so it seems uncalled for.
> 
> Wouldn't it be a lot simpler (and cheaper) to have a
> filemap_add_folio_nocharge()?

Yes, that would certainly simplify things. From the previous discussion
I understood that there would be broader scopes which would opt-out from
charging. If this is really about a single filemap_add_folio call then
having a variant without doesn't call mem_cgroup_charge sounds like a
much more viable option and also it doesn't require to make any memcg
specific changes.

-- 
Michal Hocko
SUSE Labs

