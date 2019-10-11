Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEACD4500
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfJKQIZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 12:08:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34396 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfJKQIZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 12:08:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so9379176qke.1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 09:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gDlrtxNNZCau/oXoDlNcEiPgzIFPKDmlb/S4XRQQAyQ=;
        b=VsLZyMjn4cpAbGHWd7JPsAHWMBO9kF6b2DskQgPMx77a59p7686GWJa8w5u3PI+cJz
         EUwER5kD2jyJyUD317eftSITsU+0dNbqKRljiBO+tEFOL+3HFeT1b8bLIPNInSLiJaqs
         tAlwvelHfhz4Q1YIfq0eYBcPWHA4E1sMLasu0St24F7k3SDYYL/qQqYRBtTRjhBHJndn
         uO2CCvTWeuJPJUrGHJ9WmwMo2L44SFCD5VkvY7f6VtzFq/9fPa/NJIlQOI9iJK2IQjt2
         TWjXQnURfjjAgT78ml6noTZcGvlhvEtJyKfaH0E0QWPD/txXxj5SC3Uk70Efp3l8h4C6
         B8Mw==
X-Gm-Message-State: APjAAAXB/SHxAeTm1Ri14z8lCLx8zreELq63u0buVp7xcsNCWoL7Uiww
        ZmtJ7yN2eZsH0YWLNHRuMeQ=
X-Google-Smtp-Source: APXvYqx9PHL7U3kmiTPfA3lc69Y+qnZrsnkE/mOHLGX4AV7puQUNToGqKioEbLjv62gJ7Gyv8Vc48Q==
X-Received: by 2002:ae9:c307:: with SMTP id n7mr16258572qkg.185.1570810104034;
        Fri, 11 Oct 2019 09:08:24 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::2:985b])
        by smtp.gmail.com with ESMTPSA id x12sm5999428qtb.32.2019.10.11.09.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:08:23 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:08:20 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/19] btrfs: keep track of which extents have been
 discarded
Message-ID: <20191011160820.GA29672@dennisz-mbp>
References: <cover.1570479299.git.dennis@kernel.org>
 <cover.1570479299.git.dennis@kernel.org>
 <5875088b5f4ada0ef73f097b238935dd583d5b3e.1570479299.git.dennis@kernel.org>
 <9ef5c546-7615-7970-ee7a-3200636d905e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ef5c546-7615-7970-ee7a-3200636d905e@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 08, 2019 at 03:46:18PM +0300, Nikolay Borisov wrote:
> 
> 
> On 7.10.19 г. 23:17 ч., Dennis Zhou wrote:
> > Async discard will use the free space cache as backing knowledge for
> > which extents to discard. This patch plumbs knowledge about which
> > extents need to be discarded into the free space cache from
> > unpin_extent_range().
> > 
> > An untrimmed extent can merge with everything as this is a new region.
> > Absorbing trimmed extents is a tradeoff to for greater coalescing which
> > makes life better for find_free_extent(). Additionally, it seems the
> > size of a trim isn't as problematic as the trim io itself.
> > 
> > When reading in the free space cache from disk, if sync is set, mark all
> > extents as trimmed. The current code ensures at transaction commit that
> > all free space is trimmed when sync is set, so this reflects that.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> 
> I haven't looked closely into this commit but I already implemented
> something similar in order to speed up trimming by not discarding an
> already discarded region twice. The code was introduced by the following
> series:
> https://lore.kernel.org/linux-btrfs/20190327122418.24027-1-nborisov@suse.com/
> in particular patches 13 to 15 .
> 
> Can you leverage it ? If not then your code should, at some point,
> subsume the old one.
> 

I spent some time reading through that. I believe we're tackling two
separate problems. Correct me if I'm wrong, but your patches are making
subsequent fitrims faster because it's skipping over free regions that
were never allocated by the chunk allocator.

This series is aiming to solve intra-block group trim latency as trim is
handled during transaction commit and consequently also help prevent
retrimming of the free space that is already trimmed.

Thanks,
Dennis
