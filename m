Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE34E3B82D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhF3Nbq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 09:31:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhF3Nbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 09:31:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C319B1FE91;
        Wed, 30 Jun 2021 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625059755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lriIkhdxPDw+USiS5+3/IL8BgFkfthUEemdsHp3+2UM=;
        b=mgV2tdAKbz0+gXic2WfhfwoRGHHmbDuQ3vB63uQddxWPqClUs9QmZwOD0UasUmfUkxO81Z
        DrG49LVI7FiJlhUproedE58QXCbgsCWr/mhaDhksDELQUf7WVZPPgD3D8DsswcGC7wettW
        FlJkaKGXJ4jCp1STV87chHMkj/huASw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625059755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lriIkhdxPDw+USiS5+3/IL8BgFkfthUEemdsHp3+2UM=;
        b=QHHc0IPkYvqMxkM+DomHWMXMLo3jxCSktV+A+ddsc0wc5MZHpsT1zPAxUKfOwUc5A/j5I/
        dXwi53VoJoCBq6Aw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BBD99A3B88;
        Wed, 30 Jun 2021 13:29:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF48CDA7A2; Wed, 30 Jun 2021 15:26:45 +0200 (CEST)
Date:   Wed, 30 Jun 2021 15:26:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: remove the GFP_HIGHMEM flag for compression
 code
Message-ID: <20210630132645.GN2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210630093233.238032-1-wqu@suse.com>
 <20210630093233.238032-3-wqu@suse.com>
 <20210630130636.GK2610@twin.jikos.cz>
 <5fb9c721-5aee-bc1b-5d80-6585cfc9cb7e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fb9c721-5aee-bc1b-5d80-6585cfc9cb7e@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 30, 2021 at 09:13:03PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/6/30 下午9:06, David Sterba wrote:
> > On Wed, Jun 30, 2021 at 05:32:31PM +0800, Qu Wenruo wrote:
> >> This allows later decompress functions to get rid of kmap()/kunmap()
> >> pairs.
> >>
> >> And since all other filesystems are getting rid of HIGHMEM, it should
> >> not be a problem for btrfs.
> >>
> >> Although we removed the HIGHMEM allocation, we still keep the
> >> kmap()/kunmap() pairs.
> >> They will be removed when involved functions are refactored later.
> > 
> > Without removing the kmaps it's incomplete so I'll post the series
> > removing it from the compression code at least.
> 
> But kmap()/kunmap() can still work on those pages, right?
> 
> This is just a preparation for the later patches which refactor 
> lzo_decompress_bio() and btrfs_decompress_buf2page().
> 
> Thus I don't think we need to do that in one go.

Either way but please slow down with the patches, you have too many in
flight. We need to get something merged first, the merge window is fine
so far so we can do that. There are preparatory patches and the real
subpage work so there are dependencies, I'd like to avoid unnecessary
conflicts are resends due to refreshes.
