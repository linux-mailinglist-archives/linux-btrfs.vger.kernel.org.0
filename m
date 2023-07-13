Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FC075248A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjGMOBy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjGMOBv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:01:51 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893672724
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:01:46 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so626714276.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689256905; x=1691848905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euS9K5jJnQeZY0gjebColKg4XLuJzN35nMfMBVc/nlY=;
        b=dxXvpKzBddO0pbR+AhXdl+gPoq9G3rrr9ExZkasisnz8wIxowBRIU1IP5W9cKHb1lu
         Qtazz2bF1m0ODbubl1CBkhzt2a8PJCuCPeh/GFNYDEAunpYpHvG1Q99KqpwHW/pe39bJ
         fvIyRnAQPO6sIa1DJhsZmRTeD2QmuFnaMJ30eBGkEP8oyx3TjcwmNB9MoextjxbuLtLw
         MmAcYmfn3h+wrBbrV/f0/WyGqfDrYfexIO+NdIqeVzzbGSCj06jwKiyKZawgQVATRkso
         8DAjq5xpX819WXrY9zZzcFNaIdP6+FxVsTuHOvgh6iV0Qqrll/PLrruLTJhA+5lICQab
         yYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689256905; x=1691848905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euS9K5jJnQeZY0gjebColKg4XLuJzN35nMfMBVc/nlY=;
        b=YcljAIbkr4Q6k3TaRJq5N/rZpiC3jCVci65CESvx7HwcNK/4iQcznGFuGVBanOU+r1
         kXxCtZp/iQ0KZawC6czsme6DaRsRF5lSXCDozNDH0hb6Ll5yEVBV5iC95l2GArc1JfKw
         tTobcLp5aXVABc8FRk4DTRACfwwXivON8vvQGkbWQQvS8D/OUo9vn8dcVf/S6z1+BvZD
         i5lK5M+EB2dUCPuSUMCtQD38g785N8Lf/59yUy+7f5i95oacAbzBnYaAQgdQekkMcZBd
         qY/DQg5xYQqVUVFQEz3AOX2Mu4kbDaNi/TMqb1nkrEyrxNsMuR9Dsv2FRKE2z7J0+e6A
         Xv1A==
X-Gm-Message-State: ABy/qLaLg3bwphpPcTz1mHi1P7hIJ0XB/mC3ulE1wXb7jseJrchHd+P0
        u9MiMX5y4niQ3TqnlmshD98oSQ==
X-Google-Smtp-Source: APBJJlG2ibFQB/DJF0V0UIlAVQf8xpa9jErfOVrUmLXM+rJ4DfdFZQQx40AiJJWw1PJQlIKO/x5Xzw==
X-Received: by 2002:a25:3f83:0:b0:c5e:328:87c3 with SMTP id m125-20020a253f83000000b00c5e032887c3mr1464875yba.53.1689256904150;
        Thu, 13 Jul 2023 07:01:44 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 83-20020a251656000000b00be8e8772025sm1416011ybw.45.2023.07.13.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:01:43 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:01:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/18] btrfs: free qgroup rsv on io failure
Message-ID: <20230713140141.GA207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <860ef499b2c45e2798267dd323b1b991c2bac79a.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860ef499b2c45e2798267dd323b1b991c2bac79a.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:38PM -0700, Boris Burkov wrote:
> If we do a write whose bio suffers an error, we will never reclaim the
> qgroup reserved space for it. We allocate the space in the write_iter
> codepath, then release the reservation as we allocate the ordered
> extent, but we only create a delayed ref if the ordered extent finishes.
> If it has an error, we simply leak the rsv. This is apparent in running
> any error injecting (dmerror) fstests like btrfs/146 or btrfs/160. Such
> tests fail due to dmesg on umount complaining about the leaked qgroup
> data space.
> 
> When we clean up other aspects of space on failed ordered_extents, also
> free the qgroup rsv.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
