Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5464E2744BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgIVOww (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgIVOwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:52:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51EC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:52:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w12so19274184qki.6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wq2ep8kyyAaceAMTO8vS1FECLN+yU4v/NlnEE5L3HO8=;
        b=H5EzjZfDHg6IGsj38HoYFULQq0932Su4lpaE12ToAKNdSTPX/UPVvzQT+lmBJYLNQA
         Oyxe45p+HXRccc7NXr5vqfm9oCGIzeQvLxATb22DLoFCiy7+IYZmY4Nbj0cjMeP2Tuhj
         9YtlWUr0akLLS4aKZLvWxq6iKB6B7yV9bePhwJ/ZWkbzewnGFe19blRC2PiTYC5MXBLD
         HRQyewMdU0u+dWx7tQmhu95SStu3DRxnnW0DiTIrYxi+w8sq/yY6h1j7UqsGzE3e7yXv
         sA3RFcZUQNXUOmKupEF6i8Xf7PauxEJ2YMoMxNJB8zfCAFabp01fSGpE2X5/OrxuC+9v
         GaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wq2ep8kyyAaceAMTO8vS1FECLN+yU4v/NlnEE5L3HO8=;
        b=KUMlq/IwlnFVfBH1rt0A14Z+QhFbripNrTfNWpTvwkPCXZldNJsXks2Yq+2Pxe8yG3
         M23Lff2tltInl/a9ue2q/RcHsEykqXdodOojrwTtf0+EshwtvZLbJoR72pVRxdmm+HNH
         uL6dfwmaQq4yUs6EgQfw4NbClMgdnPGZyHCCXcPaIflNR41too8ACl6tqDoW+jeHJ8Iq
         a+wjGKILSKUKFvrDpe9NbTVU8GluPweQQR/CsCEv6LjC3SKM1i9Rm3wtco+S8byxwqCV
         K1jo6DdyoPRYygQ5yYmVxGSXUPVVMiJCDsnqt7ICYvbf1J71jGaOewgf01fzMa70cc9i
         tkow==
X-Gm-Message-State: AOAM531SWibZsMGUwcLw1QbyfsSaZYitkwqdjii9tPMW7x+ahnXbg2NF
        KvUVx1B8HKizQJU0EhNTug9VPQ==
X-Google-Smtp-Source: ABdhPJwyIY/vjb5Yvb2tPmNHzOh7jU4Ia9Y8fSam+1bNpK5SHOi4zItdY2Ah6ccqqvYmK/1raRdzCg==
X-Received: by 2002:a37:9a91:: with SMTP id c139mr3032369qke.233.1600786370591;
        Tue, 22 Sep 2020 07:52:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p28sm13131567qta.88.2020.09.22.07.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:52:49 -0700 (PDT)
Subject: Re: [PATCH 12/15] btrfs: Remove dio_sem
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-13-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6f36e438-4603-5fdc-e5ad-32fc8d07cfc1@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:52:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-13-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> dio_sem can be eliminated because all DIO synchronization is performed
> through inode->i_rwsem now.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
