Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B672793DC1
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjIFNea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 09:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjIFNe3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 09:34:29 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33AC1731
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 06:34:23 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64f3ad95ec0so22024666d6.1
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Sep 2023 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694007263; x=1694612063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BgFN+E2MboIBJyphtPZcoPft7efqtYEGEYlE8MZIQXo=;
        b=Qd1+5CTdi0i2aNRKN6Er3NWVtt4w0jXa12yspO9Igr/EbtAD3e8bowmNhnv2YFoA5V
         Bzu+fqYoqYp+nhgfP2mNYpLN3BkvFTtQp2dkViixSE7j6p2DZiM8pPMUPRd4A+Bs+0N2
         UTim4rJlckriV2I+kv/vW+cYno0C96DN+fwzDKhX05cuxwNd6yPRQFtD9gDgOclwqmIr
         +oGOPlNob8nXJ39DV3WC6jDFoyok5ry4F4o1ykFXhJ6gArki73NPimaEroLW1d5I8FBM
         r2f25UR0gRGF9xbG3GWFZfxlAnwPA2ZmIVTkdfIyWgeB1EisfDFLMUTlu6ZnDv5Ct9S9
         hAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007263; x=1694612063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgFN+E2MboIBJyphtPZcoPft7efqtYEGEYlE8MZIQXo=;
        b=DNByGSwYU+jEnTUFtdStwtlYPkg1yNdTWOQopf2AV7TFO2VAwaJ/YAOxEM1oCyM2i1
         EEUpq1jkiZGMh9JE88xLTejYuzjbBe3Igd1/C5tkxGnv9Fgn4dVNibtQ1dL5OvO/BU+K
         /mRlwpjL8Sxb9ubGymthUyHRqpKSHx2AQGy08C3iE7HO/RWt3DfVdXv4JqXBCRfBwUiO
         3cOZz67Z3XUrFxgrj731ZmXWTw/Mk1JTPH61H0IklpfF6D5tLNYb02IlNafX8FFSzTuC
         R1kyuc1KQzPpe3pvO1IzS0PBVxXyU6ABEfZmayIHF1sc0bq8kWTMdMWZNAdaKwLOzif5
         OwYQ==
X-Gm-Message-State: AOJu0YwUnu4ikiBI8yy6zNOFuIHUMxQUYNRG3SDxYevVuNbGVDT9/Hwh
        yZ2UJP06Yde/X9mIgBTzppYi939fO2G3yZvs8w8=
X-Google-Smtp-Source: AGHT+IGhHhaoDNEqxZY4lB2u7UgGViiEYpA4e4NAvQpQa2mivR4r+f66QoqnG+oEeJ9oQAAJ5KJ0tg==
X-Received: by 2002:a0c:a99e:0:b0:626:f3d:9e46 with SMTP id a30-20020a0ca99e000000b006260f3d9e46mr14666495qvb.18.1694007263037;
        Wed, 06 Sep 2023 06:34:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t6-20020a0cc446000000b0064f46918737sm5435324qvi.91.2023.09.06.06.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:34:22 -0700 (PDT)
Date:   Wed, 6 Sep 2023 09:34:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/3] btrfs-progs: properly cleanup aborted transactions
 in check
Message-ID: <20230906133419.GA1877831@perftesting>
References: <cover.1693945163.git.josef@toxicpanda.com>
 <d24c0b846b150fa9e5638fc90258bf2728f88351.1693945163.git.josef@toxicpanda.com>
 <36a8f250-5545-45ce-8185-5451fbb0ebf4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a8f250-5545-45ce-8185-5451fbb0ebf4@gmx.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 06, 2023 at 06:55:45AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/9/6 04:21, Josef Bacik wrote:
> > There are several places that we call btrfs_abort_transaction() in a
> > failure case, but never call btrfs_commit_transaction().  This leaks the
> > trans handle and the associated extent buffers and such.  Fix all these
> > sites by making sure we call btrfs_commit_transaction() after we call
> > btrfs_abort_transaction() to make sure all the appropriate cleanup is
> > done.  This gets rid of the leaked extent buffer errors.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Although I'd say wouldn't it be better to make btrfs_abort_transaction()
> more standalone?
> 
> It's pretty instinctive to think btrfs_abort_transaction() should handle
> everything.
> 

It doesn't handle everything in the kernel, we call abort but we still have to
call btrfs_end_transaction() to clean up the trans handle.  Thanks,

Josef
