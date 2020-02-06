Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64B154858
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBFPpK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 10:45:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40789 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFPpK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 10:45:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id v25so4807714qto.7
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tnocuWwg2m0jQI/GHQnRpzXDXWVNi+JOd3A9J1HIwrU=;
        b=wy58cgh07rvIYEt1ICzQYC/fZsFLpu2Uvvq92TZMqzNxmZKbB5Vlk+dtsQOvmXOzjP
         TzSrZ3FNRh2WBNe1vN5MbDMiOozLYhkIe78QzzIEu+2xFaj/71yIoP9x/I20RRKNGm7+
         iforg/5RQyfhcuSYNAzEfUy4e7bqhda0LKTvtKADIdmeWoJgTDqHTMKW7pyudZ1qzw/3
         ZlIArd7DAiEPD03PHY9G1SqajzcBvvZZRRkZzzFlK281Af7qy9r2n7tqrvfaj+RcCRN1
         B9UqUZxl2dzqWXyHcMsKJTM7FtrVuG9CJ5Ubeb7I7Tv1Dvi4XQp4jRnHDoJSYMZo+ZE2
         SKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tnocuWwg2m0jQI/GHQnRpzXDXWVNi+JOd3A9J1HIwrU=;
        b=oRyb7OV2BHIbAbSBX28tUy+5wBM/wLjCv7vIQAj7YyNt4iksWZ7N9Ey7lTxe65r8LR
         WWnFVsvgYPJPtkZl+vJ7NCaZOY2d/WhAGPZbK+CgFM7fnTg6p+kTBNwuGKmXGIRKq3Og
         a5QGTAJM9XGKcIdiKpdNf/eA3yF0XWFsJk0nN35PLO/S3BhyX6J76oO+hD1jX6m7uhL3
         Z5D4TiP9p354URfn1ReY36yiDii2kqNaXlfG9WKZ5BuGPcU1HSjLiZSg5HroY6SzH2WI
         Krn6MUff2CMaIBCNL+nCuJiqbLu8L++VMseWwgRh5jgO7+hEMgpoYHZTsOaOYK68/eMY
         tNLA==
X-Gm-Message-State: APjAAAV/PE4iDrozo6RZq8T8gXRj2L7k8cl24NS2DicBqJLiz2fyTjdP
        dfi8T8CfoNAC4DmqBeoZq5TM8kUVHzQ=
X-Google-Smtp-Source: APXvYqzje/OwlYcR6q8QLiq/wFg7H9Edvhbja36iNn0zRMZ2b1bUmGPF3NZRofkCL6TBfN2cRDXgBw==
X-Received: by 2002:ac8:3676:: with SMTP id n51mr3150807qtb.208.1581003908357;
        Thu, 06 Feb 2020 07:45:08 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r1sm1806140qtu.83.2020.02.06.07.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 07:45:07 -0800 (PST)
Subject: Re: [PATCH] btrfs: add wrapper for transaction abort predicate
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200205163434.6367-1-dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <88648e59-f12a-3272-7bbd-8b08117f6b25@toxicpanda.com>
Date:   Thu, 6 Feb 2020 10:45:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205163434.6367-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/5/20 11:34 AM, David Sterba wrote:
> The status of aborted transaction can change between calls and it needs
> to be accessed by READ_ONCE. Add a helper that also wraps the unlikely
> hint.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
