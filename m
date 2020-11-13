Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414A52B2599
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 21:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKMUfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 15:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMUfD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 15:35:03 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E1C0617A6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:35:01 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so7706496qtp.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQL25hiyXOVHsnYHOBlkAVN36DF27BoewUoTSxw3Lz4=;
        b=xqkuUVL3qPCTQTzwHBt7Xa+Wt8P+faCbDERb/VSSodMdc5uEgh0zRJtlMfp9+ryH9K
         iz8F0cON1tWEigVbDhGTBXC5NwvsnBLWlmtmlXF+KVv7V5SvfW/sQlm0v2ZAOuqsIg/5
         b4mYGa4dNP6nwKpI0rA7RFs1D5QC9q27iGDBeU80yoza5wzWYCCxpGJEDLIipW1ril91
         XoC3QOFavhcLn8pGeql3sV3qcZfyERWpCxOZUd2n7mmENg6BntjvY2YJ0LYn8iThuBWT
         O2q3IW7o3NT7vDszgeIJFOPgQOXiYxA/PT6w2znE/c/COvMML8WHqH00lTPrzC+7Bf4G
         1qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQL25hiyXOVHsnYHOBlkAVN36DF27BoewUoTSxw3Lz4=;
        b=VZMlXuJ1PXq58ZHmU0Idetd+CZp/aa/8ovHYAH3YBeeMt8sw1FyNLS0xupTH1ox6nd
         cxebgSfABlTNeosXsjsjYWSxJW1yQjvp9gsWmqAAI+SbHsB//RkekKWA8FaWVORyJpHG
         no7MsIra/clz8O88s5RZ+SLkrRFST15kcbx+z5ZwHDq6Iq/hyxln+ol+48PgFtvU40q3
         ALI7T5zTE4E02/lHHiKcvCmqIMI/E9ET3aRKy1MaQ4ZQb+TKUkEUy6NK2AzaQpYM2J7b
         Ol5L72uYKY70BVFGgyqwonyrRNUMubaT/iWYAzfBZbFsRRdwDlgA1Hvq8gfFTYoPfO39
         mW0w==
X-Gm-Message-State: AOAM532QBzE9M18vU7/zHq4Oqu52J+lPcEBjPn8iw0QqWr551qtWSsw/
        ys4536tu3XH+hK46Hg1+uKCzuI9ImS8NAQ==
X-Google-Smtp-Source: ABdhPJw+LlhO31XndwVjd+MVIJU6FJFH01x0TK7l12ns8P2pzxBOKFJ2G7KNVkUgmocEc/IRx5S+lA==
X-Received: by 2002:ac8:5985:: with SMTP id e5mr3768367qte.88.1605299700642;
        Fri, 13 Nov 2020 12:35:00 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m2sm7468065qtu.62.2020.11.13.12.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:34:59 -0800 (PST)
Subject: Re: [PATCH] btrfs-progs: Sort main help menu
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
Cc:     kernel-team@fb.com
References: <e54b68968ee84f69fac0aa58db8495b99c845a82.1604103293.git.dxu@dxuuu.xyz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1a46876a-182a-a777-af60-83180ae9b9dd@toxicpanda.com>
Date:   Fri, 13 Nov 2020 15:34:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <e54b68968ee84f69fac0aa58db8495b99c845a82.1604103293.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/20 8:15 PM, Daniel Xu wrote:
> `btrfs help` is quite long and requires scrolling. For someone
> who has a vague idea of what a subcommand is called but not quite sure,
> alphabetical listing can help them find what they're looking for faster.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
