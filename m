Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20168F83A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 20:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjBHTmX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 14:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHTmW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 14:42:22 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC618147
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 11:42:21 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id i1so8498062qvo.9
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmP0a03XGwXPhtvn+GYaeV5Z3gAaV4qw/o/vICiiVlY=;
        b=iIGTvrV6yQP6N0aaivHhtdOlhu89OxtVXDwR/dUKF8AgPEHF8FZGwoB0TCU76/SWI1
         +1UW7D8S3yodnJETwbfytH/bWqeCKRa+9Q3nggqiieJ6uPNjArs1JV35J458gxJDrXyh
         kBjrGIBBfceky53KjwVvzvamO8C/M514yzq4yxVxJLyvdTogLK+slUt/jJ70JbmKVNyb
         BQwsNX4s13jiPMn+SQ80ZnLDiSOQq+xOgHZEnEEtpd4iYQuTu99R07J1kmSQPu1Qojiz
         HmS6+9GUnIPJIVPN+cZ0XYyolLsvlY7IDb1n5QyAUch1RbTDRKCeYqOF+moNiIwZndVB
         0JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmP0a03XGwXPhtvn+GYaeV5Z3gAaV4qw/o/vICiiVlY=;
        b=VTX7sq4hsTOurr2bHMqsAaiIvUvGrJi0y3gYVYJcsrrRLeJudPGxhl1GlUj8HXkmb7
         rXEn5xGQVWNeMIKM+Du8+DJGtPXbL59CVfzS8JJg/wpywahBvvUZZcgwMvoOcHCLt7/+
         mU1voyXqE1+PaxZnY7wbVE3B9ZhlnZ/Q/InZskQTc3g+pClCtAXbIX1YWi5g6w6xuMBl
         6e8eBlT+AsKtC/UCOECEn4CY/iadSXmgyMmCd8CLoEWRaS+2U2UMufhvwi50kAW9IWVb
         XwucuG+6socPhEptTpV2/2I4z6n3hnClncTFLAZvmPbMaewoSPQOcdD/PwCm7dUqKvxU
         YyTQ==
X-Gm-Message-State: AO0yUKVBOa3dSbD+7MwcEKxRfBlR2eJrFEVHDhZ125JubyvF+DB8cyYW
        jVoHTNLfaFsGkgg8nQ5qa21hdg==
X-Google-Smtp-Source: AK7set+TH7cLZ+WpZNoFp7fIt/tA0UMB7WP6IgQlUoeugy7m+O9mDwYeC20l0+AkW1m5C2M+kDFwGw==
X-Received: by 2002:a05:6214:1c0f:b0:56b:c22b:6b4d with SMTP id u15-20020a0562141c0f00b0056bc22b6b4dmr15376465qvc.35.1675885340536;
        Wed, 08 Feb 2023 11:42:20 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id 71-20020a37034a000000b00706c1fc62desm12170292qkd.112.2023.02.08.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:42:19 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:42:18 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 02/13] btrfs: add raid stripe tree definitions
Message-ID: <Y+P7GhlaQEvIj/5J@localhost.localdomain>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <c9979f47d503ce623e9e8b8d1fb32188844c1990.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9979f47d503ce623e9e8b8d1fb32188844c1990.1675853489.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:39AM -0800, Johannes Thumshirn wrote:
> Add definitions for the raid stripe tree. This tree will hold information
> about the on-disk layout of the stripes in a RAID set.
> 
> Each stripe extent has a 1:1 relationship with an on-disk extent item and
> is doing the logical to per-drive physical address translation for the
> extent item in question.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
