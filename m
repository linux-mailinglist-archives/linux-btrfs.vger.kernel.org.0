Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834B3155BF2
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 17:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgBGQhy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 11:37:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36491 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgBGQhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 11:37:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id w25so2817601qki.3
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pj6UJmPldX53HlyNDKNWBbmOyUeZrojZF8OmdcjIRdM=;
        b=TeA9Ugz6Cb/idw6lwDt+di36up6eGwtIjt6Kwez8QS6bpKZY8u9iem4/TSHv5aNjNg
         0ef5K66G/hphqy7ZLYJ0WEmglUjM2HWZDjhLkQkbtM+Sa1dndJzssMiqDCchznv2EBzT
         wEjnHvwp8shSY2OGyRf2k23dGZg4tJ9pSsxTxzfOJTX36Ephkgc5ko/HMTgSOgHNQDMU
         Y/bXnS5+jVkBTzQMGsDxWEetx/PX4qw0X116bTqUhnAEHILM74tvQUidIu/2NOiRemrx
         5xb72ihkqyVTniBRrXmOFdq1HzVvT/pnpXc7bOhYTCMUOFN9r/QxMT5ixHg2XTDp/0FF
         nN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pj6UJmPldX53HlyNDKNWBbmOyUeZrojZF8OmdcjIRdM=;
        b=Xy7Ac1GHALm/Yd9dmsEr2kMjEcenqRzontyraOwk8RH2encPuFcgemmj0gybQDnrSK
         4OEZPTdxj9mktIpLivS7yA9M5onTodMd6g5UXWs/skTrXxkalmJIVj8cV7O8/cJx6u1o
         2aeN4/sNCzYFsPCGlxOCDkjyliN5VAzxV79QCWvySmzG83DA6jpifRX9jbvwY6h62Lqv
         CCblcr076wBStuefEWPfgTHsTofOAJHIyiV2JYUF3DxnGcrbsrpF1luwkY5Ks5dq24tc
         2NRp08FsJW/nflXyJzf/2cfzXGLYDthAmu0KY3NwjwuYC2c3tfVyUm2CgNFD/ARzAGOr
         mHKA==
X-Gm-Message-State: APjAAAU3A/FMcjAkHjAkxbZHkiv8T6uCD4W+HIEzyZzwGiXTfj+jGRw2
        hJd8RvQS7bKY+gMmPTxiE1orPE7CXoA=
X-Google-Smtp-Source: APXvYqyMN7gh0mP+QBw8EN/kGUMzXXm2jLpiLodKwLDSwrlBgaNOGEakE1fXwX5aT5+eH+TpypIivA==
X-Received: by 2002:a05:620a:9d7:: with SMTP id y23mr2113752qky.5.1581093472523;
        Fri, 07 Feb 2020 08:37:52 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p135sm1565478qke.2.2020.02.07.08.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:37:51 -0800 (PST)
Subject: Re: [PATCH 3/4] btrfs: backref, only search backref entries from
 leaves of the same root
To:     ethanwu <ethanwu@synology.com>, linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-4-ethanwu@synology.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ceb594f1-7d07-b48a-30e5-7ea199029505@toxicpanda.com>
Date:   Fri, 7 Feb 2020 11:37:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207093818.23710-4-ethanwu@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/20 4:38 AM, ethanwu wrote:
> We could have some nodes/leaves in subvolume whose owner are not the
> that subvolume. In this way, when we resolve normal backrefs of that
> subvolume, we should avoid collecting those references from these blocks.
> 
> Signed-off-by: ethanwu <ethanwu@synology.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
