Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9522DD483
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgLQPo4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 10:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgLQPoz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 10:44:55 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86478C0617A7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 07:44:15 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id a6so20367075qtw.6
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g9EWFH+I/ouYjB+mfKZXtRYsK41x5Q1m8101eMfaADw=;
        b=11QVxONwZtTXzTE37dh3MD8yNfhJ2mzqQfAitOXS36RFwXOH257XmgsDzvuCHsRzAE
         VkfqZIMfUR3Ko1BY8Ga/iX5r8P6DdrA8GTkaqfsrCsZaSlNN2YPlR3jA6sGY2+k//vnP
         zSp9iaOehZvmEH0rD3HZPO5FuIG2Y4ZmJiImNiLRusVDigQClFc9XuevjJSITlF+I0YL
         w2eXWGaV4begEyUirld/vS83kl6/7V3sKE0xqfXMWfl2PotrdLiT72879OJKJTTksG7+
         rMN2XN/dYz8QeM/LlAGobTj9l0TN/TOwLpRTT7SZzzZCpFpVw6EZerTANy/cGsvm0pA1
         uz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g9EWFH+I/ouYjB+mfKZXtRYsK41x5Q1m8101eMfaADw=;
        b=TwWi5lxhFS7mwoVmTHPT73epjutp/B+lqnxk8W9MfZmWnRvHp9ILH6SJrZdfSkR9jo
         y1yIKY18PyWoO3UasAp5WEU03F+m01Y/8zmOjye/BTEGdLUP1L417I08vrz4HBOM5AkL
         PppfzMddywjw+l4uKfNcST/GD33QO45yjGCTUL1iNJo5VShk7iyJSc4+VQsneGZHwP4y
         WAuEcUyxlOicjR55a6UR9J9t/kldFPxe65FildNIktERkPqQgSPCJRhYyg667CXI00r3
         ujnSgakNA0iYV1CiCITPlwwbhsqVF8ASu9uTET7pY6sTj7TR57UtDoVD1uWEn9ZsBiJA
         Pg3g==
X-Gm-Message-State: AOAM532n48jQsSK6GtxYKyOFqPYveqoBHYd6RuolTvo3O6ioMMXFH0wN
        dbKiHK5Ay80z5aaKD7pE/T65FB+hLXsvODD+
X-Google-Smtp-Source: ABdhPJzz7UCjANySATDyvdhZ0WpI+10C4WO4FnGzErNDw4l1T6WIx+MxVkoWhcTLiLfmpaSUULvuSg==
X-Received: by 2002:ac8:6c2d:: with SMTP id k13mr48346215qtu.197.1608219851369;
        Thu, 17 Dec 2020 07:44:11 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a10sm3685976qkk.52.2020.12.17.07.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:44:10 -0800 (PST)
Subject: Re: [PATCH v2 01/18] btrfs: extent_io: rename @offset parameter to
 @disk_bytenr for submit_extent_page()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <545244a9-9402-ff9b-c168-3e8408d22f5e@toxicpanda.com>
Date:   Thu, 17 Dec 2020 10:44:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/20 1:38 AM, Qu Wenruo wrote:
> The parameter @offset can't be more confusing.
> In fact that parameter is the disk bytenr for metadata/data.
> 
> Rename it to @disk_bytenr and update the comment to reduce confusion.
> 
> Since we're here, also rename all @offset passed into
> submit_extent_page() to @disk_bytenr.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
