Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9351D7989B5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbjIHPQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbjIHPQf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:16:35 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF21E71
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:16:31 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64b8e1c739aso12389736d6.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694186190; x=1694790990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Of0pawpxAr4wp1pZV/0dEiNOrUnaOXlnAy7orE/8rk=;
        b=JCxeqXw/ObL0uA2VXOfuS+Iyl4QmnglHDojHRDZPIYS/+ni54AXEJCyQNfh5H8a2KL
         EtW0fQdn2+jJSbhRauRcNwt0BvCQw8S8MygWjFIpaStwC+bWK7+dQjH5S408O6YSTjcH
         WO9anCN+B7TTMpOcFdZ70HiOzcgZIl54JIKlJWKykNXDvBqfT1xGGouAnvU7ha1Kf4Ae
         D+FuxW5YyY4/03hGgyew4PK/pm1BxpvbB9lPHBoLa+jB0KHhJnLZ8WaF7OTMcn+KA2yr
         eD1pOLJXSnzyZeDx6cWRx1ykA8an9D8XF7R1/S7SDGbmjCHllH4gLmOqS5GAnyMJuTPZ
         H5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694186190; x=1694790990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Of0pawpxAr4wp1pZV/0dEiNOrUnaOXlnAy7orE/8rk=;
        b=h81W6hqHJ4NpuCYX3yH5HWoIAE9bQXHZwExzDVL1+VmEcIMts0uK5Nwzqi3R/ggPI+
         b3Jmbj9G7RbQleCRfqvIzQ3+EQx+Uju8NVYfDYrzf5s+WfLgXuS+SaKSxXW1cRnusj9n
         ro2tu6ENXLJjr0PpwGKIOj/UJpp2zkLc7EdoHYH0YXY9G50cEcz/CZ0ujluG8U2p6eBE
         uKVMw1DuVbnAq9Bm18vxAJLHwE1VrNo8Z/tcmSjcWZrsx3PlnZx4ZmDVhzQ8URz4bYtE
         e/PyLVQQWk/jeh42wqmJCEn/fxfv34fELAUwJiOFXbyr11/o4QBvtAv32lDZlaC15f5I
         THUA==
X-Gm-Message-State: AOJu0YyODTlcmSbSdFofCpeznJMf5cVf6P7BfcBKLWMqVioFuzs4fFqk
        axjnqLMuHoXaQ8kbcxhF+bUSdw==
X-Google-Smtp-Source: AGHT+IFMDENXY43mC7HUDRHc3iFM+fA3FlRUESneG34JDNcjes9JdJT++marC6XkU7mWkTdCzYIVgQ==
X-Received: by 2002:a0c:f189:0:b0:64f:4ba6:3b2d with SMTP id m9-20020a0cf189000000b0064f4ba63b2dmr2561993qvl.44.1694186190678;
        Fri, 08 Sep 2023 08:16:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o3-20020a0ce403000000b00653589babfcsm767707qvl.132.2023.09.08.08.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:16:30 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:16:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 19/21] btrfs: remove pointless initialization at
 btrfs_delayed_refs_rsv_release()
Message-ID: <20230908151629.GS1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <b644560da59723f2d1400dca83675c427556f95a.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b644560da59723f2d1400dca83675c427556f95a.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no point in initializing to 0 the local variable 'released' as
> we don't use it before the next assignment to it. So remove the
> initialization. This may help avoid some warnings with clang tools such
> as the one reported/fixed by commit 966de47ff0c9 ("btrfs: remove redundant
> initialization of variables in log_new_ancestors").
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
