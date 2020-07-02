Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376B8212476
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgGBNVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGBNVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:21:51 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F4C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:21:51 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h18so12614727qvl.3
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w+YqHRU/KCcgCqmTLtsOJ54KbSwyQmgK2Xrzqcat44w=;
        b=1MGqXylCA0cEtomav9Pg7Ho4k8LTLrQa6sL52UkooqTeLxShWvhMGFTdrjpOGX3Jai
         5nvL7HO/8QG+oI5DY27nmzxH2/deuD7agEZuWOB0oloDE833nCxql3fBGPrDpSD2my+e
         0qNik1OsDEpXPrUmPcjsBrEVWothh4+hUuHNrz4rpnfXQWpx21z3c9rpDW4uMbUcWaaB
         shJlWzkHMHsbA/2gITMQR1i5zkAqA6mB96qfbx0As7NU8yvuLRWz1im6SEtgFFx4xAlq
         D0U6Tq2Ub28gQO+AafDEQB8DXlKByHBT3Vh3mYgAdfvjfJjS4wTBwEuRAu11NcDhhx/e
         FaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w+YqHRU/KCcgCqmTLtsOJ54KbSwyQmgK2Xrzqcat44w=;
        b=Fn/8r/UDwPLlsVzpF+Fde431LVnpQFRdlmEq559Fu1XfM1o4ZYf7cGk3yF5EkujJkM
         OIk0/zkv5y2X1CLyAB82+Hadvz5asq3bc2nLsXsCv6p66dmEU4wltJ8kFmX+mH5KmYl5
         rEYgvmdKd2t+R7KT4JdnQunP13cXwWFXyUujQBQ7/KHxIjnK4aW6AM8H15Sh7TXo/CZ8
         5nf+A7QtMtUFxU+5+cM7heMdE4GlKRM5ba5fibWFH5yKi9rPdYLuU6oBJ4UvpfV0/9EI
         yiOer3WC/ZVYYF3HZ/mk59+Sb4MjIhWN/vxVjLNim5AnZWo2LixFJhMy3TplNXlIqv4t
         erMg==
X-Gm-Message-State: AOAM533kIslAYl6zUc57e/fGSXMV4OGiTEgfgsaru45Zy6dPgaF9WiCN
        zqwuO2l8+GPFfuHkHh42KTdiGAvIvQqr/A==
X-Google-Smtp-Source: ABdhPJxoDSCz6EiCuWvPemNL8gAS7bd5nITbdchztch3tM4b7ktR5tXH67CP1WddFP0ptpxv10YgOQ==
X-Received: by 2002:a0c:b40e:: with SMTP id u14mr22795484qve.237.1593696110020;
        Thu, 02 Jul 2020 06:21:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e129sm8338439qkf.132.2020.07.02.06.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:21:49 -0700 (PDT)
Subject: Re: [PATCH 7/8] btrfs: Increment corrupt device counter during
 compressed read
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-8-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f9d91d8b-927d-e952-af9b-1bd604f2b28a@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:21:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702122335.9117-8-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 8:23 AM, Nikolay Borisov wrote:
> If a compressed read fails due to csum error only a line is printed to
> dmesg, device corrupt counter is not modified.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
