Return-Path: <linux-btrfs+bounces-20214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BBCFF744
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C5FF3001821
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF898346AD3;
	Wed,  7 Jan 2026 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="IZyL5OvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wdy0QIGM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120432ECEBB
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810165; cv=none; b=Ng4rlP4yRGKq74u8j0qlMb5WgZPXlMAbz5BHUBWb3OQED6HGFODArfCJrHbBpMnBpTCzkE+0cxJvohrNjvUbp2Abtb02mEyLr8C1YHtSVVz2RAP9H//3VOBfTE43x83H0ioZuF/3d2uME17I8s9WOAO0tVbcoWttv2hdB9TgU90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810165; c=relaxed/simple;
	bh=VD/wNkRE4JywgqHW0OXZdYh3wbpS65ypIGEDAs1GQ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh8j8sYMNov0peUrPSmA0Qa6oslv8VvIk0ahLNt5kT7/Vcj0AMgMcLIcgrX5Ity2e7JFx4/7uep3gqqojwsnpjQ5Rhlipoj348vjmhLDMvkPimHrbm3DmXTIy3/p7ymwhF5WX7X5TTmO3RMokkRpEFYcw8cz1HOp3gvrSjeWAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=IZyL5OvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wdy0QIGM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2953314000DF;
	Wed,  7 Jan 2026 13:22:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 13:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767810162; x=1767896562; bh=njK4AGIp3f
	T/JtTKcWYbWS8TT4/1GmzntJEqUWU+84Y=; b=IZyL5OvO8i9szW81Go/I5OmE8m
	ivtdXEybEQgRO6jIyHjC+IAuEJOFEt90s4zTpDlce7oVwQLMPi8GP9+bNVLod41j
	VpyPQ4Mpu1l8wplsnTWYoQjc5dE+xCrP+oEGnyKwrMzFUxJCRV8XtFkbe05SUyIP
	imH45SCqa/DOgeYNMdIHDKpMkbmoA8l+VAoFPjj04PJVkfC/B5Ryet9pDQUF6rl5
	B3A9dUgyJK9K/AM3UqX7wHzJv6e3swwbWhSd/FCmjNUNAprt0s9uD83cZ7x/exbF
	V6Yzks9Swvcse6E2pYpf8/cfQbKA0p7sL4ncoC5wzgX2Wk2ulPelusXfYQZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767810162; x=1767896562; bh=njK4AGIp3fT/JtTKcWYbWS8TT4/1GmzntJE
	qUWU+84Y=; b=wdy0QIGM02TtvYQ1Way4bsKWChzGKSfXz+0r6SycW77drzwVaU3
	whuUEkuX70OHu/UuuG0sCtFgnuSFmu4fVJkP1gombXyRcirpBPdZbakmLyC+B+fb
	H+lcsfhUwFzU6PoP6NVV27m+oFFlHJCXVvMq4wX4TPnv3r1RtX2gqSmbK1OHAf5t
	6EVSnCSYXj0/JitqS9AUkO4FMzoIWC9pllJuufdmH5hUg6y4uAMfEd74s/NUU9yo
	SKPDvoydVFv2R2dZMWtL7ptmk/nJPyYeQh0fWefycxL9GZf9aW9PAgCMSN3qvphg
	F37VLjdyjzEHzy4NudzTuTV0q9Rq3/fnLIA==
X-ME-Sender: <xms:cqReaY-1zcfLeCvcuuqpYWuouBJLmvTA8kGTkvtdhlE4Sop9hwdKQw>
    <xme:cqReaWtnHB74FKOtBGR7TRhihaSX0hpoI2quVuo_uvu2I7GN6Etn2WIaShXVHmk_w
    gq2oUQf13Y1r0yC9SWTI7MSFkJikkM9qEZ_Z6d035Cb7E2iofm4sPw>
X-ME-Received: <xmr:cqReabog76tdZ_qtfAYcCJu0l6Dc5K3dE6sKj7mABgSnNlGye7QSSSnMYWeJmnIDWySt921PMtB0f_5pYP7Ii2fWZo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cqReaTlUiquprb1rfOHsBdF7Ff2yidgakJXgNB-5SJB114ebCImmRw>
    <xmx:cqReafyP400bKmxBszgedjHU7o7AFzz4l2N831_1k6n-WykbeMkLug>
    <xmx:cqReabmhKH_AoG_JjQbkBCKQryfb123HD4VAPd1CarsD2E6_T0oecg>
    <xmx:cqReaYfEuQUksdcN-wihyKR-_BLj--gHceg7Zf-1CnIP1QruevvHdQ>
    <xmx:cqReaepatgB5c1oq0vdZxyFIgonW70w0_DbJQk8mjSobAsn71yJnfNka>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 13:22:41 -0500 (EST)
