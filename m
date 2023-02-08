Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DA468F8C6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 21:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBHUXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 15:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBHUXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 15:23:44 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E868C7ECB
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 12:23:43 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id w3so22348655qts.7
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 12:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd9+9qh1r+MX0ZH+pCxOW0FEill55t+9dSSgMuN0vJ0=;
        b=Th0NSlf9nFxTcq1+eSuf/o0Kop6afC6p8kyPwkKZKlMI5tYDul/Mg9iurvW1MH5H0J
         9ErbKZQnp1IlkwqIaQgNKhSCrR783cDTtZbSE1Xnks52ER/2+2uGo6Y0AmiXodtJm6uE
         Iy5vZIMKQuJsdNfj41efoX98NK0mqwuAabajE4Y6ytUSVAttxoso0zOLrrgwxorLd5sK
         97ZdZ6Qr36Xl5ItjyanajIC5tYNbOwttL3pw8EralNxvKr+PvEPKjD9uIe9Rj5WX3eLC
         2HWFGQcg2oUII/9PY4yIh9FFjVfxesRBDulklBQIWJ5LWuj4XIK0a9TGniWwQRqfUzYA
         6wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd9+9qh1r+MX0ZH+pCxOW0FEill55t+9dSSgMuN0vJ0=;
        b=GfhqjVtPLJTu3U3n0fFR957XyVeQ3ullxrHf0tvMxykuWyMMx+3IB5luQ5OCYgvAVA
         mJVuHrYU8tohgVKNt/UsiNo1ClyYxLSWvHsAV0eTJ2/T4uBCHooJl5vk1iQFYUfMu1fY
         hnPhdr3piap4HRnGtiJVncTcxnZsDpZkoqOJRBP6gvdl5Dowd+cnuR+P/g+dVq6G+Z4X
         FDOnB2GmvICe96eDqrKObX5SwbRntOA90ib73greDJeA/4N4gMmAQ6DYLZ5PhXSmq+UG
         ts5JAX0Ppq4vC5Fs/fBxZyleeMcUOcvXa0FKs/w3JzJNlJtOGM2tQSwmDZPf4R091fyQ
         r2jQ==
X-Gm-Message-State: AO0yUKURxxS3zQZCRhZ080fmSI6swRfbwXf/EKEY7hQQLOk0t+x7BxbG
        nfnw954WR8Dm0p+5Rm49U5H6K9EeBCDw+gLUgNE=
X-Google-Smtp-Source: AK7set92dBAYg3vOumgzvzOWcnWKNk1P4FHFH9qyVOMIThmTQg8ZQDPkacjDXyzGfyizXKY6G15Ugg==
X-Received: by 2002:ac8:5b51:0:b0:3ae:2272:e43c with SMTP id n17-20020ac85b51000000b003ae2272e43cmr14308928qtw.29.1675887822848;
        Wed, 08 Feb 2023 12:23:42 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id a25-20020aed2799000000b003b8484fdfccsm12150549qtd.42.2023.02.08.12.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:23:42 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:23:41 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 13/13] btrfs: add raid-stripe-tree to features enabled
 with debug
Message-ID: <Y+QEzfxvoa9MN9Wj@localhost.localdomain>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <fcc0db899a9dbbac3c862b2f91afe9de82b164ac.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc0db899a9dbbac3c862b2f91afe9de82b164ac.1675853489.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:50AM -0800, Johannes Thumshirn wrote:
> Until the RAID stripe tree code is well enough tested and feature
> complete, "hide" it behind CONFIG_BTRFS_DEBUG so only people who
> want to use it are actually using it.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
