Return-Path: <linux-btrfs+bounces-5450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20F8FB8C9
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3621C22464
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0A1487C6;
	Tue,  4 Jun 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BDyq+eDh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8733F6
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518295; cv=none; b=DE0lT1dgFOjxQA0hGZXzjBGxOKCj6SRf44+8L/nLQaKxmdx3fhLij7nt49iXb7nqFjhpZziKL8PUaNB/c+33Dlcvkx3hl2JbqtW76Zprq9F+ERJ7opcQ10KRfXM9eRGs1lLz1ApEwwmtLKmrfWRE7e8DTAtLEJU+vsFeq5RWXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518295; c=relaxed/simple;
	bh=SLweL6pr/eLuEvfm4SJVxo+XM2tAhl0druAaSRx7nWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8/L3bnl/zyMz0dBRiCXm/oCvYZazVOhfZ1jMi6DfsJak00XtoV10NfYyLeR7KdZiD/xHQEDGfYVNpVN1LUHwKBBvs4+ZghAjv86lHBqHhQUOH5z/9gBdSgSJimsxQH+CO6AHXQ+Vby/A8R2ijURRD5C+5jUkCUGP3aURarYu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BDyq+eDh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f480624d0dso45876105ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717518293; x=1718123093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZS9bYGZsEYmlENK5anFyQ2/4GlxMqTKPAztcI/7ajs=;
        b=BDyq+eDhUOJDRXoDyjyPEOrDTKwMyyQ00z/ecNkm/I1sBX3sNTe/m80Y/VB9dD2Al7
         LmHpMRDK2iKua4Qe+xyg/iIBcWTU5wm7a5sK2mlfHEkpvRTPdLV45nA+C1QPtcDxg+QC
         yFH5mDdGjY9gmaN4dMU+hQ10rFOo7lPu1Sa4YlsKv7KMUPuLpPfgGZmJBzoSmPvq7Gqo
         UoC6OmhCudP54FXdqqXeOdaPEAR0ciHTsAeGUkeq4NEsUYDECVwNjzpAx324lX4RJd9T
         oK2pDbNJiT4tR8Oq/OobbuLUq/6k7mjOJB1mWOAXAGijHElkt/Qh8GOHY1wV++VWkK1Y
         gi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518293; x=1718123093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZS9bYGZsEYmlENK5anFyQ2/4GlxMqTKPAztcI/7ajs=;
        b=jPM/E9QNeotHx7Gv68GKuwRe4gk8IAatY8rtH+VNsFSO/ZUmSFQabxIUGR+B3s4ujJ
         yol+HlvpIu0VxXaRBS7TZkUXHzHq2y1h0i2FPsbZK42mVj0V8aOWI24LhCl6DsVzUa9a
         TfO/p4AL1iWGnbkHiZx3IYM2MBihf+QQaIv+MBvvGPPtGStFhPgH9B1MItTQmBx1M9t1
         MT9RiXl1Fwn2dqd8TUvGEaUQzSGzhdmF0u2/3a77OMrUqR7pEIj/NIEws3028KXp2lR8
         /36QkzPBKEdcXWbcCexMTfcbyHAlZN6E3t1+xpgHAWwPfHYBwl72NyS1njJ7LmS8cg37
         h4xg==
X-Gm-Message-State: AOJu0YwZkkoANHk99Kh08qWACFhfHktfQP+Vxsqiv57Iq7sztcSpYhGX
	FKvD/WUGkSXoi0RqdPpwePolUqlA1uQ1GKiAr2DEDbxcfoH2OHBDwmXRUIS8D7fqOHt1lNqspKC
	i
X-Google-Smtp-Source: AGHT+IHnaWO5A7p8r4F+3M/ZUA1+V35bOYiUHLVeAmywTbHZVAIp3jidnfhgX+WDoG5MOXx35bNMpQ==
X-Received: by 2002:a17:903:2341:b0:1f6:6ae5:143e with SMTP id d9443c01a7336-1f66ae54a37mr93720705ad.65.1717518293447;
        Tue, 04 Jun 2024 09:24:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:d3c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6553aa344sm63118955ad.239.2024.06.04.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:24:52 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:24:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix leak of qgroup extent records after
 transaction abort
Message-ID: <20240604162451.GF3413@localhost.localdomain>
References: <0a4d66f6922f5219c7c8c37d88a919304abdbb55.1717416325.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4d66f6922f5219c7c8c37d88a919304abdbb55.1717416325.git.fdmanana@suse.com>

On Mon, Jun 03, 2024 at 01:06:13PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Qgroup extent records are created when delayed ref heads are created and
> then released after accounting extents at btrfs_qgroup_account_extents(),
> called during the transaction commit path.
> 
> If a transaction is aborted we free the qgroup records by calling
> btrfs_qgroup_destroy_extent_records() at btrfs_destroy_delayed_refs(),
> unless we don't have delayed references. We are incorrectly assuming
> that no delayed references means we don't have qgroup extents records.
> 
> We can currently have no delayed references because we ran them all
> during a transaction commit and the transaction was aborted after that
> due to some error in the commit path.
> 
> So fix this by ensuring we btrfs_qgroup_destroy_extent_records() at
> btrfs_destroy_delayed_refs() even if we don't have any delayed references.
> 
> Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/0000000000004e7f980619f91835@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

