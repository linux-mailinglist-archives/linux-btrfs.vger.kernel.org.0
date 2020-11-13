Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B855A2B23CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKMSch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKMSch (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:32:37 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA088C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:32:36 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id n132so9716273qke.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c149pN4irzkGIAGza3Wtpv8Dks8YokuTvmNS8Kz0Grg=;
        b=XlDXGR1j9B6JBWt8RyZpuB0NgG6TB67loif4oBM4wj4nzsQqfu5wWKW+jUb12AFAzv
         FyukQnCeXFpRvqa3qsxQJIvAIIelnG0G7Kw+IbPPEdOonOFksbch3lwGfhwD6NAyqLb9
         8wm0bi/4x+C0mgzyZsPUsINcvVSmmggaGkQueuQ2nbOmUFG7ESxQOeuTumS1t4zNIRvs
         M1nQGFTNp/Xk0KYLP/ua3e5vU+/QPmk2dVUdMDFFg6ZTjEPwaEzMIluIO+HRlrXuO/7j
         2u6E69CQ7weSO5H/s/+xDr1PXWyGtTYQdLYc9F//imbJbBJY6ek5pWDD3G+L4b/GHdQy
         zuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c149pN4irzkGIAGza3Wtpv8Dks8YokuTvmNS8Kz0Grg=;
        b=nKgEZgC2mt2PJHoNFrrV/HroVIl/SApAUbtv4OLI2HcH7t86zYrx8ZbbD1JZAVnFKM
         S4iJvM4flzI/lDYNDn3Yk0U9L52N4rTVFD1hImusHx8n4SXJm0k9iHQB2L5AqxvoCz7A
         ic8hCbi86UgDws00jqKz75bSsI2CS1F8M99CRT8D2lHo6hm2VWeua7HIbjgXnJRnR19E
         ZvDtSilbWbKTEoRfEXwoMLRKUobe1d6E0FdMlSvwWsNjtcblidHvr+U29kToKMm26+N8
         ZUnvwRPUzLSEsh08LoMGJYU5Ia8xmJIaKV8jLIHPyNUEhXOvT1fYAO/mKj2aoU8gmhw+
         bNuw==
X-Gm-Message-State: AOAM5327gHa3yDF1wbDjyRG4UQFYi3Bwk1dVjIneXPqDoG9j/rFlGrD5
        fSwnFATKZCWZe5mL7LaH9kPQU8LVdboeOQ==
X-Google-Smtp-Source: ABdhPJyFYDfRkhxSs0jk6nlB7a/nEl5fg54fIkqQiXD9QlkLVxcNo1eb8Ytu6eToPyw473kQrDQQ1Q==
X-Received: by 2002:a37:a783:: with SMTP id q125mr3306864qke.10.1605292356031;
        Fri, 13 Nov 2020 10:32:36 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q129sm7171195qkd.89.2020.11.13.10.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 10:32:35 -0800 (PST)
Subject: Re: [PATCH v3 1/2] btrfs: remove the phy_offset parameter for
 btrfs_validate_metadata_buffer()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20201112084758.73617-1-wqu@suse.com>
 <20201112084758.73617-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c9a391da-d620-e98d-22e0-b375281388f5@toxicpanda.com>
Date:   Fri, 13 Nov 2020 13:32:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201112084758.73617-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/12/20 3:47 AM, Qu Wenruo wrote:
> Parameter @phy_offset is the offset against the bio->bi_iter.bi_sector.
> @phy_offset is mostly for data io to lookup the csum in btrfs_io_bio.
> 
> But for metadata, it's completely useless as metadata stores their own
> csum in its btrfs_header.
> 
> Remove this useless parameter from btrfs_validate_metadata_buffer().
> 
> Just an extra note for parameters @start and @end, they are not utilized
> at all for current sectorsize == PAGE_SIZE case, as we can grab eb directly
> from page.
> 
> But those two parameters are very important for later subpage support,
> thus @start/@len are not touched here.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
