Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57271728D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 20:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgB0Tje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 14:39:34 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34941 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgB0Tje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 14:39:34 -0500
Received: by mail-qv1-f65.google.com with SMTP id u10so180853qvi.2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2020 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8jlvDfBJlYjV/68QKnCLIjqeiNZ5VqwgRbz14+rL1pE=;
        b=sGIBh2Ot37B/MZItwqTkTwi/fytHZ5qPuonhVjO4yC3ay7/q7zkuikDd7OVW+TA+Fj
         QKvBF6ZLcfDTMZaysuzenV9KgmTl4GejIg/B6cEBFeWR+/dnx0U/2gNhI5PUZ/t7ooUs
         6+QEADuQ/RDjTah9LfbP+PBuFXJyKjGJkIaQ9yK+8s37Jjsh//EMs7C3VDIFS3gGfsQ0
         KiBLmyj3WuhpYaSSi7lULqjOVprZ/eO6qVNCZNxBKZQZ8zo28lzN742V9Z4GvLu/l2qM
         ht36mLNszEf+USqHFJcpMnOi9P0oG5bPdTKN1TlD1+R1oOKFMzB8JsTypig8sq3wHIFP
         sM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8jlvDfBJlYjV/68QKnCLIjqeiNZ5VqwgRbz14+rL1pE=;
        b=IJJrPI0eJvdfo5P+VxL8OJaa5SlfZGORblX2LXXkQEqYnEjMBrBLQ1ocAiJ+bAHXC+
         wfHaDSI4YupNhqs0cnk5jfpNoBrNDeV/mYsUI8Vm0IlhOQU+bETjy8AhL3cgjpc5ikgF
         qd6A5rf8/vdrSAdfhAf2IfK0xLpjcFmgR8noVcI/dx6ewOgJkV65q+epfhDQr4/L0LLx
         IlLhWBiPF47OBEzLI2ix6370x9ICq0yFrcu1vXEEWyAsOwwNkB5vghpWUBv+ftN/oXqN
         Z+oSAYAxfET5ltkbvGkfvcdkQr4puCC05DVN2b69wvcETb6gbcsMts6sgQzXapfplLZn
         9MjA==
X-Gm-Message-State: APjAAAUa+6d3AOpB9mGnNJDEb+cHM/30nFAC+k8CMmuXdhPwCx9RPMSn
        fQZoh8x5FzuQw6z4h54+qTyMvEiWuKs=
X-Google-Smtp-Source: APXvYqxCYju4Y8ZpNR7C1KpZBQJyhdNy+1e7YTHLemIDccai7HBiU7/MywQTu9mt2XNejgzEaeJPDw==
X-Received: by 2002:a0c:f952:: with SMTP id i18mr486462qvo.201.1582832371659;
        Thu, 27 Feb 2020 11:39:31 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t6sm3737398qke.57.2020.02.27.11.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 11:39:30 -0800 (PST)
Subject: Re: [PATCH 1/3] btrfs: relocation: Use wrapper to replace open-coded
 edge linking
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200224060200.31323-1-wqu@suse.com>
 <20200224060200.31323-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <feaf6c26-be4c-feed-68c2-02457761e45e@toxicpanda.com>
Date:   Thu, 27 Feb 2020 14:39:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224060200.31323-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/24/20 1:01 AM, Qu Wenruo wrote:
> Since backref_edge is used to connect upper and lower backref nodes, and
> need to access both nodes, some code can look pretty nasty:
> 
> 		list_add_tail(&edge->list[LOWER], &cur->upper);
> 
> The above code will link @cur to the LOWER side of the edge, while both
> "LOWER" and "upper" words show up.
> This can sometimes be very confusing for reader to grasp.
> 
> This patch introduce a new wrapper, link_backref_edge(), to handle the
> linking behavior.
> Which also has extra ASSERT() to ensure caller won't pass wrong nodes
> in.
> 
> Also, this updates the comment of related lists of backref_node and
> backref_edge, to make it more clear that each list points to what.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
