Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB2331FF56
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 20:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBSTTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 14:19:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:44910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhBSTTI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 14:19:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8721CACCF;
        Fri, 19 Feb 2021 19:18:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0417FDA783; Fri, 19 Feb 2021 20:16:29 +0100 (CET)
Date:   Fri, 19 Feb 2021 20:16:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     chrysn <chrysn@fsfe.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: doc: snapshot -r and -i can be used together
Message-ID: <20210219191629.GK1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, chrysn <chrysn@fsfe.org>,
        linux-btrfs@vger.kernel.org
References: <20200629111500.GA65690@hephaistos.amsuess.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629111500.GA65690@hephaistos.amsuess.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 29, 2020 at 01:15:00PM +0200, chrysn wrote:
> This aligns the man page with the usage output of the tool.
> 
> Signed-off-by: Christian Amsüss <chrysn@fsfe.org>
> ---
> 
> This confused me a bit when I first read the man page (why could a
> read-only snapshot not be assigned to a qgroup), but experimentation and
> looking at --help indicate that the mutual exclusivity of those options
> in the man page was most likely due to an editing error when the option
> was introduced.

Sorry for the delay, the fix is now in devel. Thanks.
