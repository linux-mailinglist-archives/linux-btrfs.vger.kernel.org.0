Return-Path: <linux-btrfs+bounces-1736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB04183B248
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 20:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B0628679F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDA3132C19;
	Wed, 24 Jan 2024 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hBw9Q3we";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLa00wNk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FE130E5D
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124473; cv=none; b=miZ/fGnXJ9s9sYscXvD6n73G55w7qp/GI0/kvX4v70Qn2HJInq24T9uMf9udIjdReNUdSKfbua8hkR0DGtLgWiB3m07gmKoFH6AXGU9m/vXqEIEU0wxAQPYHbnvxj/f3hec5uLxNJDPaPynq/ODjXRaWWBWgenmDo3xNeIfmN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124473; c=relaxed/simple;
	bh=ajlSjWNtGvQsz/K4vFtUwAiyCNX9WV6L9AF847GaIj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhN4sI6/kcsYLA/kyRwHK9s/uv0jFBo1mZb+W6l6aMNhhZHHKN/+m5OvoBGP9UfZOV1gpm0sm6lwamRsP96NS6Ugoons4+pVLZKp0XfBOI16ZbSqyDr1A8isUm7wKTPpSSV9lLlOjr2Zx0GMg8BYYaCmmglHvw66B3BgSVbIHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hBw9Q3we; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DLa00wNk; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 4855A5C00FD;
	Wed, 24 Jan 2024 14:27:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 24 Jan 2024 14:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1706124470; x=1706210870; bh=mKSyLTTpl8
	pbPtH3KyGwwaaU2+Sx7CmwxQSJt0wcPX8=; b=hBw9Q3weXQaeh21PzxPB76/R7K
	aSdSLR5/qFlIRIMWDMIQRuB7RbdyctA/ZSrVbqa/LdyHdVWl8DqQQ7bl4l+SfmNB
	FwjXBGJc3pj2AcrSILBlpn+S+58J1u9TdHd6phWAUfunaQLIZy/J8JXImi4MxA0x
	tXiq4RVwZG6AyyqfVYJ1a7L7AZv/+3Ckv7b+a1ASLjt/9rOk+xyMUONHjsnpcObg
	EY3weieirmNbHTyeaeZ2jxVtXTC4De6ogd4rSMi6ojbFoZ4KT7YCtyaKIaha0Ag4
	6Dv5oKwf3FY1fmzRcKBiWwmCNP/yOQJM94kadKTor9Pe23cKT4xU3eLiqtMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706124470; x=1706210870; bh=mKSyLTTpl8pbPtH3KyGwwaaU2+Sx
	7CmwxQSJt0wcPX8=; b=DLa00wNkYECnhHdxIcnIHry6zF9252AEIkDFf55poIud
	bzfIqp0CSMsS9s6IDTJbH3Z1SawlxMymINe9aApFVBbyNr0F3n3otcnyjTPQgJyl
	CkdIdEACJnZCQUBPQrmtUBKVxBql861qLCrgKj8TUcXGJjIxjdpNHPGdJ7X8msQ8
	4FZPJIh8soLKhOerd0Lfirn3aVDSSqQWhaHsOMLrZvqYofYvwKaJsmzzfpHXTDMt
	t6lMpJEcEtcDej8mpE3RyajgoumQ29e3MdxyUyAluMl5tOIA9ORovqKTfz+FmshP
	jO2rpkXc8EsKpmEo6hEAIpDLr7mNviF3gN3nj51VdA==
X-ME-Sender: <xms:tmSxZQ6V_1XCSnCG7f3BlvJ3zxRFrIMe9l7f01R7nGGhPO6V8wlpKQ>
    <xme:tmSxZR4nmxInjg-xAj_CbAJgo_b03vgLgYC15H7YVaKXHnmUKC8bNAuastyCPwRII
    3YOFwPIPg2pLpfDHFs>
X-ME-Received: <xmr:tmSxZffzPFzxPm14xW0sJl2QDQgTbEoXVMxo1Q3p_RWij5I0rYNEqPniDPT6faDNHQczypvMT3dhshUeAf2RgGKa6Fo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:tmSxZVI2u2f2bj7h3pblUVkYf8RvCFcbsW5xiqZYVZJRTnRdqolz0Q>
    <xmx:tmSxZUKRX8kTMPKxqY4D__HtTTB9dB23jB7CukxmX0ZNy24MevrcBw>
    <xmx:tmSxZWzB8D_vLZDH5Rv4VrKYYO39bkd0LFUjG77uCdaMhQ9orxzjGA>
    <xmx:tmSxZej5D4n86vaCAdSKBj6CTLjdm86DDnIF_Hp5C2Sj3wyNJhm9ZA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 14:27:49 -0500 (EST)
Date: Wed, 24 Jan 2024 11:28:50 -0800
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 52/52] btrfs: disable send if we have encryption
 enabled
Message-ID: <20240124192850.GA1789919@zen.localdomain>
References: <cover.1706116485.git.josef@toxicpanda.com>
 <62ce86b38e2575c542eed7fbe8d986e68496b1d7.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ce86b38e2575c542eed7fbe8d986e68496b1d7.1706116485.git.josef@toxicpanda.com>

On Wed, Jan 24, 2024 at 12:19:14PM -0500, Josef Bacik wrote:
> send needs to track the dir item values to see if files were renamed
> when doing an incremental send.  There is code to decrypt the names, but
> this breaks the code that checks to see if something was overwritten.
> Until this gap is closed we need to disable send on encrypted file
> systems.  Fixing this is straightforward, but a medium sized project.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/send.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index d26ca7b64087..eba45477b10a 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -8183,6 +8183,12 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (btrfs_fs_incompat(fs_info, ENCRYPT)) {
> +		btrfs_err(fs_info,
> +		  "send with encryption enabled isn't currently suported");
s/suported/supported/
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * The subvolume must remain read-only during send, protect against
>  	 * making it RW. This also protects against deletion.
> -- 
> 2.43.0
> 

