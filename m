Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8C7989A2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjIHPLX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjIHPLW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:11:22 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE51BFA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:11:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4135d72c75bso14824671cf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185878; x=1694790678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlxGkSrGajv2BqnJOBGcHTg+WwECuUyH2GVJ1XgIPBA=;
        b=Pvf+0rFJhBBJtuZ/mcp5l4aj4C+ZY/X9F0AjLX+IMzNVeBOuwo9IQwVq7JqF8C7UMA
         isGyHvbvWeDoooOQ31gLYbcG81PukDKwzsxuqZgnC1Rx0CGCBahzuzhICTCYwdLVq8RI
         4YX9zLGt4Q5nlW1xWOqO+11hknH/txW51xbqavINpNeQSHn5g7bf4zcUX4hOULe9Plbx
         YYIZisJK/mxBTjHW+UZlZx3c4KHBjpr/eXSP9HGqi4B72eiwL/QZh9sGlvGRT2rhd1Dn
         j+QVvsJDq3Py61gQCxspHpt6MbVQpcd7winValGcgl8+b2pNSEnTnAS50XBEoI6GHWLz
         iRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185878; x=1694790678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlxGkSrGajv2BqnJOBGcHTg+WwECuUyH2GVJ1XgIPBA=;
        b=KxSk/ffM2kjHmcMxnB5d9eKKNQPdnfAXJ88z8noh/DVqO+0lS5kYpLXZ7mAw9yZCvZ
         3/YxVXenAH/eAJ3KuJ3KD7l+FXQH2QTqj1zjPB1T9NippySWcHl8FTdt0zP/z1DQ1XjL
         q5Hq1BCBzLE1SKJNGTtgqms7eonCCw3su881rhjNC6gvkT5A2MeN2SRmRyXar+1W7m4m
         HHbvXPPVUx3WfFVnUygIGDJRBN6dhnCraUgtpsNtf7x19lcgSPwOUVboI+D78HoRmj3j
         nqL2eE3AcZ1uYGkxRWDfNjko7WjD/TeHhN9QL+e3uz9WbHeH4A4tZihhazXsfQnD4H+d
         O8vg==
X-Gm-Message-State: AOJu0YxXErWCsVkf7lPlP45Pf8clLCR8cDGqH3gqLURn1J1DGDJqzDVC
        JuPIMzn32dYuFg91hKoO0fTq7tTEcxwsGNdALzkYFw==
X-Google-Smtp-Source: AGHT+IEChWHkvevL7EPwMnMS9z3iB6Rau0MsvKVFlYND1XnDm9aLJhztVcecWrDuOMDVwTvHEnkpBA==
X-Received: by 2002:ac8:5c46:0:b0:403:a9aa:571f with SMTP id j6-20020ac85c46000000b00403a9aa571fmr3708520qtj.16.1694185878139;
        Fri, 08 Sep 2023 08:11:18 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j29-20020ac84c9d000000b004107fc9113bsm666016qtv.22.2023.09.08.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:11:17 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:11:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 16/21] btrfs: simplify check for extent item overrun at
 lookup_inline_extent_backref()
Message-ID: <20230908151117.GQ1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <1e6e5a365ce01567b0334ac2792c8e8aa1fe1a64.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e6e5a365ce01567b0334ac2792c8e8aa1fe1a64.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:18PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At lookup_inline_extent_backref() we can simplify the check for an overrun
> of the extent item by making the while loop's condition to be "ptr < end"
> and then check after the loop if an overrun happened ("ptr > end"). This
> reduces indentation and makes the loop condition more clear. So move the
> check out of the loop and change the loop condition accordingly, while
> also adding the 'unlikely' tag to the check since it's not supposed to be
> triggered.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
