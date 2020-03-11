Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7422618209E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 19:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgCKSTV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 14:19:21 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37099 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbgCKSTU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 14:19:20 -0400
Received: by mail-qv1-f67.google.com with SMTP id l17so1331355qvu.4
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bUfyRVSLtXnFSkI5GRnKRRhHX8ZOoT6WEeoMwZ+Njf8=;
        b=isFTPy/AXRScEg6Gt+IL5gnlW40Ua+HWTeKHf1OcpPhU+uUeoSIy8pZeNWoIs0tg37
         SRjKXffE7U8YnRdRz5Z6gRw10NdrGDjxr7GxIY+tdCGFdzSM6kWBDTqxBr1TuL6qCHKj
         IrzgDiC7Ngk8Xf2JsOoGRgW6RI2TN1TNizj0eETI9asWDCuhq1QmN56LSh//tu2SiP4u
         A+uAMDhUXpnT1bR118YBV0Ncx6TufxYlx8q2U6fX3k8+OwtZvjvRQS3NcH3Oe7+kiUZH
         ipCMa0UPQi/hcrwqwq7pnGI442bDI45tGcHOq2Re1oCoPwGvJRXffdrDpA9FO7/BdNjC
         pVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bUfyRVSLtXnFSkI5GRnKRRhHX8ZOoT6WEeoMwZ+Njf8=;
        b=pGbDwWk+B4aobZe+kZ4XwIkx0EVbL4juV37kTDlw2gz4or8vCmyNlAz/mp5ruGSWNn
         AdH2m1qmAWt0E5ro5jmn2YCNgRJ2P3TdAuUsXUfLfNcXtJWjRA1bLBsaJr1T1xMTjTv6
         4KxzqqFdf7Yw+u9O/9rgU7RZmyJ4p1f0hM04YS1mxZI6oLbJkB9HIKuRMJBHoAtA0amY
         vKWdSEGFbOPtAM5DRSAvFcy+E/11rDvgGKVJfOOfUfuNtLCMRFBT7U0HQXoigqiFznLs
         9+hHJL9lWtpNfuoF50n8m+YKRq67qoj5Bj8SgZT+rnDLTT2StUSLi34z699t8rjF952s
         sHgQ==
X-Gm-Message-State: ANhLgQ0fQPLbifEWsnD1RczPiVPsA856YDvM9ZeT30+Pu93muY+dn6wp
        0e3PoU3Lokf4CsyhlUYJnkKUwJMoroc=
X-Google-Smtp-Source: ADFU+vvJmuYATdz0JSBxgyNo0wKiAvGXaHI8g0VSwpvV6sta2ppjVn1813LUVR5Kt/gOHUyhZPHwJg==
X-Received: by 2002:a0c:fec3:: with SMTP id z3mr3867549qvs.111.1583950759750;
        Wed, 11 Mar 2020 11:19:19 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g15sm22304231qtq.71.2020.03.11.11.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:19:19 -0700 (PDT)
Subject: Re: [PATCH 15/15] btrfs: unify buffered and direct I/O read repair
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <7c593decda73deb58515d94e979db6a68527970b.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bdaae1b2-4256-a4fa-6260-3f996d74d6f5@toxicpanda.com>
Date:   Wed, 11 Mar 2020 14:19:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7c593decda73deb58515d94e979db6a68527970b.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Currently, direct I/O has its own versions of bio_readpage_error() and
> btrfs_check_repairable() (dio_read_error() and
> btrfs_check_dio_repairable(), respectively). The main difference is that
> the direct I/O version doesn't do read validation. The rework of direct
> I/O repair makes it possible to do validation, so we can get rid of
> btrfs_check_dio_repairable() and combine bio_readpage_error() and
> dio_read_error() into a new helper, btrfs_submit_read_repair().
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

