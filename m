Return-Path: <linux-btrfs+bounces-18021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A68BEF586
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 07:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCAB189AE86
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 05:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3992BF007;
	Mon, 20 Oct 2025 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgSBtKMi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D91EB5C2
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760937313; cv=none; b=QGXrA9KB/FgeyKPX7qg230u4EctDgH1/SKJslvkDLyKljoHGJWcEmHUWSjRPkJKjkXHh/AylLpZRSSys5Mp8SDX/AZ7fzHlzl7w2lkOscyPEe72qKnGOvOOP0hESnd02FrR+LrB7VqeaH6z38a6dkG2zp+aHt/2IbTE4iq2zLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760937313; c=relaxed/simple;
	bh=Z6+ImmeDV0LNyW8fUWfwOI5ejYfngJeHisrNK+MFll4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSTsPdQoCMaHlBwS9j998ueQgAnUDixyCtyPL41btNKrIT8zZ5xDmgQBo14sm0mxHwSY1NxCuWrTa78rqAuJ74mC4BKr/3xe2musMRegate0ie1ZEzsgEshwQr+tacpgyTtAh/nbgLX8sMxj/mh+bG32JMHz0AELVSaV8MJZ5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgSBtKMi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27c369f898fso57798905ad.3
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 22:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760937311; x=1761542111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=to20Fz69HzaFXBLRP91Nt7sJNBzjM9vSXs8ayG2MjmU=;
        b=PgSBtKMiBz86yRJ1rga9+tsngyznix8Vj6BZM688ZOvWt3rk3Zn00IjoBGSzoMQNUd
         gaUWsJBPWfzfrUye7PF626pSw+4YNmiUGxTmBomji2HKwExXIYoUrnbMVzrlzXTl6YOl
         fy6EmHhkiTQoxmRXzlc4wrTk7Tt9vgKiV2O7AKNTlDl9RtIoaPWNdEY0L6zBtt/6pFH3
         tMCT8zs/ZF3mXdKXK6YWMZoMVoiLZ2NnRR2CcLQWXocnnXB4XVvuOIzQd/tGGyxaSF5u
         HYZJ8oeRR5OTgb5Ibl46b8BN3u7sg4HF4Tmv6qGO40/Efcs5x4DBAxF25X18cyzAM/Qz
         K6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760937311; x=1761542111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=to20Fz69HzaFXBLRP91Nt7sJNBzjM9vSXs8ayG2MjmU=;
        b=fnMRrpIN1Q1PGDOaFaf250TpsrVXyHrmpGK95jqy+LGOv1rUpOurBhTHfzNRZ3xZO2
         1fl+BVEgTQsmCeNxrCwgQzrcxs95AwYNOoJ2nu9z+brzEXE0t7hmiizHcLNpWWSD+MOG
         DVY4hqR+m6qIIi7qsMyU3UcSxOgfgBdLbDkdOgFtxqfUo5HuWwTGWPZ8LUKaLKOUEysk
         nxs9uTsxGEjszYl4pIVNI7BkwUIrztYd+w5iG4CaK3Bseo4ZmRuhziaADyuVQkp4o4uG
         7DlUI6E4S3bCvSFohXCufrOEnyqZ12Z0kW6eCgze2eeCWqn+4u+LyAdCtaS1BpoTIrkn
         pfGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWff58K0+q+N4M9+qshGiMDvzhCs5+XLWlhSv7NPoa1pDweaoxRaIkNRVTdMmGqOoQncv4M1vO2lhD/3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1GEh2wOanIXnQ6OQO3225gxZ+zvUcBlfuOsprHEfFEKyXx12
	ZmD0c/XCHlrRdHaBWSUqKkA1HS26Ez3AQOnsigTRSVQEeliW/rqJhJgv
X-Gm-Gg: ASbGncsdnYpKRPqfL+ZfU3S3p92Vsav7pT2wnoFnrQ3qsjHi9KMLtZ3t/bkczUrCz2u
	bc0XTvq4ij70zuN69Xpx6Mpbg10eRzVXDfUdnTZj1TlG+pns+Za83qQV7qEAIjZOxWjVPcI9iAk
	JL7+BD5J8sN8YygB62edI3FM0zXiz24Fm07Fcxyonj1pGd+PwucFZs5gRcVp1Zlekcc2kEukiua
	Bv7CkMu3ojjE8Nlx3qwgczC/RxymJzZALR++nc6FjEnhWeiSZyQsjfOXklO70v5FCu5ImObMJzu
	/yOaCUjED8d2KrU+BRwcfzlxDYijhv43/bU49r8xriQc4TzKuhk275SVqFYvsrD3avghVxGPbS8
	ghri5SFQ1z/gVX1SaiVb5tAnwXY84HfDop5gdOInQLFqlKWDI9NuF0wwcui6WU/JWQ/89uPjHhq
	TUGTPWpizzIT3uUwmwnoCwXwbieSNKL89Tz4SFRC8VHXVp5w8=
X-Google-Smtp-Source: AGHT+IFOVPrFs4XDwOz9Wf7H8WI7AAA1vGzGWjLg2Hnv7m8Mqy6Gk9sdtib3KWNcPHTmSYnf4M49Ew==
X-Received: by 2002:a17:903:240a:b0:25e:37ed:d15d with SMTP id d9443c01a7336-290c99b11femr143543635ad.0.1760937311136;
        Sun, 19 Oct 2025 22:15:11 -0700 (PDT)
Received: from [192.168.50.88] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247219457sm68958645ad.113.2025.10.19.22.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 22:15:10 -0700 (PDT)
Message-ID: <07fa286c-23b1-4ca7-9019-47631e2af908@gmail.com>
Date: Mon, 20 Oct 2025 13:15:07 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 Hans Holmberg <Hans.Holmberg@wdc.com>, linux-xfs@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
References: <20251017055008.672621-1-johannes.thumshirn@wdc.com>
 <20251017055008.672621-3-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251017055008.672621-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/25 13:50, Johannes Thumshirn wrote:
> Add _create_zloop, _destroy_zloop and _find_next_zloop helper functions
> for creating destroying and finding the next free zloop device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   common/zoned | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/common/zoned b/common/zoned
> index 41697b08..e2f5969c 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -45,3 +45,56 @@ _require_zloop()
>   	    _notrun "This test requires zoned loopback device support"
>       fi
>   }
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
> +        local zloop_base="/var/local/zloop"
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
> +
> +    echo "$zloop_args" > /dev/zloop-control || \
> +        _fail "cannot create zloop device"
> +
> +    echo "/dev/zloop$id"
> +}
> +
> +_destroy_zloop() {
> +    local zloop="$1"
> +
> +    test -b "$zloop" || return
> +    local id=$(echo $zloop | grep -oE '[0-9]+$')
> +
> +    echo "remove id=$id" > /dev/zloop-control
> +}


Reviewed-by: Anand Jain <asj@kernel.org>

Looks good.

Small nit: The function bracketing is inconsistent in this patch and in 
the file as well. We should fix this separately.





