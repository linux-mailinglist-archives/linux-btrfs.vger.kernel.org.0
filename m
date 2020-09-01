Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0C9259F33
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 21:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgIATXm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732761AbgIATXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 15:23:41 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11214C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 12:23:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so2094097qkn.4
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=d+PQE4I7/r4jVyJscGQRUxeQDhDxvvMJp8H3u7d8BtE=;
        b=VvSiugMB1kjXwM4A15aNgsOl+gm7XJutJtAeTecpLeu0F2aRZ4NC449fdt8hl1YZWi
         Hv++TAesG8HPIM1aDcKCnkbKsWdzHbN2QeA3JbryBaZc5vt53Cs+VqNkVRAyfLDzSxE6
         kxO1PXC/CK7/+QyB8Va/48CaFwr8+gH6uYw7EeMIyXelAhXMbUjLVlHZqmNUHs+G4yD7
         kmWIPaurlBVBqeKX00DI9710yWx8BxdxE1/rgYZNT4CGyVd/Ts1Jius8VTeUeSUTRx74
         hZcI1CYT6BnlTkaUiParQUTPc+OwYC6ifCwyya2Xw6HbbK4ooRvIM/q7gozm4CFANYqX
         zDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+PQE4I7/r4jVyJscGQRUxeQDhDxvvMJp8H3u7d8BtE=;
        b=W9TmKNWjSSASNFWMU0uYZSMNF1n+yrwhvEMeSN27UmJYiRRhM8Yo2WZTRnKTWWJRdd
         syo65ciKjrBkNnKloHSXYDhUee62VmM8clWGURH4zF/3mNit9Fe3SpwXEQni3dNwfyk1
         nKpmjEJXwYzjCT6/XW0n6w75CYweJGHuCIVZMVugViUUz1pbDUr/SGzrTnj6r/g5c0DA
         V6eAp15aDaZYjGKLEmoTqRBdQtyKRPaC79g9aDZcP04hub4ZbsMxrhTcHJJ7R7IfxjuQ
         Oa6BkoI2NYNI6hfN6IJH7aPEMV8BsxJybpdN3TR4JJsyQHVrpDvTGjT46S7aBGr+8EHr
         aH0g==
X-Gm-Message-State: AOAM533g1D64hPJERf/KNaJWMTkF4JccWRk/xBhYKXDE0G75kEsH3FKw
        YAq690VvcPIvpBF3vhG8854Bmv+M9FFbtuVN
X-Google-Smtp-Source: ABdhPJxGnCUfu8mbWuvg24SoiRfwSqGG9mnuU8sGvE0h8vfWOkbEZe0L46czMmm7CF9NWSSiMz2hVg==
X-Received: by 2002:a37:6892:: with SMTP id d140mr3333993qkc.58.1598988219914;
        Tue, 01 Sep 2020 12:23:39 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l1sm2539858qtp.96.2020.09.01.12.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 12:23:39 -0700 (PDT)
Subject: Re: [PATCH 5/5] btrfs: improve error message in
 setup_items_for_insert
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200901144001.4265-1-nborisov@suse.com>
 <20200901144001.4265-6-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f7e0d2a8-4552-0874-0aad-78f8145d1f45@toxicpanda.com>
Date:   Tue, 1 Sep 2020 15:23:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901144001.4265-6-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/1/20 10:40 AM, Nikolay Borisov wrote:
> While at it also print the leaf content after the error.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
