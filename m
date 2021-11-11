Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD744D5CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 12:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhKKLdw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 06:33:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35938 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKKLdv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 06:33:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 929CF1FD4D;
        Thu, 11 Nov 2021 11:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636630261;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjaeloJ9wUcpcsCHeTCyUCqlq95FW12NoRjwY/1QH9A=;
        b=DvQ3AOJxJ3K+t5VuulSugKwF+yIPSFyp4WfroZ/GU3U/0uAZ9DbEoiasrsEd8zJuEptp66
        BtiK+ypyvHw1xtY66qd0oYNCZEncVdkw7g3tYpGKM1PjB5N1vraWVUr/2Hd3Vtk2MlLkTc
        RpmPfAhF05pG0UK6owRugJ4SKrIC4Fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636630261;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjaeloJ9wUcpcsCHeTCyUCqlq95FW12NoRjwY/1QH9A=;
        b=Ipi6RlLHLA/GgM130MD3yBs2vkA2lbmVRajMSsptibMppeSd6tmsjdueveNdFimgsGDEZx
        n0YXlgqVmVbE3RAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E23BA3B87;
        Thu, 11 Nov 2021 11:31:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ECF14DA799; Thu, 11 Nov 2021 12:31:00 +0100 (CET)
Date:   Thu, 11 Nov 2021 12:31:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: make 1-bit bit-fields unsigned int
Message-ID: <20211111113100.GY28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Colin Ian King <colin.i.king@googlemail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211110192008.311901-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110192008.311901-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 07:20:08PM +0000, Colin Ian King wrote:
> The bitfields have_csum and io_error are currently signed which is
> not recommended as the representation is an implementation defined
> behaviour. Fix this by making the bit-fields unsigned ints.
> 
> Fixes: 2c36395430b0 ("btrfs: scrub: remove the anonymous structure from scrub_page")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Added to misc-next, thanks.
