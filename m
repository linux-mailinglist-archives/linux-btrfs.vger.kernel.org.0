Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317222CDAF5
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 17:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgLCQPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 11:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLCQPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 11:15:42 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67CC061A4E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 08:15:02 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 62so1177051qva.11
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ELXEAUQo99yNE1EP8pR7gwr734kicaAA9b9sLuyAi1I=;
        b=IC+wuFhv7gbXQt6LwmC5gu2YoX1vG73vNFl/GvM4FO3leZ+ib9V1sA20TqO/kelQNI
         zVNvNJ9jgaS7Z8RkU76P1nf8WjGCV7PGtW/qfRtzZsrgHTJtI+bwdJJ1fr0kgCEEWU1J
         3cGmG2xCG/q6DnMRWjMqGNK4Wwhg2hvWtZx6Gmq19CAHEWfWUTqWMDPw0qB/avkJmGyY
         vEyJc/KnavzTTZ4eIl5W4LnLc4peXOpWpd9pGTIFTxP2R8hKLCjFtkSAJhcIH0JtxA6T
         gRu3mvD0Kf9Zr2P5xG1S0i8Q5f/YM0MZykakmkvY8Xlg4EpjNy8QMcReSdvszJ/pZqql
         JRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ELXEAUQo99yNE1EP8pR7gwr734kicaAA9b9sLuyAi1I=;
        b=TqNdoI3VycqRn4oQfuqrWkx4/vcCG2MDp9DfmMvt20mQWJZ73OUSajI/4l7dKeunP8
         ob9wxTbEs2aqinKoseIsz/+sJUGPgG2ABYdU4y/dDuh7RIAOGsEaxgoldhb86A2eLXcc
         nkLmvfxEnSphLE2i+gh+r3Xa+KLIncFfcC/0XF/XgnRjcAPxI5meBRuioRpogPVfwrU+
         aZZKvH/lOsiWbNn4vvd4xhk4ixrqvyjBEZwyRZP9COQbDnAtlwU1BmIuC0MHj/2ocxd+
         QRipRV7lS4We4Kg5fMmEX2ZdPS6qdHD0TdKith+uSAnKdrSLX9KLZ8ywTRdSpjgL+Q8s
         u62g==
X-Gm-Message-State: AOAM532Gef+DI9hcxZr25d/QXdvIjMec6SPS1khSkWJsV8+g345pNroK
        vJiS9xsgo1c/JZrNd11lmS31uQ==
X-Google-Smtp-Source: ABdhPJzNkKdJwKW15mDGWjdZDiHPGKoxOHGrrszyi5ZXJ4S8Wi3oIospRh2oucuHP5nTSc53ugFV6w==
X-Received: by 2002:a0c:e18f:: with SMTP id p15mr4222239qvl.12.1607012101352;
        Thu, 03 Dec 2020 08:15:01 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w192sm1847232qka.68.2020.12.03.08.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:15:00 -0800 (PST)
Subject: Re: [PATCH v3 26/54] btrfs: handle record_root_in_trans failure in
 create_pending_snapshot
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <602641114c0a6c5ba07f78371a4d94fd1c442218.1606938211.git.josef@toxicpanda.com>
 <525db807-743b-cfb0-221d-8db26dcd9f98@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7b4d0182-78c6-3a58-9227-bb6deb67661f@toxicpanda.com>
Date:   Thu, 3 Dec 2020 11:14:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <525db807-743b-cfb0-221d-8db26dcd9f98@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/2/20 9:56 PM, Qu Wenruo wrote:
> 
> 
> On 2020/12/3 上午3:50, Josef Bacik wrote:
>> record_root_in_trans can currently fail, so handle this failure
>> properly.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> But I guess it would be better to folding patch 17~26 into one big patch.
> 
> Since each of them are really small.
> 

I don't like to do that because it makes it easier for us to just gloss over the 
change rather than checking each site.  You prove my point by noticing that I 
wasn't dropping the new_root ref in the error case for

   btrfs: handle btrfs_record_root_in_trans failure in create_subvol

It would have been easy for you to gloss over that change if it were in a giant 
patch.  I find it nice to have it in distinct patches so I'm forced to check the 
context of every patch I'm reviewing.  Thanks,

Josef
