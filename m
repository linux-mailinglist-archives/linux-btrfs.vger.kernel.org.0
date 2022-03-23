Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0584E5998
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 21:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbiCWUMr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 16:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiCWUMp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 16:12:45 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC7F6CA5E
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 13:11:15 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b18so2164956qtk.13
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VUMIpHfUdIoFrslX0gjypBjD2CqbOIzjjUl/qg+jRlw=;
        b=iy13Knp5KESezNhrIsFSxH7+Wa15CMSFt9Q+kaJyTxmZppAwX9T/RwWu4VZNQWOuVQ
         QdPwx2Jx0tHuPkXVYk9+kUR5hVCqMyi2AKxK2zg9UDVivEywyjv4oXlEjKc7SCdPJjye
         TKWc5N5YKhAozbraBp7OWnS9uLmsSYfAoZ5CSXMoORZWwnQ0KL/FrDTVoCjfykECKYoQ
         WRecyhb8iDX4k3oJ2WWN7LDZJqWah0hyWXRyhJa0R5QzscFeu6pVYg6l4FDq98oP4nxA
         +Hl6m/ZPqfmqVQZMNrBBu7OS/A8dS7P6G+nqXliizyxedcxyh4cLKiu0H8v52mKUsE+C
         4PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VUMIpHfUdIoFrslX0gjypBjD2CqbOIzjjUl/qg+jRlw=;
        b=pYn1ZeEIxk5EvsyQgyuGepdb3ZRBIrRUIYQriEdeAXr12UVTm7T4ycY7zPVrlGuYXQ
         1oFFWidCpjmc7S9uUtGgiCrtG2ZXoISFdt4zuAwQRVW8GheONeBdAWUslvwZDf6CqigR
         zqByDsubHo+2oCdtIVIk/KlhQcdVpSAhp74jPtH1OvAFMP9ktwU0NMpjwhhGCSr8c/gn
         E7gRyl1qcV895Oyxs7+ydy6Pmx7eAEAqp+I+OxP9/MAZokaZRmAIRSW3ezslQtcGdvmV
         +zSaKRzqDEo1t9EQqIfF8ix5p17TuVBAbYLUZ6QT/pxxEUe32hWQxqkduDZcDwCuA4da
         lmuw==
X-Gm-Message-State: AOAM531gm4ttHjPfgsURb1vGvsEFHD3tlsx+uiuKfsOYwdyQ4OuYcqjs
        SZDJkZwSo3ViZDU74MgUdCEiHg==
X-Google-Smtp-Source: ABdhPJz7cUGkIC472XfiKJpG6ke04LnWh2QaPYQA4/0tOs/0YYmVqs0y2Z9PW3Pgaur3XWHoR17ynQ==
X-Received: by 2002:ac8:5f8c:0:b0:2e1:cd8a:bcad with SMTP id j12-20020ac85f8c000000b002e1cd8abcadmr1406997qta.683.1648066274234;
        Wed, 23 Mar 2022 13:11:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o3-20020a05622a008300b002e06a103476sm729507qtw.55.2022.03.23.13.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:11:13 -0700 (PDT)
Date:   Wed, 23 Mar 2022 16:11:12 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     boris@bur.io, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: add print support for verity items.
Message-ID: <Yjt+4F1fjdkaPxmx@localhost.localdomain>
References: <20220323194504.1777182-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323194504.1777182-1-sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 23, 2022 at 03:45:05PM -0400, Sweet Tea Dorminy wrote:
> 'btrfs inspect-internals dump-tree' doesn't currently know about the two
> types of verity items and prints them as 'UNKNOWN.36' or 'UNKNOWN.37'.
> So add them to the known item types.
> 
> Suggested-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
