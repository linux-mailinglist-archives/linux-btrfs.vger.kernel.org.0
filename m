Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96E418BB39
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCSPgQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:36:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33297 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgCSPgO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:36:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id p6so3527868qkm.0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Lmt2nMl4tvZmVsz9SANgP2qyx6yPeAvTPIHLhdVURMY=;
        b=vr9dtjUPB5SqvK7PSzO48t4V0B7LE/vZBCmouSzGC69jgPiO5EM3O/HeukUhgvVZvn
         Cne9KB69Jb4Qk2M79qMuTqx1yxknuvjwIaIKvPEoPhM4QNbAArpEn0DDdIT1RyFVSNZj
         pXvanJt9Te8b3MBuW/nJUKN+dEGZbfPQ1VYe/NfTaTcfAWdBvICxTLhbtcWdye28AEQf
         e05mEJr/k2Zdv0+rxzAzua4erE1iPKyU8sk3PasJU++oZp1ptUK410hDLZ6+CcmU5M27
         sQzpzhIl8pka4+K5lCgh1G4VpNwkS/ZQWgmZRKq5bLDSsRHKfue5CydrGUOiPYM2Z6dm
         detQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lmt2nMl4tvZmVsz9SANgP2qyx6yPeAvTPIHLhdVURMY=;
        b=D7f74H2wEaebLFlOI1vgQpVY+FmxAUy1wN17Ekt9pLZ3noQUvcA44XLAc1ZzaaHeIz
         WUQ/VNM97XRuA1W6sQGZjK4lG9lWRxsC3tBxYuvXVz7BTd6+ikJ4oFvTT341RVw9Lzl6
         +MMXpOjEQjEpGzGE21xikhzcdYxCw6wbcb06pzI5WcyphyykuJ0VkXpf0lGmmabAOzpc
         +un/+ZF8iAgfKpygknMr5eI4DVIiFvHTAxqFA18w/E1lPGfwXbCGsPBevsn67ZuO1LLm
         lWoYC4e0nRpDp6W702ImOcAgnxUqN1Iq+k61z7woH7WLTxpi6etbJU/nueaZsRhADVkf
         I12Q==
X-Gm-Message-State: ANhLgQ2VktREaLWM8uxLWb31N1SPHuFtpMDYCRWnXIYYLe4hlxoH4p+X
        bPzxZaX7v/A/OY1AVTr/9Q7cafvFwME=
X-Google-Smtp-Source: ADFU+vtXQuacwA+zSKf+IPuRLQ0VqiH213EfQ98hBadp7SynalaqeiSkEm1sM14p/rxMXbuNdfQZqQ==
X-Received: by 2002:a37:a6c1:: with SMTP id p184mr3523743qke.338.1584632173360;
        Thu, 19 Mar 2020 08:36:13 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o81sm1768987qke.24.2020.03.19.08.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:36:12 -0700 (PDT)
Subject: Re: [PATCH RFC 09/39] btrfs: relocation: Refactor indirect tree
 backref processing into its own function
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-10-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c03bcf66-43de-37e4-dbd0-1dce9cb2b794@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:36:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-10-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> The processing of indirect tree backref (TREE_BLOCK_REF) is the most
> complex work.
> 
> We need to grab the fs root, do a tree search to locate all its parent
> nodes, linking all needed edges, and put all uncached edges to
> pending edge list.
> 
> This is definitely worthy a helper function.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
