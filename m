Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E84F0563
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Apr 2022 20:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbiDBS1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Apr 2022 14:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiDBS1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Apr 2022 14:27:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49096DCA99
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Apr 2022 11:25:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r10so779578eda.1
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Apr 2022 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+zg0Wj7V1uBR/2d8N5B44gDdG3PuV4CufFJYgdfkavM=;
        b=ITgUKfm1D+ICcrCggNG24gcTXH3AZjer8E913q4ngYsTRfcFpLSyE/3O/5VuFWr/w+
         S+/fQB3/E3fDnfWfOqDKf6Zpe3knjhRVES9CfVbZPso3/1YYBoyOxyAKZKlN4MnWCMWx
         PWQaeqgRS/6kJEnpF7pRvEvtoleb5iDtZ9VWUJA16bFuHimHvcy5d1utGAqWXUlcr+Hu
         17PySJvUGYueFM3QLnZ3/GGDuufmvFN1+i2aSxNqnyxrsIEa8g421n13GDT20mNwgf/d
         7vrRzcEHPsV3eSEB+gE2fdRcPpLN4OS05Yf6t31ddAItF8RaKA5cb0Te7HddF5iYPstb
         JyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+zg0Wj7V1uBR/2d8N5B44gDdG3PuV4CufFJYgdfkavM=;
        b=J983yQVokM3Aj6f22LzdiZFG8guLaJjnL2hR2WmBZpS/BTxHoqV5vUa092vo2oBzsl
         bDRhFDojkIlff+nKiUfPPyvxXw4Xw6fv5zVD9WMOZnMbn1wnAYP7ovLL9+3MzjiH6q0u
         Aso0WlqLvY/vGEoeJe9D+EbXOhgmGPbxudQV3pphkwL1MDBcFrcwnAFzcQc6VZZobL6G
         Slx/oIQ7W2mNnuVHrONUIAAUFfQrVvah7cg8+CY3UcMyq3Gi3HJRv0Iyw2BmYS0tC8qL
         OmGrnu2vY1QzUOkz0/ngzLYtKELMR6wJbfxSFiqsgvQsUgJQDYI0cQlX88ZfNsJhjSaP
         5+wQ==
X-Gm-Message-State: AOAM532zXZcwjpSUTM70eRkPidRcLwE/qf+bWNDsRx88O3joj6dVbEkr
        sOFpx5N0Oz/Aq8NM1dhfUpopHEQAF8U=
X-Google-Smtp-Source: ABdhPJypPw/GDP8/uGuh37i8WNZDEr8n8sUwNuYm4kCLMOdu90Wyya5P+bd+1e8wILkSB846QE6zjg==
X-Received: by 2002:a05:6402:2805:b0:41b:630b:de68 with SMTP id h5-20020a056402280500b0041b630bde68mr18842532ede.143.1648923951737;
        Sat, 02 Apr 2022 11:25:51 -0700 (PDT)
Received: from [192.168.1.121] ([94.65.83.40])
        by smtp.googlemail.com with ESMTPSA id 22-20020a17090600d600b006dfbc46efabsm2331340eji.126.2022.04.02.11.25.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Apr 2022 11:25:51 -0700 (PDT)
Subject: Re: Adding a 4TB disk to a 2x4TB btrfs (data:single) filesystem and
 balancing takes extremely long (over a month). Filesystem has been deduped
 with bees
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, Hugo Mills <hugo@carfax.org.uk>
References: <8a536fe1-68bd-4136-8cfb-bd410afc5fa1@gmail.com>
 <YkcIIFuxqj5l17Nu@hungrycats.org>
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
Message-ID: <67609646-f896-4e69-5246-147a37ccf271@gmail.com>
Date:   Sat, 2 Apr 2022 21:27:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YkcIIFuxqj5l17Nu@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/4/2022 5:11 μμ, Zygo Blaxell wrote:
> As Hugo pointed out, it's not necessary to balance more than a few
> block groups in this situation.  You have to ensure that the amount
> of unallocated space on all the disks is large enough to contain one
> mirror copy of the metadata.  For most users that means at most 0.5%
> unallocated on each disk.  If you've already balanced 9% of the disk
> then you've already done 18x more balancing than needed and you can
> stop now.
Thank you for your answer. I guess that this should be documented 
somehow in the wiki or the btrfs balance command or even better make a 
"btrfs balance-after-device-add" command that does the right thing 
because now it is very easy to assume that after adding a device one 
should wait for the complete
balance to finish.


