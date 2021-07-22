Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150543D2C03
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhGVSAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGVSAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 14:00:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D8C061575;
        Thu, 22 Jul 2021 11:40:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j17-20020a17090aeb11b029017613554465so485731pjz.4;
        Thu, 22 Jul 2021 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rVJkWGxDq8DWhm+U0WR6h6oEyqSDEXCshwwQahUcOHI=;
        b=cEBQODyCO5dCtGf9TfpA2ErqefuW68Rwc0BwNbnNtCq+HPk7Am79nY5fzJLheIZJfN
         TBCt382peca15P6h+uSUE/SjnM/Z5ZauTuv/pBe/wdiuKQxR3wqvdOVLbig24TGatXdu
         numtq17sr27FxMjFUkcqDCDkVOmhiu4Po+qDUlgIh/bk7O3wwyj9QTAkKYJwZcIRRcaX
         NUMQajDYcqwOUQhSo/YucGYjDpCXcvLTBzM/mFzFg1Ph06oL0oO3PURcKYqR+Uj3s0W/
         0HeJ4HK3pTme0B5yB+pQ4MHQ4OEHFysthSQoHVfvVfCcPdUV1Cu+SjlalsobfGxtOJl9
         xvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rVJkWGxDq8DWhm+U0WR6h6oEyqSDEXCshwwQahUcOHI=;
        b=anlU8QOAvajCBRoLS2uqN9YyYcShbFAPyAiFvsWOdeixaA8em7+E3CSlZUumw2UAq1
         w+1MW+u8h6QoyBB/ZSgRbLNmnUBtg+JXDpOfC6nBTizUWDJMXv42obIyJtdpxq7PkgDl
         UEnp/rPFHhgKw9k15BFvo4IISbILzvAbJCVT5TKY0C65vx6VUBR+8Q41ymtK89DMHW1/
         TUGyo+9jroXbJSIEHJ6H66UYm311RCPDTSOt7TNk+tlD5TuMzDm8bqTj4XeqV56Xh816
         jMYL7JgJ011tb/11qX5v/daHkK2kopeknsKi9Skuw29Xbdr+uPw2RG+U578mtaVqnU31
         BwvQ==
X-Gm-Message-State: AOAM530V9luSulUVqik4TA6BhI8I9Qi/boQPfXDJJyWL6PIC3qCWXF1i
        qnGbxITbP103sKSmFBtnEFCaNn21rqmdHQ==
X-Google-Smtp-Source: ABdhPJxXedSJjaDttYr25/Tkc7hUZpr8hs4b+HQGdtNhuPJ+QKETSqur6vgtfs1vWTCxuDfdSI73rA==
X-Received: by 2002:aa7:818a:0:b029:309:a073:51cb with SMTP id g10-20020aa7818a0000b0290309a07351cbmr1141615pfi.40.1626979247192;
        Thu, 22 Jul 2021 11:40:47 -0700 (PDT)
Received: from [172.20.10.6] ([172.58.22.135])
        by smtp.gmail.com with ESMTPSA id y13sm33087310pgp.16.2021.07.22.11.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 11:40:47 -0700 (PDT)
Subject: Re: [PATCH 9/9] block: remove bdput
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210722075402.983367-1-hch@lst.de>
 <20210722075402.983367-10-hch@lst.de>
From:   Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Message-ID: <3c03b8ca-f763-bb94-4f39-8736516817dc@gmail.com>
Date:   Thu, 22 Jul 2021 11:40:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722075402.983367-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/22/2021 12:54 AM, Christoph Hellwig wrote:
> Now that we've stopped using inode references for anything meaninful
> in the block layer get rid of the helper to put it and just open code
> the call to iput on the block_device inode.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Josef Bacik<josef@toxicpanda.com>

Reviewed-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

-- 
-ck
