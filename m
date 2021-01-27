Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452A4306135
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhA0Qnd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhA0Qn3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:43:29 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257BEC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:42:49 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id u20so2308603qku.7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y6+SuZwGGzpHOfw9W6LaE851GfdE5UHtlQROF6gtRhc=;
        b=qo6M33LgxQuJ24CnnuEVsVKqzLF9/gPQ48XLeagY4Wv9+gS2KoWX1yhrB4AupDv1i6
         7N/qI1Mle9Dguw2sypiGEe26zb3F0OjwudUuvw2IMUvbDj75KHDrpwPE3XHKto297V87
         uE0A6ZQhdSO3R4UdxEj7t1hKdmWXxBkXXqjfjxTRw9ACc1yERDK2AqiEmTWiBNZ8Xk3c
         B1lfnS3qhyY/rUmk6NFnoMgu0ps5c5XuepEwSx+Xm/y03DxjIXdsTVZlaFpw0boECRRQ
         ZxTrm5oPcnndPJ65jnbg3eJWhI2HXgzzCUqAJBs26AS8Q8Cuvp14i8ZMcrxjHs7CKlp1
         1exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y6+SuZwGGzpHOfw9W6LaE851GfdE5UHtlQROF6gtRhc=;
        b=fZkaWmJAbZM1Tr82PNwBPs9Evh4dOSmvHG8J9qFi3uo20UXCwejaPM0WZ/+kaTC+nl
         v1fz23AyucnWJelRpHZ+l4f4rUiQaMVFtmwAJUIaOIxb2/b/7flfehzyqE3oG1LDQCEZ
         JV0Xgk3TG4U3KgFa5edkJrlwMT+RapFGlmyrwS+4D/pjN0lB3DTDaQ7mtYSCrQ0iQdSv
         gh2hZTn/LENjNwDthMy3rDYtClQ5XgzB7WppVSZEWRDvu0ImWuJ8Mx6meb/c0MEI7iqx
         /+wXuWn19DJcd7GNFRs4yVJiS7cXRU4lMbGPbngutCJ5a/44VG2gtJr2fuBTTmGIl4vj
         jL7g==
X-Gm-Message-State: AOAM532fYPC+ngq4JRLntCTaMISvVZWHypyT3RKkAZpf9yEdm1vFWV39
        eZAx+zo8DhKjrfNw6skFA8Bq7avWWZT1zcW3
X-Google-Smtp-Source: ABdhPJwe7VM2xdzKVrDCvO5iHBjXXNMn63ZTiig4bFN/zV3jq1LUXvvcPubxz+QMfY3hyrTj8XAxBA==
X-Received: by 2002:a05:620a:ed8:: with SMTP id x24mr1617344qkm.381.1611765768274;
        Wed, 27 Jan 2021 08:42:48 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p23sm1653546qtu.4.2021.01.27.08.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:42:47 -0800 (PST)
Subject: Re: [PATCH v5 14/18] btrfs: support subpage in
 endio_readpage_update_page_status()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-15-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3c3b8733-52ec-c312-e7f4-cacd291a0abf@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:42:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-15-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> To handle subpage status update, add the following:
> 
> - Use btrfs_page_*() subpage-aware helpers to update page status
>    Now we can handle both cases well.
> 
> - No page unlock for subpage metadata
>    Since subpage metadata doesn't utilize page locking at all, skip it.
>    For subpage data locking, it's handled in later commits.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
