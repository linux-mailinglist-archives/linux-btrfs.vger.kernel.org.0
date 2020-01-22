Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14209145CDD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgAVUHv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:07:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37454 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUHu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:07:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so611544qtk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oWEfSt+cxAc4/eL1RjGjo8qx1BunYEQPGpwosztAK4Y=;
        b=zJlJhhzZpMRi6RYNonZa6OmtlcvGcKrp3eYt9c9+8DSFo5QUVfyeOFcOKsuo2Bfobf
         9UQu0S3UWxl3BekH8hQEd4zNIRKmGlqefv5gppRjFt89sij6FKmtYaF88/YLqBbcJy4q
         c8L/8vuf3TnvbCnP1dtA0/hD3MCuLw5+CaFk/uRYfCcxEZnBFBgmRWpITkGm6upfZNxj
         pioEzZs2BwSY6Q3OAwJId0FH2pRsL4kKoN820I/GJNk7pKd1ijbAVZEB6sKDt0ExaS/b
         18Dni7gZzQFap9MD8j/AcCN6Q4GEkqa9Y5omCiqDcjh6agRedBruvOZN1ASZewymJBvL
         IGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oWEfSt+cxAc4/eL1RjGjo8qx1BunYEQPGpwosztAK4Y=;
        b=qwr+jToyd6eNYZDMwOthKogYX+6t4T4skQd0DpxnKrN5260sXqvEtgDEcqCkITK1ct
         7yGDjeEOzzGwtRqBVIMXXllwggA9Uk6kABW/UUkyeIdNiYmBz2cuKuQrhGtAroK5Q+xw
         oaLoPTpaAdfhUfOdnlTlhTIZE893MYIh44f+WacripKiuH2S1YwBrWSypaqmgM6ta2nD
         vmwGNoFbZ1XjdFvToRjBbRri5JbW8gviN3D5cdeZ3iZfrxGATGDduk6NSwNCK9h2hPca
         iF81AJCLKidWLLk8yjUqu/2F9B41h+AUsRwUhJh8J+2xmm6NwkQO6PKUfdOKPiO5QF0A
         MC8g==
X-Gm-Message-State: APjAAAX2XlIhYWKBr/Tz4bWGFtGzyXvZLYZuFkV8qdRr6FlBL8PotJMi
        ShCf9/2sQRwIizZOS6Y6dAQbhmFyqNGPqA==
X-Google-Smtp-Source: APXvYqyZVYuA9PwoNydkSDr7ZSaYGSjt8YOQvQgSdHUfC6ACNn2BZsCm0zhnWSR+hLo8HDz5EZtJyA==
X-Received: by 2002:aed:2d01:: with SMTP id h1mr12385753qtd.239.1579723668832;
        Wed, 22 Jan 2020 12:07:48 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id r185sm2583236qke.102.2020.01.22.12.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:07:48 -0800 (PST)
Subject: Re: [PATCH 08/11] btrfs: Pass trans handle to
 write_pinned_extent_entries
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-9-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b1ea29cc-51b6-cf11-afd6-751c0222bfe4@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:07:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-9-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> Preparation for refactoring pinned extents tracking.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
