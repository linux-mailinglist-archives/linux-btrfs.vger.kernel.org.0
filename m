Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35191549A4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 17:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBFQuB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 11:50:01 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33825 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFQuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 11:50:01 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so3170516qvf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 08:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EsboVX+Q83iwwmS3c/xaIgQlo5LvdhtMp+9KmyPsvO4=;
        b=YRZLjr5ZARRYd0zuAL2hHzx4Csb6S+XbNNBbB250P9NEkQPK7gmbyFlDUN9Lbe7ArM
         ZzuuLe6lLU9VbaLX67bPkYzsGOmb8iwWC7odEJxSqFWq2SAUjBEW5IZwCybYFSZYi/bz
         +AI3p4rcz+vw+X1Ymo5HKu5tBkkfVVStDrPESIjx166UL+zttI4qtQLrXEH50I/Jvof3
         LA7KidYfDCf1MzzyQo2S4So7Jjfvh34cL97ACkb+eaPxIGleJSgcm//t1odrY+bISvJB
         2DmrDkgK3sSh1EdDScCPC/+CEsKiFcHnwI+R+rRgZ8aooQzeKU0NkckLN1eml7V9EWZU
         rmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EsboVX+Q83iwwmS3c/xaIgQlo5LvdhtMp+9KmyPsvO4=;
        b=PnOGo/J2vffq6UZHEepEk3LycNj+9CjUiME5HLowGpH4ikPnzFoIbWRi9jOLE8PyLH
         npRTsrkh2lR2Qm9fuN5YmueHHa8TeciyFBJ3fkgqx15B7UDVx8JDiaOwncFClteuo26D
         b+j4AhHQE9PuJBkyVaejCGETw6+TAU7z+h0jNry3u3xY3a8loYU1D1xnYK4xkMr+tsqM
         cuOVE9WsgRuEhJCj685yXoamm9Ugrz9S9uZxcTdOMZNzxI/SxBlzqGEwvOW6KhB2m0Yb
         NqsjMlHJuHiebbtHAYiNf88hauAdtLVunp9mrnVbHL/lF6s+O8JWsyKEIqawPPnWv50s
         rfiw==
X-Gm-Message-State: APjAAAWRAf2rJM9ulQuB6cc8hrU72xS3jdsFPh9S/N3PGPSNhBQw1Yqg
        iXt592tlIhF04GmX03elZE6SAA==
X-Google-Smtp-Source: APXvYqzLrNmT7nXUqV7mBWvfxlOKm1wqPOcIb7wYJ85O7FqQq3gHSJrltGtGRzUEaFlRXCfiql9B0w==
X-Received: by 2002:a0c:a910:: with SMTP id y16mr3176907qva.139.1581007799952;
        Thu, 06 Feb 2020 08:49:59 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k37sm1013028qtf.70.2020.02.06.08.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:49:59 -0800 (PST)
Subject: Re: [PATCH 08/20] btrfs: factor out create_chunk()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-9-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ce201812-22c2-9799-f453-780a5b16e49b@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:49:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-9-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 5:42 AM, Naohiro Aota wrote:
> Factor out create_chunk() from __btrfs_alloc_chunk(). This function finally
> creates a chunk. There is no functional changes.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

<snip>
> +
> +	ctl.start = start;
> +	ctl.type = type;
> +	set_parameters(fs_devices, &ctl);
> +
> +	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
> +			       GFP_NOFS);
> +	if (!devices_info)
> +		return -ENOMEM;
> +
> +	ret = gather_device_info(fs_devices, &ctl, devices_info);
> +	if (ret < 0)
> +		goto error;
> +
> +	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
> +	if (ret < 0)
> +		goto error;
> +
> +	ret = create_chunk(trans, &ctl, devices_info);
> +	if (ret < 0)
> +		goto error;
> +

This can just be

out:
	kfree(devcies_info);
	return ret;

and all the above people can just do goto out on error and we can drop the 
error: part below.  Thanks,

Josef
