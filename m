Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83550423D8F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhJFMTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 08:19:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36900 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbhJFMTq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 08:19:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ACA82224EA;
        Wed,  6 Oct 2021 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633522673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLXapckpw7zLcqdo118ZMuwzZcG4AddkWBzRnP70HRQ=;
        b=WRfI12Fr/dbd8P1/Rp4jUy4jBrvsrO8yEz2V1EA/2qEP+yQebsvbSvag5MlniKlVqH3JwV
        qOpcEXEH0W6JLdMttGIj7Abq5h+ANUSvlyTQsurYEDKSRNBuXyJE4nW8JkItQNTRC065Yx
        V+8EG+0L5/eluPY22ZjGbXS/Z7rt7A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633522673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLXapckpw7zLcqdo118ZMuwzZcG4AddkWBzRnP70HRQ=;
        b=ivugdcf0MSaD2lKj//hU/1XmE3fWhyz8t+HdGx9N0YZpELZFWo4bD8FYgEHHsYZfcYJaF8
        vPAnwFsWCyoAiKCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6BE68A3B88;
        Wed,  6 Oct 2021 12:17:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1727BDA7F3; Wed,  6 Oct 2021 14:17:33 +0200 (CEST)
Date:   Wed, 6 Oct 2021 14:17:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Kai Song <songkai01@inspur.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: Use kmemdup() to replace kmalloc + memcpy
Message-ID: <20211006121732.GM9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Kai Song <songkai01@inspur.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211003080656.217151-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003080656.217151-1-songkai01@inspur.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 03, 2021 at 04:06:56PM +0800, Kai Song wrote:
> fix memdup.cocci warning:
> fs/btrfs/zoned.c:1198:23-30: WARNING opportunity for kmemdup
> 
> Signed-off-by: Kai Song <songkai01@inspur.com>

Added to misc-next, thanks.
