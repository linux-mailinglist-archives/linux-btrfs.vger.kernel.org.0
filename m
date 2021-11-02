Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481C044343F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 18:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhKBRFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 13:05:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34638 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhKBRFv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 13:05:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CBCE8218F7;
        Tue,  2 Nov 2021 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635872595;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+CprOWZbM38A7u2Tior6A4wR2MnjzdjKYf2jMXk1Dc=;
        b=YT1yafInikKUtqBwbqGH4iGu40d0m7DKMGGrjksG4bJ9H6HOzGvmW36Al8DutTQnBiR+bW
        eB/iDLG2MQGTKQY10jwnVwdtrPLFvuGSJoamkyg3VuopHUj5JN6JuBOC2yvfFZz6IXX9t0
        8fqF0xDKIkE1sQOhVgyIQwR6j09GJLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635872595;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+CprOWZbM38A7u2Tior6A4wR2MnjzdjKYf2jMXk1Dc=;
        b=0mrjXYBYTQZzVUfVLIgT1Zi/k8a4QtvIyDOWUiy4T9QVMuH5HmiNmHAfQGWmMAOe3D0VUT
        lRQN77OGd2d6/uAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C50182C154;
        Tue,  2 Nov 2021 17:03:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E4E9DA7A9; Tue,  2 Nov 2021 18:02:40 +0100 (CET)
Date:   Tue, 2 Nov 2021 18:02:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs-progs: balance: print warn mesg in old command
Message-ID: <20211102170240.GQ20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211031131011.42401-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211031131011.42401-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 31, 2021 at 01:10:11PM +0000, Sidong Yang wrote:
> This patch makes old balance command to print warning message same as
> in start command. It makes do_balance() checks flags that needs to
> print warning message. It works in old command because old command also
> uses do_balance().
> 
> Issue: #411
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2:
>  - Prints warning message in do_balance()

Added to devel and queued for 5.15, thanks.
