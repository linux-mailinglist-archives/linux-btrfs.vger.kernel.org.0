Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7306D145CD9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgAVUGD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:06:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46416 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUGD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:06:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so555735qtr.13
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1e6UBpaNMUqvCQt2waPvc/87qyJk5LqJ6q4QliFQ7go=;
        b=EEqSzBbZb752crprK1lywERb9s+0BFlqPmI9rR8ENsQ7COkEvO2QOJ5M3aaJXDfYNS
         kRSx3e7wkQQ0+WLauO3FFrSxEqEh1qFbOTFvFO310I8DnuDGoOcKvDGTeEHQcDHJYRZZ
         ls+q0jPLBjHxI6/Wdzfl4LBmBdrcSIMD+SqT5hQdbA8G5qyXVpsZqTmFANJZhl5fq3+w
         bsiyftiZg3TOBx0G7zwtN+uvgAsuIsHrHcCtYXGWjQlL3le1NM1J62qkLFhQWUnzlbAg
         babihTxjrGQuC/AkNn9Blp7hEWRvG3d46mqZaybx2MbXqbig0q/QnQYM5/xZeZCHq6Tr
         gcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1e6UBpaNMUqvCQt2waPvc/87qyJk5LqJ6q4QliFQ7go=;
        b=VQwg3y6YqFyP5KjAAod0QU+6sJWkr1GMAxUZ2QZQTeO4+/xAm9sQGQNc6YnZCfdDJO
         iKoe7FkI4gv9TwM4prbNed6n8UIZmOR8nszsq3MCMJWl5AlqBGHHo1aMlPgqvRpinf3Q
         vqGL9M/yXbrk6MSDy2CF2voc2q3qGunqQGfaFYP3PLbSrxMoVg9USL2uxL5hWSDUYM7c
         chuQkvYODSJfLcMRxmdYoMS3Fqq1bZvqsMlHkRSMnox7UeG1kmsQTPYUn0ocFQz4rQgr
         ADKIGMOBw2O2jupqpoIHSHSNQr4cMx0/Wyei+px2shZ1DBeXs6RylzXsCwDDmIlBe4gq
         U8nQ==
X-Gm-Message-State: APjAAAUnf27RM7AAGz1jPgwdbrtEBsh1NhyT9ffmWGtL81ZVrTvOBBmo
        z1/qrFVv/nVMCAuc7Qp5F6Hrv7OfxJiy/g==
X-Google-Smtp-Source: APXvYqzOkhqgmkh6rd8Uc6Iq+T0nH51uDd3yr1ZZGI5N3wmXNKyarVYeQCelR6RRtAWmFu+f9wqVVA==
X-Received: by 2002:ac8:5513:: with SMTP id j19mr12522012qtq.143.1579723561629;
        Wed, 22 Jan 2020 12:06:01 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id w1sm21941098qtk.31.2020.01.22.12.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:06:00 -0800 (PST)
Subject: Re: [PATCH 05/11] btrfs: Make btrfs_pin_reserved_extent take
 transaction
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-6-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <863312ce-e85d-977a-a955-efe965f8d4cf@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:06:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-6-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> btrfs_pin_reserved_extent is now only called with a valid transaction so
> exploit the fact to take a transaction. This is preparation for tracking
> pinned extents on a per-transaction basis.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
