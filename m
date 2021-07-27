Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB73D832C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhG0Wme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 18:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhG0Wmd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 18:42:33 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111DAC061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 15:42:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c18so401323qke.2
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EuQy9FmoDBhP7VkeXtGebfxPuZn/XxiAgXAw1fibXY0=;
        b=UNHD9I3Y8JqvKQBW8rHd3VN8ov0La7GhTy93zV4W6X9yOVgxIw3gAVrTh4aAJH0Ogt
         HWmXEhWK5xPlXlW6odB4nz56EZqWhqmsjkkTdEZpUE64FTO/rz61/tlxRDRr9ZfmFhf4
         ItBEp95iH9yvVqYVE37QF5cPY8rd2SJeOeP8kicw5nezg8wJyC+PiBcaQfiz5Ixb4h/v
         CnF5MXJy21uPqNSfDs2T5r16qj5uNEUxl4PQWYKB72w4VJcIkrHRj/STuemXKfOnwkOA
         iLZeKYoDtpcjcryM6NIKTT36Py8GccEpMDUJAwhicV4yfmuxHyBtcgdRKxm+GxFTP3Tx
         Xrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EuQy9FmoDBhP7VkeXtGebfxPuZn/XxiAgXAw1fibXY0=;
        b=JkCR4fu5Zvz4We9E8FhIHi+VzopzrvBq/cq6bP3dDjTJ9BEMeGmLMA4vAGQa6Bb7p4
         Qw620cUyGmGmmgcO9Cz+7h8xebxkGHWCFCpdE1TLiEzlDj61prDALAV2HuBt5qqYDE59
         /GBdOJmLH42O67dNLkOUUegtJruMAXsdPUElnohkE7J2tV+BP2t7aXwBzf0E/mP74yhN
         UZyoLx0eW4YS85CT016WAVQhJ8k74hVhtq/J4oAz0AbRLjGkFbpwXhzua34VQcjFVubT
         BTa0RC0jhPWDGDgRU62fqoc7Oe2PPAdfEiKgmyGs14aj3IdQmjq04fJYlLvAYNh/5/kA
         yNuA==
X-Gm-Message-State: AOAM531oVL5k4bzc/EttZ9r74pPLPCos3OvpcjViXHXTXaFio18sg3PX
        aNDVlVfBV+NnJ8uzhOuH1B+6Ow==
X-Google-Smtp-Source: ABdhPJzJqrPSXDYt6SDOFEGG72APMvPA7i0unj6mnJ7+QibQJtouGhzaMaHK/whwbgBTC0OLqIURzQ==
X-Received: by 2002:a37:64d:: with SMTP id 74mr24758742qkg.407.1627425751145;
        Tue, 27 Jul 2021 15:42:31 -0700 (PDT)
Received: from [192.168.1.211] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h7sm2067000qto.22.2021.07.27.15.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 15:42:30 -0700 (PDT)
Subject: Re: [PATCH 1/6] btrfs: do not check for ->num_devices == 0 in
 rm_device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627414703.git.josef@toxicpanda.com>
 <00156ba3c68ac186cf4895fd9e62b50a504c550f.1627414703.git.josef@toxicpanda.com>
 <8bb67a56-b79d-abb5-2a4e-597d38a373ab@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d39dd6b1-508b-1427-cdca-32418a2b5152@toxicpanda.com>
Date:   Tue, 27 Jul 2021 18:42:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8bb67a56-b79d-abb5-2a4e-597d38a373ab@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/27/21 6:35 PM, Anand Jain wrote:
> On 28/07/2021 03:47, Josef Bacik wrote:
>> We're specifically prohibited from removing the last device in a file
>> system, so this check is meaningless and the code can be deleted.
> 
> Josef, That's not true when removing a seed device from the sprouted 
> filesystem.
> 

Yeah I'm an idiot and noticed this immediately after I hit send, you'll 
see I fixed it in v2 that I sent like an hour later.  Thanks,

Josef
