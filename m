Return-Path: <linux-btrfs+bounces-4523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8428B0D03
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E363D1F26077
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBD015ECDF;
	Wed, 24 Apr 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGLasO2C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C715E80A
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969938; cv=none; b=AcT5/vsK+q+iV0oyi9QMALTKopAJSeOiobIl1nU0wBmPXCESs/Ea3Y0grjv0/l7DBrKoHL3fUICGGMkkc+PTI4FcahNS34E8SJ/VI/Tq3ZirRLsnHB3PLND4Rn3EvpMfQMfutUGS2L11A8JBtMhNtVmM/UqAIpXyZaGZmA1LDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969938; c=relaxed/simple;
	bh=J6/VLYbG/5OVoSAgZ/WX2BX4XS/XvbDqOthnQd0BrjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkexYSeTO+6qe7sdj6t4SFXHkDc/X5QuexPymtZRJuiuxSWNlIdgn+vRR/swTE6fUEpVpirnJciM4tWOaN6nPUC3E/oYE4oZwpigBmfrnhuiwvMEDS4PWTio/92hwUgUtIE12sLvN5weGfcawzhkVJ7p5kOjoPNgpDPTZ9pe58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGLasO2C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713969936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y33gdq+Z/2zAGSps0axIDnlhQq1YN7Uu8WW2CuewFoo=;
	b=JGLasO2CZ+SH20i99xxhSK6o3ndBauAhBPpWHfG6cUq2NEHGEyeidmE2gZqUtTHvkwVWqT
	tKLyPpJD+fBLuR8ZZl0SzMTEUO/mZfuYSQCOrKWeJur32kz956hxF9K5ILR4QhfJe28iEx
	xSDwF34V6pJr4AUnCvbFfaP0kLgegos=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-PDMhzSEcNSGHLrIfMk08oA-1; Wed, 24 Apr 2024 10:45:34 -0400
X-MC-Unique: PDMhzSEcNSGHLrIfMk08oA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ed25e9b34aso5457302b3a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 07:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969933; x=1714574733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y33gdq+Z/2zAGSps0axIDnlhQq1YN7Uu8WW2CuewFoo=;
        b=BWiLMae0XAawsKJHBjaKjic95YhLde7U/FCo3uYh0p33tAagma32XSqzK0/QheUy7L
         6eTkB2oT06vNnEhHHBDMmDGV0jYVhIb2P0FNeAH7vhexMcz8W6ct5paqd8+3vO5251US
         pAlauHR0kyjbCXi5LuMlON9KJ8OyBpK2YVOK/61ph7CAJFy2gH3EaeKGh/NA1xgUlf5k
         am0PRChZgGr66uuqhVl4BpJSzWmE3u+zruiUgjXwjnWMB6A49fAk0ch+rfPck/NY8y0Z
         Q+3cROfh1qDyQZBrWgOxFLJYFlW8lJ9SWN6fw1EZJMVoQBdlb49Z7M/ljBSAg3Sx4DYa
         ALVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPnFHaGeEfRrGETbT5of4QT5efllBmBohIgWn7VK1pI3dVI/Cvb9SYNnHGOA37MKlm/E8/GeVNRRPvJwcEkfm2Gn/vr5aqp13UEsg=
X-Gm-Message-State: AOJu0Ywvle9W0Ltr5HhfNC8ElaWt+XOywFwUUvjwa3MFyY++UgBwhUxJ
	lHHQ+soBZsDcQvqIjxRymRpCoF0+XyWXTGwaBMEotHCtSuPACplPRv6F7ogFsScmm8SUL27Tl6M
	pWZStL5ySSw94y/ORgp/+BsgU3aaroLCAn5y/DUg2rtp8pyGfxl9S82oXI3fi
X-Received: by 2002:a05:6a20:104c:b0:1a7:186:a176 with SMTP id gt12-20020a056a20104c00b001a70186a176mr2077857pzc.49.1713969933493;
        Wed, 24 Apr 2024 07:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH3ZSXBO+4EuFuKo8dVmBgzcP2ucUHtacMSJoo/tRDtDEzxD2IAfURXynrARUfEi0Wi/HGsA==
X-Received: by 2002:a05:6a20:104c:b0:1a7:186:a176 with SMTP id gt12-20020a056a20104c00b001a70186a176mr2077836pzc.49.1713969932975;
        Wed, 24 Apr 2024 07:45:32 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000a9300b006eae3aac040sm11511059pfl.31.2024.04.24.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:45:32 -0700 (PDT)
Date: Wed, 24 Apr 2024 22:45:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Subject: Re: [PATCH v2 3/3] common/verity: fix btrfs-corrupt-block -v option
Message-ID: <20240424144528.kd6k4uoh3wzip36c@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1711097698.git.anand.jain@oracle.com>
 <f19513c267884160a851edf76d941df423a56fc7.1711097698.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19513c267884160a851edf76d941df423a56fc7.1711097698.git.anand.jain@oracle.com>

On Fri, Mar 22, 2024 at 04:46:41PM +0530, Anand Jain wrote:
> The btrfs-corrupt-block -v has been replaced with --value so fix it.
> 
> _fsv_scratch_corrupt_merkle_tree() uses the btrfs-corrupt-block
> --value option, so add the "value" prerequisite in the function
> _require_fsverity_corruption.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

It makes sense to me, as an option is changed. But I think it'll
cause _notrun on old btrfs-corrupt-block command/version. If btrfs
list feels good for that (no objection), then that's fine.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/verity | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/common/verity b/common/verity
> index 03d175ce1b7a..59b67e12010a 100644
> --- a/common/verity
> +++ b/common/verity
> @@ -191,7 +191,7 @@ _require_fsverity_corruption()
>  {
>  	_require_xfs_io_command "fiemap"
>  	if [ $FSTYP == "btrfs" ]; then
> -		_require_btrfs_corrupt_block
> +		_require_btrfs_corrupt_block "value"
>  	fi
>  }
>  
> @@ -402,7 +402,8 @@ _fsv_scratch_corrupt_merkle_tree()
>  			# in the default filesystem tree (-r 5) and corrupt one byte (-b 1) at
>  			# $offset (-o $offset) with the ascii representation of the byte we read
>  			# (-v $ascii)
> -			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v $ascii -o $offset -b 1 $SCRATCH_DEV
> +			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 \
> +			       --value $ascii --offset $offset -b 1 $SCRATCH_DEV
>  			(( offset += 1 ))
>  		done
>  		_scratch_mount
> -- 
> 2.39.3
> 
> 


