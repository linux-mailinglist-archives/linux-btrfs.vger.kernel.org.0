Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D766064B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJTPgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJTPgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:36:35 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210511B65FC
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:36:33 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l19so13758327qvu.4
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxqr1ZE5OP5m4pQJrc8t3dbNZ6lxdeCYYIOIdDWGsOo=;
        b=dGUvD6wBV8mHGuNHGgxms4loJi92nP+6imP/Dp/oGHdNJwCXpE62Lq8u/hJN8abe32
         5jDJJjB4kIZdlwzwIDNlt9ro54TZxwz/uoj+v/P4TUJT+/DhhG7crmL9FLYlxFrEpqxh
         4BQJXzlTO9onyL2BvB+UHn3Y9XMWZUKStmTgi/LiEkii9yh2Lh0uyptOp+gqhtNptezh
         rE0tsYwlh6ICvb1CHIb1yM1snF0lnsToSZSyd90j8MWTWvVNKs+cLKmkyE0WbWuQ7z6x
         jqKdVPsfYXSjtqWqd1wLPVz1XBpNCDl7CkWlK8scC73cA6lwBsJEmH5f9wHs4pgBrLGn
         89MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxqr1ZE5OP5m4pQJrc8t3dbNZ6lxdeCYYIOIdDWGsOo=;
        b=ECYDmvb+j+A6nvMLVy9F4aQBGbFIl6aNbUCegv9nYKKYFF/BFoRQV2q2VZnAAP4TcE
         H9iVyJ+0hhGfwOhmtRCRt31d7ivUHIUtKRSzBx5KkqEQcQaRKEv9z5mLmsJKOfsl5CK5
         /NOfFb6K8IrK8EzZAAFcNjdOMMtc7d3YJWFDHyoR/8OQ2DeFSr8dpowzGaAkPGUrN12Q
         ArrqT7p5pPW+inPpEzXDos98VVuOou7iT+7I6235HqTdkR8MFtRSIH1J3bfc6sHXd0Ts
         IFNhy0jl9Kn/R1PjGzfiXlvMdqFmCkF6o4htLYkxRTuvsyEZJn1y6JDoPyBIR5vRNNKD
         XQnQ==
X-Gm-Message-State: ACrzQf1ilAuMmIG6SPfwcFfzpj9kS52YkvAVx9tS278xKm2EJq/MQBve
        n3MT7kIjxwrt2Abyha87fEucJcZgLgdqRQ==
X-Google-Smtp-Source: AMsMyM6z8iEXRFX05W+0KbcLQ6a954P0nUV7d831zlTQzx27OBgMML3p1IGjm2YXwSA/o0S3MJfGOA==
X-Received: by 2002:a05:6214:5185:b0:472:f9b0:cbc6 with SMTP id kl5-20020a056214518500b00472f9b0cbc6mr11595314qvb.92.1666280192085;
        Thu, 20 Oct 2022 08:36:32 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006e16dcf99c8sm7628606qko.71.2022.10.20.08.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:36:31 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:36:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 09/11] btrfs: fix striping with RST
Message-ID: <Y1Fq/otGn9yGv8vz@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <b764b4d96e120f2884838a35ecc57291186f3e4d.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b764b4d96e120f2884838a35ecc57291186f3e4d.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:27AM -0700, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Why you no changelog?

Josef
