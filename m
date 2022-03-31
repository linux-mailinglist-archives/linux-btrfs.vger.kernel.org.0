Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64DB4EDF1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiCaQup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 12:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbiCaQun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 12:50:43 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44655882A
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 09:48:53 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z7so195278iom.1
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GVS+7ByfaDfRQ3cP7Su5v65xswUHpTm7s1D0XKCLUIc=;
        b=5UHAlnNn6pmh13gHK2pkVOqqU+NLxHAIm10n7hxY69fkf4etI7xGcoRjiBvGoyxJNr
         kabCkIf1xxwY5lv3Fz+S1YPx7xckQPP2QGAxBmU/6XuRjvC3V9So7gmo5sdkO4isG+7U
         NYY0uWHbGE6Q/h3sInup3pNJi9R9t2lf1mAnVfMWjXyxKmAnrTRpm6i8FD+xdnRD9+kO
         TZ43pQfEjcjGk7vvTk+toj73TV/PjBpXagt13go4gLwi84xpTxTtB2xWYo91klXaZtPT
         YIuOfPzysEz9Z8i6engCc1D604prelmrGVhbWJ968cwBOEX4MnOYuo44vJBZyXv5Y/b+
         Wf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GVS+7ByfaDfRQ3cP7Su5v65xswUHpTm7s1D0XKCLUIc=;
        b=VfRB0vGmNrkmWRvgFPFRf5nxZDLagkDPKNBnQsBPnL/pYHmHR1SI8ZkBQWvIY3hFRY
         y/rwkkGKkCPW8rmelsHM6fQBoCxGBvYbPB/viEwgbNdJ1i4s+aK5uC1On0nRH3rjujyP
         APrajpfSJn5ZYR8N7SnmeExoJ/IszgcU76JSfwF87uYxmd37yKnNxgxMxRWONmj2HBqW
         YxJUFF1hQugc1jYhw66caRm8EdPY5u+PqalqL7aSGP/AvutB5sozLbqEtbH3kZ284fhJ
         dbMbPgQBDkuAPpS9Fldx+DvbozsxUZWzHJuPT+OeDe4BV8CJNBT16HYZz73gbbYoU3le
         RYvQ==
X-Gm-Message-State: AOAM532CrsYD1TMbGkaqFv0zYQx5BIpv6/X64qUW7OsxPpQtFABHbNo+
        JwGTOxtO04Drea2q5C3xJAp+KEy8l2m24uAB
X-Google-Smtp-Source: ABdhPJxO6cxAuydd+MYxjFrmEZWnATNnBLDhK+n22mh4Hzt3rKwlZEwEzWA3wPZWmZM8hKaYOdK5ag==
X-Received: by 2002:a02:c017:0:b0:323:6b24:5bde with SMTP id y23-20020a02c017000000b003236b245bdemr3323956jai.185.1648745331810;
        Thu, 31 Mar 2022 09:48:51 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j4-20020a056e02218400b002c82f195e80sm12730706ila.83.2022.03.31.09.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 09:48:51 -0700 (PDT)
Message-ID: <572bf891-8b2b-b32e-af64-d80fb7f5963f@kernel.dk>
Date:   Thu, 31 Mar 2022 10:48:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: cleanup bio_kmalloc v2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qian Cai <quic_qiancai@quicinc.com>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220308061551.737853-1-hch@lst.de> <YkXYMGGbk/ZTbGaA@qian>
 <20220331164024.GA30404@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220331164024.GA30404@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/31/22 10:40 AM, Christoph Hellwig wrote:
> This should fix it:

Let's drop this one for 5.18, it's also causing a few conflicts and
would probably be more suited for 5.19 at this point.

-- 
Jens Axboe

