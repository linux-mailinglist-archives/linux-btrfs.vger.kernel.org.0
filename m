Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16E288AE0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbgJIOaM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388724AbgJIOaL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 10:30:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E4C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 07:30:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s4so10726462qkf.7
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p7Tcy41BHHzdJD3d55Dx7+SitKAuIMpz6nsj1EKscQ4=;
        b=PXQzFPw+2zyeumJOQcaBO0MUOi3o+J7O34smVyrogzNMl+qwUVlv5JD9mWKrvmZqx4
         6O7hY5mXBCBp+JMuIOs0AUUI09cw+F3mZozuQ0HA2oTZPmn3WvFLzbrESeUi1QSpktvV
         RZ2izTI0vG7QKJL+vybdmyFBujHf4DfJCRCGwevYFXywyJQpuW4gjJieQ1pLzC5YUuRR
         j1u5XwQgtC36/uSpcjUkBu+f3KtSUHs7owqqAWhfPtrTIBV8fDqGyP0W58Y3Ca/6iOWh
         DWOEfokxeQXQX21QxYgUi7Eiamh8Lw/QDbwNINXKHJikr2ILcLmGc4FAQcqHwWBqclof
         3izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p7Tcy41BHHzdJD3d55Dx7+SitKAuIMpz6nsj1EKscQ4=;
        b=VtU5pDilak5szwBLcCffzNggQlDw5IBYJUWkwkE2qla80KAddzkpD09p2GyGeKSH/L
         34ckYiPiilYu6xdoNkz5pMVHbExM2myiGgraMIRHCP5VgMMU8od/NRIlxjf8Mw3Kce6H
         Ko75wLmrcX67kj02nokID0kTfnA8E5LYpxHWp0QnpMyaTU0OUeSPG/W2oFcqRtVeO1Ei
         vSCogkZ7LSvA3WXzh6nB8UsJK1uNIuktTOxKiwePubBa8vnG5LAA8cfjYU1CCW1fcCdn
         GUIwoLmQIKyrB/PHRCZ16ulWpHj/sayW7IswMeZhVvaZiQG/dnQT+7pLn7lnsqF35pPY
         JEMQ==
X-Gm-Message-State: AOAM5311KcVVPcbLO/RIUOoAs0GXdB6/mAa/zA05atrBcPThD2ygujMM
        8CGDh1CV7MZkekh+M8qs8NyWKg==
X-Google-Smtp-Source: ABdhPJykdSDHPibSC9hA2ZTSLVymx8cWxLJ7r95HtK9LpRSGM3JYCE24+QKVrBoWD/AJwUNdKPcMUw==
X-Received: by 2002:a05:620a:128c:: with SMTP id w12mr14124460qki.355.1602253810703;
        Fri, 09 Oct 2020 07:30:10 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::107d? ([2620:10d:c091:480::1:f1f8])
        by smtp.gmail.com with ESMTPSA id x25sm6278777qtp.64.2020.10.09.07.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:30:09 -0700 (PDT)
Subject: Re: [PATCH] btrfs: ref-verify: Fix memleak in add_extent_data_ref
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200827074339.22950-1-dinghao.liu@zju.edu.cn>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f13c740e-b140-9dbc-04f2-0142de59f099@toxicpanda.com>
Date:   Fri, 9 Oct 2020 10:30:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827074339.22950-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/27/20 3:43 AM, Dinghao Liu wrote:
> When lookup_root_entry() fails, ref should be freed
> just like when insert_ref_entry() fails.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
