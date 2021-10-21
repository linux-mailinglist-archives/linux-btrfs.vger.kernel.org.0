Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD4D436871
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhJUQ5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhJUQ5s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:57:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0190C0613B9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 09:55:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 75so873464pga.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/0PkGRxE57fE8CHs0pwZUdcJSyRd9ETomPZTtV+seTw=;
        b=qbOpSV8YLQ2hsNy8S1ArdCeiLHPpC50b8qR/qEO12flHAZn2iLPArvu+zCRswhtWuX
         pEMCfdq3iKpj/4WTDNplt/jLNAuu2XpJf+QPD9XBllfI96ShBjr4fMbHAauuDFmHHivS
         tWvppTNQiZhSbTyej25bQsZxzLpIODbeUaC5UlaJ8PXjXK3s0W+6p4dNhJ9Cp2zSzkH/
         plR82Fu37jaiA3FNZgGgV3XJMoDRuNwdOACWFgSaxbytC+feLZk1YchcNoioryWhUfhn
         cRvNxn4o+fvXIFiMTcziOYxXsqKa+dwynJCYx/jOpGkunElaU+oCMtjs1g1IbV1AdArR
         wO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/0PkGRxE57fE8CHs0pwZUdcJSyRd9ETomPZTtV+seTw=;
        b=7yvyfR7SdRtbsPw/ArkR3Q8O5ve4zj90A8K6Zm2a4NMB7ODPbQrbcCF8x54zRmYGjH
         S2fZLgFiZkxUf4UuUKnmqsOiUhKwj3FoneTUCiz1IMzzKwX2CpZtsyedA6lipF9oa3Px
         TFjfoKK2QbcUPe97A9i1ikiSSMalEubYO2li5bE+ky/lYBOi18xiZuXcWstiX2arrQC+
         A5spZtVSFYKxCM6gK4Fq58XTIOGCiGZkVT4OXgfbaYMG8N476ki1AuzXe7AYVJPl3T2P
         0LnKH7B4nnTlH8KDgKXbc8vxm+5uRCUJyJefuJLLIJKErSZPZO8rz0mEH+M4ZU4E6uie
         RWxg==
X-Gm-Message-State: AOAM531HY4r2nab1xTcui83bc6usHTXOlRcIQAPytsZufbcVaKLmb+JQ
        vbHX6BJhrcF3eM2K0DUADylbzm40fhvRtA==
X-Google-Smtp-Source: ABdhPJzod7frT3cuGjI+bW5s69km4LVGBiqwd/jc2drYS/DAJNjY6K9ZkAEwHAarCMPU+xJO6vZ8pw==
X-Received: by 2002:a63:7506:: with SMTP id q6mr5286358pgc.349.1634835330198;
        Thu, 21 Oct 2021 09:55:30 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::381])
        by smtp.gmail.com with ESMTPSA id i20sm6271291pgn.83.2021.10.21.09.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:55:29 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:55:28 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 04/14] btrfs: add ram_bytes and offset to
 btrfs_ordered_extent
Message-ID: <YXGbgBcd4KTUw1Jn@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <9169c58574fa559e6633cca7e60fe32cd161003a.1630514529.git.osandov@fb.com>
 <66c2c57b-5f67-f05f-5660-b60b649b2f4d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66c2c57b-5f67-f05f-5660-b60b649b2f4d@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 03:44:52PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:00, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Currently, we only create ordered extents when ram_bytes == num_bytes
> > and offset == 0. However, RWF_ENCODED writes may create extents which
> 
> Change RWF_ENCODED to simply encoded as we no longer rely on RWF flags,
> same thing for the changelog in the next patch.

Oops, I checked the diff for stray references to RWF_ENCODED but I
forgot to check the commit messages. Thanks, I'll fix it.
