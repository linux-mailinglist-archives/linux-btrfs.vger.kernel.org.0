Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3182972A98A
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jun 2023 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFJG6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jun 2023 02:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjFJG6c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jun 2023 02:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8C93A9B
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 23:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686380265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHkQ543QkLblaQMAJ7xg8xPkVXmZSphQVA2A+3RVS0A=;
        b=e4Msn7FdqG8k2/tD4CmO7pdjcr29Rfd8i3BZsF33uqAE2oOr6pGZutnFf6T/YgTmIl/2hn
        DeKFi2bqrOIkBO6YOb5PWj5ljFcyq75PmCAmG7rKCTji58+zWlEUHgQEV4vMcnDheDchR0
        zczReQgEFsFAbzGb11ZkS+v0+WgPFbA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-6s1ZZocYN-mo4JEXpZYJtw-1; Sat, 10 Jun 2023 02:57:43 -0400
X-MC-Unique: 6s1ZZocYN-mo4JEXpZYJtw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-256719f2381so1337245a91.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jun 2023 23:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686380262; x=1688972262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHkQ543QkLblaQMAJ7xg8xPkVXmZSphQVA2A+3RVS0A=;
        b=TEXTvKNiWwXWkk65M0tiNZG9v/F5qjJODiP3+U9nNUyB5covgyBNjke1/knDLVCjFC
         8Fm1pSz1R4d3fhYBm64eEgnhHn+tIwybvN3fmTADBDPLNj1jPx0xB9uHb3Z58l9fVV6y
         tEEBwJlOEcaGcsrGUNGrPHraT9yBbo9JXOrswAuovMmpH6aHPZlmVNOBwXoJSUGobMwq
         +3NryVg77w4eB1vvGvbPHnSv3bShYvCm7lvWIWVHP2/sN8Sxcs2VSsO/gPwBSdU84oGC
         YXKhq5Sde0JwN22BPp+af+AanYa+om4XFnUTW002x4yieItSwCvKlI4C169Yuj8voB4k
         kz/g==
X-Gm-Message-State: AC+VfDx3Ke6C1cEOfslBjXhfldmokYO8xP0tBtoWdgK8VZmO3uH4PE8A
        opKGL7wl3ldoPr4RtSNG3XHOfACz07g4aQ98fcqxo+RzC8uPF+IDoaPHifegT0cZ9+3sCNeWOin
        NzJrq/5/skm+BXK9BgwYjlDg=
X-Received: by 2002:a17:902:f687:b0:1a6:6fe3:df8d with SMTP id l7-20020a170902f68700b001a66fe3df8dmr1515736plg.8.1686380262721;
        Fri, 09 Jun 2023 23:57:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EmlKwr/AtNUDTxmM67FWKXsGHWxmk7k3DoGUAkuy0972Jv5WvojvqrhHYI1FAQOLVQV2DAA==
X-Received: by 2002:a17:902:f687:b0:1a6:6fe3:df8d with SMTP id l7-20020a170902f68700b001a66fe3df8dmr1515727plg.8.1686380262418;
        Fri, 09 Jun 2023 23:57:42 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b0019aaab3f9d7sm4343492pli.113.2023.06.09.23.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 23:57:42 -0700 (PDT)
Date:   Sat, 10 Jun 2023 14:57:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/122: fix nodesize option in mfks.btrfs
Message-ID: <20230610065738.2djgsxpdgebmuhax@zlang-mailbox>
References: <04c928cb434dae18eb4d4c2745847ed67dc3b213.1685365902.git.anand.jain@oracle.com>
 <a45349aa46e0b185acf59f3914e78dce245bb696.1685705269.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a45349aa46e0b185acf59f3914e78dce245bb696.1685705269.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 02, 2023 at 07:38:54PM +0800, Anand Jain wrote:
> btrf/122 is failing on a system with 64k page size:
> 
>      QA output created by 122
>     +ERROR: illegal nodesize 16384 (smaller than 65536)
>     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/vdb2, missing codepage or helper program, or other error.
>     +mount /dev/vdb2 /mnt/scratch failed
>     +(see /xfstests-dev/results//btrfs/122.full for details)
> 
> Mkfs.btrfs sets the default node size to 16K when the sector size is less
> than 16K, and it matches the sector size when it's greater than 16K.
> So, there's no need to explicitly set it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Remove the redundant explicit nodesize option from mkfs.btrfs.
>     Changed: Title from "btrfs/122: adjust nodesize to match pagesize"

Reviewed-by: Zorro Lang <zlang@redhat.com>

>     
> 
>  tests/btrfs/122 | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/122 b/tests/btrfs/122
> index 345317536f40..9d5e9efccec7 100755
> --- a/tests/btrfs/122
> +++ b/tests/btrfs/122
> @@ -18,9 +18,7 @@ _supported_fs btrfs
>  _require_scratch
>  _require_btrfs_qgroup_report
>  
> -# Force a small leaf size to make it easier to blow out our root
> -# subvolume tree
> -_scratch_mkfs "--nodesize 16384" >/dev/null
> +_scratch_mkfs >> $seqres.full || _fail "mkfs failed"
>  _scratch_mount
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
>  
> -- 
> 2.38.1
> 

