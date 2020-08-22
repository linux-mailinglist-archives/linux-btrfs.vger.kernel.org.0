Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8164024E73D
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Aug 2020 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgHVLs1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Aug 2020 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgHVLsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Aug 2020 07:48:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A32C061573
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Aug 2020 04:48:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u18so4135922wmc.3
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Aug 2020 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=4yJHaYpjE/wU21AzHFhuCS+5+CAMg7UJu+9ysNFIZag=;
        b=rYqPweQkMHJc2sFy3J3xfQcuCLIDyM2/orTaTPLEQujE0+sjHXwUjCPM79LOa7cM3q
         MYstzlsj/rJNqormwm/+b0IMG/gQkMUovyTllhFShiH9NA8arjyemS+v/g1MAJYpQ9dx
         VrokLOnNKU4N6g1Eg65Yktwnoe/nJOHlBYFxD2G/JgXjP5YXc3lFHm0rpTVbsGFBR6ZU
         c1h560LNIjqfTm0pMXBGjtkyA0hC+nhk/a4g49wYbEJWrqWqxLqqHs2f/Pmmt0DUUApM
         sSEGkAz5yiMdjrquhVrXR8KUA3/k2C0oVZIVvgk8mjnu6mP3q8ZJcsdfUlzIQjRfY5ul
         3LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=4yJHaYpjE/wU21AzHFhuCS+5+CAMg7UJu+9ysNFIZag=;
        b=XMmOlam2VgVa6FMbnnjad0TGP2j7Hy0LSl4J+137cYvLaL/moflobKQl2UbsV60emo
         3TlTP8qaTTWCHFPqFap1+g1Wt8tgFbaKRggf2sYvDWkQrLc+ElBTQ0nHgoHHlCohU1yk
         T9oDaYPF1maqLOT7BTv39I0BnDf1PR7deAEyDrKfAOerXTOr6+Ks2zjZckSpXQnqLyPn
         KixpE1tlQj0TDwAtnHKizn8o0deAK/H+8x6mpORmS1cIdEjo31YdO8tYbQZUmEO3FiTc
         cUHyAWlGt81vChoEXI8V6fqlgXQRiIbu69j5NfHKx0IgCayhQ91XEiWPZUtnwdObA1FW
         wySQ==
X-Gm-Message-State: AOAM533XxcT2XTtKEEV1V52fXX0KYtL3tvp2hIl2D3v9p+L+8Leg51I+
        2CtTl0MdNISLTuzo5zmOoCE6rVDhDbnRPw==
X-Google-Smtp-Source: ABdhPJycCoH7lqCQd0+OtYSgCuSy6FiWWN8Fu4AMMbcKaRWhbIzrNyZsJ3Tg6N14TUo+XhaKc8Jsng==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr7893295wma.176.1598096900281;
        Sat, 22 Aug 2020 04:48:20 -0700 (PDT)
Received: from [192.168.0.42] ([65.18.223.249])
        by smtp.googlemail.com with ESMTPSA id r11sm10391639wrw.78.2020.08.22.04.48.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 04:48:19 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   George Shuklin <george.shuklin@gmail.com>
Subject: Replacing or merging last snapshot
Message-ID: <878539b1-b8eb-f547-fb4a-9026f1d51cf7@gmail.com>
Date:   Sat, 22 Aug 2020 14:48:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I wonder if there is a way to free space if there is only one snapshot 
available. The problem is that there is a hidden top-level (id=5) 
subvolume, and there was ever switch from top-level to another subvolume 
as 'default'. If top-level subvolume have some data (not present in 
'default' snapshot), this space is wasted.

Are there way to 'merge' snapshot into top-level subvolume, or a way to 
completely remove subvolume 5 (without breaking fs)?

