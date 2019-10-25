Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E02E4AE2
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 14:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504433AbfJYMRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 08:17:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43883 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504406AbfJYMRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 08:17:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id t20so2832874qtr.10
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t1b/Voxr+WrGR5t1j8rjWzZ+jNbJ80h+rutQaiCpLFQ=;
        b=X1k/J8JB7vWmxlth5UPyXV3uX5/qDpGhd3yj7jqRGvJBCkFEyO/OLihGPMPWifaPF1
         OGReLWdV4kKmBeMIP1lu8VyDPN6qJpQptgygFK2jQtuVfhNA3tAhBl2tjNUE0MzkJia2
         DnMlQrax+JeBGe/BqSLVnW78DcNpc3sjIs3222Yb0dkl9dP4xEnbjbQVyqkXRaNZLp5L
         t2LGhy4ZKDHHEn5aOuRRumpb36fA5eQuFomhYANaPDHPASpPWb9ikxOFN/lEL2yE91qD
         CZqWmsPiKU3I/WBLfx5Ew1JU7u0TAkpNTUs0OPJGzF0O6lFmIUhS9a6rCrQ66GlFOd7a
         3W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1b/Voxr+WrGR5t1j8rjWzZ+jNbJ80h+rutQaiCpLFQ=;
        b=grFMww+Kn3NvoWISavzeVeOwhV9igK5ORA4vFa6Z8TnKm5Bq93c1Y2rsw7S6iB6Kks
         En+zpk5KwsWOuNTKBmqofAyq8+2GtSfUYWFDvb9chnvbNhmPVG0Tct1wsEkYAQa2bYW+
         YDyt701sgtOLnRjmyswWKxPKuUqeczrMRhcPpuuDZD+vvhtdlLhMVCSxYy9jEB1CfKgn
         hKG7AgTfJOMYMmRSJLRJHwlzLKzU+IB6sP+/qsogvskJHJKS3ks1hi2IGSPTtttwWnLs
         2N17433BnBjTm851dxIDYpzlaPlqCkKBuxFXVnaGycJsxoCXjmJ14Tu57h/SPKIxRK3K
         zMlw==
X-Gm-Message-State: APjAAAVy5FXRpCwrHdRCgIZvCxi3Fw0zexAeaJw8RVJIwWsXNN+BkeGD
        dNkK/Lh2EixdPBW9wDTdgaoC8A==
X-Google-Smtp-Source: APXvYqzbuW5Qa+FKzx4Fu3k8+ePKMKbXqkYE/tYNvZZXLni9fkqa6w5HRLKHwbldosZScA/s477/7A==
X-Received: by 2002:ac8:cc3:: with SMTP id o3mr2718019qti.239.1572005837734;
        Fri, 25 Oct 2019 05:17:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fad0])
        by smtp.gmail.com with ESMTPSA id z8sm944473qkf.37.2019.10.25.05.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 05:17:16 -0700 (PDT)
Date:   Fri, 25 Oct 2019 08:17:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] btrfs: volumes: Use more straightforward way to
 calculate map length
Message-ID: <20191025121714.jz5kda2w2lp6rxj6@MacBook-Pro-91.local>
References: <20191025085956.48352-1-wqu@suse.com>
 <20191025085956.48352-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025085956.48352-2-wqu@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 25, 2019 at 04:59:55PM +0800, Qu Wenruo wrote:
> The old code goes:
> 
>  	offset = logical - em->start;
> 	length = min_t(u64, em->len - offset, length);
> 
> Where @length calculate is dependent on offset, it can take reader
> several more seconds to find it's just the same code as:
> 
>  	offset = logical - em->start;
> 	length = min_t(u64, em->start + em->len - logical, length);
> 
> Use above code to make the length calculate independent from other
> variable, thus slightly increase the readability.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
