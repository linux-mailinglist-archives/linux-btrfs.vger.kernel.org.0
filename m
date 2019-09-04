Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B64A83FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfIDMyR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 08:54:17 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:43208 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIDMyR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 08:54:17 -0400
Received: by mail-qt1-f170.google.com with SMTP id l22so11956706qtp.10
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=K2Yo0LRj16H2ONDkEAV5P8S8gYYBaazExzOwwvRrqrU=;
        b=PzRmGpzixbHFEMc+EFPLqbrB3YfREB5dFkpRXivYhfjGOqDN62Mkqq50KFVKpwQoZ6
         Uoa7h4vVXpTOjU6X+SuYOJsHaaQFb3Is8liALexnkDpr11rmJye37pliTmQWQF4U2gU9
         4TyOd/tgCiSiKX6zv11bV2rDMczeQBgoPB3hgE+L1zb9872pWN3HQz5kYt7qXOGp74Hk
         IrwAfsb0xQDogzlCZXetPCqjc+gFUiw8AOostAXgc68W9Pp+Vv9zqpUUEsE2nN9Na6u3
         EO+VZgvBXRRYjwg7suM/J26VL73HncEZTOGCutnRcIAchMLe6uk+QqOWZdtU984A8Dfc
         3OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K2Yo0LRj16H2ONDkEAV5P8S8gYYBaazExzOwwvRrqrU=;
        b=UmMyVODQuQUwhW6mN5N6JT4rurSkSEqnNlzu532WJOVLcxTN03NjcNQ1ldbv0VjMvM
         GpfPzpYkrEwGnZcwxoSIfazFXBvPRPceBEOva6Qm0xKUIHxIsKgIzAndKrD019iO9m8H
         9H2L8Cvg82nySyy4IRtq1WvOZ2gMLTgWp/VAVefpVCui+XSMej7CF3FmRXKhoeFQYwCA
         S70lYcKO7GeaWDx67Iq/VCj1y6uVgAuXKg4epCRSRE/A4rAdLjzIlAjcz756j5+Dkiw1
         dccVpDYhBEoc6toyi7r8cMkDQRFehkQ+ORVtiM2hkvkJY9/oRz6foWvjO3zgLeyBJWBr
         pH0Q==
X-Gm-Message-State: APjAAAWDOUfiPK5dTYthp8Zzc1wgR/1YJTOsFXCdHcrmT721W9PVn1kj
        /rl/48ht6ebV9l+lUl5whqa+qKqEGeE=
X-Google-Smtp-Source: APXvYqzh0UDgvaH/Iq9GhQWL7KmmL+UwjVKKuM0D+E3+Cn0yf8ckMMy/4QgKUICY5CikyU/0pBHAmg==
X-Received: by 2002:ac8:2d2c:: with SMTP id n41mr12575942qta.335.1567601655909;
        Wed, 04 Sep 2019 05:54:15 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id 27sm10961480qtv.96.2019.09.04.05.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 05:54:15 -0700 (PDT)
Subject: Re: crypted btrfs in a file
To:     Jorge Fernandez Monteagudo <jorgefm@cirsa.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AM6PR10MB3399F318A3BAA232A0BCAA48A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <effe8460-808b-e94f-33f5-b7a5ea4ec8f8@gmail.com>
 <AM6PR10MB33994032ED7F1C041BE060E8A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <56acd398-7730-9a5b-356c-d6c7aa63e346@gmail.com>
Date:   Wed, 4 Sep 2019 08:54:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <AM6PR10MB33994032ED7F1C041BE060E8A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-04 08:46, Jorge Fernandez Monteagudo wrote:
> Hi Austin!
>   
>> What you want here is mkfs.btrfs with the `-r` and `--shrink` options.
>>
>> So, for your specific example, replace the genisoimage command from your
>> first example with this and update the file names appropriately:
>>
>> # mkfs.btrfs -r <dir_to_put_in_the_image> --shrink btrfs.img
>>
>> Note that you don't need and shouldn't use a loop mount for the target
>> file for the `mkfs` command.  It will generate the file at the
>> appropriate size automatically (and as a general rule, `mkfs` for any
>> filesystem works just fine without a loop mount, you just need to have a
>> file of the right size for most of them).
> 
> And is there someway to generate a crypted btrfs directly or is it better to do it using cryptsetup as I'm doing in the example?

You'll have to do it like you're doing in the sample.
