Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38A8782FD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbjHUSA4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjHUSAz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:00:55 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE1110
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:00:51 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58df8cab1f2so40553947b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692640851; x=1693245651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhQBGbj5XcF1Ilq1lrNsmmPHFt+iUgXj7eIPRONO9Fw=;
        b=Pg2mDL++01Kfsh+as28ZKPBClFrS2CqvZ/M5k4c8qfg1EDpSCsG+OGQ0FqfVtmjVeP
         Ur71zYPW023/A1xqz7lUnax5cf8/xrDwvSiu98mWH2PcuR1dy7e1ncbCJn1O67QgCg7b
         16CJHrzGgfH1e2onMp7jqCyL2dImGYxglCv16f+6CNZFKjhJoSexoASuilEkwTd5lBBX
         w4rhG5N4jgBfds2fZDem6XEfY7E2ahP8+nkjomm1dYRx3g1/abuJ8ABZHAsY2MPUO4Mx
         0v30dZqjTFvNIVYE0F79vkMoiG4VC5BRaYCE93va/p0MlzIYd5MfuzqURAJKVIjsSzTv
         +RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640851; x=1693245651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhQBGbj5XcF1Ilq1lrNsmmPHFt+iUgXj7eIPRONO9Fw=;
        b=Fbt4BJCDCF7g+YhgozVCxUCeuFInyv5I0AVpMFxc80afEGRUEXeD6+Y+RxtpnuAjvr
         i5Wf3+Glle2r4qZ4fsO01zfwheckAakGwSdz1U7BGAxhL0mdBvcZc9XS2B2UapIElVu1
         MruxXOiIQIZ0aZLZ3L5Afd6IpZPylCWmr89ZQphwKTtBfNQqRahinMfwNXJ9Hsc0ayYE
         2rXWOHDhDaH5iNIedWU373ui/HKqu4gOfxwuKFkvc3JmNhSl2vRidp9Q5F5uI3bkx/SA
         7KCvwNtFTIAh97nlES16OhdNEKWZe9ksMRXUpEoWASRgKZ0GazYT+IAzWfCgQA22rTGb
         k2uQ==
X-Gm-Message-State: AOJu0YzMCNbmnOw1/XYiwyfN+XlB8Pr+BOGHtU+KdUHaBSz/+OXigxXz
        6DTfx3qNPPLAgGdylJjyONGBLqsseobyfDq+CeA=
X-Google-Smtp-Source: AGHT+IHmORPlhcBaKhX88bUIXKeLBB7WhX3ZdkP22yCbaio7GJKB5eRWV7U8qfqnSMCfPU/6ow6l2w==
X-Received: by 2002:a81:7289:0:b0:58f:2a72:618 with SMTP id n131-20020a817289000000b0058f2a720618mr7726903ywc.4.1692640850870;
        Mon, 21 Aug 2023 11:00:50 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d15-20020a814f0f000000b00584554be59dsm2346990ywb.85.2023.08.21.11.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:00:50 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:00:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 03/18] btrfs: expose quota mode via sysfs
Message-ID: <20230821180049.GB2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <9c9d150a93e91a5a648840ef77240e81b70ff769.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9d150a93e91a5a648840ef77240e81b70ff769.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:50PM -0700, Boris Burkov wrote:
> Add a new sysfs file
> /sys/fs/btrfs/<uuid>/qgroups/mode
> which prints out the mode qgroups is running in. The possible modes are
> disabled, qgroup, and squota
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
