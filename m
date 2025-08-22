Return-Path: <linux-btrfs+bounces-16286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED690B318A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 15:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE159B62DC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E73009C7;
	Fri, 22 Aug 2025 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVUXzU40"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5952FF156
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867542; cv=none; b=XraeWom/at1HfyhlSyXW5jY9eWFb61R9VQtCfey7Ocy6OqktIWqpCPnagRxIhVGjOWp2VKu5HPdjEz8Sy/v51jLhT3o7UaOPsdXiUuxYhlTzb/7tN0MLAPOGUMhSAuMkx8M6nvTIJrN3EsWiI+L4Ilqdcclj8QYtp9SPSgUcxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867542; c=relaxed/simple;
	bh=uBxqlK6N2Cmt31RwxcXSKCnw6AzF4sfY4O48Ax/gvOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=u38Z+gTUSDCZ7q5NYH0aMCnuANJTYfJ/9e5hBUtScf1NcoSqjWShzKzLB+TikNPaVFdoGfIqPsXKhuluWOv08FHZpljh6inolNLFhsg97dczGfyjgWo01F2M+XLtVHqbAZ+Oqw5SaiZSFYKo2WBCiooRb0hh20S45ZwisuPHe0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVUXzU40; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-246180dc32cso2906955ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755867540; x=1756472340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6diVvyrfXK7dThO1rtUnEj51jro+Xi7k3C2REQCZpo=;
        b=aVUXzU40YNil9iHMAy22JK3isSfH5gTv29fI3z/COyjpXo5EDbGfh8Z4hdEOW6WFjE
         q2jSwRLNVndElyTVDC1YpIcxgO4p5r9CLcs/E7rPgQ8h5BnMbHeGPalPGrYpZcuV9kdH
         +byhi65EnkBAJpUWTqyrrEWs3zz6g86sMfSoIgyvYt9PDuNSumMqPnBw6GQVC8NqTgCW
         uWNzJnYpTRUfG47h0nV0pgW235SqAG2PLz2HmyHFMXIEs+7Oy0fTKTcCWXtv+ARFyt2x
         QftBs8yQ0IVPcnlu4XQeRONn7Ly4cKNwQIMtC5RiAL9Agy/6hZmIRR7xyvUI0xvaNA5j
         Cljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867540; x=1756472340;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6diVvyrfXK7dThO1rtUnEj51jro+Xi7k3C2REQCZpo=;
        b=RNaAB2LuzXltu3oEiWJTXl14A0LcuMCui+e9+M1VquA5NnRqGxERjU+vAHcr+wA+5k
         ExbW5qRkoJdmHgc7if5qGRw2QkNitUMGdUIC19a/cmMRi12r9nPbflNhzCLwKLJkIWBe
         Vqa9TdSx6bgAvylEmU+1R5pvuh/bsVzKgcio2OW3uk4JNsbUK9g4t7Y9WpyxBNVwvcYr
         z/sDWYF98TyYs9BPFX2aoO/tWt93EGex9R1OTGrEtD0cW/BKEs22lEDmSQhcvjc+cRM5
         in83MYsaBS5aRlKhv7JYuxM0Yb9e4sAw/0GgBfUuU7rrxrCepzc7tErJ0TbXiPTvyQse
         ix/A==
X-Gm-Message-State: AOJu0YyF+zijPX5gAOH09wHqXvgRqR1HZWcne/CmJ00fyALrCLX1TAfu
	+8me59LsM9+yU8dgvZOKaEWnklO59EX/b1sBiDL5yr7KDyb2Ff871wkr
X-Gm-Gg: ASbGncvfQf/tfUypeLFb5v9Rzn+DIuxVyVU/iHTj6f+x7EG9IGfnzE1UypMThiGzeUz
	LI0iJ42dU0AjJp0oerewgcilUGVdxVLoVvZw+1Gv+Konb47ZYfwrDa+6mBlY3hz4XvyMmQESH5d
	D1fNEMwGusx7SoyBlBiIUAoH3BVOWETgAX9MF/uhdqA2baSSzaPGIM9R4grUv7A0YzoyC0Cerkg
	HtdoxwTwstoD5vh/AlItPoKxCjLUPwAeqtglTwbmzlo7mUzjdpmDV3oYj9F3KpHCbTdDS6LwFat
	GIvXNSrtpQa9DUOIVeiHPScHw2oh3kwISPfBQjvufOBKfDMUl65Yoy1+KBUfE9GhU2s0n6TyHoL
	+kOgVArGn0Tq7/K1A1vo+CDcnj8ctYz9MHAVILIxaNnLO
X-Google-Smtp-Source: AGHT+IFnIgX49tY9dfO4Mt1dGGZufPzpKFraEn/qyh1dMaq6FmTIa2R6rCtfALmgZM8uW+y22Wxguw==
X-Received: by 2002:a17:903:189:b0:242:d237:e20b with SMTP id d9443c01a7336-2462ee3033amr23707435ad.4.1755867540268;
        Fri, 22 Aug 2025 05:59:00 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.112.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c747esm83332935ad.83.2025.08.22.05.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:58:59 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, sunk67188@gmail.com
Subject:
 Re: [PATCH 1/2] btrfs: get_inode_info(): check NULL info parameter early
Date: Fri, 22 Aug 2025 20:58:52 +0800
Message-ID: <2255718.Icojqenx9y@saltykitkat>
In-Reply-To: <20250822125027.GU22430@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> On Thu, Aug 21, 2025 at 09:12:23PM +0800, Sun YangKai wrote:
> > Move the NULL pointer check for the @info parameter to the beginning
> > of get_inode_info() function to avoid unnecessary operations when no
> > output is required.
> > 
> > This change provides two benefits:
> > 1. Avoids allocating path and performing tree lookups when @info is NULL
> > 2. Simplifies the control flow by eliminating the redundant check
> > 
> >    before writing output
> > 
> > The functional behavior remains unchanged except for the performance
> > improvement when called with NULL info parameter.
> 
> Reordering conditional usually leads to behaviour changes and I think it
> does in this case as well.
> 
> > Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> > ---
> > 
> >  fs/btrfs/send.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 7664025a5af4..5010d17878f9 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -913,6 +913,9 @@ static int get_inode_info(struct btrfs_root *root, u64
> > ino,> 
> >  	struct btrfs_inode_item *ii;
> >  	struct btrfs_key key;
> > 
> > +	if (!info)
> > +		return 0;
> 
> Moving the check as the first statement will skip anything else. There's
> one call of get_inode_info() with info == NULL, in apply_dir_move(),
> otherwise all callers fill in a stack variable.
> 
> > +
> > 
> >  	path = alloc_path_for_send();
> >  	if (!path)
> >  	
> >  		return -ENOMEM;
> > 
> > @@ -927,9 +930,6 @@ static int get_inode_info(struct btrfs_root *root, u64
> > ino,> 
> >  		goto out;
> >  	
> >  	}
> 
> Right before this there's call to btrfs_search_slot() looking up
> INODE_ITEM for 'ino', there are 3 results, and two are still valid for
> the callers. Only if ret == 0 then the 'if (!info)' check is done.
> Otherwise it's either an error (ret < 0) or -ENOENT (when ret == 1).
> 
> So get_inode_info() is also has the semantics of that the inode exists,
> with the reordered 'info' check it never happens.

I got it. Sorry. My bad. I'll fix it in patch v3.

> 
> > -	if (!info)
> > -		goto out;
> > -
> > 
> >  	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
> >  	
> >  			struct btrfs_inode_item);
> >  	
> >  	info->size = btrfs_inode_size(path->nodes[0], ii);

Thanks,
Sun YangKai



