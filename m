Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8087B01F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfG3RdY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 13:33:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbfG3RdY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 13:33:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 956F3AD45;
        Tue, 30 Jul 2019 17:33:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 512ACDA808; Tue, 30 Jul 2019 19:33:57 +0200 (CEST)
Date:   Tue, 30 Jul 2019 19:33:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: fix option parsing for -E
Message-ID: <20190730173357.GG28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20190618130746.GM19057@twin.jikos.cz>
 <20190728064735.15979-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728064735.15979-1-kilobyte@angband.pl>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 28, 2019 at 08:47:36AM +0200, Adam Borowski wrote:
> > On Mon, Jun 17, 2019 at 06:45:48PM +0200, Adam Borowski wrote:
> > > It has a mandatory argument, thus it always crashed.
> >
> > Applied, thanks.
> 
> Seems like this has fallen through the cracks -- could you please re-apply?

Dunno why it got lost, applied again, thanks.
