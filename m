Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60E12F9E8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 16:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgACPm5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 10:42:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38266 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgACPm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 10:42:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so34066430qki.5
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H4V2LxuI5nQJ8kOrebZjX/q6tWJkui78v7y3X/s2ymE=;
        b=jLsd5nk2uXM2OtSHSQA+fx12gAu6+ohw+XaQX7jb2CytEeKSx4Vl5sr3MOQETU+3ov
         sTsy0cT3/7iIlVuPqKmcWdn/I+/gDQQEVP1zkzmxJmeaJ0HNzHsJC6LR1Gg7DaSpYPIf
         hOWKWIVF1JBQAUck1E3JyyII+sUeDLkd1Uok8m1gZwHixuarpLnrIO6luknwudjfNxaO
         5UdlrAVp8HajMXi6Dw6oSst/ZiOVqNqXPHf6xuOQTKoreqvAbRm1H7KlpObK5xO3jVYN
         fO1or03bPhRGEm+PwW5OPRuis1UU8mr/ErTkVLIE5g5RxZJTVlekY/TxIaNfeVCcqVHh
         pvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H4V2LxuI5nQJ8kOrebZjX/q6tWJkui78v7y3X/s2ymE=;
        b=VskrIjWCfwi9F0NFf75mNkhi+Ey9syBzPQ2qFSSJtmR/9i2h9lTCefHK/b+2CrP82R
         tnP7LfgXEz/NwSsAHl6+aJz4GrQro7CpJzJNNK+iS0BwBkypmcnXrS9PgQG4ul6DkhKB
         LkxMCzvceVuHKg9zkPHiXnw3KXHEaqCxUBoKdPicLLP12ZTo4pKV7UcPYaMj8NUuykcR
         5Uw5Efo/5qLSheweiMVkmeUAMtlooesAMx92siGvdOfR7KV7hLaD6ptem6FBOtp4KGy7
         k5aYP7TihHBEfR02CxngSpv+hGXn2KB5qKlmOIyvHlwk4TAFbbwWqbfVksKI9j1TskIk
         WITg==
X-Gm-Message-State: APjAAAXu0f5ut4TvVe4//bffgpZoS0k7cQiDygIuIBZHl3Pnk7TiQmvg
        BJyZICe//xQeuuRNf98UShzXLw==
X-Google-Smtp-Source: APXvYqyPr44EMw8tW9t5JZ0aRxoyI/XhpXe47WJuWHvjsiy9ZgwmTavoahNXRyBJRAHY5IuwoV4VGw==
X-Received: by 2002:ae9:e103:: with SMTP id g3mr66147304qkm.353.1578066176041;
        Fri, 03 Jan 2020 07:42:56 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n32sm18537939qtk.66.2020.01.03.07.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 07:42:55 -0800 (PST)
Subject: Re: [PATCH] btrfs/139: require 2GB scratch dev
To:     Johannes Thumshirn <jth@kernel.org>, Eryu Guan <guaneryu@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200103112905.1078-1-jth@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e204cc04-b270-c5cc-6ab9-3d46183765aa@toxicpanda.com>
Date:   Fri, 3 Jan 2020 10:42:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103112905.1078-1-jth@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/3/20 6:29 AM, Johannes Thumshirn wrote:
> In my testing on 1GB zram devices btrfs/139 usually fails with
> ENOSPC.
> 
> Add a requirement for 2GB scratch devices (empirically measured).
> 
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
