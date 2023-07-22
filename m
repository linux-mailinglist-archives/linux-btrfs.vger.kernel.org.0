Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7775DA80
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 08:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGVGwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 02:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGVGwJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 02:52:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0663ABF
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 23:52:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b838dbb3d0so6722641fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690008727; x=1690613527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXvZBifavM2yA8h+COud+u1HQykxpUwFEODu38+JPQY=;
        b=EZeve8XqWAp69asQAAiNSLJMvt3mbE0azCSXvp+VCG4k6Roq+ji+T9Llk9qU6j5WaL
         1eMv+nYwVTCHkc8aUwDSfdk++mcN3MKK8AkZRm3ykXYqUavSv20iyZCkjrIt0rfCGtt2
         tVRUZ4Qdw+2LeZjJJdk63FSFxjhiOY5CODoqB94Et7TOUTvPB5yuBSAppwifVkI36h2u
         mnVEMkgzizZUd5Q+ogKo8iXSAsvHhwemxBANefxcce2RFUbtCxkuVBuFy4nKzTOtWCav
         7pDJjmtB8E49Hqtdv2kjPMlahMsIoHTcXFkp6ZfMEVNbAp3LoW0Bj/JaEUsKUI/gk+zq
         9a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690008727; x=1690613527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXvZBifavM2yA8h+COud+u1HQykxpUwFEODu38+JPQY=;
        b=XxZlBHWvrMjOrINnSgh7h29BEQXZ4GP+fIDW815byBBkvHyQ0Gxw9rmcN8aY9O7Kms
         ww6g/vP3bkfIaobIZk1cZ9UH4W5afLcJaZ340Gj/RTuawP2TOSSqJehLpwHvFi/goRR8
         b8cf0/IQDJZ2abcEAgff7xhguY4H4OuHvdfVkBkwo40/XVQl7b9B/Y/N1nEZX1fQbYsU
         4WysMu2/5R0E3JeHx2KaaUShMw4oPx71ilkGTP8VvvtKfdlGRghu9H4LuxvpdyqtRLug
         Lib8NrYxoj8nOHo083EOE74oyxznPqFm6xtS9a7XLXMzanHUPKNCwbOgLTvYw8hIaJn3
         TYjQ==
X-Gm-Message-State: ABy/qLaNXeDGOHeZ1GxNZqjb3INhJ7vZQY1TvdTibbrvWDWnp4h4yvun
        K5q7z+CjPHs3tIyKihuJ1zMyKGHIvoE=
X-Google-Smtp-Source: APBJJlFbeetP4CWOniDfMqQWpmXQ2+T22DJhax8jGJi2qU44yh6os1mygLX80tWnaaNccN5OnjDnKA==
X-Received: by 2002:a2e:a543:0:b0:2b6:af68:6803 with SMTP id e3-20020a2ea543000000b002b6af686803mr2341817ljn.4.1690008726778;
        Fri, 21 Jul 2023 23:52:06 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:2474:2a7e:740:5ff2:c783? ([2a00:1370:8180:2474:2a7e:740:5ff2:c783])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e98ca000000b002b6dc35da95sm1383440ljj.139.2023.07.21.23.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 23:52:06 -0700 (PDT)
Message-ID: <7aab044d-30de-5354-e5de-3528a9a4dce3@gmail.com>
Date:   Sat, 22 Jul 2023 09:52:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs@vger.kernel.org
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
 <9904a32c-76d7-903d-78b3-7df62c60141a@gmail.com>
 <2WO6YR.XUIBVZYBN0GJ1@ericlevy.name>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <2WO6YR.XUIBVZYBN0GJ1@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22.07.2023 09:04, Eric Levy wrote:
> 
> 
> On Sat, Jul 22 2023 at 07:34:26 AM +0300, Andrei Borzenkov
> <arvidjaar@gmail.com> wrote:
> 
>> Log with timestamps could be more useful.
> 
> I would need to generate a report showing millisecond granularity in
> order to reveal intervals not appearing as zero duration.
> 
>> Something tries to mount this filesystem before all its devices are
>> present. You need to find out what does it. btrfs is just a messenger
>> here.
> 
> The systemd mount unit is defined to start after iscsi finishes
> initializing.

"iSCSI finishes initializing" just means iscsid was started. The actual 
device discovery can take arbitrary amount of time due to network 
condition, target behavior and overall system load. So condition "iscsi 
finishes initializing" is absolutely wrong for "we can now start 
mounting remote devices".

With default btrfs udev rules systemd should wait for device required by 
mount unit to become ready; in case of btrfs all devices except the last 
discovered one will be "missing" from systemd point of view and only the 
last device should allow mount unit to start.

Provide full output of

journalctl -b --no-pager --full

immediately after boot (before doing anything else), it may give some hints.

> The idea that the kernel or filesystem layers wer causing
> problems follows from a remark given to me through a different thread
> that I opened just days ago. I have tried many different variations for
> the systemd mount unit without reaching any success for the issue.
> 

Systemd was never designed for dynamic device management when devices 
can come and go at arbitrary time and even less for multi-device 
filesystems.
