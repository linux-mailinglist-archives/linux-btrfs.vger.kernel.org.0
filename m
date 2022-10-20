Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0726064AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJTPfL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiJTPfE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:35:04 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED954180
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:35:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id o8so2178894qvw.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mYpuc6P/VSXroTfumHyEWr5mWpKRu3BpdTG6F3GYEg=;
        b=vgaGNm+hccwjWibWQFgqaVy+p8F7YyGUGTExCUznw7JYnOlmN8dhJT8ltHzuKjVp5R
         PVyJGJLLj+HbWpReIA+LIxoCsh8OdApRkYrXMuxPirlo2pPh3NdYOHqkyNUPi2/mkViS
         LgH18jAjhsw4ZU5cLqOvfT+tuN34JmamoAuSMX9sND5KfF4PDYwhJYBZIxeGb3283r0v
         /7fvNEkxKdtNzW9XQkIqd2Pi1HvavOUBHmJbMuo6FSg0BWxbgsdeNuqLf7xNJESGUmST
         MtxeVMVbUbD7rGnlwEWm70MTyVCR0Mk16E1CLQJj/GdgEGcmEWiBgw7+maJ7nhNVSLZg
         btBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mYpuc6P/VSXroTfumHyEWr5mWpKRu3BpdTG6F3GYEg=;
        b=NNEyCxhBnbPaN03X+9hGou/Se/TbBVt/j9Y2O8WR0bUeUsTDx3dNZvRU2ZjRtoPGmj
         OP4ALZy+hdTrCSMoLix3VVTlZmqglgakB5nlCgoP9JqKIuFcDICH2Ky3E4gyLZkjnM4F
         S6ZbOSK7KVN83Sav1W9dC/nweBjtNOAVHE9fZwXyorwagLVoJdUN9xIgHqV/YFH4kAVg
         Tw8NcsDoiXiZN8uyeh52uHntORBUowJYXSfuFgMVkzt96ZJ+qpNqd+Dy1X8Ay3ZKUYVk
         4dwznIbcUJBI+deOgfi/CG499GkydO/tWv58uqSxkuo8BueSAwvkL4xgSzaZy2/lSkzw
         ElDg==
X-Gm-Message-State: ACrzQf0JPvTi/IAD0vwuqpOuhZIa04SeAjqUBDy0GOVuK5QE4vg/0LAQ
        HzdiQ+TQfEzwpGSqxYNtKOXUJw==
X-Google-Smtp-Source: AMsMyM5pbOJNLwslAguJm4B+7QlbT1lz/MwwzfGWwu+UTWS2VcMGXVzeu2STRAarTYgmnlH3lSPXrg==
X-Received: by 2002:a05:6214:622:b0:4b1:d189:1631 with SMTP id a2-20020a056214062200b004b1d1891631mr11720946qvx.62.1666280097626;
        Thu, 20 Oct 2022 08:34:57 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d11-20020ac85d8b000000b003986fc4d9fdsm6564477qtx.49.2022.10.20.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:34:57 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:34:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 06/11] btrfs: add raid stripe tree pretty printer
Message-ID: <Y1FqoBXEBnn7oB6f@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <5574796b1656045504f2d5c52bab4e85fb9d1b8d.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5574796b1656045504f2d5c52bab4e85fb9d1b8d.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:24AM -0700, Johannes Thumshirn wrote:
> Decode raid-stripe-tree entries on btrfs_print_tree().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
