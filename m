Return-Path: <linux-btrfs+bounces-17973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCA4BEB400
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 20:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778931AE13D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 18:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CB8330317;
	Fri, 17 Oct 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYlYKfn2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632383090F1
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726326; cv=none; b=sZhUDkUDlGU3O2LqSk7UHFkj3lD+/ocjWX8mWH63n3qHQF4YnsnpjT2osEYUEq99B2csQozctsLySpXabkXTWjJxrZJm5zrb/GJHlq7tZK/itgXNOI+jDiduHcS2OVwDuKUq7gpiKhKr7SqyGGEpVIOP022fhXYV7LyRKetvvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726326; c=relaxed/simple;
	bh=SLpa/ja4YiwbWy8iOnOXxTO05IM1w0aQFwlbs8U7ERI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Blm/qQeqJ+kzErD46twtptNh3vyMNlpE6r1nCNqpscaoaK0XRbBzAMp38U9+S5B22jzDDMSP6lesW6kfzzLtSlPXBhquZXBcb7BqMKyYQpn0yTKoCibNK44Z1gKKqE4pLmj1kBH6lyvmtd+pu5XNZYk9SL4Csykm89nDTTluGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYlYKfn2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760726322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExpLnfaK5VsN9XkZ7Guo6bIcSOrzrOYWTg0vA9xfLp4=;
	b=ZYlYKfn2PAieB83hTbLGRCojLbT3iFzx9F1LVuPy0faC/Jxr3gCDnqGrD7gFq6rGi5X6n4
	ykrmni+3JzWnb6Ac5BEI3eRCl4fUpLBC1AOoQJdw9DIG/uR/eVXG/4r5d+//lDAoFhJ7zk
	hmKjiiEtcCBd358roE2qIbS72KX+SOc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-XQFK3qV8Nh-1AgyGCnBEwg-1; Fri, 17 Oct 2025 14:38:39 -0400
X-MC-Unique: XQFK3qV8Nh-1AgyGCnBEwg-1
X-Mimecast-MFC-AGG-ID: XQFK3qV8Nh-1AgyGCnBEwg_1760726319
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290992f9693so22276325ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 11:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760726318; x=1761331118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExpLnfaK5VsN9XkZ7Guo6bIcSOrzrOYWTg0vA9xfLp4=;
        b=Cd8d2gsUhv/K2ORWPQShi1uNoWyDFgB8lMcZxYv5CfblXC3SLdglUHAHWAOCVHjxKr
         lK8BOr1pvffKrGr6CFoNIaFXAgCeKLX+ZwTd4Uc+3EG/Nk3k9AkYd1sEEOBzv7A5vFob
         5Li52UDiVuL/OgLeyJPwEeeHFay1txohOZ0Fa1gBScnNjM8a4Uxxm7vx3AQrdZ1i6Yfv
         9DQQ+2s7S84z3spPxjlmFQJh5rlPIK0Wc05mJtxPCZJAUDlK1TSGLjFlalO3Wn8lQ5Yt
         CAWA9nObA63dOw6J59aVz06kUQ+P6fMaEQYn7hGrhnro+0nPVtKn6l1s9TJnt2wCWXp4
         bH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYA36liva35LB/4UVo8ISS+vqpp/kvuI5Bku/jQ4vp7zX7/ITIvW05ks5gAVv03BLD4o1MLWjveT5BQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxps2kVshqMThE0jlCg6uryoVPl1tJe5uANPWz1Hp8dtiS9q8Bj
	rgU+wfD9tEwH4bO6Fwe5708/RpH1t0dsVMLuVCbdh5CsajyDviDcNDQ6dmmXAf829Gh/RTgyyKG
	vgeRI/6wbSMGJV9D5OpquSxuWV0XD7jw0FHsQV6WcEQvyCuVmQ3rp+rKIMjxC2d/C
