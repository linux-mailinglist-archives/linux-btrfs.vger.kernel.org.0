Return-Path: <linux-btrfs+bounces-12496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F8A6C908
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 11:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076BF3B7819
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75D01F91E3;
	Sat, 22 Mar 2025 10:15:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.nerd2nerd.org (mail.nerd2nerd.org [148.251.171.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE851F63F5;
	Sat, 22 Mar 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.171.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638534; cv=none; b=F0F1EUqEPwOqTrRVIOET3EA6zKk5qdPhphcTunlhmfyQpkRvrAFOm6CbdESRQHDSagwARhO+ThvuEDQyRrjHT45Rhnt7tfEPTxou7UC/8786oEXxSUbpi6RkN1ccRaLGq7Gq4qAHr4d/uyWv8wTAkfz5XZ05C5ELdCzcsPFppoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638534; c=relaxed/simple;
	bh=Cn65MZK819wumfC+PS7oRw6uQH8EblfVJ2HlG+WJiqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSOsyZVXZFwh96Ky+qucReOcnkxlsPDgVIxZd8tn5IjRSYZ5ddJNKt1zdjauCJfEsmwjYb4AwT64eU6InepUSNa2sRJ+Qw0XfZvkE5qBwP/mUidC83Rnf5RQXmRMBAMXn8F+xKvk7Yegx/LnuPRUxOMK3oYDPI8DbFWTITBa/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bareminimum.eu; spf=pass smtp.mailfrom=bareminimum.eu; arc=none smtp.client-ip=148.251.171.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bareminimum.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bareminimum.eu
Received: from [IPV6:2a0b:f4c0:c1:920e:b0a6:a48b:3852:bab6] (2a0b.f4c0.00c1.920e.b0a6.a48b.3852.bab6.rdns.f3netze.de [IPv6:2a0b:f4c0:c1:920e:b0a6:a48b:3852:bab6])
	by mail.nerd2nerd.org (Postfix) with ESMTPSA id EEDDA61918;
	Sat, 22 Mar 2025 11:15:20 +0100 (CET)
Authentication-Results: mail.nerd2nerd.org;
	auth=pass smtp.auth=lemmi@nerd2nerd.org smtp.mailfrom=kernel@bareminimum.eu
Message-ID: <36c6c8f3-d7fb-42b8-bafe-4eae9b02f4ec@bareminimum.eu>
Date: Sat, 22 Mar 2025 11:15:19 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: correctly escape subvol in btrfs_show_options
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, linux-kernel@vger.kernel.org,
 Calvin Walton <calvin.walton@kepstin.ca>
References: <20250319214900.25100-1-kernel@bareminimum.eu>
 <20250319235251.GS32661@twin.jikos.cz>
From: Johannes Kimmel <kernel@bareminimum.eu>
Content-Language: de-DE, en-US
In-Reply-To: <20250319235251.GS32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.03.25 00:52, David Sterba wrote:
> On Wed, Mar 19, 2025 at 10:49:00PM +0100, Johannes Kimmel wrote:
>> Currently, displaying the btrfs subvol mount option doesn't escape `,`.
>> This makes parsing /proc/self/mounts and /proc/self/mountinfo
>> ambigious for subvolume names that contain commas. The text after the
>> comma could be mistaken for another option (think "subvol=foo,ro", where
>> ro is actually part of the subvolumes name).
> 
> The subvol= option was intentionally last so the path does not mix with
> other options but yeah it still can be confused if it's parsed in a
> generic way and not assuming anything about the ordering.
> 
> I've checked util-linux/libmount, seems that it understands the "\," as
> part of the option value so it should not break anything.
> 
>> This patch replaces the manual escape characters list with a call to
>> seq_show_option. Thanks to Calvin Walton for suggesting this approach.
>>
>> Fixes: c8d3fe028f64 ("Btrfs: show subvol= and subvolid= in /proc/mounts")
>> Suggested-by: Calvin Walton <calvin.walton@kepstin.ca>
>> Signed-off-by: Johannes Kimmel <kernel@bareminimum.eu>
> 
> Added to for-next, thanks.

Thank you for taking care of this so quickly.


