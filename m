Return-Path: <linux-btrfs+bounces-4521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEED8B0CC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 16:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15611C233C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072DD15ECF9;
	Wed, 24 Apr 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZF7K3fl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAAA15ECEF
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969488; cv=none; b=KLFIwslEVmJGOwRVLlK0BDtQzw+ReqqD3zqQnJiDAaXNd55a/3wJpAdSdnnU1mAoJC2L4RP5BFNrAsBDwFGaBf3Mw/wP7rqQCUbq1b6AenmkEGfZ4tPOGJ+YS4MbfXAVqq+kpizJU00Se9NPsPCBXRF8bvra3cCiHxR9wrISljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969488; c=relaxed/simple;
	bh=A1iKnBwprN1x/134qM7jnGUpEQlazq/km+mba9YfOto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTflaaj5RWX8G2maDz/tfqdi0UqC7M6zmyWq2AfMCV0LfHcQyLzurf6UguLWi3NzAAQLr7qK7jLvgxXkEPQS2h0qL/Tf769o2+vBk8deTx5zmWRSBacHFwCoc33qLDZ+wWL18C269v7Lr32zjfWzxyaeea2OQTJH0Emn0KBpz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZF7K3fl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713969485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZVWCOEobo4H5vYXBacZjw/B4qqMhk3RzzEe9CEOCeY=;
	b=AZF7K3flI2edCuij/HQVtKqHqOJQrvscQ4+dW/OjgCeqNSOpibMtrFs5gTvxJ9ThQv/I2G
	kB7iVCD7mvAO8Q0LoOJibmM2qduUP8X29BiL2HMuZDUN9ArDwaT9KYAJ2SuZCBD0T4aqI2
	wjO7ESuBVQIzzvlU/dKvjjFA0vIcRtg=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-YR2sY_aFPQWDd7-Vobx8KA-1; Wed, 24 Apr 2024 10:38:00 -0400
X-MC-Unique: YR2sY_aFPQWDd7-Vobx8KA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-22efb0b809aso7295991fac.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 07:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969480; x=1714574280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZVWCOEobo4H5vYXBacZjw/B4qqMhk3RzzEe9CEOCeY=;
        b=PRabS+xLML3jWj/qUKwlzRiRSaoEQDTEWKy4kn1UX1RdJDHqR7f8gjmNiSg8dVdQ16
         nNj48wBZt0i9cbAFQ7cJmZPXD7KvxPr6eSKVHpna6a0Lby4QZLSqu72Pnvjqwemw0yqT
         scTr8cQ8MwEjm+yAk0amr2ttHCwwSxL+PmTQ4TOueWCYPCkNPhysnioDG/82QidQgFlu
         wsNXqHT5STHR2KsCNzpJ5d/gw2FbvyaENjBjLs1578suKvH5gyxDeIwOS69aOvcv9HPl
         uuchOs/Lw3pxNK07IaX4HupxDwsFVrcwsmesHgW5Ck9YLdEmG3bZFSFQbUpmSVnqRn64
         pI1g==
X-Forwarded-Encrypted: i=1; AJvYcCXzzyMGobYjJ/u63dnXSpL66c5T+f1dEfq674MaonpyA4H7qzH5CZFMt7cwZVFBUfwhXUTsuIXWlUQxdSpKUlvOlw5nAJyIS7tiIvM=
X-Gm-Message-State: AOJu0YyXkrZKmfrP8bXi0iVRecmBEm9GdwFnAlYTOAlpXLl9jPxTZe+I
	H/PoMW34fAk7nW7oKdIdZWCuw4TpcU8RpyQLOmcdn0wkPhG1MNNpW3jf17hCSb4PJhOyPqIb3Hl
	HiDjZlTctlxEc5S0yW/8mET6+JFWtMd7ymqt5M/Vna49dfHwIbmgzWbk/VXaU
X-Received: by 2002:a05:6870:242a:b0:22e:bb57:94c6 with SMTP id n42-20020a056870242a00b0022ebb5794c6mr2720499oap.4.1713969479998;
        Wed, 24 Apr 2024 07:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr1tzaa3z2pPVZPV2MNsPBBRLkNRI1Ed2u7VfRgFJvxM49r9Ljc62JuSW8DyVb3EYSr3h7bQ==
X-Received: by 2002:a05:6870:242a:b0:22e:bb57:94c6 with SMTP id n42-20020a056870242a00b0022ebb5794c6mr2720477oap.4.1713969479592;
        Wed, 24 Apr 2024 07:37:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p13-20020a635b0d000000b005dc98d9114bsm11308564pgb.43.2024.04.24.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:37:59 -0700 (PDT)
Date: Wed, 24 Apr 2024 22:37:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Subject: Re: [PATCH v2 1/3] common/btrfs: refactor
 _require_btrfs_corrupt_block to check option
Message-ID: <20240424143754.ag7kc24yysudoigp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1711097698.git.anand.jain@oracle.com>
 <206f5635cffc0c923afd1a297058fa406bd8e43a.1711097698.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206f5635cffc0c923afd1a297058fa406bd8e43a.1711097698.git.anand.jain@oracle.com>

On Fri, Mar 22, 2024 at 04:46:39PM +0530, Anand Jain wrote:
> The -v and -o short options in btrfs-corrupt-block were introduced and
> replaced with the long options --value and --offset in the same
> btrfs-progs release 5.19 by the following commits:
> 
>   b2ada0594116 ("btrfs-progs: corrupt-block: corrupt generic item data")
>   22ffee3c6cf2 ("btrfs-progs: corrupt-block: use only long options for value and offset")
> 
> We hope that if these commits are backported, they are both backported at
> the same time.
> 
> Use only the long options of btrfs-corrupt-block in the test cases. Also,
> check if btrfs-corrupt-block has the options --value and --offset.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/btrfs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ae13fb55cbc6..a8340fdd4748 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -659,7 +659,22 @@ _btrfs_buffered_read_on_mirror()
>  
>  _require_btrfs_corrupt_block()
>  {
> +	# An optional arg1 argument to also check the option.
> +	local opt=$1
> +	local ret
> +
>  	_require_command "$BTRFS_CORRUPT_BLOCK_PROG" btrfs-corrupt-block
> +
> +	if [ -z "$opt" ]; then
> +		return
> +	fi
> +
> +	$BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q -- " --$opt "

I'm wondering if we can use the "-w" option to replace the two
blanks around the --$opt (due to I don't know if there always be
two blanks), likes:

  grep -qw -- "--$opt"

?

> +	ret=$?
> +
> +	if [ $ret != 0 ]; then

The "ret" looks like useless at here. If there's not other place uses
this return value, we can use "$?" directly.

If no objection from you, I can help to change that when I merge. Others
looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +		_notrun "Require $BTRFS_CORRUPT_BLOCK_PROG option --$opt"
> +	fi
>  }
>  
>  _require_btrfs_send_version()
> -- 
> 2.39.3
> 
> 


