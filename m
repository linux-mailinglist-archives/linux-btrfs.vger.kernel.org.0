Return-Path: <linux-btrfs+bounces-5473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA078FD18C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2B284553
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151C45030;
	Wed,  5 Jun 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XB92GeNL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5317BA9
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601045; cv=none; b=tkXtcilKtXQirDqYpfvDqaiWFmBRpNY5mlup312AWdhFmEdDOnpgNMP170eQ2FzqybtSaKFmpCyAUpbXzPbvd5dwnSlawDRjUCw/tmu+7RO0lLwsfRUYJpGD9Eei6tx2OfSyXHmtzuQ3HVzTOcjbdHmtn/S6AgVb8JTlj4+uRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601045; c=relaxed/simple;
	bh=fyKZVrxnb19wAZd+wS9Qee4peZaM72NJY9gfu6UrMKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQTX1n9b9okzIGtenJ+3PJxOIg2vyViMGgEsrXi8lFGb8RbxEZDMAtlJwj96J8Kvvltaobn1JjatEEvr3frJu6JbQJf3UnOsS6TDwPIzrg5aRkkPlP3g7dvg1gr7pdba5TrvWZYQAbfz2wGCtB+iU9oLtf4t84tF2xLeXOD+4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XB92GeNL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f480624d0dso55319765ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jun 2024 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717601043; x=1718205843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KIdiZk28aLIk2SwF7AkSntfyzB45M9XoE+nRdS4lqbc=;
        b=XB92GeNLqVr6E6649LJh3I/+95RlJP9N1lERpvF5OKMmhyE3pyM+c/ZB8io7XsicTb
         hEmNmTnSymLE9iZhAMUxMDnJGtqD0BNyTayfG0Cl7cr/EuXG0IJdgJVZwTuJn9c4iGbw
         2xVxrmSWQVF5TVYF+vDstQauovTBMyXlZCItuJLsTX5zymnjKhMGe7QxstUPZoFAchbE
         6LEqYIaD1wNcwcxADsATBaQJHSZNUtjxAw6IjPiGIjVYDEEhzyOteJKMEBruHmaOKFzs
         0hCXYsEXJhRBEEDXceqht/GW+lLolYToUJFvdv9q78yo4bCj/Z0tr7RQVcnUIk9k0ZBd
         r/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601043; x=1718205843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIdiZk28aLIk2SwF7AkSntfyzB45M9XoE+nRdS4lqbc=;
        b=VdP3txKB4l3lbhnfD9xWebrrRQts0hIYvKxxWk+fSPvAbDtJF2ANyDQEMAFJQ+mIgL
         vOzqr6WlKUW/co3GSPfL4NjHovkPP2MVGgjEBAHupSQsP/iyDNsPEiUKhEQkqj1pGaf2
         JoG3Cm4AsPOGZIwFWzQ2L3Uea3QmKqYvarguQRaGyXqfKB9r4CrZyfEJKuw5N1kaaXE0
         Mt7BCI/8YTarQKglot6B+xKzQhlEYU6z3/GPM7ijUuH+g+0IduIZMdwQDBXdK3/Rix7j
         qCzj44/NqvMG1wfHaFNSoV57t1hYIK07jLsQzU23QFz2+nsxe5aYophSUs6Vpmi+5LK9
         5mvw==
X-Forwarded-Encrypted: i=1; AJvYcCWQE8iFdp97WcrHhOmX9QEbyZClweFGySmW7jl+8pwM41WL2LrW6iEmJcKbgfCIJwSYVrPMmXITxJN3Z2vvgE8eCFcK9fON3Z8NYQQ=
X-Gm-Message-State: AOJu0Yzx+ljGx7sBC/gdqLj0JF9wJEz/6CB8MM5K9zLewmDABs+s9jGS
	a4TCiQNmSktgH3u6+rSr/CNcsnOAV8NAhbU5ynn1XPy/wiUKFWSz6K1HPDFKHA4=
X-Google-Smtp-Source: AGHT+IFV2ykq+wbolHyk9+Ehy8q1rCvyvcCX9MBb8SDPCRwFekka1jLOv/CEQKw5a02IAYUeRVtUYA==
X-Received: by 2002:a17:902:d4cf:b0:1f6:3721:bca with SMTP id d9443c01a7336-1f6a5a0de3amr38810515ad.15.1717601043136;
        Wed, 05 Jun 2024 08:24:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:eaa0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dde8sm106368805ad.1.2024.06.05.08.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:24:02 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:24:01 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print-tree: do sanity checks for dir items
Message-ID: <20240605152401.GA21567@localhost.localdomain>
References: <0279bccaf02bbc09d6ac685b37e36aacb60bf9b0.1717476533.git.wqu@suse.com>
 <20240604155813.GC3413@localhost.localdomain>
 <c53aad22-ed68-433b-9dcc-c52f1c2fc73f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c53aad22-ed68-433b-9dcc-c52f1c2fc73f@gmx.com>

On Wed, Jun 05, 2024 at 07:46:49AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/6/5 01:28, Josef Bacik 写道:
> > On Tue, Jun 04, 2024 at 02:19:08PM +0930, Qu Wenruo wrote:
> > > There is a bug report that with UBSAN enabled, fuzz/006 test case would
> > > crash.
> > > 
> > > It turns out that the image bko-154021-invalid-drop-level.raw has
> > > invalid dir items, that the name/data len is beyond the item.
> > > 
> > > And if we try to read beyond the eb boundary, UBSAN got triggered.
> > > 
> > > Normally in kernel tree-checker would reject such metadata in the first
> > > place, but in btrfs-progs we can not go that strict or we can not do a
> > > lot of repair.
> > > 
> > > So here just enhance print_dir_item() to do extra sanity checks for
> > > data/name len before reading the contents.
> > > 
> > > Issue: #805
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > I'd rather not duplicate this check.
> > 
> > Is the print-tree coming from repair?
> 
> Nope, it's "inspect tree-stats" subcommand, it's just really printing
> the root of each tree.
> 
> Remember we still need to call "btrfs ins dump-tree" to analyze fuzzed
> images, if the print-tree is as strict as tree-checker, just image how
> miserable the life would be.
> 

Ugh good point, ok

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

