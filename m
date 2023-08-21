Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9834F782FDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbjHUSBi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjHUSBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:01:37 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C648F114
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:01:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58ca499456dso41259457b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692640894; x=1693245694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26SKYBBAze09pZgctqBVX+wvLCij0fMuFNv/boTWILA=;
        b=cqqSXqykzBoZDfQ/qhdxntxSaL9Siya61bF9jcm2osW21RIKF4uhj7EUll8RdwacI3
         JkT+svb+YjiO3yOdRmur7caNAkHkHju3UI6owBiBmPwW089Mmda38JMk5toX0kW9cwVZ
         5sWLzt9hiXuzwyVHfimFFD1wsjyWTFUsVy9ZVF1shp6Vi7DI8xOp8vyAF8hhaRQMe2FR
         PAvIBoFDQRsDRTM5N/d9Myt6EyskGnWM34axoIBGkXKfrXQdcWtCAA+5QnNEd1Ns0JLo
         E525GbaLVgVDtPlaW8ONflIv20RBw//f1G/ZCOH3XMkFC9Du34E2Bg1VnlmHVOS/IdmC
         ZLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640894; x=1693245694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26SKYBBAze09pZgctqBVX+wvLCij0fMuFNv/boTWILA=;
        b=eDSxJhDjola0rLGwnHioOWyxIbRWrWmMCcG8v2dmtD4kayNp9Q0pOOIKpt/7SdHw7/
         mpSO2xh3z9776HPlORKBS8bDGe/mym0/HG8uu7MMuSlx1kqoKthY0708t8zLFoMaqiem
         A3rBXRFt677zhE9bM325GtOFfofcnMdS/qjcRBmSv0WN3BOrvBAtAj+Po7iObnwRclVn
         /xhp3oTXW0P+AwZotfiJ/wNDXgCRsWJmLfPB3faFLOOIPwSOIRGYhnPb6l7XgnYAstCe
         ZxFddxHdkbt7U7X0r0GRim3FlyYsvm0TOHDVRGPkC1s1usbbNKyXDdXdUHYc9au9cx7E
         QJYA==
X-Gm-Message-State: AOJu0YwQ13bmVxRV4IaXWbTqoal3xIILYQJ3g7bRqZDig/CKDm4I4hde
        /8mZXNSOa4pEDpjz+PUyokJ74A==
X-Google-Smtp-Source: AGHT+IHfhTmKH8oWrmxDbcQMxCpGBE+GkDcPttoJTFreB3UrL3OpuOWlV9bQLHMWEyGvR8wY7mGUTA==
X-Received: by 2002:a0d:d752:0:b0:58f:9cd8:9e4d with SMTP id z79-20020a0dd752000000b0058f9cd89e4dmr8433180ywd.46.1692640894001;
        Mon, 21 Aug 2023 11:01:34 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i124-20020a0ddf82000000b00583f9bcd531sm2334788ywe.97.2023.08.21.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:01:33 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:01:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 04/18] btrfs: add simple_quota incompat feature to
 sysfs
Message-ID: <20230821180133.GC2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <f3aa781253502054034c839ab0d0b18ec35a3d3d.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3aa781253502054034c839ab0d0b18ec35a3d3d.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:51PM -0700, Boris Burkov wrote:
> Add an entry in the features directory for the new incompat flag
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
