Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB28342346F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhJEXZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 19:25:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33422 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbhJEXZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 19:25:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4323522476;
        Tue,  5 Oct 2021 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633476222;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPvvSPWIaO/sRiVaHpaQP4IzMcM4L/Eht8ZgLmrbvGE=;
        b=1od9ni1M9axvOXuB/iAIhYzihqUbBZnj8qNvUxcENwi342zVJbtLmbsqX5KyBz9SJuatAE
        dRiX09AVCJlT94mQlGUC7EV9vQCn3Lebeh1n9VZzrwL8pvC2yA5jY6zj3yVVRYOvYcxoLC
        h17TLM3Xdj1zAEjvvlDkCGN4WqLTtOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633476222;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPvvSPWIaO/sRiVaHpaQP4IzMcM4L/Eht8ZgLmrbvGE=;
        b=6eqJjXvNFybkUNRMn3ysJFA9tzBRFk58hDBM/V7QzaTWToqLhRFIGyJiRD9SJaqFPqGXWe
        RTdH4O18iyQRqWBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 36D4BA3B94;
        Tue,  5 Oct 2021 23:23:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52D4EDA7F3; Wed,  6 Oct 2021 01:23:21 +0200 (CEST)
Date:   Wed, 6 Oct 2021 01:23:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, noreply@ellerman.id.au
Subject: Re: [PATCH -next] btrfs: lzo: Mask instead of divide to fix 32-bit
 build
Message-ID: <20211005232321.GK9286@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Geert Uytterhoeven <geert@linux-m68k.org>, Qu Wenruo <wqu@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, noreply@ellerman.id.au
References: <20211005093406.1241222-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005093406.1241222-1-geert@linux-m68k.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 11:34:06AM +0200, Geert Uytterhoeven wrote:
> On 32-bit builds (e.g. m68k):
> 
>     ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!
> 
> "cur_in - start" is 64-bit, while sectorsize is u32.
> 
> As sectorsize is always a power of two, the 64-by-32 modulo operation
> can be replaced by a much cheaper bitwise AND with "sectorsize - 1".
> 
> Fixes: 0078783c7089fc83 ("btrfs: rework lzo_compress_pages() to make it subpage compatible")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks. Folded to the patch as it's still in the devel queue.
