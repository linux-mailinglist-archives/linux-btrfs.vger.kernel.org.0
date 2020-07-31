Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABF0234139
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgGaI3e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgGaI3e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 04:29:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C9C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 01:29:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f7so27229329wrw.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=wZEJxoOWiR9LyfXNNvn1xmE1wNlZX0BnHNg1067lstY=;
        b=ByFB5eNriT3S49zgV6c6Py/Sdk9n3FmYrZAK8bX7wG4onbmiexLbRcJnM4Wu1LFWGe
         PF0W2oeYwsCJ/iQ9dJMTVeTYfvCW7XfV/eXUf3ATFLtEhICW0lb6l4sdPZKVaK9jIid0
         zDf7RssDeZnrICM557lrJQ/UcNU651OVGyjvd8Azz5mcSMYvKTXf3xvDFacNML+YFGrK
         CJxbri4H3MsnrS3qppSSlBEoR+UIkplIyTnrkt6gXdoxCHMuA4aQpRli+zRScZhY+VKZ
         FwwYdPBMz1cSQ6JNZB5JguZsohH8uP3EqJs5qLH0xgDWcLwCxvLe/+5vv6oqt2VBVFGx
         9flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wZEJxoOWiR9LyfXNNvn1xmE1wNlZX0BnHNg1067lstY=;
        b=kfBwkGx3JxbeCm59kLCIkIkkUamIxa5+7v3WnLM+5Bco5D4Sf1dO+cvEM1i3BaDzuG
         ps1gSe8pBZWMsou8GN8S0Clre5doRw7wws0JGj3qRLKLYS5FmODl2GzkN+RDx0Oxm4sH
         simSUHfQtBiPgdwFPZMgH2R1ydiT/SMNa88PKVLM5R7aekWQx67kIJc++40bv8Cq2GTQ
         C+QS4F+D94TOhMZo96ZfUHK9iukQrAmkX7iKEnEKDQ74Rse35/4/TNArSJ4BpZeZBOYG
         ZEl1zcC8VwHusAzhPDBu7YSiGuvM+7TLT7vJCSQmZMZf1S2N36b+bUSKAkfWJkCmBaz8
         aiCw==
X-Gm-Message-State: AOAM5306ZXlRhkN5CEXclr1iazabjEfR4D+IX8VhDWPOUyStOyrJ46Co
        YRDPAYBXEFvbe+EThGrROY6zSktZ
X-Google-Smtp-Source: ABdhPJwzm8I0LMpw7talDDCkt7YQHB6aKBqcWEZ818hYKZNoy7E5nqmnpJB/Kt32K2IsZAku6Jz/XA==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr2408715wrx.212.1596184171140;
        Fri, 31 Jul 2020 01:29:31 -0700 (PDT)
Received: from [192.168.111.113] (host-2-114-69-218.business.telecomitalia.it. [2.114.69.218])
        by smtp.gmail.com with ESMTPSA id f9sm11960274wrm.62.2020.07.31.01.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 01:29:30 -0700 (PDT)
Subject: Re: raid1 with several old drives and a big new one
To:     Eric Wong <e@80x24.org>, linux-btrfs@vger.kernel.org
References: <20200731001652.GA28434@dcvr>
From:   Alberto Bursi <bobafetthotmail@gmail.com>
Message-ID: <6d29319f-301e-c1d2-9674-b39619356ae7@gmail.com>
Date:   Fri, 31 Jul 2020 10:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731001652.GA28434@dcvr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 31/07/20 02:16, Eric Wong wrote:
> Say I have three ancient 2TB HDDs and one new 6TB HDD, is there
> a way I can ensure one raid1 copy of the data stays on the new
> 6TB HDD?
>
> I expect the 2TB HDDs to fail sooner than the 6TB HDD given
> their age (>5 years).
>
> The devid balance filter only affects data which already exists
> on the device, so that isn't suitable for this, right?
>
> Thanks in advance.


I'm not sure what is the problem, ok maybe the drives are old and are 
more likely to fail, but why would more than one drive fail at once?

-Alberto

