Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471CA45DDDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 16:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356220AbhKYPtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 10:49:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48708 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhKYPrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 10:47:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 80B001FD34;
        Thu, 25 Nov 2021 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637855028;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHnoMUmDMdz0iceuL2QSmO1GFT05Lzs6qtxrifT/lYM=;
        b=SKp/j1h/4CCGwGY+y67xDHTXkfJ68i1spI3ZbyerY9SPxjf7fgF8j3D/pwj21j/W+NP35f
        LDzmBfcuYcx7uzjGZ0EJYzkkmJFZs1D7skQvggvIKeLNm07d1vcFUBVhsYLZjMEMAL05Cn
        ZdXkbtLst8NtiLVqS464Z1O+/SONeaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637855028;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHnoMUmDMdz0iceuL2QSmO1GFT05Lzs6qtxrifT/lYM=;
        b=0RzdZQLKK5F0LzFRPNeL43Q8SdSc1ECQruXmM+CWL58ML1VRLSicihA8A+YD1ua2eYvCTH
        4MbcJgraOvhaTFCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 763CDA3B89;
        Thu, 25 Nov 2021 15:43:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B392DA735; Thu, 25 Nov 2021 16:43:40 +0100 (CET)
Date:   Thu, 25 Nov 2021 16:43:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Support adding a device during paused balance
Message-ID: <20211125154340.GA28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211125091443.762092-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125091443.762092-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 25, 2021 at 11:14:40AM +0200, Nikolay Borisov wrote:
> 
> So here's v3 which takes care of the feedback received in the last round, namely:
> 
>  - Introduced btrfs_exclop_balance which is used to switch the balance state,
>  alongside ASSERTS
>  - Removed unused variable in balance_kthread
> 
> Nikolay Borisov (3):
>   btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
>   btrfs: make device add compatible with paused balance in
>     btrfs_exclop_start_try_lock
>   btrfs: allow device add if balance is paused

With the minor message fixup added to misc-next, thanks.
