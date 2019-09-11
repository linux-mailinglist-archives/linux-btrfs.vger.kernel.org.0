Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01454B00F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfIKQId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:08:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34541 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfIKQId (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:08:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id j1so13176872qth.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5x6DtWvfCAAUR9ngdG5r1rPtr97cFp86HrePkYOTWNY=;
        b=qH1Va873+oVZgHwgLXR2terD3Q4oHkdWBPguGr5jPKrVE7URBEYU0qu9ukTtB3B9oE
         YxxznkgHtOf8ZbQ7F2nkMu42znIN0K19EOwsd8ktAGZByHpTssvlTi3iyrm+S+n1F1vh
         i0+jzg8dkSYgudxnqDtr9hu/aE1HtV/Oqdie9LdsiIQ+rLzdw98vzGm7579dLlwVfhV2
         giOADRoiDsVfsMINYXic32bzFnVKC0IoqUN40nA/Aw/Te+tCLgtn/SrhiXIK+88bZ3yw
         YBnXOY06aswsktzMn7NOy7taG8MgHNIr4wxptf60uTWCjZrIEmOhDYT+qVlcqRG/EbiZ
         mdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5x6DtWvfCAAUR9ngdG5r1rPtr97cFp86HrePkYOTWNY=;
        b=o23k/gkSWWKxQnkSkdLbU8tbg90tuFjdd2PlupHD4FY4ELslL/KWhsf7Cn/erI0KV5
         Jn2GZ8vhkyimjsjU1TdwSu1+qnxu8LWuPo0hfNWGTzrI2/7pnmZyYeTjxEfV5kQqZPu/
         qsQP8a6424Dr0ZDLMv3s629+K3QM7n8YQKtlGlLmIwBZXmalkzX5zM2lIo5zgCmn9yEO
         Psiu3JB05uvR9Do6U69a2IXb0TYLmF5NaUACSOqatqqZlVXzB70iOLqTb/uU9sKER0u8
         Yh/lwDTeI5GXSIPKII9kfomHCAinXcOtJ3fAd5IhJBBMgVDGqiQygbI37ExmJCdmttuF
         Yrkw==
X-Gm-Message-State: APjAAAWzpdgEjxQXb+dzpjEV3XrBvliVOfbvXlqHxdQ6UMn/b2ESU1Z0
        oPt6gzAndnTPHDyi49C0Q2i8lw==
X-Google-Smtp-Source: APXvYqzAfvOx+XuzK7jcoWzvCUl4tNCvAL71KP6ETAr/9PqzIvPlHoGzudl5gxk6HySHPt22ruslsw==
X-Received: by 2002:ac8:3f79:: with SMTP id w54mr22025805qtk.324.1568218111334;
        Wed, 11 Sep 2019 09:08:31 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j4sm11113225qkf.116.2019.09.11.09.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:08:30 -0700 (PDT)
Date:   Wed, 11 Sep 2019 12:08:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mark Fasheh <mfasheh@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Mark Fasheh <mfasheh@suse.de>
Subject: Re: [PATCH 1/3] btrfs: Move backref cache code out of relocation.c
Message-ID: <20190911160828.jty2d72vplde2ivf@MacBook-Pro-91.local>
References: <20190906171533.618-1-mfasheh@suse.com>
 <20190906171533.618-2-mfasheh@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906171533.618-2-mfasheh@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 06, 2019 at 10:15:31AM -0700, Mark Fasheh wrote:
> From: Mark Fasheh <mfasheh@suse.de>
> 
> No functional changes are made here, we simply move the backref cache out of
> relocation.c and into it's own file, backref-cache.c.  We also add the
> headers relocation.h and backref-cache.h.
> 
> Signed-off-by: Mark Fasheh <mfasheh@suse.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
