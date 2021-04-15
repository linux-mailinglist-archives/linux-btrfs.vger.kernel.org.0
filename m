Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52FD361214
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 20:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhDOS0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOS0i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 14:26:38 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE89C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 11:26:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c123so21387493qke.1
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jNZe9dHUbvgqrp3bxF9JEvXCgkm+t0yET6QPylUGziA=;
        b=W35AuKGyFHgTgnLwf0u8AndjEQXeP+YJJEsGSpzK7l1uOnNBoqlSxpyu/T+ORKUkSU
         5vWSpf0J3IxqlIDSHQZVlk7T5fsQgqmsjK5Rn6oGnf4I23eeYzM5WRqXmr6dOobzqYKp
         VKC/fvUkpbcG0I/FXEWrL4I6XLfcztKw9QboCnzLXCf33+bBXcSp5MucaFe3OGr4bD8u
         p3+4Q3p1cshYoU71vAaXnJgLHfIAuVb4nN5WBr53EX/kKUlMe8J5CSeTFKKtCIdbJQQp
         kujDXEwWhp7tOx76jyAhW7k0t/emflfJEieWnw+Ba/0fkxTSoCr9jzcMge+wyie2gciM
         aX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jNZe9dHUbvgqrp3bxF9JEvXCgkm+t0yET6QPylUGziA=;
        b=CVRi9AcR8ophFJNAj5uTemsiP4C9Zd+RYP+ZAYtIEEjn+M4sBbyKkoV4ghane4xZLO
         Iu8Qq5SfMIN7BWrcjsZnkeVoDLMlQemJlif+OwbMSzQaZDr7P1ro7xmGkMeJcueggbM5
         j7h1GPagbDP35q+gpLNtvXWUubKnJlDa11YTlVV3aKdOMKb5Nubxf0D8dQY8qHaafVg+
         dWRxljXoEBUjEqUZiDn+r0+AUlVbLr3l9WDA0VfWpre+N1tPsN7J8O2P8nhcex+aRFwZ
         vX1kGHYMC89f1d99PdIIb/LTFoI5suBIDSJDop2TUsDfLRqAnnWdb2PXbfNHuf9COobZ
         aWvw==
X-Gm-Message-State: AOAM5339Yy8p/OF6KplYPiFt2sm4NOuIx49X1dzRom7KMYKVZBp3igLk
        xjIZl79ELMEBrDONFgCy2HsfO7wjs9PU2g==
X-Google-Smtp-Source: ABdhPJxiVb0c1kUdHekxtuCinQSCftad00N1EXtWZhpdd6/cINzuDTaB7JYjJPHQXdO5dqJ8ZuJ5+Q==
X-Received: by 2002:a37:70c6:: with SMTP id l189mr4840613qkc.277.1618511174645;
        Thu, 15 Apr 2021 11:26:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1288? ([2620:10d:c091:480::1:2677])
        by smtp.gmail.com with ESMTPSA id g128sm2569908qke.1.2021.04.15.11.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 11:26:13 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block
 groups
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
 <d3aec3e168a547dcc39a764f242d1df9d3489928.1618494550.git.johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <deda311b-3ab1-fa89-9700-73b2cf049be1@toxicpanda.com>
Date:   Thu, 15 Apr 2021 14:26:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <d3aec3e168a547dcc39a764f242d1df9d3489928.1618494550.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 9:58 AM, Johannes Thumshirn wrote:
> When relocating a block group the freed up space is not discarded in one
> big block, but each extent is discarded on it's own with -odisard=sync.
> 
> For a zoned filesystem we need to discard the whole block group at once,
> so btrfs_discard_extent() will translate the discard into a
> REQ_OP_ZONE_RESET operation, which then resets the device's zone.
> 
> Link: https://lore.kernel.org/linux-btrfs/459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

What would be cool is if we could disable discard per bg so we don't discard at 
all during the relocation, and then discard the whole block group no matter if 
we have zoned or not.  However not really something you need to do, just 
thinking out loud

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
