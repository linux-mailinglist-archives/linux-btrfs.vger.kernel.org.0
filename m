Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC15A1A61
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfH2Mq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 08:46:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37295 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2Mq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 08:46:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so3299727wrt.4
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YRTXsuxg4QFkrrKVLZ9Q+cwr6RlM0UhgaOaE8VhJHdk=;
        b=WCQLG+ldcQQgCCUCy49a+cpkR4JNzduJSF74OL9DthbBjYE0A0dN/BrdUc1iF5Ah6e
         PQeGjAmDrK6mQluZD8CfZCXhU2XkbDJRxbNWw5LWpkmb5INX5W2lWy0n6Ywy1ZMQyeBz
         lBSKcHPVyWbL+lpwdWPDaBHBH2zKx3oa1ROkmCJ+QIQOqHSATn5fpZKFTLzvUZ9Ft9MK
         O9QqMscx7s/BSa5AcIbOCId8VCBDhlq+m9YfHjiW/bXIGdwZVW4K+ONHLD1PweRnHN5r
         ntNG1PnHdC61s1vuxy6qmvfywOWSfSOoHbPw1PDusBAG5IlBe2a59HzCVFK9XZQPAqOT
         IElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YRTXsuxg4QFkrrKVLZ9Q+cwr6RlM0UhgaOaE8VhJHdk=;
        b=LupYD6sXb3GNqpF8A1DgiA5ENiui7048vHegGAV7Ht6yAwtQB7JxMTKXbUKrn8Mw6n
         3+AXKe2oPIWp1pj584d2xCSXQWugsDX7E1v6IYjzzTUi7DDZiN1siCCFHmuUiTdi89ff
         YY9tVqmxAHWVPJbsION7hmhkHYqrwnyOG1bSj8aKIeLG5rAfRtRl68It5d7heAmwrSpJ
         9jzcSV4gO3SVhGRPJTrNZ7GH4z1tjFC/+DV8y2vZd9nic+vvB2YTE6vg06q7mL2aBR1z
         hzTE4MIEOGf3VS0dFTMBQz/tmC5dHtSI5qgkTI0kgo7bszU1dbRibl9IAT3HCOnZM+aH
         Z1OQ==
X-Gm-Message-State: APjAAAWIix73/OK/tM80/l8OPrrkrfn9mhWY5rJLMsYokY0buTIt2Ssd
        rFXzsizNB07kTzloD65ZJNNhBUd0sbg=
X-Google-Smtp-Source: APXvYqxvWZmMNzY9thH5xYWRzZxAjzIOp3za/LBzoOX4cNk1mZEnHOEDbgf/gLdUIsz1H7LqH3nTvA==
X-Received: by 2002:adf:f90e:: with SMTP id b14mr10625744wrr.124.1567082785440;
        Thu, 29 Aug 2019 05:46:25 -0700 (PDT)
Received: from ?IPv6:2a01:5c0:e097:52b0:fd3f:afaf:148a:b588? ([2a01:5c0:e097:52b0:fd3f:afaf:148a:b588])
        by smtp.googlemail.com with ESMTPSA id e6sm2412952wrw.35.2019.08.29.05.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 05:46:24 -0700 (PDT)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Hans van Kranenburg <hans@knorrie.org>,
        =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
 <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
 <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
 <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
 <209fcd36-6748-99c5-7b6d-319571bdd11f@petaramesh.org>
 <6525d5cf-9203-0332-cad5-2abc5d3e541c@gmx.com>
 <317a6f8f-3810-4a6c-ba64-3825317de1e7@petaramesh.org>
 <c116d672-a212-f73f-ffdf-fd97aa958135@knorrie.org>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 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
 KB7t2CoZv5xo0STm
Message-ID: <3fe4a6dd-942b-56b6-c5ca-fed5e801dc0e@googlemail.com>
Date:   Thu, 29 Aug 2019 14:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c116d672-a212-f73f-ffdf-fd97aa958135@knorrie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 27.08.19 um 14:40 schrieb Hans van Kranenburg:
> On 8/27/19 11:14 AM, Swâmi Petaramesh wrote:
>> On 8/27/19 8:52 AM, Qu Wenruo wrote:
>>>> or to use the V2 space
>>>> cache generally speaking, on any machine that I use (I had understood it
>>>> was useful only on multi-TB filesystems...)
>>> 10GiB is enough to create large enough block groups to utilize free
>>> space cache.
>>> So you can't really escape from free space cache.
>>
>> I meant that I had understood that the V2 space cache was preferable to
>> V1 only for multi-TB filesystems.
>>
>> So would you advise to use V2 space cache also for filesystems < 1 TB ?
> 
> Yes.
> 

This makes me wonder if it should be the default? 

This thread made me check on my various BTRFS volumes and for almost all of them (in different machines), I find cases of
 failed to load free space cache for block group XXXX, rebuilding it now
at several points during the last months in my syslogs - and that's for machines without broken memory, for disks for which FUA should be working fine,
without any unsafe shutdowns over their lifetime, and with histories as short as only having seen 5.x kernels. 

So if this may cause harmful side effects, happens without clear origin, and v2 is safer due to being CoW, 
I guess I should switch all my nodes to v2 (or this should become the default in a future kernel?). 

Cheers,
	Oliver
