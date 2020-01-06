Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989351316C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 18:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAFR2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 12:28:51 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37422 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFR2v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 12:28:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id 21so40156773qky.4
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 09:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hp17HEbG+TjP85tl1qfhhHQaMdBb53zkUprIQ+9w4iA=;
        b=adz+0kl2YGnbvBdtG5+MJ1oTY+U65nqK3nP+8NM1JmLkbCRdIWHd9E/2DNDrj7JWcg
         dbfL7JAnEMsNT1agmsLAtbZdOj3P5UXn1OR8LTm3P8YdXlv8m8iAkR189XCOSR/ZbDAy
         B0FhXGYVuf535yCOfZRWBwE45AQNyykfpsCyAgHxsPZKYH4nE+gQ21qZW8PM4+jsYT05
         SOD11e8P+o3/c9emF/S81vGrKOprizEC+fWVtjdYO8h/iYfuPwnM1WzmQTNzmkCTIJOX
         CBagt8DOpUuVr61Xc6cbHd06vx4fhMsueISoUDgEpDgPyMkWcqMcqbwDPK2GVlzw6dQ7
         NL1Q==
X-Gm-Message-State: APjAAAWgRUyC0ul81hPajkeIC6LcJ+/cnw2qOfzi6FIpfBgGtqJSlIHY
        l8k/aVvEU24xGQEI6bVAzks=
X-Google-Smtp-Source: APXvYqz8LwPWCn+sQbcLcrHOVPKVDeOHAke0j4q9lpxylCTFjp885j2RTOOSv3LCYjntJ+ICBTi3JQ==
X-Received: by 2002:a37:9ac5:: with SMTP id c188mr82858884qke.374.1578331730069;
        Mon, 06 Jan 2020 09:28:50 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::3:effb])
        by smtp.gmail.com with ESMTPSA id a144sm21324445qkc.30.2020.01.06.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 09:28:49 -0800 (PST)
Date:   Mon, 6 Jan 2020 12:28:47 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: async discard follow up
Message-ID: <20200106172847.GB16428@dennisz-mbp>
References: <cover.1577999991.git.dennis@kernel.org>
 <20200106163001.GM3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106163001.GM3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 05:30:01PM +0100, David Sterba wrote:
> Is it expected to leave the counters in a state where are discardable
> extents but not process after a long period of time? I found
> 
> discard_bitmap_bytes:316833792
> discard_bytes_saved:59390722048
> discard_extent_bytes:26122764288
> discardable_bytes:44863488
> discardable_extents:883
> iops_limit:10
> kbps_limit:0
> max_discard_size:67108864
> 
> there was activity when the number of extents wen from about 2000 to
> that value (833), so this could bea nother instance of the -1 accounting
> bug.

There is no guarantee each invocation of the work item will find
something to discard. This was designed to prevent any edge case from
consuming the cpu.

If free space is added back while a block_group has it's cursor being
moved (unless it's fully free), it will not go back and trim those
extents. So we may leave stuff untrimmed until the next time around.
This is also to prevent a pathological case of just resetting in the
same block_group. Therefore, we may be in a situation where we have
discardable extents, but we aren't actively discarding it. The premise
is some filesystem usage will eventually occur and kick it back onto the
list. This also works because btrfs tries to reuse block groups before
allocating another one.

The -1 case is special because it really has to be we're blowing up the
block_group with something left on the table. Because of the size, I'm
guessing it's bitmap related and I added removal of discardable_* inside
free_bitmap().
