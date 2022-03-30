Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01A84EC6AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346952AbiC3OjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346954AbiC3OjS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 10:39:18 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF4424B9
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 07:37:32 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 125so24974019iov.10
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p1LjEXlqSlyorFbt9Hj6fJ3D33ukmQymP4McTXiwuvI=;
        b=iTrIn1cbRbAafOVWLJoaPGvGcG92oIQWuKAS8ld+7TzJMGrlIZGIecgHB0YJqawVqp
         BhvNXZPmWjZk8ScJ3H2NT2B3evZc2HHv+m2IoVTNGJs/uVQbfc4AFgCMhIWaCEag/LWw
         5Fd3pDUzbDFZl5mAPUU2O/d3E5AVwqUwOEL76KWtoaQL50kBR2PeTsU1iZ3w2z1gT6yZ
         MQu4DjmNSajgQAP4gBsofstkf/ZsLttPcbJLsAsd+BEMD8XdjnotqxQaTvPzCwmys+p1
         l9SW+wiU+BLQYIFrRuix4jLY5PvqHbzpkWyct18SBvYcHkTJS+mGI2Jozs9gvobywIvJ
         tBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p1LjEXlqSlyorFbt9Hj6fJ3D33ukmQymP4McTXiwuvI=;
        b=c9bvSrm7bSMWNNagwGsERV2bOaIIgHLmZBTaiikfljlJUHMx2o9s2ZUyxqKbJYYwg1
         Mst6ZAoAV3RLEvzmTIwKZR0X2XiRewSyYi83iF01MwZ1sWqSm99drfGUZGVTorJa8vgA
         uTzNKtpNVQ9r2XPeeyD8wEZiV25Mk39jbF4Sp/v/6oZoHsJP7O50Wnq4s9Gv5zMacUEW
         l0VCyYHm/iLtxr5aYBlqCtjkCROob9D7DhNndvN4eG282Y4j03jeABXT7R+oQ2P2Xka8
         zBbhJHKI+aa65bs0WC5Whvko9jykbZ+4kzSKAecktqNLrwmXW59+CCLq3vbsP68TB4KW
         Sodg==
X-Gm-Message-State: AOAM530CPRwJpvfmTlCSxWWTJnvj/wlcr59HhXv7Z8+TINaER2zOzsEp
        u3fpJyNjAbyG05ZCo0v3mEUk9A/QhzraETea
X-Google-Smtp-Source: ABdhPJxWZjyhMiWtwRr2IJsCj1tDCDDyu4dISaBGduLCOvlTo7fi3P8RUag3/yt+zUT6N1KJCo0sFA==
X-Received: by 2002:a5d:9a0a:0:b0:648:c8a4:c86 with SMTP id s10-20020a5d9a0a000000b00648c8a40c86mr11682274iol.168.1648651052133;
        Wed, 30 Mar 2022 07:37:32 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k11-20020a926f0b000000b002c2756f7e90sm10089799ilc.17.2022.03.30.07.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 07:37:31 -0700 (PDT)
Message-ID: <97a03884-9dcf-b1b3-a97c-506cec2f6d27@kernel.dk>
Date:   Wed, 30 Mar 2022 08:37:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: cleanup bio_kmalloc v2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
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
References: <20220308061551.737853-1-hch@lst.de>
 <20220330142941.GA3479@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220330142941.GA3479@lst.de>
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

On 3/30/22 8:29 AM, Christoph Hellwig wrote:
> I just noticed this didn't make it into the 5.18 queue.  Which is a
> bit sad as it leaves us with a rather inconsistent bio API in 5.18.

Let me take a look, we might still be able to make it...

-- 
Jens Axboe

