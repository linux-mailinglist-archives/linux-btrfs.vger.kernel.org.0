Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD34068F8BD
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 21:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjBHUUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 15:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjBHUUM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 15:20:12 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A667B360BE
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 12:20:09 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d8so2143870qvs.4
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynCzGaoWlKyAxAdW+KNB1jH1mAyyRcM7NPQM2rShq9A=;
        b=6kir8ghvDJTycI/+0zJRdkDeqms4EUrKti7BCGj5ikr/YcXzVnOrA6tszE9k/6dXtW
         6gvmrkS+msMajbZT7Fq7tYVlBqDcvx4oGNT6oIhLlRfYlzFLNXVPVqiEtRaDv9g2KAxI
         JcS2gU2MgAnU9iLy6kIq6nl64wRRjJVbxT7okpbePz0pMn8SIBeFR39SrXG/p1MYl1F5
         NLBdLGRYM/+UF+XuZZ7yqMJ3oPz7uoE3DIrukwx7t3sSPzBGGm3N4DHXXLRUDveboXSD
         WFihiyuU76Ztfoti8PQse9QM0g6f2brCWMd20oB1KI2Hi5Q3cMGxPY+pUMzHOqUPD9Gx
         atcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynCzGaoWlKyAxAdW+KNB1jH1mAyyRcM7NPQM2rShq9A=;
        b=dN0l+n/BGAVn7CyMUPmAHq9DQXPpNKFD8IKva6bRVEfFVxoU9cenfhvBSBIEMkIotS
         b/St/lWCx/BBrAQELg60MdtbMbjSOmeJw46LKnBD85SK9yC43VEbFvD8w6eBevDofToE
         NdzuFw9Bf2XpWidaw7kSG5StOxnphakxFbF3YUqpT2jQDzABg534gRU14AWh3gT33mb5
         nKfWu70kXZ7aNs2FVEGVsBVyklUbR+lL5JVzBP9bELVLyc5mWkb0vjueJnjj/RaloBP1
         NTUz3E2AOcdetqsnVtxdSlC94nR7RXoRvBtxjsk+JqaE6P2mZimuiEfS+jGvI/h4/JBj
         NsBw==
X-Gm-Message-State: AO0yUKW2iS6DHprSNAsMTReECfenP5Ti10xiucyHbJO21cVKOv6SkKC6
        gLKD8t7Gz+2q0XL5MApw1cBtc0bQNQ3r54QLGpQ=
X-Google-Smtp-Source: AK7set8APn1113xG4HaowsYeLmv6br7U1byDg9I1p+oXEDrL5PQIdcZdHtIGZryS/NNIx+adqKw0Sw==
X-Received: by 2002:a05:6214:1c0a:b0:56b:eed2:e6a with SMTP id u10-20020a0562141c0a00b0056beed20e6amr14787529qvc.36.1675887608852;
        Wed, 08 Feb 2023 12:20:08 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ea7-20020a05620a488700b007290be5557bsm12352353qkb.38.2023.02.08.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:20:08 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:20:07 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 11/13] btrfs: announce presence of raid-stripe-tree in
 sysfs
Message-ID: <Y+QD9+s9fYmgX1+/@localhost.localdomain>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <ef669592a878eb975e4bee1d869d17446e10c111.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef669592a878eb975e4bee1d869d17446e10c111.1675853489.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:48AM -0800, Johannes Thumshirn wrote:
> If a filesystem with a raid-stripe-tree is mounted, show the RST feature
> in sysfs.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
