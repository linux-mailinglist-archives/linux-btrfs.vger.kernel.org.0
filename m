Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888AEA02D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfH1NOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 09:14:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:53594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfH1NOd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 09:14:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AC7FAEFB
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 13:14:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D1F2DA809; Wed, 28 Aug 2019 15:14:55 +0200 (CEST)
Date:   Wed, 28 Aug 2019 15:14:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use percentage for fractions, replace helpers
Message-ID: <20190828131454.GA2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190827182453.3072-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827182453.3072-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 08:24:53PM +0200, David Sterba wrote:
> The div_factor* helpers calculate fraction or percentual fraction.
> There's a nice helper mult_frac that's for general fractions, we'll add
> a local wrapper suited for our purposes and replace all instances of
> div_factor and update naming in fuctions that pass the fractions.
> 
> * div_factor calculates tenths and the numbers need to be adjusted
> * div_factor_fine is direct replacement
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Dropped for now. Does not compile on 32bit and due to 64bit division and
adding 64bit version of mult_frac does not make things significantly
easier. I'll probably do a reduced version that only renames div_factor.
