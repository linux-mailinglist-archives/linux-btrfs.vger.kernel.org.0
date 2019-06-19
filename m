Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6F4C3BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfFSWeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 18:34:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfFSWeh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 18:34:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13298ACEE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 22:34:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A2200DA897; Thu, 20 Jun 2019 00:35:23 +0200 (CEST)
Date:   Thu, 20 Jun 2019 00:35:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Spring cleaning
Message-ID: <20190619223523.GJ8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190619140440.5550-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619140440.5550-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 05:04:36PM +0300, Nikolay Borisov wrote:
> Just a couple of patches that remove unneeded code. The first one does away 
> with an always true if construct and the rest remove code which has been #if 0
> for quite some time.
> 
> Nikolay Borisov (4):
>   btrfs-progs: Remove redundant if
>   btrfs-progs: Remove commented code
>   btrfs: Remove old send implementation
>   btrfs-progs: check: Remove duplicated and commented functions

1-4 applied, thanks.
