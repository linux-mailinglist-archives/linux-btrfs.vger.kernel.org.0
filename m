Return-Path: <linux-btrfs+bounces-11770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 616A3A43FE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 14:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E503BF733
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 12:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C0A269810;
	Tue, 25 Feb 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YdhA+z7U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF3268FEE
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488361; cv=none; b=ZjTqkivxU2hnkAzPZ2uVvq1a2zSsaCHqw3mIJME0QPel5FecehOZOmBn3JcmLu37DpnQXUv6ttky4p745ZU2GdcePznkEXoylQPbNYbDYG3gGbV0JuoCx6sac7O25HK+JAYKYKeRDItbbbH0lq5lH5thle46IJnCvcVqOo3uWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488361; c=relaxed/simple;
	bh=QshVbSM0TlGRRooWWGrXwSW/K9vqcrxovLs/pTGnm/Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jc7vKjJmsBvumOAreYEM8ddexqt2sZJ2jEVlTRLGHgbyea7XgMN9BDwrNeLFIHcOGNsaTwSwoSdFgyo3HtliKZ8r6AxqRwEcpT205+M88p6i50YoVLSnDuFVFSWrtKyjd/4kbBgBUJsqW1EMXDU0qkJxok7OloaFi5d+gEfpjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YdhA+z7U; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740488344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYCRA4lOKUkv6A0x2e0ErFK6w+Mpd9VIqmWibbcbvD0=;
	b=YdhA+z7UcuRgwYL69v8xEUqIziVy4Hq21+nfUzRc3yoIts6qhj43w67T7JTgujjZvQRJ4W
	8Dtir4unbtjy/32nJNLRDgXquAxcGilKFu3kMPnxNO9Pm5PM9olV4fBm0srEVwf6pFxQX1
	t7I3ImQomGuBFsjWa7fNxRFh6XZeHEk=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] btrfs: Replace deprecated strncpy() with strscpy_pad()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250225122828.GM5777@twin.jikos.cz>
Date: Tue, 25 Feb 2025 13:58:50 +0100
Cc: Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 linux-hardening@vger.kernel.org,
 linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7144F578-88DC-46F3-926F-7652503149A6@linux.dev>
References: <20250225092949.287300-2-thorsten.blum@linux.dev>
 <20250225122828.GM5777@twin.jikos.cz>
To: dsterba@suse.cz
X-Migadu-Flow: FLOW_OUT

On 25. Feb 2025, at 13:28, David Sterba wrote:
> On Tue, Feb 25, 2025 at 10:29:49AM +0100, Thorsten Blum wrote:
>> strncpy() is deprecated for NUL-terminated destination buffers. Use
>> strscpy_pad() instead and don't zero-initialize the param array.
>> 
>> Compile-tested only.
>> 
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> I don't think we need the padding, so strscpy is probably ok. We copy
> input string to a temporary modifiable buffer and then match it against
> a table, so the NUL termination is ok.

Ok thanks, I'll submit a v2 later today.

