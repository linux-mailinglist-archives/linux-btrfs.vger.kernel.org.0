Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7344558D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 15:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKDOpu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 10:45:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57392 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhKDOpt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 10:45:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6B689218B2;
        Thu,  4 Nov 2021 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636036990;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=APcCLap5/5ONGbiFJRe+mz81xr0yIxpfF5APOy4xPT8=;
        b=IVkJuUAIo60WrqZSTz8Egrl7hhgwudfDxPNTyksHX05wIG84LROu9PFMqpuxX8iF6FVr83
        FWlDXSiy1gcIs5QyufzoGwZ5ZEBjT42KJgwRXNr21F64/bA/V2wKXlgDe5bL5iHV44qb6s
        3gKZ1ZHkpHKdp10pksjPg6FVmBDbAqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636036990;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=APcCLap5/5ONGbiFJRe+mz81xr0yIxpfF5APOy4xPT8=;
        b=MGsxYJIGdyxCli4RR7vHslAIm5k4XscNOBYjpekvTssevDJD2sHrmi8qNadNa//p3SDpEv
        yoEat6UBBlHfm4CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 649072C157;
        Thu,  4 Nov 2021 14:43:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D31FFDA7A9; Thu,  4 Nov 2021 15:42:33 +0100 (CET)
Date:   Thu, 4 Nov 2021 15:42:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix XX_flags_to_str() to always end with
 '\0'
Message-ID: <20211104144233.GX20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org
References: <20211102100316.20256-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102100316.20256-1-wangyugui@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 06:03:16PM +0800, Wang Yugui wrote:
> [BUG]
> We noticed 'btrfs check' output something like
>   leaf 30408704 flags 0x0(P1逅?) backref revision 1
> but we expected
>   leaf 30408704 flags 0x0() backref revision 1
> 
> [CAUSE]
> some XX_flags_to_str() failed to make sure the result string always end
> with '\0' in some case.
> 
> [FIX]
> add 'ret[0] = 0;' at the begining.
> 
> Signed-off-by: Wang Yugui (wangyugui@e16-tech.com)

Added to devel, thanks.
