Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F39155BB9
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 17:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBGQ0b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 11:26:31 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46921 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGQ0b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 11:26:31 -0500
Received: by mail-qv1-f66.google.com with SMTP id y2so1250113qvu.13
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 08:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wbjuC6rEH1cm5pGay1KmFM6WsLlsPsN7zwM2QHJGjfg=;
        b=1USGTgRbv0rak9ufOTwcwV/Aa7bCbnJh8iiuFKl4zPl/ZNZcGJkejQpVk3z5hDYn4s
         /G3YQERVNZ1aNRnViUNQkr6cyCXpRDen3/bbUM7UkKe1N0BYN3s4T/N0F70YB6VC5V7R
         oH+Ni1YR5kAm/TNX3DoyCpCd/MxNgFviiXz4o8J6O+2dle+4x98yD8BpWCaD4KK6P9np
         zo5U45eHy2GZL4G3lXbohgeH92nmJLfyZvJ71/AISdrYcDb+IBERiFqAjK+CeAxj1lKZ
         pyA3l60apiznTXquCVMXHe3XJ5y39TN6HXoXn1tRzx4u0N3yW+vESlHrjvT0AvcA17SC
         UV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbjuC6rEH1cm5pGay1KmFM6WsLlsPsN7zwM2QHJGjfg=;
        b=j2ZIGyM8nOlNdthqnFb2ug3nWVI+zUWMJwYt674s0eiPy6RgkpNgNuOoqMqshDK46V
         45pPA7Hr3g4YpaF032taqRc24EBNu28ozfGoITSF3Rf9pkhnW+S5wmkjg2812azLp5ue
         Q2c+r+JI9n6cYQpx2sOb1VnA5sXy49hRuEN1sSy80y9RXz5YlQiGsOcIwr4DvNJGVa7X
         QO7sSwkJEiouKSj8YG2Bhk2i6CkUHQg7b06pXoFGbGV72VJDlD2aFIzjLbWNBNTpytj5
         AS8qQkDB5Kc+OPL1+w2daM+r9wfHkjbdsLD9NokskeemI6YWUDT9qWRFXXN9yxkAEh3k
         KVTQ==
X-Gm-Message-State: APjAAAW88SEZu2NZm0ecvMJ1QExMsBrHbFsK3uzWxyJlku/U+UCI+Vwu
        DzmRKs3biLTIREpd434PXuD74xALPCU=
X-Google-Smtp-Source: APXvYqxWXFBG1QkpPCX29hjjRITuE+oLGQrWCPgQMqrqmO4kjcwviOgIiGa6OLdnc38HOdnkYNl0tg==
X-Received: by 2002:a05:6214:1634:: with SMTP id e20mr7528533qvw.205.1581092788491;
        Fri, 07 Feb 2020 08:26:28 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s42sm1576746qtk.87.2020.02.07.08.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:26:27 -0800 (PST)
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
To:     ethanwu <ethanwu@synology.com>, linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-2-ethanwu@synology.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
Date:   Fri, 7 Feb 2020 11:26:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207093818.23710-2-ethanwu@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/20 4:38 AM, ethanwu wrote:
> When resolving one backref of type EXTENT_DATA_REF, we collect all
> references that simply references the EXTENT_ITEM even though
> their (file_pos- file_extent_item::offset) are not the same as the
> btrfs_extent_data_ref::offset we are searching.
> 
> This patch add additional check so that we only collect references whose
> (file_pos- file_extent_item::offset) == btrfs_extent_data_ref::offset.
> 
> Signed-off-by: ethanwu <ethanwu@synology.com>

I just want to make sure that btrfs/097 passes still right?  That's what the 
key_for_search thing was about, so I want to make sure we're not regressing.  I 
assume you've run xfstests but I just want to make doubly sure we're good here. 
If you did then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
