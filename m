Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50CA36ED00
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 17:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhD2PHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 11:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbhD2PHq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 11:07:46 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2483C06138C
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 08:06:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o5so67473518qkb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m9ARm/H1qCng43AlLNbgUuU+Bb+EJyOdkFSAAcq4cjM=;
        b=E0fvtfoaLp+6mB39pGxFFsBCAlSCjx0jokdvfBOraywpUDSGU7fFrnDuQpKkSflICA
         4lNqxzoNKZYmOFRQkNuzvov3AOllxPOFxA7uU5ZzLFA4/p1fhvaUH8EogH82pQiSHhUR
         EjRX0cc+YWAxgIqWw3Tauw8hpqiRP+5h2+RTzidbhSvtLHUyIuU857MWpGvn/cAzKjtB
         B/PcbRs61wW+ZZGjt3lJmDqQ8Eb+5YOVtggo3MohoIJJjq1l3iV2W1IBdY0SxR2MB3TM
         D9q4RQXL1pNS1xe5DLOW7uu1XHc/0d6mvv1XkJqTcKocaTefwC8b5oE4Q/8wRW0SwPSb
         LjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9ARm/H1qCng43AlLNbgUuU+Bb+EJyOdkFSAAcq4cjM=;
        b=P0jBAd4qH6+zgoA++oTs7Th9U1QCXCgfQnlGvCdHemWQRZK1cadlzZOfQl5+8tmcCF
         TPGOqUWSXo6WI4kIArNbrLNXUuvm7pijE4UoWUmyampnY0Eoss0pcHH4OWUGkRoGFmJu
         3orA/9OVgBenRxYK3kBqvU8v49Cjj0O4GAyPVtN3sChbd88I3d86cuRPEWQVru9/ezG1
         A+j48QtmNZcM3E8rEe0nTZ/P09fBUGnYHwRpNJ8fuE3nRLLCv7RBGPmj4LKLPMuts6JC
         r5I7vtAw4Pq7OoZ6a2stClQnD/cM/Ow1dkfU6P0AGvDTxd3R3nrpXu8jxKjDBP6bJmTJ
         0KbA==
X-Gm-Message-State: AOAM530+D6+SdkM3ETyUQlkT92SbDUjy7tFDRgmxTxCYpzDQD1bX0Zov
        iTFrbIEUYNPZyAMJGDLtpWifPCmjTGMyOw==
X-Google-Smtp-Source: ABdhPJxEatgijEGxtvUg3/5R0/IUhrx3NugOX0x1qH/SnxZL0WPUm8iQ9uO45wJJ7r9lF+7KUs5UqA==
X-Received: by 2002:a37:44d3:: with SMTP id r202mr61196qka.399.1619708818025;
        Thu, 29 Apr 2021 08:06:58 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::11c3? ([2620:10d:c091:480::1:a937])
        by smtp.gmail.com with ESMTPSA id p6sm2344873qkk.30.2021.04.29.08.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 08:06:55 -0700 (PDT)
Subject: Re: [PATCH 0/7] Preemptive flushing improvements
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1619631053.git.josef@toxicpanda.com>
 <20210429094852.DAC3.409509F4@e16-tech.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a4d45780-84f1-2ff9-638e-64a0e97af5b0@toxicpanda.com>
Date:   Thu, 29 Apr 2021 11:06:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429094852.DAC3.409509F4@e16-tech.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/28/21 9:48 PM, Wang Yugui wrote:
> Hi,
> 
> xfstests generic/562 failed with this patch.
> 
> This is the file 562.out.bad.
> 

It's not failing for me, what is your config like?  Both the local.config and 
the type/size of your devices.  Thanks,

Josef
