Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62F24A447
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfFROpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 10:45:22 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:37835 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFROpV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 10:45:21 -0400
Received: by mail-pf1-f173.google.com with SMTP id 19so7804069pfa.4;
        Tue, 18 Jun 2019 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMnqg5fufjYWb0sSIzXnpqigWMgenHlEvuLuwxRG46k=;
        b=iLxHc4UIhIvPcrQW4JIdi7HnIoh5OFdQzF8YuPTWZ8B43cT8o2Yxqe4KV1bj1XSZMg
         MNOZzh+iuUavxLRbi71HCocW6OKcb5zTCfrglG8n8jxG5ZPD9v5UfoMYB11l3A1rHc0n
         3GLvHrYfiGSTS/VKcs291iR42fPYzfBATJ83TP47ZwHsJhJBNxTMrRi2XLEPd9w3wKdi
         QQSjf53v/hTwVTJNf1EOP5vhfCD1cRc99PaxStAc4al4J+76YCK2R9/VDQmYEST9JE9Y
         1CDbo6TZ3g+zrQIVtIh8KNX3wsfP5+yJ9Zss/wdS+g5CtuAFj2WA0Al5d6U/VOXUzLK6
         P4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMnqg5fufjYWb0sSIzXnpqigWMgenHlEvuLuwxRG46k=;
        b=Go/agy2pVTfU0qkjpedPtm/J1isUv8jasWT7ntG82lnP0WC4YiG/MV+Q2qbVRAf9ls
         akuu51OEPBQiIG3iDY8iev7dT1Ojj3dTbqhOwX3fpR95DW5r8vj7LOJztcff8O2Yh0Yt
         JlyzWm6RraTuXMQc9l2+p+upFOhzYRR4tehhgLfEwNiOivPQLnDxhYg3QDUkImWtmQqN
         KlDI3+gifhkbm3fKbR3Mth/I+hJ1RQZhZcM0RYx0I1UZ6OwlI7sPKyMUmy7oB4th9qE8
         G1RC8ZWpOhPWri0xYUahZMNSWPwBPGyx6H+yhB/XDSxNqDx9PT3ENywxndkgjw3tHHiL
         QKmw==
X-Gm-Message-State: APjAAAWv5gYKJ8jN96HAg6a4lY+9LZZCzXud76xXP6Y/2KABRtsBEZFL
        pAlMhPR8Q09/quO4wE/oyqk=
X-Google-Smtp-Source: APXvYqzIYeLMQNgDRIdCyouue7+qbHrf+jL2uYPgXh4v17+m5Tepc54GRMoO5ApB7u1tpkGQs04mvg==
X-Received: by 2002:a17:90a:a008:: with SMTP id q8mr5640617pjp.114.1560869120930;
        Tue, 18 Jun 2019 07:45:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5159])
        by smtp.gmail.com with ESMTPSA id c133sm16558044pfb.111.2019.06.18.07.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:45:20 -0700 (PDT)
Date:   Tue, 18 Jun 2019 07:45:17 -0700
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.cz, dsterba@suse.com, clm@fb.com,
        josef@toxicpanda.com, axboe@kernel.dk, jack@suse.cz,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCHSET v2 btrfs/for-next] blkcg, btrfs: fix cgroup writeback
 support
Message-ID: <20190618144517.GI657710@devbig004.ftw2.facebook.com>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190618125442.GL19057@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618125442.GL19057@twin.jikos.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, David.

On Tue, Jun 18, 2019 at 02:54:42PM +0200, David Sterba wrote:
> However, as it's rc5, I'm not at all comfortable to add this patchset to
> 5.3 queue, the changes seem to be intrusive and redoing bio submission
> path is something that will affect all workloads. I did quick tests on
> fstests (without cgruops enabled) and this was fine, but that's the
> minimum that must work. Wider range of workloads would be needed, I can
> do that with mmtests, but all of that means that 5.3 is infeasible.

Sure thing.  These aren't urgent in any way.

> So this opens more possibilites regarding the patchset routing. Both
> parts can go separately through their usual trees.

Yeah, that sounds great too.  Let's wait for Jens's review and decide
how to route the patches.

Thanks.

-- 
tejun
