Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CAD4387C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 17:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfFMPGL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 11:06:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33915 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732417AbfFMOJZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 10:09:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so22698330qtu.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2019 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oUME5bpW/Pr2SfzIJPfU0VV06cSnG0RxvavtUh+MNiE=;
        b=M/EoFGxSABgyBztItve42zjdupYcYzfD66qeOAPLBjvpSgzRq3HwHibHyK/bfTYVEp
         Snv4WKDHMWhtXFgzfNRIFTonBDpjlZsLLMc7vcnU9wP5LDnc/CIYINLuC6ppOlhzSzY5
         ZWucyBOfomZUhxoFgVEij2q2INcKhyqsuO0F4hRvO7iu5rONPKPMTHOya75MQbomTah8
         wugG9whK6bvLQvDOPZ19ijqEfPhbK5NevTijutOMONhj6LXCDCikjy8e+z5pAil5qWGh
         rbacUCGTqim+/+M2vPQhdgQMs5lJtjkZ2RiSQhQb59i7UDGC3ZBzpBNJdPhIml4PbxZi
         n6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUME5bpW/Pr2SfzIJPfU0VV06cSnG0RxvavtUh+MNiE=;
        b=U1V+gEw5SeJZp8PsYHRohcYy2WPPzFvxrDA15vO45YQUcF1C07J3OSjv22YsZeh+R9
         ZXytXBgf6HsIMfnzWFhwuJsr7DO0WkBpn20qJmkI88VbFF5mdo+O1Zc5Xm7mX0qx+6Ql
         hJoGtolta56WPZsVpf2ywLDFrgUXGENE3HKaKsTL8DgalJTweWfiTS+1BQQO/3FnxvaA
         SRJBRo2YxxvUOjRcmxNg5/RMjJDZkXX0qyMTJJijRQd9gMQyS2hE9XnnMneKFwfoXBEb
         rk8zs6iy3/lIdDE3xajvoJTICr5qtSqu4kNDUrtYQIWDtkgG90Z5yIrx4W5VZ/m8nVG8
         Rn1g==
X-Gm-Message-State: APjAAAWo+1HcterceP8Cor1OWu40E8W4zQYd1AlFkBzAH2ioY6EliNkh
        fawBaAZphVQw6m7qmtgnjR11cw==
X-Google-Smtp-Source: APXvYqx4PKvJqRb73kg+itLzxBEy7G8qizukwpBTzsJCknKQ1saPW7YkHzuQiHXLfj0I/50gl4TQCA==
X-Received: by 2002:a0c:b036:: with SMTP id k51mr3868142qvc.103.1560434964503;
        Thu, 13 Jun 2019 07:09:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id m44sm1865189qtm.54.2019.06.13.07.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:09:23 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:09:22 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 08/19] btrfs: make unmirroed BGs readonly only if we have
 at least one writable BG
Message-ID: <20190613140921.a2kmty5p6lzqztej@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-9-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-9-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:14PM +0900, Naohiro Aota wrote:
> If the btrfs volume has mirrored block groups, it unconditionally makes
> un-mirrored block groups read only. When we have mirrored block groups, but
> don't have writable block groups, this will drop all writable block groups.
> So, check if we have at least one writable mirrored block group before
> setting un-mirrored block groups read only.
> 

I don't understand why you want this.  Thanks,

Josef
