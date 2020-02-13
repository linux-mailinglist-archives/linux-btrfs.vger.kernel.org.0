Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4932D15C835
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 17:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBMQ2C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 11:28:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34152 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgBMQ2B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 11:28:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id c20so6259960qkm.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rzSjLwScU3C0NfLuecC9tfePijAPGMVcmjqq68FTKTg=;
        b=PyekYUld5wcs4QcXnfetLPQNI7ojLkz5bmlbEHoQpAfGDE0BrIqnbBNyexN9So6zjJ
         T3wGW7piRcT3qbNcov2Ebygh1GYsEWpBlNsIrRxIBtrV/dYBLkV6x0P2v1axfrwaPmAK
         m2/D3xFFJcmBSQMKL8cqX4Wa/R8ZHWZWmxQDgJzxBpkT9R2imb/pd7PNj6nW0tIMf+Ld
         YeSPSQaYhbzDDUNOIzh0hG0429Y9N+OoqToBdXTXKFCLIFg5liTgdwlBDEGek0ubTQR/
         ldyRvLLCd43OyYWgxPEKaPE+AmrH5Nys+i8co8ojKTV0h2pLC1qqbOiRxxzw8aoIdheZ
         9xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rzSjLwScU3C0NfLuecC9tfePijAPGMVcmjqq68FTKTg=;
        b=j2j0IxFlRARW6M+EliSzHmf1JPTuzg4vIkzxqieHHL+++FtYQwcxCkdmGeniQKToAS
         DUlJdi2b6T22RZojqv4t/MVja3r81VH5dGSedx/uQnpc4EmZpwf5MHIIzumVSoNHK0Qh
         WpZKtX4G+A8oj3a3PFWvnHoQNvU8/PhpiGUQgtng7trfZgKHO4sJdwLnWvRPueFqSTz4
         RigOVysnNoxMOvIEFeuf9RIe2VPg22ohnrTpJ8UtQFoKRXFfP7APKygXw8GzEfkI1oUK
         ciTTBkcPzHbid75QHWL0PGDqWWDoYL14FWZm626Vml+D3tdEeewUlpa2RXNkaHPnCjFA
         RC3A==
X-Gm-Message-State: APjAAAU0Vvunjh6He1j57fwtmzuQo9gIxT4abpLEnR1vnCRcQfcwCfLr
        +4dss5REUnXXLp0+VbRFx8mJUg==
X-Google-Smtp-Source: APXvYqysNcRyJQkCepzB17Bhn4T8+paNKZwum3UsR+NEbj367KSpL7oU2QpNJwlkOx41cp3zwNL3Gg==
X-Received: by 2002:a37:7bc7:: with SMTP id w190mr16314505qkc.193.1581611280826;
        Thu, 13 Feb 2020 08:28:00 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::edcc])
        by smtp.gmail.com with ESMTPSA id c25sm1557670qkc.12.2020.02.13.08.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 08:27:59 -0800 (PST)
Subject: Re: [PATCH v2 10/21] btrfs: parameterize dev_extent_min
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-11-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a987d02b-e9ee-7e76-29b2-d9851fe4f479@toxicpanda.com>
Date:   Thu, 13 Feb 2020 11:27:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-11-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Currently, we ignore a device whose available space is less than
> "BTRFS_STRIPE_LEN * dev_stripes". This is a lower limit for current
> allocation policy (to maximize the number of stripes). This commit
> parameterizes dev_extent_min, so that other policies can set their own
> lower limitation to ignore a device with an insufficient space.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
