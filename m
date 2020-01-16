Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4978F13DF46
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 16:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAPPw7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 10:52:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42473 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPw7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 10:52:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so19208333qtq.9
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 07:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O/okRHRHFUdnj3r3HcdZdNy0PhR3hFKYLzUbfV0nSNE=;
        b=VaJBS5MGF8WpCsT34CxFdT2urvnGe+mpVgu7akZv7OeAsDYwn6gAJr+aLMhFOdgNtL
         07LJZlNugJbXlPjNoK1tjOMIaUjqMVriyKlLpbXzRNSHegRrhYG6n912QpoZHEDUT8tj
         c3bw6bQOJpMu3ce4XizTDqaY3cWfp3qMmVm5V1Mqrk5J+KSXVEKsIrhbvZuov21BKeaH
         k6OLRi+mDnZJCP6bIXUOGULWA1E9C2GYLoBMHuJowXEe1upOWOO7e2xhEwNqRfvIVtAL
         YvHP63suos8rgCzA323WCUUpb68NMVhz4NxImU7sXHNwNIAWqDPuXYtCEuiznNbrSoI+
         A6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/okRHRHFUdnj3r3HcdZdNy0PhR3hFKYLzUbfV0nSNE=;
        b=R8YH9hpn7DAf2ce7Ma5ZjjpPKkuSJqjaWBLOha5YLQs7wviDuaj9d3dTWBwUSU6YMM
         5BtlgZJFwToVLt51RrDYYUGPbUMJtRyH5b2WRUlqn12sTO2GEnw+aD0P/dW5QbMaM4yJ
         2enr8Fcndda5Hc9rPuJGYx1V84QpczK6Y25pVnIPCw9enQxQ50MeziDyaTsdKOEhZoK5
         2qy6Sne3GFlZ6b0ik2LuBYGOpXCLFrk0Nel3AQ51p7Twx3prvWoMQ+35GOWfJuA52UEi
         Bx9LSe6ZmGKNTnLfsGM1Yd2ZLv7PnmfLCWWTpSHsKoBqsnJI7lskICy126S6bEgLhSIc
         HTIw==
X-Gm-Message-State: APjAAAVaT5Xi0Lq8l4NQPseBErtsuaDYQGaVw0G9py4V6wqS/WG7rwhD
        Xdstg0gCjiU+UjMyL0TLqvWvSg0WWtcopg==
X-Google-Smtp-Source: APXvYqzcjuKnkfL9DIbtkP2LZXy7pFDOt0kgMx6fHMRaLFCV9aCaA11xQOC+tvLIVXn051iVor3WBg==
X-Received: by 2002:ac8:2bb9:: with SMTP id m54mr3095970qtm.150.1579189978409;
        Thu, 16 Jan 2020 07:52:58 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id c184sm10192570qke.118.2020.01.16.07.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 07:52:57 -0800 (PST)
Subject: Re: [PATCH 1/5] btrfs: drop useless goto in open_fs_devices
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-2-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7fce9bfa-1e01-504c-bf26-a9ffef92277b@toxicpanda.com>
Date:   Thu, 16 Jan 2020 10:52:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191007094515.925-2-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/7/19 5:45 AM, Anand Jain wrote:
> There is no need of goto out in open_fs_devices() as there is nothing
> special done at %out:. So refactor it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
