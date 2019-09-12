Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD1B12AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 18:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfILQVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 12:21:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43313 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILQVJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 12:21:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so24429673wrx.10
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KeULQ4vF1IDcv576d/Ip9Q1ABEeMOkzGwBPeSwKIRmw=;
        b=SX7qUDLOTpoKaMKR2CEAMg7n7ygwPUB21+8oP+KQ3i4EHECfDSDtp09+aD4uUCKZmK
         QzHWJZtC56JrSUzEvg0g1XrnoahCztJwFm9uzwPMFaK3bmN//2ttIBoVsUaB8tqUr1Kr
         qP6c/TNA/DzdUWf10jlc2FFPhE80j/yzvhUi9oD4Dqli+hpd+COc2z7nfEzK7jbRh8JV
         qIycBHWvVoFxjNYFvO5uRNFv78KUvB3eMIgzS7fwz9BkyPPUFnyroepvZS9wCHSHIk3R
         JoQEH0/VQqH6kuqO5MIIdk1fv+iLZq7FtnhebAWvnC1PRwwekOpt9E/djrmEnUKwqWpf
         8Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KeULQ4vF1IDcv576d/Ip9Q1ABEeMOkzGwBPeSwKIRmw=;
        b=ZFgqsr++wu1wLtDsenRSVANssupER1XwuOhswqljV4SZqwLRvi43pVZ+zYwMknrg90
         4Qg+xLeCjEsLoB1L2biqteU62LauWRX8Rb1zfZhl+8LEd9SietRFj6Jr8bpQ00x3qZvX
         LpY+cLj4ZTcMVSFrbhFp2vYlgo2278bqJHMzgKBe0BCO7wA8HMob86NThR6n0vTMHmvq
         Ir8l4LfZrznmZdo2buCaGb9efZWMhpqXlIddrd4WhC8qyU5aM4T5dsNh/2Qvmyogt9DS
         V1zBd2Esjt96qoMfbNyDtIO52ok3De4ryHo51QPs5/MPd5RUQCsfw9iXdFib5j70kFJN
         b91g==
X-Gm-Message-State: APjAAAXQ4v/hF5doT/pxy0R/HB9nZkkMW72aJTIRDxoBfTsGycaKqQqY
        RfuxEl2V/CP771DNwwiEhJDfy2ffKH4=
X-Google-Smtp-Source: APXvYqwMA2WRtjCHd2Ixy3OLU113bWtdEGbwUhOtABUjy8sIqjcFsuYf0C1jpTN4IKlYimHVUzZS3Q==
X-Received: by 2002:adf:de0d:: with SMTP id b13mr6419208wrm.140.1568305265700;
        Thu, 12 Sep 2019 09:21:05 -0700 (PDT)
Received: from [192.168.1.51] (ip-78-45-105-225.net.upcbroadband.cz. [78.45.105.225])
        by smtp.googlemail.com with ESMTPSA id q66sm525106wme.39.2019.09.12.09.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 09:21:04 -0700 (PDT)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
 <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
 <CAL3q7H5qNE4rizN14qmgrAwtju9KRHspKxo3S-PoTcSUvXYuew@mail.gmail.com>
 <41d5dae3587efa5c19262a230e3c459f8e14159b.camel@scientia.net>
 <2cfe8d20-43f1-ae88-0712-60bb9d6d4dc0@petaramesh.org>
From:   Zdenek Kaspar <zkaspar82@gmail.com>
Message-ID: <d92a1321-7e79-e3a9-7dd0-c82d9545b3a0@gmail.com>
Date:   Thu, 12 Sep 2019 18:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <2cfe8d20-43f1-ae88-0712-60bb9d6d4dc0@petaramesh.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/12/19 4:57 PM, Swâmi Petaramesh wrote:

> However having read that the bug is diagnosed, confirmed and fixed by
> Filipe, I seriously consider downgrading my kernel back to 5.1 on the 2
> Manjaro machines as it is rather straightforward, and maybe my Arch as
> well... Until I'm sure that the fix made it to said distro kernels.

It's included in [testing] right now...

https://git.archlinux.org/linux.git/log/?h=v5.2.14-arch2

Z.
