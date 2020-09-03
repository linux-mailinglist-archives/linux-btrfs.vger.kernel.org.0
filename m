Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBE025C403
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgICPCm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgICPCi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:02:38 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1BAC061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 08:02:36 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n10so2137589qtv.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nnznhvLEKu1NvJh0PfN/jXIOflRQbeGKu9NU9FZ9nR4=;
        b=m02UbEUqvQ8JIt+23it+NMdPFcxNAejJEZ7Ai99V8ADl1OplIiA4bDWYr2bIakaUje
         9odRXCwjBVfkio4CxrM+tNvQuXoe8+kD/RUi2lorkIQf+/Vihx95TJPVvioe9XV3hJjc
         4xTVJq1zqhXu0+41wFA+YcYSCMRVh2mJIxMMFWZzG2vKiwIpwu+ZEUEeJ0U2K5e3xXRV
         iDDEgOt0PCZWX7ra/DgYy5suEcQmuR6+VEaUu6k8NOJJgqPY/voN0piPi0oZr8CtdFhS
         7iSMFh1l1rhwKhEsgWVj1jTOBUJQGeG9F2h6jN5WhQ7RcLuY6o7l1ch3B83VOxLMdC9A
         CyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nnznhvLEKu1NvJh0PfN/jXIOflRQbeGKu9NU9FZ9nR4=;
        b=IAfw6cnzlR+350v1YAD9XxeRDCHHULLHcA6KHdkh4UJaQzprbzCeom/u568QXCSAUN
         oZryHYd3+QqbqugFV4J0ahvq16Or7howEeFpAhcSCN4EAQAajLuAgxveELlOUU/8kiA4
         l5kxUDYJdWR2Z61BIKcIV6ZiLSXTO8S6r9+2Rrh/QWLfGIgdkItrWovkM2WN6sJLQeB4
         nm7IiGFH4mwQxO5LKcv1qtqBmJh6riRGHEWCh47nGEQR+yorqsGh6F68PP7j7/tILqPB
         +aAv+6exS74JRZiFRxaCfL0h0VVsHgEwRICyVtrt5bivHKFE/HLle3bxFRPEG6Y4g11s
         VYqg==
X-Gm-Message-State: AOAM532E9RGdwyQzyklPx/qWMto4yoSD2X68RQ/VL6GWIMYy71WtWIrK
        opre7mggt8nrkbDqIWZuyZixcykdz80ayXsx
X-Google-Smtp-Source: ABdhPJyfk8hpOTy/uZrnZ96RcvaoIARvApkMw7BFPJMALjnw1pZx+gM0YPuaE/CXNIrX6NfyiWTAOg==
X-Received: by 2002:ac8:7943:: with SMTP id r3mr3691174qtt.90.1599145353047;
        Thu, 03 Sep 2020 08:02:33 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m30sm2236815qtm.46.2020.09.03.08.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:02:32 -0700 (PDT)
Subject: Re: About the state of Btrfs RAID 5/6
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Robbie Ko <robbieko@synology.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAEg-Je8OsZjWU_ZyLJHrbOJb=_C56MOmJ5w8UUbzz3JNuAi5Ow@mail.gmail.com>
 <b9ceb790-e376-69b8-0648-56c9a026b40c@toxicpanda.com>
 <SN4PR0401MB3598C82C1186CA04215145489B2C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e3c54b0b-59fa-8cd2-0e28-7cddca0e1b3e@toxicpanda.com>
Date:   Thu, 3 Sep 2020 11:02:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598C82C1186CA04215145489B2C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/3/20 3:34 AM, Johannes Thumshirn wrote:
> On 02/09/2020 19:37, Josef Bacik wrote:
>> I know Johannes is working on something magical,
>> but IDK what it is or how far out it is.
> 
> That something is still slide-ware. I hopefully get back
> to really working on it soonish.
> 
> So please don't expect patches within the next say 12 months.
> 

Have you seen my branch graveyard of things I still need to get back to? 
Clearly we're not committing to anything here ;).  Thanks,

Josef
