Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052BA2744A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIVOsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIVOsY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:48:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F72C0613D0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:48:23 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q5so19286768qkc.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dgn0sm8nR69UiFf8jtySk7cGzpV3gq7JlokrBzDz9Ho=;
        b=JzvlXSUbrd2alcye/WaB/cJ2zGsFlxYW7UcHXXKAAlYzixNPpC0hntm679hPiRQNDm
         Wq/JMwVTdfNjPceg5NcZvSuhn3DkrEtZwUNQDr3doh3gHC63IqhjibK+QbOBZhVYv96T
         VkNeOAidqfP7aBb09ZsAqNDwPUSQ2Gq1oWM8uW6v3G7FOcySa7fVw6GWIjxqCUsF9Z1k
         OloZE3gY9UBhWD/fpKD7Cue6r+jbmva3mWmJWpSr4BOSb1ShGjntruNBpok8je3dA+Dq
         jrcvJfelbHs/NppPwV0wx4UE87eReO1t5Gs7G6994C0rNLf8UTjfIriHa6iXf2KWYpbB
         RTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dgn0sm8nR69UiFf8jtySk7cGzpV3gq7JlokrBzDz9Ho=;
        b=olRQL+7hxRLJqyBdx1JmSQgRHuVpEZecqGfGc/TuPZg0b0bzhq8NPs358zQadn8e6i
         Ac5QC6jXHwYYybge/zcXIy1fgGIWEz/q4jv3zun6jSiTpRNsqhhFuZWQG0kC+1ywmP/s
         c5oB/uKtBq0dS8yTpGIdl97KEfxYbo5+10XGMLhJqXYBVBmcxKqF/sqrzyqCs9ztIKNn
         JrT9+vs78Q7Gn3MrIhdWcF4AkNMLEr9zebv6z1/eZMyv4c5PaB5BOinYhG8hTJPEMdwH
         i/ufsxnAEzs89j10f/NhLZBMOPo5jB5fVxvzKoiwR7G4JdSr9yeImKGwy7qivraSCyCg
         fEzA==
X-Gm-Message-State: AOAM530+YhQKiTdZNCBJ8IGUSmfLynCR8ynVAbQzvKH133KQjASiIKpZ
        kdbQlqj+GkgSApkR8TcWjrrTJBJMya1nvsHqKJM=
X-Google-Smtp-Source: ABdhPJwHIjTmZ+M7C9Dk9PHxKI+gN2SpzzNZb5l9rLws2FTxHhyvEeQfsVu+7h7XklNt3XlvOurdjg==
X-Received: by 2002:a05:620a:55d:: with SMTP id o29mr5249651qko.12.1600786102729;
        Tue, 22 Sep 2020 07:48:22 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s15sm11645443qkj.21.2020.09.22.07.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:48:20 -0700 (PDT)
Subject: Re: [PATCH 10/15] btrfs: Push inode locking and unlocking into
 buffered/direct write
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-11-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <de9e9d48-20db-f2c5-2ba1-cf277226dcb5@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:48:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-11-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Push inode locking and unlocking closer to where we perform the I/O. For
> this we need to move the write checks inside the respective functions as
> well.
> 
> pos is assigned after write checks because generic_write_check can
> modify iocb->ki_pos.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
