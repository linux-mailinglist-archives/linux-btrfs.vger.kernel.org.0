Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F89124608
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 12:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLRLpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 06:45:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46990 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLRLpr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 06:45:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so848814pll.13
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 03:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8pKrd+indvOWD897sN5LHsTEjblxoZvhwVpLXEY0feM=;
        b=AbwkWgbusIHVIObGkrgDujO39Ez5JLOfz4EbpmxMLgziPWQP28LXcuzP6CMlDan4A1
         W6m8jy6Id+9YA41vIL+WVVcUTwKUzvtqfPjXovgEx0VswpKNl2+SgxNZF24gatAsMT8p
         Em9RjuuuZRj0+YpCKe1mBn6KvtOiK3zWFqJNrXKcJo6M6CSINx48vn5WOsNv/CVxzVRp
         ORr/OqWD9TxjgNogGmBsmNV9mnswxEQsi41RO7lwnkxYk1JDk5qjQmYYm5th/2NOaKL3
         5kQ0GnDfY/aHcUzJy40hgKnqYyoEawt5bKYilH2WsMVhtotgJBHxsXOX18n/xljgMnFe
         CH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8pKrd+indvOWD897sN5LHsTEjblxoZvhwVpLXEY0feM=;
        b=Ko9UHHfYR1HaiHJSdlVQch4UcX9TCpYtPGnp+Rq59fDaAaUlACjaFz1q9jt39hLIij
         FLGz+18D9nG44blZfI2BPAJEQqjSf8VkUfIGO1BWg9ncjpKqVWZD/8dYIVOrC2kDRIgC
         WgqSYdjIaso3PK17J8nCQQ9RbJFX3vGwDToXWfJRtykNHYLWHXeuhTK1pqt8G56lsI/K
         7fmH7IRNk0PG8fplwKV7a0FNUDq9CzycHujUlYP/siZOx4uq9/cY2R/kaoLTfZ/79o3H
         QhYco2qVgGJ7bQxwjux8xiYRrgDLOj5xcC5NJVtN06188/9cy85GvtFZgjBOkrxDSWt7
         b5TA==
X-Gm-Message-State: APjAAAWGfk6smUSGs6Zn6t2NFZ3b6DhQ6BqnF/PtzpEwVInMehnmF4+6
        Ve+D9EFhs8iWw4eyRfGTLrfpIxsvSqo=
X-Google-Smtp-Source: APXvYqyQ5JJI4d5FFCBfcJOSnr3a/juI73HemtgBZwF6+WidJjIoeZfTvk792rVsrEPFho3Wqn6B/Q==
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr2305415pls.256.1576669546129;
        Wed, 18 Dec 2019 03:45:46 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id f8sm2563027pjg.28.2019.12.18.03.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 03:45:45 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 08/22] btrfs: add removal calls for sysfs debug/
To:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <1323085ba861d894c3b1259b669f84a0fc1e2d33.1576195673.git.dennis@kernel.org>
Message-ID: <3ac76c27-8511-636c-e4f8-c573403209f8@oracle.com>
Date:   Wed, 18 Dec 2019 19:45:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1323085ba861d894c3b1259b669f84a0fc1e2d33.1576195673.git.dennis@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/14/19 8:22 AM, Dennis Zhou wrote:
> We probably should call sysfs_remove_group() on debug/.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
