Return-Path: <linux-btrfs+bounces-7050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8A394C19D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 17:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C801F21AE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F618F2F4;
	Thu,  8 Aug 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b="rURs+euO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4418EFC4
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131641; cv=none; b=YTDsxoMj5lj2SZlU+vFuMgNg+5UINtCLF1umcpshlsLX363EliQEYQbnj+5uH9r/63JOv44DEPugFa221536PRaP62H0nVbeAM6+0z9A5paO8e97kAELVHCz61GzKN23BC5uDpfIc5HQ2dOk7d39kaQneun+7CMY9iqtXpI/Tt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131641; c=relaxed/simple;
	bh=MU+CI77u32Ntm0M3rWQw22qP4R2f3D97HGJViJNRlmg=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=E9M8wG4TtlPWGBE85XgkmpFfp0OS+Ck411E4bnHYRP+AIgtKD69fdMt0JNYyS8IiwmM33R97reQxSmOBgAvWvOgbWszJZzGc+obSCbtGBv3MpQUFZI9byveEYDuzPbxXOqEhCrSrWNHzPp2jWzM+aSuNwPL0b21xzFZh0jpq6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net; spf=pass smtp.mailfrom=dirtcellar.net; dkim=pass (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b=rURs+euO; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dirtcellar.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dirtcellar.net; s=ds202312; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=6bDvhXep2Jihurdm3ezm2hpmS5ySo8/lb5buERSlrLM=; b=r
	URs+euOzwnvuhGoogmVwcLQKLb3SK3mIdqNl9AeRdLGSE/nI0yf59PmoWi/zC2INtN4MeZNaKDO1y
	9JaUyiFwUqGH4jCmPU6P8RHNhKMrsw2yoyqZZNzNdKOfzOWYR8IcW6b7/kegNzuEwqSmGz8BJIk3W
	c2/WBu7HmGOWWyYx53oB2l/VpcqZxnWY+9fNf4+kKSZVKkOjEO7ycH77PcZJ5n8OX0DQUM6lOY8Ua
	5A7vZ4lYBy2BvdkPveJJphznJKAwstetXrEgDVb4jnwlgiGmd3P4LrLxvlACAT7S37XVjXzY0Wok5
	2vfVSXzpSLF3pn75jb++T4IfCh1hN4FyA==;
Received: from 203.92-220-130.customer.lyse.net ([92.220.130.203]:29808 helo=[10.0.0.100])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <waxhead@dirtcellar.net>)
	id 1sc5Ff-00Fi72-Dg
	for linux-btrfs@vger.kernel.org;
	Thu, 08 Aug 2024 17:40:31 +0200
Reply-To: waxhead@dirtcellar.net
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From: waxhead <waxhead@dirtcellar.net>
Subject: Round robin read policy?
Message-ID: <87c646e8-c27e-6853-feaa-38b480892d60@dirtcellar.net>
Date: Thu, 8 Aug 2024 17:40:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A while ago some basic framework for the READ_POLICY was introduced. 
(Personally I think it should have been implemented at subvolume level, 
but that is another story.)

Anyway , the only implemented read policy so far is PID based.
This does has it's flaws. For example a simple operation such as
"btrfs filesystem defragment -czstd -r -v /usr" would read all of /usr 
from only one device which can be many gigabytes of data. For peace of 
mind a proper scrub is the only way to go if you want to make sure all 
devices contains good data, but that can be a hassle as well.

If however a round robin read policy was implemented, the same operation 
would exercise all devices in the filesystem and kind of work as a 
"cheap scrub". And while this would of course not check all the data on 
all devices, and therefore being far from a substitute for a proper 
scrub, it would still be a reasonable good check of most of the data 
anyway. Especially on systems with a low utilization and in any case, if 
redundancy is your thing, it would be better than the PID approach as I 
see and understand it.

(A round robin approach might also be nicer for spinning drives, both 
for some wear leveling and ***maybe*** for increasing the chance that 
the read/write head is not too far away from it's next seek target.)

So not for performance reasons, but for reliability reasons. I would 
like to ask the btrfs devs to please consider adding a round robin (or 
even pseudorandom) read policy option to the existing one.

As for the technical implementation I not familiar with btrfs code, but 
maybe something as simple as adding the chunk number / unique chunk 
identified to the mix would ensure a somewhat relaxed round robin method 
that can be used. I would imagine something along the lines of:

preferred_mirror = first + ((current->pid + current_chunkid) % num_stripes)

instead of something that is probably more "noisy" as:

preferred_mirror = first + ((current->pid + rr++) % num_stripes)

So pretty please with sugar on top... would this be anything worth 
considering?

