Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7027138C86C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbhEUNke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbhEUNkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 09:40:18 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6DC061343
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:38:55 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k127so19691695qkc.6
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hRlaO3TpA6MgQQxiZ29GYNitf5BSMuMdDsUNQIX9PvY=;
        b=yGi0n3YJY/c3yYMHGhpZBVzT6ELqo10pnLdKVy6nwT7jYxb24iOGWw0QgyddbWvTkq
         mFN2KylsPuJW+bJLoURrS/KTwOgjdz05Y6nm3gy3xKpok+8AaKsaQF1ZsDNiCv1XThbO
         CTrl7FYMyJJG9YCcROV0CtUvFYClroc5bFjQxHMFchC0PCF4s3T9z9HZVqkPBn+xXH1p
         l58a5T4b7zj89FEchwQKozxS7JHOYZCprrCrV/rg4CIwEV7eGItZ8NaUBbJbZWCKp6Nt
         RDyyk2cYHlVJaHfcdp1E2NgKkB8qbtbG5XBTIlftgQOt/pUgtN4N5s7xyT5HJdlXjD9R
         /phQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hRlaO3TpA6MgQQxiZ29GYNitf5BSMuMdDsUNQIX9PvY=;
        b=WOtrhlY8JWU5DOca0SSoDBkVxl2Brqj8w0AAMd+k91AYyxXYJSPlDMLqj8Ra63PoZK
         2uyKobeySMohPiIjPOZnhPqVp/hJ5cQ56Wl4dtQwuPppXE/KAtWA+BuMyp5efnGFOE1/
         c/VMMqUo4iKwQ1F7pMhGt3iQpteo+2VyOBcCWpvVr77o3AIZIbpHkpg9PA86vPadtgFf
         gWIYdsFFG9SbjOp73b4/lxCA2TKTq55lYBE5jeOCYFHs9lB9Ig9vvSpTp53WKWPQz4hl
         YOjy+EdwD/lEuffcXb/JYzsg5HLYTqUvmTiRTU4GtlR5uZVoJzdJO/t5Sv2HzJNQ2b2b
         5Jjw==
X-Gm-Message-State: AOAM533CKmX6vU62IerPL4eoflTrN5s+BWr9Xj1S3VILeo720E2jCtNh
        byuqLBx2YEZtXVyopV0NuaSyrDNi5qmJfA==
X-Google-Smtp-Source: ABdhPJw98b76rSsrEHRmjPQa9+pehn6hv4jRTrWfFD5SdG2F0mmvBLe3Qo8hTQaGCiq8QiA5r2AQiQ==
X-Received: by 2002:a05:620a:1446:: with SMTP id i6mr11985756qkl.353.1621604333955;
        Fri, 21 May 2021 06:38:53 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::114c? ([2620:10d:c091:480::1:e74])
        by smtp.gmail.com with ESMTPSA id s190sm4915603qkc.40.2021.05.21.06.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 06:38:53 -0700 (PDT)
Subject: Re: [PATCH 6/6] btrfs: add device delete cancel
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <8759a75926d1a48c6092b2055348e35129cafd51.1621526221.git.dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <06e8fd6e-fb18-7085-6cd0-0c4c8ad3dc32@toxicpanda.com>
Date:   Fri, 21 May 2021 09:38:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <8759a75926d1a48c6092b2055348e35129cafd51.1621526221.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/21/21 8:06 AM, David Sterba wrote:
> Accept device name "cancel" as a request to cancel running device
> deletion operation. The string is literal, in case there's a real device
> named "cancel", pass it as full absolute path or as "./cancel"
> 
> This works for v1 and v2 ioctls when the device is specified by name.
> Moving chunks from the device uses relocation, use the conditional
> exclusive operation start and cancelation helpers
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
