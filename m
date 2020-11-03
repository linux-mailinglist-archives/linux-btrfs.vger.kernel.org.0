Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E542A48CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 15:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgKCO61 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 09:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgKCO5v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 09:57:51 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8054C0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 06:57:51 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id r7so14893214qkf.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+bZraXjlwiXWtHvYgrgXFNOGII49UuD/qUqho59g4f8=;
        b=uGsa9mbUsilURKu0n+jMxoXFkcl866kFbHvWKkVyiyIvwQTPRyE7bs2EbdYiTD+Fw6
         5BGCigSwP9ORRVdgOA/2wRvzvxDpJWHkF/2B1Vt8WY/kuIl2G+s2upPkCtZtoPnohp42
         DEoPiXiyd0wOS5AHkFEdxc5YHHefoQNpHlen4Cs+QJV1bVVaYiwN1nTwlIwsAjvSGWZW
         cuKQG5brtm8naaaKSlZoNMk0DBeTL9/yiCnWqThRFhbqw5nUDRrx6fATrGs79NZo8fLH
         oai9DSir+ndrlbnEBDqT56QXfu22VjekWh0AadG1yKLv3uSNbUUcuV0mx3ZtvmVtLR+h
         lzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bZraXjlwiXWtHvYgrgXFNOGII49UuD/qUqho59g4f8=;
        b=gWpw0YKRhe77GVC+shE/Ipx9tiLAIcKX2r6ypPzhtn7fmyEuxrpPdjbY8KQ/YB55SK
         K4eLXpI+A+Bf62tF3F7lA1QR2DEOl08WV14lPyuVX3yWjVAJgpGmIMOAYrCp2/MH1bNI
         PiKTomjukyjiVmfw8fzO1e2EJvQg0U++zVUI3nFiurZr/QiF6Scs/WqOQ5VlzAO+yRrI
         QG7OrdwoBCwlxboo7oFr6jG0FsWoZ3nJIVOF8I8ioSLv+TVKTnvS7M313B26lwtrrKpA
         UtmBW9ywrOx4w73gEYn8N6fD0c7CR62lWaWh/6kGUfig7TkctLh1HD6M3NKIs28o+cHv
         lidg==
X-Gm-Message-State: AOAM5329aTLfX5fAMX7BBpkO3rO76AT0hFcFAYCeooC49pOiukj20U0R
        TSOSjhmcbfNNdZRsxH2Kif+m/EBX+n9A98Pt
X-Google-Smtp-Source: ABdhPJyOdeOhcJKr8v0Dn6YU8ULqyTydRXk3FaZ/4hUyEoCYhg8R2MJanCDaXVKoH4zwDfEWvtpwtg==
X-Received: by 2002:a05:620a:814:: with SMTP id s20mr19958309qks.127.1604415470895;
        Tue, 03 Nov 2020 06:57:50 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h125sm10431187qkc.36.2020.11.03.06.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:57:50 -0800 (PST)
Subject: Re: [PATCH v9 22/41] btrfs: handle REQ_OP_ZONE_APPEND as writing
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <4f9bb21cb378fa0b123caf56c37c06dedccbbf1f.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a31167bd-9713-467e-884d-7c8340a592d6@toxicpanda.com>
Date:   Tue, 3 Nov 2020 09:57:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4f9bb21cb378fa0b123caf56c37c06dedccbbf1f.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> ZONED btrfs uses REQ_OP_ZONE_APPEND bios for writing to actual devices. Let
> btrfs_end_bio() and btrfs_op be aware of it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
