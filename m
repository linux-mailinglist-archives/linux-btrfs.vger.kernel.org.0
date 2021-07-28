Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF73D921B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhG1Pfa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 11:35:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbhG1Pfa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 11:35:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A27FA222D9;
        Wed, 28 Jul 2021 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627486527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3seY2tVOp/88+gjP01clgxSlLmOPHEdbzGYLzOpsx0=;
        b=XHFCff8vnzJDYOeuqxp+uGqilYdnBN8ubU27UpEDxLZ3TUavAoY8/UaIE+rLP2wwPj9R8x
        CsM1Haf4S2d8hneN0fuE1KEqSW61Dg5vcHTm1K/9bxr5dmEDDO65xe7Quryssw31QD5lvd
        wAiYND0mCG5V4hhViMmPJqaDUuYt3DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627486527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3seY2tVOp/88+gjP01clgxSlLmOPHEdbzGYLzOpsx0=;
        b=1DOzc08rB1D5kjACO9b6Zbnq7N900Hs7MpSvf2xyVuIMZh85XhjjGcea6xWiwd7gkwHAbe
        mr4HRf0jqsJ2CODA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 98F01A3B81;
        Wed, 28 Jul 2021 15:35:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A144DA8A7; Wed, 28 Jul 2021 17:32:42 +0200 (CEST)
Date:   Wed, 28 Jul 2021 17:32:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
Message-ID: <20210728153242.GN5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
References: <20210701160039.12518-1-dsterba@suse.com>
 <YN67+nvpQBfiLXzh@infradead.org>
 <20210702110630.GE2610@twin.jikos.cz>
 <YOLD3CJjDgiq+kfR@infradead.org>
 <20210708143412.GC2610@twin.jikos.cz>
 <333c5709-0d10-635e-656f-32263ec7f0a5@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <333c5709-0d10-635e-656f-32263ec7f0a5@embeddedor.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 14, 2021 at 06:37:01PM -0500, Gustavo A. R. Silva wrote:
> Is it OK with you if we proceed to enable -Warray-bounds in linux-next,
> in the meantime?

Yes, I've checked the development queue and there are no warnings from
fs/btrfs/.
