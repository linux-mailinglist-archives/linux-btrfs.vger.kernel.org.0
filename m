Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644A421244E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgGBNNO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGBNNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:13:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE3C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:13:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k18so25512163qke.4
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qsgrzQb+NO1ka28fE9F8AtI6dfqh9dG8y/DvVegXmuc=;
        b=RBQiOxs1G1Kzp1PytRfo3hnVuKUDkrIIj4XYLBZdxm7GaYoj1miKaiL+rFJOorcWQS
         lXWKdoYgiP2kvnE1/jCNQ6+d7mtLL+fHviIfrFxUAT0sI6MTwqAm+RNDgqgzvM1AY9no
         kWQxMp7piAxgEggJP1k4eWsiegCzUewdvKMh7txwKYraWrMO9ggI0pxEI48eAT4I75+r
         uqQOoSkUdi3hU9fgAzqcaDSRZ1WP2wO6/PIiTmi33o8jujn6ee2qS1KvoC67IO3EbyNJ
         kOC269sAK75vjqlSReiM3oiivxbKmD07qBpsgTyu8vHz0qczi3uOcnFP6z+cyfVru7XR
         vi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qsgrzQb+NO1ka28fE9F8AtI6dfqh9dG8y/DvVegXmuc=;
        b=UIKGBh1TxyI8sAA/NhGV7BiXSe9Qr/sMsXkDJtPCLr20fTGrfmUguWaIWzZ6Rd3+OF
         Jb+9Tl8rUIHQm/NFD94Gnmu/JKModyy2iAariUJ75yqIWclQ89BZ8qDEWQcb+fAO3i91
         VNDsb5p3nAKBBkZgV6rg7Vl+mxEtW/1i+mLb7mvZML/7ObrNKrHURHVkF7oPsxqVnCFM
         C31UuFaXH4x+3sLdWLTmnh0jnvzFaorOvyQGEagPW+/UtbjM4s+qWKRta+hA3nsBYhO/
         ucwcPdYZyPG5/80FWN5NS0CUHVL3SuRHvnMdQR6Inz5MRL8jPInGNbwV7MhrR3AHlRxV
         K2ag==
X-Gm-Message-State: AOAM531zlCWWheebu1P10tPB6ToY2OcAeYzl50ADFbFOFha1Q844woWp
        /neubV5EBh4qx37tYDRnRdVy8u1KTDhzew==
X-Google-Smtp-Source: ABdhPJz6GzW28qV5sNX8amQ0FCRwIdHxLy5qBFjvZEyyA23eC1V4pWSdlku844sEIR601pnkj2k+RA==
X-Received: by 2002:a37:51c6:: with SMTP id f189mr30434228qkb.339.1593695592803;
        Thu, 02 Jul 2020 06:13:12 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 188sm7922207qkf.50.2020.07.02.06.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:13:11 -0700 (PDT)
Subject: Re: [PATCH 2/8] btrfs: Streamline btrfs_get_io_failure_record logic
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-3-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <147155db-d83c-0180-0977-2ede4f0f76a4@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:13:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702122335.9117-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 8:23 AM, Nikolay Borisov wrote:
> Make the function directly return a pointer to a failure record and
> adjust callers to handle it. Also refactor the logic inside so that
> the case which allocates the failure record for the first time is not
> handled in an 'if' arm, saving us a level of indentation. Finally make
> the function static as it's not used outside of extent_io.c .
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
