Return-Path: <linux-btrfs+bounces-12689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7DA7671B
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 15:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF181886792
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7D3212B0C;
	Mon, 31 Mar 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwesKVNh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B16211A16
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743428918; cv=none; b=FSxzUPEXEkJZTyDPGucpZc9h7uW1mh7bI0D7eXc5XjaFqZaRCZpe3eonlDxqucddbYfrRoWuGS0J2xsRzDoJyytK16GhhB5whR3QPVYnrjeLYGonW0ayFCvhzm/58h3qv2GDZXEcss9w2ung89Ty/hoSCZiQrm/roqMgNXQcfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743428918; c=relaxed/simple;
	bh=hfHXqtCM9g3kme35ZkfKhWwanTOeUWoZHrNcFTF+P50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXt3FX1xFMLp4KEAI5Ko0i3HyfeWAP7GnmZcOfk5YPu+xSDapuUY31KQjWTW9O/o0+QT5wZydcJFMK3o8GYHZTnx12muXUA8VjNI2vVixoz/F9Us8/V4fWe4RO7tUrGnCiPsNMRMaTuNoN+/zzmzMISx4V4XoxpbEQKMjRHrTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwesKVNh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743428915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V6YWlaHb/+sQxHYU09XE2mXXZQH2Pq2JQG12aswrcG4=;
	b=XwesKVNhNJvo5DELzoq/VUVpfFFvciwRxPL+7RPQwNEDbCbuJFwv8pB47bQSR01tz9UAX+
	5yr1w4I6X1OJof1dT9W20ryUcFlFPkcN8Z2Glaur8qLH1faId/m3MHx5OXQDGS108D3Ul+
	VP+i+68ZSgii9LcxqBDB+tRiyraE1mA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-EzzILJdQMaeQ-HoFW5TczA-1; Mon, 31 Mar 2025 09:48:33 -0400
X-MC-Unique: EzzILJdQMaeQ-HoFW5TczA-1
X-Mimecast-MFC-AGG-ID: EzzILJdQMaeQ-HoFW5TczA_1743428913
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so7936368a91.0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 06:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743428913; x=1744033713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6YWlaHb/+sQxHYU09XE2mXXZQH2Pq2JQG12aswrcG4=;
        b=FoVCaZnu/OPuMTj3QYKZ4eKgfgEshUfBgZNwlJxj9A0TwLPzw5noLLaceCxTAEeMwb
         bMrAgkbksaE1mclblQDFcSiDErHWaLif/i7+CFzAg8Aj1lf7RIwtHM1YOlImAfOJ+5JE
         w+kIwxuWHvaBW8E3z4/x6rLFDhlEwJOaz1U8gy0hgKfCutSTCrpM0hxSddJg+gqgmYal
         bLmWxk6R01+0sE7tw7r4q2MIId9yrTGiC2rZZ+bdU3Iwd8iJ3dnBLmwkS62NHzC9pjID
         7mLdoaj8GFoQiOpRwUrw7uv/k+3ABacRogMJ5KXlzjrvnwPpyscs6NBU7HBKfgtNHuKB
         rmQg==
X-Forwarded-Encrypted: i=1; AJvYcCWfzRtsAHMf+zaBYteVGkrt1mlDRBoGr1fiead7Exh6bVTxLS15+S1V9+KCgtcvHwfkocTlJRLEMzY8JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtb0IIFV5DIAiA3UVqg87XOHvB/rnEyRoGc7GILK3ndSNVSqf0
	gG3SGadM2I9X8LERU+HALse4EugBV5RTZo1vVceNc2rrd9+ctYUnHTyhu5qnOw8lZoEOpNYkoPY
	W3kCinsk0BC0DeiyHbZPzXPxVE5bvX++CVOK47dZu3p+jXoPGRChFugP2VAdv
X-Gm-Gg: ASbGncs7CS5nKa6LgSXAQZQD1M4Pgvm8EIAHnJCqtfWoFmmj8D+hb0DdKq+FUjdjef+
	IxEQ8k4vizayacheY8LCAH5opJYJ0r+pXNvFUp5jfDjfV5O0JWn7fb/hAFbBncwczTmpXMmyrn0
	ywQbrypjSXu6ePr2TLfiOPy7D8bVYlpvDegnkyxgC/S2jRGfcxvylHJ0B4KJc3gP15oyxprqZor
	li1fHcF/vDtEpqHJ05vmc7v/Vmch8CbbrE9DIJB9lXjyGAHOJ/RlXsPxR7S5E6rn/CM9oA0KLFc
	I8jQCunrhhA4gRXP60+PCpGR8DMnhvahQFjNoKsFBKbpWUuR7RQKB8UJ
X-Received: by 2002:a17:90b:2e4e:b0:2ff:618c:a1e9 with SMTP id 98e67ed59e1d1-30532153717mr11908701a91.23.1743428912864;
        Mon, 31 Mar 2025 06:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQKSNhk8NiYd8Hn1ZwyKJ6CjBpwAC/RgBvb3iPW3KMEFIllNvo17+flUhvAe5tyvFxT0OTlQ==
X-Received: by 2002:a17:90b:2e4e:b0:2ff:618c:a1e9 with SMTP id 98e67ed59e1d1-30532153717mr11908676a91.23.1743428912537;
        Mon, 31 Mar 2025 06:48:32 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b6cfbsm9518248a91.47.2025.03.31.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:48:31 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:48:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH v4 1/5] fstests: common/rc: set_fs_sysfs_attr: redirect
 errors to stdout
Message-ID: <20250331134828.atadwmenvglahjrk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
 <cb5e54259bcd2bd6cd310ffa2411a79370698f61.1740721626.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5e54259bcd2bd6cd310ffa2411a79370698f61.1740721626.git.anand.jain@oracle.com>

On Fri, Feb 28, 2025 at 01:55:19PM +0800, Anand Jain wrote:
> Redirect sysfs write errors to stdout as a preparatory patch to enable
> testing of expected sysfs write failures. Also, log the executed
> sysfs write command and its failure if any to seqres.full for better
> debugging and traceability.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index c7d7dbb8e93b..59af83a01e3a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5181,7 +5181,8 @@ _set_fs_sysfs_attr()
>  
>  	local dname=$(_fs_sysfs_dname $dev)
>  
> -	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
> +	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
> +	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full

Actually I doubt the $seqres might be not defined before calling _set_fs_sysfs_attr.
For example, we call _set_fs_sysfs_attr in ./check as

 _test_mount -> _prepare_for_eio_shutdown -> _xfs_prepare_for_eio_shutdown -> _set_fs_sysfs_attr

The _test_mount is called before $seqres is defined. At that time, the $seqres.full
will be ".full" if the FSTYP=xfs

Anyway, we can fix this problem in another patch, this
patch is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  }
>  
>  # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
> -- 
> 2.47.0
> 
> 


