Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63D1660BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgBTPQc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:16:32 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44991 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgBTPQc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:16:32 -0500
Received: by mail-qt1-f194.google.com with SMTP id j23so3072882qtr.11
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pknUJyJyyl6UPOil8tWgOstfUw0VOmI5UxQdaP5uHNY=;
        b=UVnJMm/rF2rXEfrFgyvPkGJjsFII1kn2jN7U0qou9gkWAgM/RsLsYN7JSjzEpT2F4K
         f+cLoV3fPZJiuv7ZKOopUyEysS9/z5sNL/E3IbSsZ3QyANUG7tBcw3gmX3W0TksCD42Y
         6y9oEVnKrIPFX/HIlZdVlMTSqHVLYNYNTq/MNb3AhZf8PKHIAlAsS5I/Z1FwYKaQaI9k
         /PUwf6G7W962oydbrmrn6DUx3PRrr6hrjCd0PJxpdY1++47dQvc3iHW6+S9BqowWP+SI
         WY15txqS1G2PZF6pIY4QGdsSbSy6SXfm0haZ9YwNsrIZomyYJ+LA8+bMbrwKPf572ZXG
         +KBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pknUJyJyyl6UPOil8tWgOstfUw0VOmI5UxQdaP5uHNY=;
        b=hN5OWIehKyFSJSpFwsumBVZhiCvQrX6IRXUGe+8SbcwNPrc2koAJp22WlQhM2t9ngO
         OdmJh68rNuaYMWrhKNMVasxgtmx4SUDD8k/qgpwCJ53tZ2em9tCf/WcIZNb/6SlBbM4b
         8MMPLvCwt+hLseqTcm7KXG/LwwF/0qv/a7ssHHOJZ0n66bkPQ1P4vNTUYKiexQLckz22
         0LQ4aUt6d6gI309cF/sfI9MrJhcwGdqHiidgfYDGh/qMbRPFv5HvcaOfddJdG1EfOESM
         fe19b/aYZJcq//lj6dca+FdTXXduqKHnfxfIX7tE+2xORI3oOGdVdR6Dz5ea3ERBEoUX
         +g7Q==
X-Gm-Message-State: APjAAAXZx0rYHB+pazqsKXD9H2YcYr0XGnfK3yOmoPZiYDbrjzdG3YSN
        fMMNM1Q9ZixwvZbuTBxb39LQgDxMIdg=
X-Google-Smtp-Source: APXvYqxqOU9hzJpgKufarw3u2D1ZZ2G7lHRUQcN8REFfcrGtV3Z4uo1qoN0HeLTB6k1z6y+OPdQ8pQ==
X-Received: by 2002:ac8:7299:: with SMTP id v25mr27117985qto.128.1582211791163;
        Thu, 20 Feb 2020 07:16:31 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z27sm1856754qtv.11.2020.02.20.07.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:16:30 -0800 (PST)
Subject: Re: [PATCH 3/4] Btrfs: resurrect extent_read_full_page_nolock()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200219140606.1641625-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <db89548c-bb4e-0bb9-57b8-30d1930d8e34@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:16:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219140606.1641625-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/20 9:06 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Commit 7f042a8370a5bb ("Btrfs: remove no longer used function
> extent_read_full_page_nolock()") removed extent_read_full_page_nolock()
> because it was not needed anymore.
> 
> This function was used to read a page while holding the respective range
> locked in the inode's iotree, to avoid deadlocks when using the other
> APIs we have for reading a page (which lock and unlock the range
> themselves).
> 
> Since this type of functionality is needed for the upcoming changes to
> the reflink implementation dealing with cloning of inline extents, bring
> back this function to life.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
