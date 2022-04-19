Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE005063C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 07:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbiDSFMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 01:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiDSFMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 01:12:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF35D201A1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 22:09:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g19so13543487lfv.2
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 22:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=yOIbjjDk2T95Qdc+epwt4gBtCKRfwKVsWt+fzj31M8k=;
        b=ndI2kuZWgyHTgOEgmONKSGYlCKdzzqs0QYWLzFSSbf49wNZXPrGIRuTG5ptVPbqtGc
         elHs3pz6iJxmPnuiYAV9LOIKx+O1HtzU0ds8vQIvxjuX3gIj85Eoypi9ej8/m2zgkzb7
         y672bvTbMP+c5xx4eoZ984rN7EfWmTqyZS+t6nbijU1hGVGPqDh1Y5HQHgY2dXhr3bG1
         tU0o0i+HcVpN/NhZ3Xam9VIlc5e+IL5bL/dzWJHjqLDba3bB9JNZDVxi4qd6rwf3XV1j
         BKO/17gjTL6N3Dt0UsKjbpqmRoLJOmSfTDRdbKDKpJCUhQ/kO/S81akIuJ6HfiXxzciW
         E16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yOIbjjDk2T95Qdc+epwt4gBtCKRfwKVsWt+fzj31M8k=;
        b=r+hfdbSly1CA2sDJQBtAikNgQa+Wr86grtyd7i6g1zUez6Pl7fqoiIYpCQ88OT4gwE
         p0Qu/+6FCA8Uk4JXmGAb4Gmu3LJbOfc/N82AosXlBvmnCuP4D2LyKxxzNmTRWSv2cHCJ
         XBaZaFYr564jplHarNI6YMJAQAy/ipCJvxxCsYohjPcTwDUx7br0X+N48zCnDSLNqs9y
         UZ2v7CwsEbU/9K+kHCnI6GSdVYjkWTtKv/MEi7G+0PixvV3NM/TcF7K4zm1qteRgPFJe
         RSQgrXQbI8RuOTPoSHbeLrQ8fBJ3MIeOtyK2gYXR+cyr23UJ9P7dHJEJyki67LK/E1Nw
         EDiw==
X-Gm-Message-State: AOAM533eP0Mt5iSBVh0jPCPkBqLQ3Y5rjmSJB2Dk1un6IUbJKAOaFcxP
        q3dQEuqCrTbS8igXxC+A0erfMjUYuq3taQ==
X-Google-Smtp-Source: ABdhPJwhKsBsx5Pg/S/kP0zOP+7cD21xq2jfONjTiQH5ahhr60oys2otUseSlauuED9Z+/nAKUfDdg==
X-Received: by 2002:a05:6512:752:b0:471:9d5e:1ec8 with SMTP id c18-20020a056512075200b004719d5e1ec8mr4081572lfs.492.1650344963961;
        Mon, 18 Apr 2022 22:09:23 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:3365:df52:ce71:56d4:e7e6? ([2a00:1370:8182:3365:df52:ce71:56d4:e7e6])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651c102f00b0024db4728681sm823486ljm.50.2022.04.18.22.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 22:09:23 -0700 (PDT)
Message-ID: <e329a96b-8fe0-0426-f368-f0a1c2eb13b9@gmail.com>
Date:   Tue, 19 Apr 2022 08:09:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] btrfs-progs: fix a memory leak when starting a
 transaction on fs with error
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1650287150.git.wqu@suse.com>
 <0aa27221eba9359cd566fc6448d46b12583211f2.1650287150.git.wqu@suse.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <0aa27221eba9359cd566fc6448d46b12583211f2.1650287150.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18.04.2022 16:10, Qu Wenruo wrote:
> Function btrfs_start_transaction() will allocate the memory
> unconditionally, but if the fs has an aborted transaction we don't free
> the allocated memory but return error directly.
> 
> Fix it by only allocate the new memory after the transaction_aborted
> check.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  kernel-shared/transaction.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
> index 0201226678ba..799520a0ef71 100644
> --- a/kernel-shared/transaction.c
> +++ b/kernel-shared/transaction.c
> @@ -25,13 +25,15 @@ struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
>  		int num_blocks)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> -	struct btrfs_trans_handle *h = kzalloc(sizeof(*h), GFP_NOFS);
> -
> +	struct btrfs_trans_handle *h;
> +	
>  	if (fs_info->transaction_aborted)
>  		return ERR_PTR(-EROFS);
>  
> +	h = kzalloc(sizeof(*h), GFP_NOFS);
>  	if (!h)
>  		return ERR_PTR(-ENOMEM);
> +
>  	if (root->commit_root) {
>  		error("commit_root already set when starting transaction");
>  		kfree(h);

If you are moving allocation of h anyway, why not move it beyond all
checks and delete redundant kfree(h)?
