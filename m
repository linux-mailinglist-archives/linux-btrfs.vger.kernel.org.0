Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA318202D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgCKR7y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:59:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39675 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgCKR7y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:59:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id e16so2976173qkl.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cyo0MjF68Zg4KrjegXoPwerkYW/t2qPjmqeZMWuNRm8=;
        b=VcIxPkJQxmVKfgVc+j7l0OAsjoJKwVrr8R8NIJgfTQRaR8WhTImUNc+PzK4huVG4YH
         rKC19PyA05rwclz85eGrxBHqUFIT49D/zjC3/0lxeC9MJWD1PlL2/QNKaDJL5neLIHb9
         p4qD6gzYIODKBaWpILYmFOa0IR1lnlWtzMYyKfjEblimHht7x5J/kaIKHeHKk3DRdzxm
         S65r+99RjGkR3t9cB6NPyvpIIBryynuVa3uaOBUySMrEIvom+ZIhgHEWinP6cwBV5tQz
         sH4GJAea73ZEXMlotCR8T4304+E6HNPHoXLnfKO1E2YooO8h4yZYxKmH9ntVpprzr8jT
         osdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cyo0MjF68Zg4KrjegXoPwerkYW/t2qPjmqeZMWuNRm8=;
        b=G40JdAXTCs/agtOx1nWJa2vpLj49DXnfpE56D04EXI9HKSuVJgZQ4K19bitfUjC+SP
         7RZI+djm3s2GkWSelDbY/+GhYKEL0vn9Va2+MGRVMprsq9ey2OoNQ3hoKxsiA0GFrYLO
         EM9UZv3ES6NYVCDLiVwwZRcRkroAM1510TWRc3cUVsPItuGA+WETyQI+BpdZ/F+gzWLD
         4fvM8NS/T3fdlsuC+sPhlMoCj1inqz6ZHG1p54c5HHTDSg7pIIwTQTV1WU/o8vgLPIjF
         TsWgTK5MXtDiNMFLYUwPPcH0/gXoMCHv/KAtxKRp82LO7q3AIELcp+NYAoTNuC0J2ss/
         q6SQ==
X-Gm-Message-State: ANhLgQ2R2nno4b6twvl+FeZ3EKk+w9EUTKM3oLfYPE6PhI07NfoEmyrV
        qf1qjZlaI8jpu1pHxOBlwIJUBQ==
X-Google-Smtp-Source: ADFU+vsmb7xWFoTQRvTPxKhdsnNy/Aq1m9zjEpVPTD85GIHk/V+SbEgHqSbJDkQ+s9qB8tWFevNMnw==
X-Received: by 2002:a37:2713:: with SMTP id n19mr3913212qkn.230.1583949593374;
        Wed, 11 Mar 2020 10:59:53 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m1sm2954812qtk.16.2020.03.11.10.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:59:52 -0700 (PDT)
Subject: Re: [PATCH 09/15] btrfs: kill btrfs_dio_private->private
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <432c19b74bb13191a04550b630d2db1f998ba3be.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <32ab11c9-b347-8158-1288-506069cb6403@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:59:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <432c19b74bb13191a04550b630d2db1f998ba3be.1583789410.git.osandov@fb.com>
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
> We haven't used this since commit 9be3395bcd4a ("Btrfs: use a btrfs
> bioset instead of abusing bio internals").
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
