Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5473CED62
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfJGU0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:26:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46792 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfJGU0Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:26:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so21106697qtq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pWqDYt+vsKqBj4PxqTG0GN9ZKUFhJilJefNqRSNOdXU=;
        b=lFU77jbRMdB5P5prl/yIcefMvA/BKJN464imlBTzowkoczv7oA5nt9hIMdGypVd8Um
         6HloSXwgVR69HQItXvMp3ZRp/hnyOAJS/6zijRoTQT8Mw57u3nJzVgRbbvRrMa/OwYPJ
         Q30H+CUhpButQmtLFxpp7/RIi/gzfYtDP9AENQ1WBUO7sBMWw+U1yhBsxLHQDuFMmKPJ
         aSRVzmmptpWkwXiB24juUnkoazpNPVWgfRjDtzRc5Fh5YnWqlTXWGd4SDGU4IIkleR81
         /2oa9QHT9gQhPIX/tWRhr33gFVo5iEfNJ3wcOpFk1rK4s69Loa2I4yXR1W6oQ5oj6VzY
         BU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pWqDYt+vsKqBj4PxqTG0GN9ZKUFhJilJefNqRSNOdXU=;
        b=gWTVwQrRYexH5nF6+NWCzBap/CpcNAA2HClBNMiRgqzEFUYFT2CH3XvBPVFbJi86XJ
         KX+khludk6KEeCdFDxQU3rroMbL/X1AP4KATRKA8PDGovSSmmBlh65a9Qt5dT8A7UR4g
         3VGjDR/yZnsi6OPBmrcQjc57VRiJjkxw31AynGl+pZLzmB92KXLsmIj+BDHjzTCjMzDb
         UwEdUq17DjaHEJOjlt7B49/r+n5htJTHLH5FcMbsLxJZ0oh3BANq2jfXwCgRsKZujVu1
         ihwIGVrNWC+Zhvt5p7TEpVz1ov8tGhh9qL7Mch45q1vBNpH82pwHMz74TunoTSJRbcDL
         qKjw==
X-Gm-Message-State: APjAAAWlr6zNMUlqO6TLoVKSU1ZgUaLFKcC/xa2nDqjr6iWnp0vlp/YK
        C50djJ4Bt2+E4tIy0MpNetw45A==
X-Google-Smtp-Source: APXvYqy5osbwcIi/xtU81gYnZB9XOGE9n7O25GBvz95v3GZfTQFA99gvOv6I9yyyCWl0zAKCW0ZMyg==
X-Received: by 2002:ac8:7b97:: with SMTP id p23mr31790077qtu.292.1570479975301;
        Mon, 07 Oct 2019 13:26:15 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q207sm8907940qke.98.2019.10.07.13.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:26:15 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:26:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/19] bitmap: genericize percpu bitmap region iterators
Message-ID: <20191007202612.mer74bok5ymyxae6@MacBook-Pro-91.local>
References: <cover.1570479299.git.dennis@kernel.org>
 <d2efb06e5e5400007a709bb1269b25e16b435169.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2efb06e5e5400007a709bb1269b25e16b435169.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:32PM -0400, Dennis Zhou wrote:
> Bitmaps are fairly popular for their space efficiency, but we don't have
> generic iterators available. Make percpu's bitmap region iterators
> available to everyone.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  include/linux/bitmap.h | 35 ++++++++++++++++++++++++
>  mm/percpu.c            | 61 +++++++++++-------------------------------
>  2 files changed, 51 insertions(+), 45 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 90528f12bdfa..9b0664f36808 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -437,6 +437,41 @@ static inline int bitmap_parse(const char *buf, unsigned int buflen,
>  	return __bitmap_parse(buf, buflen, 0, maskp, nmaskbits);
>  }
>  
> +static inline void bitmap_next_clear_region(unsigned long *bitmap,
> +					    unsigned int *rs, unsigned int *re,
> +					    unsigned int end)
> +{
> +	*rs = find_next_zero_bit(bitmap, end, *rs);
> +	*re = find_next_bit(bitmap, end, *rs + 1);
> +}
> +
> +static inline void bitmap_next_set_region(unsigned long *bitmap,
> +					  unsigned int *rs, unsigned int *re,
> +					  unsigned int end)
> +{
> +	*rs = find_next_bit(bitmap, end, *rs);
> +	*re = find_next_zero_bit(bitmap, end, *rs + 1);
> +}
> +
> +/*
> + * Bitmap region iterators.  Iterates over the bitmap between [@start, @end).

Gonna be that guy here, should be '[@start, @end]'

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