X-Gm-Gg: ASbGncsrlSz6hinVz/MzHquetEM5vgCOtxjeqOo24roDPPCRXAsV0262cVrcWHjnPlN
	8IxO8oe7l1on/MsXuSaSe20u3T5zI41dAOeTqT9Ff8C6npnz4eE3JwNhTEQwVuft2LFJ/ib4qrC
	aq7H2Wjoe4cIgbgsG2RAZ4NsV2OkTiyEB0DHBCvjgVPQGqsl141193YC1ICtJ+/KqRqDelhWEet
	Fwy0eZ/HC/DBYugfkWY3710qCSByZMCi3pLcXTydFSemHYETmASnbWFq/RaDfbAHA6fK0jq5Ohd
	mD+TkMutlpU2gLxFsRg8f0xpKu8j/VQIRze9hcZaGVzTp+8d2dP9ooj0bqmzjIwtfsg+AJdLAEM
	ZrJyg/04wsRfM0ikC1L4eC7WBL1CjEvg2w2h0lR0=
X-Received: by 2002:a17:903:2f91:b0:265:62b6:c51a with SMTP id d9443c01a7336-29091b8e553mr86886775ad.23.1760726318484;
        Fri, 17 Oct 2025 11:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlSps9FM2fsaq1q0PxHLN6Yrh13diUDUi+9KW4jhFsK/IZsntt/GxiVsHdicvvaVrGZmRupg==
X-Received: by 2002:a17:903:2f91:b0:265:62b6:c51a with SMTP id d9443c01a7336-29091b8e553mr86886555ad.23.1760726317945;
        Fri, 17 Oct 2025 11:38:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5c00sm1973365ad.74.2025.10.17.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:38:37 -0700 (PDT)
Date: Sat, 18 Oct 2025 02:38:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v5 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Message-ID: <20251017183831.pszgljhi7zwotslg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016152032.654284-3-johannes.thumshirn@wdc.com>

On Thu, Oct 16, 2025 at 05:20:31PM +0200, Johannes Thumshirn wrote:
> Add _create_zloop, _destroy_zloop and _find_next_zloop helper functions
> for creating destroying and finding the next free zloop device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/zoned | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/common/zoned b/common/zoned
> index 41697b08..313e755e 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -45,3 +45,55 @@ _require_zloop()
>  	    _notrun "This test requires zoned loopback device support"
>      fi
>  }
> +
> +_find_next_zloop()
> +{
> +    id=0
> +
> +    while true; do
> +        if [[ ! -b "/dev/zloop$id" ]]; then
> +            break
> +        fi
> +        id=$((id + 1))
> +    done
> +
> +    echo "$id"
> +}
> +
> +# Create a zloop device
> +# usage: _create_zloop <base_dir> <zone_size> <nr_conv_zones>
> +_create_zloop()
> +{
> +    local id="$(_find_next_zloop)"
> +
> +    if [ -n "$1" ]; then
> +        local zloop_base="$1"
> +    else
> +	local zloop_base="/var/local/zloop"
> +    fi
> +
> +    if [ -n "$2" ]; then
> +        local zone_size=",zone_size_mb=$2"
> +    fi
> +
> +    if [ -n "$3" ]; then
> +        local conv_zones=",conv_zones=$3"
> +    fi
> +
> +    mkdir -p "$zloop_base/$id"
> +
> +    local zloop_args="add id=$id,base_dir=$zloop_base$zone_size$conv_zones"

Are there more arguments for zloop creation, if so, how about add "$*" to the end?

> +
> +    echo "$zloop_args" > /dev/zloop-control

Can this step always succeed? If not, better to _fail if the device isn't created.

> +
> +    echo "/dev/zloop$id"
> +}
> +
> +_destroy_zloop() {
> +	local zloop="$1"
> +
> +	test -b "$zloop" || return
> +	local id=$(echo $zloop | grep -oE '[0-9]+$')
> +
> +	echo "remove id=$id" > /dev/zloop-control

Same question, can this step always succeed?

Thanks,
Zorro

> +}
> -- 
> 2.51.0
> 


