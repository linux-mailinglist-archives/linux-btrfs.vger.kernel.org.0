Return-Path: <linux-btrfs+bounces-269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC737F37CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 22:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC53328272C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE95103C;
	Tue, 21 Nov 2023 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mIQkeTVN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E51A2
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:01:44 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db057de2b77so5550612276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700600503; x=1701205303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0Mtot4o4Iv50p8GRxRR7oxPOP/8FQ0rT3lW5lbuUPw=;
        b=mIQkeTVNt1mdhwm3zoA2sJz0xAwwQeRKKz09vJod5/Fuw5SOTDcdKzNVm7GmZ2qyar
         PRwzI4bs7UmFX4w0LOV6renVazu2QJQcYIdifsSXVHxECSZDKQTmSvITduEZe6oqj3EU
         /37tkWEH2UCThcjVjFUqf83lbL2m3hHQ9Y0bup7mZTSpd9ecPk43yTLcULOOiiwLSRvx
         kwKHGpyOLTxpi2sbd24dnCsUsqE7/PVyVmmadrmT9r1O+6aSPXKSwKKjNg6W1ca10kJj
         msTM1rKHp73CRJi+co8MUqhg2cXziRbJuIAfuVfe842yJbkEEWtslvDejpB/5Vna+YyQ
         SoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700600503; x=1701205303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0Mtot4o4Iv50p8GRxRR7oxPOP/8FQ0rT3lW5lbuUPw=;
        b=A4JjeChUgdewXeUMikRyLlsaW69MLBVAQhzak1cvsvlh/8VMLwVmK4vdvh9AsBENOM
         RvLtPwWNrkNMFG0g2gsjgu0ZKOGcwN55nEV7nBzKwOVHmVZ48I1OozbXCHNONaaQ/nrP
         4CNum7dZfkTYf8DERWCL4ZgRDu8rKeXgHPR+qBphMaK9PBFdLIaD66CHw0XGkpRfn3DT
         VZfAqcl0kzEC7GOwsE49Sj0xUIHLuYRnXLQODR0h+4rs77/URCbAucD+az1tyPjd/793
         Rv/xnhhBg1GxBZG9972ds6Xq0PnhLCiUlgVP3hZ1A4fl/EIFhZ2mRuagmA3dKjOFo3tS
         zz3A==
X-Gm-Message-State: AOJu0Ywyi1LHrx45EQGZw/5Wqm3hAM/VDT0jwpc3pJdVm6MwKGhq6d52
	+I5orAGljD4s5+weC+P/O/ZbRYEx6zFEUxuh5DGTXKUr
X-Google-Smtp-Source: AGHT+IEHLwu5bZxVyWPESADsP4NWmSI7NnvdTQNabAOLg5JOWUP+SZt4Lrcs9tIEgRerSnc77E9Aig==
X-Received: by 2002:a25:e797:0:b0:da0:37c8:9f00 with SMTP id e145-20020a25e797000000b00da037c89f00mr164010ybh.36.1700600502794;
        Tue, 21 Nov 2023 13:01:42 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m204-20020a2558d5000000b00da07d9e47b4sm939035ybb.55.2023.11.21.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:01:42 -0800 (PST)
Date: Tue, 21 Nov 2023 16:01:41 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 0/5] btrfs: zoned: remove extent_buffer redirtying
Message-ID: <20231121210141.GB1675377@perftesting>
References: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>

On Tue, Nov 21, 2023 at 08:32:29AM -0800, Johannes Thumshirn wrote:
> Since the beginning of zoned mode, I've promised Josef to get rid of the
> extent_buffer redirtying, but never actually got around to doing so.
> 
> Then 2 weeks ago our CI has hit an ASSERT() in this area and I started to look
> into it again. After some discussion with Christoph we came to the conclusion
> to finally take the time and get rid of the extent_buffer redirtying once and
> for all.
> 
> Patch one renames EXTENT_BUFFER_NO_CHECK into EXTENT_BUFFER_CANCELLED, because
> this fits the new model somewhat better.
> 
> Number two sets the cancel bit instead of clearing the dirty bit from a zoned
> extent_buffer.
> 
> Number three removes the last remaining bits of btrfs_redirty_list_add().
> 
> The last two patches in this series are just trivial cleanups I came across
> while looking at the code.
>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef 

