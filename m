Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0828227E8B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgI3Mmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3Mmi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 08:42:38 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A8BC061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 05:42:38 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v123so1163536qkd.9
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmBkEup4lpsTX6MGr+G/TGCMTytcueGDwXZdpwelDo0=;
        b=FMTzZsZYubwiSFoTTxX5zsAhHGOifphNqwFClABjwDkL48X5eL7h1nWLDJJLjOAL3a
         vmGVjiriea/4+VB5Vzm727Q3CDNUHG19Pn0EfIxTzV8q8y1liIvuzLkxXTajj4yWsf1E
         i2DD2h+1vvSq9EPU5/kRxI+c9HCeUXrRrYQjQgjrTORNvYu5YAgD+eJgEB8GVB75RMiL
         hP84gRG52nKD7Q5vzf+N2MuHvKD5w1pgcTqL7klueSudGAvkHXec6DP2v9S+jDdudIa/
         yVqzdV63f/O348WQv3cwJ44Y8/Nwv5WJT3/9N8L6tQepaMAV0ACq/mAAtiy4wi5sFclx
         2XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmBkEup4lpsTX6MGr+G/TGCMTytcueGDwXZdpwelDo0=;
        b=Y/BNX1S3aiRxmMEh0wnNYUyNSxrq+CkQ1WfX0JEj/HKj0vGfnxGUog+K7PEV9gX679
         27vvSEue6lq2DWWRTBdqYrY1a1+cyQTN9pNfOvYy9t0J1BdRCEiHGbIN+F3VWJWixOlu
         lqUFQPwIXhPu1r7Ig1eVuQIt8A0acsSwhu17CJ9W9us97bdXUuK8lG6ugLUVsDJKJ3Vv
         cXsVFHeScKRYLitFw8WVUUqCnTHwkirZHMssF1iceSfZW7NUqt7eqWDRlSuhoJ2CFUBo
         9xxnY7R0+f6gwREAog8DyZZh5UK/bk7VXPmwqlvPZcBB/KXB1ZqnzFxWzMZFW0J6pdYk
         TbmA==
X-Gm-Message-State: AOAM5301qYXPY22LlJ6owHHiZ8WmzFS3xQ0kuxKOVbfjrHeOxr1oKbgw
        4we73+LD10A8a1DD8MI2Kx5aVQ==
X-Google-Smtp-Source: ABdhPJw8MfuhKZ3oKyGEbYzhKVM81mqcgGmemT2JhSU2iy29lP1aED73ikM1SWgj0W5Z2y6qJLBU/g==
X-Received: by 2002:a37:a607:: with SMTP id p7mr2354490qke.118.1601469757267;
        Wed, 30 Sep 2020 05:42:37 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d76sm1938762qkc.81.2020.09.30.05.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 05:42:36 -0700 (PDT)
Subject: Re: [PATCH v2] fstests: btrfs/064 add a comment to the test case
 header
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, guaneryu@gmail.com,
        johannes.thumshirn@wdc.com
References: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
 <c224d095bf56d5cac6268829d2d285a48aca77e2.1601440484.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <35d6a7ab-5993-fff0-a775-7d533266f434@toxicpanda.com>
Date:   Wed, 30 Sep 2020 08:42:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <c224d095bf56d5cac6268829d2d285a48aca77e2.1601440484.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/30/20 12:44 AM, Anand Jain wrote:
> It appears that the goal of this case was to test balance and
> replace concurrency. But these two operations aren't meant to run
> concurrently and the replace failing errors are captured in the
> seqres.full output. Which are expected errors. To avoid further
> confusion, this patch adds comments. The reason to keep this
> test case is at the Link.
> 
> Link: https://patchwork.kernel.org/patch/11806307/
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
