Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020B8757A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfGYTOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 15:14:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45825 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 15:14:09 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so99560759ioc.12
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 12:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wjSg/Tvpdr9T7FSXNKzBYEPcpgnCVbfs2X2a5aK2Wk8=;
        b=nQkukiVYE/FtTg3112qHNGfi787jdUaVPEr03VLWPXuS3gVK+cwfD5ig6NU2Pu4PjH
         wt3wOSavgcbEegYReD5mlHtEMJsBrzsfum0un8C9ZMeHKSaGSdoDaimOfetBBm+fF7k5
         y7xGsob9iSVNS0AkTxuVNtTr80W54XjNa+9b4o+yMNnTJxjbSaXiYc1pCkgSBtArMqml
         W1FM6A58Sa+cfpT47gtUSNxHh9aiD1VSYjrpIj6nvMtn0O5XYoVGXEAoGNA5USM76gtw
         CABMMwVxFLbnbeWGtSgWWs3TbV4V3oJ1rfF6ZI7m8IO6vos30zIA5lAnhkQbZB0BM4mb
         xmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wjSg/Tvpdr9T7FSXNKzBYEPcpgnCVbfs2X2a5aK2Wk8=;
        b=GuGGIFICg/7IzrDkfHo5L6RWgk8ttsm+y7ZMSqjgftR2qtUvd/JnoI4nlTlS6lB1yI
         ENXj8s96rMkTVey4/6wZGZ5fLJPJv6NM4V0AIMcDg2Qb09If75KK3dSbnG7hmWhqAI37
         O/dalvu5RYYogbcWxVSpaMPJYWsRrpD7zI1Rcn6A2Vmyr3lPOBx9AhW8NKJrtj2Fbyyj
         OTybP7LukqlTtp1bZqsrV98SDPwvq/oEEzP8PKRC9Fkzk7vPHPKNT7Ls9wAHtaCCN0iZ
         pXArNI1Pe30pavUW77VLO2fegonuyVIH+S+sGei6/UnPP4G7PGsNgDTQ1RHyAZy1XPES
         Li5w==
X-Gm-Message-State: APjAAAVIohGIrc/LIxq980ptbI4ZP0oY03jVp8tYobKvTa+YoAvxZCoS
        8aR8uBF7chaR8QNw0oASC0nnke/cZWQ=
X-Google-Smtp-Source: APXvYqw0rFSAR/620Kr89jT18htWTkMpawBv4vOWpsrD9vc0cvdHo12lwgrqLsIsTdO/pwtDsKHsOA==
X-Received: by 2002:a6b:d809:: with SMTP id y9mr86428267iob.301.1564082048525;
        Thu, 25 Jul 2019 12:14:08 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id s3sm41864596iob.49.2019.07.25.12.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:14:08 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Allow more disks missing for RAID10
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190718062749.11276-1-wqu@suse.com>
 <20190725183741.GX2868@twin.jikos.cz>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <bad64044-5168-848e-1799-6c621ae2337f@gmail.com>
Date:   Thu, 25 Jul 2019 15:14:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725183741.GX2868@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-07-25 14:37, David Sterba wrote:
> On Thu, Jul 18, 2019 at 02:27:49PM +0800, Qu Wenruo wrote:
>> RAID10 can accept as much as half of its disks to be missing, as long as
>> each sub stripe still has a good mirror.
> 
> Can you please make a test case for that?
> 
> I think the number of devices that can be lost can be higher than a half
> in some extreme cases: one device has copies of all stripes, 2nd copy
> can be scattered randomly on the other devices, but that's highly
> unlikely to happen.
It is possible, but as you mention highly unlikely.  It's also possible 
with raid1 mode too, and a lot less unlikely there (in fact, it's almost 
guaranteed to happen in certain configurations).
> 
> On average it's same as raid1, but the more exact check can potentially
> utilize the stripe layout.
> 
