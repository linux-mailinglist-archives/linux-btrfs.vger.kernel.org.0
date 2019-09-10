Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97267AE8E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 13:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfIJLMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 07:12:13 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:41735 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbfIJLMN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 07:12:13 -0400
Received: by mail-io1-f51.google.com with SMTP id r26so36413795ioh.8
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kjPsLKgF625fNbaLaUMa+RJmxBCztnsUhHIGFW8EYpo=;
        b=mYlvkIHvW85qRO0cXXcc+9zN9mkljv88TFU8o20WVcXHNvLINDDfdRz7BzjpstYmaH
         Agy1P0BAhptl30lrtILJ9A7ish9WiUr4zu3Lja2FXZhjcCdzHnutBy2qJjwJo4qzd5of
         wTdoo5jhrNM43c3JNQDcOTq/aUUKfJEkHdc9zLqZCDWqxG84htf/Je72TQljGgNIcEh0
         HzuqoETzSw89FQ/6jljFvpSHehikByheZ+JUOa93EMnq/KIYaVMGNNytSBB9CANNtRjO
         LO+XKU3Dlwok5cElbQeC7dCnvDk5MDgLPGt4aHFplhm/Mi0p0p/q+x2ZN2z+f12LUF3+
         X8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjPsLKgF625fNbaLaUMa+RJmxBCztnsUhHIGFW8EYpo=;
        b=AfDf4C76u4QqQMovHZSB0GMwDi04Dgq4u9JrkBW+6scgW1dUAwmdYERS3JBflw/Jql
         btc1NyB55ChOkvKcDyNHQkxmaDEW2itrWLTmItXut9AAQIB/LQWHx2T8i9XKgrVBd5HP
         m4O8F+6vMEq9Hixt/ThYmG/rrwy+q1mrphsRVUEjsQjOHhHssLQYezhpsuNB/K28VGwN
         UsIV5QOYT07rGaVPcz2NeJx3pmaYSC/jEfXyNIK6kKT1tNq8fADGPbKMEw2N9joVifMd
         bJuewJ7McjvbM0WFMRBER18WCKQC0WS8KAIzQq6o6xebbP3ELDePVq7+jm4fqWQUXLua
         6JGw==
X-Gm-Message-State: APjAAAWka649Jj0Jk0v0gq7ZwtlmyPWuU7Wfg4+OaNqjPAURU1nVUvw6
        rk4x96yTHwsMqWCKB+a/MmcxWjZg2kk=
X-Google-Smtp-Source: APXvYqw9ssPNaFgqfh65Mq37z3fo57Hf5kN/uzUoLLrDGz6Ddv/2KDV/fLqsy0PlCSF28/TalZfk8g==
X-Received: by 2002:a5e:c644:: with SMTP id s4mr30770579ioo.36.1568113930743;
        Tue, 10 Sep 2019 04:12:10 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id n12sm6136505ioo.84.2019.09.10.04.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 04:12:09 -0700 (PDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     zedlryqc@server53.web-hosting.com, linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <f9ec967a-34f2-5ffe-fdf7-fe72f2d4581d@gmail.com>
Date:   Tue, 10 Sep 2019 07:12:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-09 07:25, zedlryqc@server53.web-hosting.com wrote:
> 
> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>> 1) Full online backup (or copy, whatever you want to call it)
>>> btrfs backup <filesystem name> <partition name> [-f]
>>> - backups a btrfs filesystem given by <filesystem name> to a partition
>>> <partition name> (with all subvolumes).
>>
>> Why not just btrfs send?
>>
>> Or you want to keep the whole subvolume structures/layout?
> 
> Yes, I want to keep the whole subvolume structures/layout. I want to 
> keep everything. Usually, when I want to backup a partition, I want to 
> keep everything, and I suppose most other people have a similar idea.\
This: https://github.com/Ferroin/btrfs-subv-backup may be of interest to 
you.  It's been a while since I updated it, but it still works perfectly 
fine.

Won't exactly let you do an exact block-level backup, and it won't 
preserve reflinks, but it will let you store subvolume info in an 
otherwise 'normal' backup through tools like Borg, Bacula, or Amanda.
