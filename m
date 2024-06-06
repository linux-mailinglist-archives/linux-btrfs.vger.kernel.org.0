Return-Path: <linux-btrfs+bounces-5505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8AA8FF30C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 18:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406231F2A01A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B202198E7F;
	Thu,  6 Jun 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="tL9rdML7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975F224D1
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692887; cv=none; b=IanwS3tbziODh1dMAEP2nw09KdPkpUWHBRkmIdeMWELxgb1ihs1ocowGZMKPMp7bcFpv3M+MV9rlDkxuENQTXyqzzMD0SId5+nW6PLd+mWTa8cAoX1LnVSN02vk8At3dvEamoIhLKFuhAlcCE0DuauNnSLIrlDw7yRDICv9zGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692887; c=relaxed/simple;
	bh=YD+Wd2hBc/cdkdO3mlBFfazKoYYVzUBziDVhraNCsIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmoIIXbKGDSMoUpWkKGCeLlBIIOpX2mybeJN8pq+j3JLnDveBR82ZM0LvFb0VnD0eH7iIlcWnguRjhmIR2G4JiG4kQuDGvlJ18b8I7TVPEWfSyBbpcBVo/L8TemRpJoUCWWtka4Bm695kBBOX2wHNMUKbFclAcz5ZjOt7QSTw0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=tL9rdML7; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6afc61f9a2eso9536176d6.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717692884; x=1718297684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+y+dl8aT5uPAs1eKPG+kVmWJwMw6JblJ8vF59gD+i5Q=;
        b=tL9rdML73qPgqYqyRj2cAb1vUI4OFNp/1y+AvdYTDQ5fTIlEJZc5w4DynpDgNvszrZ
         DwM110MVuxozer0Y7gh+o2GTH2aaVEp9Av2MPTUkdD6NgWH1JR3rrPqWfT5W4tkd0sj7
         e0p5BxEvEM6Yknk69rGHFn6+QZj03JCFu4spl8kyw1/FkRcr0lJ6F9Oe/73O05VPbv85
         /wNBZDZxmq2sG5IKHI3fycT/xXTr53NPrA0XJDc0AgeAsuILmNgxE03ea1gJoCBZxQWa
         m8fQG+tygeaPDDTbVWPjiN8AqeTrQ0xZBkWlCbTHJDAS8tX1WWPNwbz6y3oyW2OCx/U7
         60hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692884; x=1718297684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y+dl8aT5uPAs1eKPG+kVmWJwMw6JblJ8vF59gD+i5Q=;
        b=NsrvNyagu2W8cqSoQ2WJlmALKATUq5K36nMVGL+G6L/7l0fLvhyyl5OQ+qUePka1MA
         ZpBRexO+P9U5ajA38MTxlKIY0aDMYB/wAx0HxZ0WyPSXRE0ncSwFs6Mi/tLPqbSTPuhL
         H9tAkuQ+PWMJuu1FjtVyBnZaoR0jytT+qUhTh5Y+Xdic3lLtdtjsIkUcVYS69cTr5Hst
         n6W0RG412BLX46K/ercckXA528irO4yNAJOEKhsfN/W8STZHsoFFJRFHBrTw2Ye5Z6Yj
         09oGzjvCAX1TgwteixE7BV+OZkPRx/16hL+xHYjYM/uklk/5N3VgA+QX5VcLiESRp67p
         /tOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNR+UjyKFKubBwuPHklnJPMyZjErpPZNnmfDhz3EsUDZfw+gt40TPQPOvBKHMQ9Li8WMjf65eY/zQN1O2fMCMSLaUrbmJHWdjIF0g=
X-Gm-Message-State: AOJu0YzvIfddHzKDklEGn/im8ThzmyPXfTebabEG2QwbqIIBCHlQtCYm
	LhcWTdmGFKZlQaZlL1MaYFgn3S2i+u46qDiToQPAGPBNAJlEQypUrZL46nUJmVo=
X-Google-Smtp-Source: AGHT+IFAYcXMFI8o0MjOxBERg27z3u3kw0duCZYFs2U33NR29oDfLpQLlRfKGKgdE6Y2F+w+ln9DOQ==
X-Received: by 2002:a05:6214:3186:b0:6ab:996d:425b with SMTP id 6a1803df08f44-6b05951098fmr4622796d6.4.1717692884259;
        Thu, 06 Jun 2024 09:54:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f988c20sm7820016d6.98.2024.06.06.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:54:43 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:54:43 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 5/6] btrfs: pass a struct reloc_control to
 prealloc_file_extent_cluster
Message-ID: <20240606165443.GC2529118@perftesting>
References: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
 <20240606-reloc-cleanups-v2-5-5172a6926f62@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-reloc-cleanups-v2-5-5172a6926f62@kernel.org>

On Thu, Jun 06, 2024 at 10:35:03AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Pass a 'struct reloc_control' to prealloc_file_extent_cluster()
> instead of passing its members 'data_inode' and 'cluster' on their own.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

