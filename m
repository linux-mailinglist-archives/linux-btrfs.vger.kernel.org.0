Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25741A4A4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 21:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJTUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 15:20:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40306 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgDJTUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 15:20:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id z15so3190966qki.7
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Apr 2020 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LqaN+FPpD6fYC7ClRQVmI0nj9rflZnxunpT+JdECzMU=;
        b=VYkcUPTIHBaa76A+3jgMSftV9Rxzkarc1i68xDiuxhDha9QRoK/hmkNp9HF2+XjpGc
         UiNQDgYdw7Qx6nYlkknYxzEesZPRdNAEaXmGIE+yrd/s8U0fvVC/l/fGH0F7GSk89x/5
         JCQXJIQ78eZcT/ooDSA1pM4zflF2cL+n7kD1jq8AsGateums0b51/9p+Sqpuz49bqHKJ
         ADdfz35S2DU9VCHB+2efKfJz69AyxMJMxvm7ifw2tM8bFwB2gxRZVAC+L/QVovKPqJtK
         EEBBhKrF/lDpN7T4BXSkTFOMLP73i5vvHvIKoVbq11o9u690UMrBOfzOZGMqSZFOZLIo
         /8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LqaN+FPpD6fYC7ClRQVmI0nj9rflZnxunpT+JdECzMU=;
        b=W3EiJYNcW3VbCEsWJeGlPN1MVRDxFKxgQeo0lGgAYQsf35QIuAUiHQZmHvGcakJf6g
         ChYwAuQkEwgJMc7Qj30QGlnitjwg4FfvL2oU6m+D833RR4Q0JPAf858XoXroLBI9+C3O
         T2XVkmqZWtOTtCqEqvxkpLKmveAYnMUf0bGNPn5dnRIv0q0SCtTjX5zTNKeYimwJxEys
         cXkVWNOa+5iCUwI8RvP67Ool7QS47Yg9+N6K0OeMjapFZqUpGTHmoQ7Ulu4c7nsPST8e
         GfxCNmH7Y0g9I6JBOoCq5SCWnRQRwfkkzqOn2sJxrLoRgOm4g/uUaeU3BoltW41uMML2
         poDw==
X-Gm-Message-State: AGi0PubMQPMcm+HbSufj/e3OJ+JE7aWiQyqzDydP61HTAw/dmQ18dljA
        ShSITOzG6NeKykAQA4FbLA31SNKTe5ji8A==
X-Google-Smtp-Source: APiQypLzhFsWAwxXMioe4IB9ntALVh9gmJSmGByFKRd8memFTd/aQL0Zx1scvaP1I5FD4zx/igPEbQ==
X-Received: by 2002:a05:620a:7eb:: with SMTP id k11mr5457294qkk.282.1586546410349;
        Fri, 10 Apr 2020 12:20:10 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d23sm2214538qtj.9.2020.04.10.12.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:20:09 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Move on-disk structure definition to btrfs_tree.h
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200407084442.46195-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a36d767a-0e8c-6997-64dd-44b26c1a4299@toxicpanda.com>
Date:   Fri, 10 Apr 2020 15:20:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407084442.46195-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/7/20 4:44 AM, Qu Wenruo wrote:
> These structures all are on-disk format. Move them to btrfs_tree.h
> 
> This move includes:
> - btrfs magic
>    It's a surprise that it's not even definied in btrfs_tree.h
> 
> - tree block max level
>    Move it before btrfs_header definition.
> 
> - tree block backref revision
> - btrfs_header structure
> - btrfs_root_backup structure
> - btrfs_super_block structure
> - BTRFS_FEATURE_* flags
> 
> - btrfs_item structure
> - btrfs_leaf structure
> - btrfs_key_ptr structure
> - btrfs_node structure
> 
> - BTRFS_INODE_* flags
>    Move them before btrfs_inode_item definition.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
