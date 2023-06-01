Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5549E719705
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjFAJdx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 05:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjFAJdt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 05:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864EDD7
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685611984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xX4DWUXuUgkUkDBynfRPO9UP4HYgJT6wwsFaYxT3dmA=;
        b=YVPUxa6BsR25a8sWto0+HWCpSQCsUEg1sAAZURqRdRzvyK783P/iAQaqB4ZucCZhISn+ja
        ufhgyKK0eGAbRWHaan+b+7Qg+9o+ZkjXz7DJhOWab0fa5d4sg8VG5gDeSD6XFDr+zcbU6G
        zPjqGFvtSVj45EX1bgYT1MmcrX4L6P4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-nnrRUC7RPtS0PO3P7sMviw-1; Thu, 01 Jun 2023 05:33:03 -0400
X-MC-Unique: nnrRUC7RPtS0PO3P7sMviw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b03ae23eacso6717645ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jun 2023 02:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685611982; x=1688203982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX4DWUXuUgkUkDBynfRPO9UP4HYgJT6wwsFaYxT3dmA=;
        b=Bj5RDNpOYGltrmXvFGuRf/EKT8G0gOGJXqHAKFgkyzGIq8x6vEjBH0JEOmWs79nSi0
         MuaSJLgMzYh8/NxveMVD+aqpiv1NDN9akOLwJhti3I8rmPAufCM8wQR5IS7a1JsnMW0D
         KD80/PQNtKArVdvP+vZUeZP7vJI5ErF9CDPbv/G3G0ESHgFjMQn0c3mhGv9CJIdSJ0IA
         c2wbYOWDXkW+K007aTnBOIxryH2hIc/ezvFD7mCd0nAP+WPDjClFUx6ricOIvS44LJKM
         SAWlHDB4/4LFsHamplQKusW8kf7qzGk/nd1qSEkmVFNm+rTw5M+lgZ6edbEnv398jF+J
         uxxg==
X-Gm-Message-State: AC+VfDwUsPvrD/Qh/VD/T1AQo/NZV+I4BvZOOAy1KYYnAvRtO4u3c6Kw
        rKUvXgKpJZqqaL454QYr1WDTpG8KAdiNRgJ8M/DKlG7ifV3ILA/TyYNFjRY/SXm513ijjhUwV89
        57lr4uHZVrYS4cuOOpjjWp48=
X-Received: by 2002:a17:902:ec91:b0:1a6:d15f:3ce1 with SMTP id x17-20020a170902ec9100b001a6d15f3ce1mr9761511plg.34.1685611982350;
        Thu, 01 Jun 2023 02:33:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bF9//rKmP6OHnN241NLMJwvQIYa4l0eoJL+X+INfN0NMATaMLhmsQ0Kny/T/KW95WLnS1Mw==
X-Received: by 2002:a17:902:ec91:b0:1a6:d15f:3ce1 with SMTP id x17-20020a170902ec9100b001a6d15f3ce1mr9761496plg.34.1685611981943;
        Thu, 01 Jun 2023 02:33:01 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170903278b00b001b03a1a3173sm2960584plb.145.2023.06.01.02.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:33:01 -0700 (PDT)
Date:   Thu, 1 Jun 2023 17:32:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/122: adjust nodesize to match pagesize
Message-ID: <20230601093257.d7q3mdfliwly4o77@zlang-mailbox>
References: <04c928cb434dae18eb4d4c2745847ed67dc3b213.1685365902.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c928cb434dae18eb4d4c2745847ed67dc3b213.1685365902.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 29, 2023 at 09:13:20PM +0800, Anand Jain wrote:
> btrf/122 is failing on a system with 64k page size:
> 
>      QA output created by 122
>     +ERROR: illegal nodesize 16384 (smaller than 65536)
>     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/vdb2, missing codepage or helper program, or other error.
>     +mount /dev/vdb2 /mnt/scratch failed
>     +(see /xfstests-dev/results//btrfs/122.full for details)
> 
> This test case requires the use of a 16k node size, however, it is not
> possible on a system with a 64k page size. The smallest possible node size
> is the page size. So, set nodesize to the system page size instead.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/122 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/122 b/tests/btrfs/122
> index 345317536f40..e7694173cc24 100755
> --- a/tests/btrfs/122
> +++ b/tests/btrfs/122
> @@ -18,9 +18,10 @@ _supported_fs btrfs
>  _require_scratch
>  _require_btrfs_qgroup_report
>  
> -# Force a small leaf size to make it easier to blow out our root
> +# Force a smallest possible leaf size to make it easier to blow out our root
>  # subvolume tree
> -_scratch_mkfs "--nodesize 16384" >/dev/null
> +pagesize=$(get_page_size)
> +_scratch_mkfs "--nodesize $pagesize" >> $seqres.full || _fail "mkfs failed"

Will this patch change the original test target? Due to it hopes to test
nodesize=16k in 4k pagesize machine, but now it tests 4k nodesize as this
change.

How about:
  nodesize=16384
  pagesize=$(get_page_size)
  if [ $pagesize -gt $nodesize ];then
  	nodesize=$pagesize
  fi
  _scratch_mkfs "--nodesize $nodesize" ...

Or
  pagesize=$(get_page_size)
  nodesize=$((4 * pagesize))
  if [ $nodesize -gt 65536 ];then
      nodesize=65536
  fi
  _scratch_mkfs "--nodesize $nodesize" ...

Thanks,
Zorro


>  _scratch_mount
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
>  
> -- 
> 2.38.1
> 

