Return-Path: <linux-btrfs+bounces-9594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD459C705A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 14:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6692281B3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5EF1DFE35;
	Wed, 13 Nov 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opsone.ch header.i=@opsone.ch header.b="dufVRTlT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.opsone.ch (mail.opsone.ch [185.17.70.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270B7DA7F
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.17.70.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503719; cv=none; b=APDw4AbYQP1vgYpu6Rnir67gc3QF6Oa6nznZqsJyWgElPq19qGvjEx1SS+lLhhphrD6CrnEqDgGIulv6FPNlDet3HY+ZEYCnloJgqaNU1oXZMUEk8Zyp4Wpp6U+4D2tIfISgI18VRzooId2f8oC/sjjhekgdA1PZ9Ol1oqmBw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503719; c=relaxed/simple;
	bh=LWFPV+MQdlToiCY9K13BNEzBhQz5GH/bBJ/v39sPi0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Du/c78VBAFKc8HcfYzJig8JkCpMxPXKjYgiiweHmlLYM4OfOrybhkM9FILuusun7RMx8EcFJ/pOyw/OD9rV7ca0BDUGNSE4vYwVzgPZ3OmkkdCVuZSvssvgNKhgbQhnSJyTKrRlK4yukKv4c8ZsxV7G9nSuOj4rYZFqqWMmZBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opsone.ch; spf=pass smtp.mailfrom=opsone.ch; dkim=pass (2048-bit key) header.d=opsone.ch header.i=@opsone.ch header.b=dufVRTlT; arc=none smtp.client-ip=185.17.70.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opsone.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opsone.ch
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B60215B7AEE;
	Wed, 13 Nov 2024 14:07:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opsone.ch; s=dkim;
	t=1731503265; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7QQw10ecES/+4qugxs1uEyyVieRY59wTXbhrsbCm0f0=;
	b=dufVRTlTRMltBj8WgSxz6lU9BVTdKnLGh8ICVXnXBMDzpw45pTA5vaXG7+IW6rK+na1Lsz
	AC5GkZ3NZQupvRLjnXvplp74z90c8qlBjXPEoolwREvkgmlTCyrfMNgR0x7PNmfN2XgW/p
	wfP5QHpSTCCmf71dXgRixiXjVwO/fyCAvWFd4J96NKzkKEVAVKzbnTVnvXntSSkI1L5SnE
	tuzO2+0WJYmLGKP1RmzMzqDAVWAn5wyzsZwQewJMqDOO951IFxt8Gr3AFhebDx2Z0OxjMf
	+A6iDUxNp8ok3CB44x0CIkjn96Fupy54coZz0q3V02Z5Cmq0ryxqeDdb0VbX4A==
Message-ID: <42062cf0-e5fd-430f-9aff-51a4bb9ca3ae@opsone.ch>
Date: Wed, 13 Nov 2024 14:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: send: fix invalid clone operation for file that
 got its size decreased
Content-Language: de-CH
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
 <794af660cbd6c6fc417a683bfc914bbf9fb34ab0.1727434488.git.fdmanana@suse.com>
From: Markus <markus@opsone.ch>
In-Reply-To: <794af660cbd6c6fc417a683bfc914bbf9fb34ab0.1727434488.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Am 27.09.24 um 13:03 schrieb fdmanana@kernel.org:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During an incremental send we may end up sending an invalid clone
> operation, for the last extent of a file which ends at an unaligned offset
> that matches the final i_size of the file in the send snapshot, in case
> the file had its initial size (the size in the parent snapshot) decreased
> in the send snapshot. In this case the destination will fail to apply the
> clone operation because its end offset is not sector size aligned and it
> ends before the current size of the file.
> 
> Sending the truncate operation always happens when we finish processing an
> inode, after we process all its extents (and xattrs, names, etc). So fix
> this by ensuring the file has a valid size before we send a clone
> operation for an unaligned extent that ends at the final i_size of the
> file. The size we truncate to matches the start offset of the clone range
> but it could be any value between that start offset and the final size of
> the file since the clone operation will expand the i_size if the current
> size is smaller than the end offset. The start offset of the range was
> chosen because it's always sector size aligned and avoids a truncation
> into the middle of a page, which results in dirtying the page due to
> filling part of it with zeroes and then making the clone operation at the
> receiver trigger IO.

I came across this patch/message after I had the "failed to clone
extents" problem 3-4x on Debian 12, 6.1.0-27-amd64. For us, it only
occurs since we periodically run a Btrfs balance via Cronjob.

That's why I'm wondering: Is it possible that Btrfs Balance increases
the likelihood of the problem occurring?

Best,
Markus

