Return-Path: <linux-btrfs+bounces-20290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F53DD059FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 19:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A8493035CD7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CFC322B66;
	Thu,  8 Jan 2026 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FZY2t9r6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SzJYTCA5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5630EF92
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897849; cv=none; b=kj3VtO/qxhPtW6sfoF3ztfHqxnq/d9Alzel8g0wvM+aLiQyhWE/eZ2J2e9CjLxMh5IekNruLsxjTTkfEq/oDqj/pMeu+CxWCWXPBiycSvTgN7Q/L6PSD7633FWfsl62+Puzg6qIAcPB01jfaGlBOYenc/n752RbctDPhzRFtB80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897849; c=relaxed/simple;
	bh=Lo2KWLA5AW/qNErTLaImfzPaoiRQjnBnWveAOtUJwKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBCyvP3FVUmBmRHy+bxm3AbS+Ls1u+8+w+vqKXWmLS6o1aVQAvVBsEW/2cbPsNeuDd+uygTJkqrTcK2BHBP8QHtphYx45mcOPllR23a7jBrBWqpmy40A//W1H9G3KeQvE6/1o12vKgIhAXyxBQh8dDNUsEiMJ/qXLBi/IkIPa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FZY2t9r6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SzJYTCA5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 730917A0081;
	Thu,  8 Jan 2026 13:44:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 08 Jan 2026 13:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767897847; x=1767984247; bh=Rm2i+3nJvB
	aF+015n7mITfiThk7ROtpbWIFTWiL6okg=; b=FZY2t9r6VHhvx9ZUWZEiL0tlSS
	hMwb4EtqXxINeg2xGha/aXSSWxxa5uR5Z38JKQjNRXmM9Xyukz1veq0zQjPLWENf
	3SNSpa+Hw/evbv/TyaZyKjIULKhwnXIi84fScHxTAszGJ1k+a8WfREmnZ2Upt1ei
	OvBObSHBVrSFYy/lG66njLxqjRH/50ZQ1XbUvuWnRuvFdw4nQm05qRET/37VK5kp
	zg372pQmRfkxAFZAJ6iA2UUS03HMnO3Cq1ualbxp7jEfRNf0EzdleUom8DsU0VDd
	AkW2iOgg7jAe1dUBKAGEO0V4g1hNQrJHi6VdFpW9yZ+VSnj8YdGT4spz8Jyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767897847; x=1767984247; bh=Rm2i+3nJvBaF+015n7mITfiThk7ROtpbWIF
	TWiL6okg=; b=SzJYTCA55NwxXp0UydFu9MQAWLAKxhJgRe2DwQIbH5Uf9iTGADT
	kHQP5Qr3vWyE5HNP3ltUee17ADyOk1MOkPaIw1MJ2j5VfRX2CEYK55Vui2BkPVmw
	u+33Kbozf6ekTYz5bhDia7CraXwqlpMCalyZojO5/hqsjEaTdHiqXt7LnOcnyObs
	ZPz+ryb23VamufJ1fqYMcpBpUIlxvien/WWb4RmNorDcq7UCXCcxCy16kCfog4pM
	JgbVlPNV5RSEt7EiH7T3OWxcWjuZJ2CFoTQ1LTIiwysbT9v+/B6QkWe/hKnhQ+Up
	82BSDATPQxRLic3wgvgtW1fN/viPUKmrBcg==
X-ME-Sender: <xms:9_pfaX7Uwa94Td0LdqtcjpJRnhXvX4gB1hAapdFlOqQu3Nh2XPvmPA>
    <xme:9_pfaS5NLPuJueDqX_ox_VayEdDAuPkum1eWQIwnW_5RouiM_u8aECnwTGR3gv-lt
    Eczev0IOUBpo6dNLn5bU0EN4sw505rig-MrTnznEHy6EOtKMC3Gi5I>
X-ME-Received: <xmr:9_pfacEm5f2Zec-v4mL9tEw7b1M6tO11jqqy3JgrQ5zeXVW04xusmyJAeuC9Xi-tx-RQvXHjuwQYvx8kDZR1OqZhwto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeijedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9_pfaTQvKTsqk_PJ5S2lBXiSdzXu7PI5Wja8kZHO96dnEOcN8rIo6Q>
    <xmx:9_pfadtOqLZrVDIdWdeo1Xa0qKHurFbx_VgL8RR1LhuzQTAZ28vLyw>
    <xmx:9_pfaaxA_jV9NOwRHKy7MfG9ll4zQJKwwWr3FlDSc9ggvaiJeaCIMg>
    <xmx:9_pfaf7DgA2GGG74B7s8M4gLv5h1arFLnFvtzW1OZgGARdYfzQEY0w>
    <xmx:9_pfaZFCIjrd8ur5TBT6RnWA6KfWFUeG2wIuoShZ0N-9kcFcPKMjuw76>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 13:44:06 -0500 (EST)
Date: Thu, 8 Jan 2026 10:44:16 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/12] btrfs: zstd: remove local variable nr_dest_folios
 in zstd_compress_folios()
Message-ID: <20260108184416.GJ2216040@zen.localdomain>
References: <cover.1767716314.git.dsterba@suse.com>
 <3af91c534b1567e237a35d17241028f7c4d2b4dd.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3af91c534b1567e237a35d17241028f7c4d2b4dd.1767716314.git.dsterba@suse.com>

On Tue, Jan 06, 2026 at 05:20:35PM +0100, David Sterba wrote:
> The value of *out_folios does not change and nr_dest_folios is only a
> local copy, we can remove it. This saves 8 bytes of stack.

To my eye, this one has the same bug as the zlib one.

> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/zstd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 75294302fe0530..40cc2a479be63e 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -408,10 +408,9 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  	struct folio *in_folio = NULL;  /* The current folio to read. */
>  	struct folio *out_folio = NULL; /* The current folio to write to. */
>  	unsigned long len = *total_out;
> -	const unsigned long nr_dest_folios = *out_folios;
>  	const u64 orig_end = start + len;
>  	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
> -	unsigned long max_out = nr_dest_folios * min_folio_size;
> +	unsigned long max_out = *out_folios * min_folio_size;
>  	unsigned int cur_len;
>  
>  	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
> @@ -485,7 +484,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  		if (workspace->out_buf.pos == workspace->out_buf.size) {
>  			*total_out += min_folio_size;
>  			max_out -= min_folio_size;
> -			if (nr_folios == nr_dest_folios) {
> +			if (nr_folios == *out_folios) {
>  				ret = -E2BIG;
>  				goto out;
>  			}
> @@ -549,7 +548,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  
>  		*total_out += min_folio_size;
>  		max_out -= min_folio_size;
> -		if (nr_folios == nr_dest_folios) {
> +		if (nr_folios == *out_folios) {
>  			ret = -E2BIG;
>  			goto out;
>  		}
> -- 
> 2.51.1
> 

