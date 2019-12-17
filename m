Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD6123614
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 20:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLQT4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 14:56:52 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33627 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfLQT4w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 14:56:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so8180469qto.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h+xgOYrkbJ4BY6ml9OrsMnXMWsXA6UKKNsIOK9D7wlQ=;
        b=Nk/MK2ZzXrWLiphhyNlGRzpc7Wqke/gW5jc7A1UBFpwlj9+Q28P9De7lA3yKq12mwP
         7POzemkCUWiWiYFwF4B5IHpP11bAA4mX9VV/UERxH6N43F21V51Cm943HuXisSFXb9Qp
         Qnfklp241zuYBjEtllANUjPt/eq5y20AHb8PNYGyT4h4/dyYy7B1Ft7fm6VpeS/z3yCN
         krK/zI6UXl/P290/pt2OcgY6aUIpgb8SFc1tZM2/oXWDE2ejwvuLS815+2M+CsyEy/CG
         R62dKI9HIIbKLn5Ol4TGbc7fOjAAJdmRpwIJ1841IT0oyHe404bJg8QM7ynIGmUtYpcD
         6Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+xgOYrkbJ4BY6ml9OrsMnXMWsXA6UKKNsIOK9D7wlQ=;
        b=VPFdCIfDNxBSafP0YfKZv2RHH6ECAvBjhV1FQEEqZZJKMu1TXzdUnpP/K9KW/kr70n
         a4lsF29SdOVdUmPX9DaEwVFuy2GIuOy/bRrqW6U+tmSN8J4vngegxlMpVHb+AQp5nN3l
         oYK4z+Il11Tp36IVJJPd6TQJ1THY8Guy50egTlL7fdCdwCJyYNXA3TFRHcVPWVPuqqwt
         UeZCzC8LGhK4f141jE5IXMsOe0S4EBNvAPXLSkYmz6yVKACKdvdpu+qkxTmdsZxzrZ81
         laSDKNacTlT4O/EwJzcO1gpoeXnaUJotNGYWQw59KWxEJN0iVN28x3OeYNfyYiewrctD
         MJXg==
X-Gm-Message-State: APjAAAUSkaGxlc04ybS7pzrjEma2TahxmFbCqkRPLkIi+ZpUF1J6INtZ
        8SgoabQnRqYuUvij5VI/bAJj2g==
X-Google-Smtp-Source: APXvYqzgzSdABrPoAehRLV20jpUGCp+P0ac1GI8NgYO3LEWzQxu74NpSHzk6OnhXj/v/30fV9yXhGg==
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr6300021qtu.2.1576612611677;
        Tue, 17 Dec 2019 11:56:51 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id f42sm8507483qta.0.2019.12.17.11.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:56:50 -0800 (PST)
Subject: Re: [PATCH v6 22/28] btrfs: disallow inode_cache in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-23-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <44cf8b1a-d5b4-dfb1-7ce7-8f40818da574@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:56:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-23-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> inode_cache use pre-allocation to write its cache data. However,
> pre-allocation is completely disabled in HMZONED mode.
> 
> We can technically enable inode_cache in the same way as relocation.
> However, inode_cache is rarely used and the man page discourage using it.
> So, let's just disable it for now.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Same comment as the mixed_bg's comment

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
