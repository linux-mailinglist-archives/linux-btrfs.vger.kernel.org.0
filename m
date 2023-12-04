Return-Path: <linux-btrfs+bounces-588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9273B803C30
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 19:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C5281100
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C7D2EAF8;
	Mon,  4 Dec 2023 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy8IuXSE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E494AFF
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 10:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701713023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEhSjs54nO8InvY+sUNJmDqysmSb2BVyoKp37NKJFbw=;
	b=Yy8IuXSESJmSWlDKem990N11r1A6l4qZIYdKGUoTcp3dyDTpuij0L2BczzKZ1H5SMH7rcG
	ABgX+YRXPneEu9YGkjzqYIZu+iPrP6sQWbtrPrb9H7l3w/ElixuNDIFO+ozuEA6p6hN2ji
	9W05gpDaQFDTd+Jwo2bOrRgYRbKe2KE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-b8WDIutKMq2cZnZttxjYMQ-1; Mon, 04 Dec 2023 13:03:39 -0500
X-MC-Unique: b8WDIutKMq2cZnZttxjYMQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-285bb0575d5so6440784a91.1
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 10:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713018; x=1702317818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEhSjs54nO8InvY+sUNJmDqysmSb2BVyoKp37NKJFbw=;
        b=iougFchcNJJ6x4nCx8iP7qfNGf6tAbjx7/7go0SkMEfKkJoWOowujnniCuWIXv2yeP
         klaW7rdTi8OLWlMEDFxD3g2dijSnzIwSDIBNyVE1hNK0ZF85aJdwzOTvRUgM69vDbKwr
         oj4e4xhHuAxkzCoz9ByPoKy61vm8xsoOvPqkNh1JlcnAxBOnLuzTOPOOchAMYNOZSCPB
         iXqr7KzRYxRQG8J4oVLaQcpuVPZ1oVhIVDxMTm/5lbbmhghzjvQuaPBkuoEGh9CyvD3e
         3zhUHapcEMPvKMKBVYreXShLlNAgHPyoIg4IXFLGsUbTJ18Cu/fr4XBztpiQ9Em1boK8
         gFNg==
X-Gm-Message-State: AOJu0YyBi+9JtCWiHUEgnhPzHNbahK+Lwu2yVCNTyEu2g5ogHtRyV9uh
	QPZGm79wvcc5LdGfiybxyuBPfin5EnkIAc7bDQNY3RQwiiczHXieoaty2LR9EC0sk2yNTftqvLt
	IeuqYMzJhRd2ggGkatcJ/r+A=
X-Received: by 2002:a17:90a:de8c:b0:286:6cc0:cae1 with SMTP id n12-20020a17090ade8c00b002866cc0cae1mr3195189pjv.88.1701713018393;
        Mon, 04 Dec 2023 10:03:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8HMPc0sGd+lSFBbe6RxYaY900yBM9NEDJabmoBq/DInD6Ago7d6g2nc046Zj6mbokrn9vVQ==
X-Received: by 2002:a17:90a:de8c:b0:286:6cc0:cae1 with SMTP id n12-20020a17090ade8c00b002866cc0cae1mr3195179pjv.88.1701713018120;
        Mon, 04 Dec 2023 10:03:38 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a8d8500b002867adefbd4sm3937115pjo.48.2023.12.04.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:03:37 -0800 (PST)
Date: Tue, 5 Dec 2023 02:03:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] btrfs/048: add missing groups 'subvol', 'snapshot'
 and 'send'
Message-ID: <20231204180334.czfdn4y5zi2qpltb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1701704557.git.fdmanana@suse.com>
 <bb893d210f2cb43467f219a817003cbd6b596b6c.1701704559.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb893d210f2cb43467f219a817003cbd6b596b6c.1701704559.git.fdmanana@suse.com>

On Mon, Dec 04, 2023 at 03:45:11PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This test case exercises subvolumes, snapshot and send/receive, so add
> the corresponding groups to the test.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/048 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/048 b/tests/btrfs/048
> index 7816a997..8a88b8cc 100755
> --- a/tests/btrfs/048
> +++ b/tests/btrfs/048
> @@ -11,7 +11,7 @@
>  #  btrfs: fix zstd compression parameter
>  #
>  . ./common/preamble
> -_begin_fstest auto quick compress
> +_begin_fstest auto quick compress subvol snapshot send
>  
>  # Override the default cleanup function.
>  _cleanup()
> -- 
> 2.40.1
> 
> 


