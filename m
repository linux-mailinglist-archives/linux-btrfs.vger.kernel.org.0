Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16D68C735
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 21:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBFUCY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 15:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBFUCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 15:02:21 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF5029E01
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 12:02:15 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-52a849206adso24531607b3.4
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Feb 2023 12:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiPp4Fkfw4Dtgl5T1HECgLFlnELIu6UWKYjiTaBdfCQ=;
        b=pKiKhKCRkmK/fQPCa+xT6/wRvRR9Qz+6gNAhRyMJODKEL4/DkhbFg01qDdQjhJkXNN
         Nv57lwFOTcakqujhwOoY8aSi01eLhdzejOfJkPQCgDmAWYzwaI0bA1gn2o10kDdgq9ea
         m0UY/z+DeBK7k2kNdzA4cTy27NOS7xPMfkubP/brzyfTeRk0Bs9GSt7H7GN1EOsYnzyf
         NYkU88lyDvD5himPIHA3NrbP/hMsa23qHeJPXVzARNEgCCxkJMADTod1B2iTnN3x6qQ8
         oHLHDxb7UK7+hYHhSr/3ZazaxS0tlUoKwALjuavondnOvOUWvckyFtInxL1EgLnMD9GE
         01Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiPp4Fkfw4Dtgl5T1HECgLFlnELIu6UWKYjiTaBdfCQ=;
        b=rGM3O8H1Jw3yQwpTrwanRVSJg5/vWXr/6WIypW1DkW0anNrLrX/awBPx/WSE58vide
         8rth6ztwur0wvERiylCu4GrIgQmOvjX9/stbBfUfs7cZLWRmyj4T2viU9HgTknBCoERC
         TR+waQtmRfKTyMhBEVDqEwMUj6pfnCFjZghZ8IvDqbUQpUG7e0p16iANYZGobdTxVXyy
         4+K+uP6q+InIe7zhVlsd7LcxjAxbqnkTCPRvBX1xAWikTtcwVo7+W+zxBxMeK4GiVSw6
         g5raKmayStL1o/eIUTkS8xoLJRwHQqDg6HP4gvPswWsa9ZrzVaHum3ShjMKVXciRq6iz
         AN0Q==
X-Gm-Message-State: AO0yUKX80p3sHSOVDUKjfsG4dcwXwksuB4RQVmx567Qe5anOxn2selh8
        /mhrmgsfoyIqSp5buSUVRTeBiV1rnQRbcPlBurQ=
X-Google-Smtp-Source: AK7set/3JHcuChy0kAOWG4Aza8glzEVS+Iyw3rJgqRAJaj62Ad2Q0wEmSq9mCxpf+a7MW7jVJkAu6g==
X-Received: by 2002:a81:ca03:0:b0:527:b78e:bc67 with SMTP id p3-20020a81ca03000000b00527b78ebc67mr204895ywi.50.1675713734327;
        Mon, 06 Feb 2023 12:02:14 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u15-20020a37ab0f000000b006ef1a8f1b81sm8229724qke.5.2023.02.06.12.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:02:13 -0800 (PST)
Date:   Mon, 6 Feb 2023 15:02:12 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: add a stress test for send v2 streams
Message-ID: <Y+FcxLs5eLzEiR+l@localhost.localdomain>
References: <a2a5700b744bca710ff0721f1d1fa268d76430fc.1675353192.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a5700b744bca710ff0721f1d1fa268d76430fc.1675353192.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 02, 2023 at 03:58:09PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently we don't have any test case in fstests to do randomized and
> stress testing of the send stream v2, added in kernel 6.0 and support for
> it in btrfs-progs v5.19. For the send v2 stream, we only have btrfs/281
> that exercises a specific scenario which used to trigger a bug.
> 
> So add a test that uses fsstress to generate a filesystem and exercise
> both full and incremental send operations using the v2 send stream with
> compressed extents, and then receive the streams without and with
> decompression, to verify they work and produce the same results as in
> the original filesystem. This is the same base idea as btrfs/007, but
> for the send v2 stream with compressed data.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
