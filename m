Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3F619B6FE
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 22:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbgDAUcD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 16:32:03 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35018 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732669AbgDAUcD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Apr 2020 16:32:03 -0400
Received: by mail-qt1-f176.google.com with SMTP id e14so1388912qts.2
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Apr 2020 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ii5ViKnL/Fb/oq3hirhymYSM+6cYYQOck6pZNDfqRGM=;
        b=YaeiPaEY80BAOGz5UJJMR+MZobV59L0/vaqPlAQDzTsPe5W71NK4CIc7rmN2/eyrsg
         hHu2wbltFTVx8ZQkYXH6eQgoJRGSLfUWf6vGwPOMDwHsobhRSUWTAwCs5GKPGa4Anmaf
         qkPBvW4whq0yQ9j+MzQuJlBTADqBA7UIPnmfAhqs7Sc/bGSuleftB8zU2Ch/li8ULHDH
         iQc395LfuwmCIqQqFqGTxSEeneImyB5gl8EgGJqMIjIjDUhC/W21SqnucgyttAj6VTBE
         t4t1KGdbZN+rN8+Grsu9b5RtWDyvlDDEQjVgFPLSB2Ha5sMcv/VOFM9Cf8MiNkrb355d
         79sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ii5ViKnL/Fb/oq3hirhymYSM+6cYYQOck6pZNDfqRGM=;
        b=O2f35OC0hGaZYbTvWwfFEGsjEZsI1mN3e7oKGWqrYZqAnywsXJVTKXOKfo6QUwcO15
         +wnHsq8RSLiJ/vvpGptXmVynpKdTlD7qA7JXQU0SJBEyaEWfLkA8TVsfnAI1wQXdxsi/
         vXYF0dQYE9/8tfaTzsyc/POs74Pd2iC15CwyBd0LT0je8pUug/ww67YKyA4dcic3NKRx
         sRHCDYIU98NnhXtxbJ9fBQw8ICzlnJueyrRmiQ4UB0eZ/ftao/OjFCBjzrLnahd9FJ3a
         WJWrMAeTJyAFgrfzYtep5SfnZV/9mTJNLwu1boWMk2Jl0zBHni/Q4Y6ybxY6jcIqZ8+E
         ocog==
X-Gm-Message-State: ANhLgQ1nNQkMepZ5wlgoq6pDLpq2oY6j2cQOt5sR7r+AzEuViAwkPQ/r
        KaC+hhzfge6CiNm3w1UsL/DFA3hsN0L3yg==
X-Google-Smtp-Source: ADFU+vtxaroxY1r2ZMI/iAcq+G/V2fNiYdOAl2WeC0dM2GpBARmIVw11710U0dPlwlQre5nSkLCwvA==
X-Received: by 2002:aed:21c5:: with SMTP id m5mr12286859qtc.42.1585773119821;
        Wed, 01 Apr 2020 13:31:59 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f127sm2129711qkd.74.2020.04.01.13.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 13:31:59 -0700 (PDT)
Subject: Re: Btrfs transid corruption
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <800B6BF0-64AA-45F5-A539-9D2868C2835C@scientia.net>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a8a1e614-d5f0-d4b6-2f0b-626a34761758@toxicpanda.com>
Date:   Wed, 1 Apr 2020 16:31:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <800B6BF0-64AA-45F5-A539-9D2868C2835C@scientia.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/1/20 4:06 PM, Christoph Anton Mitterer wrote:
> Seems my mails didn't get though,... Maybe because of the attachments.
> 
> 
> Hey.
> 
> Can only write via smartphone...
> 
> My notebook, running 5.5.13 froze... After forced power off I did a reboot from rescue USB stick with fsck... no errors found.
> 
> After booting into the normal system I get the errors attached as screenshots.
> 
> 
> mount -o ro,recovery fails, too.
> 
> Any idea how to recover? Is this a serious corruption (and should I thus recreate the filesystem from scratch..or just a minor glitch? )
> 
> Thanks,
> Chris
> 
> Screenshots here
> https://drive.google.com/folderview?id=1pWUh80CIefXUguqv6UklEBrVv5QSpNkp
> 

Looks like the tree log got corrupted, you can use mount -o nologreplay to get 
it mounted, and then you should be good to go (hopefully).  Thanks,

Josef
