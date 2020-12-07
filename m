Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC6D2D1676
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgLGQhG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 11:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGQhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 11:37:06 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BF8C061749
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 08:36:25 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so9817247qtp.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 08:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CTjZ8dE2k5crFaQt3/sG5vMR1Jb4//r+r9eAPESAD8c=;
        b=n1bvWZUJAZjbc5dxs6ktfVBCpgQyL+pT9pThn769U2ebHl8VwPYrrllruW04iky1xp
         scz4fItn5z/j94x6YQIlDDVSioRlFttgl4jjeC37zNzDlNXo1jVgdasmzeHAxG+X/7Jz
         1hvXSNkX1r/OobvAZ+e3p2DVy36750MKhItj3gw/zEhmlaRtTcUqsVAyuf2l5DYDQgdz
         ZGMkEXtJxBZXWGjoD4tDtuLs0NHJmwz2HhOj7YXGq4j8BT9mjbHpXpI/osU2+MBg1I3I
         NTgK0l2NN4IVU80m2d9TMBeKeOKv5aFfc0E1+eYSPeorwmwkGfcqJmeBLpDbrC0KC7AJ
         ujpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CTjZ8dE2k5crFaQt3/sG5vMR1Jb4//r+r9eAPESAD8c=;
        b=GIbTcuNztWmnJTYJxXYDbYwCMr0L2JQlkPB87ee98jicmJykeA3Nh+ZoZVae/waHOK
         ckzq5BVh8006QCaYY4cgwFyb+2IqOSHWkGdCCmGw45A5tdmF344UIl3BPLkWBUuNC4YL
         SFqRMJxdoftY0kHTPCPPlddBWESnSK5TjcjhDiFSbQIdhxbMG+2Ylm9pmBzgTXlh5oFY
         HO1hIflyg3JXYGYMJQIybPW6HOww3ZvD130ruEggnlPYYPWA/CyaRQY+tkjydQmZEugH
         IzenDmcqxNmP5qZwfzXWBoGD/kDPH73jjwHa4bM9xje8+U+eztBWvqzWAlLrz2AqOCZ/
         YSig==
X-Gm-Message-State: AOAM531G1eUFr4wWcaJUPrUayPxkoddN/v76TLyOb9y7CD4P77JZiXGE
        cVFyRJXKYyXwdblz7z2xpVLp16TWLAckONB8
X-Google-Smtp-Source: ABdhPJwYr4CkuXcA+b3JBL9lvrPalA5tRN/s/SQLc8GuNjbGggE9Lbo413HzCHxG1NwxsjH2fXNTpg==
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr24593514qtw.213.1607358985003;
        Mon, 07 Dec 2020 08:36:25 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b19sm2209575qtr.39.2020.12.07.08.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 08:36:24 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: Update btrfs/215
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20201207092318.950548-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1c23bd14-3c30-603f-0014-a1aeeb8ef8ab@toxicpanda.com>
Date:   Mon, 7 Dec 2020 11:36:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207092318.950548-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/7/20 4:23 AM, Nikolay Borisov wrote:
> This patch updates btrfs/215 to work with latest upstream kernel. That's
> required since commit 324bcf54c449 ("mm: use limited read-ahead to satisfy read")
> changed readahead logic to always issue a read even if the RA pages are
> set to 0. This results in 1 extra io being issued so the counts in the
> test should be incremented by 1. Also use the opportunity to update the
> commit reference since it's been merged in the upstream kernel.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> V2:
>   * Updated comment above buffered read issue command to better describe why 2
>   failures are expected.

Do we want to just test for non-zero, since the original problem was that we 
weren't getting any error stats at all?  Then we don't have to worry about new 
edge cases in the future.  Thanks,

Josef
