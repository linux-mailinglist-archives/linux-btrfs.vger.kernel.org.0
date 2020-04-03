Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD10319DD2B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgDCRu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 13:50:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:58464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbgDCRu7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 13:50:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9C6BABEA;
        Fri,  3 Apr 2020 17:50:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 860E4DA727; Fri,  3 Apr 2020 19:50:23 +0200 (CEST)
Date:   Fri, 3 Apr 2020 19:50:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: Introduce expand_command() to inject
 aruguments more accurately
Message-ID: <20200403175023.GK5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200330070232.50146-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330070232.50146-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 30, 2020 at 03:02:32PM +0800, Qu Wenruo wrote:
> +_is_target_command()
> +{
> +	if [[ $1 =~ /btrfs$ ]]; then
> +		return 0
> +	fi
> +	if [[ $1 =~ /mkfs.btrfs$ ]]; then
> +		return 0
> +	fi
> +	if [[ $1 =~ /btrfs-convert$ ]]; then
> +		return 0
> +	fi
> +	return 1

I think we want all commands, so this should also include btrfstune,
btrfs-corrupt-block, btrfs-image, btrfs-select-super, btrfs-find-root.
As the list grew, a shorter form of the checks would be better, like

	[[ $1 =~ /btrfs$ ]] && return 0

I'm testing the changes with a stub instrument script, there are some
failures still.
