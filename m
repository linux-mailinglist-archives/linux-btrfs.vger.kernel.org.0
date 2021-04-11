Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810CD35B1C5
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 06:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhDKEuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 00:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhDKEui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 00:50:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7463C06138B
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 21:50:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u20so11202999lja.13
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 21:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=osKmRFXJF0b0aWsfJU4SJMCACF2HNpZoynySKwqjC5Y=;
        b=dGD9T5kMWtVBBhv8Kc4TJ5nYJ+9B824Nz/f7HEMdpoVefzvKIeiqYh1U2ghTulAzJS
         Kl3ZQ6vehNZpaKj9XTC4uieP4yvRPDCnikFCiRTkJgnw9jfFrSzzGxHOrVeQfsepFrtt
         DGFac4VZhAxz1bK8qZErWOEMAIf5xht3mFFxpJzgOQ6SOoCK3q6L5TepbtrcXgnLN1ka
         LxMxV2Mz+oqV0/Q/OKXbw0V0lKMjmlALQWl3ckyp7ab03hctGIN/oBxHlRdO3FJj9Aw3
         uANVi520JdE4J7vB9L/zDM01ya5WyKfnNCyxOI4u2wws+JryzRaZATL3fJtStzFTLJxb
         AzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=osKmRFXJF0b0aWsfJU4SJMCACF2HNpZoynySKwqjC5Y=;
        b=N4awHo7GNBp7KYxNMSD6bCV7l0ob6pQlM/Wfo8NXku9uPh0WC57Oa17ROSE/LC/eU0
         hplkdRwKS++QvDv4JZ19DnZQmY7IxOvTUPizeAp0NjVcRJsheEi31lkRQOX9Iitscx8p
         pCvCFVrmAzxEgLVJUQDrPIa39+UivvK/8m7NbBBNUrz+dgv674kW1Vb0BlOH1NBqC7a/
         MWPGAp3GghSyjWmRynRtMH7WE+ymUJ87zhTOSvABEL4XNYrdRWFfreB9I/VIdUmLzA18
         DxRpVcb4pdGGppBRZs1onvwepzfS0GpMHrEwtxq5DzhqkArB8aQyQOR3W+Br6Ppptdus
         9Cmw==
X-Gm-Message-State: AOAM531Y4vAfiJ6dvRbD9NDGrHXUD5SPg5/WAbkZ/g9YrCvV61/hxbiS
        XmRaAfBxAeRZwbC1qUmdXpwmfrmkvmw=
X-Google-Smtp-Source: ABdhPJz5USNLdRhCurKr6Ux/3Yy1xvVcuKxXP2DPpRtzbx8Lw+lh+XKC2FHcjHdHCfQaHJf7DsaN3g==
X-Received: by 2002:a2e:a543:: with SMTP id e3mr13563675ljn.433.1618116620644;
        Sat, 10 Apr 2021 21:50:20 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:f67d:23b0:24c5:db70:4d19? ([2a00:1370:812d:f67d:23b0:24c5:db70:4d19])
        by smtp.gmail.com with ESMTPSA id h6sm4969lfu.191.2021.04.10.21.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 21:50:20 -0700 (PDT)
Subject: Re: Parent transid verify failed (and more): BTRFS for data storage
 in Xen VM setup
To:     Chris Murphy <lists@colorremedies.com>,
        Roman Mamedov <rm@romanrm.net>
Cc:     Paul Leiber <paul@onlineschubla.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <FRYP281MB058285E8F1BD4B521817F6CFB0729@FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM>
 <20210410194842.71f49059@natsu>
 <CAJCQCtRqaxE6k9JGK+xSF-onTcVTjageC4dWoPdD+RARMK652w@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <18ddbfa5-1cc2-fc29-a865-bd19eb80f163@gmail.com>
Date:   Sun, 11 Apr 2021 07:50:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRqaxE6k9JGK+xSF-onTcVTjageC4dWoPdD+RARMK652w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11.04.2021 02:06, Chris Murphy wrote:
> Right. The block device (partition containing the Btrfs file system)
> must be exclusively used by one kernel, host or guest. Dom0 or DomU.
> Can't be both.
> 
> The only exception I'm aware of is virtiofs or virtio-9p, but I
> haven't messed with that stuff yet.
> 

There is no exception. Filesystem accessed by virtio-9p is owned by host.
