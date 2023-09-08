Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E87798965
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbjIHO7v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 10:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIHO7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 10:59:51 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C01BF9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 07:59:46 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76ef6d98d7eso119983785a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185185; x=1694789985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VdHwZYwN5DVoSO9EHPKeQ/rZjBXG4mjJJrMVCCUZTE=;
        b=UZy969OaYyPNsf5ywRkTh8vHqdXP9O9t+C66rhbbZKrrgVeM5KfKPyncvmErgpclLc
         +ARcq9SvkykqGDdR1VeVhdnNyb9O8yDEVLggEY5xX9s/UKQx8xSnvk3n/9MqXGxE3JGj
         6cvaTtlHwGK82cy6LPk33XeokjdWDOfHHujeW2UHpO9TOOzD/PMtRzIYhDOV/h/jYU6F
         /ssGU5fNQqM45+0weTI+PS6o0QDWZ84buAZDZkhagJcLU4G2Q3e75CrZCMtW9YPU7Ol+
         YFJ3Pozy5ffKVhW2Mv+UipHNwXP+me1peQ3DoKidCb/hJ4tzPqrToC/eNbVTSb/bkqTB
         wPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185185; x=1694789985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VdHwZYwN5DVoSO9EHPKeQ/rZjBXG4mjJJrMVCCUZTE=;
        b=hrLUd7OpQTu6nGEXcV13kLaMC7QcoMX1PxfEVa30T7HX3B+IkJLaC37jAUuPIuE0Zs
         d7JLCw8rMRfRODHdRw7JLbYkzOUhK/F+iwoEM5lCz3+PDFtIxoYlxHEKyyCb+t3+G8wo
         vvXJauFAXURGjFbVNdDsndkgNZyWtc3TYlBHn0gwmjxhg/jtT/OstPLltM3J4J3NIrV9
         qYB0lVglriyDH9LmdEJC5AOVQCTO2xuoJtxoQB1uwYaW75FBIKCkHFqhudJo8eHUXu1d
         0OVCSAh3AiJKaqYq22is6iEm4/R0ySITJWAjxqQyoSqJNSOTxX4Sj2YcbQDdSJ54japs
         Z7uw==
X-Gm-Message-State: AOJu0Yx7D1SgH0uHZUmJmaDqVKoBTxhE9JZOxpWOSTjzngACZQztUw2J
        Y+pvqhp3i4n/N5EEbGAy5rlIS4vpwfhSLwiirFElFw==
X-Google-Smtp-Source: AGHT+IFfYaQY6CM+NNEGizVI/F+UN8apooiOA+KiQZUV3zQACtBgHOzhOlZiOf3cTnlJmpkayu7ZSw==
X-Received: by 2002:a0c:c24f:0:b0:64f:4dbf:b216 with SMTP id w15-20020a0cc24f000000b0064f4dbfb216mr2402057qvh.27.1694185185172;
        Fri, 08 Sep 2023 07:59:45 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e12-20020a0ce3cc000000b0063d30c10f1esm763321qvl.70.2023.09.08.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:59:44 -0700 (PDT)
Date:   Fri, 8 Sep 2023 10:59:43 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/21] btrfs: remove unnecessary logic when running new
 delayed references
Message-ID: <20230908145943.GE1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <fbc35af56c5b21fbceba9c0c1038a03907361427.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc35af56c5b21fbceba9c0c1038a03907361427.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:06PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running delayed references, at btrfs_run_delayed_refs(), we have this
> logic to run any new delayed references that might have been added just
> after we ran all delayed references. This logic grabs the first delayed
> reference, then locks it to wait for any contention on it before running
> all new delayed references. This however is pointless and not necessary
> because at __btrfs_run_delayed_refs() when we start running delayed
> references, we pick the first reference with btrfs_obtain_ref_head() and
> then we will lock it (with btrfs_delayed_ref_lock()).
> 
> So remove the duplicate and unnecessary logic at btrfs_run_delayed_refs().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
