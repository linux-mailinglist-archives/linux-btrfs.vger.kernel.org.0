Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A655D3DFB4E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 08:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhHDGHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 02:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhHDGHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 02:07:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E2FC0613D5
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Aug 2021 23:07:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l17so1317610ljn.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Aug 2021 23:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n3GM1WmsIpEYbzkOmqSqYvz4WAjqZe33RAJb0heONFo=;
        b=ciIBxvuGav8qnlbUL2dJGvimIOsSDo9CgMIsRC3Kcavf1Lkj4sYjf+G6dJJuJaClI0
         FLkUgVRNae0XMfbxtSF8ELYxQBEOHofOFF5OB8rAoNz+g0NkUYcUES+zUI45OEp+gbfs
         f8FSn1nKungawCT5EMPK3+19T5y2Tjmm5zD/QWhdOuux7dyS9QVBGOvxpdPZ/8R8NFOs
         H1dXlodSNCTE7FYxD7q7epX7IZXztYQX+WXYJ4zuaBs7A0Jb5MBrNHTYwsR7tdiM3FyS
         k+e+2VG8MffCbU0HVHMfi9qCVg0EZoK5akEGQswuUs+k0e22Dx1ZFOdwWCVKjpbw36LD
         gezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3GM1WmsIpEYbzkOmqSqYvz4WAjqZe33RAJb0heONFo=;
        b=dOQ+gn5ol1U6rSXwoxHirHzMjtD61ghC6JwmLXzytNBkZAKYE//T5mNTt+GWq4KX28
         JQEq9KvXEB63L+TEk6mR2qttYUsVI02YAp2lbwHDgKYR6qnsSlrrDodEX9R5UT73sft2
         ua1VNd2jZ2CEUgoG8IccfjllZ/OhNiLuZ1vGJ/omYaBeqIhIENZktBmWNeq9OQg5bt74
         /6S3OpshUP7gcLmY5wEIJhauwBAVlC9q8GZRve/16zMB337xAZnvwG6dfy+gkXewKu6w
         A1zWeLD3D6BRIBJt9PApd4uQiwzVqgKGq/qIEdohsOciHw5sIWrU/C4bP3RHl3Pd2MDW
         U1ng==
X-Gm-Message-State: AOAM533NdtO7EVq6T9559QW7anPKh+6oLYfWeRrx0urm2YpVqXZC4hEL
        c/PXvfOyKRxz+XJdW4v3sTiel7f4jjTXKg==
X-Google-Smtp-Source: ABdhPJx2dzgS9CZg8M0RHNs37JorziX7LYRmHczZnbqjCyFvVKF8VlZJk62ZIldN40XvfBQkQBP58w==
X-Received: by 2002:a2e:a288:: with SMTP id k8mr16429146lja.107.1628057252149;
        Tue, 03 Aug 2021 23:07:32 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:8c8a:31bb:abfc:e015:a7fa? ([2a00:1370:812d:8c8a:31bb:abfc:e015:a7fa])
        by smtp.gmail.com with ESMTPSA id r15sm86396ljg.16.2021.08.03.23.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 23:07:31 -0700 (PDT)
Subject: Re: Random csum errors
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        telsch <telsch@gmx.de>
Cc:     linux-btrfs@vger.kernel.org
References: <trinity-59843172-879e-4efd-9b35-bbfed0ed52c6-1627914043406@3c-app-gmx-bap64>
 <20210802233850.GO10170@hungrycats.org>
 <trinity-7b251a66-4376-4938-91f7-9fae2a72c5ef-1628016907507@3c-app-gmx-bap48>
 <20210803211649.GP10170@hungrycats.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <3f14ef82-cf1b-db1e-adc5-8faa6a29698e@gmail.com>
Date:   Wed, 4 Aug 2021 09:07:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803211649.GP10170@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04.08.2021 00:16, Zygo Blaxell wrote:
>>
>> 1 SanDisk SDSSDA120G/Firmware Version: Z22000RL
> 
> I have some of those!  I can confirm they silently corrupt data as they
> approach the end of their very short lives.  I've seen no evidence that
> the firmware is able to detect or report any errors before the drive dies,
> despite providing drives many opportunities to do so as they died.
> 

What about adding them to
https://btrfs.wiki.kernel.org/index.php/Hardware_bugs?
