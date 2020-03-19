Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0832418BAF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCSPVk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:21:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44841 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgCSPVk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:21:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so3370926qkc.11
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sgZzXc+fkyGS1iOY9jq5D2qifSOB5odT5Qi4UBhUYMk=;
        b=K5aW5g0vMLE2SqPW35l2OR3uTXK5YyA+s2TpqcTo84ebRGZ+/2GogkXtehn3gDk1Z0
         9KSo7lcpwLPlissbF6uGO8ftwgwcy+FTs+YFZ3HIbKUbwpqiTuB9wh1cpM8PDSq83psT
         9Flwh115aEDIVstZlVswtH/h3/H06ta8zDlraAWNXSGk7kr5IP2nq0sEBc4Ld33QNF3g
         abUYxQWB0ggpN75RtSCm73SHZmXgdZviRa5SOh2TBnnIhjLdymhWjCLu8jgPfY7cY9Us
         GZutvpez4QbVIG1Z8zol8iSW2P++l17Yvf/Z9FlC0k7EiEASt/vZw5W4r8AKnLNqrLid
         QOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sgZzXc+fkyGS1iOY9jq5D2qifSOB5odT5Qi4UBhUYMk=;
        b=HybnAFpk3cl0K9jAXPtMky8T1gq5+12YocoKt6MG2gJpartMAkY4BBFtsmtSB+adBm
         XW4F8xaSXxFQ0rrI0fvOrMe/Xq9f4BpDChUaF6rL9hRjVdPO9G1SA/es1a6WuKPKfR6j
         CX/ZvV9D4nPTBTD+EV4xiuRwiCG+8a6LxEwKsPkZBp+J92WEq/L9lTI1NJnugetDw4ql
         Q4DPlbl4fJTOPzr4o2IGnuWwH54mlOakA0WAxpFpzKN9QKcHLkq3iNv8SAUUE/Ys43mY
         wb7eJwNbBqAnOuqgyyiNYlmoyGno2DQiv8EUPlchaih2IWkRqOCoMZ3oG/SrvQlx7EVR
         icnw==
X-Gm-Message-State: ANhLgQ3xz73QxkRCUgG1z32S/GM2IsPF6fQAWsySyDBWp2fYYJjplpVM
        xBNitWAg4Xs4xm6lUsaa0lGUM+FoDy0=
X-Google-Smtp-Source: ADFU+vv+1n9qv06O5iZ3R0soBIiFZdpajmNGvmM3IgfNdpIvc0ZG3vsZK5Hw7nLBjvW4A9V6vucT5A==
X-Received: by 2002:a37:aa4c:: with SMTP id t73mr3480198qke.300.1584631297953;
        Thu, 19 Mar 2020 08:21:37 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m1sm1853400qtm.22.2020.03.19.08.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:21:37 -0700 (PDT)
Subject: Re: [PATCH RFC 06/39] btrfs: relocation: Add backref_cache::fs_info
 member
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-7-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7c242a07-396e-5313-989a-7e878da0b32e@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:21:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-7-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> Add this member so that we can grab fs_info without the help from
> reloc_control.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
