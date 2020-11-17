Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9EE2B57BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 04:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgKQDRe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 22:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKQDRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 22:17:34 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25619C0613CF;
        Mon, 16 Nov 2020 19:17:34 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 34so11804623pgp.10;
        Mon, 16 Nov 2020 19:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6w6Y+KqzYbUwOj4A2p9Oz5OKTpIjMcQwiYg01iziPDg=;
        b=YfWZvwi04XQpIu88S35NvFhkwZGp3RXqeam0pIp4LMSrQLR9hpxk6Vt0AUwO+kYgzy
         8sh6m6J+8VM9FQZEbEI/eMTe9SWwNinhS+3w5Pz7xktWA9SdSeKXv6NtupePZwX4YP6b
         9Uuu/h4oQ2cYzaiOuZdsN8SOGixniVnP8AmslVlqtcRd1RH+4TszkR3yRwpqGZj5Dhal
         QytFRpteTeBUU4rOkeLaF5CXlKJSJFi6UjTpseAlI17oZtgn0nJyvVHcuz9XoCvh9vir
         Sxn6n1dwGYXGCfTdE9dGKFFrUVN5D0BeAUNJ3IKrO451MibByObzTtptHxJ4TjeQQzhw
         H07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6w6Y+KqzYbUwOj4A2p9Oz5OKTpIjMcQwiYg01iziPDg=;
        b=gF/jB81kYxmk5f1I4jwh5g4ZqsgyJ99tm7JKVQ8vfZ7PTW/J2yRNvugqDJS4uFcq0b
         nIr8d2S2qhNXnS8SfTWc3XS3iyNj4HntJzUr85CIUc/9+5+clKWbmjidtcRsCmqA3Kcl
         vTTMqX4kiRJ8AdBIzBDQRI/H6wuyxI/vZc8bSjufhH5PZhhEFhzQ1yRSPnhBUjNhWpPf
         ZXZebCh1b4m/8iSMi6IRz1z5bGIQLWOaeY0uLb45r9KJiiUUoiLLC7akR8UaLfQj1gj2
         3ZxZ5zFVidUnef2fbIvqLfDUQGfgjcpXr7AP/1MaA16X4i28GnWxQufr4Wlc20Ly6J15
         HpsQ==
X-Gm-Message-State: AOAM530p+gmIaYzt7mPIq56igiulc94wbKewuZpu9gG9wtIY64ogPF8w
        pxknsR4Lcb2Kz/kNJdY6Vw==
X-Google-Smtp-Source: ABdhPJykU1tkk71gKf6j4um/95973o5WKsvcw7cpJ6eI6Gdfq+Q9J1aBfsjMElSOlmc3YNE4Z/pMNQ==
X-Received: by 2002:a62:e516:0:b029:156:3b35:9423 with SMTP id n22-20020a62e5160000b02901563b359423mr16121769pff.19.1605583053709;
        Mon, 16 Nov 2020 19:17:33 -0800 (PST)
Received: from [10.76.131.47] ([103.7.29.7])
        by smtp.gmail.com with ESMTPSA id t26sm21393757pfl.72.2020.11.16.19.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 19:17:33 -0800 (PST)
Subject: Re: [PATCH] btrfs: remove the useless value assignment in
 block_rsv_release_bytes
To:     dsterba@suse.cz, dsterba@suse.com
References: <1605422363-14947-1-git-send-email-kaixuxia@tencent.com>
 <20201116151512.GJ6756@twin.jikos.cz>
From:   kaixuxia <xiakaixu1987@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Message-ID: <104c5965-fbbe-b306-e835-5f2bbf60aa7f@gmail.com>
Date:   Tue, 17 Nov 2020 11:17:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116151512.GJ6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/16 23:15, David Sterba wrote:
> On Sun, Nov 15, 2020 at 02:39:23PM +0800, xiakaixu1987@gmail.com wrote:
>> From: Kaixu Xia <kaixuxia@tencent.com>
>>
>> The variable qgroup_to_release is overwritten by the following if/else
>> statement before it is used, so this assignment is useless. Remove it.
> 
> Again this lacks explanation why removing it is correct.
> 
Actually this assignment is redundant because the variable qgroup_to_release
has been overwritten before it is used. The logic like this,

 static u64 block_rsv_release_bytes(...)
 {
 ...
        if (num_bytes == (u64)-1) {
                num_bytes = block_rsv->size;
                qgroup_to_release = block_rsv->qgroup_rsv_size;
        }   
        
	//qgroup_to_release isn't used

        if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
                qgroup_to_release = block_rsv->qgroup_rsv_reserved -
                                    block_rsv->qgroup_rsv_size;
                block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
        } else {
                qgroup_to_release = 0;
        }//qgroup_to_release is overwritten    
 ...
 }

Thanks,
Kaixu

-- 
kaixuxia
