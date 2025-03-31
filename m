Return-Path: <linux-btrfs+bounces-12690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 821B6A76722
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD5C7A4903
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67920212B3D;
	Mon, 31 Mar 2025 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeVDLwzU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFB211A21
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429205; cv=none; b=E4vHoY7ntbHGweU6k+t08BwgILGHtyev58/Ae/jkTIXxU1NSok9hWUjod9CKvQvWiwUM26jAv5gPw5CUI6NO4UpsbnpkOuruz0p/R6bcLshHjYmM8PF1iKQTAKYSjDZ7ZE1YkHlgwn6Unj54YVbnf7iGBTrSGZ108rNxM5YuPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429205; c=relaxed/simple;
	bh=Epbg3tX+e++/J3j0K5iwu29F/ZAM8FRe+mjxJntxnso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe0DUAF2bjrVS2SCK2swKaRqoWPM1prv/Qkc73b1Re7+xdRVq0S970YRnvoMyzFBF1sDQiuztnK/zajZbX+hVAXpp7pf32hHtMJeeYO25+J72hRZ9sg5tfrspAAdU402IS1845MWBGVDKm2PxI2qwsVC2wsqu9GAt/+Y6H6ym3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeVDLwzU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743429201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJ5ci9d9i3QAlE9T7loPNwrkyVC7vDvJhOYZE9V+VB4=;
	b=NeVDLwzU5djMkh7Vm3T0aFHLFQWTPYBi/Bir5yJOh1qIPTzrsIVSOE8tBhtlRQRBUbL3+H
	pgB4iIBN4iVtsbMHdUliVuZ9Rc9kDu/F56mk0Q3CutdmHO9tZ9xBNARGqbWB0B179iSEO1
	S326x42EIuI/QW/3CCcq6CyM1cp6TTM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-4NfXdQlkMjq0u57Xwy5OLQ-1; Mon, 31 Mar 2025 09:53:20 -0400
X-MC-Unique: 4NfXdQlkMjq0u57Xwy5OLQ-1
X-Mimecast-MFC-AGG-ID: 4NfXdQlkMjq0u57Xwy5OLQ_1743429199
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2241e7e3addso70473875ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 06:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429199; x=1744033999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ5ci9d9i3QAlE9T7loPNwrkyVC7vDvJhOYZE9V+VB4=;
        b=a6ngBhoZWVgcYHcLScnQKgjkmmfod5jZYBmzPlwtdwtm+3MLsibXF/UnexylYfVjxg
         3xQQs/CoYfm7vhmha2WUYZJBtSfju8NQ1LtIPHT6rCeJHh8diQtkFIb9i6nNJbezm8X8
         GeDKHl2gMP7cyOIWSepvpS3plNmJLZ/5wInhLl/Jhth1IU9+M+0C7dTvmG5mULgLKVOw
         qZJc7YETpZK/2Ie7ULT+daEPsn63WiDD9pR6m3nmaIei9U1iVA2tsZGywvgmSdvbDsPl
         Eov1NhA/cqzAOqU5MigBs8axFQuJapON6hlGjwan8s8Z4GA7qxQOYuaWmc5MER2lLIdl
         lHGA==
X-Forwarded-Encrypted: i=1; AJvYcCV0xdFlbI5yFPbyiofpv0fXT0iHSQCBoOUY9JBSPtRihVoxXvExg7cF663LNFLl1acnQLyL476kv4bfBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWGXcn+0V03Vfq13baT/2tiMe3O7rDYsxrNYHj+S3SeCiN0TCR
	mFaoHe1fihevUR7uTvGtZI6Pk5TssNNUdYML3rlMy5i3S6RL0Y9oXwq/sToy/mCb3bjC6Smf/Hu
	SCfZdxq6h99pR9jZ2ZWle8Z2BujXC8cSGYsWAhx0sEjG0FRdmivxLA5UvLptTRtr6+WEASP0=
X-Gm-Gg: ASbGncuHvvMfn1/fXk7uQjyjuWxCOd0xxDuTFGvfiTxkhKxjBEN/Zqft/SfoRUXuPd6
	b+Aa/Vj/T69m6nXsSbs5GidRvpFPXrljw54/965ZfkEFm6Aknv2qVhQvEBhUBYviuR+oaGrqoWC
	4JzedH/RjO19Sfzqn6kk4pQsfhhtMKyqN8mYFaFUU9cYkd4mx++jkEWQVfjaMJHtJWkQZgTVe+B
	JEQ53em20BVmYvlHL0yBt+zd2TicdKntSaOvvkUquNwQfjSc3fPkBvfGeLzTQuw5wHk6F4rAiW5
	G6iei64HR8fJuMX4rTQo7otnBwYnpQHyAY6jeVqS5ptx5zWyjB0Xb4fM
X-Received: by 2002:a05:6a00:138e:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-73980324787mr14752166b3a.4.1743429199000;
        Mon, 31 Mar 2025 06:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfGE6aMaC2DvBG2/2NeEPugbdXkF+GdkMUuSthBmFuebO92LsscAWzBiMR3tYsuZjKgRrtuw==
X-Received: by 2002:a05:6a00:138e:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-73980324787mr14752128b3a.4.1743429198576;
        Mon, 31 Mar 2025 06:53:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e271absm7189063b3a.51.2025.03.31.06.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:53:17 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:53:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH v4 2/5] fstests: filter: helper for sysfs error filtering
Message-ID: <20250331135313.znre7np5vss3hrl2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
 <c8389fe873ff3cbf68d1f6b5a6df8d6fc0645f9f.1740721626.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8389fe873ff3cbf68d1f6b5a6df8d6fc0645f9f.1740721626.git.anand.jain@oracle.com>

On Fri, Feb 28, 2025 at 01:55:20PM +0800, Anand Jain wrote:
> Added filter helper to filter sysfs write errors, retain only the
> error part.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/filter | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/common/filter b/common/filter
> index 7e02ded377cc..44ba2b38c21d 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -671,5 +671,14 @@ _filter_flakey_EIO()
>  	sed -e "s#.*: Input\/output error#$message#"
>  }
>  
> +# Filters
> +#      +./common/rc: line 5085: echo: write error: Invalid argument
> +# to
> +# 	Invalid argument
> +_filter_sysfs_error()
> +{
> +	sed 's/.*: \(.*\)$/\1/'
> +}

Maybe output the "echo: write error: Invalid argument" or "write error:
Invalid argument" is better. But as there's not more requirement for
this helper, for later two cases, this helper is good. We can change
that when we have particular requirement.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.47.0
> 
> 


