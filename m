Return-Path: <linux-btrfs+bounces-15654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66689B1011D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 08:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB667A040C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 06:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20550221F34;
	Thu, 24 Jul 2025 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKwmLF9D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6E20F088
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Jul 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339886; cv=none; b=GcAkaQxZqgiHS9JQW28B4awJGoQI4hlS+qlrEqdrjBAdfso+PWBcwcZl3hiuOsFK3oCqbvyd+McM3TSUCLmzjT1IfcXOEQcZvf2sTzQv/+T3xr5mdNKbLtuCCR3CW7wbyboOyYftXaN3IswfmOuZX5MpiN3OMHWd+A3Deg+smJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339886; c=relaxed/simple;
	bh=u7igWpV2K8o0bXckOlzDXy4r02xhUU+hw42wj0USXrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eokIduQEJtGyRLmw7LWvc5wxgiT0Hdp3oFgJV/ayo/ytpaf68yMCZ9G0bZb9R8zcoZ00IWX4YuGls0U9hsbkeIlAwQMK4lipam/hzERZelkx0AFxXplr9bauMcJA/LI9joUXH4lyoBRotHLliF9gHj16ZTcmYvD8VISxbqqH2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKwmLF9D; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a54700a463so392367f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753339883; x=1753944683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmwaqJ0idIWWPFaVblV/PRv/PAdctTYaz+oXsBak7KA=;
        b=FKwmLF9Dkup5uwY+gICnQz1LLUlKsqziFbjXLbDVZtq7I9n8Y/uRLEGgi5uZlJ/Agc
         HyOn3D5OtGErOq7+mXks8S7arVzgFVFFm/8ifnDFr1i+Z9t22Fi8lb2A0y0zJoIo87ri
         Y9GsKDtfYvlbYEqXLOgXNfwEfdrK9f86h2WdEoi+diImYIgib3FJH4so+SkDVPm9qYbz
         6xM53e2mrmA4etXC9rEHsRut7MJeWb5zhz4fO2c2/APGwL7aaUp5fNIOl5oVBHqE8Eoh
         ScC5VPJOp2QdrIez1tdNDs3MqU/7p+H5iSMm78rSX5M5bgpBIT5XAOQe3jyJnz595N51
         r/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753339883; x=1753944683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmwaqJ0idIWWPFaVblV/PRv/PAdctTYaz+oXsBak7KA=;
        b=QReyDC2KBMfao2hmpwaSXiilG0c10uECqK8aTgVALFVcmjgmRkqfr2++VOBmk5zelO
         DBDaJ9DBCVfVceP4GOKstNkosubIt9dlkiKaipFkBqGx6fb8woOL2v7txSqiiNQOP5dn
         IOXATdjkE+dLUs7Y49i8iX6oOTkGe+Ru47ah42APSBdUsDVbt3LdkPkJeiO+6sAQ7wVD
         EUXtdGFnkwlF34kkKoIRRdhsekhex+zdk3to8auvW60bhtbWo1AM5XdkbFpRxVia/mTO
         16AmG8fYicPiYivaq1hMTWkrm9a9pTXy9QPh2DIYY5YxCupZn8Z+UcmfiuhZ+vPj/JJF
         CYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX51RbMulijQescI+mR4rFURH+G4gwJefYN5rhNgmwF1G3vR/JdMHYYMvTs+Hs6DbUlyAeMsGE3W1TX3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwgT4RQd7pBbSN994Ce5Y0xWrtS6c1q7iC/npf8VCFOe716DK
	NrOXJBPWjyY6VkTO3ssmd11ejcRABYaXFR2OffbHxNlZQWLuBwrSC4+A
X-Gm-Gg: ASbGncsJnuYR+5i9GqLhQZVGoeR/1igh8axUFfTfAiUtr2rktDbXuFnT7c/EpgJNh/M
	a0FTqzPelyst1UJcxeAS19+cvtg4bM+TmEWUswATPPxblZ0iAdcFaZ1xb3obsxPDkI22IsqUma0
	sIeQAWBzHEF1/Fv1wzBXIga0D6/HPXUsXZt1P6UqCf6N2K/CFbw5+f5K+Ua5fKQgSBJy3hHKTiL
	O1EW7KC9xCXsVNrAE1ztkuVpP1dm8gSwp/C5E9OWejaOduPAL/kdLSYi91aO0GZOY39cYLaH5Tf
	k5ipVUo/JESwojV2R4kT8MQ0A145yA+d/HM/12ZCU8GBTr4i/G6YEv1dtVxGO2COBs5dy2JtlZj
	93V3wtcmx7pc8QXmtIggClUjtPrl+rN6cnsCTERke6/qDMwEAn0LwE9rd125qXTy9FTY9hdzwRA
	==
X-Google-Smtp-Source: AGHT+IFIO1kzZ1ykLgEz1gTC8/2bIF5rYMScWipWJJLSvkwaXYyDCnj5EHQLZcia2PleOm9+N3yq9A==
X-Received: by 2002:a5d:68c7:0:b0:3a4:f7e7:3630 with SMTP id ffacd0b85a97d-3b771359b9dmr449545f8f.15.1753339882734;
        Wed, 23 Jul 2025 23:51:22 -0700 (PDT)
Received: from nuc (p200300f6f705f800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f705:f800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc60595sm1169590f8f.4.2025.07.23.23.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 23:51:22 -0700 (PDT)
Date: Thu, 24 Jul 2025 08:51:19 +0200
From: Johannes Thumshirn <morbidrsa@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: skip ZONE FINISH of conventional zones
Message-ID: <aIHX5yG1tE4JCMPx@nuc>
References: <20250723133810.48179-1-jth@kernel.org>
 <3786245c-60d5-4567-a505-3c05ba8610f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3786245c-60d5-4567-a505-3c05ba8610f6@kernel.org>

On Thu, Jul 24, 2025 at 08:56:43AM +0900, Damien Le Moal wrote:
> > +	if (!device->bdev)
> > +		return 0;
> > +
> > +	if (zinfo->max_active_zones == 0)
> > +		return 0;
> 
> Should these 2 returns be replaced with a "goto out;"...
> 
> > +
> > +	if (btrfs_dev_is_sequential(device, physical)) {
> > +		unsigned int nofs_flags;
> > +
> > +		nofs_flags = memalloc_nofs_save();
> > +		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> > +				       physical >> SECTOR_SHIFT,
> > +				       zinfo->zone_size >> SECTOR_SHIFT);
> > +		memalloc_nofs_restore(nofs_flags);
> > +
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> 
> With "out:" label here ?
> 
> That was not done before, but I wonder if that is needed.
> 
> > +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
> > +		zinfo->reserved_active_zones++;
> > +	btrfs_dev_clear_active_zone(device, physical);

I don't think so. If device->bdev == NULL it means the device is missing and
we can't do anything with it. If zone_info->max_active_zones == 0, it means we
don't do active zone tracking on that device.

