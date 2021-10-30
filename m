Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD10E44092B
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhJ3Nku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Oct 2021 09:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhJ3Nkt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 09:40:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE53C061570
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 06:38:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id l13so26766547lfg.6
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=J+VQVFWXmPGZ7NCt3mYyjhsr/niKmCTz4NsGpE180AE=;
        b=k9zy8tPZt9lHVJtLHON39+2PUwwm+zXe6YnBe7GSCYGy8XMEoBzmzqDd1O4bRPbOz6
         /kwv3uPdn5skwf2qGORhufnqjyPOb1dpU7q092T6w6IgpC5Nv56JSfzyMU7voNZAIpVq
         g0CCvossOxf4RwBF76IhnLaU5AhVs0iFGTB/Zi5pn9DyvAg+LKGwU8LZiHXH5+CUiDA4
         GBSBzCbhzEYZ1HMPTd2BSW/i0H4BDTdy+uBQGntbowwy4SI68DLIKFJ/LR4KRLnRSISO
         uRN9NZA3Y98sjLjUIEyVI+kJSXleUGWovR2IYhV953QIoeV5B6AHiJXRxSG/yXExVbet
         qyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J+VQVFWXmPGZ7NCt3mYyjhsr/niKmCTz4NsGpE180AE=;
        b=Sh0DrGdvIr+7cc+u9o1EIdKnZqBiV7nGXpzO0Y5geZxnxCkkiSKJzmtpUwlaXmSjo2
         +ayrzXS/PfrnsRnJfkF4KhlLFkLfd08YGmg/Z9NILinUFiXWHt+zjuQEQ9X0dvI0LQcI
         V4s9cxX4udHDRqxGwiIPZtXbUFFNYQGxMAJOTGc2QVaiVKvmUoc4Jab9cN+hxymZZ1yS
         Wm/Tv94zOzOqtxYPUPJlMO9EQeXKmn8PviaNw0C5fus9nwZiwGApuQjZi2M2lYuY3jUq
         CKBHqRjKZTz7Rmx9FXgMpTbYIAj8E2un/F0QPk1ealRA4PbE4SvRUdDRrkonmVTUA25S
         gJFA==
X-Gm-Message-State: AOAM531nasgQehd/m8glEwuFlSmwjug2PEA/uyGXDSwrDL/z/bFMexvG
        Vcw9iae2RHNqvRK2Bs/GfKIcFbY+JvXeTA==
X-Google-Smtp-Source: ABdhPJxZPeqvcEL5x510lkKbRUs0fN7Bqv7VGJKCR861IkYw7ZLc9txRaIq19ns1aoyJVohuGHA9pA==
X-Received: by 2002:a05:6512:3f8b:: with SMTP id x11mr16357553lfa.536.1635601097374;
        Sat, 30 Oct 2021 06:38:17 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:2ee3:d0da:16e0:4d67:a3d0? ([2a00:1370:812d:2ee3:d0da:16e0:4d67:a3d0])
        by smtp.gmail.com with ESMTPSA id v19sm895530lfe.54.2021.10.30.06.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 06:38:17 -0700 (PDT)
Subject: Re: Btrfs failing to make incremental backups
To:     David Sardari <d@duxsco.de>, linux-btrfs@vger.kernel.org
References: <58d81c70b2c7de2faa209b56ba18143b5bfb6e2a.camel@duxsco.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <3574af93-d40d-1502-3c8b-5c71c2ee1abd@gmail.com>
Date:   Sat, 30 Oct 2021 16:38:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <58d81c70b2c7de2faa209b56ba18143b5bfb6e2a.camel@duxsco.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30.10.2021 15:49, David Sardari wrote:
> Hi *,
> 
> I have a problem doing an incremental backup with "btrfs send/receive"
> using a snapshot as parent, that has been incrementally saved on the
> destination side itself. Attached you find the problem description and
> my dmesg.log. They can also be viewed on github:
> 
> https://gist.github.com/duxsco/55b31a5e73fd2ef498f0ae96d9152f99
> 
> https://gist.github.com/duxsco/b5ee79e51f68d50240b2bc5b6a7fd82c
> 

This makes it impossible to comment on your description or logs inline.

Anyway, the usual primary suspect is duplicated received UUID. Show
"btrfs subvolume show snapshot" on both source and destination systems
for each involved snapshot.
