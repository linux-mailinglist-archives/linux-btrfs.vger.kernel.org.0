Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6346D9CFA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfHZM1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 08:27:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43878 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfHZM1V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 08:27:21 -0400
Received: by mail-io1-f67.google.com with SMTP id 18so36702736ioe.10
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H/N7gWnruTlKacQqDAeFeHHNleOd/fi/7ZUbFS509DU=;
        b=dg+K9npC21k+XHEVWnp4AFoQFOCYEE88YbGoektA/QEQi11Gi9pib16sHnHXz5izrA
         8CTd9xPxImD33vvaGGIwlH0TaRjZjeBTBBrp9TkCC2THNSQIIZDoOFTtSSZ9KDWCx/w0
         78wAdrVF3N2WTylLkUa19V4XjoZkS01ubXRWyH1+JlMKflU+TyfizLh6fOJqB/b64SlK
         1/eHYnfD1u9Cqc/6e1eU32fnyHkXbFsf74IcBlbNMK3DzDtGXO9hAPYuI1ZVw4mrGI+n
         ke3vz+YdEek2RDsGo7mB87gGGdeMGPcAWrmUDxNeLRoEuegmPDpPsungjkZxM67/UTDi
         hMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H/N7gWnruTlKacQqDAeFeHHNleOd/fi/7ZUbFS509DU=;
        b=gAWLXNKaMYbtG0XJP+pxrwDpVbDJtmgBC4KSDfFqts0qnFE5JHy+QZSei7SP21WSug
         5vrXucd3b41s3oCR+2Owyic3SFTbwHHCP8m4sn++gS0WKudVFdskDcDN+uQXuzLaOWiD
         K7SoMZEdNTbvwR2phXuQl2kx2NZrJesXRLKrg0pWICLTI1TaRX2PL+cfS3P7D7Z4fYU+
         cSdi8fP/LU85XLBUKX88LzOw9316vfa71rb0ZTWKaqzCtoB4qLClpUM8i8A7J74skJml
         H6gKJDr19+VL/4dF5elSHN/vdrhNwGIGVfngGKfwvRokdXypsjdAEvEc/o6ylRqfQgy5
         zueg==
X-Gm-Message-State: APjAAAXx+G5kFbBnvIV8L9qyuGosP0EHgzeQfUnoZQHso+nyb61wN6Wx
        bm1vItzErEsnibq//X3db3ByyO0Utn4=
X-Google-Smtp-Source: APXvYqxn/7GGBOUv35hVcPEYef/6tITopBTZXmwyf0/RViVMvHuKQOhm0zBDZ+2KrEdDg5UQURY0VQ==
X-Received: by 2002:a05:6638:1e5:: with SMTP id t5mr17836081jaq.79.1566822439877;
        Mon, 26 Aug 2019 05:27:19 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id s12sm10552557ios.31.2019.08.26.05.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 05:27:19 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Support xxhash64 checksums
To:     Adam Borowski <kilobyte@angband.pl>,
        Paul Jones <paul@pauljones.id.au>
Cc:     Peter Becker <floyd.net@gmail.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190822114029.11225-1-jthumshirn@suse.de>
 <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
 <CAEtw4r01JMFqszs0bBeeU3OXLqbT5+cU+4ZP282J3cvYzALgZg@mail.gmail.com>
 <SYCPR01MB5086F030FA4FD295783638B99EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
 <SYCPR01MB5086BAB60D850EBC8FE046E49EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
 <20190823170845.GD17075@angband.pl>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <69ac4340-c782-aa92-246c-3106b1611eea@gmail.com>
Date:   Mon, 26 Aug 2019 08:27:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823170845.GD17075@angband.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-08-23 13:08, Adam Borowski wrote:
> the improved collision
> resistance of xxhash64 is not a reason as if you intend to dedupe you want
> a crypto hash so you don't need to verify.

The improved collision resistance is a roughly 10 orders of magnitude 
reduction in the chance of a collision.  That may not matter for most, 
but it's a significant improvement for anybody operating at large enough 
scale that media errors are commonplace.

Also, you would still need to verify even if you're using whatever the 
fanciest new collision resistant cryptographic hash is, because the 
number of possible input values is still more than _nine thousand_ 
orders of magnitude larger than the total number of output values even 
if we use a 512-bit cryptographic hash.
