Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBBB5A99B8
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiIAOIO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIAOIN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 10:08:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA725D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 07:08:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w28so13457082qtc.7
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Z1Fi6zI4Ju9KwAPzT52zBSvEAAkLxv1kG+9eUFI1FOc=;
        b=ntEttfGQG8TpR5mQFdpFFVXpLqVzz+9EQZQKOmByQEJwF6z9bHV6Ko6a4zZMugpD8/
         R2QwksTSo5NeaqLfj4b0zH+xPnluPwXvCiLi1iPRHDbU96rmhMjy7KCgDyJSk7AHiYVz
         1JkQOF+Xj4g1PNigfgWsSuFYwBt2oruQZ0YcjFxPKZZVYGfic8xOGIC0ue8wUGj//vRj
         qOvL60Hj0MdFvacjZTA0dHu+BlIZ0UciZDISrmcV5WZOmBHwnQlmquJp+nrPBnsZQh9v
         VXHHr2iWORZE/RAAFW0DpLi1rYEmvbUsDpjony7j2Qaj7IXtq6kZmKMty7ar699Bfctq
         aPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Z1Fi6zI4Ju9KwAPzT52zBSvEAAkLxv1kG+9eUFI1FOc=;
        b=7d6N05OKEIRkLiqcQZV2SejFQ8FyfONiCHKF7xy+tpEuLFAo8bA/dqCUT/RoOj26kX
         FHVcfkLrC+GCqsgrRp6EuRgM3y2KdFAqsPXuMmneD8ITiHGjt8Xl5x5zV5uDVzr1nhNA
         cS0vToQhsHfQiFm+3oSoGUq+UeBh4tYosIrdpKRGD4gtJdSUf9ygy+bYtxoIKX7XmvNB
         /z3YqfSIQyIBRsq2Pvsd3zYOnJMCqHaX637nYjcysKGQitqzqBP3XgZwnj5xCbIA8aXd
         zv1vDXJ6bKwWK8Iddk+OuOZvJtsvh0IvLiXufj+cgsTe9wJxzJNf5c8c3kCJcQTPRGvS
         uM5Q==
X-Gm-Message-State: ACgBeo0mm7WJRCtDhYH9ybDlpSXzzBUQrxn9CtDQ4TARbPHQfWsbV7PC
        UDunF8ihUe/wRZ5qozvLuLycw5TlkHf8fA==
X-Google-Smtp-Source: AA6agR49VvkhNeJejfCO6lvGIm/0rHjzphun8PwfOqUdQLtIhGykzWCZFcJFbAcbnWmxAyjO1RfdVQ==
X-Received: by 2002:ac8:5dd3:0:b0:344:94e6:d667 with SMTP id e19-20020ac85dd3000000b0034494e6d667mr24398423qtx.409.1662041291664;
        Thu, 01 Sep 2022 07:08:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x17-20020a05620a449100b006bbd2c4cccfsm12933943qkp.53.2022.09.01.07.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:08:11 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:08:10 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/10] btrfs: rename btrfs_check_shared() to a more
 descriptive name
Message-ID: <YxC8ygjqRfBczjpi@localhost.localdomain>
References: <cover.1662022922.git.fdmanana@suse.com>
 <c9954cf24dce0f62ad89dd5839c36e3ba9b14b8d.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9954cf24dce0f62ad89dd5839c36e3ba9b14b8d.1662022922.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:18:27PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The function btrfs_check_shared() is supposed to be used to check if a
> data extent is shared, but its name is too generic, may easily cause
> confusion in the sense that it may be used for metadata extents.
> 
> So rename it to btrfs_is_data_extent_shared(), which will also make it
> less confusing after the next change that adds a backref lookup cache for
> the b+tree nodes that lead to the leaf that contains the file extent item
> that points to the target data extent.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
