Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B714633B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfFNPrq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 11:47:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:57848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfFNPrq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 11:47:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7C96AED0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2019 15:47:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9406DA8D1; Fri, 14 Jun 2019 17:48:34 +0200 (CEST)
Date:   Fri, 14 Jun 2019 17:48:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs-progs: image: Data dump support, restore
 optimization and small fixes
Message-ID: <20190614154834.GA19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190606110611.27176-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606110611.27176-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 06, 2019 at 07:06:02PM +0800, Qu Wenruo wrote:
> This patchset can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/image_data_dump
> Which is based on v5.1 tag.
> 
> This patchset contains the following main features:
> - various small fixes for btrfs-image
>   From indent misalign, SZ_* cleanup to too many core cores causing
>   btrfs-image crash.

I've applied 1-4 to devel for now.
