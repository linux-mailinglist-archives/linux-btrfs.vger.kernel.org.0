Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35EC64BCBD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiLMTIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbiLMTIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:08:37 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6279F220EE
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:08:37 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3b10392c064so206616167b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofn4EDRYmlQPU4wroOJNakA72SY9Y4HhjwOO03i0iv8=;
        b=xkw6VijFoyrmR4pJpqFK18a074qtm5ckVVUQzIR4ST7z/R3al0Icox4YU1btNUy8Iv
         T52ESvywVKxr+4LglB65NVIqmVkM/PIzDK8lTj4TDu5tdBCXq84bkHAFvua7KWd2PL8r
         h4XRb60RGLdXWWlBTvilGjOeZj3hhcV2nCy0O0XpJevIMoBcvDNo9JbwSovNKy9kLBWv
         KBrlasCdL3iA+mBloLGAvk8ESnVmjL8I8yKaKz6fbnEtnoxJNA4QQHb/XmC7ok8tUZfI
         dFiWxdXZShYB605qBehANTWb169M20xcjcIYuE6qcma23hr8e6X6h+aoErs82YlBPRfY
         /4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofn4EDRYmlQPU4wroOJNakA72SY9Y4HhjwOO03i0iv8=;
        b=MJBs7LGI2uK3NnJDwhg/5PcIzCmvhcYRkoSvgtsXon4PJGvrUnAdTNGUs3TuTc6Jwc
         P0TJ2mvyZxCjv98QYzGPWDFe0uBBhGXfGnq9kG95aXovC1RqSTyXm9mekod/OOr6lWAJ
         D6feiZV8Y2kGQwk7R6I6sF1ESsV3wLcl1Y7YxNyXfH3LjWrpIZIMqluVsua0LIiQ+64O
         RchAbiWSbCaNaKDv6Npjr9NrTvQms+Aepj9Co8GH4Rs8CdAdUU1pNwLXn2eoTOAJQW3+
         ZlOAGrn2mJOMTgU9rNsF1F4+k/xgnHWao8U9OrJMGp43X9DZRM62RQpMaOah5LA2o4DC
         YUVg==
X-Gm-Message-State: ANoB5pkL1PqOTPk7lreAhgkGinoIvTvehfjCTp+vlEhdSV7mSs3y0RS9
        u8stEUYUy/DwpVrb55IvQOQTT6tZ3chMQDGf5U4=
X-Google-Smtp-Source: AA0mqf69lUu48V45b9TZxX15mYLrPkN32NsZNif1UsTENYr6zhC+8hf/E1AB2tPVwQksxz0GRb1k6g==
X-Received: by 2002:a05:7500:2d0c:b0:eb:3161:99ee with SMTP id et12-20020a0575002d0c00b000eb316199eemr1840519gab.40.1670958516342;
        Tue, 13 Dec 2022 11:08:36 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006fbaf9c1b70sm8341357qki.133.2022.12.13.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:08:35 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:08:34 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 11/16] btrfs: lock extents before pages - defrag
Message-ID: <Y5jNshp069ox4Zuc@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <9d2c5c3625dae4a58dfb42a387f33f1f7be0fe42.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d2c5c3625dae4a58dfb42a387f33f1f7be0fe42.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:29PM -0600, Goldwyn Rodrigues wrote:
> lock and flush the range before performing defrag.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
