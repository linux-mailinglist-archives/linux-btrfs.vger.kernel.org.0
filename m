Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD977BC46
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjHNPB7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjHNPB1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6FDE6A
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692025244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gUIcTGKgmv6U3oBn1AoJg5Y0JtooqOi2HzPrts+u9fU=;
        b=HPvYjgJJ98FiJQcDyxIm2pjIIVNeQi/1hvLiua4JS7ToJ/xR4xlScjHnAAvYkhULbtHbXs
        JkkcS3Yic1aw/NGRgZowpzC6ydBrXhKg7DUVaBTJcbCbNzqfrM74EPD+6YsV5g2JbUfXnS
        ypMP7/OZKWHQToS5YnR+80OfF7bDO6Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-9HugtBVLMwu0HL_Q6-kr5Q-1; Mon, 14 Aug 2023 11:00:43 -0400
X-MC-Unique: 9HugtBVLMwu0HL_Q6-kr5Q-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bb8f751372so70027845ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025241; x=1692630041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUIcTGKgmv6U3oBn1AoJg5Y0JtooqOi2HzPrts+u9fU=;
        b=McXELQ1N972gTNHvc6fZ0gp2290HJXl/klc37QkriNDg3LvWguO5xcAKEWuLnh5M++
         +FX1CoV5f/HgxcnbzMPQviBtpQddRY5KH7upGYQ54mUXtXs0yv65/tRkPi63qiPV5vaY
         Oqtmm2wrij36Uhqu8on8zmJRwDhT5t94a/uvpHXJN5ULu1UotO/zTxGvdeqAyvXFy5wt
         AN6/zPGvRsybECQDIObcHdDypc3C1tEUp9kjLAmTybRFl6cNUbZqIlM+spfjyMoIp0I9
         lok0i0TWyeNXE4MSFWnSD2AoE7V9qoR+epz0a9/zC00Yind3AkdnzrkrzwvZ4dge/lVO
         7IBg==
X-Gm-Message-State: AOJu0YwTym25yp2JOiH9gYjhbVD7U3AoB1+WmSohsfKXUQ6PMZ+42mB+
        6FXr1V3gJfzXEM8ZsTV9uRFfx+5iyxvhk7kgnuO8ZsJrbaLqNrobUEHjMhOelUxipOsujljt3GI
        7aM+z4fkjYe9KEKLQV1V7res=
X-Received: by 2002:a17:903:234c:b0:1b7:e355:d1ea with SMTP id c12-20020a170903234c00b001b7e355d1eamr13740343plh.24.1692025240821;
        Mon, 14 Aug 2023 08:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn3wT/M1zRb6sEDUTnnaEwMglEZfX1p5XFlrpjFAtuPOKVhoc2RPEdx8jw0IP9m0vgV6HBOg==
X-Received: by 2002:a17:903:234c:b0:1b7:e355:d1ea with SMTP id c12-20020a170903234c00b001b7e355d1eamr13740162plh.24.1692025240029;
        Mon, 14 Aug 2023 08:00:40 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001bdf046ed71sm998882plg.120.2023.08.14.08.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:00:39 -0700 (PDT)
Date:   Mon, 14 Aug 2023 23:00:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/213: fix failure due to misspelled function name
Message-ID: <20230814150036.e6zyasqydeq5krsa@zlang-mailbox>
References: <71413edbeb1ee5b945f0b82faccaf4a75e8ba56b.1691924176.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71413edbeb1ee5b945f0b82faccaf4a75e8ba56b.1691924176.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 13, 2023 at 12:01:22PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test is calling _not_run but it should be _notrun, so fix that.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/213 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/213 b/tests/btrfs/213
> index 5666d9b9..6def4f6e 100755
> --- a/tests/btrfs/213
> +++ b/tests/btrfs/213
> @@ -55,7 +55,7 @@ sleep $(($runtime / 4))
>  # any error about no balance currently running.
>  $BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iq 'not in progress'
>  if [ $? -eq 0 ]; then
> -	_not_run "balance finished before we could cancel it"
> +	_notrun "balance finished before we could cancel it"
>  fi
>  
>  # Now check if we can finish relocating metadata, which should finish very
> -- 
> 2.34.1
> 

