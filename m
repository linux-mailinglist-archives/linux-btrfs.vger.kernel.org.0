Return-Path: <linux-btrfs+bounces-14113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774D1ABBB38
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 12:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BD93A862F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97A52580D5;
	Mon, 19 May 2025 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ahtPnSJ/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF31DFD84
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650858; cv=none; b=LlQb/9Jpu6bS4s7cwyAQXorDiWaibI9KiMXAqxcCDb7xGlaOdz4AzwKsgnBF1J8ApiReamsrGcv62k9QG4aR/OYqwAtZieUvcHy53YJp72Nfi6aKZStRVlEXTfAaAa66IEGHqUBuKenSKO+kLinA+9D4wwnWVJ2K+l5a5knu4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650858; c=relaxed/simple;
	bh=OCiXCgXTsdRzlcaZtWeBhlKDQeWUe+XaeEuHpx1+3FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfWpYK2yF6MYPtLheBI0RXMC3fg0mlc1C7N4OvwRcoAFdyJuxJccG2OgUBiqbvsfZ0LWtB8SsQyuhqJtMt8/4U4nTFpoJRKVZaUqCSVqqOIuQYY6WBTJjct6j1TeGX/Dgy0/vbTCE0CzaR1lWJfP9RBRtzDtVXaRGAXvprb3D7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ahtPnSJ/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so683471366b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747650854; x=1748255654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OCiXCgXTsdRzlcaZtWeBhlKDQeWUe+XaeEuHpx1+3FE=;
        b=ahtPnSJ/Gc1ZTkiBUqsk9zNazJ3dOZXidTo+KO5ZxwHMK94OTuRYK8qSteP39a3ElU
         eRLLPo87GjdqptTPhEQXCSa/nxoJRzcNoXKxzc8kN1D1AGSJPTMLspsmkA+e+P1jHXwe
         khCwJiHEOR0hGahag+CxmDvNEh1N/UZBOasRuLsGAHn4p9/GqtvHz5lwpvNkGL8/b2Hi
         Xwg8joQWcW1hw/DNiex3aac0bGEZ2YdarTWsPKLGbgV5XnC0g0zuwZAyt8z9LUgcvXeT
         JjbkDdFKRCWmHlXYmBfBSmD7GSOSmtAblrQbzURH9d+JlCOUIChd/u5acZVGo1lF4bvD
         C1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747650854; x=1748255654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCiXCgXTsdRzlcaZtWeBhlKDQeWUe+XaeEuHpx1+3FE=;
        b=GWQ9c+09vtlHLAnK5mHzgwWz3XxbpZAYwKFEYD4moGdOE7XuVPPeb+F6JpaIBkWic0
         H+z89A/m2jIcJnZZDbfTqnlVj+9j3ddywpr+X/kTxEXc2tcywdBcz/MOI4Q6mWYQMtYY
         Enl1jNyxIxNIezWzGf45XHkpqyPXWixWmZOKe5MaeDgvoqGZwc+JN83ca1ceJj207pya
         bWVOv01flTXy6wp7hnoTDCvwK7tu7DcZh6nn/sVgbLpTDPC4IV0yceyIGPTUVez4OsXI
         k4dzwfdqUJao7GSjT5oMNrQd5meERFvcH/7M5mYNlUsM8fJf7hNj+AJ4sxrWUQGBnedr
         Rvqw==
X-Forwarded-Encrypted: i=1; AJvYcCWcohN6E2EzI4fO8MQNMkwNr4S+gk5rsxreos3QDTBF5bIoY5Jge5SdHq/jFymnnnMpN1Q0OnpsMzSeYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCvrUojQEdHU3pR8/TK5OMqTXiXXYIRiAC6yVwDjo8fkYQtEw
	lJTek9U6DnQL9YVlROFkLWvvOq/Yl5nzffB6IeDAvmgqC3qqVqYEaFj2Q/xPaBFqq45KnSrtPRt
	KBRR04oyt4ndaEFwVl0TirHATnENgl72sT7jkm+sGAg==
X-Gm-Gg: ASbGncvIXciYUKyFJLWNAEwSWqL6uoQTglZhdbyV2vEIRh+IA+NlZsZepU4c4btypsN
	uRFgvajUsDHzWCz5aVzpa5UG/RfZEE4lZDJu4vetIpsSQezr/PrMSsUsl717XAJZv+poqIdz1PH
	RC+kwi1stsZbV2A6YnpSUpVkxcqbfifCk=
X-Google-Smtp-Source: AGHT+IFDp8A2zyqmQfoHj5jH3cPFOL82cfvhbT89hIH6TA5DLkVoMIRPLMREfOyoE29O/ZDFknRlG6y9JUGlUCAi8RU=
X-Received: by 2002:a17:907:3e16:b0:ad2:3fa9:7511 with SMTP id
 a640c23a62f3a-ad536dce687mr1138427866b.41.1747650854046; Mon, 19 May 2025
 03:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514131240.3343747-1-neelx@suse.com> <3c08a5d6-bf17-4a74-a889-b1658a2a75d1@wdc.com>
 <ad599778-43c1-49ae-9662-ecd5b79292ca@wdc.com>
In-Reply-To: <ad599778-43c1-49ae-9662-ecd5b79292ca@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 19 May 2025 12:34:03 +0200
X-Gm-Features: AX0GCFvyJrl471zarGWZbjYduBBOoR_Tqci57jCpNqeeLfhsT5ctT_BHaSCe-gw
Message-ID: <CAPjX3FdLkt1DCmKkZDQvHOauGE1m3dgjP_3Jt-kHq7FDpjOzBA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: btrfs_backref_link_edge() cleanup
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 17:48, Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 14.05.25 17:47, Johannes Thumshirn wrote:
> > Looks good,
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >
>
> Hit sent too early sorry, I'd also mention in the changelog that it
> isn't used outside of backref.c so it can be made static.

Yeah, that could be mentioned explicitly.

