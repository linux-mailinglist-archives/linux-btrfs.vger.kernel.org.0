Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825027B030
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfG3RgN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 13:36:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:48222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfG3RgN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 13:36:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04005AD45
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 17:36:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0079CDA808; Tue, 30 Jul 2019 19:36:46 +0200 (CEST)
Date:   Tue, 30 Jul 2019 19:36:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 05/17] btrfs-progs: add option for checksum type to
 mkfs
Message-ID: <20190730173646.GH28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <d404e57945240f413ab62945fd1cc4bfc86364ae.1564046971.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d404e57945240f413ab62945fd1cc4bfc86364ae.1564046971.git.jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 11:33:52AM +0200, Johannes Thumshirn wrote:
> Add an option to mkfs to specify which checksum algorithm will be used for
> the filesystem.
> 
> XXX this patch should go last in the series.

If the code update and the mkfs option are split, I can merge the
preparatory part independently. In case you're going to respin the
series, please do 2 patches and sort the preparatory patches to the
beginning of the series.
