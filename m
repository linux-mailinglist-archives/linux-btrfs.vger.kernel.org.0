Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2630511E832
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 17:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfLMQZd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 11:25:33 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34737 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfLMQZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 11:25:33 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so1055855qvf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 08:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+tbtoQ7gZS65RurxvAssDUa7FuT8iyRBAIe3ZHERmgY=;
        b=IGRJlwjdhrIr4xZasTX8FCP3/tYlj36leE+szVNsO6cjP8imIMzpKAhlpWowukP0Wl
         ObYshxK2GFsmcYi7lS6PjJDs/B1hH1Ja0bkGQ8pXxDiCZx1v/wPcdOJhokMAiK80DmXr
         +bnKIW5JGRLEb9Wqe+gpQ3kDdcF/Li1omPvKefHGbFb/xF4SGC7k92VR1mkYaxeJ2Y/e
         IaYOGBR/CS/MNFaygXsWJxHRw6KXJuwLDtAU/hbmpFqUK2HtG5kqammJfTU+nyOWZGgq
         egQmOVg88Jm8SxLQMTVJUmUFMlLkQUZchsWPKj9z2PMD66Ee6Bx72+QYAQBsjEWzLXm7
         Zruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+tbtoQ7gZS65RurxvAssDUa7FuT8iyRBAIe3ZHERmgY=;
        b=Kp2Per6ixxwyK7VT7XRN1QFEpL8DR8S2aTi2NqTb1xsZv2MiOZ2bxnbnPVehD3NcNa
         AxpPOz+HUJydO6hbEl4YL8dZR0YGq5G66LXa4yc9aty9N7gX+20+dOrYuTMsiY4HHDiI
         l8I2vs31161BQYdT487OOmBaG6Wju5ky5wKY0pCOO1CXxPf98mrvDPWarPUAaI/voWI6
         rHLZm3IS+c/roXqVj9UrsoEZP5TyhlsUfi+ExI2pESXMwB1j4ZVfeqORfgmwZqvgkOmx
         vbDlu2Mb6AgVo/k+UuzZLQu8tmPvENoKJF9XvvyATLSE8agii8OckCZZc+PmG8rWrBJa
         nZsQ==
X-Gm-Message-State: APjAAAWLkLwMOKjeRTtGPIaRv3ipee/hjn5s4J7GPTgZRfBvwvDfjjTd
        588+jm36CZ3VrmtB3/0wEKmvQQ==
X-Google-Smtp-Source: APXvYqz6Q+nfJYcATHwx0Iq+EG08Jp9MX1mpLWz4gLPkDK0fdQ2Sq+OrCBGMcF5gDWLZ6wlxVJQH8Q==
X-Received: by 2002:a0c:9d82:: with SMTP id s2mr14040925qvd.38.1576254332680;
        Fri, 13 Dec 2019 08:25:32 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id b81sm2934140qkc.135.2019.12.13.08.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:25:32 -0800 (PST)
Subject: Re: [PATCH v6 06/28] btrfs: disallow NODATACOW in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-7-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5a099092-3bc1-3595-da3f-281780fd80f4@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:25:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-7-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> NODATACOW implies overwriting the file data on a device, which is
> impossible in sequential required zones. Disable NODATACOW globally with
> mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
