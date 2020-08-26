Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6006A253163
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgHZOep (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgHZOeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 10:34:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1CBC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:34:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so2055239qkb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D1S9lOEprpUkhqkg6yS1ZJr7NO7kj9NYFQ7JDHUK5qY=;
        b=CTktiYHvkvIbgkUFCQMWQis390buta7LO9iBMervGfE8ZCZcnynp+lcl5IJSVxmHjW
         PeStwybrvIirx6E9dzR9BBViC5wtZJD324ZpU2wID1MZSy2NEMypfG4ERhFoyom7vmSe
         wurCmlcvuQHe8zczDREowpqQ+pDrykND1wn8xPhTs9Nm2gKzrApGZTgBwz3vYz2HDonT
         JTnO45HKlYugljdbmr4p62J6LDG7SFPdxEjDaXkUtjwUYV82JOiHiJaAsjlSTdCX8aZ0
         QD7CzZ32fF5qYiHJvllOWevVZuPcgJUFKFP9GbYH3/c8ArlL3jS3p6GVuiNkNUW3L7f8
         Dqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D1S9lOEprpUkhqkg6yS1ZJr7NO7kj9NYFQ7JDHUK5qY=;
        b=SGJRSfMJ3VASMHoikoRU2vP4p7Z5C+T6NS1y/43RfrRkX4YGUumfoG7Dlg1QcEDOp1
         Qtxreyv6jaQ7D5PamppdG1m5dTF+cDTYM9/QSy+BAnX7ek4Z+S5Q6+aijOqWDesA/LTb
         dwtuJW9T6xhjxuS3Ug4LQQ3oQR3yi/OpzwwK92mh//er3AywSeHtE4u1TdOO/WKHpIci
         XU+ywLrZHOiwv4m4sapMniAQTkKC0qZHMK3JVsrvBaXhv3VV8BXbKhp/mzHQQ+4e/hbU
         sxU7S8pTNk3HXkRYZFGrlDl2lmY3NtGOPIJ1RZnunf852RUrG1rWZjDXw+Cf/V1rb24P
         BGEA==
X-Gm-Message-State: AOAM5326k5Ajub/Jg/CGC8moQ6WbUBF2oVqBGsYjgDzpO++lMVhYjDoZ
        aWd+bBTe0EkCUSpf4r71NcgJM4w9At/8Dsjk
X-Google-Smtp-Source: ABdhPJyjAq2MqNCk2CYe9CsQcIxxDXBFsvzR7MmUINoHP6AvU72wurdQXo6nP+/BsfDBSocSDHhp3w==
X-Received: by 2002:a05:620a:22eb:: with SMTP id p11mr13911705qki.413.1598452469234;
        Wed, 26 Aug 2020 07:34:29 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10f3? ([2620:10d:c091:480::1:efc3])
        by smtp.gmail.com with ESMTPSA id v2sm2108960qte.25.2020.08.26.07.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 07:34:28 -0700 (PDT)
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: add inode transid detect
 and repair support
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200826005233.90063-1-wqu@suse.com>
 <20200826005233.90063-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2df29c40-4b52-4230-7785-dd8c4e5ca6be@toxicpanda.com>
Date:   Wed, 26 Aug 2020 10:34:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826005233.90063-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/25/20 8:52 PM, Qu Wenruo wrote:
> There are quite some reports on kernel rejecting invalid inode
> generation, but it turns out to be that, kernel is just rejecting inode
> transid. It's a bug in kernel error message.
> 
> To solve the problem and make the fs mountable again, add the detect and
> repair support for lowmem mode.
> 
> The implementation is pretty much the same, just re-use the existing
> inode generation detect and repair code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
