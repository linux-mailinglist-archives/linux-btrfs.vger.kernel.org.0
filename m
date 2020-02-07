Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50953155BFA
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 17:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGQjy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 11:39:54 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41689 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGQjy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 11:39:54 -0500
Received: by mail-qv1-f65.google.com with SMTP id s7so1283043qvn.8
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 08:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t2WSPhBKrsmc3cn5VDceRIHOHuiCj3vCA9+gi1Hb4pU=;
        b=QIqbGOQxIrtyjkoCjgi4o82D0Okrohhoh1LHIELkn8p8OfGrdBK+wAhbRsCRmlHl9M
         LcMuecPf82Zu+A1+2C2w4rWbAb8hoNkQDWZOtvgqdIgVQM0+UaiH2NO3N6wkLO6+ip/W
         7bFytuHQ5PQKgAxRPouTITsETkvXzyMAu48atJPMNpVvYjW2n1GoUO9gDJrr2MfBtIZa
         2bz5A0DKARllr85OOu0dABU+mjAYqooySrCvo1ekryEKfB9ZRjWkw8IyaM8OjygzDNJ8
         eDioMM/OTWj1QWiaFuaYRmcoO34SnAyKeh+NpC3fIYYlHSCLBEAPQWuK/g5WSaShJC+Y
         7UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t2WSPhBKrsmc3cn5VDceRIHOHuiCj3vCA9+gi1Hb4pU=;
        b=QVFs9meUwOQOUjlnjvkb7rTi7wRZSKH1ODxcqxwXyIztQ4BfvmW1cv1JGPY4LWgdb7
         LQJ71y0x+pNlOItvMP99Vt3dSfvHDpnIn5BRxdfeOlZqIktNQkVrkLpgoaNMGqYExw/x
         Sdu9begz1WRNUFwc5n3lz7wrrTXu5TFnIxeKyt7KExUyYdSxBqN2OOtEtInOPXxq5D3W
         wxGte32uzVURWig+/aVwWh0IRTpyifCDD5BLIIZtrlj5FsxYoNg2g7vMBU2cBDdxVk0y
         YwkxPvdg4IbDoouaAxpkyTjx2pHmMSrkzE8X+4ilSiWCVdUJ/o3QkAjgUHpsIyrvrJMs
         s9PA==
X-Gm-Message-State: APjAAAWkmK5o6BLTK++PJIFFItxl3WuteMrlayjwSobtG3XAww2DNtOm
        v9JwZXgyWkruOZQbqZvt5RuAOeGW4X0=
X-Google-Smtp-Source: APXvYqxWIZ339eaLe6lvTZYXMVYaUx6pqb7/+hnzxjH9rMm+1PSHbcFHAMk22ddtvFYiBAopdM3XTw==
X-Received: by 2002:a0c:b61c:: with SMTP id f28mr7724177qve.101.1581093592544;
        Fri, 07 Feb 2020 08:39:52 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e3sm1615292qtb.65.2020.02.07.08.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:39:51 -0800 (PST)
Subject: Re: [PATCH 4/4] btrfs: backref, use correct count to resolve normal
 data refs
To:     ethanwu <ethanwu@synology.com>, linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-5-ethanwu@synology.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4edc607a-394e-85b4-8e66-95f88b1016d5@toxicpanda.com>
Date:   Fri, 7 Feb 2020 11:39:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207093818.23710-5-ethanwu@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/20 4:38 AM, ethanwu wrote:
> With the following patches:
> btrfs: backref, only collect file extent items matching backref offset
> btrfs: backref, not adding refs from shared block when resolving normal backref
> btrfs: backref, only search backref entries from leaves of the same root
> 
> we only collect the normal data refs we want, so the imprecise
> upper bound total_refs of that EXTENT_ITEM could now be changed
> to the count of the normal backref entry we want to search.
> 
> Signed-off-by: ethanwu <ethanwu@synology.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
