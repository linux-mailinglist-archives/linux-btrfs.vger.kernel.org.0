Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA20182017
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgCKRy0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:54:26 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38718 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgCKRy0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:54:26 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so1291525qva.5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jwM4OBqNu+oeSWlqW1BB7EwhUONyKChBidte6F7vUME=;
        b=gf0V5b0R0BPRUE7PjrwoDYJHtryBRm6Th7FY6+N+FWS+TwerTbOsmAtCUA4dSR6KBM
         zb9QW4Xn0dmuPBz+aYBHwAZCMRI1/wx/lEuCCVjxpVPiuErY7eyv8yovnkr0Opo5580D
         jlYw8OX9EdBW++XEwANtzGFm2jhoHdazpIERyeWz4+2irpxmnFdI8+cRLm/T/VOmZK6u
         NDtz2+dg0ddRqHilqHJYaCQXog5sPvcdL7UY6okm2EZK+I/OpYSfqBeLOIapbTjvqc+l
         SRtf50s29H6voecbu/j0qW2kQvzQXqYb3+nm+uLIQetf9ELkzwAOqp3S/tciCRQfOq4b
         SXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jwM4OBqNu+oeSWlqW1BB7EwhUONyKChBidte6F7vUME=;
        b=gA0xNZ4aUV3tmQz9Bbtv+RmB4ZuEIBMQxjlXki3R+gbFhNQpsM1Oz7W8YMS8h9tfaa
         cLbdiz0Alw27N1w2+xnzXOYBi+0yj9YzQq7dnQH9jKKi7lqoxDwbJBNAL64FwoKLYRpi
         TcO+aI8p3UEm1ia00JvR6seiRcRXumALaqAi8k7WD/rQwkfvVHjj0fWgLYjsw/ZukJiK
         qQXUkRGuNw7LTOds31n/6Wv3ahvoLRaLW7qPS81Q0gChoYo+y77N9gCt0+QTR7RxeZHX
         UBy8hoWq0NPQ3MiOKYxehPNTVpdKkUC34vG6iLHIa86DyrzYe5cb5RdNO94R5occ5JvS
         4lvA==
X-Gm-Message-State: ANhLgQ2feqGM75KW1JpxjepZZIWtld9bLQyf7eurikkcBivTuamLWbGl
        XLfpDPfcT6TdFrx5K7K/61G2AQ==
X-Google-Smtp-Source: ADFU+vvL8GmXqBoY37TR4mmNn07Jjk9/3L5PONgxj9yR9DB+574m7efRb0HHmlq/6cBA33wlqeaJyg==
X-Received: by 2002:ad4:4527:: with SMTP id l7mr3880808qvu.221.1583949263605;
        Wed, 11 Mar 2020 10:54:23 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p6sm1084282qkd.32.2020.03.11.10.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:54:22 -0700 (PDT)
Subject: Re: [PATCH 01/15] btrfs: fix error handling when submitting direct
 I/O bio
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <4481393496a9dfe99c9432193407ebdaa27d0753.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9890a9a6-689e-05b5-cf91-4f2726abf6c9@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:54:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4481393496a9dfe99c9432193407ebdaa27d0753.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> If we submit orig_bio in btrfs_submit_direct_hook(), we never increment
> pending_bios. Then, if btrfs_submit_dio_bio() fails, we decrement
> pending_bios to -1, and we never complete orig_bio. Fix it by
> initializing pending_bios to 1 instead of incrementing later.
> 
> Fixing this exposes another bug: we put orig_bio prematurely and then
> put it again from end_io. Fix it by not putting orig_bio.
> 
> After this change, pending_bios is really more of a reference count, but
> I'll leave that cleanup separate to keep the fix small.
> 
> Fixes: e65e15355429 ("btrfs: fix panic caused by direct IO")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
