Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A90146A0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 14:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAWN7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 08:59:39 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39476 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAWN7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 08:59:38 -0500
Received: by mail-qv1-f68.google.com with SMTP id y8so1502052qvk.6
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zktral+DBqiAUiKoU70GTFarHn7rQvCDl0GbUeyWntk=;
        b=aqm65+UgbJKZYkGVhUniSa0OyO/UVF5PxGZm5UlNAihS56+cNk+cR/bHyWBGoADqHD
         0TPOSC1bnEhhX6946XJKrbvxxSPoC2v529g3GoKB6ZEP8KwdJKjkIRLEvd6xUiXlh8Lf
         a4f5yhJDHGcN1JUOP2aZMewx9htizebN6Gt+KZftRdceQzoLE4+cJPmm1xU9gPAns8pq
         5AnkNOZ9t4d+bi2MucIv9o5K6rOGo57yUqno2KexN7wMu5OPcPADqLS9Ys0CmS8NaceS
         xUHL1OOaw4gUqfdRDwOcgKw+gStzgjwqsCxzICkLwrH2Ks8HDsbTNJvJh2m+eUWatoWz
         tmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zktral+DBqiAUiKoU70GTFarHn7rQvCDl0GbUeyWntk=;
        b=haLjlewytguEoZajpqHbsqXoyC2/0D3EJfaBNkC0sh3TIvA5ioLtlw6KXY8F00hEkW
         hTkkMiuCTBiqHIkrhJey9SHpRl+W/1pRDH//T5zRNOY0xrXUwCqm7v7HZNxQbC/oGiPW
         LSI7y9cue+dmwCOj1Lc2hp3f2c1Kh37GAAH/3BewbjXn8LGi6Ym/9pnabiYYbG2KA8W6
         5jQOcNSs1/aOV5uAdGKF5k2j48CAl+wvw4rLiEVx4NhNhVTe6poea0S2CN+R0DdcXfhE
         BCWtOq7WjxlcD1enqBpfnXZwIjaRFSbMWpHQPpYKmTNeGglmkwsn8plrLqX7IVqy7KhW
         VxFQ==
X-Gm-Message-State: APjAAAX3mEzA4dzWQ4pgmd3u7LUrSPrBKcwFSs7v++Kd7FANeu6f+xoY
        79Arn8m7aBGkaoQVNG1BrzsvYhZtk+2LZA==
X-Google-Smtp-Source: APXvYqzm4H7XovspzqAoiApSIx8M4cZ+HWVzHYQw1FUcHGuMHnaTlIDmK69ThScUUE/LzBislX/q5g==
X-Received: by 2002:a0c:eb42:: with SMTP id c2mr16315257qvq.241.1579787977464;
        Thu, 23 Jan 2020 05:59:37 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id k88sm947999qte.32.2020.01.23.05.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 05:59:36 -0800 (PST)
Subject: Re: [PATCH v2 3/6] btrfs: remove use of buffer_heads from superblock
 writeout
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-4-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <63781d55-5ea6-cfc2-6a9c-4b0e656dba44@toxicpanda.com>
Date:   Thu, 23 Jan 2020 08:59:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123081849.23397-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 3:18 AM, Johannes Thumshirn wrote:
> Similar to the superblock read path, change the write path to using BIOs
> and pages instead of buffer_heads. This allows us to skip over the
> buffer_head code, for writing the superblock to disk.
> 
> This is based on a patch originally authored by Nikolay Borisov.
> 
> Co-developed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
