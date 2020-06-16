Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813D01FBEEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgFPTZI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 15:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbgFPTZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 15:25:07 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C629BC06174E
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:25:07 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id r16so10092360qvm.6
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SX7NHHWcb9L/TNEuk7nPLGHoTVnDVglNtD6cDlKL/cE=;
        b=eXCI9a8nOS78jft2llIk7CmGCkKWe0m6GNQu+vxq0CsW8cE+KCK3e3QwurJ2e2AdSb
         by5xBb9Lq45e3LW0i7JCzn3/3NZ7gl0VW/BOS2A1ei8HBZzgd2rM8e/7OYGSFfHQ80Yy
         P11dl9SzQqaTTTaJScnR2szHeQu/cmH+N1WITMuyF1Og8zvZebP/NOvbDbDF9Jf81jTZ
         0n8B1/hAetF7IMYgBnrSMB58pYNtphC7oROQCqP+HV/ReQ74Dt7RuediBOna1NWm3VbX
         ee4H2i5Obtal0Fo0au/aD0HCN+Ta9vQ8D+VpGsd1+A2eOvOVYupLG6ffKFcpTn1JKLJT
         eynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SX7NHHWcb9L/TNEuk7nPLGHoTVnDVglNtD6cDlKL/cE=;
        b=fXDAYPrEc+JDHsWQH/JD5RJZu1NCZrnxgIle9uDhFwcTkOMTCjyFN40/CL4eYMMiYT
         RlzuJHF380efGqRTvJJBZUIGMeaQgyPCSIn1v4Bm4l4KBYSon+lrWYaDio4S8mvAKwiU
         ATYvOv2SqBsDW3xqJHY0ODXDz0pxkzDPOgCFF6Jc8/90roEwyiwgDTViqFuGrWP9DW2e
         NZOUtIkWXKc19zrHF6CwbV5Ez8wnUhPraDG+/UDRelK36o6nCm8RKiFveZ3sSopouFEg
         SfpGHdoXWkHPSx+sUFyhKrpPj/z/bLxWiw2opYkzpMKN8y/COiZhzykytae7Yulv4/Nh
         f6Tg==
X-Gm-Message-State: AOAM532eRXdDczmxaaCiZBUKjHk/gHDeYY/kHCPqdGBvpDONGbuHrpLJ
        VkieRlZMTvit1JoGHh1ldwA16gM44zH63A==
X-Google-Smtp-Source: ABdhPJwjJ0mAfIqLvfmHwhnmJCCBnlyMga0S+FM8EG/C5pUw0+0QC6xyrmjRJnJIvkWIN5dUeWeEvw==
X-Received: by 2002:a0c:f293:: with SMTP id k19mr4013047qvl.157.1592335506664;
        Tue, 16 Jun 2020 12:25:06 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p16sm13845404qkg.63.2020.06.16.12.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 12:25:06 -0700 (PDT)
Subject: Re: [PATCH 2/4] btrfs: detect uninitialized btrfs_root::anon_dev for
 user visible subvolumes
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d17609b5-ac29-937c-763d-fc978e3f1bad@toxicpanda.com>
Date:   Tue, 16 Jun 2020 15:25:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616021737.44617-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/15/20 10:17 PM, Qu Wenruo wrote:
> btrfs_root::anon_dev is an indicator for different subvolume namespaces.
> Thus it should always be initialized to an anonymous block device.
> 
> Add a safe net to catch such uninitialized values.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Can we handle stat->dev not having a device set?  Or will this blow up in other 
ways?  Thanks,

Josef
