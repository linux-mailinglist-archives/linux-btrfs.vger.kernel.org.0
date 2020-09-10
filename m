Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847B1265294
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 23:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgIJVUr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731132AbgIJOZ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:25:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC27C061349
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:07:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o16so6118077qkj.10
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AV4sXubzPTyCrmuIz7/wPAfCJP7JfxWqQMhE0a2dR/g=;
        b=yccqbg82bzFu0W0YepdCd7vfj9SS3PXEICnp2MCysxaAE8N8xu1PTWzO8tGptIEN5s
         odF6qr53NTVcrFKVDqNrBZgVNdx7Iy+B/Ov/xkHKUqVl61Y02bN1MAstHAFPzz3VwIjZ
         0HURjBKqsAt1uH8wWiPANYr2zKslfxqeUw4AIPE0THH6sWHAo3rKKPM0hhYudakrJ2OV
         SlaM4J/SmFbgH8JF6kO+6RybvEo9fqPdULwkKbsQxABZYrTRodPAwE+E3QVKlPemhty/
         5YdgUuYKQ0u7DPwBkCj7tLvcVPTBWLOUvkwZ6VARsBU7gxjKq7CYf4A/8H3tKczuwBy1
         EyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AV4sXubzPTyCrmuIz7/wPAfCJP7JfxWqQMhE0a2dR/g=;
        b=B7+6qmg8eRdzmz6rPQVnY8dTghbSCHs7rrqmQmsNI7tAS9OKwVcySvsc2vlNE6pP+h
         yZ7q0HVoqVgE3vxWss2jnTXzMWIYthCHe74bvdYXkv6Z5JzuXkzyEWdhtj0iGk9NrvOj
         XWhHCwtTTXRfI77Qft+9aG6nNpxMv1vdr7dE6Ct3v/DCBIP3DBLQ8d9+l5Z0ZCHkdX+B
         YV7hs3tjtRgQQE4bh79ZZMfWv1uRUShpObdOiMy5VmxcAqGHuNbSb9fgtIAG6Gm56Jgo
         Py7teM6Rhy1IFBbsKZP/RXhNENfbgaL4eXYdneM9KmU0T0OkVqWfyLcv/m96/8zkdaq9
         7GxA==
X-Gm-Message-State: AOAM531WrZurWZoS/D/iiE79VsvLhVDdMxzx8E+YkBA8q4r0WisHFZ/s
        XKxAoUf/ETZnuY9AK47UoBScDQ==
X-Google-Smtp-Source: ABdhPJwdhQZzrUgn2So5GzqmuY12s0BZ37esF8pZLwoa8fn/VmzJw2RCRNCMS10poYmMPxyZACNJnQ==
X-Received: by 2002:a37:a887:: with SMTP id r129mr7343103qke.263.1599746873943;
        Thu, 10 Sep 2020 07:07:53 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p37sm7284399qtp.31.2020.09.10.07.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:07:53 -0700 (PDT)
Subject: Re: [PATCH 3/3] btrfs: skip space_cache v1 setup when not using it
To:     Boris Burkov <boris@bur.io>, Dave Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1599686801.git.boris@bur.io>
 <2e20e4da6a0df68bc29e85e173f70fcd393df2fa.1599686801.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d83ca181-3da7-9148-8b03-018a8a068e94@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:07:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2e20e4da6a0df68bc29e85e173f70fcd393df2fa.1599686801.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 5:45 PM, Boris Burkov wrote:
> If we are not using space cache v1, we should not create the free space
> object or free space inodes. This comes up when we delete the existing
> free space objects/inodes when migrating to v2, only to see them get
> recreated for every dirtied block group.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
