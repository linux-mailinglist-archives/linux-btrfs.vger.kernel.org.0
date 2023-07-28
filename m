Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA47767066
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 17:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjG1PWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjG1PW3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 11:22:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18893582
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 08:22:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe1ef6d290so447098e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690557747; x=1691162547;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wuxAvCxVgKdALQi622MUuUbAlSLTT8eRFQr5urdJLEo=;
        b=li5teO+Jbiagjqj5cHLAGLKZvmdoHeYuGQlkNuxkhMDlcnGo/bPDwOWNs7cDTqd2pf
         YkZY7zTyLFGi7O+HOfKVWZodcQkqZ480pUjwF4Uwdy1Nc81gjFi9+B+XNjOFQGj0j2aK
         Ir59io1fo6NDmJMCqX0qAEdZTPUXOirve5jhxvfOKJSGSFrebm5h2nLj1DbsjzCfOYUa
         uQpm9Mh/ImikyY6mkIAwLeUdIML9T6PIVWcHjxFOfEZCAAoh0lVeNLGuRb6kPWBtdFxa
         HRZh4HkC13jcPg7bCdj7tIZZrkznSMypwCKAv7oeX3qGUB8sq4hphGkfR/xlyYm/WUmB
         inTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690557747; x=1691162547;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuxAvCxVgKdALQi622MUuUbAlSLTT8eRFQr5urdJLEo=;
        b=URXxzaVebac0A9bX5OdjPXTg25cvGjodz+7PwcathpAenoMe9PpFtG0Uw7YQyL4Ko1
         xjdi9kJDAdH4jSey2fQH5KRkpY3xfRYifobDvwdtzPfPpK49QifeZoYYFMR3Cg8SqvE+
         AQz6o5WGfGkCvJ2Lf2CQ7Dxeht1NUkfn2B4jSb3JrnQD0bPVKEXZlKkxWL8+A6l5Vjnf
         A3Ou+HTdW3G99VFDiiO5YAw2wZ9bTTqOxmq3qtH8ECeGsxFpIiAuQk+NszdlWvKz7A07
         DKOt6vAlvebM3FeuMR7Jf+QR6hTEotOJsiAORLU/EeuLzEHek8w9YiPkVLtjFMFegXTa
         2vuA==
X-Gm-Message-State: ABy/qLaWJkvIhXYw598flNXVgHTCwb8UCoYKcLJn01N57OsO8NQUvnJQ
        nwpMKiOoqhWlHrsil7NYXoXP7d1s/QA=
X-Google-Smtp-Source: APBJJlHXfB3buMQ2lu4+PGYAK0Q9LiLBPJ/wshQ4w6S+NoESodd8Y6kCwc8KTupqL6D7KLN208RoTQ==
X-Received: by 2002:ac2:44ba:0:b0:4fd:cbd8:17d5 with SMTP id c26-20020ac244ba000000b004fdcbd817d5mr1414813lfm.4.1690557746817;
        Fri, 28 Jul 2023 08:22:26 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:2474:b66c:bdcf:94f1:a4a3? ([2a00:1370:8180:2474:b66c:bdcf:94f1:a4a3])
        by smtp.gmail.com with ESMTPSA id c27-20020ac2531b000000b004fe163e5a7esm847627lfh.119.2023.07.28.08.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:22:26 -0700 (PDT)
Message-ID: <ec55663e-7655-a201-fc2c-6d64193e9fc7@gmail.com>
Date:   Fri, 28 Jul 2023 18:22:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Drives failures in irregular RAID1-Pool
Content-Language: en-US
To:     Stefan Malte Schumacher <s.schumacher@netcologne.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAA3ktqkR_hk++GpHM1oLUVto139oUOMLH92GPepQMA4M7-wdYQ@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAA3ktqkR_hk++GpHM1oLUVto139oUOMLH92GPepQMA4M7-wdYQ@mail.gmail.com>
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

On 28.07.2023 16:59, Stefan Malte Schumacher wrote:
> Hello,
> 
> I recently read something about raidz and truenas, which led to me
> realizing that despite using it for years as my main file storage I
> couldn't answer the same question regarding btrfs. Here it comes:
> 
> I have a pool of harddisks of different sizes using RAID1 for Data and
> Metadata. Can the largest drive fail without causing any data loss? I
> always assumed that the data would be distributed in a way that would
> prevent data loss regardless of the drive size, but now I realize I
> have never experienced this before and should prepare for this
> scenario.
> 

RAID1 should store each data copy on a different drive, which means all 
data on a failed disk must have another copy on some other disk.

> Total devices 6 FS bytes used 27.72TiB
> devid    7 size 9.10TiB used 6.89TiB path /dev/sdb
> devid    8 size 16.37TiB used 14.15TiB path /dev/sdf
> devid    9 size 9.10TiB used 6.90TiB path /dev/sda
> devid   10 size 12.73TiB used 10.53TiB path /dev/sdd
> devid   11 size 12.73TiB used 10.54TiB path /dev/sde
> devid   12 size 9.10TiB used 6.90TiB path /dev/sdc
> 
> Yours sincerely
> Stefan Schumacher

