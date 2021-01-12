Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ACA2F34BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 16:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392048AbhALPyp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 10:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731312AbhALPyp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 10:54:45 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E9C061786
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:54:05 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id h13so1091752qvo.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N83XENXQnW41AFuMXS/IDpH47OJgCoILWeiepwCuKhw=;
        b=yP8V8XIk+Oq4YG5aY/CR4Q5voPMkQQvusLuq06yxTF30zAht7vC+6PTXM0Itg2F1Fw
         CSlditR3CyKqdAcL2mDLt6u4g/h1/cS4xCDxG4mq7RcMw4z5Z0pHyxI0YspaL8PaIBFc
         AwgeEYyXtnuTMThBnuyWUBl4HAezm0/zi9nUuhDRxOnYXkhC+2gws4gcwc5xpyMQZue8
         86eojElXw4rKEFApVbRkphAEvalBt2jDiAoG4hLKXy7PvsH1AuAkVtcofsUF55vvM79m
         ON9yCJNPM5ViPzc8o5Gh1hr9nb3BCRRSlLm9MdsItfkvasVyf9K6ASXbRTOZcdXq08IS
         b0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N83XENXQnW41AFuMXS/IDpH47OJgCoILWeiepwCuKhw=;
        b=cEC41PP2OJbhjBnD88OQqYJOGRFvUQkqgNLUjHrvCbZUmLsQSLt6d8Zqa4XxAzDbWS
         ajjIM4XFPi09IzI9fws8BOTLB5Du86cD4XPyVt4so3uvEwZPeu8GBDEy4AmjdW/LFxrJ
         lXgLpb67mCXeRidXSm8HcHkiKVDEekkp6HBGfmcIromED46yW1M8tZj9Jv5pnFCeJj4C
         Bf0kp+2+44cUq92RcM63IbGevvnPsqTS7OVmcUFkxAReS/Ttq6SW2NwweezsSwVKyvg5
         NflhzB9A636Odnt9X6bcjejhlzV1ZHxsc8+GKAVIhOwMqYITO0Wn0GyASXUhEkfR/jGi
         snWg==
X-Gm-Message-State: AOAM532Hqwyz8+zJVkdTWlz44LBs6XRXWbFL9Sy/QBliPtVlNq5ktFN2
        HsnYhZRDtkT6LapZx8ohBDuW9Q==
X-Google-Smtp-Source: ABdhPJxaUDH7QAnnEVnkSDvNArqpqc7/2dpMa2zWpHyhcKipSo4a6klU7xZvWb8dgzrTr5yyHj+Bug==
X-Received: by 2002:ad4:5a53:: with SMTP id ej19mr5071919qvb.61.1610466844188;
        Tue, 12 Jan 2021 07:54:04 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m8sm1467921qkh.21.2021.01.12.07.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:54:03 -0800 (PST)
Subject: Re: [PATCH v11 18/40] btrfs: reset zones of unused block groups
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <bd2bdfe3a51d928eb2e948d4df66683e5cb1c6c3.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4698efa8-944f-4e08-54af-b9062d40a60c@toxicpanda.com>
Date:   Tue, 12 Jan 2021 10:54:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bd2bdfe3a51d928eb2e948d4df66683e5cb1c6c3.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> For an ZONED volume, a block group maps to a zone of the device. For
> deleted unused block groups, the zone of the block group can be reset to
> rewind the zone write pointer at the start of the zone.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
