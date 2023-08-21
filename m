Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF8783002
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjHUSL2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjHUSL2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:11:28 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99AEE8
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:11:26 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d650a22abd7so3799993276.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692641486; x=1693246286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cR6UyiAFb7sEas84rFpPWEenqeG7Dz0FFs4QmbQkDDk=;
        b=hmcInBwK06tPc2w+QUQT7d4IYLVcGG7UEWyYa7t/fy2NYj4chpQ6nVQg0WXZvm8l9Q
         vn9L5OGqYhwOrw8AqtDErBThYncQ2uRsWdaFdhLnKy6aoYtSYxlSlFKaR2mP+bA9JE2V
         TVKVM4pN//Ilb103VnWpu0wXU7UMTAQQCfbJYQWOaxgyqbD0eNFjQUj0UgNe4Uvh2upO
         9rtPpXqKL7HQiOwRnz6W1RjiyYcb/5Bmez1koOMz4DLwuDLELbp/CqBqYwWpjtrvEtem
         FJ4bnk3SCAOZUS3m/Hjgd1r/383VqNYbbuU19kMdB9AtWz2JnjB02FKaIDBxGkhw/Zaa
         q6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641486; x=1693246286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR6UyiAFb7sEas84rFpPWEenqeG7Dz0FFs4QmbQkDDk=;
        b=VcCi4dsta9jr8+xS61xYUjoP8g9UWVM/c/X1ebUvslNRxUOkr/D0+t6SXUc2omfFcZ
         2Zroe7iBKu+CjQsFch9JWQsJX2Jw23nXxCepDKLfThgCQpQUbDCTP6ZmBXowA+X7QjHU
         +UQp83SGjCkKVB1dpTgoS4p6kJUxdHgeQ9Pshr56KTjL5OPdTlUXXoZFsWn5dkPGOumi
         ZeJnkFJqv2qC31FItz3xWRxpCuWvSn8lEQ0XLgDFcJyEDUxvXp/Upv86tGw71E04ATAV
         i7YcNRR2jUybdaK4RKApni65wj82koDKgJ/enHl2XqwObtp6jFOBUDxTMX1rw4btSSOk
         D4pA==
X-Gm-Message-State: AOJu0Yzu0UbvysoeD0Jc2vwv5eBwMNBEqDVWyrMS8bHGpnLPFiVvoBoo
        /P9S81yEKutqQCJaqyMoxN17Dw==
X-Google-Smtp-Source: AGHT+IHjNH3FdL+TMooFyVBONBUhbxa6er2hIJ5VWGYkMC3b3ZgbMUORxUHTI2suW/xOtjmN89oAvA==
X-Received: by 2002:a25:d311:0:b0:d0c:c83b:94ef with SMTP id e17-20020a25d311000000b00d0cc83b94efmr7662261ybf.23.1692641485819;
        Mon, 21 Aug 2023 11:11:25 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j9-20020a2597c9000000b00d3e7b5ae274sm1888904ybo.58.2023.08.21.11.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:11:25 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:11:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 15/18] btrfs: check generation when recording simple
 quota delta
Message-ID: <20230821181124.GK2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <04ffbfcc145951c2f570312901b2c03c3c74e48e.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ffbfcc145951c2f570312901b2c03c3c74e48e.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:13:02PM -0700, Boris Burkov wrote:
> Simple quotas count extents only from the moment the feature is enabled.
> Therefore, if we do something like:
> 1. create subvol S
> 2. write F in S
> 3. enable quotas
> 4. remove F
> 5. write G in S
> 
> then after 3. and 4. we would expect the simple quota usage of S to be 0
> (putting aside some metadata extents that might be written) and after
> 5., it should be the size of G plus metadata. Therefore, we need to be
> able to determine whether a particular quota delta we are processing
> predates simple quota enablement.
> 
> To do this, store the transaction id when quotas were enabled. In
> fs_info for immediate use and in the quota status item to make it
> recoverable on mount. When we see a delta, check if the generation of
> the extent item is less than that of quota enablement. If so, we should
> ignore the delta from this extent.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
