Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5E782FDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbjHUSCY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjHUSCY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:02:24 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EA010D
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:02:22 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58fa51a0d97so29902037b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692640942; x=1693245742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWx5fhiboq028lSkT57FkUacf6otyX0c9XbHosvtA0o=;
        b=FAKAxSn2Hnh7iAgAS5+IfEpM19swdxvp/hfxO5rx0S1Bd802W8PFbHmqI0uQ5znfaG
         W8OfqqF8wrN0DsvlreiOaiiAX6rjZ5L4F/lirHC3MozGNnEfu8jhbyTlUNaur4vgyKkZ
         /CLLz1ieeGtUBAlVTYTPI11qB+kpCbixhPCMS2WibwmypeB1CveWmCtDwPT8D9dmT/Ce
         dgy99kU1ab3v6+swv/Q8z1pPw6DaYbrRqYkugcM+IjSHzUIbpuoOYxlvBql5nZnWKSyO
         JI7ah4yQgSuM1g3o1zwOoqg0sqh4PDfskN7VVbjYN5dHf1OgucTRp5Gt09/tKvdLatSY
         8lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640942; x=1693245742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWx5fhiboq028lSkT57FkUacf6otyX0c9XbHosvtA0o=;
        b=HhfnpfDZHK1I/my0lptUVhZdpyS7+Gg5HpmxSqIUD32ZVvtqzvzzuX6NSd7Qf3qAAG
         uWUEq1uhPKEzzy2LFfBN9mNt4DdxU/rtlNOTNoWKFjaz2rvmztMEsx61OMqi5s+qnHBN
         T4dS8k0Nsiq6auD7nJjoCA3p3ZGrh20OEa+TgJLvuAJAk9UJ5/Od3tYGm3aLh3NNwwyX
         OgPcswrqZpWeFUqsTsSvmQDzT2BxGWdftyu+frnkBGUq0a/o+TIgsOUd/ymMLXwY+wYU
         EDCV6J6hkSR9Fkn09Lkf/UEbBHjxAm+k6P2XE4/OyzXU1TW+qBrbB3udogRlrCODhOp/
         H0HA==
X-Gm-Message-State: AOJu0Ywqdo1O3AIr8+F3M6xPM/x1tZ4Kd+mWYd1lHdFFM355S57YdN0s
        s3tWb40YNDeE/fMW+Q1w9R1XWwNB2D10AzpxdxA=
X-Google-Smtp-Source: AGHT+IFt5kBy5W6pWRS3ZSacx0vvGWc9jIl+kZts/j23xHsqmKUp5iZaMWx5hvU8dVn1ewqrRY0qRA==
X-Received: by 2002:a25:9e12:0:b0:d21:ef87:c1be with SMTP id m18-20020a259e12000000b00d21ef87c1bemr6783233ybq.27.1692640942173;
        Mon, 21 Aug 2023 11:02:22 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v193-20020a25c5ca000000b00d43697c429esm1982691ybe.50.2023.08.21.11.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:02:21 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:02:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 06/18] btrfs: create qgroup earlier in snapshot
 creation
Message-ID: <20230821180221.GD2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <4418d4544e16023fb0b7db6969b657b32cd25f93.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4418d4544e16023fb0b7db6969b657b32cd25f93.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:53PM -0700, Boris Burkov wrote:
> Pull creating the qgroup earlier in the snapshot. This allows simple
> quotas qgroups to see all the metadata writes related to the snapshot
> being created and to be born with the root node accounted.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
