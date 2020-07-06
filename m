Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CE62158B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgGFNmm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 09:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgGFNml (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 09:42:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50667C061755
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 06:42:41 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j80so34753636qke.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DYxC3PBGDUvnF+t4gjPg7HcT7g1+jq66w1Sz9bjPTgM=;
        b=SJB3seRQ9RPVfZruYeLlCiZP8yIQrYmfQobDtVItgwZeumSqtxdgHUzcNSukpEGbU1
         klJGSftrRpDOXTV0BdtJ7UU6M7i25ihW3MRFdSIcpQMw1xsw+mEHQFIQ2hHloBTgng/n
         ONTMBY40cAQDkFxEnC9MWp4n2HtMbet8T9WOrL2SB1ln8zCIKny8Y/pHocMCiZq/BveU
         V13rzMV9hYfEsXs8jA4WsHY89Q+eaACHKrd18pY03dawIlW9YE9NvBPnasTViJeg+59L
         VsQxCevQFPTBh2dOavafWAEktq1EK0OQw0uTC2jrD09GrmYbRdf7OZhgAN2l1wm7McZn
         D6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DYxC3PBGDUvnF+t4gjPg7HcT7g1+jq66w1Sz9bjPTgM=;
        b=oUUWQGGO4kK6xDld+/YrBjtzrm1sIItnq8H0TbkicoV7WmelCPZ0F2W9lIwRp/40j8
         nT5w/rCcrPa/93Gv4sdpuLwQFWwrdPCk5/7nXbTNF03kmUB30guX8X1yLGqLyJVJW8Xs
         aWNfdB/N0PIVEfn21kzQudl6aqv0VIz5j3UFQY+yRzhdWCj5mWB+RAoUagOkz9ddST0+
         tQmIb3w0C1KLeYT8Hfv020gApCbJmmMNU+spBC7IAFoaHQG4GjvoB7UcegY+Vxj44yAA
         Hhx2s+YFCKr8gftVDdRodxUWtX6TwhnTUG502fIiVnJKdjndgoaCP7bSHxTEOTZY/t64
         ygzA==
X-Gm-Message-State: AOAM531zbfpGDz/yXdE8oozhkm/OVOyHfLodckq+SE0Pqec8c8MOM6W4
        o2PYjy+0KW7bFcMmqnwpJeUMkj0iJmkWsA==
X-Google-Smtp-Source: ABdhPJyJnPgKDxPOxF/6v7NnEZfXOQLTuVeYJp9rkbGF3ZITPxoRRQJ+He4X1SOizL3nBANLoJcxEQ==
X-Received: by 2002:ae9:ed8e:: with SMTP id c136mr47018107qkg.374.1594042959992;
        Mon, 06 Jul 2020 06:42:39 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z60sm21103832qtc.30.2020.07.06.06.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 06:42:39 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] btrfs: qgroup: remove the ASYNC_COMMIT mechanism
 in favor of qgroup reserve retry-after-EDQUOT
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200703061902.33350-1-wqu@suse.com>
 <20200703061902.33350-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c3024175-e1d1-2d05-f3af-540e6bbd2bdf@toxicpanda.com>
Date:   Mon, 6 Jul 2020 09:42:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200703061902.33350-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/3/20 2:19 AM, Qu Wenruo wrote:
> commit a514d63882c3 ("btrfs: qgroup: Commit transaction in advance to
> reduce early EDQUOT") tries to reduce the early EDQUOT problems by
> checking the qgroup free against threshold and try to wake up commit
> kthread to free some space.
> 
> The problem of that mechanism is, it can only free qgroup per-trans
> metadata space, can't do anything to data, nor prealloc qgroup space.
> 
> Now since we have the ability to flush qgroup space, and implements
> retry-after-EDQUOT behavior, such mechanism is completely replaced.
> 
> So this patch will cleanup such mechanism in favor of
> retry-after-EDQUOT.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
