Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C861815CB84
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 20:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgBMT56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 14:57:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41865 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgBMT56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 14:57:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id j9so3588541pfa.8
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 11:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GImlpmjaPnENHyqco9Z/rAmb4YdtKlaBQH4St2s1w7E=;
        b=RMdZsuNE8NDOLfTmeJtg9scYmCTQR/TKv+Ed3hghtgyGkxYhV5HlmRfScKZIeUqujO
         C+iHPN7MjoVfXvOOXZEROu4GL/Kx/+p3YNZLgI+Xk31fvALOXOTqJhtK7slIpML+a2hK
         XJyAqAD7PGhqN6Rh9VZ6ozHuPcO6vWJ9sekgY5dW8hZI7Hr38KYh4Asm1h+kWBxGFbbi
         gTSAALc+Bi/Qr+8v0og38eUZkBznVPxezr6QHuoVE+nMogVX5+1I2crT0vptTog7fV/S
         zeICsAQqbzY7LvZ9GaPkVwakaiptpSW7TvqI48ZW34CMrLHHCA0hqNk+LdNeLWFFKsT6
         Ffhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GImlpmjaPnENHyqco9Z/rAmb4YdtKlaBQH4St2s1w7E=;
        b=ZPUKLqI6tWLgUJC6U0HfMFNlhWn1Z1ZqO3U2Q1d4CVhhNlLXVh+4BD/wuIMRaLmcAU
         +xMg3utiewFrjWTCUABCYP5tUw48Mz2QXXEdQcmsezWCIiMEXawdlclDOaTMnWTDq/qS
         14MV8uVUGtlYPdRwXdyyf0hGWysbDfc1Yt/zFFa8H//Tm4HxyQilW+aZEuBvwy2AeFmq
         LTvjtkUdObHG0toNSL3eGgh1WQS1EwTkJ/gbbQNji4m3mLgdpZZfwugVMQ8U/gqodeAd
         ldfD70KTXXjErgr78WmK+VOHquGnUmC7RGR9lWK52d7e1rXSuLU3ewAnVvUPWsOCMgcK
         2G2Q==
X-Gm-Message-State: APjAAAW3jBhyT5p9w6PQpDmQ/lmN6bx+NmqRkhbYyGkJepEabpfk2FqP
        /Nf0EG2UaR3ITtr92uQAPR1EJQ==
X-Google-Smtp-Source: APXvYqw/pQsTl4JnOfS2+0cnWo1LoIcuYji/Fw7X+EQyuUwDO3Qi7BSaNkyYyMltdQJyAxZveOC/eA==
X-Received: by 2002:a65:68ce:: with SMTP id k14mr19016576pgt.336.1581623876599;
        Thu, 13 Feb 2020 11:57:56 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id 196sm4113302pfy.86.2020.02.13.11.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:57:55 -0800 (PST)
Subject: Re: [PATCH v2 14/21] btrfs: factor out do_allocation()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-15-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cb9ebc33-213f-e57c-9ffd-d6b0a65342df@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:57:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-15-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Factor out do_allocation() from find_free_extent(). This function do an
> actual allocation in a given block group. The ffe_ctl->policy is used to
> determine the actual allocator function to use.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