Date: Wed, 7 Jan 2026 10:22:52 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: corrupt-block: allow to specify the value
 for key corruption
Message-ID: <20260107182252.GA2216040@zen.localdomain>
References: <8460d20765914390ac2600d8e3f613f5b89060f3.1766975209.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8460d20765914390ac2600d8e3f613f5b89060f3.1766975209.git.wqu@suse.com>

On Mon, Dec 29, 2025 at 12:56:53PM +1030, Qu Wenruo wrote:
> I tried to use btrfs-corrupt-block -K to corrupt a INODE_REF type, but
> unfortunately the field is always filled with random value, and
> sometimes it even break the key order.
> 
> To make it more useful to reproduce the biflip recently reported, allow
> "-K" option to work with "--value".
> 
> There are some minor points to note though:
> 
> - (u64)-1 will not work
>   We use that value if detect if "--value" is specified.
>   For most cases we do not have key objectid/offset set to (u64)-1, so
>   it should not be a big deal.
> 
> - Will keep the random value behavior if --value is not specified
>   So old behavior is still kept.
> 
> - Values over 255 will be truncated for key.type
>   Just give a warning and do the usual truncation.

Seems useful.

I think it might be a little better to make it mirror --item and expect
size, offset, value all to be set and corrupt the key fully generically.


> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  btrfs-corrupt-block.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index 3d349f8cf40a..b111206e685b 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -112,7 +112,7 @@ static const char * const corrupt_block_usage[] = {
>  			"metadata block to corrupt (must also specify -f for the field to corrupt)"),
>  	OPTLINE("-k|--keys"," corrupt block keys (set by --logical)"),
>  	OPTLINE("-K|--key <u64,u8,u64>",
> -		"corrupt the given key (must also specify -f for the field and optionally -r for the root)"),
> +		"corrupt the given key (must also specify -f for the field, optionally -r for the root and -v for the value)"),
>  	OPTLINE("-f|--field FIELD", "field name in the item to corrupt"),
>  	OPTLINE("-I|--item", "corrupt an item corresponding to the passed key triplet "
>  		"(must also specify the field, or a (bytes, offset, value) tuple to corrupt and root for the item)"),
> @@ -557,7 +557,7 @@ out:
>  }
>  
>  static int corrupt_key(struct btrfs_root *root, struct btrfs_key *key,
> -		       char *field)
> +		       char *field, u64 bogus_value)
>  {
>  	enum btrfs_key_field corrupt_field = convert_key_field(field);
>  	struct btrfs_path *path;
> @@ -590,13 +590,27 @@ static int corrupt_key(struct btrfs_root *root, struct btrfs_key *key,
>  
>  	switch (corrupt_field) {
>  	case BTRFS_KEY_OBJECTID:
> -		key->objectid = generate_u64(key->objectid);
> +		if (bogus_value != (u64)-1)
> +			key->objectid = bogus_value;
> +		else
> +			key->objectid = generate_u64(key->objectid);
>  		break;
>  	case BTRFS_KEY_TYPE:
> -		key->type = generate_u8(key->type);
> +		if (bogus_value != (u64)-1) {
> +			if (bogus_value > UCHAR_MAX)
> +				warning(
> +		"value %llu is larger than U8_MAX, will be truncated for key.type",
> +					bogus_value);
> +			key->type = bogus_value;
> +		} else {
> +			key->type = generate_u8(key->type);
> +		}
>  		break;
>  	case BTRFS_KEY_OFFSET:
> -		key->offset = generate_u64(key->objectid);
> +		if (bogus_value != (u64)-1)
> +			key->offset = bogus_value;
> +		else
> +			key->offset = generate_u64(key->objectid);
>  		break;
>  	default:
>  		error("invalid field %s, %d", field, corrupt_field);
> @@ -1583,7 +1597,7 @@ int main(int argc, char **argv)
>  		if (*field == 0)
>  			usage(&corrupt_block_cmd, 1);
>  
> -		ret = corrupt_key(target_root, &key, field);
> +		ret = corrupt_key(target_root, &key, field, bogus_value);
>  		goto out_close;
>  	}
>  	if (block_group) {
> -- 
> 2.52.0
> 

