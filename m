Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7B5B3818
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIIMpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 08:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIIMpT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 08:45:19 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D4E9C2D8
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 05:45:18 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id h28so1046287qka.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9n2P/V0qMRp60trOn8fWRWZ5ONtMehtmhUiJY/W8E7Q=;
        b=Cn/KKbjRO+76npDKoSZGF9UrXkJQ2Ups0Dn/yStFA88yala4f/vxTCZEvWLTA2dNSA
         rmLasIbqsSyGHDFWBw5T9PBigBkt1NQOt1rcDE2UdmaZmNWRXxmNEJMU6YApNMpWCHgw
         E+bOiC1LORDvpD00N58G06hiAHRl3Nd8U8HcJD/4Gep27qWBFCwhVq9/njfi0VOmUyCW
         a1mj82CcY3/xGcm2QmC/DV7CY2qocTQXhaypm+wWo1vL5QWDE0i9TdLzwLIgf1pl3Xjn
         kivTQp8MlXr+GOVBgtMtP2MSogWj6IUv7ClX5iFauM8k+5fNAs7xDa/Mj1Cxk7YHO3n6
         H/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9n2P/V0qMRp60trOn8fWRWZ5ONtMehtmhUiJY/W8E7Q=;
        b=ZYQbks4jOGgeozuYfwYbKRB1mKmOkFvkHSCSIjiATW70anG169956MgNV5TthGSwI+
         5OhRbrZIpEWw51YkulILad3rdvQ5z2E9qlro+AidGIdsDzUz+B62wO6R7ZCMNgR+QsGN
         Wn8ghRNHTmGZwFtpILHD8yBTLAvbTmelZaf9hTATMeoIDLnCfOcNOIn+Rtf2kgM47rqw
         pYMfCrWK1gOmO6eUYVKwgCwzad7cpxuCRg01hRzRBkiWcA7XFbW4ehgtrOYbB7+1BHgv
         YMZgmsk+jZ/RvlF+j5jrwEb+8fSYQ4sOB2ZaO/UypNadduFVgLuEMf0i3fjM5YJL6Ykl
         Hu4Q==
X-Gm-Message-State: ACgBeo02nCcuC0dodpeA5Vbaozqt8EpH0WIWKw7egWrFaohbskcSphp9
        n1G9PeP2LKokCNsO853UXnzVCscGO2aXYg==
X-Google-Smtp-Source: AA6agR6AN3ffZUQyISPIYSoubV7zDUdJJurC8ZF2d5WzAfp9RlS5YsC9AQlqU3juST0vtAjiiDVjSw==
X-Received: by 2002:a37:691:0:b0:6cb:cee5:a7e2 with SMTP id 139-20020a370691000000b006cbcee5a7e2mr5098915qkg.650.1662727516991;
        Fri, 09 Sep 2022 05:45:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b006bb83e2e65fsm390559qko.42.2022.09.09.05.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:45:16 -0700 (PDT)
Date:   Fri, 9 Sep 2022 08:45:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     clm@fb.com, dsterba@suse.com, chris.mason@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_bit_radix_cachep declaration
Message-ID: <Yxs1WpoG9q4R0EGv@localhost.localdomain>
References: <20220909065451.1155969-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909065451.1155969-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 09, 2022 at 02:54:51PM +0800, Gaosheng Cui wrote:
> btrfs_bit_radix_cachep has been removed since
> commit 45c06543afe2 ("Btrfs: remove unused btrfs_bit_radix slab"),
> so remove it.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
