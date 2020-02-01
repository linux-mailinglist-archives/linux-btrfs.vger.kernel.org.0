Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA41014F73A
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 09:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgBAIHD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 03:07:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35013 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgBAIHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Feb 2020 03:07:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so4869730pgk.2;
        Sat, 01 Feb 2020 00:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p+MkS8qmtCp5lCzM4df73oUtXz54HHkncllF5fin82c=;
        b=cYdgtnOLhwjDJNOtArjYzya5aAK+vpJJ6Vv/joY6PolzO9GO4qN95ak2lOcmAmskQ5
         whVPZyERcwkrbszqF0rB/G0833UXmgRHy0mWyW3Z78OLT4XyWG764H/pBbJkY9QIa/cd
         LgZZIHqFZxhhUYwPcVWKgVaRJTzQi5KAofTTDGTXZv3iLn5kwnxHLmmmyZYPXmAjC/iQ
         WDdVVBC766Da0hofE62HtFU041oYEWbl6rjhvO2zujePQj380EePHeVUcZapOylPrSkB
         ONapTkayFUKH4gK3brPQqfPHXBUUPdqlIdjRHkLXy65sJ5cgSVIfbkS2qDnod2rOIAZ2
         rgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p+MkS8qmtCp5lCzM4df73oUtXz54HHkncllF5fin82c=;
        b=JQfnB13DAFrZouk+DADuTgzrBMHQT0KBnH/dfRdq4vxD38EM90fN+znHZNvcZCMUjS
         uINEuOU/6R/hE+sIU58UoGiIXGJ1wZLHTL/zP7Zhemi2FDnbz6Ri+zqlIsg3YUu1/FAz
         mjtsXcMqnhtIj8dKNZexZZdp8QBj9wQ7EnijNhB5Ar+YNEafxjWQLcjfW1d6GvrsM9jX
         kDVahqPrfWYZeQIYF9dwAprl+6l/x/ocPkmNwWbcT6HTxoOIZMzZgPGeQr2laJuSHSVQ
         JMRT/156mtNcEzRwDIKuzpoln1hh6zkR3XjzdilFl4NncZIuzEDF3OAvFuRBB36olOsH
         DeKg==
X-Gm-Message-State: APjAAAUxtJS5xOxlvbhWTYzuP3xTN1+xuQWlrUDclKOI0NlPIZ11ONwT
        aPtjocR5OkB48syuzlyf0FE=
X-Google-Smtp-Source: APXvYqwPaws5cgWJ02UKuaq1syobxAeTJNDz/PKi95coGEriaemWGg5FvL6HBw6cwSLAGl0eZRjBaQ==
X-Received: by 2002:a63:2ac2:: with SMTP id q185mr14650373pgq.417.1580544412395;
        Sat, 01 Feb 2020 00:06:52 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id 3sm13498775pjg.27.2020.02.01.00.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 00:06:51 -0800 (PST)
Date:   Sat, 1 Feb 2020 16:06:47 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] generic/521: add close+open operations to the fsx run
Message-ID: <20200201080644.GC2697@desktop>
References: <20200107165542.70108-1-josef@toxicpanda.com>
 <20200107165542.70108-4-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107165542.70108-4-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 07, 2020 at 11:55:42AM -0500, Josef Bacik wrote:
> I was fixing a issue with i_size setting in btrfs and generic/521 was
> what I used to reproduce the problem.  However I needed the close+open
> operation to trigger the issue.  This is a soak test, so add this
> option to increase the coverage of this test.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/generic/521 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/521 b/tests/generic/521
> index e8bc36e4..f0fc575e 100755
> --- a/tests/generic/521
> +++ b/tests/generic/521
> @@ -52,6 +52,7 @@ fsx_args+=(-r $min_dio_sz)
>  fsx_args+=(-t $min_dio_sz)
>  fsx_args+=(-w $min_dio_sz)
>  fsx_args+=(-Z)
> +fsx_args+=(-c 10)

This looks fine to me, but my only concern is that this floods dmesg
because every drop cache records a dmesg info, and the useful part of
dmesg may be lost. How about "-c 10000"? As the default op number is 1
million, with "-c 10000" we only have 100 dmesg entries. But I'm not
sure if that's enough for you to reproduce the bug.

Thanks,
Eryu

>  
>  run_fsx "${fsx_args[@]}" | sed -e '/^fsx.*/d'
>  
> -- 
> 2.23.0
> 
