Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CAE703B74
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244852AbjEOSDK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbjEOSCw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 14:02:52 -0400
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5F919944
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 11:00:25 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.124])
        by smtp-18.iol.local with ESMTPA
        id ycTzp9FP3770lycTzpirHg; Mon, 15 May 2023 19:59:40 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1684173580; bh=ToFwZslsn3YWE3VLCWs0ek4ttPy6heyDqjkHVQGJWpQ=;
        h=From;
        b=t6ZAOmiOHCB6/j6DSNsioAp8wVoMnJNykAlw3yF+YGqttuMu+EiCWuIPeYIuPp9KV
         sYSJ+SpNwoLsxmwTW8O6wX+7PEk14PfDw7kZ/w3wsu5IapYuihhGRLcDAlG/nbAYLN
         S+q6c4YZTzb0rJmr+9nPYJqoeHESz+irE1e3uCWD5tGRU7jxLY6Yrk8K8kyQO7WJ3M
         cSfRSpzIesKAD/3Q3RD6I2N7cJ4fW3amaR5t/98PztdrN1MSger1ZohZL+SBXUL87A
         +kE6x4Nul39FIoIEhodfAvSwG4aNm+HBY3v/R1qsZkqn329Q2tfhfABKtdlPU7/qvr
         PVbdfJ3fQ4Oxw==
X-CNFS-Analysis: v=2.4 cv=HJIFVKhv c=1 sm=1 tr=0 ts=6462730c cx=a_exe
 a=qXvG/jU0CoArVbjQAwGUAg==:117 a=qXvG/jU0CoArVbjQAwGUAg==:17
 a=IkcTkHD0fZMA:10 a=f7z7repX5lSUaiQqpHEA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
Message-ID: <69df9067-3986-b818-bba2-868946a039e7@libero.it>
Date:   Mon, 15 May 2023 19:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC PATCH] Makefile: add library for mkfs.btrfs
Content-Language: en-US
To:     Stefano Babic <sbabic@denx.de>, linux-btrfs@vger.kernel.org
References: <20230514114930.285147-1-sbabic@denx.de>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20230514114930.285147-1-sbabic@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfI77bEeyQfesfTUtuVEFpYSAkDywmC1t5b88LjgmtDJ9HyU/oAl5ETDJy/iPh3YqlHR1JlwqVNKtcsgZpyg4wj+sshjAH7h8P2ePxOAepHZUotXUvrXA
 cYfEiG3A9vM2C4iWkG+z9Qve1/057lODSShArYus2mFxxbIle/eTtxXMN0zgW7bll7XqxQtm1Wme/apPyXeGYYOLqAb1BoPe83MaZAvXViJ1CbCcufzzkHK/
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/05/2023 13.49, Stefano Babic wrote:
> Even if mkfs.btrfs can be executed from a shell, there are conditions
> (see the reasons for the creation of libbtrfsutil) to call a function
> inside own applicatiuon code (security, better control, etc.).
> 
> Create a libmkfsbtrfs library with min_mkfs as entry point and the same

Really a minor thing; instead of libmkfsbtrfs, I think that it is better call it
libbtrfsmkfs or something like it; so all the btrfs libs are with the same prefix:

- libbtrfs
- libbtrfsutils
- libbtrfsmkfs



> syntax like mkfs.btrfs. This can be linked to applications requiring to
> create the filesystem.
> 
> Signed-off-by: Stefano Babic <sbabic@denx.de>
> ---
> 
[...]
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

