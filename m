Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E519F1F1C7D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgFHP5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 11:57:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbgFHP5y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 11:57:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43522AA7C;
        Mon,  8 Jun 2020 15:57:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70426DA790; Mon,  8 Jun 2020 17:57:47 +0200 (CEST)
Date:   Mon, 8 Jun 2020 17:57:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/46] Trivial BTRFS_I removal
Message-ID: <20200608155746.GC27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200603055546.3889-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 03, 2020 at 08:55:00AM +0300, Nikolay Borisov wrote:
> V2 with purely cosmetic changes in the line length of some patches' changelogs.
> 
> For the cover letter of substance for this series check v1 [0] cover letter.

I'll add the series to misc-next after rc1 so any potential fixes that
we'd like to get in early are not conflicting. Thanks.
