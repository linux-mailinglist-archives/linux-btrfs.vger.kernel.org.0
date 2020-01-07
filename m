Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1E132987
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 16:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgAGPDQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 10:03:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42378 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgAGPDQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 10:03:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so45488766qtq.9
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=h7Y0+smBHQrAGa/64Z5jgOR5ji6AUKne0dqY0KZD7/4=;
        b=OgGw0cf3cpaJxjn4GEyod0aFIGI9WmSZz8sjqrqxmdacUyw7jsTfXtokwV7s7sXrMS
         vKO2H6wpzAqc/sCGA6Z4mLRBk8WAnxaUzChp9GElwYJ3RaQ123hzqvoOMX+lv4D1AUkW
         Y0vo3+VrM6mWrHAfK77TvOMXKUxslm5YMGYzi0V093Ubw1qjbXkKMip7YeIIyT4kmYE2
         D+Yn+b8QCDBUrl6MjR5FxOUO0himpG6iqiFVs7Gg80+sK43lPn+uJDJsesbdYrJRPvg+
         1IPPyrMllV/tUfxWX/dl5q7CwwLU5LgLJDfUw5qFqowwWc0XvuLRfdrKL9vG5Ly2KSIb
         jJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h7Y0+smBHQrAGa/64Z5jgOR5ji6AUKne0dqY0KZD7/4=;
        b=TUq1pkL8DZKn1F2H7kq4q6B/TlThcrAvYmq/Oa5lt2ij9UqdFDl2Yx5SoJAqc/L4C4
         TNkNx/JPPx6Qnrk3pZZf0A+IDG8d1jd1/l7GmuhjgSW16qrIpUVDXN4CHpBdnXt25rWr
         yYtuy36acl0WCFRdOg7ge7Ai4aoBV9UpjUoyMp/V6Aj+TBh9o95RCyOQR12SsqZE0lsC
         9qMaWvu/3UtNSwD0QKYykeESBG3c2YPK8Qf/17LsqJgC5D0vFJWWIC71OIwiaYD5MTQA
         O1pSPK0/LAs1VRqX5xe6dzzuTylaXFgXbuiR8Vq59yxchBpJIGY4yiokiKTqvA1ch4yA
         adLQ==
X-Gm-Message-State: APjAAAXZaPUB39k7IAnD59RVutraeLv2Z2HNzcblu2HpsfMMtqnt/vAt
        KhXggEydZcuq2YDxwY7mtLSJdnXh58SoMw==
X-Google-Smtp-Source: APXvYqzWkasSSMLn7cD1kj3OO0549IqHAYhJY/LekQjC1s3uje5McGWFqKByz5HyTso41jXcwvJiEA==
X-Received: by 2002:ac8:42d7:: with SMTP id g23mr64917194qtm.206.1578409394974;
        Tue, 07 Jan 2020 07:03:14 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::5354])
        by smtp.gmail.com with ESMTPSA id g52sm22756238qta.58.2020.01.07.07.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 07:03:14 -0800 (PST)
Subject: Re: [PATCH v2 2/2] btrfs: sysfs, add read_policy attribute
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <a3e99d85-80c5-5ad3-cda3-75834e1f7441@toxicpanda.com>
 <1578372741-21586-1-git-send-email-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a297d01f-8270-423f-c210-8d50c169ba2d@toxicpanda.com>
Date:   Tue, 7 Jan 2020 10:03:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578372741-21586-1-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/6/20 11:52 PM, Anand Jain wrote:
> Add
> 
>   /sys/fs/btrfs/UUID/read_policy
> 
> attribute so that the read policy for the raid1 and raid10 chunks can be
> tuned.
> 
> When this attribute is read, it shall show all available policies, and
> the active policy is with in [ ], read_policy attribute can be written
> using one of the items showed in the read.
> 
> For example:
> cat /sys/fs/btrfs/UUID/read_policy
> [by_pid]
> echo by_pid > /sys/fs/btrfs/UUID/read_policy
> echo -n by_pid > /sys/fs/btrfs/UUID/read_policy
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
