Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E28F64B965
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 17:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiLMQQX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 11:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiLMQQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 11:16:22 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A9620F62
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 08:16:20 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id j16so230239qtv.4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGJFr/h0zWs5IPHVWeFPfhdQqEnero7KujyVZ29KFk4=;
        b=3ZyA+4Wot8Oj6x7QDTEF13XH+IYxdpAWrQhvJmyDpbiPvfud2NtzUBgFwSB5ZfXrlo
         u0x+KOtvHZGOMIXPkQ8huLeQ/sPdG45rkr4FOHLkr050K6tgYGMAPV3LjsqlXc/q2oX2
         YFxGfzPiYtWOKkF214Jky9q38IEDWlvweVOewX3OQA/fDgHdDoIMcXzGF2c+g1dS3/Ll
         O+I3vLLEj/sR8JXwe9INf7EZl1HCygnTWKZhKHpioi62EOgXH2fOw6lHXGQTJbu/BVCu
         wV6hqCnt8iRrQSACD+pDTEu4ExfYrBv5Li+VOipf03z44M9pXqc41NnkAzSTW1m1aMyc
         RYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGJFr/h0zWs5IPHVWeFPfhdQqEnero7KujyVZ29KFk4=;
        b=YTUBgGbIEmOxEpZYYdZ5m/L4itt9xlwWsBHS2fglNy5MCTQssay9sB94ZrWUjzUaxX
         8hXS3tieYhPm47UW8L3Sd3BnOBRrf1y1AVjhAfJTU/2+V/+mEgwCQq575v4JvaWe2Ajs
         m8d7TSBVpxzXPbRtyi9hhdpkwDYxm0TqM/BqbIMrunRLx2bpzCVdRBS2A0AggFzYO4Vp
         RWg55j42JA8NxDymI7fLDvXqTkg2qcgaXydkx65zLqHZnltObZHa/6F5i1sIwpifL60f
         kglIYBPMHC0QJewpxUPADHgHBE2IJ4BrireeLSyiLHISxh9NHPOfjJU1vp2hUWhJYL4a
         nZQA==
X-Gm-Message-State: ANoB5pkIapetp1s9Ils2ov0zlTRikHXWHn1tBh7F9Znk1ofjS7XZb0kc
        HyKxBcvUrkR+abpaDErv4R0iKXwIbOlAu+TYbjw=
X-Google-Smtp-Source: AA0mqf6tCp6y1cb3yi5aTxo3BC7I6Zt9p5HWv/EqqRJ6ouHQwr70fIGQsXh4KVSY50AKH2JUQJEp6g==
X-Received: by 2002:ac8:4883:0:b0:3a5:1680:4cd0 with SMTP id i3-20020ac84883000000b003a516804cd0mr26340965qtq.7.1670948179509;
        Tue, 13 Dec 2022 08:16:19 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bb21-20020a05622a1b1500b003999d25e772sm91432qtb.71.2022.12.13.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:16:18 -0800 (PST)
Date:   Tue, 13 Dec 2022 11:16:17 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix leak of fs devices after removing btrfs module
Message-ID: <Y5ilUXAjOwrJ6s44@localhost.localdomain>
References: <914f0ef27d40e6bac9b63f27c40357e7dcdc1bb0.1670928105.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <914f0ef27d40e6bac9b63f27c40357e7dcdc1bb0.1670928105.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 10:42:26AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When removing the btrfs module we are not calling btrfs_cleanup_fs_uuids()
> which results in leaking btrfs_fs_devices structures and other resources.
> This is a regression recently introduced by a refactoring of the module
> initialization and exit sequence, which simply removed the call to
> btrfs_cleanup_fs_uuids() in the exit path, resulting in the leaks.
> 
> So fix this by calling btrfs_cleanup_fs_uuids() at exit_btrfs_fs().
> 
> Fixes: 5565b8e0adcd ("btrfs: make module init/exit match their sequence")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
