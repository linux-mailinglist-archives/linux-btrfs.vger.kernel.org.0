Return-Path: <linux-btrfs+bounces-1893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B81840208
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24BFB20FE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E2955E4B;
	Mon, 29 Jan 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UM3si/uz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AEE41C63;
	Mon, 29 Jan 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521667; cv=none; b=DeyaZ+n/QrKh09lImbyHV4ummQkw9AUsqlw27w3O1e4Q8Z231uD6jtsxEeQCpnAF0uvvlZ2ua9i3LgQw2zIt1rNrWsZ4gnI3vbEp2Hnrp0+Cr6K+3ufI2k6m4DFfD6U2MXolp7G/+QDP/A471Qnvt9dinUHB/KuwGm3NHjk+uv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521667; c=relaxed/simple;
	bh=VBR7uHoh5G4bx356M7+wqgaO8/xBmXdJrn7Uz3rJrXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ceFMYS4wADgNE3Lr7AiY2P9gor5sJgUvWYDiADqpIeQ5YR5k9VQ/KruLZ10F9QmiFcDxDP8B78dnYQ+2KD3DN9TQQzTFllFSUK5o1evvVGSALN8KnfTuyVwE9AYiRH/Ubs4RFArQ3rG9JatAgeq4tMEAXmpGNFREme9mC6uYwfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UM3si/uz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706521666; x=1738057666;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=VBR7uHoh5G4bx356M7+wqgaO8/xBmXdJrn7Uz3rJrXU=;
  b=UM3si/uzuk9wzk7/1AR6iRl8NMahd8GHdLsM1Fg5lxXmfyXukbiFruu+
   G4XXzip2yNhktO0OwSF1H/VZm3hgNhXI/39c2hSWcwxRP+D9XBIl+I4hY
   VVKzhiVbSOBL6lxoq1YqgqayNN3Qo/4GLatWSqM4TZekaQesXn3pVo2Pt
   WxNFJmN6rR3dC2oKCMJ6u/YTZu1ovojxpqP2GFpgx4cfYaRIOITf4yKCJ
   tJdfD2kOPJy1Z179AhkFg5YMXM6hxmFHiHLL8m0Am/InCrc6n2Q340Sr5
   X6MXMeBb0EK9jUjnGHgStr9gOW8abpQbtomGHI1waS7Si9NWZzmEfjBDD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9652174"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="9652174"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="787778209"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="787778209"
Received: from hbrandbe-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.53])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:47:40 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: David Laight <David.Laight@ACULAB.COM>, "'linux-kernel@vger.kernel.org'"
 <linux-kernel@vger.kernel.org>, 'Linus
 Torvalds' <torvalds@linux-foundation.org>, 'Netdev'
 <netdev@vger.kernel.org>, "'dri-devel@lists.freedesktop.org'"
 <dri-devel@lists.freedesktop.org>
Cc: 'Jens Axboe' <axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'"
 <willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>,
 "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>, 'Andrew
 Morton' <akpm@linux-foundation.org>, 'Andy Shevchenko'
 <andriy.shevchenko@linux.intel.com>, "'David S . Miller'"
 <davem@davemloft.net>, 'Dan Carpenter' <dan.carpenter@linaro.org>
Subject: RE: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
In-Reply-To: <963d1126612347dd8c398a9449170e16@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
 <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
 <87sf2gjyn9.fsf@intel.com>
 <963d1126612347dd8c398a9449170e16@AcuMS.aculab.com>
Date: Mon, 29 Jan 2024 11:47:37 +0200
Message-ID: <87il3cjwsm.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 29 Jan 2024, David Laight <David.Laight@ACULAB.COM> wrote:
> From: Jani Nikula
>> Sent: 29 January 2024 09:08
>> 
>> On Sun, 28 Jan 2024, David Laight <David.Laight@ACULAB.COM> wrote:
>> > blk_stack_limits() contains:
>> > 	t->zoned = max(t->zoned, b->zoned);
>> > These are bool, so it is just a bitwise or.
>> 
>> Should be a logical or, really. And || in code.
>
> Not really, bitwise is fine for bool (especially for 'or')
> and generates better code.

Logical operations for booleans are more readable for humans than
bitwise. And semantically correct.

With a = b || c you know what happens regardless of the types in
question. a = b | c you have to look up the types to know what's going
on.

To me, better code only matters if it's a hotpath.

That said, not my are of maintenance, so *shrug*.


BR,
Jani.


-- 
Jani Nikula, Intel

