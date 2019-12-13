Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242BC11E837
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfLMQ0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 11:26:10 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45189 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfLMQ0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 11:26:10 -0500
Received: by mail-qv1-f66.google.com with SMTP id c2so1034862qvp.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p2zNK7Z9rXnJvkUmnHIiSiOCLYCzfIxgsp3Urt3bVZI=;
        b=DcUdjlLuAQBgFO+ON9Fwnabvk311DFrPGfnZPeqd1J5AgTGQHp4uwL49LsE9iVrAw1
         Mya1GScFM60GV7J0Sf2B7mWcJNkoYLwHSSUoqI/a0eQ0LLVrMcDxQCMrPH6e2+2e1zBn
         xyrQ7vtzjbOfioNpq7+4l3SPHJcRUGMCDY3N74/87Gs2NrLMsf0ssBqA1eRglnQF592S
         se7VgtRQAR6nQveysu0elJWSOuOmfr3jAdh+w+wbguYRr9Nq/ReL2h0V5LZ5nccTpbdh
         pFiVdNGcQ/lyFC+Wk4Q+SwzLaM6+3BN3HIcDwybzqp6lre2vofy73WM1IMZcUWxhPWcA
         +cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2zNK7Z9rXnJvkUmnHIiSiOCLYCzfIxgsp3Urt3bVZI=;
        b=e7n/uNIQeuFq+bhF87k8tS3xrSS2EDwGlHIlIguOhrMx/fc3v8ZmUnBuGNVaOA48NK
         VX6S41B4W1txEFZH3QboeH7mVeXMCaFY9TE3yH47ClFOe1P80wfX2JH+/+1ZpYqNbb0c
         UHdanTltc833KxRLFi0XQIGV7MfhNSc3Te2iBQqcHF+YVXvMuHr46uRd1vPq80OJ53BB
         +jVBoAFlo3cHjgqnecBjSLU21YSqGGcR3QNpBEVm+9okek9l3DUAoEP6cfz4RZo1Fdvt
         +EnwuArVg+7HKG7885DLFo7slk0sgHrciOrKsUC/25ZNkodiIpmuKWhYvsNwyvRg3DRr
         0kgA==
X-Gm-Message-State: APjAAAUJUa5lyND5VEsI5XQhP4SybhOi5cKYkS5gnz74NZ7TPh1A0N2D
        7haDnKDG9AZJglCtGZDERnSh2Q==
X-Google-Smtp-Source: APXvYqyPbSJgKMYYRYHBT9k14Z1sOoEKRwdNadOHhKZ4V/cQloJgSeMk5+RnXBKVkBJHfj+Yx0u79A==
X-Received: by 2002:a05:6214:13a3:: with SMTP id h3mr14329805qvz.212.1576254369514;
        Fri, 13 Dec 2019 08:26:09 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id a66sm2991493qkb.27.2019.12.13.08.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:26:08 -0800 (PST)
Subject: Re: [PATCH v6 07/28] btrfs: disable fallocate in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-8-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c0533003-8aae-1dde-6997-794263341fb8@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:26:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-8-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> fallocate() is implemented by reserving actual extent instead of
> reservations. This can result in exposing the sequential write constraint
> of host-managed zoned block devices to the application, which would break
> the POSIX semantic for the fallocated file.  To avoid this, report
> fallocate() as not supported when in HMZONED mode for now.
> 
> In the future, we may be able to implement "in-memory" fallocate() in
> HMZONED mode by utilizing space_info->bytes_may_use or so.
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
