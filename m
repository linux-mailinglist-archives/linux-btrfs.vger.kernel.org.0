Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12B24A1A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfFRNHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 09:07:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:43676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfFRNG7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 09:06:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7A12AC66;
        Tue, 18 Jun 2019 13:06:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5740DA871; Tue, 18 Jun 2019 15:07:46 +0200 (CEST)
Date:   Tue, 18 Jun 2019 15:07:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: fix option parsing for -E
Message-ID: <20190618130746.GM19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20190617164548.4776-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617164548.4776-1-kilobyte@angband.pl>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 17, 2019 at 06:45:48PM +0200, Adam Borowski wrote:
> It has a mandatory argument, thus it always crashed.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

Applied, thanks.
