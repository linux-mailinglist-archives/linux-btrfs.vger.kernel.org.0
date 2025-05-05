Return-Path: <linux-btrfs+bounces-13647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD50AA8F9C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 11:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DB01754C1
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE02D1F8908;
	Mon,  5 May 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="dhzlduoF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ab3.no (mail.ab3.no [176.58.113.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB01F4626
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.58.113.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437477; cv=none; b=KX8hgeMfCidlb2OvQu9k12IHVugTfpg0wOkIFyv3h6fwGtzGDM9L6tPQ4iUCj3H5hqKpWjPnTPb8Gt4FS5IswrqMr0BEWvs4YLmpMREsm/XdTDlJQBIUN82KfZZVKR3O3l1u7QBSQo7T6XzwgvNN+7+pQAUGhm3ZfRcOiC2yGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437477; c=relaxed/simple;
	bh=t9NdsSgevIzrVLqkxi3kRju7axWO0qhCwn3bkaToodU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oqw7TGVZBZ/E4ic3zOyT8WL5Q/3x23dCsWJ4TR0kqvJDdV1bPVtygEEy+Au01hJILBZ8UWdOZkmE1eI7E0K40eUaMDzInuE8OeSw2XZnchNvBjoWc4CcLnYibt22XO51d5rZgp7EZ/FcPpbReMUxqVDehLbqN5Cq1ZCiBPzkz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ab3.no; spf=pass smtp.mailfrom=ab3.no; dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b=dhzlduoF; arc=none smtp.client-ip=176.58.113.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ab3.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ab3.no
X-Virus-Scanned: amavisd-new at ab3.no
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no A28CA4DE05C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
	t=1746437472; bh=t9NdsSgevIzrVLqkxi3kRju7axWO0qhCwn3bkaToodU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dhzlduoFNGGGkGthAQIgdzpi12/XAO5njyyYZj/og34uaMUcJ28dJFjsAs4WIIkvx
	 pVEK5Gcgh6vtOLexqUPhwO7UjZuWudh9BAu3Rv/GYDKSRuSFZvufRbI1Cn/GXS3zrG
	 p+uVmQHTL/v9YTPvk3OydhNQEPa2MUipL5rx5yxY=
Message-ID: <dccaa082-9512-48e1-9c86-95e0b7b861c8@ab3.no>
Date: Mon, 5 May 2025 11:31:10 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BTRFS critical (device sda): bad key order, sibling blocks, left
 last (4382045401088 230 4096) right first (4382045396992 230 4096)
Content-Language: en-GB
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
References: <c00b7f69-6a21-455b-aab2-dafcd1194346@ab3.no>
 <6ced26e8-ffae-488f-b910-f332f1190430@wdc.com>
From: =?UTF-8?Q?Mads_L=C3=B8nsethagen?= <mads@ab3.no>
In-Reply-To: <6ced26e8-ffae-488f-b910-f332f1190430@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.05.2025 11:25, Johannes Thumshirn wrote:
> On 05.05.25 11:00, Mads wrote:

> 
> Out of pure curiosity, why raid56? It's not supported with RST yet. I do
> have a prototype but that's only supports full stripe size writes yet.
> 
> [...]
> 

The plan was to (later) test out converting the filesystem to raid5 or 
raid6. Since it was a feature which I didn't know if changed the on-disk 
format or not, I thought it was wise to enable it - as in not make it so 
the fs could not be converted later. But it was pure guesswork...

Thanks for the quick reply!

- Mads

