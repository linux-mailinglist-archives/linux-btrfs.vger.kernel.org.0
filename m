Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E77559F60
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiFXRMU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFXRMT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 13:12:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8B51E7E
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 10:12:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v65-20020a1cac44000000b003a03c76fa38so1024137wme.5
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skarcha-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=zpCbNbdY9h+8VvMVzmGlOS+i5VBrGo2B11fQDsN4xA8=;
        b=0h61YcNK8lS+u4a3a+zn2b0aX0E5FOtdxddvGAD6+0ZBpeVWoP/GCpMABtoxG7IRPV
         8q3fvMeDfkVcZuySH8O9Z8uHC8CqEVLMr/9TWZKQvzBsa4fmaisAyRcGuyaPTO6Lj4w5
         7W5iKDI6qVlORICs41nQ2HKG5+E9KXVyofVP/DyAc9sOSJ2pq9cPXHkAiGsWLUPlvqtM
         xGNhA3I9nCuCdfkTPF/yJlUKTDZpARpdvgr9NMCc9q5NIcZQ9JrokUbrLuLB5WG3vvWO
         ClpR8VzDW7DH6Q8Cq85PPqy/vRbZQLCMK8k2CnHFdGxmlefYoLnF0512p0AeNg/o9H5t
         oi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zpCbNbdY9h+8VvMVzmGlOS+i5VBrGo2B11fQDsN4xA8=;
        b=MHnVGXPbklmcGOfNL+PCw4DY9lPtsHclsTQeMC9CKkUj8NYSQ19XYRLEYCckpId1Co
         291dg6Uu9goaXBTzoNg5xA5MFQmOyhyjKPC70c46IMBYpbVMv8YOGsbrmkzdm1Zqe5tR
         zkGtrumz1YcHxOSUKwKIO45JAWApR+TnSGpWGWWIlIXkrlLfmOjoLxH7NSIDGE2KT/iD
         G77GuBoWTO5mLqBBbasWBw31tlEOpHSC8czO1QAz58vLmb9a3z+tTeBiLjJygUELQ7ef
         n/NyuaPf4YQDcwhUzNvPjR6J5+bqm6pvurHdy1ZxUQjAsZX2BcP0XFw3JdpcWZBXCugt
         UnSQ==
X-Gm-Message-State: AJIora/EQLeJdvVNI2nNDaDWmOcIdTH+tGM0EGN4mzFNGMjIwASO+X5B
        vu4EAf5sihMcTyBGYTo6A2SzsgIqRVoB6p7fgNM=
X-Google-Smtp-Source: AGRyM1tthPkynscfjeqlf+9KniUXXLzFAyH5K4hee/cKOiNFVHH975PmvMVyUkbR4iI99piuRxHB/w==
X-Received: by 2002:a1c:3b07:0:b0:3a0:333d:ae22 with SMTP id i7-20020a1c3b07000000b003a0333dae22mr109721wma.1.1656090736653;
        Fri, 24 Jun 2022 10:12:16 -0700 (PDT)
Received: from [192.168.20.2] ([185.212.125.212])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b0021b892f4b35sm2899351wrm.98.2022.06.24.10.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:12:15 -0700 (PDT)
Message-ID: <80428a51-4e0c-f109-d469-c6dc3da2ac7f@skarcha.com>
Date:   Fri, 24 Jun 2022 19:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] btrfs: switch btrfs_block_rsv::full to bool
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1656079178.git.dsterba@suse.com>
 <845f7ad07062c689f23d2c6346dfc5f74fe9d92d.1656079178.git.dsterba@suse.com>
From:   =?UTF-8?Q?Antonio_P=c3=a9rez?= <aperez@skarcha.com>
In-Reply-To: <845f7ad07062c689f23d2c6346dfc5f74fe9d92d.1656079178.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

El 24/6/22 a las 16:01, David Sterba escribió:

> @@ -175,7 +175,7 @@ void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
>   	if (num_bytes)
>   		delayed_refs_rsv->reserved += num_bytes;
>   	if (delayed_refs_rsv->reserved >= delayed_refs_rsv->size)
> -		delayed_refs_rsv->full = 1;
> +		delayed_refs_rsv->full = false;

Should it be 'true'?

Thanks,
Antonio
