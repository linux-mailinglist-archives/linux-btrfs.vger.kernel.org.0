Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC37352AB0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 14:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhDBMgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBMgQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Apr 2021 08:36:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F98C0613E6
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Apr 2021 05:36:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so4632663wrn.4
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Apr 2021 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mMjjv0HlCIvkYhOGLhM0J6r8LRlJ/Ug2Ikf9/QuczPk=;
        b=hK4VvYGAInHmNyoZ5JiivrKVgxPhk2it1O2dE3x29fJD5X4kKCwwQAE101wJ7Q7nPy
         8HDuFruZ4e9luHQWFV4KXu43vcvW9nn3e+0JOBByW0OjmAruD37bvXwUpy5XmjT+BQ5U
         v4Vfq+C7rCn/YCtz121FMtfZ4Tky+9kWX0A6JDnegN/bPXQ463CKbVEYtc3qeF42Ao87
         w6h5IKjnirxjrG+SIHVJOd5J68IgSNsAaWiGymG9zp8IjcVSKsJ8hryDjp0HC00oX5D4
         uAWuLj3h6fh09fNgxA7ZjtjcAgAIQWiuTqks6XADafKMZpqqtrv7wup7cNZKecz6tX/D
         XaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mMjjv0HlCIvkYhOGLhM0J6r8LRlJ/Ug2Ikf9/QuczPk=;
        b=qGRwl88rYJZdCfVWtrAOes7omzPEpTgcbXFff4T7O/F7jvc1lPCQXtFO1ruoZfFTh5
         V9Pdyhvv0W8rS0WbUzYyudMpd59N11obyIL4x1cTax43ldA+V5Hi7Ph2WO+k5y/eLsuY
         epmW/9WbFe+4ojuL6IwW0fViDPt4AGDeykxhkHd1WMMkDdmljT+aa0x4IZ3eFz6GMc8x
         uXkCvsZp+Lk0mEE0KCPgwvTIN1O2A4GQXg5h3eHGr7GpecEvjImi6f7J9SnOGX+KpO0y
         AjAUve/1ydG3GzvuR7N5Aa8hWSjDS5gxMgc/7S7pCQktiwPcROC4Dc0rtMR3EpQAA5NT
         UshA==
X-Gm-Message-State: AOAM533fQaEcuwDYvP8GaPLEVawd2amWI2KI9yokmFbh+wqSraN2kZgf
        jLbf+3FxHITZcsuhHMY3VMOmUfh/+YA8i5aQ
X-Google-Smtp-Source: ABdhPJw3eX10nrfn9U+2LeCYOGGXor3cfAoZh5+bhnxccchhpiwQWmeenXD+xbMwozyoRlDdG9r0Mw==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr14913904wrn.65.1617366973156;
        Fri, 02 Apr 2021 05:36:13 -0700 (PDT)
Received: from [192.168.44.27] (dynamic-002-247-251-234.2.247.pool.telefonica.de. [2.247.251.234])
        by smtp.gmail.com with ESMTPSA id c2sm12346388wmr.22.2021.04.02.05.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 05:36:12 -0700 (PDT)
Subject: Re: Any ideas what this warnings are about?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com>
 <20210331015827.GV32440@hungrycats.org>
 <adbc670b-b85e-a44d-3089-089c4564f57f@gmail.com>
 <CAJCQCtSKjcDuVprCq_kjaMrwgJ1QXq=8YaU9b8hok+sqYhvqxA@mail.gmail.com>
 <ccb7cae7-08d1-4499-a1c5-9c7ccd1722da@gmail.com>
 <20210402011045.GX32440@hungrycats.org>
From:   Markus Schaaf <markuschaaf@gmail.com>
Message-ID: <f84ae2f0-103b-6d99-ec6b-70441a8770ed@gmail.com>
Date:   Fri, 2 Apr 2021 14:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210402011045.GX32440@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 02.04.21 um 03:10 schrieb Zygo Blaxell:

> flushoncommit does give better crash consistency--I've been using it
> for years for that reason.

Okay. This machine is the last I have setup, and it was my first try 
with flushoncommit. But I didn't remember, until you mentioned it. So I 
will leave it enabled and ignore these warnings. Thank you!

BR
