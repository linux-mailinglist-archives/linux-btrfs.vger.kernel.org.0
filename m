Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BCF4B2753
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 14:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiBKNpJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 08:45:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiBKNpI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 08:45:08 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4969E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 05:45:07 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n23so16423886pfo.1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 05:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DStPIMx98gO/8g0d32eeBofKrWUr/gJ2V7s00D3hs7s=;
        b=J04pFL0TxgkRE3BFoMq0luwztf0YQmSGu2n5wHzTOaI1kuVtHOSyo8hvrpCMcxSBQn
         ahVMt1zhjJzZqg5brpoBHCOpWYhD9pxRj8ryPDg4oSJ/N1R3p7OKp8eiPCg8oX1B/L7X
         n+G7yfKBXgysjBoZ4thrwVEQQdePoJY6SntCB03wqNwACT0gYHciG+eATkXG8he257Xl
         l7DC/BSy251wnjx9riZNHrvwa/41vaajD2ilS6NOFMc0BNd2Gbqr2QHLfDzuJgvkbO4k
         MBtA3q9BED36rldlWnuip62p6UGt9mxHIwJ6kEYC2IqexJUEYiVNfoRNj3RqBT0DRaV0
         y2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DStPIMx98gO/8g0d32eeBofKrWUr/gJ2V7s00D3hs7s=;
        b=tK4GNfpd+N9cSZQZ9IFoYBvrSD/SaxdYaZ+tZ5+uZipcXMvOAjBRf3J2beXhRoyu8B
         prQlwnJGSgWgOR1iOBmb83qW+UosEk5X+RxSSaHtucksrqiN8e0yREN0UBECz5XcIYMl
         JCFE6nGHxhE6kHZojWOdP6WQ/VDfdQ6W2k7LVdUpogmnNBhIHXrvgtgnDbh7I43H7982
         WQqhnhwczFgvxUFw1+KEgfbYZSElMcELT+M5VduM2CgEo9/SwCLnlyhX04PvZgsyITR2
         8cGM+qS0PuIhzLHqqzbcxjAp0Q0VUor0oY547WN467K3FXDcG5aijGhkqJrH2JMoOiOT
         kKig==
X-Gm-Message-State: AOAM530m+UJ9cRahyOaFnoCu8BpoV0xZHgxpq2B6OQTagtzw7SyQQOPX
        2hpIRFlljXcU6Um06sW+GMYUFekM3pM=
X-Google-Smtp-Source: ABdhPJwATvAjW/Ey1r1yZAebg5wEj6+4bDWc93OKGvgWkzS3+1rtmTPhU5pYEMCiaP3BNMjmfzlgBQ==
X-Received: by 2002:a63:2b89:: with SMTP id r131mr1347908pgr.578.1644587106986;
        Fri, 11 Feb 2022 05:45:06 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id h5sm28407355pfi.111.2022.02.11.05.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:45:06 -0800 (PST)
Date:   Fri, 11 Feb 2022 13:44:59 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: Remove an oudated comment
Message-ID: <20220211134459.GA1181@realwakka>
References: <20220210125204.962999-1-realwakka@gmail.com>
 <20220210185906.GX12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210185906.GX12643@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 07:59:06PM +0100, David Sterba wrote:
> On Thu, Feb 10, 2022 at 12:52:04PM +0000, Sidong Yang wrote:
> > It seems that btrfs_qgroup_inherit() works on subvolume creation and it
> > copies limits when BTRFS_QGROUP_INHERIT_SET_LIMITS flags on.
> 
> I think we can delete the whole TODO comment from 2012.

Agree. It's written very long ago. I'll write another patch to delete
it.
