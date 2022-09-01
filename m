Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9CD5A99B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiIAOEb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 10:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiIAOEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 10:04:24 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA176FF2
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 07:04:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j1so13486828qvv.8
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=cl1sSKD1RmPLbVkEegpiSGxu/8jaEby+OINiKcs+Q1g=;
        b=V5GbmaNVto/yR36gs6KEXQEqTBJZsVkDkatHg+LikD/ezwUNMnRGhNVAROVCfkYSgy
         gfRRxbWAvB1VoL+tadNR5nTZIT811dmtYBJJ4R41Akw0e31rMytYcMo+cbbQDXqoTGcs
         5vBl8701jtmDIwcZx5o8W7Kx8cQVOc1FY0x7DLXY7KloZcjCA0ZnZ/ePTGa9yE2L/8Eh
         1m0fr4lqiQjoHsXmzoeFRNdtoKJsSeRFmBiUCbsAKpWy1RO4NMVG+wVFt6fUSs2QFtkT
         FFIB8ILl/AKTxo630IacmDXsDzY1hveo4xzPYKiMKToAdqpEFrvqmI4MMA5hTXnIj0au
         zbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cl1sSKD1RmPLbVkEegpiSGxu/8jaEby+OINiKcs+Q1g=;
        b=xdw2s7ZlCHgbSyjcEmY1hwZegtHQtK7wUFgRakGi8XwXw84NtbBl6OhZy+jaBAJSGM
         TrfD0DWaLnoepsDm24GYpCVrrMbXk0sYrFFaUvaJdUqyr4TT8OWSnG8RzflU72agCkiN
         dMoLs4VMckR90/lZGgcK8p3vn3EXDioBwGsW4HDwPl6D4e2SHApicn0KdB/I4ovyXuPS
         VlvADHmQUWd4B5JLBDo8Yz1e7bMhsXFCJfgE/bJYZfh0UD/PLre55cFlWR7gpUB9MpBt
         VRe6I5ydRDB+An2/XOV4DHlArI9IR0o3FSRMqrO8eGHD/B5EyZtntFnjgiHbm+zhLvyX
         zEFg==
X-Gm-Message-State: ACgBeo1RmNOtj2Ah4sjJX5QNxCVAU+fEORgVhjydrkV9JyIG8A3+7vUM
        e/W+1eHKyyQn8DcQk35OM+jNwA==
X-Google-Smtp-Source: AA6agR4vgZsIAi9Yk/jx9m+GPkHIOZcAm8pxsNCMltWO3juvPyDYQWWw0YjmgPIfNaikkTDauCOpbQ==
X-Received: by 2002:a05:6214:5186:b0:499:42f:beb1 with SMTP id kl6-20020a056214518600b00499042fbeb1mr16893109qvb.86.1662041061834;
        Thu, 01 Sep 2022 07:04:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a24c400b006b9a89d408csm12328251qkn.100.2022.09.01.07.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:04:21 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:04:20 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/10] btrfs: remove zero length check when entering
 fiemap
Message-ID: <YxC75G4EssCx6Xiq@localhost.localdomain>
References: <cover.1662022922.git.fdmanana@suse.com>
 <4d19dc86c76af6e7ca8577e7d3fdf5a319a7357d.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d19dc86c76af6e7ca8577e7d3fdf5a319a7357d.1662022922.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:18:24PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no point to check for a 0 length at extent_fiemap(), as before
> calling it, we called fiemap_prep() at btrfs_fiemap(), which already
> checks for a zero length and returns the same -EINVAL error. So remove
> the pointless check.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
