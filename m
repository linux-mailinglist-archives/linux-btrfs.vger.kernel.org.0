Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4729C6DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 19:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827460AbgJ0SY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 14:24:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35553 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1827297AbgJ0SWu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 14:22:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id s39so1259044qtb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Oct 2020 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KtW27e/BnVxAtqkQ4lqzLFFqFcBu+VgIgFCmH5n1t/c=;
        b=aIGasnJzSkp8tuAOEaqMEG9nSVW9BgZ83dKprFeKtfisPXzGLATiI0bkJDqa3s5NqL
         HGqmX4zY6nIvcNI/smvX/HqVH717qauPF02pKMM+OQ2/S3EBNdNb0Jv4qFC699aKIZz5
         7SflvRod8ZrchOQ6Z9THHKX8JE3LcTtboHUXwTqvQ4o4tSbjbYhtVAOM2guRCuP5FDCF
         83CfDc8EvtaAVWgu087inOZjB6XcuvZh6Jxwo7Nkn2kx6+41Dbt5OcwuBK9XPwn1mzam
         3bXY5exdK5y7gd1YdyxiBEouVQ3IdSNQZddNXo5xFOtQohArl+Pjcn5+hvU7k90ueGMb
         5nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KtW27e/BnVxAtqkQ4lqzLFFqFcBu+VgIgFCmH5n1t/c=;
        b=kggYzZ36EgkQ0hA8Jx4AXnhGdK4GO5WHfYvIE+scM3PX/f6PIjEm4kGYftO8Qc4EVt
         yC5pPkWhCb4esqMY+aWyQ9N0GEnDmyQ+qHkwlcLrIXPOcjYgITE6JhchHtBg9rURz/Ck
         wB+bN6ggJVLMAN9e/kCNY+DfaKrIOPqfBpaPrW6zm20egxk2uduRA2zL4NxyQBXKNYjd
         590NudlbLdhF2UbZEbdD25oz0SMbV/sP43AE9r9RvA9k/2FcgUVU3zbGw6ryqZk7qw0A
         H42zYF5j9FjOdYlNbW2gcXC3fBUBJGkGV18l4yKj7PDTx4Dn1nZ1iWjfOxxR0ldzZwfL
         HAuw==
X-Gm-Message-State: AOAM532yKei+ALOHX6ZGV7gZRdbcIekNS4dpoQXDaEiNyt0MPDvV2e6V
        Y2qi1SfvnAzQBBS/AUYS+h9iW5tw9LN1yKqm
X-Google-Smtp-Source: ABdhPJx/C/YY/Zdqaxow5cEUscCp0FM4S11YOExXWi75BOJb1uw6JpWgaAfWAbfHYn4cYsx0nL28cw==
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr3367315qtv.175.1603822968976;
        Tue, 27 Oct 2020 11:22:48 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n205sm1268359qke.43.2020.10.27.11.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 11:22:47 -0700 (PDT)
Subject: Re: [PATCH RFC 4/7] btrfs: trace, add event btrfs_read_policy
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1603751876.git.anand.jain@oracle.com>
 <e6e5c40113cd3e939441ab3ece823282049a596f.1603751876.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eaf39974-65db-4a38-4342-f7dbea4d06bc@toxicpanda.com>
Date:   Tue, 27 Oct 2020 14:22:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e6e5c40113cd3e939441ab3ece823282049a596f.1603751876.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/26/20 7:55 PM, Anand Jain wrote:
> This patch adds trace event btrfs_read_policy, which is common to all the
> read policies.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/volumes.c           | 28 ++++++++++++++++++++++++++--
>   include/trace/events/btrfs.h | 20 ++++++++++++++++++++
>   2 files changed, 46 insertions(+), 2 deletions(-)

Noooooo this isn't the way we do this.  Simply make a trace class with all the 
variations, and then add individual trace events that inherit from the class 
that print out the appropriate values.  Thanks,

Josef
