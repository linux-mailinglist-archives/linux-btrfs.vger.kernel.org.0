Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7CA1230D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfLQPtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:49:12 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37713 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQPtL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:49:11 -0500
Received: by mail-qv1-f67.google.com with SMTP id f16so2146562qvi.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4AwhM4X3IvoSSiTGZld3NdQlFYR22xN5kTIMQAv8EPc=;
        b=XrUUySKKKJBpvZ3XAhoK4VJuXuUUV7YXLwjghJ8AFRO6bzSunl/1EuBmLz1uc8FO7Z
         GIhRDKNrylU5Mkq4f9pmA6bSqaemSwgsrWKc5rHDujOJveC+0rOdm+/Au8Y+CPV4u1cO
         b80rH73fFXwacH0yKWcqSRyW5TjajnR0jNE32Z5OaonOoJ8FfRQ2b/VpfZcjimlvKSVY
         fsiBnHo2NfGdAUkmfir/CLkMM/WrBiV22e++x7HY27XFWUR1PxgDw/agAvXwBiiHR0BK
         rT3zr/lMp5ZZksO/8KkBnz4VmYHlQd/c1+hoPdPE6P9++z1HA94TJYvZ1AL2xo7I4y3t
         fePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4AwhM4X3IvoSSiTGZld3NdQlFYR22xN5kTIMQAv8EPc=;
        b=tlGUdvG57jsa/kt4vbuX3jfK8Hv4N7UUyZRZAT01Z0mU4ll/Cn+bWtH860GEV4yMNN
         SzC3U6gYLdBRsvlvIg3yXfiwYakLtSNO8941pfWplj9mX8VV/5fodvhyNDBqUdPMXBIO
         9Zxs74i7XH+g0Aa3N4Qf67gbyOnQO8WqQupCf1rsBbPnhd1P1BsnFQbLOVefMyIUiSyn
         6wNA4H/4+Aj2ZfI6opPzb1RSKci+8efKbdij1A432TMbEjX12+Du2RMcdbxVwRNHmNY4
         hzJwqihbbzSqnNzk4la/kW4Xr8Arw7FqinVVqaBM1pZpPJ4/RClKgr0kDIm6M7rb8WP4
         W29A==
X-Gm-Message-State: APjAAAWQgeC1FH/rq2YO23jyjg7lbFB3/6ZoCr6MYqEP/aLmgY5+Pd4i
        3RjU2R8f2iKcOM5O8M2RL6egR1Z1BwyWhA==
X-Google-Smtp-Source: APXvYqwp6tQtobLpkiHsak4B7Swx5tpFA+5lgmtVkH9xVf/XuSe3ecs0kVQQZ1aSXXi3ptMUxVkGCA==
X-Received: by 2002:a0c:ed32:: with SMTP id u18mr5372524qvq.2.1576597750413;
        Tue, 17 Dec 2019 07:49:10 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s91sm619429qtd.50.2019.12.17.07.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:49:09 -0800 (PST)
Subject: Re: [PATCH] btrfs: tree-checker: Check leaf chunk item size
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191217105820.20884-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <96888112-822b-83a9-ebde-2f5f76d9b2f2@toxicpanda.com>
Date:   Tue, 17 Dec 2019 10:49:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217105820.20884-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/17/19 5:58 AM, Qu Wenruo wrote:
> Inspired by btrfs-progs github issue #208, where chunk item in chunk
> tree has invalid num_stripes (0).
> 
> Although that can already be catched by current btrfs_check_chunk_valid(),
> that function doesn't really check item size as it needs to handle chunk
> item in super block sys_chunk_array().
> 
> This patch will just add two extra checks for chunk items in chunk tree:
> - Basic chunk item size
>    If the item is smaller than btrfs_chunk (which already contains one
>    stripe), exit right now as reading num_stripes may even go beyond
>    eb boundary.
> 
> - Item size check against num_stripes
>    If item size doesn't match with calculated chunk size, then either the
>    item size or the num_stripes is corrupted. Error out anyway.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
