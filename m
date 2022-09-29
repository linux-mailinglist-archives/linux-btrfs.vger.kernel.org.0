Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58675EEB39
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 03:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiI2Btm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 21:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiI2BtR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 21:49:17 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7019120581;
        Wed, 28 Sep 2022 18:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1664416145; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VgE3+C2kAd55uGmaCqdTxux2Ui0BbOkaZQqtwBcwL9WAp5zmVG0+FXYWCuDST29ftIV+7CAse4SPGILL0pLHvtU00M3UOppXZS2sD6dxHaO2rbRaJb+p40I2XHaAgfdxsTKMRuDPBTNuGB6T3p8Nn+yzenLJNrSVkOjlJnT+k7s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1664416145; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nFQOJc4dHrCYblidg4L4WaQoJSYbi9B+73Gd5rjkAxM=; 
        b=oDFFdLDERnRt+jCDvvK3CQutasHR1EfE1jc99Oc6p3TRzjay0ROxfyRwCZrNxWqcox/1vALE1M4L7C5yl02Pz5S6VthX9ol7AQljLjnVvgXBZD2F+FP1DuMt58ST7cR2qlemRQchygwWu6ufgQAdHSxAVU6vN55EOWnUKea8zY0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:cc:references:from:in-reply-to:content-type; 
  b=jBEi5o0Dapas/Y3gTqXE7Urbrun/d0qv8B5NLr4wFxdJ0rOe2Lz+DQJQj6goKU8avYvEGgH5FLsE
    PpeXkUD5h8gP87WSkaDoDynZJh1244+Yl+Pf6AfK0KpWbtVy0nQb  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664416145;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=nFQOJc4dHrCYblidg4L4WaQoJSYbi9B+73Gd5rjkAxM=;
        b=Kx2WfgIKfAlZXqAe+fdXHFRHVSJolc5xXqrzA1WtjpcpabcLnasWc/00MpS/H2nB
        MlHXY8YGEGkDRsHpzRfOImihdjRzueRt4fE69ENhtyuE2iJSrJTQKVa08Ab5/I9mrdU
        B7jDO5PYmZs8FL1vzO7uxLzHf3M4f44B0bpvY/rI=
Received: from [192.168.0.103] (58.247.201.74 [58.247.201.74]) by mx.zohomail.com
        with SMTPS id 1664416144498797.9205126469951; Wed, 28 Sep 2022 18:49:04 -0700 (PDT)
Message-ID: <6104df01-4190-5c18-ddbf-6694e1e14900@zoho.com>
Date:   Wed, 28 Sep 2022 21:49:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs:remove redundant index_rbio_pages in
 raid56_rmw_stripe
Content-Language: en-US
To:     wqu@suse.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220929014402.2450-1-hmsjwzb@zoho.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <20220929014402.2450-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/28/22 21:44, Flint.Wang wrote:
>   The index_rbio_pages in raid56_rmw_stripe is redundant.
>   It is invoked in finish_rmw anyway.
> 
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> ---
>  fs/btrfs/raid56.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index f6395e8288d69..44266b2c5b86e 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1546,8 +1546,6 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
>  	if (ret)
>  		goto cleanup;
>  
> -	index_rbio_pages(rbio);
> -
>  	atomic_set(&rbio->error, 0);
>  	/* Build a list of bios to read all the missing data sectors. */
>  	for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
Hi Qu,

	I am doing some experiment on the destroy RMW. It seems the index_rbio_pages in raid56_rmw_stripe is redundant. We will do it in finish_rmw anyway.

Thanks,
Flint
