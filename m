Return-Path: <linux-btrfs+bounces-8171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A9197EE18
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 17:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3021D1F22125
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA2A19D062;
	Mon, 23 Sep 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zMtmXmEG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4680BFF
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105229; cv=none; b=JbDoDk+8+Z6qCsfBud6TXSLPCGPx6HNyBI7HecBiC0bFAu1mFwa26Fh0W9pZ6AJDfbEbejCPNAWOEAx3L2ljte9WUX4bJJCHt0A8eO0/bi85Dv0en6zuV4G12nqsICR2epziirMUcrpLRmAiY7NezaSMHBhTkfY4nb1SAO39B5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105229; c=relaxed/simple;
	bh=tJUXWdegHNrjMWzEHk+7gkJQiUxiqqNUnvDEEJJNr20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8hoQI5Tz8+3t663DVb4Y5lcCoiWXuedrBdfkEX23VkFhIxPKaQhT3P7AYekJxgNGb2HTNPiEI3+2oXK7IvMX+hai4c2vYWk0JNNOcEGC3rUUU4SMvwcB1A4FULIuwHJRPmPBK1pQeP8eTNRGI4eq1It8tj4/g9HjOFCoTyKhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zMtmXmEG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ddd138e0d0so38883177b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727105227; x=1727710027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNHsKrWK3rwhixkAQfutaQ51LoP3XAtSgBxc65VCxxQ=;
        b=zMtmXmEGQFDDZTn70ypaqprMGvr8tbhPVQNnH8v2wZq6ixhkWuZ/4Aoi6kzMolpneB
         1a6z65sTBuGdpDlwMD6pjyO/kmDmnsIEHpASeGLMZbewvQpiFmaFAF64PMZA4lSDAwvC
         HV/6ECTSQgTOSU6BI/JKj1cAiqDhS7e8UoPH04cqX5NBMjSiJTR1PkXr3e7AGDGxXnR2
         +6nsXiWOA75YJo+dJI0iqoimkQvP5tdbwHA/S14m1pIS2cXuifAIRjEn2wr1Y+hpGi7g
         0kbA371pMAdFjwVP6szSBVCHRxgTC0QGJQc4GxNnm6Bmq+/0YmWxzmpqdbYtUDWv6ESU
         oPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105227; x=1727710027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNHsKrWK3rwhixkAQfutaQ51LoP3XAtSgBxc65VCxxQ=;
        b=rWm3+XzGqkAndGficNqbvk56ALNmgH4lH5GHngYZV1LO0pG99WvtcUk9SQPyjYKMzp
         XD0fiTePz49qnDg3dUl/BdL4oJE/OCbcfzXQIetnPPn5SiI4bHALzf4AUs8Pv1E5KUHW
         EXHBao6TsfiFzx32R8aCdW6GNa7TVFBKYp2oZR5OMIq0VkOxMUZjbnIlVC74RrTNHq7p
         4r5BAzT66rma7IuPCRnRcXgFW3+Dmc1xKYwW0nsXzIAwq1JRdK1QO6HSPX9Sc7S/JPr+
         U8v0BzYIto9j//asCBd6sbDJ+Azqu93vzZLlLRNEfh+SBIHH7i4GPpq73N/TQFrcJSna
         9Lug==
X-Forwarded-Encrypted: i=1; AJvYcCW9JUsM6sYQBaDF0W8bj79kFKvvyWF6AgSK172ADI3Y1nw4PU8pUTtyrhSvnW/ow++oPUQ1qVbTxGwDFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhxLfe+u9AwndmOkRQR9Gri+Ry1cBp2cIMAnIGSzqqTmdv9qSr
	rjen9sl1yUaOA5RxSNvNfVSyZo1By1of2BEjpPGAHk93PZFkzAM40Q4noh3rx2Irh56xWExTXAu
	y
X-Google-Smtp-Source: AGHT+IG1uKV2d9hNeFr5TRtvfJTjocy7scrO5P8LzjZrrJY8JjwBBcm0JQI35bWKs1T+gsuGmlsC9w==
X-Received: by 2002:a05:690c:748a:b0:6d3:f171:46f3 with SMTP id 00721157ae682-6dfeeff8acemr103120037b3.41.1727105227286;
        Mon, 23 Sep 2024 08:27:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ddbafd084asm33349367b3.130.2024.09.23.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:27:06 -0700 (PDT)
Date: Mon, 23 Sep 2024 11:27:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC 0/2] Add dummy RAID stripe tree entries for PREALLOC data
Message-ID: <20240923152705.GB159452@perftesting>
References: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
 <20240918140850.27261-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918140850.27261-1-jth@kernel.org>

On Wed, Sep 18, 2024 at 04:08:48PM +0200, Johannes Thumshirn wrote:
> This is an RFC implementation of Qu's request to be able to
> distinguish preallocated extents in the stripe tree for scrub.
> 
> It's not 100% working yet but only showing the basic "how it's going to
> look like".
> 
> I'm not really sure this is a better solution than returning ENOENT
> and ignoring it in scrub.
> 
> A third possibility would be to do a full backref walk on
> btrfs_map_block() error and then check if it's a preallocated extent.
> 
> Johannes Thumshirn (2):
>   btrfs: introduce dummy RAID stripes for preallocated data
>   btrfs: insert dummy RAID stripe extents for preallocated data
> 

I don't like this approach, I'd rather have a RST represent actually written
bytes on disk rather than adding entries to work around this particular case.

I think that -ENOENT from btrfs_map_block() is liable to result in weird
problems wif we return -ENOENT for other operations.  I think that you change it
to return -ENODATA so that we can for sure trace it back to RST, and use that to
indicate that we need to skip that extent.  This way we have something that is
unique to RST, and we don't have all these other entries that are unrelated to
the RST's job.  Thanks,

Josef

