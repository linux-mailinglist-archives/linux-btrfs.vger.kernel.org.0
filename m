Return-Path: <linux-btrfs+bounces-8656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302409957C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 21:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E28E1C218DF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 19:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63087213EE7;
	Tue,  8 Oct 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="Q17zQ5s4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D1213EC7
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416359; cv=none; b=m6WGAu8+KD7xsaN7QZB5lITEf9p4B7yqc+sTkbfC4PNx1MezOo42n02jQ2dgSFlqynH4B5R22kRKB8Vtu67zkDUeTiZupzKW2NDExXCYARSbRSHv0334eh9liPY1MWcFxj+jeSFnBB4UJjcZQNIGgSahn+8hzmcTja+lJjq6LTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416359; c=relaxed/simple;
	bh=w/rewmOGVl11Ymd3XchA0hNJjjI2ywpbPqlQq3Uuhes=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F4phRer4uOb6JDLtMnZD+wMTRcm3m+fZ7zj1m72B7xKjimhucX1jQp9KmdwzqJgfd6VaaR4qTmlqNK0iRkwJCFwToh8PzFZSu4iQae5TbAUWl8eT4tGlJn6LfOMkZKex1b9sf14EdGWKdt9v/OhXbUfw8Fbao+3AI23kI8Mkw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=Q17zQ5s4; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1728416349; bh=w/rewmOGVl11Ymd3XchA0hNJjjI2ywpbPqlQq3Uuhes=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Q17zQ5s4hdPlnTMnYzTKTcIXrXb3cDIXsM8MW8FLy1pSL1rfSEJSGpKNQSXCq13My
	 nyGFWWzHdzhfvr2xJ53QbpHQTsOqbCMYbli+jPedPNXX13OuNElgkgx/tGdWX58+09
	 tJbIMC8g5MshU+MbWCSod+P1UfHRbFFWDflQuelMx6NkhJWyooXNkT8ZdHe0d2LDDd
	 fvObUaXca2WD7uLyaNSN1l0AFukfIOty8+D/bhgviykkW2OqS39a2L1vQCYjbaRPtc
	 ihy0n0qCF4OZ2oaXWdRydq2uS9KxAQ6ywwXR2i54AuSPIoY6On1zuPlEkM8590oWmV
	 KJuSes055QfrR3hEp36q0p+dHSrqief+jvz2mBziV1ZGZKEKmThI1WzqPdUJohOj0f
	 KXMhVQvhB/CJfevA60KjE586QxKbF0DREg3166lyuClyndTjXooT1qB4GHQ0K3BVD6
	 uMnvaHjLIOrg28nuYetv5M91sDV0FA3IdJW3pJ8TsQtaY4joBCSvVJIjWbDpQRJVnz
	 DWTe9t7nv8Iw/qKSqeZt+VtXJEGhV991p8UiRserO3UrHEn9EOJ62zbjM6j56uwmUW
	 pnSp4zCTp++6QnW5T4GX5Jd09vxK22hpAWA/ZHQK3IamogHyv/mvlWaPoRD7KlXT88
	 UoSPayG5KhIjaZ7EcloCotVA=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 80AF918D6D9;
	Tue,  8 Oct 2024 21:39:09 +0200 (CEST)
Message-ID: <f6a720b3-65cc-494d-b32a-50a2991929a2@ijzerbout.nl>
Date: Tue, 8 Oct 2024 21:39:07 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] btrfs: fix missing error handling when adding
 delayed ref with qgroups enabled
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1727342969.git.fdmanana@suse.com>
 <7e4b248dad75a0f0dd3a41b4a3af138a418b05d8.1727342969.git.fdmanana@suse.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <7e4b248dad75a0f0dd3a41b4a3af138a418b05d8.1727342969.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 26-09-2024 om 11:33 schreef fdmanana@kernel.org:
> From: Filipe Manana <fdmanana@suse.com>
>
> When adding a delayed ref head, at delayed-ref.c:add_delayed_ref_head(),
> if we fail to insert the qgroup record we don't error out, we ignore it.
> In fact we treat it as if there was no error and there was already an
> existing record - we don't distinguish between the cases where
> btrfs_qgroup_trace_extent_nolock() returns 1, meaning a record already
> existed and we can free the given record, and the case where it returns
> a negative error value, meaning the insertion into the xarray that is
> used to track records failed.
>
> Effectively we end up ignoring that we are lacking qgroup record in the
> dirty extents xarray, resulting in incorrect qgroup accounting.
>
> Fix this by checking for errors and return them to the callers.
>
> Fixes: 3cce39a8ca4e ("btrfs: qgroup: use xarray to track dirty extents in transaction")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> [...
> @@ -1034,8 +1047,14 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
>   	 * insert both the head node and the new ref without dropping
>   	 * the spin lock
>   	 */
> -	head_ref = add_delayed_ref_head(trans, head_ref, record,
> -					action, &qrecord_inserted);
> +	new_head_ref = add_delayed_ref_head(trans, head_ref, record,
> +					    action, &qrecord_inserted);
> +	if (IS_ERR(new_head_ref)) {
> +		spin_unlock(&delayed_refs->lock);
> +		ret = PTR_ERR(new_head_ref);
> +		goto free_record;
> +	}
> +	head_ref = new_head_ref;
>
There is a chance (not sure how big a chance) that head_ref is going to 
be freed twice.

In the IS_ERR true path, head_ref still has the old value from before 
calling add_delayed_ref_head.
However, in add_delayed_ref_head is is possible that head_ref is freed 
and replaced. If
IS_ERR(new_head_ref) is true the code jumps to the end of the function 
where (the old) head_ref
is freed again.

Is it perhaps possible to assign head_ref to the new value before doing 
the IS_ERR check?
In other words, do this:
         head_ref = new_head_ref;
         if (IS_ERR(new_head_ref)) {
                 spin_unlock(&delayed_refs->lock);
                 ret = PTR_ERR(new_head_ref);
                 goto free_record;
         }

-- 
Kees

