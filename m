Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5081DC0CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 23:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgETVCM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 17:02:12 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:35614 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgETVCM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 17:02:12 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2020 17:02:11 EDT
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id D3BEF2A7C086;
        Wed, 20 May 2020 22:53:26 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ro_Qzj3kFEiC; Wed, 20 May 2020 22:53:23 +0200 (CEST)
Received: from latitude (x4dbe0cc2.dyn.telefonica.de [77.190.12.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Wed, 20 May 2020 22:53:23 +0200 (CEST)
Date:   Wed, 20 May 2020 22:53:19 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Justin Engwer <justin@mautobu.com>, linux-btrfs@vger.kernel.org
Subject: Re: I think he's dead, Jim
Message-ID: <20200520205319.GA26435@latitude>
References: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
 <20200520013255.GD10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520013255.GD10769@hungrycats.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020 Mai 19, Zygo Blaxell wrote:
> 
> Corollary:  Never use space_cache=v1 with raid5 or raid6 data.
> space_cache=v1 puts some metadata (free space cache) in data block
> groups, so it violates the "never use raid5 or raid6 for metadata" rule.
> space_cache=v2 eliminates this problem by storing the free space tree
> in metadata block groups.
> 

This should not be a real problem, as the space-cache can be discarded
and rebuild anytime. Or do I miss something?

-- 
Regards,
  Johannes Hirte

