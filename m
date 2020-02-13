Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280A115CB89
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 20:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgBMT6k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 14:58:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37519 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgBMT6k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 14:58:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so2763989plz.4
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pVH+873kZpbEbaIccLjTSfs6ZyWqtMj5dnMBUQ051i8=;
        b=tSzqhQDt/v6xIszlkxG3bNJLt6zB1TSAyDXMiI5wUoOWrpbCGb5492yRGK3OldzLx4
         PxbjkhmrM/Tx2/3f6iywoIKrZJT0BSvqQ5oDxgAr1DjUNDZauLHjovYI4ZZeKXY19Hku
         u3ytEX7t+Wn54usAJXy9YX4W5JLZzcTifDXW91q75wHmhIDiz9QRHmGChw44AzRCHZ48
         uo3LFOQmQLt4JNVK87aMFnYO1YV8P4v1wq3cjvRXro794c1Rzic1Lm7Wnh2YX3Hem+Nn
         tlL0JDjmhMUwEgLa4l5OkEkEu5eyMzzlhGRJvpyXL1LhVLxKmG3D0EmL+t7ByMPkMZK4
         r65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pVH+873kZpbEbaIccLjTSfs6ZyWqtMj5dnMBUQ051i8=;
        b=I29krVL0cqJgDvpisJuPQFHtfBDnNYzyaEed9idbVuIWbxgiT8v4uCKf2Nbk5KmAF4
         zrXSNvcLLrvLkUblTDkryitcl6zVugylllJDXQzR1NJnUp5TOX2Ici81vdyyj3VXBMsw
         L84lr7b/69qLBCn/u50/23vPgmmQtloREMfVHaYRIH86aVmnAxR04v0zItP70SNi7sVa
         39H1akUMTbqAfTRfmbBcRux2lUU0jvEB61w4oVqfty5nD64VkFNE91nohXvlq1Sm5WIY
         lxB2j/BYrgCfmhZx/y0a2qoUCAOvHdOOHAPAB3CQwLbXd6T+1MNjYyVh0hOVvO7LKjmj
         O9eA==
X-Gm-Message-State: APjAAAXFzvoy7fwv8Sz4J5kGlLcQs3Xa5t39Jkk4lAoJwQfTiX41t1QR
        5pAtqhg+CddGOSolgQc53aeeYQ==
X-Google-Smtp-Source: APXvYqwUWTSiEXDjlLszbLwkr0Dr2caV+vrSZP8wXEWkrtATFjzElTuiKAOBHqvAuthuv2DOg9eeIw==
X-Received: by 2002:a17:90a:cc02:: with SMTP id b2mr6672130pju.137.1581623919971;
        Thu, 13 Feb 2020 11:58:39 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id q187sm4028157pfq.185.2020.02.13.11.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:58:39 -0800 (PST)
Subject: Re: [PATCH v2 17/21] btrfs: factor out found_extent()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-18-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d06160bc-cb90-b66e-0366-0bc9c5320fd1@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:58:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-18-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Factor out found_extent() from find_free_extent_update_loop(). This
> function is called when a proper extent is found and before returning from
> find_free_extent().  Hook functions like found_extent_clustered() should
> save information for a next allocation.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
