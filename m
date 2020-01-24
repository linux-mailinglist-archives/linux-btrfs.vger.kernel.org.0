Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D841B1475AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 01:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgAXAsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 19:48:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35227 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbgAXAsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 19:48:23 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so494060qka.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 16:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y3tL1oU02zT2h5lHpiCmoDlHXg8hSyHOdYNesBA4VD0=;
        b=f8QQazGvWGiC3Y0Os7DQrlbARtNTfloLVRadObUC19zz+vlYUFevL5JG7kVAZlJTnR
         3muIN1LNZtjJTPmjgFOHQdY7BnHR2zKQoD+5uLXNRI2RZqD44tgeLZIbzN5k8xgU79Ji
         O+2Ey0muN66CmCoKs+vNHm80ws3qo5EQJ5559CMujtaWAiLiQ7TQCKqPRTWgZ/1MF6+X
         O2LcF4BzkcKUgqVwyUym1J0DQH61iualdOm9q2wXFV8fX/8LGoIUen0S9CnT/SBUWL9N
         OA9ZnGh/sne0Der7KDwMDCOIQhZ1hUCzpXbHa+MjfI+sW657SBtkf4T4TPBwTzEQ+U+7
         lkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y3tL1oU02zT2h5lHpiCmoDlHXg8hSyHOdYNesBA4VD0=;
        b=DAXDur7JYYE8RprhzaSWyabK2wQtOV+T+iWRnRJfRvu5x5qgXUBAx2zziGO7+2eQFr
         MbN3ty6QWFvxmgobrau6VfEN4QZCfkHQWCsR9iXEvWBIx1mHMhUOxJsJXcoRjpj1jfRY
         VRsNG7CEO9rP1/BSrHv8QYujA5ADSS5z2A3sTK+GkFThAWFIso6pGinDwir9inXBvzFf
         2Sb3RHILwWGYoxQA15Q523oI09BaEwa+/RY+8MPFyb5K9tq4zKchhoVwsX1QKa4pu0TD
         KHi29zGyMAo23MALvZ6+mabI6GKcQTH+FUDAwIvq9183A6RtqV0AbPqiKBHTYtDQL6tx
         in8A==
X-Gm-Message-State: APjAAAXRtzLnrnwIIrloA7LwOGm8loq5nrcOYywtvdbkcWtZM/mIByLj
        jUuN2ZuLl5aKhgkc1ObX0JWKHr7AnylUag==
X-Google-Smtp-Source: APXvYqwDTQHEaQp5eNRdOm6aqGHRtRXCtlkjoaQBEw6Bns0bxHBEGMFNoQyUX7Mv0FoWZMv8W5WQ4Q==
X-Received: by 2002:a37:6716:: with SMTP id b22mr201893qkc.109.1579826901745;
        Thu, 23 Jan 2020 16:48:21 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::a80d])
        by smtp.gmail.com with ESMTPSA id m54sm2057263qtf.67.2020.01.23.16.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 16:48:21 -0800 (PST)
Subject: Re: [PATCH 4/5] btrfs: do not account global reserve in
 can_overcommit
To:     Anand Jain <anand.jain@oracle.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20190822191904.13939-1-josef@toxicpanda.com>
 <20190822191904.13939-5-josef@toxicpanda.com>
 <8b7d11d3-3f54-d090-a1c6-cb1e67b2b4f1@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <70811c93-2933-8055-ad3c-ce874e1a703a@toxicpanda.com>
Date:   Thu, 23 Jan 2020 19:48:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8b7d11d3-3f54-d090-a1c6-cb1e67b2b4f1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 11:14 AM, Anand Jain wrote:
> 
> 
> This patch is causing regression in the test case generic/027
> and generic/275 with MKFS_OPTIONS="-n64K" on x86_64.
> 
> Both of these tests, test FS behavior at ENOSPC.
> 
> In generic/027, it fails to delete a file with ENOSPC
> 
>       +rm: cannot remove '/mnt/scratch/testdir/6/file_1598': No space left on 
> device
> 
> In generic/275, it failed to create at least 128k size file after
> deleting 256k sized file. Failure may be fair taking into the cow part,
> but any idea why it could be successful before this patch?
> 
>      +du: cannot access '/mnt/scratch/tmp1': No such file or directory
>      +stat: cannot stat '/mnt/scratch/tmp1': No such file or directory
> 
> These fail on misc-next as well.

I spot checked this and it appears because before we just weren't getting as 
full before, and now we are.

These failures are the next thing on my list, I'll likely have them fixed early 
next week.  Thanks,

Josef
