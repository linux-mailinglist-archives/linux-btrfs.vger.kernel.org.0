Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B8C1721C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgB0PCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 10:02:48 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:43113 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbgB0PCr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 10:02:47 -0500
Received: by mail-qk1-f169.google.com with SMTP id q18so3372261qki.10
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2020 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I9lttMKr8ZTFNgiMmrIpwfm6d5kcranG0q1JSeyg/0c=;
        b=kBeph1ZzA8w4fNpfUcE8H2RLQIW27NL1sKQz7SHnqTk0xDqzpuNSXQPG+HWYNV66nM
         U8p7CiF3jUFFwEZN7K6Yyai9XwGbK73oSHuKbAEadOZ4M1cPnU8mt8yCIeJI3UTIJ7+T
         XsKCNr8lqldfvWEl9909dS29uNtMsiPBs4MtbkS446TeKj0dSqz6P5C2L+3zWmqbuMch
         0TRJNl31BvyDIKxn+13RYwtYGqT8jCWHgtGGHAc0FS+GutGMRPxD+xJ9jD0FNZUUZDDv
         cVKSQsSJ3JopuKVcMAyO8p/ql7gc1eABxD/raZOqV9kryTnjysR7AKtUCuTvXGDcCCdY
         M+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I9lttMKr8ZTFNgiMmrIpwfm6d5kcranG0q1JSeyg/0c=;
        b=oDtiTbM3cZ8POuLRg7Syz8S2MdhLUbV8aFle8IQGCCZ0xnUhTHn59gn95y4v+3bZsx
         vGqXOAWmhBUYBSvIiuhJmNAId/q2ZHThzmTDW+MudQiHIXLv3hEgVeLGZt7uBbNwFT/x
         azqhBaghO2aa0ac9AA3ZjQvm5/2uEGTCAhw+PCZ/iEtPMcwYQ9rY/06+8ZPxCwz9oJ/4
         HsHxKcyrckmwopwvzwEz1pm6XsgORD7sJVLaY7k00dNyZt5xOqyFAsPpYxrPUHGzKpoR
         p5AJ1zUtnMW6sfWZJUKktawydZPA1uf6ZuXD0ptid1Ga1CH1Zr5jMB6CGvAFt+Ifz+Jd
         3t+A==
X-Gm-Message-State: APjAAAVZ3BjWOyH6UNT0oK2vF3BS5hT0eqJWB/MfGdEXFzVdxVCVCWPr
        EnTUFbP5lnuIZa9B1a6XRA9mC4puv2k=
X-Google-Smtp-Source: APXvYqyfFRCEx04yar9rWKomsI72agMCHCAXGraanr2+DrqYclWlJy6ujgI1dQFT9+IZztJb2Wr2vQ==
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr6168638qkg.244.1582815765077;
        Thu, 27 Feb 2020 07:02:45 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j127sm3243765qkc.36.2020.02.27.07.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 07:02:43 -0800 (PST)
Subject: Re: [bug report] btrfs: hold a ref on the root in
 btrfs_search_path_in_tree_user
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20200227134737.bq6cz7bo6jjciswe@kili.mountain>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <17def594-0e06-d0a5-6c68-ece1bc02a99b@toxicpanda.com>
Date:   Thu, 27 Feb 2020 10:02:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227134737.bq6cz7bo6jjciswe@kili.mountain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/27/20 8:47 AM, Dan Carpenter wrote:
> [ It's weird that I haven't reported before...  - dan ]
> 
> Hello Josef Bacik,
> 
> The patch d8359e551d00: "btrfs: hold a ref on the root in
> btrfs_search_path_in_tree_user" from Jan 24, 2020, leads to the
> following static checker warning:

Thanks Dan, I'll get this fixed.

Josef
