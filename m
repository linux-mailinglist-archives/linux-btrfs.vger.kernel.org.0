Return-Path: <linux-btrfs+bounces-5857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98836911415
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 23:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BDA283636
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28DD7581F;
	Thu, 20 Jun 2024 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Y4KPgiuB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ifVRXTY2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456043A1CD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917626; cv=none; b=MlPecthkWy4dxSBw7v3SOT+ScbMLloNOU5pP8C14YTsZMBtj4KrPk01AWoWRad5JgbF9iDO0n7gKgdHrJD6IbtOA4pINaFsejdQdSozitDRqv76g+w62tHlK8Y4OsKs/S+yKKq6x1UO/xdT76Uu16pBcekHOtwyPBatrfEDC9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917626; c=relaxed/simple;
	bh=xDWHK8YpUwT3GCCrp8eeBiC0yZLEjVB3cwDA84tLBKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E90eW8iy+C5HpBilBFKThJYzPEWWWo6aGcW6SorcB4ii8O4U6Z8C3+z+F7NE75sW/cFkAnPzstJ6Lwj9WmFsM5JqaslrWNMbEuSFZZ3fgPmqEZEdIerziidnnGqVkJXUbxsNbcuNGe+06W7j7BRxeLkCYyKGqv2bga0JPEo3LjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Y4KPgiuB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ifVRXTY2; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1F2711800110;
	Thu, 20 Jun 2024 17:07:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 20 Jun 2024 17:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718917622; x=1719004022; bh=QxVmcb2dOg
	g9ayfma8rmFBIUMtGcRhZy0mn0hbpVcTI=; b=Y4KPgiuBrFXOfeVfrdUTfiN9of
	JzYbSQyQfv2Kre0nThg1I6gzNcw7gBzxGMmIZtzmBgEINhJ5waN512NnDs3nwLvQ
	MLH7JPx5hrjdEaVIv32YG7wMJes3Vg4IfGyAU2u6BUSmbzUsl1wJP8xmX7pvj49Z
	aCnCTUefP08R78zlwY18h7y4cpt8Tpawm9JtKidcCtBKG0tNFIJBXOqyiq6N2s7R
	35X2LWoSvl+Jrq71Z86N4gCdXwuFhh5kno8KkcIANCCoSuFYe6pRufDrndHU24yn
	fTpSvXBB4Yzilpb805fa4hqXMt5vqDu3JZwM+X8/8wvE0jX1vrCIzc1lRdLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718917622; x=1719004022; bh=QxVmcb2dOgg9ayfma8rmFBIUMtGc
	RhZy0mn0hbpVcTI=; b=ifVRXTY2Lz17mCjN3F9aJhRWZXQGfPZTEaR2EWK+EXqi
	aXZ7lsNQOLyPKhPQtskTZGpsswSmCLF/YVnNNQX+ptbwVYNheLA2vRXkKUdYFkBp
	nzSJAu+IWxePo8zQ5ZsxQZymPOLmKEnPqoAw/EJihMBUe47jCKjaUdv8f7Fs+M+e
	N+EUmmw5B5zWrhdggHJi3qSxsLdKJTm7hDo6yryc78jWvmJZgn5P1hdbDUh5xFKm
	TGs7y7K0K8ghEMhLrSOnGmoCEiOiQz4LYph1WJLJexjwxMx/3YzD0aM0Wub1c90B
	scJs7QOlQYOP0wx1m7uCIO6P0fr1TvLdPHscw7HS7Q==
X-ME-Sender: <xms:9pl0ZmK5gYIp92iME2A_cnQcfxoWugmiwUsmEfQrRlexPDi3kPi8Kg>
    <xme:9pl0ZuIWGEjC9O33zu6e0ynOHHSrIyKPdrErYf15DSAW2PR4_MyBxh3k2rOmABK5G
    fxrpiJy_wCLwFqpjlE>
X-ME-Received: <xmr:9pl0ZmsiiWI83UrQxHpJWhO1nXTahOEBypXx9wcVhD9dhx_auIAE7fo3qND-hSvz9XelpmnUTZKAIhUfGoNqn3cWcLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefvddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghu
    rhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvd
    evieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:9pl0ZrY11_Kp27ldpFYaIUDFBLyPCt7ZQUVSgabLna61Xge8RRilYA>
    <xmx:9pl0ZtYm71P4rHSCf52s8l6sOj9sk_zBwVc4TE_uwbFwAr9K733MgQ>
    <xmx:9pl0ZnBp5ntGpttYYu7o9s4v2SNA9ZOcbhKjcu5918kf4LzoONrMmg>
    <xmx:9pl0ZjYWs4m8ariA5_dxYYQtkozPpJ7qIcxqSF0uXoDSo_I8GHtXVw>
    <xmx:9pl0Zsn4q54dtSdOLmZaXBvLPwt0WC0DubgRer5DJUwQLIxrNx0LZ3-G>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jun 2024 17:07:01 -0400 (EDT)
Date: Thu, 20 Jun 2024 14:06:39 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: fix quota root leak after quota disable
 failure
Message-ID: <20240620210639.GA3251296@zen.localdomain>
References: <d4186215561658577a9622bf111c79909f0521c6.1718883560.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4186215561658577a9622bf111c79909f0521c6.1718883560.git.fdmanana@suse.com>

On Thu, Jun 20, 2024 at 12:41:09PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If during the quota disable we fail when cleaning the quota tree or when
> deleting the root from the root tree, we jump to the 'out' label without
> ever dropping the reference on the quota root, resulting in a leak of the
> root since fs_info->quota_root is no longer pointing to the root (we have
> set it to NULL just before those steps).
> 
> Fix this by always doing a btrfs_put_root() call under the 'out' label.
> This is a problem that exists since qgroups were first added in 2012 by
> commit bed92eae26cc ("Btrfs: qgroup implementation and prototypes"), but
> back then we missed a kfree on the quota root and free_extent_buffer()
> calls on its root and commit root nodes, since back then roots were not
> yet reference counted.
> 
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/qgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 3edbe5bb19c6..d89240512796 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1346,7 +1346,7 @@ static int flush_reservations(struct btrfs_fs_info *fs_info)
>  
>  int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_root *quota_root;
> +	struct btrfs_root *quota_root = NULL;
>  	struct btrfs_trans_handle *trans = NULL;
>  	int ret = 0;
>  
> @@ -1445,9 +1445,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
>  				    quota_root->node, 0, 1);
>  	if (ret < 0)
>  		btrfs_abort_transaction(trans, ret);
> -	btrfs_put_root(quota_root);
>  
>  out:
> +	btrfs_put_root(quota_root);
>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>  	if (ret && trans)
>  		btrfs_end_transaction(trans);
> -- 
> 2.43.0
> 

